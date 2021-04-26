	.text
	.file	"test.ll"
	.globl	_copy$vector$$QEA_NUvector$$$Z # -- Begin function _copy$vector$$QEA_NUvector$$$Z
	.p2align	2
	.type	_copy$vector$$QEA_NUvector$$$Z,@function
_copy$vector$$QEA_NUvector$$$Z:         # @"_copy$vector$$QEA_NUvector$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	mv	a2, zero
	sw	a1, 24(sp)
	sw	a0, 20(sp)
	bne	a1, a2, .LBB0_2
	j	.LBB0_1
.LBB0_1:                                # %if.then
	mv	a0, zero
	sw	a0, 16(sp)
	j	.LBB0_9
.LBB0_2:                                # %if.end
	lw	a0, 24(sp)
	call	_getDim$vector$$QEAHXZ
	mv	a1, zero
	bne	a0, a1, .LBB0_7
	j	.LBB0_3
.LBB0_3:                                # %if.then_2
	mv	a0, zero
	lw	a1, 20(sp)
	sw	a0, 0(a1)
	sw	a0, 12(sp)
	j	.LBB0_8
.LBB0_4:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 8(sp)
	lw	a1, 20(sp)
	sw	a0, 4(sp)
	mv	a0, a1
	call	_getDim$vector$$QEAHXZ
	lw	a1, 4(sp)
	bge	a1, a0, .LBB0_6
	j	.LBB0_5
