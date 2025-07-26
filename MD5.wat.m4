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
		(;
			Initialize an [MD5] computation context.

			You MUST call this procedure exactly once before a series of related `update` calls for progressively digesting a body of data (e.g. a file), otherwise the behaviour of `update` and thus the ultimate [MD5] signature stored in the computation context, are undefined. If you're familiar with Python's built-in `hashlib` module analog for digesting data, you can think of calling `start` as equivalent to constructing a hash object (for calling the `update` method on, among other things) with `hashlib.new` or `hashlib.md5`, both of which essentially return an object that encapsulates a digest computation context.

			A computation context is used for computing an MD5 signature iteratively for an arbitrarily large body of data, through a series of calls to the `update` procedure, piecemeal (chunk by chunk, if you will). This means that one single WASM instance may safely be used for computing signatures in parallel, for distinct unrelated bodies of data -- each body using its own computation context. The computation context is encoded as a tightly-packed structure consisting of initial ("seed") values for variables A, B, C, and D that comprise the 128-bit MD5 signature (updated with every call to `update`), and the number of bytes (octets) so-far digested as part of the computation context.

			@param context The pointer to (offset in [default] memory) where this procedure initializes with contents of the computation context structure
			@result The number of octets that the context structure spans (i.e. its size); this is for portability so that clients don't have to generally assume a magic size number
		;)
		(i32.store offset=0 (local.get $context) (i32.const 0x67452301))
		(i32.store offset=4 (local.get $context) (i32.const 0xefcdab89))
		(i32.store offset=8 (local.get $context) (i32.const 0x98badcfe))
		(i32.store offset=12 (local.get $context) (i32.const 0x10325476))
		(i64.store offset=16 (local.get $context) (i64.const 0))
		(i32.const 24))
	(func (export "update") (param $start i32) (param $n_bytes i32) (param $context i32)
		(;
			Update the signature stored in a computation context (see `start`) from a given block of data.

			This procedure implements iterative / "streaming" digesting of a body of data (conventionally a "file") for a single piece of the latter. Calling this procedure on subsequent (necessarily adjacent) pieces of the body of data, once per piece or chunk as these are called, updates the signature stored in the computation context structure. As per the MD5 algorithm, after the final `update` call -- one for the last chunk of the body of data -- the [MD5] signature will have been available in the computation context structure, as-is (all 128 bits of it). See also `pad` which patches (pads) the last chunk and returns amended chunk length, all per the MD5 algorithm.

			@param start The pointer to (offset in [default] memory) where the block of data starts
			@param n_bytes Number of bytes (octets) that comprise the block of data; the value MUST be a multiple of 64 [bytes], otherwise the behaviour of the procedure is undefined
			@param context The pointer to (offset in [default] memory) the computation context structure (see `start`)
		;)
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
		(;
			Patch a "final" chunk of a given body of data being digested.

			MUST be called exactly once for a body of data, specifically for the "final" chunk _and_ returning the size of the resulting padded chunk, `update` MUST be called with the resulting size too, regardless of whether there is actually any number of bytes comprising the final chunk or not. So for the final chunk that is zero bytes (necessarily because the body of data to be digested was in fact of a size that was multiple of 64) you'd still call this procedure as `pad(start, 0, context)`, as part of e.g. `update(start, pad(start, 0, context), context)`. For a final chunk whose size isn't 0, substitute 0 with the chunk size -- the requirement still applies.

			As per the MD5 algorithm, the "end" portion of data _as fed_ to the MD5 "digesting" machine (`update` in this implementation), must also be of size that is a multiple of 64 bytes, which is what this procedure essentially helps ensure with padding mandated explicitly by the algorithm.

			Keep in mind that although the procedure is perhaps "innocuously" called `pad`, it does _patch_ the range of memory at the end of the chunk (as passed) to comply with the MD5 algorithm. As such the procedure could have been called `patch` but then the rather clear "padding" part of the algorithm wouldn't have been expressed as well, hence the former name at the cost of the somewhat hidden "patching" portion of it.

			@param start See the corresponding parameter for `update`; in this context this is correspondingly offset of / pointer to the final chunk
			@param n_bytes See the corresponding parameter for `update`; in this context, the value is the "original" size of the final chunk -- obvously, since it is this procedure that "pads" the chunk and returns the padded size
			@param context See the corresponding parameter to `start` and `update`
			@result The padded chunk size fit for passing to one final call to `update` after which the MD5 signature is available in the context structure
		;)
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
