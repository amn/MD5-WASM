#define _POSIX_C_SOURCE 200809L

#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/// NOTE: [The MD5 computation procedure in this translation unit] is implemented with RFC1321 as direct and sole reference

/*static uint32_t F(uint32_t X, uint32_t Y, uint32_t Z);
static uint32_t G(uint32_t X, uint32_t Y, uint32_t Z);
static uint32_t H(uint32_t X, uint32_t Y, uint32_t Z);
static uint32_t I(uint32_t X, uint32_t Y, uint32_t Z);*/

struct MD5_context {
	uint32_t A, B, C, D;
	uint64_t n_bits;
};

uint32_t T[64];

struct MD5_context start_context = { .A = 0x67452301, .B = 0xefcdab89, .C = 0x98badcfe, .D = 0x10325476 };

void MD5_update(void * data, int n_bits, struct MD5_context * p_context) {
	assert(n_bits % 512 == 0);
	int N = n_bits / 32; /// amount of [32-bit] words in padded message
	uint32_t * M = data;
	uint32_t A = p_context->A, B = p_context->B, C = p_context->C, D = p_context->D;
	#define F(X, Y, Z) (X & Y | ~X & Z)
	#define G(X, Y, Z) (X & Z | Y & ~Z)
	#define H(X, Y, Z) (X ^ Y ^ Z)
	#define I(X, Y, Z) (Y ^ (X | ~Z))
	for(int i = 0; i < N / 16; i++) {
		uint32_t X[16];
		for(int j = 0; j < 16; j++) {
			X[j] = M[i * 16 + j];
		}
		uint32_t AA = A;
		uint32_t BB = B;
		uint32_t CC = C;
		uint32_t DD = D;
		#define ROTATE_LEFT(x, n) (((x) << (n)) | ((x) >> (sizeof(x) * 8 - (n))))
		#define R1(a, b, c, d, k, s, i) a = b + ROTATE_LEFT(a + F(b, c, d) + X[k] + T[i - 1], s)
		R1(A, B, C, D, 0, 7, 1); R1(D, A, B, C, 1, 12, 2); R1(C, D, A, B, 2, 17, 3); R1(B, C, D, A, 3, 22, 4);
		R1(A, B, C, D, 4, 7, 5); R1(D, A, B, C, 5, 12, 6); R1(C, D, A, B, 6, 17, 7); R1(B, C, D, A, 7, 22, 8);
		R1(A, B, C, D, 8, 7, 9); R1(D, A, B, C, 9, 12, 10); R1(C, D, A, B, 10, 17, 11); R1(B, C, D, A, 11, 22, 12);
		R1(A, B, C, D, 12, 7, 13); R1(D, A, B, C, 13, 12, 14); R1(C, D, A, B, 14, 17, 15); R1(B, C, D, A, 15, 22, 16);
		#define R2(a, b, c, d, k, s, i) a = b + ROTATE_LEFT(a + G(b, c, d) + X[k] + T[i - 1], s)
		R2(A, B, C, D, 1, 5, 17); R2(D, A, B, C, 6, 9, 18); R2(C, D, A, B, 11, 14, 19); R2(B, C, D, A, 0, 20, 20);
		R2(A, B, C, D, 5, 5, 21); R2(D, A, B, C, 10, 9, 22); R2(C, D, A, B, 15, 14, 23); R2(B, C, D, A, 4, 20, 24);
		R2(A, B, C, D, 9, 5, 25); R2(D, A, B, C, 14, 9, 26); R2(C, D, A, B, 3, 14, 27); R2(B, C, D, A, 8, 20, 28);
		R2(A, B, C, D, 13, 5, 29); R2(D, A, B, C, 2, 9, 30); R2(C, D, A, B, 7, 14, 31); R2(B, C, D, A, 12, 20, 32);
		#define R3(a, b, c, d, k, s, i) a = b + ROTATE_LEFT(a + H(b, c, d) + X[k] + T[i - 1], s)
		R3(A, B, C, D, 5, 4, 33); R3(D, A, B, C, 8, 11, 34); R3(C, D, A, B, 11, 16, 35); R3(B, C, D, A, 14, 23, 36);
		R3(A, B, C, D, 1, 4, 37); R3(D, A, B, C, 4, 11, 38); R3(C, D, A, B, 7, 16, 39); R3(B, C, D, A, 10, 23, 40);
		R3(A, B, C, D, 13, 4, 41); R3(D, A, B, C, 0, 11, 42); R3(C, D, A, B, 3, 16, 43); R3(B, C, D, A, 6, 23, 44);
		R3(A, B, C, D, 9, 4, 45); R3(D, A, B, C, 12, 11, 46); R3(C, D, A, B, 15, 16, 47); R3(B, C, D, A, 2, 23, 48);
		#define R4(a, b, c, d, k, s, i) a = b + ROTATE_LEFT(a + I(b, c, d) + X[k] + T[i - 1], s)
		R4(A, B, C, D, 0, 6, 49); R4(D, A, B, C, 7, 10, 50); R4(C, D, A, B, 14, 15, 51); R4(B, C, D, A, 5, 21, 52);
		R4(A, B, C, D, 12, 6, 53); R4(D, A, B, C, 3, 10, 54); R4(C, D, A, B, 10, 15, 55); R4(B, C, D, A, 1, 21, 56);
		R4(A, B, C, D, 8, 6, 57); R4(D, A, B, C, 15, 10, 58); R4(C, D, A, B, 6, 15, 59); R4(B, C, D, A, 13, 21, 60);
		R4(A, B, C, D, 4, 6, 61); R4(D, A, B, C, 11, 10, 62); R4(C, D, A, B, 2, 15, 63); R4(B, C, D, A, 9, 21, 64);
		A += AA;
		B += BB;
		C += CC;
		D += DD;
	}
	p_context->A = A;
	p_context->B = B;
	p_context->C = C;
	p_context->D = D;
	p_context->n_bits += n_bits;
}

