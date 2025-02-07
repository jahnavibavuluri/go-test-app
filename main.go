package main

import (
    "fmt"
    "net/http"
)

var toolboxes = []string{
    "Signal Processing Toolbox",
    "Optimization Toolbox",
    "Deep Learning Toolbox",
    "Image Acquisition Toolbox",
    "Parallel Computing Toolbox",
    "Computer Vision Toolbox",
    "Instrument Control Toolbox",
    "MATLAB Compiler",
    "MATLAB Compiler SDK",
}

func main() {
    http.HandleFunc("/", toolboxHandler)
    fmt.Println("Server started at http://localhost:8080")
    http.ListenAndServe(":8080", nil)
}

func toolboxHandler(w http.ResponseWriter, r *http.Request) {
    html := "<html><head><title>MATLAB Toolboxes</title></head><body>"
    html += "<h1>List of MATLAB Toolboxes</h1><ul>"

    for _, toolbox := range toolboxes {
	html += fmt.Sprintf("<li>%s</li>", toolbox)
    }

    html += "</ul></body></html>"
    w.Header().Set("Content-Type", "text/html")
    w.WriteHeader(http.StatusOK)
    w.Write([]byte(html))
}
