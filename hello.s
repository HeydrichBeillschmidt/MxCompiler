	.text
	.file	"test.ll"
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	j	.LBB0_1
.LBB0_1:                                # %return
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
	sw	a0, 12(sp)
	blt	a0, a1, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %if.then
	lw	a0, 12(sp)
	sw	a0, 8(sp)
	j	.LBB1_3
.LBB1_2:                                # %if.end
	mv	a0, zero
	lw	a1, 12(sp)
	sub	a0, a0, a1
	sw	a0, 8(sp)
	j	.LBB1_3
.LBB1_3:                                # %return
	lw	a0, 8(sp)
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
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_2 Depth 2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 5
	blt	a0, a1, .LBB2_8
	j	.LBB2_10
.LBB2_2:                                # %for.cond_2
                                        #   Parent Loop BB2_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lui	a0, %hi(j)
	lw	a0, %lo(j)(a0)
	addi	a1, zero, 5
	blt	a0, a1, .LBB2_5
	j	.LBB2_7
.LBB2_3:                                # %if.then
                                        #   in Loop: Header=BB2_2 Depth=2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	lui	a1, %hi(r)
	sw	a0, %lo(r)(a1)
	lui	a0, %hi(j)
	lw	a0, %lo(j)(a0)
	lui	a1, %hi(c)
	sw	a0, %lo(c)(a1)
	j	.LBB2_4
.LBB2_4:                                # %if.end
                                        #   in Loop: Header=BB2_2 Depth=2
	j	.LBB2_6
.LBB2_5:                                # %for.body
                                        #   in Loop: Header=BB2_2 Depth=2
	call	_getInt$$YGHXZ
	lui	a1, %hi(n)
	sw	a0, %lo(n)(a1)
	addi	a1, zero, 1
	beq	a0, a1, .LBB2_3
	j	.LBB2_4
.LBB2_6:                                # %for.inc
                                        #   in Loop: Header=BB2_2 Depth=2
	lui	a0, %hi(j)
	lw	a1, %lo(j)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(j)(a0)
	j	.LBB2_2
.LBB2_7:                                # %for.end
                                        #   in Loop: Header=BB2_1 Depth=1
	j	.LBB2_9
.LBB2_8:                                # %for.body_2
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(j)
	mv	a1, zero
	sw	a1, %lo(j)(a0)
	j	.LBB2_2
.LBB2_9:                                # %for.inc_2
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_1
.LBB2_10:                               # %for.end_2
	lui	a0, %hi(r)
	lw	a0, %lo(r)(a0)
	addi	a1, zero, 2
	sub	a0, a1, a0
	sw	a1, 8(sp)
	call	_abs$$YGHH$Z
	lui	a1, %hi(c)
	lw	a1, %lo(c)(a1)
	lw	a2, 8(sp)
	sub	a1, a2, a1
	sw	a0, 4(sp)
	mv	a0, a1
	call	_abs$$YGHH$Z
	lw	a1, 4(sp)
	add	a0, a1, a0
	call	_printInt$$YGXH$Z
	j	.LBB2_11
.LBB2_11:                               # %return
	mv	a0, zero
	lw	ra, 12(sp)
	addi	sp, sp, 16
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