void MD5_update_last(void * data, int n_bits, struct MD5_context * p_context) {
	uint8_t * P = (uint8_t *)data + (n_bits / 8);
	int x = n_bits % 8;
	*P &= ~(0xff >> x);
	*P |= 0x80 >> x;
	int z = (512 - (n_bits + 1 + 64) % 512), Z = z / 8;
	memset(P + 1, 0, Z + 8);
	uint64_t n_message_bits = p_context->n_bits + n_bits;
	for(int i = 0; i < sizeof(n_message_bits); i++)
		P[1 + Z + i] = (n_message_bits >> (i * 8)) & 0xff;
	MD5_update(data, n_bits + 1 + z + 64, p_context);
}

/*uint32_t F(uint32_t X, uint32_t Y, uint32_t Z) {
	return X & Y | ~X & Z;
}

uint32_t G(uint32_t X, uint32_t Y, uint32_t Z) {
	return X & Z | Y & ~Z;
}

uint32_t H(uint32_t X, uint32_t Y, uint32_t Z) {
	return X ^ Y ^ Z;
}

uint32_t I(uint32_t X, uint32_t Y, uint32_t Z) {
	return Y ^ (X | ~Z);
}*/

uint32_t T[] = {
	0xd76aa478,
	0xe8c7b756,
	0x242070db,
	0xc1bdceee,
	0xf57c0faf,
	0x4787c62a,
	0xa8304613,
	0xfd469501,
	0x698098d8,
	0x8b44f7af,
	0xffff5bb1,
	0x895cd7be,
	0x6b901122,
	0xfd987193,
	0xa679438e,
	0x49b40821,
	0xf61e2562,
	0xc040b340,
	0x265e5a51,
	0xe9b6c7aa,
	0xd62f105d,
	0x02441453,
	0xd8a1e681,
	0xe7d3fbc8,
	0x21e1cde6,
	0xc33707d6,
	0xf4d50d87,
	0x455a14ed,
	0xa9e3e905,
	0xfcefa3f8,
	0x676f02d9,
	0x8d2a4c8a,
	0xfffa3942,
	0x8771f681,
	0x6d9d6122,
	0xfde5380c,
	0xa4beea44,
	0x4bdecfa9,
	0xf6bb4b60,
	0xbebfbc70,
	0x289b7ec6,
	0xeaa127fa,
	0xd4ef3085,
	0x04881d05,
	0xd9d4d039,
	0xe6db99e5,
	0x1fa27cf8,
	0xc4ac5665,
	0xf4292244,
	0x432aff97,
	0xab9423a7,
	0xfc93a039,
	0x655b59c3,
	0x8f0ccc92,
	0xffeff47d,
	0x85845dd1,
	0x6fa87e4f,
	0xfe2ce6e0,
	0xa3014314,
	0x4e0811a1,
	0xf7537e82,
	0xbd3af235,
	0x2ad7d2bb,
	0xeb86d391
};

void print_context(const struct MD5_context * p_context) {
	uint8_t* context_word_addresses[] = { (uint8_t*)&p_context->A, (uint8_t*)&p_context->B, (uint8_t*)&p_context->C, (uint8_t*)&p_context->D };
	for(int i = 0; i < 4; i++)
		for(int j = 0; j < 4; j++)
			printf("%02x", context_word_addresses[i][j]);
	printf("\n");
}

int main(int argc, char * * argv) {
	const int fd = (argc > 1) ? open(argv[1], O_RDONLY) : STDIN_FILENO;
	if(fd == -1) {
		perror("Error opening input file");
		return -1;
	}
	struct MD5_context context = start_context;
	const int buf_size = 4 * 1024 * 1024;
	assert(buf_size % (512 / 8) == 0);
	void * const buf = malloc(buf_size + 512);
	uint8_t * const p_buf_end = (uint8_t*)buf + buf_size;
	uint8_t * p_read_start = buf;
	for(;;) {
		assert(p_buf_end - p_read_start > 0);
		const int n_bytes_read = read(fd, p_read_start, p_buf_end - p_read_start);
		if(n_bytes_read > 0) {
			p_read_start += n_bytes_read;
			if(p_read_start == p_buf_end) {
				MD5_update(buf, buf_size * 8, &context);
				p_read_start = buf;
			}
		} else if(n_bytes_read == 0) {
			MD5_update_last(buf, (p_read_start - (uint8_t*)buf) * 8, &context);
			break;
		} else {
			perror("Error reading from standard input");
			free(buf);
			return -2;
		}
	}
	print_context(&context);
	return 0;
}
