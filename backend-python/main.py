from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/check', methods=['GET'])
def check():
    return "OK", 200

@app.route('/', methods=['GET'])
def get_json():
    data = {
        "Instancia":  "Instancia #2 - API #2",
		"Curso":      "Seminario de Sistemas 1",
		"Seccion":    "Seccion A",
		"Periodo":    "2do Semestre 2024",
		"Estudiante": "Alberto Gabriel Reyes Ning - 201612174"}
    return jsonify(data)

if __name__ == '__main__':
    port = 5000
    print(f"Server is running on port {port}")
    app.run(host='0.0.0.0', port=port)
