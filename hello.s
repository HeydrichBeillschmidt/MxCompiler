	.text
	.file	"test.ll"
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
	call	_getInt$$YGHXZ
	mv	a1, a0
	slli	a2, a0, 2
	addi	a2, a2, 4
	sw	a0, 40(sp)
	mv	a0, a2
	sw	a1, 36(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 40(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	mv	a2, zero
	sw	a0, 32(sp)
	sw	a2, 28(sp)
	j	.LBB0_1
.LBB0_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 28(sp)
	lw	a1, 36(sp)
	sw	a0, 24(sp)
	bge	a0, a1, .LBB0_3
	j	.LBB0_2
.LBB0_2:                                # %for.body
                                        #   in Loop: Header=BB0_1 Depth=1
	lw	a0, 24(sp)
	slli	a1, a0, 2
	lw	a2, 32(sp)
	add	a1, a2, a1
	sw	a1, 20(sp)
	call	_getInt$$YGHXZ
	lw	a1, 20(sp)
	sw	a0, 0(a1)
	lw	a0, 24(sp)
	addi	a1, a0, 1
	sw	a1, 28(sp)
	j	.LBB0_1
.LBB0_3:                                # %for.end
	addi	a0, zero, 12
	call	_malloc$$YGPADH$Z
	lw	a1, 32(sp)
	sw	a1, 0(a0)
	mv	a2, zero
	sw	a2, 4(a0)
	lw	a3, -4(a1)
	sw	a3, 8(a0)
	sw	a2, 16(sp)
	call	_mergeSort$$YGXUSlice_int$$$Z
	lw	a0, 16(sp)
	sw	a0, 12(sp)
	j	.LBB0_4
.LBB0_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 36(sp)
	sw	a0, 8(sp)
	bge	a0, a1, .LBB0_6
	j	.LBB0_5
.LBB0_5:                                # %for.body_2
                                        #   in Loop: Header=BB0_4 Depth=1
	lw	a0, 8(sp)
	slli	a1, a0, 2
	lw	a2, 32(sp)
	add	a1, a2, a1
	lw	a0, 0(a1)
	call	_toString$$YGPADH$Z
	lui	a1, %hi(.L$const.main.str2)
	addi	a1, a1, %lo(.L$const.main.str2)
	call	_strcat$$YGPADPADPAD$Z
	call	_print$$YGXPAD$Z
	lw	a0, 8(sp)
	addi	a1, a0, 1
	sw	a1, 12(sp)
	j	.LBB0_4
.LBB0_6:                                # %for.end_2
	lui	a0, %hi(.L$const.main.str3)
	addi	a0, a0, %lo(.L$const.main.str3)
	call	_println$$YGXPAD$Z
	mv	a0, zero
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	_merge$$YGPAHUSlice_int$$USlice_int$$$Z # -- Begin function _merge$$YGPAHUSlice_int$$USlice_int$$$Z
	.p2align	2
	.type	_merge$$YGPAHUSlice_int$$USlice_int$$$Z,@function
_merge$$YGPAHUSlice_int$$USlice_int$$$Z: # @"_merge$$YGPAHUSlice_int$$USlice_int$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -144
	.cfi_def_cfa_offset 144
	sw	ra, 140(sp)
	.cfi_offset ra, -4
	lw	a2, 8(a0)
	lw	a3, 4(a0)
	sub	a2, a2, a3
	mv	a3, zero
	sw	a1, 136(sp)
	sw	a0, 132(sp)
	bne	a2, a3, .LBB1_5
	j	.LBB1_1
.LBB1_1:                                # %if.then
	lw	a0, 136(sp)
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	slli	a2, a1, 2
	addi	a0, a2, 4
	sw	a1, 128(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 128(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	mv	a2, zero
	sw	a0, 124(sp)
	sw	a2, 120(sp)
	j	.LBB1_2
.LBB1_2:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 120(sp)
	lw	a1, 136(sp)
	lw	a2, 8(a1)
	lw	a3, 4(a1)
	sub	a2, a2, a3
	sw	a0, 116(sp)
	bge	a0, a2, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %for.body
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a0, 116(sp)
	slli	a1, a0, 2
	lw	a2, 124(sp)
	add	a1, a2, a1
	lw	a3, 136(sp)
	lw	a4, 0(a3)
	lw	a5, 4(a3)
	add	a5, a5, a0
	slli	a5, a5, 2
	add	a4, a4, a5
	lw	a4, 0(a4)
	sw	a4, 0(a1)
	addi	a1, a0, 1
	sw	a1, 120(sp)
	j	.LBB1_2
.LBB1_4:                                # %for.end
	lw	a0, 124(sp)
	sw	a0, 112(sp)
	j	.LBB1_36
.LBB1_5:                                # %if.end
	lw	a0, 136(sp)
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	mv	a2, zero
	bne	a1, a2, .LBB1_10
	j	.LBB1_6
.LBB1_6:                                # %if.then_2
	lw	a0, 132(sp)
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	slli	a2, a1, 2
	addi	a0, a2, 4
	sw	a1, 108(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 108(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	mv	a2, zero
	sw	a0, 104(sp)
	sw	a2, 100(sp)
	j	.LBB1_7
.LBB1_7:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 100(sp)
	lw	a1, 132(sp)
	lw	a2, 8(a1)
	lw	a3, 4(a1)
	sub	a2, a2, a3
	sw	a0, 96(sp)
	bge	a0, a2, .LBB1_9
	j	.LBB1_8
.LBB1_8:                                # %for.body_2
                                        #   in Loop: Header=BB1_7 Depth=1
	lw	a0, 96(sp)
	slli	a1, a0, 2
	lw	a2, 104(sp)
	add	a1, a2, a1
	lw	a3, 132(sp)
	lw	a4, 0(a3)
	lw	a5, 4(a3)
	add	a5, a5, a0
	slli	a5, a5, 2
	add	a4, a4, a5
	lw	a4, 0(a4)
	sw	a4, 0(a1)
	addi	a1, a0, 1
	sw	a1, 100(sp)
	j	.LBB1_7
.LBB1_9:                                # %for.end_2
	lw	a0, 104(sp)
	sw	a0, 112(sp)
	j	.LBB1_36
.LBB1_10:                               # %if.end_2
	lw	a0, 132(sp)
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	lw	a2, 136(sp)
	lw	a3, 8(a2)
	lw	a4, 4(a2)
	sub	a3, a3, a4
	add	a1, a1, a3
	slli	a3, a1, 2
	addi	a0, a3, 4
	sw	a1, 92(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 92(sp)
	sw	a1, 0(a0)
	addi	a2, a0, 4
	addi	a3, zero, 12
	sw	a0, 88(sp)
	mv	a0, a3
	sw	a2, 84(sp)
	sw	a3, 80(sp)
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 84(sp)
	sw	a2, 0(a0)
	mv	a3, zero
	sw	a3, 4(a0)
	lw	a3, 88(sp)
	lw	a4, 0(a3)
	sw	a4, 8(a0)
	lw	a5, 80(sp)
	sw	a0, 76(sp)
	mv	a0, a5
	sw	a1, 72(sp)
	sw	a4, 68(sp)
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 76(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	addi	a3, a3, 1
	sw	a3, 4(a0)
	lw	a4, 4(a2)
	lw	a5, 68(sp)
	add	a4, a4, a5
	sw	a4, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a4, zero, 1
	sw	a1, 64(sp)
	sw	a4, 60(sp)
	blt	a0, a3, .LBB1_12
	j	.LBB1_11
.LBB1_11:                               # %logical_or_branch
	lw	a0, 64(sp)
	lw	a1, 8(a0)
	lw	a2, 72(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 60(sp)
	j	.LBB1_12
.LBB1_12:                               # %logical_or_end
	lw	a0, 60(sp)
	mv	a1, zero
	beq	a0, a1, .LBB1_14
	j	.LBB1_13
.LBB1_13:                               # %if.then_4
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB1_14
.LBB1_14:                               # %if.end_4
	lw	a0, 132(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	slli	a2, a2, 3
	add	a1, a1, a2
	lw	a1, 0(a1)
	lw	a2, 136(sp)
	lw	a3, 0(a2)
	lw	a4, 4(a2)
	slli	a4, a4, 3
	add	a3, a3, a4
	lw	a3, 0(a3)
	bge	a1, a3, .LBB1_25
	j	.LBB1_15
.LBB1_15:                               # %if.then_3
	lw	a0, 132(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	slli	a2, a2, 3
	add	a1, a1, a2
	lw	a1, 0(a1)
	lw	a2, 84(sp)
	sw	a1, 0(a2)
	lw	a1, 8(a0)
	lw	a3, 4(a0)
	sub	a1, a1, a3
	addi	a0, zero, 12
	sw	a1, 56(sp)
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 132(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	addi	a3, a3, 1
	sw	a3, 4(a0)
	lw	a4, 4(a2)
	lw	a5, 56(sp)
	add	a4, a4, a5
	sw	a4, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a4, zero, 1
	sw	a1, 52(sp)
	sw	a4, 48(sp)
	blt	a0, a3, .LBB1_17
	j	.LBB1_16
.LBB1_16:                               # %logical_or_branch_2
	lw	a0, 52(sp)
	lw	a1, 8(a0)
	lw	a2, 132(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 48(sp)
	j	.LBB1_17
.LBB1_17:                               # %logical_or_end_2
	lw	a0, 48(sp)
	mv	a1, zero
	beq	a0, a1, .LBB1_19
	j	.LBB1_18
.LBB1_18:                               # %if.then_5
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB1_19
.LBB1_19:                               # %if.end_5
	lw	a0, 52(sp)
	lw	a1, 136(sp)
	call	_merge$$YGPAHUSlice_int$$USlice_int$$$Z
	addi	a1, zero, 12
	sw	a0, 44(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 44(sp)
	sw	a2, 0(a0)
	mv	a3, zero
	sw	a3, 4(a0)
	lw	a3, -4(a2)
	sw	a3, 8(a0)
	lw	a0, 64(sp)
	lw	a4, 8(a0)
	lw	a5, 4(a0)
	sub	a4, a4, a5
	sw	a1, 40(sp)
	bge	a4, a3, .LBB1_21
	j	.LBB1_20
.LBB1_20:                               # %if.then_6
	lui	a0, %hi(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	addi	a0, a0, %lo(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	call	_println$$YGXPAD$Z
	j	.LBB1_21
.LBB1_21:                               # %if.end_6
	mv	a0, zero
	sw	a0, 36(sp)
	j	.LBB1_22
.LBB1_22:                               # %for.cond_3
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 36(sp)
	lw	a1, 40(sp)
	lw	a2, 8(a1)
	lw	a3, 4(a1)
	sub	a2, a2, a3
	sw	a0, 32(sp)
	bge	a0, a2, .LBB1_24
	j	.LBB1_23
.LBB1_23:                               # %for.body_3
                                        #   in Loop: Header=BB1_22 Depth=1
	lw	a0, 64(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	lw	a3, 32(sp)
	add	a2, a2, a3
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a2, 40(sp)
	lw	a4, 0(a2)
	lw	a5, 4(a2)
	add	a5, a5, a3
	slli	a5, a5, 2
	add	a4, a4, a5
	lw	a4, 0(a4)
	sw	a4, 0(a1)
	addi	a1, a3, 1
	sw	a1, 36(sp)
	j	.LBB1_22
.LBB1_24:                               # %for.end_3
	j	.LBB1_35
.LBB1_25:                               # %if.else
	lw	a0, 136(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	slli	a2, a2, 3
	add	a1, a1, a2
	lw	a1, 0(a1)
	lw	a2, 84(sp)
	sw	a1, 0(a2)
	lw	a1, 8(a0)
	lw	a3, 4(a0)
	sub	a1, a1, a3
	addi	a0, zero, 12
	sw	a1, 28(sp)
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 136(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	addi	a3, a3, 1
	sw	a3, 4(a0)
	lw	a4, 4(a2)
	lw	a5, 28(sp)
	add	a4, a4, a5
	sw	a4, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a4, zero, 1
	sw	a1, 24(sp)
	sw	a4, 20(sp)
	blt	a0, a3, .LBB1_27
	j	.LBB1_26
.LBB1_26:                               # %logical_or_branch_3
	lw	a0, 24(sp)
	lw	a1, 8(a0)
	lw	a2, 136(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 20(sp)
	j	.LBB1_27
.LBB1_27:                               # %logical_or_end_3
	lw	a0, 20(sp)
	mv	a1, zero
	beq	a0, a1, .LBB1_29
	j	.LBB1_28
.LBB1_28:                               # %if.then_7
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB1_29
.LBB1_29:                               # %if.end_7
	lw	a0, 132(sp)
	lw	a1, 24(sp)
	call	_merge$$YGPAHUSlice_int$$USlice_int$$$Z
	addi	a1, zero, 12
	sw	a0, 16(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 16(sp)
	sw	a2, 0(a0)
	mv	a3, zero
	sw	a3, 4(a0)
	lw	a3, -4(a2)
	sw	a3, 8(a0)
	lw	a0, 64(sp)
	lw	a4, 8(a0)
	lw	a5, 4(a0)
	sub	a4, a4, a5
	sw	a1, 12(sp)
	bge	a4, a3, .LBB1_31
	j	.LBB1_30
.LBB1_30:                               # %if.then_8
	lui	a0, %hi(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	addi	a0, a0, %lo(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	call	_println$$YGXPAD$Z
	j	.LBB1_31
.LBB1_31:                               # %if.end_8
	mv	a0, zero
	sw	a0, 8(sp)
	j	.LBB1_32
.LBB1_32:                               # %for.cond_4
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 8(sp)
	lw	a1, 12(sp)
	lw	a2, 8(a1)
	lw	a3, 4(a1)
	sub	a2, a2, a3
	sw	a0, 4(sp)
	bge	a0, a2, .LBB1_34
	j	.LBB1_33
.LBB1_33:                               # %for.body_4
                                        #   in Loop: Header=BB1_32 Depth=1
	lw	a0, 64(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	lw	a3, 4(sp)
	add	a2, a2, a3
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a2, 12(sp)
	lw	a4, 0(a2)
	lw	a5, 4(a2)
	add	a5, a5, a3
	slli	a5, a5, 2
	add	a4, a4, a5
	lw	a4, 0(a4)
	sw	a4, 0(a1)
	addi	a1, a3, 1
	sw	a1, 8(sp)
	j	.LBB1_32
.LBB1_34:                               # %for.end_4
	j	.LBB1_35
.LBB1_35:                               # %if.end_3
	lw	a0, 84(sp)
	sw	a0, 112(sp)
	j	.LBB1_36
.LBB1_36:                               # %return
	lw	a0, 112(sp)
	lw	ra, 140(sp)
	addi	sp, sp, 144
	ret
.Lfunc_end1:
	.size	_merge$$YGPAHUSlice_int$$USlice_int$$$Z, .Lfunc_end1-_merge$$YGPAHUSlice_int$$USlice_int$$$Z
	.cfi_endproc
                                        # -- End function
	.globl	_mergeSort$$YGXUSlice_int$$$Z # -- Begin function _mergeSort$$YGXUSlice_int$$$Z
	.p2align	2
	.type	_mergeSort$$YGXUSlice_int$$$Z,@function
_mergeSort$$YGXUSlice_int$$$Z:          # @"_mergeSort$$YGXUSlice_int$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -64
	.cfi_def_cfa_offset 64
	sw	ra, 60(sp)
	.cfi_offset ra, -4
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	addi	a2, zero, 1
	sw	a0, 56(sp)
	bne	a1, a2, .LBB2_2
	j	.LBB2_1
.LBB2_1:                                # %if.then
	j	.LBB2_24
.LBB2_2:                                # %if.end
	lw	a0, 56(sp)
	lw	a1, 8(a0)
	lw	a2, 4(a0)
	sub	a1, a1, a2
	srli	a2, a1, 31
	add	a2, a1, a2
	srai	a2, a2, 1
	addi	a0, zero, 12
	sw	a1, 52(sp)
	sw	a2, 48(sp)
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	slli	a3, a3, 1
	sw	a3, 4(a0)
	lw	a4, 4(a2)
	lw	a5, 48(sp)
	add	a4, a4, a5
	sw	a4, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a4, zero, 1
	sw	a1, 44(sp)
	sw	a4, 40(sp)
	blt	a0, a3, .LBB2_4
	j	.LBB2_3
.LBB2_3:                                # %logical_or_branch
	lw	a0, 44(sp)
	lw	a1, 8(a0)
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 40(sp)
	j	.LBB2_4
.LBB2_4:                                # %logical_or_end
	lw	a0, 40(sp)
	mv	a1, zero
	beq	a0, a1, .LBB2_6
	j	.LBB2_5
.LBB2_5:                                # %if.then_2
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB2_6
.LBB2_6:                                # %if.end_2
	lw	a0, 44(sp)
	call	_mergeSort$$YGXUSlice_int$$$Z
	addi	a0, zero, 12
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	lw	a4, 48(sp)
	add	a3, a3, a4
	sw	a3, 4(a0)
	lw	a5, 4(a2)
	lw	a6, 52(sp)
	add	a5, a5, a6
	sw	a5, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a5, zero, 1
	sw	a1, 36(sp)
	sw	a5, 32(sp)
	blt	a0, a3, .LBB2_8
	j	.LBB2_7
.LBB2_7:                                # %logical_or_branch_2
	lw	a0, 36(sp)
	lw	a1, 8(a0)
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 32(sp)
	j	.LBB2_8
.LBB2_8:                                # %logical_or_end_2
	lw	a0, 32(sp)
	mv	a1, zero
	beq	a0, a1, .LBB2_10
	j	.LBB2_9
.LBB2_9:                                # %if.then_3
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB2_10
.LBB2_10:                               # %if.end_3
	lw	a0, 36(sp)
	call	_mergeSort$$YGXUSlice_int$$$Z
	addi	a0, zero, 12
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	slli	a3, a3, 1
	sw	a3, 4(a0)
	lw	a4, 4(a2)
	lw	a5, 48(sp)
	add	a4, a4, a5
	sw	a4, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a4, zero, 1
	sw	a1, 28(sp)
	sw	a4, 24(sp)
	blt	a0, a3, .LBB2_12
	j	.LBB2_11
.LBB2_11:                               # %logical_or_branch_3
	lw	a0, 28(sp)
	lw	a1, 8(a0)
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 24(sp)
	j	.LBB2_12
.LBB2_12:                               # %logical_or_end_3
	lw	a0, 24(sp)
	mv	a1, zero
	beq	a0, a1, .LBB2_14
	j	.LBB2_13
.LBB2_13:                               # %if.then_4
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB2_14
.LBB2_14:                               # %if.end_4
	addi	a0, zero, 12
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	sw	a3, 0(a0)
	lw	a3, 4(a2)
	lw	a4, 48(sp)
	add	a3, a3, a4
	sw	a3, 4(a0)
	lw	a5, 4(a2)
	lw	a6, 52(sp)
	add	a5, a5, a6
	sw	a5, 8(a0)
	lw	a0, 0(a2)
	lw	a0, -4(a0)
	addi	a5, zero, 1
	sw	a1, 20(sp)
	sw	a5, 16(sp)
	blt	a0, a3, .LBB2_16
	j	.LBB2_15
.LBB2_15:                               # %logical_or_branch_4
	lw	a0, 20(sp)
	lw	a1, 8(a0)
	lw	a2, 56(sp)
	lw	a3, 0(a2)
	lw	a3, -4(a3)
	slt	a1, a3, a1
	sw	a1, 16(sp)
	j	.LBB2_16
.LBB2_16:                               # %logical_or_end_4
	lw	a0, 16(sp)
	mv	a1, zero
	beq	a0, a1, .LBB2_18
	j	.LBB2_17
.LBB2_17:                               # %if.then_5
	lui	a0, %hi(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	addi	a0, a0, %lo(.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	call	_println$$YGXPAD$Z
	j	.LBB2_18
.LBB2_18:                               # %if.end_5
	lw	a0, 28(sp)
	lw	a1, 20(sp)
	call	_merge$$YGPAHUSlice_int$$USlice_int$$$Z
	addi	a1, zero, 12
	sw	a0, 12(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	mv	a1, a0
	lw	a2, 12(sp)
	sw	a2, 0(a0)
	mv	a3, zero
	sw	a3, 4(a0)
	lw	a3, -4(a2)
	sw	a3, 8(a0)
	lw	a0, 56(sp)
	lw	a4, 8(a0)
	lw	a5, 4(a0)
	sub	a4, a4, a5
	sw	a1, 8(sp)
	bge	a4, a3, .LBB2_20
	j	.LBB2_19
.LBB2_19:                               # %if.then_6
	lui	a0, %hi(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	addi	a0, a0, %lo(.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	call	_println$$YGXPAD$Z
	j	.LBB2_20
.LBB2_20:                               # %if.end_6
	mv	a0, zero
	sw	a0, 4(sp)
	j	.LBB2_21
.LBB2_21:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 4(sp)
	lw	a1, 8(sp)
	lw	a2, 8(a1)
	lw	a3, 4(a1)
	sub	a2, a2, a3
	sw	a0, 0(sp)
	bge	a0, a2, .LBB2_23
	j	.LBB2_22
.LBB2_22:                               # %for.body
                                        #   in Loop: Header=BB2_21 Depth=1
	lw	a0, 56(sp)
	lw	a1, 0(a0)
	lw	a2, 4(a0)
	lw	a3, 0(sp)
	add	a2, a2, a3
	slli	a2, a2, 2
	add	a1, a1, a2
	lw	a2, 8(sp)
	lw	a4, 0(a2)
	lw	a5, 4(a2)
	add	a5, a5, a3
	slli	a5, a5, 2
	add	a4, a4, a5
	lw	a4, 0(a4)
	sw	a4, 0(a1)
	addi	a1, a3, 1
	sw	a1, 4(sp)
	j	.LBB2_21
.LBB2_23:                               # %for.end
	j	.LBB2_24
.LBB2_24:                               # %return
	lw	ra, 60(sp)
	addi	sp, sp, 64
	ret
.Lfunc_end2:
	.size	_mergeSort$$YGXUSlice_int$$$Z, .Lfunc_end2-_mergeSort$$YGXUSlice_int$$$Z
	.cfi_endproc
                                        # -- End function
	.type	.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0,@object # @"$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0"
	.section	.rodata.str1.1,"aMS",@progbits,1
.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0:
	.asciz	"Warning: Slice_int::slice: out of range"
	.size	.L$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, 40

	.type	.L$const.main.str3,@object # @"$const.main.str3"
.L$const.main.str3:
	.zero	1
	.size	.L$const.main.str3, 1

	.type	.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1,@object # @"$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1"
.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1:
	.asciz	"Warning: Slice_int::copy: size() < arr.size()"
	.size	.L$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1, 46

	.type	.L$const.main.str2,@object # @"$const.main.str2"
.L$const.main.str2:
	.asciz	" "
	.size	.L$const.main.str2, 2

	.section	".note.GNU-stack","",@progbits
