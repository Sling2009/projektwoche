package main

import (
	"fmt"
	"net/http"
	"os"
	"sort"
	"strconv"

	"golang.org/x/exp/maps"
)

// Variable, die per ldflags gesetzt wird
var appVersion string

func environment() string {
	env := os.Getenv("ENVIRONMENT")
	if env == "" {
		return "Docker Lokal"
	}
	return env
}

func port() int {
	portStr := os.Getenv("PORT")
	if portStr == "" {
		return 8080
	}
	p, err := strconv.Atoi(portStr)
	if err != nil {
		fmt.Printf("Ungültiger Port '%s', nehme Default 8080\n", portStr)
		return 8080
	}
	return p
}

func headers(w http.ResponseWriter, req *http.Request) {
	keys := maps.Keys(req.Header)
	sort.Strings(keys)
	fmt.Fprintf(w, "Workshop Docker & Kubernetes am 11.06.2025 - 12.06.2025\n\n")
	fmt.Fprintf(w, "App-Version: %s\n", appVersion)
	fmt.Fprintf(w, "Environment: %s\n", environment())
	fmt.Fprintf(w, "Port: %d\n\n", port())
	fmt.Fprintf(w, "Request: %s\n\n", req.RequestURI)
	fmt.Printf("Request: %s\n", req.RequestURI)
	for _, key := range keys {
		value := req.Header.Get(key)
		fmt.Fprintf(w, "%v: %v\n", key, value)
	}

	// Secret-Env auslesen
	secretVal := os.Getenv("MY_SECRET_KEY")
	if secretVal != "p@ss:geheim" {
		fmt.Fprintf(w, "\n--- Verschlüsselter Bereich ---\n")
		fmt.Fprintf(w, "Secret: %s\n", secretVal)
	} else {
		fmt.Fprintf(w, "\n--- Verschlüsselter Bereich nicht verfügbar (Secret fehlt) ---\n")
	}
}

func main() {
	env := environment()
	fmt.Printf("App Version: %s\n", appVersion)    // Ausgabe der Version beim Start
	fmt.Printf("Environment: %s\n", env)            // ENV Variable ausgeben
	p := port()
	fmt.Printf("Listening, try http://localhost:%d/\n", p)
	http.HandleFunc("/", headers)
	err := http.ListenAndServe(fmt.Sprintf(":%d", p), nil)
	if err != nil {
		fmt.Printf("Fehler beim Starten des Servers: %v\n", err)
	}
}
