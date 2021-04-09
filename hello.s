	.text
	.file	"test.ll"
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
	addi	a0, zero, 20
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 4
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a1, %hi(a)
	sw	a0, %lo(a)(a1)
	addi	a0, zero, 24
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 5
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a1, %hi(b)
	sw	a0, %lo(b)(a1)
	j	.LBB0_1
.LBB0_1:                                # %return
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	___init__$$YGXXZ, .Lfunc_end0-___init__$$YGXXZ
	.cfi_endproc
                                        # -- End function
	.globl	_printNum$$YGXH$Z       # -- Begin function _printNum$$YGXH$Z
	.p2align	2
	.type	_printNum$$YGXH$Z,@function
_printNum$$YGXH$Z:                      # @"_printNum$$YGXH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	.cfi_offset ra, -4
	addi	a1, zero, 4
	sw	a0, 8(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 8(sp)
	sw	a1, 0(a0)
	mv	a0, a1
	call	_toString$$YGPADH$Z
	call	_println$$YGXPAD$Z
	j	.LBB1_1
.LBB1_1:                                # %return
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	_printNum$$YGXH$Z, .Lfunc_end1-_printNum$$YGXH$Z
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
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	lui	a1, %hi(i)
	mv	a2, zero
	sw	a2, %lo(i)(a1)
	sw	a0, 40(sp)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 3
	blt	a1, a0, .LBB2_4
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lui	a1, %hi(i)
	lw	a1, %lo(i)(a1)
	slli	a1, a1, 2
	add	a0, a0, a1
	addi	a1, zero, 48
	sw	a0, 36(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 11
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lw	a1, 36(sp)
	sw	a0, 0(a1)
	j	.LBB2_3
.LBB2_3:                                # %for.inc
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_1
.LBB2_4:                                # %for.end
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_5
.LBB2_5:                                # %for.cond_2
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_6 Depth 2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 4
	blt	a0, a1, .LBB2_10
	j	.LBB2_12
.LBB2_6:                                # %for.cond_3
                                        #   Parent Loop BB2_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lui	a0, %hi(j)
	lw	a0, %lo(j)(a0)
	addi	a1, zero, 9
	blt	a1, a0, .LBB2_9
	j	.LBB2_7
.LBB2_7:                                # %for.body_2
                                        #   in Loop: Header=BB2_6 Depth=2
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lui	a1, %hi(i)
	lw	a1, %lo(i)(a1)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	lui	a1, %hi(j)
	lw	a1, %lo(j)(a1)
	slli	a1, a1, 2
	add	a0, a0, a1
	addi	a1, zero, 888
	sw	a1, 0(a0)
	j	.LBB2_8
.LBB2_8:                                # %for.inc_2
                                        #   in Loop: Header=BB2_6 Depth=2
	lui	a0, %hi(j)
	lw	a1, %lo(j)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(j)(a0)
	j	.LBB2_6
.LBB2_9:                                # %for.end_2
                                        #   in Loop: Header=BB2_5 Depth=1
	j	.LBB2_11
.LBB2_10:                               # %for.body_3
                                        #   in Loop: Header=BB2_5 Depth=1
	lui	a0, %hi(j)
	mv	a1, zero
	sw	a1, %lo(j)(a0)
	j	.LBB2_6
.LBB2_11:                               # %for.inc_3
                                        #   in Loop: Header=BB2_5 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_5
.LBB2_12:                               # %for.end_3
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_13
.LBB2_13:                               # %for.cond_4
                                        # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 4
	blt	a1, a0, .LBB2_16
	j	.LBB2_14
.LBB2_14:                               # %for.body_4
                                        #   in Loop: Header=BB2_13 Depth=1
	lui	a0, %hi(b)
	lw	a1, %lo(b)(a0)
	lui	a2, %hi(i)
	lw	a3, %lo(i)(a2)
	slli	a3, a3, 2
	add	a1, a1, a3
	addi	a3, zero, 8
	sw	a0, 32(sp)
	mv	a0, a3
	sw	a2, 28(sp)
	sw	a1, 24(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 24(sp)
	sw	a0, 0(a1)
	lw	a0, 32(sp)
	lw	a1, %lo(b)(a0)
	lw	a2, 28(sp)
	lw	a3, %lo(i)(a2)
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addi	a3, zero, -1
	sw	a3, 0(a1)
	j	.LBB2_15
.LBB2_15:                               # %for.inc_4
                                        #   in Loop: Header=BB2_13 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_13
.LBB2_16:                               # %for.end_4
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a0, 12(a0)
	lw	a0, 36(a0)
	call	_printNum$$YGXH$Z
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_17
.LBB2_17:                               # %for.cond_5
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_18 Depth 2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 4
	blt	a0, a1, .LBB2_22
	j	.LBB2_24
.LBB2_18:                               # %for.cond_6
                                        #   Parent Loop BB2_17 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lui	a0, %hi(j)
	lw	a0, %lo(j)(a0)
	addi	a1, zero, 9
	blt	a1, a0, .LBB2_21
	j	.LBB2_19
.LBB2_19:                               # %for.body_5
                                        #   in Loop: Header=BB2_18 Depth=2
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lui	a1, %hi(i)
	lw	a1, %lo(i)(a1)
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	lui	a2, %hi(j)
	lw	a2, %lo(j)(a2)
	slli	a3, a2, 2
	add	a0, a0, a3
	addi	a3, zero, 10
	mul	a1, a1, a3
	add	a1, a1, a2
	sw	a1, 0(a0)
	j	.LBB2_20
.LBB2_20:                               # %for.inc_5
                                        #   in Loop: Header=BB2_18 Depth=2
	lui	a0, %hi(j)
	lw	a1, %lo(j)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(j)(a0)
	j	.LBB2_18
.LBB2_21:                               # %for.end_5
                                        #   in Loop: Header=BB2_17 Depth=1
	j	.LBB2_23
.LBB2_22:                               # %for.body_6
                                        #   in Loop: Header=BB2_17 Depth=1
	lui	a0, %hi(j)
	mv	a1, zero
	sw	a1, %lo(j)(a0)
	j	.LBB2_18
.LBB2_23:                               # %for.inc_6
                                        #   in Loop: Header=BB2_17 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_17
.LBB2_24:                               # %for.end_6
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB2_25
.LBB2_25:                               # %for.cond_7
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_26 Depth 2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	addi	a1, zero, 4
	blt	a0, a1, .LBB2_30
	j	.LBB2_32
.LBB2_26:                               # %for.cond_8
                                        #   Parent Loop BB2_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lui	a0, %hi(j)
	lw	a0, %lo(j)(a0)
	addi	a1, zero, 9
	blt	a1, a0, .LBB2_29
	j	.LBB2_27
.LBB2_27:                               # %for.body_7
                                        #   in Loop: Header=BB2_26 Depth=2
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lui	a1, %hi(i)
	lw	a1, %lo(i)(a1)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	lui	a1, %hi(j)
	lw	a1, %lo(j)(a1)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	call	_printNum$$YGXH$Z
	j	.LBB2_28
.LBB2_28:                               # %for.inc_7
                                        #   in Loop: Header=BB2_26 Depth=2
	lui	a0, %hi(j)
	lw	a1, %lo(j)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(j)(a0)
	j	.LBB2_26
.LBB2_29:                               # %for.end_7
                                        #   in Loop: Header=BB2_25 Depth=1
	j	.LBB2_31
.LBB2_30:                               # %for.body_8
                                        #   in Loop: Header=BB2_25 Depth=1
	lui	a0, %hi(j)
	mv	a1, zero
	sw	a1, %lo(j)(a0)
	j	.LBB2_26
.LBB2_31:                               # %for.inc_8
                                        #   in Loop: Header=BB2_25 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB2_25
.LBB2_32:                               # %for.end_8
	lui	a0, %hi(a)
	lw	a1, %lo(a)(a0)
	lw	a1, 8(a1)
	mv	a2, zero
	sw	a2, 40(a1)
	lw	a1, %lo(a)(a0)
	lw	a1, 8(a1)
	lw	a1, 40(a1)
	sw	a0, 20(sp)
	mv	a0, a1
	sw	a2, 16(sp)
	call	_printNum$$YGXH$Z
	lui	a0, %hi(b)
	lw	a1, %lo(b)(a0)
	lw	a1, 0(a1)
	addi	a2, zero, -2
	sw	a2, 0(a1)
	lw	a1, %lo(b)(a0)
	lw	a2, 20(sp)
	lw	a3, %lo(a)(a2)
	lw	a3, 8(a3)
	lw	a3, 40(a3)
	slli	a3, a3, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	addi	a3, zero, -10
	sw	a3, 0(a1)
	lw	a1, %lo(b)(a0)
	lw	a1, 0(a1)
	lw	a1, 0(a1)
	sw	a0, 12(sp)
	mv	a0, a1
	call	_printNum$$YGXH$Z
	lw	a0, 12(sp)
	lw	a1, %lo(b)(a0)
	lw	a1, 4(a1)
	lw	a0, 0(a1)
	call	_printNum$$YGXH$Z
	lw	a0, 16(sp)
	lw	a1, 40(sp)
	sw	a0, 0(a1)
	j	.LBB2_33
.LBB2_33:                               # %return
	lw	a0, 40(sp)
	lw	a0, 0(a0)
	lw	ra, 44(sp)
	addi	sp, sp, 48
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

	.type	b,@object               # @b
	.globl	b
	.p2align	2
b:
	.word	0
	.size	b, 4

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

	.section	".note.GNU-stack","",@progbits
