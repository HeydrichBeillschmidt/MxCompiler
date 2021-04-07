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
	.globl	_qpow$$YGHHHH$Z         # -- Begin function _qpow$$YGHHHH$Z
	.p2align	2
	.type	_qpow$$YGHHHH$Z,@function
_qpow$$YGHHHH$Z:                        # @"_qpow$$YGHHHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	sw	s1, 20(sp)
	sw	s2, 16(sp)
	sw	s3, 12(sp)
	sw	s4, 8(sp)
	sw	s5, 4(sp)
	sw	s6, 0(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	.cfi_offset s5, -28
	.cfi_offset s6, -32
	mv	s4, a2
	mv	s5, a1
	mv	s1, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s0, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s3, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s2, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s6, a0
	sw	s1, 0(a0)
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s1, a0
	sw	s5, 0(a0)
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	sw	s4, 0(a0)
	addi	a1, zero, 1
	sw	a1, 0(s3)
	lw	a1, 0(s6)
	sw	a1, 0(s0)
	j	.LBB1_2
.LBB1_1:                                # %if.end
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 0(s0)
	lw	a2, 0(a0)
	mul	a1, a1, a1
	rem	a1, a1, a2
	sw	a1, 0(s0)
	lw	a1, 0(s1)
	srli	a2, a1, 31
	add	a1, a1, a2
	srai	a1, a1, 1
	sw	a1, 0(s1)
.LBB1_2:                                # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a1, 0(s1)
	blez	a1, .LBB1_5
# %bb.3:                                # %while.body
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 0(s1)
	andi	a1, a1, 1
	beqz	a1, .LBB1_1
# %bb.4:                                # %if.then
                                        #   in Loop: Header=BB1_2 Depth=1
	lw	a1, 0(s3)
	lw	a2, 0(s0)
	lw	a3, 0(a0)
	mul	a1, a1, a2
	rem	a1, a1, a3
	sw	a1, 0(s3)
	j	.LBB1_1
.LBB1_5:                                # %while.end
	lw	a0, 0(s3)
	sw	a0, 0(s2)
	lw	s6, 0(sp)
	lw	s5, 4(sp)
	lw	s4, 8(sp)
	lw	s3, 12(sp)
	lw	s2, 16(sp)
	lw	s1, 20(sp)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	_qpow$$YGHHHH$Z, .Lfunc_end1-_qpow$$YGHHHH$Z
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
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	call	___init__$$YGXXZ
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s0, a0
	lui	a0, 2
	addi	a2, a0, 1808
	addi	a0, zero, 2
	addi	a1, zero, 10
	call	_qpow$$YGHHHH$Z
	call	_toString$$YGPADH$Z
	call	_println$$YGXPAD$Z
	sw	zero, 0(s0)
	mv	a0, zero
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
