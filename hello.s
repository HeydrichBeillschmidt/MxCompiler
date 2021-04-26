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
	.globl	_dceconst$$YGHXZ        # -- Begin function _dceconst$$YGHXZ
	.p2align	2
	.type	_dceconst$$YGHXZ,@function
_dceconst$$YGHXZ:                       # @"_dceconst$$YGHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	lui	a0, 28
	addi	a0, a0, -174
	ret
.Lfunc_end1:
	.size	_dceconst$$YGHXZ, .Lfunc_end1-_dceconst$$YGHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_test$$YGHXZ            # -- Begin function _test$$YGHXZ
	.p2align	2
	.type	_test$$YGHXZ,@function
_test$$YGHXZ:                           # @"_test$$YGHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	mv	a0, zero
	mv	a1, a0
	sw	a1, 12(sp)
	sw	a0, 8(sp)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 8(sp)
	lw	a1, 12(sp)
	addi	a2, zero, 199
	sw	a0, 4(sp)
	sw	a1, 0(sp)
	blt	a2, a1, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	lw	a0, 4(sp)
	addi	a1, a0, 1
	lw	a2, 0(sp)
	addi	a3, a2, 2
	sw	a3, 12(sp)
	sw	a1, 8(sp)
	j	.LBB2_1
.LBB2_3:                                # %for.end
	lw	a0, 4(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	_test$$YGHXZ, .Lfunc_end2-_test$$YGHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_naivedce$$YGHXZ        # -- Begin function _naivedce$$YGHXZ
	.p2align	2
	.type	_naivedce$$YGHXZ,@function
_naivedce$$YGHXZ:                       # @"_naivedce$$YGHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	a0, zero, 1919
	ret
.Lfunc_end3:
	.size	_naivedce$$YGHXZ, .Lfunc_end3-_naivedce$$YGHXZ
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
	call	_test$$YGHXZ
	sw	a0, 8(sp)
	call	_naivedce$$YGHXZ
	lw	a1, 8(sp)
	add	a0, a1, a0
	sw	a0, 4(sp)
	call	_dceconst$$YGHXZ
	lw	a1, 4(sp)
	add	a0, a1, a0
	lui	a1, 1048564
	addi	a1, a1, -1845
	add	a0, a0, a1
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
	.cfi_endproc
                                        # -- End function
	.type	N,@object               # @N
	.section	.sdata,"aw",@progbits
	.globl	N
	.p2align	2
N:
	.word	80                      # 0x50
	.size	N, 4

	.section	".note.GNU-stack","",@progbits
