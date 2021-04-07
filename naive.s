	.text

	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
___init__$$YGXXZ:                       # @___init__$$YGXXZ
# %bb.0:                                # %entry
	addi	sp, sp, 0
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
	addi	sp, sp, 0
	ret
                                        # -- End function

	.globl	_abs$$YGHH$Z            # -- Begin function _abs$$YGHH$Z
	.p2align	2
_abs$$YGHH$Z:                           # @_abs$$YGHH$Z
# %bb.0:                                # %entry
	addi	sp, sp, 0
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
	mv	c, a0
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	c.addr, malloc_2
	sw	c, 0(c.addr)
	lh	c_2, 0(c.addr)
	bgt	c_2, zero, .LBB1_1
	j	.LBB1_2
.LBB1_1:                                # %if.then
	lh	c_3, 0(c.addr)
	sw	c_3, 0(retval)
	j	.LBB1_3
.LBB1_2:                                # %if.end
	lh	c_4, 0(c.addr)
	sub	prefix_neg, zero, c_4
	sw	prefix_neg, 0(retval)
	j	.LBB1_3
.LBB1_3:                                # %return
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
	addi	sp, sp, 0
	ret
                                        # -- End function

	.globl	main                    # -- Begin function main
	.p2align	2
main:                                   # @main
# %bb.0:                                # %entry
	addi	sp, sp, 0
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
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	lui	lui, %hi(i)
	lh	i, %lo(i)(lui)
	lui	lui1, %hi(i)
	sw	zero, %lo(i)(lui1)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
	lui	lui2, %hi(i)
	lh	i_2, %lo(i)(lui2)
	li	constInt, 5
	blt	i_2, constInt, .LBB2_8
	j	.LBB2_10
.LBB2_2:                                # %for.cond_2
	lui	lui3, %hi(j)
	lh	j_2, %lo(j)(lui3)
	blt	j_2, constInt, .LBB2_5
	j	.LBB2_7
.LBB2_3:                                # %if.then
	lui	lui4, %hi(r)
	lh	r, %lo(r)(lui4)
	lui	lui5, %hi(i)
	lh	i_3, %lo(i)(lui5)
	lui	lui6, %hi(r)
	sw	i_3, %lo(r)(lui6)
	lui	lui7, %hi(c)
	lh	c, %lo(c)(lui7)
	lui	lui8, %hi(j)
	lh	j_3, %lo(j)(lui8)
	lui	lui9, %hi(c)
	sw	j_3, %lo(c)(lui9)
	j	.LBB2_4
.LBB2_4:                                # %if.end
	j	.LBB2_6
.LBB2_5:                                # %for.body
	lui	lui10, %hi(n)
	lh	n, %lo(n)(lui10)
	call	_getInt$$YGHXZ
	mv	funcCallRet, a0
	lui	lui11, %hi(n)
	sw	funcCallRet, %lo(n)(lui11)
	lui	lui12, %hi(n)
	lh	n_2, %lo(n)(lui12)
	li	constInt1, 1
	beq	n_2, constInt1, .LBB2_3
	j	.LBB2_4
.LBB2_6:                                # %for.inc
	lui	lui13, %hi(j)
	lh	j_4, %lo(j)(lui13)
	addi	postfix_inc, j_4, 1
	lui	lui14, %hi(j)
	sw	postfix_inc, %lo(j)(lui14)
	j	.LBB2_2
.LBB2_7:                                # %for.end
	j	.LBB2_9
.LBB2_8:                                # %for.body_2
	lui	lui15, %hi(j)
	lh	j, %lo(j)(lui15)
	lui	lui16, %hi(j)
	sw	zero, %lo(j)(lui16)
	j	.LBB2_2
.LBB2_9:                                # %for.inc_2
	lui	lui17, %hi(i)
	lh	i_4, %lo(i)(lui17)
	addi	postfix_inc_2, i_4, 1
	lui	lui18, %hi(i)
	sw	postfix_inc_2, %lo(i)(lui18)
	j	.LBB2_1
.LBB2_10:                               # %for.end_2
	lui	lui19, %hi(r)
	lh	r_2, %lo(r)(lui19)
	li	constInt2, 2
	sub	sub, constInt2, r_2
	mv	a0, sub
	call	_abs$$YGHH$Z
	mv	funcCallRet_2, a0
	lui	lui20, %hi(c)
	lh	c_2, %lo(c)(lui20)
	sub	sub_2, constInt2, c_2
	mv	a0, sub_2
	call	_abs$$YGHH$Z
	mv	funcCallRet_3, a0
	add	add, funcCallRet_2, funcCallRet_3
	mv	a0, add
	call	_printInt$$YGXH$Z
	sw	zero, 0(retval)
	j	.LBB2_11
.LBB2_11:                               # %return
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
	addi	sp, sp, 0
	ret
                                        # -- End function


	.section	.sdata,"aw",@progbits
	.globl	r
	.p2align	2
r:
	.word	0                       # 0

	.globl	c
	.p2align	2
c:
	.word	0                       # 0

	.globl	i
	.p2align	2
i:
	.word	0                       # 0

	.globl	j
	.p2align	2
j:
	.word	0                       # 0

	.globl	n
	.p2align	2
n:
	.word	0                       # 0

