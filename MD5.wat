(module
	(memory (export "memory") 1)
	(data (i32.const 0) "\78\a4\6a\d7\56\b7\c7\e8\db\70\20\24\ee\ce\bd\c1\af\0f\7c\f5\2a\c6\87\47\13\46\30\a8\01\95\46\fd\d8\98\80\69\af\f7\44\8b\b1\5b\ff\ff\be\d7\5c\89\22\11\90\6b\93\71\98\fd\8e\43\79\a6\21\08\b4\49\62\25\1e\f6\40\b3\40\c0\51\5a\5e\26\aa\c7\b6\e9\5d\10\2f\d6\53\14\44\02\81\e6\a1\d8\c8\fb\d3\e7\e6\cd\e1\21\d6\07\37\c3\87\0d\d5\f4\ed\14\5a\45\05\e9\e3\a9\f8\a3\ef\fc\d9\02\6f\67\8a\4c\2a\8d\42\39\fa\ff\81\f6\71\87\22\61\9d\6d\0c\38\e5\fd\44\ea\be\a4\a9\cf\de\4b\60\4b\bb\f6\70\bc\bf\be\c6\7e\9b\28\fa\27\a1\ea\85\30\ef\d4\05\1d\88\04\39\d0\d4\d9\e5\99\db\e6\f8\7c\a2\1f\65\56\ac\c4\44\22\29\f4\97\ff\2a\43\a7\23\94\ab\39\a0\93\fc\c3\59\5b\65\92\cc\0c\8f\7d\f4\ef\ff\d1\5d\84\85\4f\7e\a8\6f\e0\e6\2c\fe\14\43\01\a3\a1\11\08\4e\82\7e\53\f7\35\f2\3a\bd\bb\d2\d7\2a\91\d3\86\eb")
	(func $init_module
		(local $i i32) (local $j i32) (local $k i32)
		(local.tee $i (i32.const 256))
		(local.set $j (i32.add (i32.const 64)))
		(loop
			(i32.store offset=0 (local.get $i) (i32.const 7))
			(i32.store offset=4 (local.get $i) (i32.const 12))
			(i32.store offset=8 (local.get $i) (i32.const 17))
			(i32.store offset=12 (local.get $i) (i32.const 22))
			(i32.store offset=64 (local.get $i) (i32.const 5))
			(i32.store offset=68 (local.get $i) (i32.const 9))
			(i32.store offset=72 (local.get $i) (i32.const 14))
			(i32.store offset=76 (local.get $i) (i32.const 20))
			(i32.store offset=128 (local.get $i) (i32.const 4))
			(i32.store offset=132 (local.get $i) (i32.const 11))
			(i32.store offset=136 (local.get $i) (i32.const 16))
			(i32.store offset=140 (local.get $i) (i32.const 23))
			(i32.store offset=192 (local.get $i) (i32.const 6))
			(i32.store offset=196 (local.get $i) (i32.const 10))
			(i32.store offset=200 (local.get $i) (i32.const 15))
			(i32.store offset=204 (local.get $i) (i32.const 21))
			(local.tee $i (i32.add (local.get $i) (i32.const 16)))
			(br_if 0 (i32.ne (local.get $j))))
		(local.set $i (i32.add (local.get $j) (i32.const 192)))
		(loop
			(i32.store (i32.add (local.get $i) (i32.shl (local.get $k) (i32.const 2)))
				(i32.shl (local.get $k) (i32.const 2)))
			(local.tee $k (i32.add (local.get $k) (i32.const 1)))
			(br_if 0 (i32.ne (i32.const 16))))
		(loop
			(i32.store (i32.add (local.get $i) (i32.shl (local.get $k) (i32.const 2)))
				(i32.shl (i32.and (i32.add (i32.mul (local.get $k) (i32.const 5)) (i32.const 1)) (i32.const 15)) (i32.const 2)))
			(local.tee $k (i32.add (local.get $k) (i32.const 1)))
			(br_if 0 (i32.ne (i32.const 32))))
		(loop
			(i32.store (i32.add (local.get $i) (i32.shl (local.get $k) (i32.const 2)))
				(i32.shl (i32.and (i32.add (i32.mul (local.get $k) (i32.const 3)) (i32.const 5)) (i32.const 15)) (i32.const 2)))
			(local.tee $k (i32.add (local.get $k) (i32.const 1)))
			(br_if 0 (i32.ne (i32.const 48))))
		(loop
			(i32.store (i32.add (local.get $i) (i32.shl (local.get $k) (i32.const 2)))
				(i32.shl (i32.and (i32.mul (local.get $k) (i32.const 7)) (i32.const 15)) (i32.const 2)))
			(local.tee $k (i32.add (local.get $k) (i32.const 1)))
			(br_if 0 (i32.ne (i32.const 64)))))
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
		(local $i i32)
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
			(local.set $i (i32.const 0))
			(loop $process_round_1
				(i32.add
					(local.get $B)
					(i32.rotl
						(i32.add
							(i32.add
								(i32.add
									(local.get $A)
									(i32.or
										(i32.and (local.get $B) (local.get $C))
										(i32.and (i32.xor (local.get $B) (i32.const -1)) (local.get $D))))
								(i32.load (i32.add (local.get $start) (i32.load offset=512 (local.get $i)))))
							(i32.load offset=0 (local.get $i)))
						(i32.load offset=256 (local.get $i))))
				(local.set $A (local.get $D))
				(local.set $D (local.get $C))
				(local.set $C (local.get $B))
				local.set $B
				(local.tee $i (i32.add (local.get $i) (i32.const 4)))
				(br_if 0 (i32.ne (i32.const 64))))
			(loop $process_round_2
				(i32.add
					(local.get $B)
					(i32.rotl
						(i32.add
							(i32.add
								(i32.add
									(local.get $A)
									(i32.or
										(i32.and (local.get $B) (local.get $D))
										(i32.and (local.get $C) (i32.xor (local.get $D) (i32.const -1)))))
								(i32.load (i32.add (local.get $start) (i32.load offset=512 (local.get $i)))))
							(i32.load offset=0 (local.get $i)))
						(i32.load offset=256 (local.get $i))))
				(local.set $A (local.get $D))
				(local.set $D (local.get $C))
				(local.set $C (local.get $B))
				local.set $B
				(local.tee $i (i32.add (local.get $i) (i32.const 4)))
				(br_if 0 (i32.ne (i32.const 128))))
			(loop $process_round_3
				(i32.add
					(local.get $B)
					(i32.rotl
						(i32.add
							(i32.add
								(i32.add
									(local.get $A)
									(i32.xor
										(i32.xor (local.get $B) (local.get $C))
										(local.get $D)))
								(i32.load (i32.add (local.get $start) (i32.load offset=512 (local.get $i)))))
							(i32.load offset=0 (local.get $i)))
						(i32.load offset=256 (local.get $i))))
				(local.set $A (local.get $D))
				(local.set $D (local.get $C))
				(local.set $C (local.get $B))
				local.set $B
				(local.tee $i (i32.add (local.get $i) (i32.const 4)))
				(br_if 0 (i32.ne (i32.const 192))))
			(loop $process_round_4
				(i32.add
					(local.get $B)
					(i32.rotl
						(i32.add
							(i32.add
								(i32.add
									(local.get $A)
									(i32.xor
										(local.get $C)
										(i32.or (local.get $B) (i32.xor (local.get $D) (i32.const -1)))))
								(i32.load (i32.add (local.get $start) (i32.load offset=512 (local.get $i)))))
							(i32.load offset=0 (local.get $i)))
						(i32.load offset=256 (local.get $i))))
				(local.set $A (local.get $D))
				(local.set $D (local.get $C))
				(local.set $C (local.get $B))
				local.set $B
				(local.tee $i (i32.add (local.get $i) (i32.const 4)))
				(br_if 0 (i32.ne (i32.const 256))))
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
				(i32.sub
					(i32.const 64)
					(i32.and
						(i32.add
							(local.get $n_bytes)
							(i32.const 9))
						(i32.const 63)))))
		(loop $pad_with_zero
			(if (i32.ne (local.get $end) (local.get $end_padding)) (then
				(i32.store (local.get $end) (i32.const 0))
				(local.set $end (i32.add (local.get $end) (i32.const 1)))
				(br $pad_with_zero))))
		(i64.store (local.get $end) (i64.shl (i64.add (i64.extend_i32_u (local.get $n_bytes)) (i64.load offset=16 (local.get $context))) (i64.const 3)))
		(i32.sub (i32.add (local.get $end) (i32.const 8)) (local.get $start)))
	(start $init_module))