.LBB0_5:                                # %for.body
                                        #   in Loop: Header=BB0_4 Depth=1
	lw	a0, 20(sp)
	lw	a1, 0(a0)
	lw	a2, 4(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a4, 24(sp)
	lw	a5, 0(a4)
	add	a3, a5, a3
	lw	a3, 0(a3)
	sw	a3, 0(a1)
	addi	a1, a2, 1
	sw	a1, 8(sp)
	j	.LBB0_4
.LBB0_6:                                # %for.end
	lw	a0, 4(sp)
	sw	a0, 12(sp)
	j	.LBB0_8
.LBB0_7:                                # %if.else
	lw	a0, 24(sp)
	call	_getDim$vector$$QEAHXZ
	slli	a1, a0, 2
	addi	a1, a1, 4
	sw	a0, 0(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 0(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lw	a2, 20(sp)
	sw	a0, 0(a2)
	mv	a0, zero
	sw	a0, 8(sp)
	j	.LBB0_4
.LBB0_8:                                # %if.end_2
	lw	a0, 12(sp)
	addi	a1, zero, 1
	sw	a1, 16(sp)
	j	.LBB0_9
.LBB0_9:                                # %return
	lw	a0, 16(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	_copy$vector$$QEA_NUvector$$$Z, .Lfunc_end0-_copy$vector$$QEA_NUvector$$$Z
	.cfi_endproc
                                        # -- End function
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	ret
.Lfunc_end1:
	.size	___init__$$YGXXZ, .Lfunc_end1-___init__$$YGXXZ
	.cfi_endproc
                                        # -- End function
	.globl	_tostring$vector$$QEAPADXZ # -- Begin function _tostring$vector$$QEAPADXZ
	.p2align	2
	.type	_tostring$vector$$QEAPADXZ,@function
_tostring$vector$$QEAPADXZ:             # @"_tostring$vector$$QEAPADXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	.cfi_offset ra, -4
	lui	a1, %hi(.L__const._tostring$vector$$QEAPADXZ.str0)
	addi	a1, a1, %lo(.L__const._tostring$vector$$QEAPADXZ.str0)
	sw	a0, 40(sp)
	sw	a1, 36(sp)
	call	_getDim$vector$$QEAHXZ
	addi	a1, zero, 1
	lw	a2, 36(sp)
	sw	a2, 32(sp)
	blt	a0, a1, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %if.then
	lw	a0, 40(sp)
	lw	a1, 0(a0)
	lw	a0, 0(a1)
	call	_toString$$YGPADH$Z
	lw	a1, 36(sp)
	sw	a0, 28(sp)
	mv	a0, a1
	lw	a1, 28(sp)
	call	_strcat$$YGPADPADPAD$Z
	sw	a0, 32(sp)
	j	.LBB2_2
.LBB2_2:                                # %if.end
	lw	a0, 32(sp)
	addi	a1, zero, 1
	sw	a1, 24(sp)
	sw	a0, 20(sp)
	j	.LBB2_3
.LBB2_3:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)
	lw	a1, 24(sp)
	lw	a2, 40(sp)
	sw	a0, 16(sp)
	mv	a0, a2
	sw	a1, 12(sp)
	call	_getDim$vector$$QEAHXZ
	lw	a1, 12(sp)
	bge	a1, a0, .LBB2_5
	j	.LBB2_4
.LBB2_4:                                # %for.body
                                        #   in Loop: Header=BB2_3 Depth=1
	lui	a0, %hi(.L__const._tostring$vector$$QEAPADXZ.str1)
	addi	a1, a0, %lo(.L__const._tostring$vector$$QEAPADXZ.str1)
	lw	a0, 16(sp)
	call	_strcat$$YGPADPADPAD$Z
	lw	a1, 40(sp)
	lw	a2, 0(a1)
	lw	a3, 12(sp)
	slli	a4, a3, 2
	add	a2, a2, a4
	lw	a2, 0(a2)
	sw	a0, 8(sp)
	mv	a0, a2
	call	_toString$$YGPADH$Z
	lw	a1, 8(sp)
	sw	a0, 4(sp)
	mv	a0, a1
	lw	a1, 4(sp)
	call	_strcat$$YGPADPADPAD$Z
	lw	a1, 12(sp)
	addi	a2, a1, 1
	sw	a2, 24(sp)
	sw	a0, 20(sp)
	j	.LBB2_3
.LBB2_5:                                # %for.end
	lui	a0, %hi(.L__const._tostring$vector$$QEAPADXZ.str2)
	addi	a1, a0, %lo(.L__const._tostring$vector$$QEAPADXZ.str2)
	lw	a0, 16(sp)
	call	_strcat$$YGPADPADPAD$Z
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end2:
	.size	_tostring$vector$$QEAPADXZ, .Lfunc_end2-_tostring$vector$$QEAPADXZ
	.cfi_endproc
                                        # -- End function
	.globl	_init$vector$$QEAXPAH$Z # -- Begin function _init$vector$$QEAXPAH$Z
	.p2align	2
	.type	_init$vector$$QEAXPAH$Z,@function
_init$vector$$QEAXPAH$Z:                # @"_init$vector$$QEAXPAH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	mv	a2, zero
	sw	a1, 24(sp)
	sw	a0, 20(sp)
	bne	a1, a2, .LBB3_2
	j	.LBB3_1
.LBB3_1:                                # %if.then
	j	.LBB3_6
.LBB3_2:                                # %if.end
	lw	a0, 24(sp)
	lw	a1, -4(a0)
	slli	a2, a1, 2
	addi	a0, a2, 4
	sw	a1, 16(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 16(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lw	a2, 20(sp)
	sw	a0, 0(a2)
	mv	a0, zero
	sw	a0, 12(sp)
	j	.LBB3_3
.LBB3_3:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 24(sp)
	lw	a2, -4(a1)
	sw	a0, 8(sp)
	bge	a0, a2, .LBB3_5
	j	.LBB3_4
.LBB3_4:                                # %for.body
                                        #   in Loop: Header=BB3_3 Depth=1
	lw	a0, 20(sp)
	lw	a1, 0(a0)
	lw	a2, 8(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a4, 24(sp)
	add	a3, a4, a3
	lw	a3, 0(a3)
	sw	a3, 0(a1)
	addi	a1, a2, 1
	sw	a1, 12(sp)
	j	.LBB3_3
.LBB3_5:                                # %for.end
	j	.LBB3_6
.LBB3_6:                                # %return
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	_init$vector$$QEAXPAH$Z, .Lfunc_end3-_init$vector$$QEAXPAH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_set$vector$$QEA_NHH$Z  # -- Begin function _set$vector$$QEA_NHH$Z
	.p2align	2
	.type	_set$vector$$QEA_NHH$Z,@function
_set$vector$$QEA_NHH$Z:                 # @"_set$vector$$QEA_NHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	sw	a0, 24(sp)
	sw	a2, 20(sp)
	sw	a1, 16(sp)
	call	_getDim$vector$$QEAHXZ
	lw	a1, 16(sp)
	bge	a0, a1, .LBB4_2
	j	.LBB4_1
.LBB4_1:                                # %if.then
	mv	a0, zero
	sw	a0, 12(sp)
	j	.LBB4_3
.LBB4_2:                                # %if.end
	lw	a0, 24(sp)
	lw	a1, 0(a0)
	lw	a2, 16(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a3, 20(sp)
	sw	a3, 0(a1)
	addi	a1, zero, 1
	sw	a1, 12(sp)
	j	.LBB4_3
.LBB4_3:                                # %return
	lw	a0, 12(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	_set$vector$$QEA_NHH$Z, .Lfunc_end4-_set$vector$$QEA_NHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_getDim$vector$$QEAHXZ  # -- Begin function _getDim$vector$$QEAHXZ
	.p2align	2
	.type	_getDim$vector$$QEAHXZ,@function
_getDim$vector$$QEAHXZ:                 # @"_getDim$vector$$QEAHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	lw	a1, 0(a0)
	mv	a2, zero
	sw	a0, 12(sp)
	bne	a1, a2, .LBB5_2
	j	.LBB5_1
.LBB5_1:                                # %if.then
	mv	a0, zero
	sw	a0, 8(sp)
	j	.LBB5_3
.LBB5_2:                                # %if.end
	lw	a0, 12(sp)
	lw	a1, 0(a0)
	lw	a1, -4(a1)
	sw	a1, 8(sp)
	j	.LBB5_3
.LBB5_3:                                # %return
	lw	a0, 8(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	_getDim$vector$$QEAHXZ, .Lfunc_end5-_getDim$vector$$QEAHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_add$vector$$QEAUvector$$Uvector$$$Z # -- Begin function _add$vector$$QEAUvector$$Uvector$$$Z
	.p2align	2
	.type	_add$vector$$QEAUvector$$Uvector$$$Z,@function
_add$vector$$QEAUvector$$Uvector$$$Z:   # @"_add$vector$$QEAUvector$$Uvector$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	.cfi_offset ra, -4
	sw	a0, 40(sp)
	sw	a1, 36(sp)
	call	_getDim$vector$$QEAHXZ
	lw	a1, 36(sp)
	sw	a0, 32(sp)
	mv	a0, a1
	call	_getDim$vector$$QEAHXZ
	addi	a1, zero, 1
	lw	a2, 32(sp)
	sw	a1, 28(sp)
	bne	a2, a0, .LBB6_2
	j	.LBB6_1
.LBB6_1:                                # %logicalOr_branch
	lw	a0, 40(sp)
	call	_getDim$vector$$QEAHXZ
	seqz	a0, a0
	sw	a0, 28(sp)
	j	.LBB6_2
.LBB6_2:                                # %logicalOr_end
	lw	a0, 28(sp)
	mv	a1, zero
	beq	a0, a1, .LBB6_4
	j	.LBB6_3
.LBB6_3:                                # %if.then
	j	.LBB6_8
.LBB6_4:                                # %if.end
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 40(sp)
	sw	a0, 24(sp)
	mv	a0, a2
	sw	a1, 20(sp)
	call	_getDim$vector$$QEAHXZ
	slli	a1, a0, 2
	addi	a1, a1, 4
	sw	a0, 16(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 16(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lw	a2, 24(sp)
	sw	a0, 0(a2)
	mv	a0, zero
	sw	a0, 12(sp)
	j	.LBB6_5
.LBB6_5:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 40(sp)
	sw	a0, 8(sp)
	mv	a0, a1
	call	_getDim$vector$$QEAHXZ
	lw	a1, 8(sp)
	bge	a1, a0, .LBB6_7
	j	.LBB6_6
.LBB6_6:                                # %for.body
                                        #   in Loop: Header=BB6_5 Depth=1
	lw	a0, 20(sp)
	lw	a1, 0(a0)
	lw	a2, 8(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a4, 40(sp)
	lw	a5, 0(a4)
	add	a5, a5, a3
	lw	a5, 0(a5)
	lw	a6, 36(sp)
	lw	a7, 0(a6)
	add	a3, a7, a3
	lw	a3, 0(a3)
	add	a3, a5, a3
	sw	a3, 0(a1)
	addi	a1, a2, 1
	sw	a1, 12(sp)
	j	.LBB6_5
.LBB6_7:                                # %for.end
	j	.LBB6_8
.LBB6_8:                                # %return
	mv	a0, zero
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end6:
	.size	_add$vector$$QEAUvector$$Uvector$$$Z, .Lfunc_end6-_add$vector$$QEAUvector$$Uvector$$$Z
	.cfi_endproc
                                        # -- End function
	.globl	_dot$vector$$QEAHUvector$$$Z # -- Begin function _dot$vector$$QEAHUvector$$$Z
	.p2align	2
	.type	_dot$vector$$QEAHUvector$$$Z,@function
_dot$vector$$QEAHUvector$$$Z:           # @"_dot$vector$$QEAHUvector$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	mv	a2, zero
	mv	a3, a2
	sw	a1, 24(sp)
	sw	a0, 20(sp)
	sw	a3, 16(sp)
	sw	a2, 12(sp)
	j	.LBB7_1
.LBB7_1:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 16(sp)
	lw	a2, 20(sp)
	sw	a0, 8(sp)
	mv	a0, a2
	sw	a1, 4(sp)
	call	_getDim$vector$$QEAHXZ
	lw	a1, 8(sp)
	bge	a1, a0, .LBB7_3
	j	.LBB7_2
.LBB7_2:                                # %while.body
                                        #   in Loop: Header=BB7_1 Depth=1
	lw	a0, 20(sp)
	lw	a1, 0(a0)
	lw	a2, 8(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a1, 0(a1)
	lw	a4, 24(sp)
	lw	a5, 0(a4)
	add	a3, a5, a3
	lw	a3, 0(a3)
	mul	a1, a1, a3
	addi	a3, a2, 1
	sw	a1, 16(sp)
	sw	a3, 12(sp)
	j	.LBB7_1
.LBB7_3:                                # %while.end
	lw	a0, 4(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	_dot$vector$$QEAHUvector$$$Z, .Lfunc_end7-_dot$vector$$QEAHUvector$$$Z
	.cfi_endproc
                                        # -- End function
	.globl	_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z # -- Begin function _scalarInPlaceMultiply$vector$$QEAUvector$$H$Z
	.p2align	2
	.type	_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z,@function
_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z: # @"_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	lw	a2, 0(a0)
	mv	a3, zero
	sw	a1, 24(sp)
	sw	a0, 20(sp)
	bne	a2, a3, .LBB8_2
	j	.LBB8_1
.LBB8_1:                                # %if.then
	mv	a0, zero
	sw	a0, 16(sp)
	j	.LBB8_6
.LBB8_2:                                # %if.end
	mv	a0, zero
	sw	a0, 12(sp)
	j	.LBB8_3
.LBB8_3:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 20(sp)
	sw	a0, 8(sp)
	mv	a0, a1
	call	_getDim$vector$$QEAHXZ
	lw	a1, 8(sp)
	bge	a1, a0, .LBB8_5
	j	.LBB8_4
.LBB8_4:                                # %for.body
                                        #   in Loop: Header=BB8_3 Depth=1
	lw	a0, 20(sp)
	lw	a1, 0(a0)
	lw	a2, 8(sp)
	slli	a3, a2, 2
	add	a1, a1, a3
	lw	a3, 0(a1)
	lw	a4, 24(sp)
	mul	a3, a4, a3
	sw	a3, 0(a1)
	addi	a1, a2, 1
	sw	a1, 12(sp)
	j	.LBB8_3
.LBB8_5:                                # %for.end
	lw	a0, 20(sp)
	sw	a0, 16(sp)
	j	.LBB8_6
.LBB8_6:                                # %return
	lw	a0, 16(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z, .Lfunc_end8-_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 44
	sw	a0, 24(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 10
	sw	a1, 0(a0)
	addi	a0, a0, 4
	mv	a1, zero
	sw	a0, 20(sp)
	sw	a1, 16(sp)
	j	.LBB9_1
.LBB9_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 16(sp)
	addi	a1, zero, 9
	sw	a0, 12(sp)
	blt	a1, a0, .LBB9_3
	j	.LBB9_2
.LBB9_2:                                # %for.body
                                        #   in Loop: Header=BB9_1 Depth=1
	lw	a0, 12(sp)
	slli	a1, a0, 2
	lw	a2, 20(sp)
	add	a1, a2, a1
	addi	a3, zero, 9
	sub	a3, a3, a0
	sw	a3, 0(a1)
	addi	a1, a0, 1
	sw	a1, 16(sp)
	j	.LBB9_1
.LBB9_3:                                # %for.end
	lw	a0, 24(sp)
	lw	a1, 20(sp)
	call	_init$vector$$QEAXPAH$Z
	lui	a0, %hi(.L__const.main.str3)
	addi	a0, a0, %lo(.L__const.main.str3)
	call	_print$$YGXPAD$Z
	lw	a0, 24(sp)
	call	_tostring$vector$$QEAPADXZ
	call	_println$$YGXPAD$Z
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	sw	a0, 8(sp)
	lw	a2, 24(sp)
	sw	a1, 4(sp)
	mv	a1, a2
	call	_copy$vector$$QEA_NUvector$$$Z
	addi	a1, zero, 3
	addi	a2, zero, 817
	lw	a3, 8(sp)
	sw	a0, 0(sp)
	mv	a0, a3
	call	_set$vector$$QEA_NHH$Z
	andi	a0, a0, 1
	mv	a1, zero
	beq	a0, a1, .LBB9_5
	j	.LBB9_4
.LBB9_4:                                # %if.then
	lui	a0, %hi(.L__const.main.str4)
	addi	a0, a0, %lo(.L__const.main.str4)
	call	_println$$YGXPAD$Z
	j	.LBB9_5
.LBB9_5:                                # %if.end
	lui	a0, %hi(.L__const.main.str5)
	addi	a0, a0, %lo(.L__const.main.str5)
	call	_print$$YGXPAD$Z
	lw	a0, 4(sp)
	call	_tostring$vector$$QEAPADXZ
	call	_println$$YGXPAD$Z
	lui	a0, %hi(.L__const.main.str6)
	addi	a0, a0, %lo(.L__const.main.str6)
	call	_print$$YGXPAD$Z
	lw	a0, 24(sp)
	lw	a1, 4(sp)
	call	_add$vector$$QEAUvector$$Uvector$$$Z
	call	_tostring$vector$$QEAPADXZ
	call	_println$$YGXPAD$Z
	lui	a0, %hi(.L__const.main.str7)
	addi	a0, a0, %lo(.L__const.main.str7)
	call	_print$$YGXPAD$Z
	lw	a0, 24(sp)
	lw	a1, 4(sp)
	call	_dot$vector$$QEAHUvector$$$Z
	call	_toString$$YGPADH$Z
	call	_println$$YGXPAD$Z
	lui	a0, %hi(.L__const.main.str8)
	addi	a0, a0, %lo(.L__const.main.str8)
	call	_print$$YGXPAD$Z
	addi	a1, zero, 8
	lw	a0, 4(sp)
	call	_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z
	call	_tostring$vector$$QEAPADXZ
	call	_println$$YGXPAD$Z
	mv	a0, zero
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	main, .Lfunc_end9-main
	.cfi_endproc
                                        # -- End function
	.type	.L__const.main.str8,@object # @__const.main.str8
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str8:
	.asciz	"(1 << 3) * y: "
	.size	.L__const.main.str8, 15

	.type	.L__const.main.str7,@object # @__const.main.str7
.L__const.main.str7:
	.asciz	"x * y: "
	.size	.L__const.main.str7, 8

	.type	.L__const._tostring$vector$$QEAPADXZ.str2,@object # @"__const._tostring$vector$$QEAPADXZ.str2"
.L__const._tostring$vector$$QEAPADXZ.str2:
	.asciz	" )"
	.size	.L__const._tostring$vector$$QEAPADXZ.str2, 3

	.type	.L__const._tostring$vector$$QEAPADXZ.str1,@object # @"__const._tostring$vector$$QEAPADXZ.str1"
.L__const._tostring$vector$$QEAPADXZ.str1:
	.asciz	", "
	.size	.L__const._tostring$vector$$QEAPADXZ.str1, 3

	.type	.L__const._tostring$vector$$QEAPADXZ.str0,@object # @"__const._tostring$vector$$QEAPADXZ.str0"
.L__const._tostring$vector$$QEAPADXZ.str0:
	.asciz	"( "
	.size	.L__const._tostring$vector$$QEAPADXZ.str0, 3

	.type	.L__const.main.str6,@object # @__const.main.str6
.L__const.main.str6:
	.asciz	"x + y: "
	.size	.L__const.main.str6, 8

	.type	.L__const.main.str5,@object # @__const.main.str5
.L__const.main.str5:
	.asciz	"vector y: "
	.size	.L__const.main.str5, 11

	.type	.L__const.main.str4,@object # @__const.main.str4
.L__const.main.str4:
	.asciz	"excited!"
	.size	.L__const.main.str4, 9

	.type	.L__const.main.str3,@object # @__const.main.str3
.L__const.main.str3:
	.asciz	"vector x: "
	.size	.L__const.main.str3, 11

	.section	".note.GNU-stack","",@progbits
