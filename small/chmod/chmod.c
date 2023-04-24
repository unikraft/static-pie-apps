#include <sys/stat.h>
#include <stdio.h>
#include <errno.h>

int main() {
	int rc = chmod("chmod_test_dir", 0700);
	if (rc < 0)
		printf("chmod failed errno=%d\n", errno);
	return 0;
}
