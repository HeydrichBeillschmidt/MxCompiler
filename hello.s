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
	.globl	_solveAge$older$$QEAXXZ # -- Begin function _solveAge$older$$QEAXXZ
	.p2align	2
	.type	_solveAge$older$$QEAXXZ,@function
_solveAge$older$$QEAXXZ:                # @"_solveAge$older$$QEAXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	.cfi_offset ra, -4
	addi	a1, zero, 4
	sw	a0, 40(sp)
	mv	a0, a1
	sw	a1, 36(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 36(sp)
	sw	a0, 32(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 36(sp)
	sw	a0, 28(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 36(sp)
	sw	a0, 24(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 36(sp)
	sw	a0, 20(sp)
	mv	a0, a2
	sw	a1, 16(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 40(sp)
	sw	a1, 0(a0)
	addi	a0, zero, 1
	lw	a2, 20(sp)
	sw	a0, 0(a2)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_2 Depth 2
                                        #       Child Loop BB1_3 Depth 3
	lw	a0, 16(sp)
	lw	a1, 0(a0)
	addi	a2, zero, 10
	blt	a1, a2, .LBB1_12
	j	.LBB1_14
.LBB1_2:                                # %for.cond_2
                                        #   Parent Loop BB1_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_3 Depth 3
	lw	a0, 24(sp)
	lw	a1, 0(a0)
	addi	a2, zero, 100
	blt	a1, a2, .LBB1_9
	j	.LBB1_11
.LBB1_3:                                # %for.cond_3
                                        #   Parent Loop BB1_1 Depth=1
                                        #     Parent Loop BB1_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	lw	a0, 28(sp)
	lw	a1, 0(a0)
	addi	a2, zero, 100
	blt	a1, a2, .LBB1_6
	j	.LBB1_8
.LBB1_4:                                # %if.then
                                        #   in Loop: Header=BB1_3 Depth=3
	lw	a0, 16(sp)
	lw	a0, 0(a0)
	call	_printInt$$YGXH$Z
	lui	a0, %hi(.L__const._solveAge$older$$QEAXXZ.str0)
	addi	a0, a0, %lo(.L__const._solveAge$older$$QEAXXZ.str0)
	sw	a0, 12(sp)
	call	_print$$YGXPAD$Z
	lw	a0, 24(sp)
	lw	a0, 0(a0)
	call	_printInt$$YGXH$Z
	lw	a0, 12(sp)
	call	_print$$YGXPAD$Z
	lw	a0, 28(sp)
	lw	a0, 0(a0)
	call	_printInt$$YGXH$Z
	lw	a0, 12(sp)
	call	_print$$YGXPAD$Z
	lw	a0, 32(sp)
	lw	a0, 0(a0)
	call	_printlnInt$$YGXH$Z
	j	.LBB1_5
.LBB1_5:                                # %if.end
                                        #   in Loop: Header=BB1_3 Depth=3
	j	.LBB1_7
.LBB1_6:                                # %for.body
                                        #   in Loop: Header=BB1_3 Depth=3
	lw	a0, 16(sp)
	lw	a1, 0(a0)
	lw	a2, 24(sp)
	lw	a3, 0(a2)
	add	a4, a1, a3
	lw	a5, 28(sp)
	lw	a6, 0(a5)
	add	a4, a4, a6
	addi	a7, zero, 100
	mul	a1, a1, a7
	addi	a7, zero, 10
	mul	a3, a3, a7
	add	a1, a1, a3
	add	a1, a1, a6
	mul	a1, a4, a1
	lw	a3, 32(sp)
	sw	a1, 0(a3)
	lui	a4, 278749
	addi	a4, a4, 719
	mulh	a4, a1, a4
	srli	a6, a4, 31
	srai	a4, a4, 9
	add	a4, a4, a6
	addi	a6, zero, 1926
	mul	a4, a4, a6
	sub	a1, a1, a4
	mv	a4, zero
	beq	a1, a4, .LBB1_4
	j	.LBB1_5
.LBB1_7:                                # %for.inc
                                        #   in Loop: Header=BB1_3 Depth=3
	lw	a0, 28(sp)
	lw	a1, 0(a0)
	addi	a1, a1, 1
	sw	a1, 0(a0)
	j	.LBB1_3
.LBB1_8:                                # %for.end
                                        #   in Loop: Header=BB1_2 Depth=2
	j	.LBB1_10
.LBB1_9:                                # %for.body_2
                                        #   in Loop: Header=BB1_2 Depth=2
	lw	a0, 24(sp)
	lw	a1, 0(a0)
	addi	a1, a1, 1
	lw	a2, 28(sp)
	sw	a1, 0(a2)
	j	.LBB1_3
.LBB1_10:                               # %for.inc_2
                                        #   in Loop: Header=BB1_2 Depth=2
	lw	a0, 24(sp)
	lw	a1, 0(a0)
	addi	a1, a1, 1
	sw	a1, 0(a0)
	j	.LBB1_2
.LBB1_11:                               # %for.end_2
                                        #   in Loop: Header=BB1_1 Depth=1
	j	.LBB1_13
.LBB1_12:                               # %for.body_3
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 16(sp)
	lw	a1, 0(a0)
	addi	a1, a1, 1
	lw	a2, 24(sp)
	sw	a1, 0(a2)
	j	.LBB1_2
.LBB1_13:                               # %for.inc_3
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 16(sp)
	lw	a1, 0(a0)
	addi	a1, a1, 1
	sw	a1, 0(a0)
	j	.LBB1_1
.LBB1_14:                               # %for.end_3
	j	.LBB1_15
.LBB1_15:                               # %return
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	_solveAge$older$$QEAXXZ, .Lfunc_end1-_solveAge$older$$QEAXXZ
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
	addi	a0, zero, 4
	sw	a0, 8(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 8(sp)
	sw	a0, 4(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 8(sp)
	sw	a0, 0(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 4(sp)
	sw	a0, 0(a1)
	call	_solveAge$older$$QEAXXZ
	lw	a0, 4(sp)
	lw	a1, 0(a0)
	lw	a1, 0(a1)
	lui	a2, 2
	addi	a2, a2, 1809
	blt	a1, a2, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %if.then
	lui	a0, %hi(.L__const.main.str1)
	addi	a0, a0, %lo(.L__const.main.str1)
	call	_println$$YGXPAD$Z
	j	.LBB2_2
.LBB2_2:                                # %if.end
	mv	a0, zero
	lw	a1, 0(sp)
	sw	a0, 0(a1)
	j	.LBB2_3
.LBB2_3:                                # %return
	lw	a0, 0(sp)
	lw	a0, 0(a0)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.str1,@object # @__const.main.str1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str1:
	.asciz	"eternal!"
	.size	.L__const.main.str1, 9

	.type	.L__const._solveAge$older$$QEAXXZ.str0,@object # @"__const._solveAge$older$$QEAXXZ.str0"
.L__const._solveAge$older$$QEAXXZ.str0:
	.asciz	" "
	.size	.L__const._solveAge$older$$QEAXXZ.str0, 2

	.section	".note.GNU-stack","",@progbits
