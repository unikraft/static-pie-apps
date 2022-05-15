package main

import (
	"fmt"
	"net"
	"os"
)

const (
	CONN_HOST = "localhost"
	CONN_PORT = "3333"
	CONN_TYPE = "tcp"
)

func main() {
	// Listen for incoming connections.
	//l, err := net.Listen(CONN_TYPE, CONN_HOST+":"+CONN_PORT)
	l, err := net.Listen(CONN_TYPE, ":" + CONN_PORT)
	if err != nil {
		fmt.Println("Error listening:", err.Error())
		os.Exit(1)
	}
	// Close the listener when the application closes.
	defer l.Close()
	fmt.Println("Listening on " + CONN_HOST + ":" + CONN_PORT)
	for {
		// Listen for an incoming connection.
		conn, err := l.Accept()
		if err != nil {
			fmt.Println("Error accepting: ", err.Error())
			os.Exit(1)
		}
		// Handle connections in a new goroutine.
		go handleRequest(conn)
	}
}

// Read bytesToRead bytes.
// Only return if the number of bytes read is bytesToRead or if the
// connection is closed from the client side.
func readBytes(conn net.Conn, buf []byte, bytesToRead int)(err_ret error) {
	readSoFar := 0
	var err error
	for {
		reqLen, err := conn.Read(buf[readSoFar:])
		if err != nil {
			return err
		}
		readSoFar += reqLen
		if readSoFar >= bytesToRead {
			break
		}
	}
	return err
}

// Handles incoming requests.
func handleRequest(conn net.Conn) {
	// Make a buffer to hold incoming data.
	buf := make([]byte, 8192)
	// Read 100MB. Print time. Repeat 100 times.
	for i := 0; i < 100; i++ {
		// 100 MB = 8KB (buffer) * 12800
		for j := 0; j < 12800; j++ {
			// Read the incoming connection into the buffer.
			err := readBytes(conn, buf, 8192)
			if err != nil {
				println("Read failed:", err.Error())
				conn.Close()
				return
			}
		}
	}
	// Close the connection when you're done with it.
	conn.Close()
	fmt.Println("closed")
}
