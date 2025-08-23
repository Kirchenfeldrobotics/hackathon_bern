from google.cloud import vision
from google.oauth2 import service_account

def detect_labels_above_threshold(image_path, key_path, threshold=0.5):
    #bilder mit score >50 werden zurückgegeben, image path und key path müssne noch angegeben werden
    """
    Erkennt Labels in einem Bild mit der Google Cloud Vision API und gibt Labels mit Score > threshold zurück.

    :param image_path: Pfad zum Bild
    :param key_path: Pfad zur Service-Account-JSON-Datei
    :param threshold: Mindest-Schwellenwert für die Wahrscheinlichkeit (0.0–1.0)
    :return: Kommagetrennter String mit Labels über dem Schwellenwert
    """
    credentials = service_account.Credentials.from_service_account_file(key_path)
    client = vision.ImageAnnotatorClient(credentials=credentials)

    with open(image_path, "rb") as image_file:
        content = image_file.read()
    image = vision.Image(content=content)

    response = client.label_detection(image=image)

    if response.error.message:
        raise Exception(f"Fehler von API: {response.error.message}")

    labels = response.label_annotations
    filtered = [label.description for label in labels if label.score >= threshold]

    return ", ".join(filtered)

