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
	mv	a0, zero
	addi	a1, zero, 1
	mv	a2, a1
	mv	a3, a0
	sw	a2, 40(sp)
	sw	a3, 36(sp)
	sw	a1, 32(sp)
	sw	a0, 28(sp)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 28(sp)
	lw	a1, 32(sp)
	lw	a2, 36(sp)
	lw	a3, 40(sp)
	addi	a4, zero, 9
	sw	a0, 24(sp)
	sw	a1, 20(sp)
	sw	a2, 16(sp)
	sw	a3, 12(sp)
	blt	a4, a1, .LBB1_3
	j	.LBB1_2
.LBB1_2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, 16(sp)
	lw	a1, 12(sp)
	add	a2, a0, a1
	lw	a3, 20(sp)
	addi	a4, a3, 1
	mv	a5, a2
	sw	a5, 40(sp)
	sw	a1, 36(sp)
	sw	a4, 32(sp)
	sw	a2, 28(sp)
	j	.LBB1_1
.LBB1_3:                                # %for.end
	lw	a0, 24(sp)
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
