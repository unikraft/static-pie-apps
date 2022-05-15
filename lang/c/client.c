/*
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * THIS HEADER MAY NOT BE EXTRACTED OR MODIFIED IN ANY WAY.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <netdb.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>

#define DEFAULT_LISTEN_PORT 3333

/* "shortcut" for struct sockaddr structure */
#define SSA			struct sockaddr

/* error printing macro */
#define ERR(call_description)                           \
	do {                                            \
		fprintf(stderr, "(%s, %d): %s\n",       \
				__FILE__, __LINE__,     \
				call_description);      \
	} while (0)

/* print error (call ERR) and exit */
#define DIE(assertion, call_description)                \
	do {                                            \
		if (assertion) {                        \
			ERR(call_description);          \
			return -1;                      \
		}                                       \
	} while(0)

#define SEC_TO_USEC(s)		((s) * 1000 * 1000)
#define NSEC_TO_USEC(s)		((s) / 1000)

typedef struct timespec TIMETYPE;

static TIMETYPE start_time;
static TIMETYPE stop_time;

static void get_time(TIMETYPE *time_ptr)
{
	if (clock_gettime(CLOCK_REALTIME, time_ptr) < 0) {
		perror("clock_gettime");
		exit(EXIT_FAILURE);
	}
}

static unsigned long us_time(TIMETYPE *time_ptr)
{
	return SEC_TO_USEC(time_ptr->tv_sec) + NSEC_TO_USEC(time_ptr->tv_nsec);
}

static unsigned char buf[8192];

/*
 * Connect to a TCP server identified by name (DNS name or dotted decimal
 * string) and port.
 */

int tcp_connect_to_server(const char *name, unsigned short port)
{
	struct hostent *hent;
	struct sockaddr_in server_addr;
	int s;
	int rc;

	hent = gethostbyname(name);
	DIE(hent == NULL, "gethostbyname");

	s = socket(PF_INET, SOCK_STREAM, 0);
	DIE(s < 0, "socket");

	memset(&server_addr, 0, sizeof(server_addr));
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(port);
	memcpy(&server_addr.sin_addr.s_addr, hent->h_addr,
			sizeof(server_addr.sin_addr.s_addr));

	rc = connect(s, (struct sockaddr *) &server_addr, sizeof(server_addr));
	DIE(rc < 0, "connect");

	return s;
}

int tcp_close_connection(int sockfd)
{
	int rc;

	rc = shutdown(sockfd, SHUT_RDWR);
	DIE(rc < 0, "shutdown");

	return close(sockfd);
}

/*
 * Write bytes_to_write bytes.
 * Only return if the number of bytes written is bytes_to_write or if the
 * connection is closed from the server side.
 */

int write_bytes(int client, size_t bytes_to_write)
{
	size_t written_so_far = 0;
	ssize_t bytes_written;

	while (1) {
		bytes_written = write(client, buf, 8192 - written_so_far);
		if (bytes_written < 0)
			return bytes_written;
		if (bytes_written == 0)
			break;
		written_so_far += bytes_written;
		if (written_so_far >= bytes_to_write)
			break;
	}
	return written_so_far;
}

/*
 * Handle connection to server.
 */

static void handle_connection(int conn)
{
	int rc;
	size_t i, j;

	/* Write 100MB. Repeat 100 times. */
	for (i = 0; i < 100; i++) {
		get_time(&start_time);
		for (j = 0; j < 12800; j++) {
			rc = write_bytes(conn, 8192);
			if (rc < 0) {
				perror("write");
				return;
			}
			if (rc == 0)
				return;
		}
		get_time(&stop_time);
		printf("Duration: %lu us\n", (us_time(&stop_time) - us_time(&start_time)) / 1000);
	}
}

static void usage(const char *argv0)
{
	fprintf(stderr, "Usage: %s server_address server_port\n", argv0);
}

int main(int argc, char **argv)
{
	int conn;

	if (argc != 3) {
		usage(argv[0]);
		exit(EXIT_FAILURE);
	}

	conn = tcp_connect_to_server(argv[1], atoi(argv[2]));
	if (conn < 0)
		exit(EXIT_FAILURE);

	handle_connection(conn);

	tcp_close_connection(conn);

	return 0;
}
