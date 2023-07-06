import os
import re
import unicodedata
import streamlit as st
import requests
import uuid

from PIL import Image


API_GATEWAY_URL = os.getenv("API_GATEWAY_URL")
IMAGE_EXTENSIONS = ["png", "jpg", "jpeg"]


class User:
    def __init__(self):
        self.id = ""
        # hasher = Hasher(ip)
        # self.ip = hasher.hash_text()


class Img:
    def __init__(self):
        self.id = ""
        self.uid = ""
        self.file = ""


def is_image(f):
    try:
        img = Image.open(f)
        img.verify()
        return True
    except (IOError, SyntaxError):
        return False


def generate_uuid():
    return str(uuid.uuid4())


def rename_file(name):
    file_name = os.path.splitext(name)[0]
    extension = os.path.splitext(name)[1]

    file_name = ''.join(c for c in unicodedata.normalize('NFD', file_name) if unicodedata.category(c) != 'Mn')
    file_name = re.sub(r'[^a-zA-Z0-9\-]', '-', file_name)

    return file_name + extension


def upload_image(image_path):
    api_gateway_url = f'<A REMPLIR>/<IP_HASHÉE>_<ID_UNIQUE>.jpg'  # TODO

    response = requests.get(api_gateway_url)
    response_json = response.json()
    presigned_url = response_json['presigned_url']
    parameters = response_json['fields']

    with open(image_path, 'rb') as image_file:
        response = requests.put(presigned_url, headers=parameters, data=image_file)
        if response.status_code == 200:
            print('Image upload successful.')
        else:
            print('Image upload failed.')


def main():
    user = User()
    img = Img()

    user.id = generate_uuid()

    st.sidebar.markdown("Upload file")

    st.title("Upload")

    file = st.file_uploader("Select file", type=IMAGE_EXTENSIONS)

    if file is not None:
        if is_image(file):
            st.success("File OK.")

            renamed_file = rename_file(file.name)

            st.write(f"Renamed file : {renamed_file}")

            img.id = generate_uuid()
            img.file = renamed_file
            img.uid = f"{user.id}_{img.id}"

            # upload_image("")  # TODO
        else:
            st.error("File is not a valid image.")

        image = Image.open(file)
        st.image(image)

        st.write(f"id user : {user.id}")
        st.write(f"id img : {img.id}")
        st.write(f"uid img : {img.uid}")


if __name__ == "__main__":
    main()