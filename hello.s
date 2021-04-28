	.text
	.file	"ssa.ll"
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
	.globl	_merge$$YGHHH$Z         # -- Begin function _merge$$YGHHH$Z
	.p2align	2
	.type	_merge$$YGHHH$Z,@function
_merge$$YGHHH$Z:                        # @"_merge$$YGHHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -48
	.cfi_def_cfa_offset 48
	sw	ra, 44(sp)
	.cfi_offset ra, -4
	mv	a2, zero
	sw	a1, 40(sp)
	sw	a0, 36(sp)
	bne	a0, a2, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %if.then
	lw	a0, 40(sp)
	sw	a0, 32(sp)
	j	.LBB1_7
.LBB1_2:                                # %if.end
	mv	a0, zero
	lw	a1, 40(sp)
	bne	a1, a0, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %if.then_2
	lw	a0, 36(sp)
	sw	a0, 32(sp)
	j	.LBB1_7
.LBB1_4:                                # %if.end_2
	lui	a0, %hi(w)
	lw	a0, %lo(w)(a0)
	lw	a1, 36(sp)
	slli	a2, a1, 2
	add	a2, a0, a2
	lw	a2, 0(a2)
	lw	a3, 40(sp)
	slli	a4, a3, 2
	add	a0, a0, a4
	lw	a0, 0(a0)
	mv	a4, zero
	sw	a4, 28(sp)
	sw	a3, 24(sp)
	sw	a1, 20(sp)
	bge	a2, a0, .LBB1_6
	j	.LBB1_5
.LBB1_5:                                # %if.then_3
	lw	a0, 36(sp)
	lw	a1, 36(sp)
	lw	a2, 40(sp)
	sw	a0, 28(sp)
	sw	a1, 24(sp)
	sw	a2, 20(sp)
	j	.LBB1_6
.LBB1_6:                                # %if.end_3
	lw	a0, 20(sp)
	lw	a1, 24(sp)
	lw	a2, 28(sp)
	lui	a3, %hi(r)
	lw	a4, %lo(r)(a3)
	slli	a5, a0, 2
	add	a4, a4, a5
	lw	a6, 0(a4)
	sw	a0, 16(sp)
	mv	a0, a6
	sw	a2, 12(sp)
	sw	a3, 8(sp)
	sw	a5, 4(sp)
	sw	a4, 0(sp)
	call	_merge$$YGHHH$Z
	lw	a1, 0(sp)
	sw	a0, 0(a1)
	lui	a0, %hi(l)
	lw	a0, %lo(l)(a0)
	lw	a2, 4(sp)
	add	a0, a0, a2
	lw	a3, 0(a0)
	lw	a4, 8(sp)
	lw	a5, %lo(r)(a4)
	add	a5, a5, a2
	lw	a5, 0(a5)
	sw	a5, 0(a0)
	lw	a0, %lo(r)(a4)
	add	a0, a0, a2
	sw	a3, 0(a0)
	lw	a0, 16(sp)
	sw	a0, 32(sp)
	j	.LBB1_7
.LBB1_7:                                # %return
	lw	a0, 32(sp)
	lw	ra, 44(sp)
	addi	sp, sp, 48
	ret
