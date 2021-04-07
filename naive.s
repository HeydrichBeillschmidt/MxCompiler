	.text

	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
___init__$$YGXXZ:                       # @___init__$$YGXXZ
# %bb.0:                                # %entry
	mv	.ra.save, ra
	mv	.s0.save, s0
	mv	.s1.save, s1
	mv	.s2.save, s2
	mv	.s3.save, s3
	mv	.s4.save, s4
	mv	.s5.save, s5
	mv	.s6.save, s6
	mv	.s7.save, s7
	mv	.s8.save, s8
	mv	.s9.save, s9
	mv	.s10.save, s10
	mv	.s11.save, s11
	j	.LBB0_1
.LBB0_1:                                # %return
	mv	s0, .s0.save
	mv	s1, .s1.save
	mv	s2, .s2.save
	mv	s3, .s3.save
	mv	s4, .s4.save
	mv	s5, .s5.save
	mv	s6, .s6.save
	mv	s7, .s7.save
	mv	s8, .s8.save
	mv	s9, .s9.save
	mv	s10, .s10.save
	mv	s11, .s11.save
	mv	ra, .ra.save
	ret
                                        # -- End function

	.globl	_solveAge$older$$QEAXXZ # -- Begin function _solveAge$older$$QEAXXZ
	.p2align	2
_solveAge$older$$QEAXXZ:                # @_solveAge$older$$QEAXXZ
# %bb.0:                                # %entry
	mv	.ra.save, ra
	mv	.s0.save, s0
	mv	.s1.save, s1
	mv	.s2.save, s2
	mv	.s3.save, s3
	mv	.s4.save, s4
	mv	.s5.save, s5
	mv	.s6.save, s6
	mv	.s7.save, s7
	mv	.s8.save, s8
	mv	.s9.save, s9
	mv	.s10.save, s10
	mv	.s11.save, s11
	mv	this, a0
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_4, a0
	mv	k.addr, malloc_4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_3, a0
	mv	j.addr, malloc_3
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	i.addr, malloc_2
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	this.addr, malloc
	sw	this, 0(this.addr)
	lh	i, 0(i.addr)
	li	constInt1, 1
	sw	constInt1, 0(i.addr)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
	lh	i_2, 0(i.addr)
	li	constInt2, 100
	blt	i_2, constInt2, .LBB1_12
	j	.LBB1_14
.LBB1_2:                                # %for.cond_2
	lh	j_2, 0(j.addr)
	blt	j_2, constInt2, .LBB1_9
	j	.LBB1_11
.LBB1_3:                                # %for.cond_3
	lh	k_2, 0(k.addr)
	blt	k_2, constInt2, .LBB1_6
	j	.LBB1_8
.LBB1_4:                                # %if.then
	lh	this_2, 0(this.addr)
	lh	older.age, 0(this_2)
	lh	i_8, 0(i.addr)
	lh	i_9, 0(i.addr)
	sub	sub_4, i_8, i_9
	lh	i_10, 0(i.addr)
	add	add_10, sub_4, i_10
	lh	j_8, 0(j.addr)
	add	add_11, add_10, j_8
	lh	j_9, 0(j.addr)
	sub	sub_5, add_11, j_9
	lh	j_10, 0(j.addr)
	add	add_12, sub_5, j_10
	lh	k_7, 0(k.addr)
	add	add_13, add_12, k_7
	lh	k_8, 0(k.addr)
	sub	sub_6, add_13, k_8
	lh	k_9, 0(k.addr)
	add	add_14, sub_6, k_9
	lh	i_11, 0(i.addr)
	mul	mul_4, constInt2, i_11
	lh	j_11, 0(j.addr)
	li	constInt3, 10
	mul	mul_5, constInt3, j_11
	add	add_15, mul_4, mul_5
	lh	k_10, 0(k.addr)
	add	add_16, add_15, k_10
	mul	mul_6, add_14, add_16
	sw	mul_6, 0(this_2)
	j	.LBB1_5
.LBB1_5:                                # %if.end
	j	.LBB1_7
