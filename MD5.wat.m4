define(`R', `dnl
(local.tee $$1
				(i32.add
					(i32.rotl
						(i32.add
							(i32.add
								(i32.add
									(local.get $$1)
									$8($2,$3,$4))
								(i32.load offset=eval($5 * 4) align=2 (local.get $start)))
							(i32.const $6))
						(i32.const $7))))dnl
')dnl
define(`F', `(i32.xor (local.get $$3) (i32.and (local.get $$1) (i32.xor (local.get $$2) (local.get $$3))))')dnl
define(`G', `(i32.xor (local.get $$2) (i32.and (local.get $$3) (i32.xor (local.get $$1) (local.get $$2))))')dnl
define(`H', `(i32.xor (i32.xor (local.get $$1) (local.get $$2)) (local.get $$3))')dnl
define(`I', `(i32.xor (local.get $$2) (i32.or (local.get $$1) (i32.xor (local.get $$3) (i32.const -1))))')dnl
(module
	(memory (export "memory") 1)
	(func (export "start") (param $context i32) (result i32)
		(i32.store offset=0 (local.get $context) (i32.const 0x67452301))
		(i32.store offset=4 (local.get $context) (i32.const 0xefcdab89))
		(i32.store offset=8 (local.get $context) (i32.const 0x98badcfe))
		(i32.store offset=12 (local.get $context) (i32.const 0x10325476))
		(i64.store offset=16 (local.get $context) (i64.const 0))
		(i32.const 24))
	(func (export "update") (param $start i32) (param $n_bytes i32) (param $context i32)
		(local $end i32)
		(local $A i32) (local $B i32) (local $C i32) (local $D i32)
		(local.set $A (i32.load offset=0 (local.get $context)))
		(local.set $B (i32.load offset=4 (local.get $context)))
		(local.set $C (i32.load offset=8 (local.get $context)))
		(local.set $D (i32.load offset=12 (local.get $context)))
		(local.set $end (i32.add (local.get $start) (local.get $n_bytes)))
		(loop $process_block
			local.get $C
			local.get $D
			local.get $A
			local.get $B
			local.get $B
			R(A, B, C, D, 0, 0xd76aa478, 7, `F')
			R(D, A, B, C, 1, 0xe8c7b756, 12, `F')
			R(C, D, A, B, 2, 0x242070db, 17, `F')
			R(B, C, D, A, 3, 0xc1bdceee, 22, `F')
			R(A, B, C, D, 4, 0xf57c0faf, 7, `F')
			R(D, A, B, C, 5, 0x4787c62a, 12, `F')
			R(C, D, A, B, 6, 0xa8304613, 17, `F')
			R(B, C, D, A, 7, 0xfd469501, 22, `F')
			R(A, B, C, D, 8, 0x698098d8, 7, `F')
			R(D, A, B, C, 9, 0x8b44f7af, 12, `F')
			R(C, D, A, B, 10, 0xffff5bb1, 17, `F')
			R(B, C, D, A, 11, 0x895cd7be, 22, `F')
			R(A, B, C, D, 12, 0x6b901122, 7, `F')
			R(D, A, B, C, 13, 0xfd987193, 12, `F')
			R(C, D, A, B, 14, 0xa679438e, 17, `F')
			R(B, C, D, A, 15, 0x49b40821, 22, `F')
			;; Round 2
			R(A, B, C, D, 1, 0xf61e2562, 5, `G')
			R(D, A, B, C, 6, 0xc040b340, 9, `G')
			R(C, D, A, B, 11, 0x265e5a51, 14, `G')
			R(B, C, D, A, 0, 0xe9b6c7aa, 20, `G')
			R(A, B, C, D, 5, 0xd62f105d, 5, `G')
			R(D, A, B, C, 10, 0x02441453, 9, `G')
			R(C, D, A, B, 15, 0xd8a1e681, 14, `G')
			R(B, C, D, A, 4, 0xe7d3fbc8, 20, `G')
			R(A, B, C, D, 9, 0x21e1cde6, 5, `G')
			R(D, A, B, C, 14, 0xc33707d6, 9, `G')
			R(C, D, A, B, 3, 0xf4d50d87, 14, `G')
			R(B, C, D, A, 8, 0x455a14ed, 20, `G')
			R(A, B, C, D, 13, 0xa9e3e905, 5, `G')
			R(D, A, B, C, 2, 0xfcefa3f8, 9, `G')
			R(C, D, A, B, 7, 0x676f02d9, 14, `G')
			R(B, C, D, A, 12, 0x8d2a4c8a, 20, `G')
			;; Round 3
			R(A, B, C, D, 5, 0xfffa3942, 4, `H')
			R(D, A, B, C, 8, 0x8771f681, 11, `H')
			R(C, D, A, B, 11, 0x6d9d6122, 16, `H')
			R(B, C, D, A, 14, 0xfde5380c, 23, `H')
			R(A, B, C, D, 1, 0xa4beea44, 4, `H')
			R(D, A, B, C, 4, 0x4bdecfa9, 11, `H')
			R(C, D, A, B, 7, 0xf6bb4b60, 16, `H')
			R(B, C, D, A, 10, 0xbebfbc70, 23, `H')
			R(A, B, C, D, 13, 0x289b7ec6, 4, `H')
			R(D, A, B, C, 0, 0xeaa127fa, 11, `H')
			R(C, D, A, B, 3, 0xd4ef3085, 16, `H')
			R(B, C, D, A, 6, 0x04881d05, 23, `H')
			R(A, B, C, D, 9, 0xd9d4d039, 4, `H')
			R(D, A, B, C, 12, 0xe6db99e5, 11, `H')
			R(C, D, A, B, 15, 0x1fa27cf8, 16, `H')
			R(B, C, D, A, 2, 0xc4ac5665, 23, `H')
			;; Round 4
			R(A, B, C, D, 0, 0xf4292244, 6, `I')
			R(D, A, B, C, 7, 0x432aff97, 10, `I')
			R(C, D, A, B, 14, 0xab9423a7, 15, `I')
			R(B, C, D, A, 5, 0xfc93a039, 21, `I')
			R(A, B, C, D, 12, 0x655b59c3, 6, `I')
			R(D, A, B, C, 3, 0x8f0ccc92, 10, `I')
			R(C, D, A, B, 10, 0xffeff47d, 15, `I')
			R(B, C, D, A, 1, 0x85845dd1, 21, `I')
			R(A, B, C, D, 8, 0x6fa87e4f, 6, `I')
			R(D, A, B, C, 15, 0xfe2ce6e0, 10, `I')
			R(C, D, A, B, 6, 0xa3014314, 15, `I')
			R(B, C, D, A, 13, 0x4e0811a1, 21, `I')
			R(A, B, C, D, 4, 0xf7537e82, 6, `I')
			R(D, A, B, C, 11, 0xbd3af235, 10, `I')
			R(C, D, A, B, 2, 0x2ad7d2bb, 15, `I')
			R(B, C, D, A, 9, 0xeb86d391, 21, `I')
			(local.set $B (i32.add))
			(local.set $A (i32.add (local.get $A)))
			(local.set $D (i32.add (local.get $D)))
			(local.set $C (i32.add (local.get $C)))
			(local.set $start (i32.add (local.get $start) (i32.const 64)))
			(br_if 0 (i32.ne (local.get $start) (local.get $end))))
		(i32.store offset=0 (local.get $context) (local.get $A))
		(i32.store offset=4 (local.get $context) (local.get $B))
		(i32.store offset=8 (local.get $context) (local.get $C))
		(i32.store offset=12 (local.get $context) (local.get $D))
		(i64.store offset=16 (local.get $context) (i64.add (i64.load offset=16 (local.get $context)) (i64.extend_i32_u (local.get $n_bytes)))))
	(func (export "pad") (param $start i32) (param $n_bytes i32) (param $context i32) (result i32)
		(local $end i32)
		(local $end_padding i32)
		(local.set $end (i32.add (local.get $start) (local.get $n_bytes)))
		(i32.store (local.get $end) (i32.const 0x80))
		(local.tee $end (i32.add (local.get $end) (i32.const 1)))
		(local.set $end_padding
			(i32.add
				(i32.and
					(i32.sub
						(i32.const 64)
						(i32.and
							(i32.add
								(local.get $n_bytes)
								(i32.const 9))
							(i32.const 63)))
					(i32.const 63))))
		(loop $pad_with_zero
			(if (i32.ne (local.get $end) (local.get $end_padding)) (then
				(i32.store (local.get $end) (i32.const 0))
				(local.set $end (i32.add (local.get $end) (i32.const 1)))
				(br $pad_with_zero))))
		(i64.store (local.get $end) (i64.shl (i64.add (i64.extend_i32_u (local.get $n_bytes)) (i64.load offset=16 (local.get $context))) (i64.const 3)))
		(i32.sub (i32.add (local.get $end) (i32.const 8)) (local.get $start))))
