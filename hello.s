	.text
	.file	"test.ll"
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	ret
.Lfunc_end0:
	.size	___init__$$YGXXZ, .Lfunc_end0-___init__$$YGXXZ
	.cfi_endproc
                                        # -- End function
	.globl	_abs$$YGHH$Z            # -- Begin function _abs$$YGHH$Z
	.p2align	2
	.type	_abs$$YGHH$Z,@function
_abs$$YGHH$Z:                           # @"_abs$$YGHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	addi	a1, zero, 1
	sw	a0, 8(sp)
	blt	a0, a1, .LBB1_2
# %bb.1:                                # %if.then
	lw	a0, 8(sp)
	j	.LBB1_3
.LBB1_2:                                # %if.end
	lw	a0, 8(sp)
	neg	a0, a0
.LBB1_3:                                # %return
	sw	a0, 12(sp)
	lw	a0, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	_abs$$YGHH$Z, .Lfunc_end1-_abs$$YGHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	sw	s0, 40(sp)
	sw	s1, 36(sp)
	sw	s2, 32(sp)
	sw	s3, 28(sp)
	sw	s4, 24(sp)
	sw	s5, 20(sp)
	sw	s6, 16(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	call	___init__$$YGXXZ
	lui	s2, %hi(i)
	addi	a0, s2, %lo(i)
	sw	zero, 0(a0)
	addi	s1, zero, 5
	lui	s0, %hi(j)
	lui	s3, %hi(n)
	addi	s4, zero, 1
	lui	s5, %hi(r)
	lui	s6, %hi(c)
	j	.LBB2_2
.LBB2_1:                                # %for.end
                                        #   in Loop: Header=BB2_2 Depth=1
	lw	a0, %lo(i)(s2)
	addi	a0, a0, 1
	sw	a0, %lo(i)(s2)
.LBB2_2:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_5 Depth 2
	lw	a0, %lo(i)(s2)
	bge	a0, s1, .LBB2_8
# %bb.3:                                # %for.body_2
                                        #   in Loop: Header=BB2_2 Depth=1
	sw	zero, %lo(j)(s0)
	j	.LBB2_5
.LBB2_4:                                # %if.end
                                        #   in Loop: Header=BB2_5 Depth=2
	lw	a0, %lo(j)(s0)
	addi	a0, a0, 1
	sw	a0, %lo(j)(s0)
.LBB2_5:                                # %for.cond_2
                                        #   Parent Loop BB2_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a0, %lo(j)(s0)
	bge	a0, s1, .LBB2_1
# %bb.6:                                # %for.body
                                        #   in Loop: Header=BB2_5 Depth=2
	call	_getInt$$YGHXZ
	sw	a0, %lo(n)(s3)
	bne	a0, s4, .LBB2_4
# %bb.7:                                # %if.then
                                        #   in Loop: Header=BB2_5 Depth=2
	lw	a0, %lo(i)(s2)
	lw	a1, %lo(j)(s0)
	sw	a0, %lo(r)(s5)
	sw	a1, %lo(c)(s6)
	j	.LBB2_4
.LBB2_8:                                # %for.end_2
	lui	a0, %hi(r)
	lw	a0, %lo(r)(a0)
	addi	s1, zero, 2
	sub	a0, s1, a0
	call	_abs$$YGHH$Z
	lui	a1, %hi(c)
	lw	a1, %lo(c)(a1)
	mv	s0, a0
	sub	a0, s1, a1
	call	_abs$$YGHH$Z
	add	a0, s0, a0
	call	_printInt$$YGXH$Z
	sw	zero, 12(sp)
	mv	a0, zero
	lw	s6, 16(sp)
	lw	s5, 20(sp)
	lw	s4, 24(sp)
	lw	s3, 28(sp)
	lw	s2, 32(sp)
	lw	s1, 36(sp)
	lw	s0, 40(sp)
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	r,@object               # @r
	.section	.sbss,"aw",@nobits
	.globl	r
	.p2align	2
r:
	.word	0                       # 0x0
	.size	r, 4

	.type	c,@object               # @c
	.globl	c
	.p2align	2
c:
	.word	0                       # 0x0
	.size	c, 4

	.type	i,@object               # @i
	.globl	i
	.p2align	2
i:
	.word	0                       # 0x0
	.size	i, 4

	.type	j,@object               # @j
	.globl	j
	.p2align	2
j:
	.word	0                       # 0x0
	.size	j, 4

	.type	n,@object               # @n
	.globl	n
	.p2align	2
n:
	.word	0                       # 0x0
	.size	n, 4

	.section	".note.GNU-stack","",@progbits
