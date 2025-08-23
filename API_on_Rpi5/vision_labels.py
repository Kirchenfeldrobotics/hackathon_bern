# import libraries for Google Cloud Vision
from google.cloud import vision
from google.oauth2 import service_account

# analyse image bytes and return labels above threshold
def detect_labels_from_bytes(image_bytes, key_path, threshold=0.5):
    """
    Erkennt Labels in einem Bild (als Bytes) mit der Google Cloud Vision API
    und gibt Labels mit Score >= threshold zurück.

    :param image_bytes: Bilddaten als Bytes
    :param key_path: Pfad zur Service-Account-JSON-Datei
    :param threshold: Mindest-Schwellenwert für die Wahrscheinlichkeit (0.0–1.0)
    :return: Liste mit Labels über dem Schwellenwert
    """
    credentials = service_account.Credentials.from_service_account_file(key_path)
    client = vision.ImageAnnotatorClient(credentials=credentials)

    image = vision.Image(content=image_bytes)
    response = client.label_detection(image=image)

    if response.error.message:
        raise Exception(f"Fehler von API: {response.error.message}")

    return [label.description for label in response.label_annotations if label.score >= threshold]