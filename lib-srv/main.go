package main

import (
	"flag"
	"log"
	"net/http"
	"os"
)

func main() {
	port := flag.String("p", "8100", "port to serve on")
	directory := flag.String("d", ".", "the directory of static file to host")
	versionOutputFile := flag.String("v", "", "write version to passed argument and exit")
	flag.Parse()

	if *versionOutputFile != "" {
		err := os.WriteFile(*versionOutputFile, []byte("1.0.0"), 0644)
		if err != nil {
			panic(err)
		}

		os.Exit(0)
	}

	http.Handle("/", http.FileServer(http.Dir(*directory)))

	log.Printf("Serving %s on HTTP port: %s\n", *directory, *port)
	log.Fatal(http.ListenAndServe(":"+*port, nil))
}