.LBB1_6:                                # %for.body
	lh	i_4, 0(i.addr)
	lh	i_5, 0(i.addr)
	sub	sub, i_4, i_5
	lh	i_6, 0(i.addr)
	add	add_3, sub, i_6
	lh	j_4, 0(j.addr)
	add	add_4, add_3, j_4
	lh	j_5, 0(j.addr)
	sub	sub_2, add_4, j_5
	lh	j_6, 0(j.addr)
	add	add_5, sub_2, j_6
	lh	k_3, 0(k.addr)
	add	add_6, add_5, k_3
	lh	k_4, 0(k.addr)
	sub	sub_3, add_6, k_4
	lh	k_5, 0(k.addr)
	add	add_7, sub_3, k_5
	lh	i_7, 0(i.addr)
	mul	mul, constInt2, i_7
	lh	j_7, 0(j.addr)
	mul	mul_2, constInt3, j_7
	add	add_8, mul, mul_2
	lh	k_6, 0(k.addr)
	add	add_9, add_8, k_6
	mul	mul_3, add_7, add_9
	li	constInt4, 1926
	rem	srem, mul_3, constInt4
	beq	srem, zero, .LBB1_4
	j	.LBB1_5
.LBB1_7:                                # %for.inc
	lh	k_11, 0(k.addr)
	addi	postfix_inc, k_11, 1
	sw	postfix_inc, 0(k.addr)
	j	.LBB1_3
.LBB1_8:                                # %for.end
	j	.LBB1_10
.LBB1_9:                                # %for.body_2
	lh	k, 0(k.addr)
	lh	j_3, 0(j.addr)
	addi	add_2, j_3, 1
	sw	add_2, 0(k.addr)
	j	.LBB1_3
.LBB1_10:                               # %for.inc_2
	lh	j_12, 0(j.addr)
	addi	postfix_inc_2, j_12, 1
	sw	postfix_inc_2, 0(j.addr)
	j	.LBB1_2
.LBB1_11:                               # %for.end_2
	j	.LBB1_13
.LBB1_12:                               # %for.body_3
	lh	j, 0(j.addr)
	lh	i_3, 0(i.addr)
	addi	add, i_3, 1
	sw	add, 0(j.addr)
	j	.LBB1_2
.LBB1_13:                               # %for.inc_3
	lh	i_12, 0(i.addr)
	addi	postfix_inc_3, i_12, 1
	sw	postfix_inc_3, 0(i.addr)
	j	.LBB1_1
.LBB1_14:                               # %for.end_3
	j	.LBB1_15
.LBB1_15:                               # %return
	mv	s0, .s0.save
	mv	s1, .s1.save
	mv	s2, .s2.save
	mv	s3, .s3.save
	mv	s4, .s4.save
	mv	s5, .s5.save
	mv	s6, .s6.save
	mv	s7, .s7.save
	mv	s8, .s8.save
	mv	s9, .s9.save
	mv	s10, .s10.save
	mv	s11, .s11.save
	mv	ra, .ra.save
	ret
                                        # -- End function

	.globl	main                    # -- Begin function main
	.p2align	2
main:                                   # @main
# %bb.0:                                # %entry
	mv	.ra.save, ra
	mv	.s0.save, s0
	mv	.s1.save, s1
	mv	.s2.save, s2
	mv	.s3.save, s3
	mv	.s4.save, s4
	mv	.s5.save, s5
	mv	.s6.save, s6
	mv	.s7.save, s7
	mv	.s8.save, s8
	mv	.s9.save, s9
	mv	.s10.save, s10
	mv	.s11.save, s11
	call	___init__$$YGXXZ
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	mrJiang.addr, malloc_2
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_3, a0
	mv	castToClassPtr, malloc_3
	sw	castToClassPtr, 0(mrJiang.addr)
	lh	mrJiang, 0(mrJiang.addr)
	mv	a0, mrJiang
	call	_solveAge$older$$QEAXXZ
	lh	mrJiang_2, 0(mrJiang.addr)
	lh	older.age, 0(mrJiang_2)
	li	constInt1, 10000
	bgt	older.age, constInt1, .LBB2_1
	j	.LBB2_2
.LBB2_1:                                # %if.then
	la	__const.main.str0, __const.main.str0
	mv	a0, __const.main.str0
	call	_println$$YGXPAD$Z
	j	.LBB2_2
.LBB2_2:                                # %if.end
	sw	zero, 0(retval)
	j	.LBB2_3
.LBB2_3:                                # %return
	lh	returnValue, 0(retval)
	mv	a0, returnValue
	mv	s0, .s0.save
	mv	s1, .s1.save
	mv	s2, .s2.save
	mv	s3, .s3.save
	mv	s4, .s4.save
	mv	s5, .s5.save
	mv	s6, .s6.save
	mv	s7, .s7.save
	mv	s8, .s8.save
	mv	s9, .s9.save
	mv	s10, .s10.save
	mv	s11, .s11.save
	mv	ra, .ra.save
	ret
                                        # -- End function


	.section	.sdata,"aw",@progbits
	.globl	__const.main.str0
__const.main.str0:
	.asciz	"eternal!"

