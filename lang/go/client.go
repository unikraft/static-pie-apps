package main

import (
	"fmt"
	"net"
	"os"
	"time"
)

// Write bytesToWrite bytes.
// Only return if the number of bytes written is bytesToWrite or if the
// connection is closed from the server side.
func writeBytes(conn net.Conn, buf []byte, bytesToWrite int)(err_ret error) {
	writtenSoFar := 0
	var err error
	for {
		reqLen, err := conn.Write(buf[writtenSoFar:])
		if err != nil {
			return err
		}
		writtenSoFar += reqLen
		if writtenSoFar >= bytesToWrite {
			break
		}
	}
	return err
}

func main() {
	if len(os.Args) != 3 {
		println("Usage: " + os.Args[0] + " server_addres server_port")
		os.Exit(1)
	}
	servAddr := os.Args[1] + ":" + os.Args[2]
	tcpAddr, err := net.ResolveTCPAddr("tcp", servAddr)
	if err != nil {
		println("ResolveTCPAddr failed:", err.Error())
		os.Exit(1)
	}

	conn, err := net.DialTCP("tcp", nil, tcpAddr)
	if err != nil {
		println("Dial failed:", err.Error())
		os.Exit(1)
	}

	// Write 10GB. Use 8KB buffer.
	buf := make([]byte, 8192)
	// Store start time.
	start := time.Now()
	for i := 0; i < 100; i++ {
		// 100 MB = 8KB (buffer) * 12800
		for j := 0; j < 12800; j++ {
			err = writeBytes(conn, buf, 8192)
			if err != nil {
				println("Write to server failed:", err.Error())
				os.Exit(1)
			}
		}
	}
	elapsed := time.Since(start)
	start = time.Now()
	fmt.Println("Duration: ", elapsed)

	conn.Close()
}
