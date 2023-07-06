import hashlib


class Hasher:
    def __init__(self, text):
        self.text = text
        self.hash_method = "SHA256"

    def hash_text(self):
        hash = hashlib.new(self.hash_method)
        hash.update(self.text.encode())

        return hash.hexdigest