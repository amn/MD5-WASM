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
		(local $AA i32) (local $BB i32) (local $CC i32) (local $DD i32)
		(local.set $A (i32.load offset=0 (local.get $context)))
		(local.set $B (i32.load offset=4 (local.get $context)))
		(local.set $C (i32.load offset=8 (local.get $context)))
		(local.set $D (i32.load offset=12 (local.get $context)))
		(local.set $end (i32.add (local.get $start) (local.get $n_bytes)))
		(loop $process_block
			(local.set $AA (local.get $A))
			(local.set $BB (local.get $B))
			(local.set $CC (local.get $C))
			(local.set $DD (local.get $D))
			;; Round 1
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=0 (local.get $start)) (i32.const 7) (i32.const 0xd76aa478) (i32.const 0)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=4 (local.get $start)) (i32.const 12) (i32.const 0xe8c7b756) (i32.const 0)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=8 (local.get $start)) (i32.const 17) (i32.const 0x242070db) (i32.const 0)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=12 (local.get $start)) (i32.const 22) (i32.const 0xc1bdceee) (i32.const 0)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=16 (local.get $start)) (i32.const 7) (i32.const 0xf57c0faf) (i32.const 0)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=20 (local.get $start)) (i32.const 12) (i32.const 0x4787c62a) (i32.const 0)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=24 (local.get $start)) (i32.const 17) (i32.const 0xa8304613) (i32.const 0)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=28 (local.get $start)) (i32.const 22) (i32.const 0xfd469501) (i32.const 0)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=32 (local.get $start)) (i32.const 7) (i32.const 0x698098d8) (i32.const 0)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=36 (local.get $start)) (i32.const 12) (i32.const 0x8b44f7af) (i32.const 0)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=40 (local.get $start)) (i32.const 17) (i32.const 0xffff5bb1) (i32.const 0)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=44 (local.get $start)) (i32.const 22) (i32.const 0x895cd7be) (i32.const 0)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=48 (local.get $start)) (i32.const 7) (i32.const 0x6b901122) (i32.const 0)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=52 (local.get $start)) (i32.const 12) (i32.const 0xfd987193) (i32.const 0)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=56 (local.get $start)) (i32.const 17) (i32.const 0xa679438e) (i32.const 0)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=60 (local.get $start)) (i32.const 22) (i32.const 0x49b40821) (i32.const 0)))
			;; Round 2
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=4 (local.get $start)) (i32.const 5) (i32.const 0xf61e2562) (i32.const 1)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=24 (local.get $start)) (i32.const 9) (i32.const 0xc040b340) (i32.const 1)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=44 (local.get $start)) (i32.const 14) (i32.const 0x265e5a51) (i32.const 1)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=0 (local.get $start)) (i32.const 20) (i32.const 0xe9b6c7aa) (i32.const 1)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=20 (local.get $start)) (i32.const 5) (i32.const 0xd62f105d) (i32.const 1)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=40 (local.get $start)) (i32.const 9) (i32.const 0x02441453) (i32.const 1)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=60 (local.get $start)) (i32.const 14) (i32.const 0xd8a1e681) (i32.const 1)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=16 (local.get $start)) (i32.const 20) (i32.const 0xe7d3fbc8) (i32.const 1)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=36 (local.get $start)) (i32.const 5) (i32.const 0x21e1cde6) (i32.const 1)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=56 (local.get $start)) (i32.const 9) (i32.const 0xc33707d6) (i32.const 1)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=12 (local.get $start)) (i32.const 14) (i32.const 0xf4d50d87) (i32.const 1)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=32 (local.get $start)) (i32.const 20) (i32.const 0x455a14ed) (i32.const 1)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=52 (local.get $start)) (i32.const 5) (i32.const 0xa9e3e905) (i32.const 1)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=8 (local.get $start)) (i32.const 9) (i32.const 0xfcefa3f8) (i32.const 1)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=28 (local.get $start)) (i32.const 14) (i32.const 0x676f02d9) (i32.const 1)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=48 (local.get $start)) (i32.const 20) (i32.const 0x8d2a4c8a) (i32.const 1)))
			;; Round 3
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=20 (local.get $start)) (i32.const 4) (i32.const 0xfffa3942) (i32.const 2)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=32 (local.get $start)) (i32.const 11) (i32.const 0x8771f681) (i32.const 2)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=44 (local.get $start)) (i32.const 16) (i32.const 0x6d9d6122) (i32.const 2)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=56 (local.get $start)) (i32.const 23) (i32.const 0xfde5380c) (i32.const 2)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=4 (local.get $start)) (i32.const 4) (i32.const 0xa4beea44) (i32.const 2)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=16 (local.get $start)) (i32.const 11) (i32.const 0x4bdecfa9) (i32.const 2)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=28 (local.get $start)) (i32.const 16) (i32.const 0xf6bb4b60) (i32.const 2)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=40 (local.get $start)) (i32.const 23) (i32.const 0xbebfbc70) (i32.const 2)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=52 (local.get $start)) (i32.const 4) (i32.const 0x289b7ec6) (i32.const 2)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=0 (local.get $start)) (i32.const 11) (i32.const 0xeaa127fa) (i32.const 2)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=12 (local.get $start)) (i32.const 16) (i32.const 0xd4ef3085) (i32.const 2)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=24 (local.get $start)) (i32.const 23) (i32.const 0x04881d05) (i32.const 2)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=36 (local.get $start)) (i32.const 4) (i32.const 0xd9d4d039) (i32.const 2)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=48 (local.get $start)) (i32.const 11) (i32.const 0xe6db99e5) (i32.const 2)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=60 (local.get $start)) (i32.const 16) (i32.const 0x1fa27cf8) (i32.const 2)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=8 (local.get $start)) (i32.const 23) (i32.const 0xc4ac5665) (i32.const 2)))
			;; Round 4
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=0 (local.get $start)) (i32.const 6) (i32.const 0xf4292244) (i32.const 3)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=28 (local.get $start)) (i32.const 10) (i32.const 0x432aff97) (i32.const 3)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=56 (local.get $start)) (i32.const 15) (i32.const 0xab9423a7) (i32.const 3)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=20 (local.get $start)) (i32.const 21) (i32.const 0xfc93a039) (i32.const 3)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=48 (local.get $start)) (i32.const 6) (i32.const 0x655b59c3) (i32.const 3)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=12 (local.get $start)) (i32.const 10) (i32.const 0x8f0ccc92) (i32.const 3)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=40 (local.get $start)) (i32.const 15) (i32.const 0xffeff47d) (i32.const 3)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=4 (local.get $start)) (i32.const 21) (i32.const 0x85845dd1) (i32.const 3)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=32 (local.get $start)) (i32.const 6) (i32.const 0x6fa87e4f) (i32.const 3)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=60 (local.get $start)) (i32.const 10) (i32.const 0xfe2ce6e0) (i32.const 3)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=24 (local.get $start)) (i32.const 15) (i32.const 0xa3014314) (i32.const 3)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=52 (local.get $start)) (i32.const 21) (i32.const 0x4e0811a1) (i32.const 3)))
			(local.set $A (call $R (local.get $A) (local.get $B) (local.get $C) (local.get $D) (i32.load offset=16 (local.get $start)) (i32.const 6) (i32.const 0xf7537e82) (i32.const 3)))
			(local.set $D (call $R (local.get $D) (local.get $A) (local.get $B) (local.get $C) (i32.load offset=44 (local.get $start)) (i32.const 10) (i32.const 0xbd3af235) (i32.const 3)))
			(local.set $C (call $R (local.get $C) (local.get $D) (local.get $A) (local.get $B) (i32.load offset=8 (local.get $start)) (i32.const 15) (i32.const 0x2ad7d2bb) (i32.const 3)))
			(local.set $B (call $R (local.get $B) (local.get $C) (local.get $D) (local.get $A) (i32.load offset=36 (local.get $start)) (i32.const 21) (i32.const 0xeb86d391) (i32.const 3)))
			(local.set $A (i32.add (local.get $A) (local.get $AA)))
			(local.set $B (i32.add (local.get $B) (local.get $BB)))
			(local.set $C (i32.add (local.get $C) (local.get $CC)))
			(local.set $D (i32.add (local.get $D) (local.get $DD)))
			(local.set $start (i32.add (local.get $start) (i32.const 64)))
			(br_if $process_block (i32.ne (local.get $start) (local.get $end))))
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
		(i32.sub (i32.add (local.get $end) (i32.const 8)) (local.get $start)))
	(table 4 funcref)
	(elem (i32.const 0) $F $G $H $I)
	(type $F (func (param $X i32) (param $Y i32) (param $Z i32) (result i32)))
	(func $F (type $F) (param $X i32) (param $Y i32) (param $Z i32) (result i32)
		local.get $X
		local.get $Y
		i32.and
		local.get $X
		i32.const 0xffffffff
		i32.xor
		local.get $Z
		i32.and
		i32.or)
	(func $G (type $F) (param $X i32) (param $Y i32) (param $Z i32) (result i32)
		local.get $X
		local.get $Z
		i32.and
		local.get $Y
		local.get $Z
		i32.const 0xffffffff
		i32.xor
		i32.and
		i32.or)
	(func $H (type $F) (param $X i32) (param $Y i32) (param $Z i32) (result i32)
		local.get $X
		local.get $Y
		i32.xor
		local.get $Z
		i32.xor)
	(func $I (type $F) (param $X i32) (param $Y i32) (param $Z i32) (result i32)
		local.get $Y
		local.get $X
		local.get $Z
		i32.const 0xffffffff
		i32.xor
		i32.or
		i32.xor)
	(func $R (param $a i32) (param $b i32) (param $c i32) (param $d i32) (param $X i32) (param $s i32) (param $T i32) (param $F i32) (result i32)
		local.get $b
		local.get $a
		local.get $b
		local.get $c
		local.get $d
		local.get $F
		call_indirect (type $F)
		i32.add
		local.get $X
		i32.add
		local.get $T
		i32.add
		local.get $s
		i32.rotl
		i32.add))
