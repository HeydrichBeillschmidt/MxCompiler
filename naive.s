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

	.globl	_qpow$$YGHHHH$Z         # -- Begin function _qpow$$YGHHHH$Z
	.p2align	2
_qpow$$YGHHHH$Z:                        # @_qpow$$YGHHHH$Z
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
	mv	a, a0
	mv	p, a1
	mv	mod, a2
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_6, a0
	mv	y.addr, malloc_6
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_5, a0
	mv	t.addr, malloc_5
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	a.addr, malloc_2
	sw	a, 0(a.addr)
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_3, a0
	mv	p.addr, malloc_3
	sw	p, 0(p.addr)
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_4, a0
	mv	mod.addr, malloc_4
	sw	mod, 0(mod.addr)
	li	constInt1, 1
	sw	constInt1, 0(t.addr)
	lh	a_2, 0(a.addr)
	sw	a_2, 0(y.addr)
	j	.LBB1_1
.LBB1_1:                                # %while.cond
	lh	p_2, 0(p.addr)
	bgt	p_2, zero, .LBB1_4
	j	.LBB1_5
.LBB1_2:                                # %if.then
	lh	t, 0(t.addr)
	lh	t_2, 0(t.addr)
	lh	y, 0(y.addr)
	mul	mul, t_2, y
	lh	mod_2, 0(mod.addr)
	rem	srem, mul, mod_2
	sw	srem, 0(t.addr)
	j	.LBB1_3
.LBB1_3:                                # %if.end
	lh	y_2, 0(y.addr)
	lh	y_3, 0(y.addr)
	lh	y_4, 0(y.addr)
	mul	mul_2, y_3, y_4
	lh	mod_3, 0(mod.addr)
	rem	srem_2, mul_2, mod_3
	sw	srem_2, 0(y.addr)
	lh	p_4, 0(p.addr)
	lh	p_5, 0(p.addr)
	li	constInt2, 2
	div	sdiv, p_5, constInt2
	sw	sdiv, 0(p.addr)
	j	.LBB1_1
.LBB1_4:                                # %while.body
	lh	p_3, 0(p.addr)
	andi	bitwise_and, p_3, 1
	beq	bitwise_and, constInt1, .LBB1_2
	j	.LBB1_3
.LBB1_5:                                # %while.end
	lh	t_3, 0(t.addr)
	sw	t_3, 0(retval)
	j	.LBB1_6
.LBB1_6:                                # %return
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
	mv	malloc, a0
	mv	retval, malloc
	li	constInt1, 2
	mv	a0, constInt1
	li	constInt2, 10
	mv	a1, constInt2
	li	constInt3, 10000
	mv	a2, constInt3
	call	_qpow$$YGHHHH$Z
	mv	funcCallRet_2, a0
	mv	a0, funcCallRet_2
	call	_toString$$YGPADH$Z
	mv	funcCallRet, a0
	mv	a0, funcCallRet
	call	_println$$YGXPAD$Z
	sw	zero, 0(retval)
	j	.LBB2_1
.LBB2_1:                                # %return
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
