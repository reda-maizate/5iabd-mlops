from dataclasses import dataclass
import os
from dotenv import load_dotenv

load_dotenv()


# aws_access_key_id=..., aws_secret_access_key

@dataclass
class AwsCredentials:
    AWS_ACCESS_KEY = os.getenv("AWS_ACCESS_KEY")
    AWS_SECRET_KEY = os.getenv("AWS_SECRET_KEY")


@dataclass
class AwsSqsEnv:
    AWS_REGION = os.getenv("AWS_REGION")
    AWS_SQS_INPUT_QUEUE = os.getenv("AWS_SQS_INPUT_QUEUE")
    AWS_SQS_OUTPUT_QUEUE = os.getenv("AWS_SQS_OUTPUT_QUEUE")

@dataclass
class AwsS3Bucket:
    AWS_BUCKET_NAME = os.getenv("AWS_BUCKET_NAME")
