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

/*
 * Create a server socket.
 */

static int tcp_create_listener(unsigned short port, int backlog)
{
	struct sockaddr_in address;
	int listenfd;
	int sock_opt;
	int rc;

	listenfd = socket(PF_INET, SOCK_STREAM, 0);
	DIE(listenfd < 0, "socket");

	sock_opt = 1;
	rc = setsockopt(listenfd, SOL_SOCKET, SO_REUSEADDR,
			&sock_opt, sizeof(int));
	DIE(rc < 0, "setsockopt");

	memset(&address, 0, sizeof(address));
	address.sin_family = AF_INET;
	address.sin_port = htons(port);
	address.sin_addr.s_addr = INADDR_ANY;

	rc = bind(listenfd, (SSA *) &address, sizeof(address));
	DIE(rc < 0, "bind");

	rc = listen(listenfd, backlog);
	DIE(rc < 0, "listen");

	return listenfd;
}

#ifndef __unused
#define __unused __attribute__((unused))
#endif

/*
 * Use getpeername(2) to extract remote peer address. Fill buffer with
 * address format IP_address:port (e.g. 192.168.0.1:22).
 */

static int get_peer_address(int sockfd, char *buf, size_t __unused len)
{
	struct sockaddr_in addr;
	socklen_t addrlen = sizeof(struct sockaddr_in);

	if (getpeername(sockfd, (SSA *) &addr, &addrlen) < 0)
		return -1;

	sprintf(buf, "%s:%d", inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));

	return 0;
}

static unsigned char buf[8192];

/*
 * Read bytes_to_read bytes.
 * Only return if the number of bytes read is bytes_to_read or if the
 * connection is closed from the client side.
 */

int read_bytes(int client, size_t bytes_to_read)
{
	size_t read_so_far = 0;
	ssize_t bytes_read;

	while (1) {
		bytes_read = read(client, buf, 8192 - read_so_far);
		if (bytes_read < 0)
			return bytes_read;
		if (bytes_read == 0)
			break;
		read_so_far += bytes_read;
		if (read_so_far >= bytes_to_read)
			break;
	}
	return read_so_far;
}

/*
 * Handle connection from client.
 */

static void handle_connection(int client)
{
	int rc;
	size_t i, j;

	/* Read 100MB. Print duration. Repeat 100 times. */
	for (i = 0; i < 100; i++) {
		for (j = 0; j < 12800; j++) {
			rc = read_bytes(client, 8192);
			if (rc < 0) {
				perror("read");
				return;
			}
			if (rc == 0)
				return;
		}
	}
}

int main(void)
{
	int srv, client;
	unsigned short listen_port = DEFAULT_LISTEN_PORT;
	char addrname[128];

	setvbuf(stdout, NULL, _IONBF, 0);

	srv = tcp_create_listener(listen_port, 1);
	if (srv < 0)
		return -1;

	printf("Listening on port %hu...\n", listen_port);
	while (1) {
		client = accept(srv, NULL, 0);
		DIE(client < 0, "accept");

		get_peer_address(client, addrname, 128);
		printf("Received connection from %s\n", addrname);

		/* Process connection. */
		handle_connection(client);

		/* Close connection */
		printf("Connection closed\n");
		close(client);
	}

	return 0;
}