.Lfunc_end1:
	.size	_merge$$YGHHH$Z, .Lfunc_end1-_merge$$YGHHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -96
	.cfi_def_cfa_offset 96
	sw	ra, 92(sp)
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	call	_getInt$$YGHXZ
	lui	a1, %hi(N)
	sw	a0, %lo(N)(a1)
	sw	a1, 88(sp)
	call	_getInt$$YGHXZ
	lui	a1, %hi(M)
	sw	a0, %lo(M)(a1)
	sw	a1, 84(sp)
	call	_getString$$YGPADXZ
	lui	a1, %hi(ch)
	sw	a0, %lo(ch)(a1)
	lw	a0, 88(sp)
	lw	a1, %lo(N)(a0)
	lw	a2, 84(sp)
	lw	a3, %lo(M)(a2)
	add	a1, a1, a3
	addi	a1, a1, 5
	slli	a3, a1, 2
	addi	a0, a3, 4
	sw	a1, 80(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 80(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a2, %hi(l)
	sw	a0, %lo(l)(a2)
	lw	a0, 88(sp)
	lw	a2, %lo(N)(a0)
	lw	a3, 84(sp)
	lw	a4, %lo(M)(a3)
	add	a2, a2, a4
	addi	a2, a2, 5
	slli	a4, a2, 2
	addi	a0, a4, 4
	sw	a2, 76(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 76(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a2, %hi(r)
	sw	a0, %lo(r)(a2)
	lw	a0, 88(sp)
	lw	a2, %lo(N)(a0)
	lw	a3, 84(sp)
	lw	a4, %lo(M)(a3)
	add	a2, a2, a4
	addi	a2, a2, 5
	slli	a4, a2, 2
	addi	a0, a4, 4
	sw	a2, 72(sp)
	call	_malloc$$YGPADH$Z
	lw	a1, 72(sp)
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a2, %hi(w)
	sw	a0, %lo(w)(a2)
	addi	a0, zero, 1
	sw	a0, 68(sp)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 68(sp)
	lui	a1, %hi(N)
	lw	a1, %lo(N)(a1)
	sw	a0, 64(sp)
	blt	a1, a0, .LBB2_3
	j	.LBB2_2
.LBB2_2:                                # %for.body
                                        #   in Loop: Header=BB2_1 Depth=1
	lui	a0, %hi(w)
	lw	a0, %lo(w)(a0)
	lw	a1, 64(sp)
	slli	a2, a1, 2
	add	a0, a0, a2
	sw	a2, 60(sp)
	sw	a0, 56(sp)
	call	_getInt$$YGHXZ
	lw	a1, 56(sp)
	sw	a0, 0(a1)
	lui	a0, %hi(l)
	lw	a0, %lo(l)(a0)
	lw	a1, 60(sp)
	add	a0, a0, a1
	mv	a2, zero
	sw	a2, 0(a0)
	lui	a0, %hi(r)
	lw	a0, %lo(r)(a0)
	add	a0, a0, a1
	sw	a2, 0(a0)
	lw	a0, 64(sp)
	addi	a2, a0, 1
	sw	a2, 68(sp)
	j	.LBB2_1
.LBB2_3:                                # %for.end
	addi	a0, zero, 1
	sw	a0, 52(sp)
	j	.LBB2_4
.LBB2_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 52(sp)
	lui	a1, %hi(M)
	lw	a1, %lo(M)(a1)
	sw	a0, 48(sp)
	blt	a1, a0, .LBB2_6
	j	.LBB2_5
.LBB2_5:                                # %for.body_2
                                        #   in Loop: Header=BB2_4 Depth=1
	lui	a0, %hi(w)
	lw	a0, %lo(w)(a0)
	lui	a1, %hi(N)
	lw	a2, %lo(N)(a1)
	lw	a3, 48(sp)
	add	a2, a3, a2
	slli	a2, a2, 2
	add	a0, a0, a2
	lui	a2, %hi(ch)
	lw	a2, %lo(ch)(a2)
	addi	a4, a3, -1
	sw	a0, 44(sp)
	mv	a0, a2
	sw	a1, 40(sp)
	mv	a1, a4
	call	_ord$string$$QEAHH$Z
	lw	a1, 44(sp)
	sw	a0, 0(a1)
	lui	a0, %hi(l)
	lw	a0, %lo(l)(a0)
	lw	a1, 40(sp)
	lw	a2, %lo(N)(a1)
	lw	a3, 48(sp)
	add	a2, a3, a2
	slli	a2, a2, 2
	add	a0, a0, a2
	mv	a2, zero
	sw	a2, 0(a0)
	lui	a0, %hi(r)
	lw	a0, %lo(r)(a0)
	lw	a4, %lo(N)(a1)
	add	a4, a3, a4
	slli	a4, a4, 2
	add	a0, a0, a4
	sw	a2, 0(a0)
	addi	a0, a3, 1
	sw	a0, 52(sp)
	j	.LBB2_4
.LBB2_6:                                # %for.end_2
	lui	a0, %hi(N)
	lw	a0, %lo(N)(a0)
	addi	a0, a0, 1
	addi	a1, zero, 2
	addi	a2, zero, 1
	sw	a0, 36(sp)
	sw	a2, 32(sp)
	sw	a1, 28(sp)
	j	.LBB2_7
.LBB2_7:                                # %for.cond_3
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 28(sp)
	lw	a1, 32(sp)
	lui	a2, %hi(N)
	lw	a2, %lo(N)(a2)
	sw	a0, 24(sp)
	sw	a1, 20(sp)
	blt	a2, a0, .LBB2_9
	j	.LBB2_8
.LBB2_8:                                # %for.body_3
                                        #   in Loop: Header=BB2_7 Depth=1
	lw	a0, 20(sp)
	lw	a1, 24(sp)
	call	_merge$$YGHHH$Z
	lw	a1, 24(sp)
	addi	a2, a1, 1
	sw	a0, 32(sp)
	sw	a2, 28(sp)
	j	.LBB2_7
.LBB2_9:                                # %for.end_3
	lui	a0, %hi(N)
	lw	a0, %lo(N)(a0)
	addi	a0, a0, 2
	lw	a1, 36(sp)
	sw	a0, 16(sp)
	sw	a1, 12(sp)
	j	.LBB2_10
.LBB2_10:                               # %for.cond_4
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, 12(sp)
	lw	a1, 16(sp)
	lui	a2, %hi(N)
	lw	a2, %lo(N)(a2)
	lui	a3, %hi(M)
	lw	a3, %lo(M)(a3)
	add	a2, a2, a3
	sw	a0, 8(sp)
	sw	a1, 4(sp)
	blt	a2, a1, .LBB2_12
	j	.LBB2_11
.LBB2_11:                               # %for.body_4
                                        #   in Loop: Header=BB2_10 Depth=1
	lw	a0, 8(sp)
	lw	a1, 4(sp)
	call	_merge$$YGHHH$Z
	lw	a1, 4(sp)
	addi	a2, a1, 1
	sw	a2, 16(sp)
	sw	a0, 12(sp)
	j	.LBB2_10
.LBB2_12:                               # %for.end_4
	lui	a0, %hi(w)
	lw	a0, %lo(w)(a0)
	lw	a1, 20(sp)
	slli	a2, a1, 2
	add	a0, a0, a2
	lw	a0, 0(a0)
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	call	_print$$YGXPAD$Z
	lui	a0, %hi(ch)
	lw	a0, %lo(ch)(a0)
	lui	a1, %hi(N)
	lw	a1, %lo(N)(a1)
	lw	a2, 8(sp)
	sub	a1, a2, a1
	addi	a3, a1, -1
	sw	a1, 0(sp)
	mv	a1, a3
	lw	a2, 0(sp)
	call	_substring$string$$QEAPADHH$Z
	call	_print$$YGXPAD$Z
	lui	a0, %hi(.L__const.main.str1)
	addi	a0, a0, %lo(.L__const.main.str1)
	call	_print$$YGXPAD$Z
	lw	a0, 20(sp)
	lw	a1, 8(sp)
	call	_merge$$YGHHH$Z
	call	_toString$$YGPADH$Z
	call	_println$$YGXPAD$Z
	mv	a0, zero
	lw	ra, 92(sp)
	addi	sp, sp, 96
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	r,@object               # @r
	.section	.sbss,"aw",@nobits
	.globl	r
	.p2align	2
r:
	.word	0
	.size	r, 4

	.type	ch,@object              # @ch
	.globl	ch
	.p2align	2
ch:
	.word	0
	.size	ch, 4

	.type	w,@object               # @w
	.globl	w
	.p2align	2
w:
	.word	0
	.size	w, 4

	.type	.L__const.main.str1,@object # @__const.main.str1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str1:
	.asciz	"\n"
	.size	.L__const.main.str1, 2

	.type	.L__const.main.str0,@object # @__const.main.str0
.L__const.main.str0:
	.asciz	" "
	.size	.L__const.main.str0, 2

	.type	l,@object               # @l
	.section	.sbss,"aw",@nobits
	.globl	l
	.p2align	2
l:
	.word	0
	.size	l, 4

	.type	M,@object               # @M
	.globl	M
	.p2align	2
M:
	.word	0                       # 0x0
	.size	M, 4

	.type	N,@object               # @N
	.globl	N
	.p2align	2
N:
	.word	0                       # 0x0
	.size	N, 4

	.section	".note.GNU-stack","",@progbits
