package main

import (
	"fmt"
	"io"
	"log"
	"net"
	"net/http"
	"strings"
)

func main() {
	fmt.Println("start listen port 80")
	err := http.ListenAndServe(":80", http.HandlerFunc(httpHandler))
	if err != nil {
		panic(err)
	}
}

func httpHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("url:",r.RequestURI,";TcpAddr:",r.RemoteAddr)
	switch r.RequestURI {
	case "/","/host": // Deprecated
		if r.Method != http.MethodGet {
			http.NotFound(w, r)
			return
		}
		io.WriteString(w, realIP(r))
	default:
		http.NotFound(w, r)
	}
}

func realIP(r *http.Request) string {
	var ip string
	if ip = strings.TrimSpace(r.Header.Get("X-Forwarded-For")); ip != "" {
		index := strings.IndexByte(ip, ',')
		if index < 0 {
			return ip
		}
		if ip = strings.TrimSpace(ip[:index]); ip != "" {
			return ip
		}
	}
	if ip = strings.TrimSpace(r.Header.Get("X-Real-Ip")); ip != "" {
		return ip
	}
	ip, _, _ = net.SplitHostPort(r.RemoteAddr)
	return ip
}
