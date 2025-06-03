from flask import Flask, request, jsonify
from utils import ocr_to_text
import tempfile
import os

app = Flask(__name__)

@app.route('/ocr', methods=['POST'])
def ocr_endpoint():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']
    with tempfile.NamedTemporaryFile(delete=False, suffix='.pdf') as temp:
        file.save(temp.name)
        temp_path = temp.name

    try:
        OCR_CONFIG = {
            "grayscale": "true",
            "user_defined_dpi": "250",
            "oem": "1",
        }
        numpage_text_bundle = sorted(
            [page for page in ocr_to_text(temp_path, **OCR_CONFIG)],
            key=lambda x: x[1],
        )
        ocr_text = "\n".join([page[0] for page in numpage_text_bundle])
        return jsonify({'text': ocr_text})
    finally:
        os.remove(temp_path)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
