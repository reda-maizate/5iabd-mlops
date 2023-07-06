from typing import Optional

from transformers import AutoImageProcessor, ResNetForImageClassification
from datasets import load_dataset
import io
import torch
import boto3
import json
from PIL import Image
import numpy as np

from config import AwsCredentials, AwsSqsEnv, AwsS3Bucket

credential = AwsCredentials()
sqs = AwsSqsEnv()
bucket = AwsS3Bucket()

image_data = io.BytesIO()


def service_connection():
    sqs_resource = boto3.resource(
        "sqs",
        aws_access_key_id=credential.AWS_ACCESS_KEY,
        aws_secret_access_key=credential.AWS_SECRET_KEY,
        region_name=sqs.AWS_REGION
    )

    bucket_resource = boto3.resource(
        's3',
        aws_access_key_id=credential.AWS_ACCESS_KEY,
        aws_secret_access_key=credential.AWS_SECRET_KEY
    )

    return sqs_resource, bucket_resource


def get_image(bucket_client, file_name: str) -> None:
    with open(f'./images/{file_name}', 'wb') as image_file:
        bucket_client.download_fileobj(bucket.AWS_BUCKET_NAME, file_name, image_file)


def model_inference(file_name) -> str:

    with open(f"./images/{file_name}", 'rb') as f:
        image_data = f.read()

    image_io = io.BytesIO(image_data)
    image = Image.open(image_io)

    processor = AutoImageProcessor.from_pretrained("microsoft/resnet-50")
    model = ResNetForImageClassification.from_pretrained("microsoft/resnet-50")

    inputs = processor(image, return_tensors="pt")

    with torch.no_grad():
        logits = model(**inputs).logits

    predicted_label = logits.argmax(-1).item()
    return model.config.id2label[predicted_label]


def upload_to_sqs_queue(prediction: str, filename: str) -> None:
    output_queue = sqs_client.get_queue_by_name(QueueName=sqs.AWS_SQS_OUTPUT_QUEUE)
    output_queue.send_message(
        MessageBody=json.dumps({
            "filename": filename,
            "prediction": prediction
        })
    )
    print(f"{filename} = {prediction}")


def parse_message(message) -> Optional[str]:
    payload = json.loads(message.body)

    if payload.get('Event', None) is not None:
        return None

    object_key = payload.get('Records')[0].get('s3').get('object').get('key')
    print(f"Object key: {object_key}")

    message.delete()

    return object_key


if __name__ == '__main__':
    sqs_resource, bucket_resource = service_connection()

    while True:
        try:
            input_queue = sqs_resource.get_queue_by_name(QueueName=sqs.AWS_SQS_INPUT_QUEUE)
            messages = input_queue.receive_messages(MessageAttributeNames=['All'], MaxNumberOfMessages=1, WaitTimeSeconds=5)
            for message in messages:
                image_filename = parse_message(message)
                get_image(bucket_resource, image_filename)
                predictions = model_inference(image_filename)
                upload_to_sqs_queue(predictions)
        except Exception as e:
            print(f"Error in message consuming: {e}")
            continue

