	.text

	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	lui	s0, %hi(w)
	call	_getInt$$YGHXZ
	sw	a0, %lo(w)(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	seqz	a1, a0
	sb	a1, 3(sp)
	beqz	a0, .LBB1_3
# %bb.1:                                # %logicalAnd_end
	lbu	a0, 3(sp)
	beqz	a0, .LBB1_4
.LBB1_2:                                # %if.then
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	j	.LBB1_5
.LBB1_3:                                # %logicalAnd_branch
	lw	a0, %lo(w)(s0)
	addi	a1, zero, 2
	slt	a0, a1, a0
	sb	a0, 3(sp)
	lbu	a0, 3(sp)
	bnez	a0, .LBB1_2
.LBB1_4:                                # %if.else
	lui	a0, %hi(.L__const.main.str1)
	addi	a0, a0, %lo(.L__const.main.str1)
.LBB1_5:                                # %if.end
	call	_print$$YGXPAD$Z
	sw	zero, 4(sp)
	mv	a0, zero
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
                                        # -- End function
	.type	w,@object               # @w
	.section	.sbss,"aw",@nobits
	.globl	w
	.p2align	2
w:
	.word	0                       # 0x0
	.size	w, 4

	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str1:
	.asciz	"NO"

.L__const.main.str0:
	.asciz	"YES"
