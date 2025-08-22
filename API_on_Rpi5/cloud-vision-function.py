from google.cloud import vision
from google.oauth2 import service_account

def detect_labels(image_path, key_path):
    """
    Erkennt Labels in einem Bild mit der Google Cloud Vision API.

    :param image_path: Pfad zum Bild
    :param key_path: Pfad zur Service-Account-JSON-Datei
    """
    # Credentials direkt aus der Key-Datei laden
    credentials = service_account.Credentials.from_service_account_file(key_path)

    # Vision API Client mit Credentials erstellen
    client = vision.ImageAnnotatorClient(credentials=credentials)

    # Bild einlesen
    with open(image_path, "rb") as image_file:
        content = image_file.read()
    image = vision.Image(content=content)

    # Label-Erkennung durchführen
    response = client.label_detection(image=image)

    # Fehler abfangen
    if response.error.message:
        raise Exception(f"Fehler von API: {response.error.message}")

    labels = response.label_annotations
    print("Erkannte Labels:")
    for label in labels:
        print(f"{label.description} (Score: {label.score:.2f})")

# Beispiel-Aufruf
if __name__ == "__main__":
    image_path = "C:\\Users\\nick\\Programmieren\\bern_hackt\\hackathon_bern\\API_on_Rpi5\\pictures\\spagetti.jpg"
    key_path = "C:\\Users\\nick\\Programmieren\\bern_hackt\\hackathon_bern\\API_on_Rpi5\\service-account.json"
    detect_labels(image_path, key_path)
