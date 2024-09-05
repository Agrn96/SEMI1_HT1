package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/check", checkHandler)
	http.HandleFunc("/", jsonHandler)
	fmt.Println("Server running on port 5000")

	http.ListenAndServe(":5000", nil)
}

func checkHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("OK"))
}

func jsonHandler(w http.ResponseWriter, r *http.Request) {
	data := map[string]string{
		"Instancia":  "Instancia #1 - API #1",
		"Curso":      "Seminario de Sistemas 1",
		"Seccion":    "Seccion A",
		"Periodo":    "2do Semestre 2024",
		"Estudiante": "Alberto Gabriel Reyes Ning - 201612174",
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(data)
}
