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
	fmt.Fprintf(w, "Port: %d\n\n", port())
	fmt.Fprintf(w, "Request: %s\n", req.RequestURI)
	fmt.Printf("Request: %s\n", req.RequestURI)
	for _, key := range keys {
		value := req.Header.Get(key)
		fmt.Fprintf(w, "%v: %v\n", key, value)
	}
}

func main() {
	p := port()
	http.HandleFunc("/", headers)
	fmt.Printf("Listening, try http://localhost:%d/\n", p)
	http.ListenAndServe(fmt.Sprintf(":%d", p), nil)
}
