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
	addi	a0, zero, 132
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 4
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a1, %hi(a)
	sw	a0, %lo(a)(a1)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	___init__$$YGXXZ, .Lfunc_end0-___init__$$YGXXZ
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
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	call	___init__$$YGXXZ
	addi	a0, zero, 132
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 4
	sw	a1, 0(a0)
	lui	a1, %hi(a)
	lw	a2, %lo(a)(a1)
	addi	a3, a0, 4
	sw	a3, 16(sp)
	sw	a2, 4(a0)
	lw	a0, 16(sp)
	lw	a2, %lo(a)(a1)
	sw	a2, 4(a0)
	lw	a0, 16(sp)
	lw	a2, %lo(a)(a1)
	sw	a2, 8(a0)
	lw	a0, 16(sp)
	lw	a1, %lo(a)(a1)
	sw	a1, 12(a0)
	lw	a0, 16(sp)
	lw	a0, -4(a0)
	call	_toString$$YGPADH$Z
	call	_println$$YGXPAD$Z
	sw	zero, 20(sp)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 16(sp)
	lw	a0, 0(a0)
	lw	a1, 20(sp)
	lw	a0, -4(a0)
	bge	a1, a0, .LBB1_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 16(sp)
	lw	a1, 20(sp)
	lw	a0, 0(a0)
	slli	a1, a1, 2
	add	s0, a0, a1
	call	_getInt$$YGHXZ
	sw	a0, 0(s0)
	lw	a0, 20(sp)
	addi	a0, a0, 1
	sw	a0, 20(sp)
	j	.LBB1_1
.LBB1_3:                                # %for.end
	sw	zero, 20(sp)
.LBB1_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 16(sp)
	lw	a0, 4(a0)
	lw	a1, 20(sp)
	lw	a0, -4(a0)
	bge	a1, a0, .LBB1_6
# %bb.5:                                # %for.body_2
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a0, 16(sp)
	lw	a1, 20(sp)
	lw	a0, 4(a0)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	lw	a0, 20(sp)
	addi	a0, a0, 1
	sw	a0, 20(sp)
	j	.LBB1_4
.LBB1_6:                                # %for.end_2
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	call	_println$$YGXPAD$Z
	sw	zero, 20(sp)
.LBB1_7:                                # %for.cond_3
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 16(sp)
	lw	a0, 8(a0)
	lw	a1, 20(sp)
	lw	a0, -4(a0)
	bge	a1, a0, .LBB1_9
# %bb.8:                                # %for.body_3
                                        #   in Loop: Header=BB1_7 Depth=1
	lw	a0, 16(sp)
	lw	a1, 20(sp)
	lw	a0, 8(a0)
	slli	a1, a1, 2
	add	a0, a0, a1
	sw	zero, 0(a0)
	lw	a0, 20(sp)
	addi	a0, a0, 1
	sw	a0, 20(sp)
	j	.LBB1_7
.LBB1_9:                                # %for.end_3
	sw	zero, 20(sp)
.LBB1_10:                               # %for.cond_4
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 16(sp)
	lw	a0, 12(a0)
	lw	a1, 20(sp)
	lw	a0, -4(a0)
	bge	a1, a0, .LBB1_12
# %bb.11:                               # %for.body_4
                                        #   in Loop: Header=BB1_10 Depth=1
	lw	a0, 16(sp)
	lw	a1, 20(sp)
	lw	a0, 12(a0)
	slli	a1, a1, 2
	add	a0, a0, a1
	lw	a0, 0(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	lw	a0, 20(sp)
	addi	a0, a0, 1
	sw	a0, 20(sp)
	j	.LBB1_10
.LBB1_12:                               # %for.end_4
	sw	zero, 12(sp)
	mv	a0, zero
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	a,@object               # @a
	.section	.sbss,"aw",@nobits
	.globl	a
	.p2align	2
a:
	.word	0
	.size	a, 4

	.type	.L__const.main.str0,@object # @__const.main.str0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str0:
	.zero	1
	.size	.L__const.main.str0, 1

	.section	".note.GNU-stack","",@progbits
