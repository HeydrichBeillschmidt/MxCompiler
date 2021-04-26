	.text
	.file	"ssa.ll"
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
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a0, -4(a0)
	slli	a1, a0, 2
	addi	a1, a1, 4
	sw	a0, 40(sp)
	mv	a0, a1
	call	_malloc$$YGPADH$Z
	lw	a1, 40(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	mv	a2, zero
	sw	a0, 36(sp)
	sw	a2, 32(sp)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 32(sp)
	lui	a1, %hi(a)
	lw	a1, %lo(a)(a1)
	lw	a1, -4(a1)
	sw	a0, 28(sp)
	bge	a0, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a1, 28(sp)
	slli	a2, a1, 2
	add	a0, a0, a2
	mv	a3, zero
	sw	a3, 0(a0)
	lw	a0, 36(sp)
	add	a2, a0, a2
	sw	a2, 24(sp)
	call	_getInt$$YGHXZ
	lw	a1, 24(sp)
	sw	a0, 0(a1)
	lw	a0, 28(sp)
	addi	a1, a0, 1
	sw	a1, 32(sp)
	j	.LBB1_1
.LBB1_3:                                # %for.end
	mv	a0, zero
	sw	a0, 20(sp)
	j	.LBB1_4
.LBB1_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 20(sp)
	lui	a1, %hi(a)
	lw	a1, %lo(a)(a1)
	lw	a1, -4(a1)
	sw	a0, 16(sp)
	bge	a0, a1, .LBB1_6
	j	.LBB1_5
.LBB1_5:                                # %for.body_2
                                        #   in Loop: Header=BB1_4 Depth=1
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a1, 16(sp)
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	lw	a0, 16(sp)
	addi	a1, a0, 1
	sw	a1, 20(sp)
	j	.LBB1_4
.LBB1_6:                                # %for.end_2
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	call	_println$$YGXPAD$Z
	lui	a0, %hi(a)
	lw	a1, 36(sp)
	sw	a1, %lo(a)(a0)
	mv	a0, zero
	sw	a0, 12(sp)
	j	.LBB1_7
.LBB1_7:                                # %for.cond_3
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lui	a1, %hi(a)
	lw	a1, %lo(a)(a1)
	lw	a1, -4(a1)
	sw	a0, 8(sp)
	bge	a0, a1, .LBB1_9
	j	.LBB1_8
.LBB1_8:                                # %for.body_3
                                        #   in Loop: Header=BB1_7 Depth=1
	lui	a0, %hi(a)
	lw	a0, %lo(a)(a0)
	lw	a1, 8(sp)
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	lw	a0, 8(sp)
	addi	a1, a0, 1
	sw	a1, 12(sp)
	j	.LBB1_7
.LBB1_9:                                # %for.end_3
	mv	a0, zero
	lw	ra, 44(sp)
	addi	sp, sp, 48
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
