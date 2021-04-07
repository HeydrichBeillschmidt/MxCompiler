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
	.globl	_solveAge$older$$QEAXXZ # -- Begin function _solveAge$older$$QEAXXZ
	.p2align	2
	.type	_solveAge$older$$QEAXXZ,@function
_solveAge$older$$QEAXXZ:                # @"_solveAge$older$$QEAXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	sw	s1, 20(sp)
	sw	s2, 16(sp)
	sw	s3, 12(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	mv	s3, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s0, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s1, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s2, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	sw	s3, 0(a0)
	addi	a1, zero, 1
	sw	a1, 0(s2)
	addi	t1, zero, 100
	addi	a7, zero, 10
	lui	a3, 278749
	addi	t0, a3, 719
	addi	a6, zero, 1926
	j	.LBB1_2
.LBB1_1:                                # %for.end_2
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 0(s2)
	addi	a1, a1, 1
	sw	a1, 0(s2)
.LBB1_2:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_5 Depth 2
                                        #       Child Loop BB1_8 Depth 3
	lw	a5, 0(s2)
	bge	a5, t1, .LBB1_11
# %bb.3:                                # %for.body_3
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 0(s2)
	j	.LBB1_5
.LBB1_4:                                # %for.end
                                        #   in Loop: Header=BB1_5 Depth=2
	lw	a1, 0(s1)
.LBB1_5:                                # %for.cond_2
                                        #   Parent Loop BB1_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_8 Depth 3
	addi	a1, a1, 1
	sw	a1, 0(s1)
	lw	a5, 0(s1)
	bge	a5, t1, .LBB1_1
# %bb.6:                                # %for.body_2
                                        #   in Loop: Header=BB1_5 Depth=2
	lw	a1, 0(s1)
	j	.LBB1_8
.LBB1_7:                                # %if.end
                                        #   in Loop: Header=BB1_8 Depth=3
	lw	a1, 0(s0)
.LBB1_8:                                # %for.cond_3
                                        #   Parent Loop BB1_2 Depth=1
                                        #     Parent Loop BB1_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	addi	a1, a1, 1
	sw	a1, 0(s0)
	lw	a5, 0(s0)
	bge	a5, t1, .LBB1_4
# %bb.9:                                # %for.body
                                        #   in Loop: Header=BB1_8 Depth=3
	lw	a1, 0(s2)
	lw	a2, 0(s1)
	lw	a3, 0(s0)
	add	a4, a1, a2
	add	a4, a4, a3
	mul	a1, a1, t1
	mul	a2, a2, a7
	add	a1, a1, a2
	add	a1, a1, a3
	mul	a1, a4, a1
	mulh	a2, a1, t0
	srli	a3, a2, 31
	srai	a2, a2, 9
	add	a2, a2, a3
	mul	a2, a2, a6
	sub	a1, a1, a2
	bnez	a1, .LBB1_7
# %bb.10:                               # %if.then
                                        #   in Loop: Header=BB1_8 Depth=3
	lw	a5, 0(s2)
	lw	a4, 0(s1)
	lw	a2, 0(s0)
	lw	a3, 0(a0)
	add	a1, a5, a4
	add	a1, a1, a2
	mul	a5, a5, t1
	mul	a4, a4, a7
	add	a4, a5, a4
	add	a2, a4, a2
	mul	a1, a1, a2
	sw	a1, 0(a3)
	j	.LBB1_7
.LBB1_11:                               # %for.end_3
	lw	s3, 12(sp)
	lw	s2, 16(sp)
	lw	s1, 20(sp)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
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
	sw	s0, 8(sp)
	sw	s1, 4(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	call	___init__$$YGXXZ
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s1, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s0, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	sw	a0, 0(s1)
	call	_solveAge$older$$QEAXXZ
	lw	a0, 0(s1)
	lw	a0, 0(a0)
	call	_printlnInt$$YGXH$Z
	lw	a0, 0(s1)
	lw	a0, 0(a0)
	lui	a1, 2
	addi	a1, a1, 1809
	blt	a0, a1, .LBB2_2
# %bb.1:                                # %if.then
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	call	_println$$YGXPAD$Z
.LBB2_2:                                # %if.end
	sw	zero, 0(s0)
	mv	a0, zero
	lw	s1, 4(sp)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.str0,@object # @__const.main.str0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str0:
	.asciz	"eternal!"
	.size	.L__const.main.str0, 9

	.section	".note.GNU-stack","",@progbits
