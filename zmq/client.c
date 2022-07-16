//  Hello World client
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "zmq.h"

int main(int argc, char **argv)
{
	char url[50];

	if (argc != 2) {
		fprintf(stderr, "Usage: %s <IP_ADDR>\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	printf("Connecting to hello world server...\n");
	void *context = zmq_ctx_new();
	void *requester = zmq_socket(context, ZMQ_REQ);

	sprintf(url, "tcp://%s:5555", argv[1]);

	zmq_connect(requester, url);

	int request_nbr;
	for (request_nbr = 0; request_nbr != 10; request_nbr++) {
		char buffer[10];

		printf("Sending Hello %d...\n", request_nbr);
		zmq_send(requester, "Hello", 5, 0);
		zmq_recv(requester, buffer, 10, 0);
		printf("Received World %d\n", request_nbr);
	}
	zmq_close(requester);
	zmq_ctx_destroy(context);
	return 0;
}
