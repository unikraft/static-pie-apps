#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>
#include <sched.h>

void* f(void* args)
{
	printf("Thread func!\n");
	return NULL;
}

int main()
{
	pthread_t thread;
	struct timespec t;
	t.tv_sec = 5;
	t.tv_nsec = 0;
	int res = pthread_create(&thread, NULL, f, NULL);
	sched_yield();

	//pthread_join(thread, NULL);

	return 0;
}
