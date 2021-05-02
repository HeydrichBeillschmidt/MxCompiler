	.text
	.file	"inOpt_1.ll"
	.globl	_jud$$YGHH$Z            # -- Begin function _jud$$YGHH$Z
	.p2align	2
	.type	_jud$$YGHH$Z,@function
_jud$$YGHH$Z:                           # @"_jud$$YGHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	mv	a1, zero
	sw	a0, 44(sp)
	sw	a1, 40(sp)
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	lw	a0, 40(sp)
	lui	a1, %hi(n)
	lw	a1, %lo(n)(a1)
	lw	a2, 44(sp)
	div	a1, a1, a2
	sw	a0, 36(sp)
	blt	a0, a1, .LBB0_9
	j	.LBB0_10
.LBB0_2:                                # %for.cond_2
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a0, 32(sp)
	lw	a1, 28(sp)
	lw	a2, 24(sp)
	sw	a0, 20(sp)
	sw	a1, 16(sp)
	blt	a1, a2, .LBB0_5
	j	.LBB0_6
.LBB0_3:                                # %if.then
                                        #   in Loop: Header=BB0_2 Depth=2
	addi	a0, zero, 1
	sw	a0, 12(sp)
	j	.LBB0_4
.LBB0_4:                                # %if.end
                                        #   in Loop: Header=BB0_2 Depth=2
	lw	a0, 12(sp)
	lw	a1, 16(sp)
	addi	a2, a1, 1
	sw	a2, 28(sp)
	sw	a0, 32(sp)
	j	.LBB0_2
.LBB0_5:                                # %for.body
                                        #   in Loop: Header=BB0_2 Depth=2
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a1, 8(sp)
	lw	a2, 16(sp)
	add	a3, a1, a2
	slli	a3, a3, 2
	add	a0, a0, a3
	lw	a3, 0(a0)
	lw	a0, 4(a0)
	lw	a4, 20(sp)
	sw	a4, 12(sp)
	blt	a0, a3, .LBB0_3
	j	.LBB0_4
.LBB0_6:                                # %for.end
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 20(sp)
	andi	a1, a0, 1
	bnez	a1, .LBB0_8
	j	.LBB0_7
.LBB0_7:                                # %if.then_2
	addi	a0, zero, 1
	sw	a0, 4(sp)
	j	.LBB0_11
.LBB0_8:                                # %if.end_2
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 36(sp)
	addi	a1, a0, 1
	sw	a1, 40(sp)
	j	.LBB0_1
.LBB0_9:                                # %for.body_2
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 44(sp)
	addi	a1, a0, -1
	lw	a2, 36(sp)
	mul	a3, a2, a0
	mv	a4, zero
	mv	a5, a4
	sw	a1, 24(sp)
	sw	a3, 8(sp)
	sw	a4, 28(sp)
	sw	a5, 32(sp)
	j	.LBB0_2
.LBB0_10:                               # %for.end_2
	mv	a0, zero
	sw	a0, 4(sp)
	j	.LBB0_11
.LBB0_11:                               # %return
	lw	a0, 4(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	_jud$$YGHH$Z, .Lfunc_end0-_jud$$YGHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	.cfi_offset ra, -4
	addi	a0, zero, 84
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 20
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a1, %hi(a)
	sw	a0, %lo(a)(a1)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	___init__$$YGXXZ, .Lfunc_end1-___init__$$YGXXZ
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
	call	_getInt$$YGHXZ
	lui	a1, %hi(n)
	sw	a0, %lo(n)(a1)
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	lui	a1, %hi(n)
	lw	a1, %lo(n)(a1)
	bge	a0, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lui	a1, %hi(i)
	lw	a2, %lo(i)(a1)
	slli	a2, a2, 2
	add	a0, a0, a2
	sw	a1, 8(sp)
	sw	a0, 4(sp)
	call	_getInt$$YGHXZ
	lw	a1, 4(sp)
	sw	a0, 0(a1)
	lw	a0, 8(sp)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_1
.LBB2_3:                                # %for.end
	lui	a0, %hi(n)
	lw	a0, %lo(n)(a0)
	lui	a1, %hi(i)
	sw	a0, %lo(i)(a1)
	j	.LBB2_4
.LBB2_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	mv	a1, zero
	blt	a1, a0, .LBB2_7
	j	.LBB2_8
.LBB2_5:                                # %if.then
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	j	.LBB2_9
.LBB2_6:                                # %if.end
                                        #   in Loop: Header=BB2_4 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	srli	a2, a1, 31
	add	a1, a1, a2
	srai	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_4
.LBB2_7:                                # %for.body_2
                                        #   in Loop: Header=BB2_4 Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	call	_jud$$YGHH$Z
	mv	a1, zero
	blt	a1, a0, .LBB2_5
	j	.LBB2_6
.LBB2_8:                                # %for.end_2
	j	.LBB2_9
.LBB2_9:                                # %return
	mv	a0, zero
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	a,@object               # @a
	.section	.sbss,"aw",@nobits
	.globl	a
	.p2align	2
a:
	.word	0
	.size	a, 4

	.type	i,@object               # @i
	.globl	i
	.p2align	2
i:
	.word	0                       # 0x0
	.size	i, 4

	.type	n,@object               # @n
	.globl	n
	.p2align	2
n:
	.word	0                       # 0x0
	.size	n, 4

	.section	".note.GNU-stack","",@progbits
