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
	li	constInt, 32
	slli	sizeTmp, constInt, 2
	addi	size, sizeTmp, 4
	mv	a0, size
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	mallocInt32Ptr, malloc
	li	constInt1, 4
	sw	constInt1, 0(mallocInt32Ptr)
	addi	arrayHeadPtrUnguarded, mallocInt32Ptr, 4
	mv	arrayHeadPtr, arrayHeadPtrUnguarded
	lui	lui, %hi(a)
	sw	arrayHeadPtr, %lo(a)(lui)
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
	mv	malloc_4, a0
	mv	i.addr, malloc_4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	b.addr, malloc_2
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	slli	sizeTmp, constInt, 2
	addi	size, sizeTmp, 4
	mv	a0, size
	call	_malloc$$YGPADH$Z
	mv	malloc_3, a0
	mv	mallocInt32Ptr, malloc_3
	sw	constInt1, 0(mallocInt32Ptr)
	addi	arrayHeadPtrUnguarded, mallocInt32Ptr, 4
	mv	arrayHeadPtr, arrayHeadPtrUnguarded
	sw	arrayHeadPtr, 0(b.addr)
	lh	b, 0(b.addr)
	addi	elementPtr, b, 0
	lh	arrayElement, 0(elementPtr)
	lui	lui, %hi(a)
	lh	a, %lo(a)(lui)
	sw	a, 0(elementPtr)
	lh	b_2, 0(b.addr)
	addi	elementPtr_2, b_2, 4
	lh	arrayElement_2, 0(elementPtr_2)
	lui	lui1, %hi(a)
	lh	a_2, %lo(a)(lui1)
	sw	a_2, 0(elementPtr_2)
	lh	b_3, 0(b.addr)
	addi	elementPtr_3, b_3, 8
	lh	arrayElement_3, 0(elementPtr_3)
	lui	lui2, %hi(a)
	lh	a_3, %lo(a)(lui2)
	sw	a_3, 0(elementPtr_3)
	lh	b_4, 0(b.addr)
	addi	elementPtr_4, b_4, 12
	lh	arrayElement_4, 0(elementPtr_4)
	lui	lui3, %hi(a)
	lh	a_4, %lo(a)(lui3)
	sw	a_4, 0(elementPtr_4)
	lh	b_5, 0(b.addr)
	mv	castToIntPtr, b_5
	addi	arrayElemPtr, castToIntPtr, -4
	lh	arraySize, 0(arrayElemPtr)
	mv	a0, arraySize
	call	_toString$$YGPADH$Z
	mv	funcCallRet, a0
	mv	a0, funcCallRet
	call	_println$$YGXPAD$Z
	lh	i, 0(i.addr)
	sw	zero, 0(i.addr)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
	lh	i_2, 0(i.addr)
	lh	b_6, 0(b.addr)
	addi	elementPtr_5, b_6, 0
	lh	arrayElement_5, 0(elementPtr_5)
	addi	arrayElemPtr_2, arrayElement_5, -4
	lh	arraySize_2, 0(arrayElemPtr_2)
	blt	i_2, arraySize_2, .LBB1_2
	j	.LBB1_4
.LBB1_2:                                # %for.body
	lh	b_7, 0(b.addr)
	addi	elementPtr_6, b_7, 0
	lh	arrayElement_6, 0(elementPtr_6)
	lh	i_3, 0(i.addr)
	slli	mul, i_3, 2
	add	elementPtr_7, arrayElement_6, mul
	lh	arrayElement_7, 0(elementPtr_7)
	call	_getInt$$YGHXZ
	mv	funcCallRet_2, a0
	sw	funcCallRet_2, 0(elementPtr_7)
	j	.LBB1_3
.LBB1_3:                                # %for.inc
	lh	i_4, 0(i.addr)
	addi	postfix_inc, i_4, 1
	sw	postfix_inc, 0(i.addr)
	j	.LBB1_1
.LBB1_4:                                # %for.end
	lh	i_5, 0(i.addr)
	sw	zero, 0(i.addr)
	j	.LBB1_5
.LBB1_5:                                # %for.cond_2
	lh	i_6, 0(i.addr)
	lh	b_8, 0(b.addr)
	addi	elementPtr_8, b_8, 4
	lh	arrayElement_8, 0(elementPtr_8)
	addi	arrayElemPtr_3, arrayElement_8, -4
	lh	arraySize_3, 0(arrayElemPtr_3)
	blt	i_6, arraySize_3, .LBB1_6
	j	.LBB1_8
.LBB1_6:                                # %for.body_2
	lh	b_9, 0(b.addr)
	addi	elementPtr_9, b_9, 4
	lh	arrayElement_9, 0(elementPtr_9)
	lh	i_7, 0(i.addr)
	slli	mul1, i_7, 2
	add	elementPtr_10, arrayElement_9, mul1
	lh	arrayElement_10, 0(elementPtr_10)
	mv	a0, arrayElement_10
	call	_toString$$YGPADH$Z
	mv	funcCallRet_3, a0
	mv	a0, funcCallRet_3
	call	_print$$YGXPAD$Z
	j	.LBB1_7
.LBB1_7:                                # %for.inc_2
	lh	i_8, 0(i.addr)
	addi	postfix_inc_2, i_8, 1
	sw	postfix_inc_2, 0(i.addr)
	j	.LBB1_5
.LBB1_8:                                # %for.end_2
	la	__const.main.str0, __const.main.str0
	mv	a0, __const.main.str0
	call	_println$$YGXPAD$Z
	lh	i_9, 0(i.addr)
	sw	zero, 0(i.addr)
	j	.LBB1_9
.LBB1_9:                                # %for.cond_3
	lh	i_10, 0(i.addr)
	lh	b_10, 0(b.addr)
	addi	elementPtr_11, b_10, 8
	lh	arrayElement_11, 0(elementPtr_11)
	addi	arrayElemPtr_4, arrayElement_11, -4
	lh	arraySize_4, 0(arrayElemPtr_4)
	blt	i_10, arraySize_4, .LBB1_10
	j	.LBB1_12
.LBB1_10:                               # %for.body_3
	lh	b_11, 0(b.addr)
	addi	elementPtr_12, b_11, 8
	lh	arrayElement_12, 0(elementPtr_12)
	lh	i_11, 0(i.addr)
	slli	mul2, i_11, 2
	add	elementPtr_13, arrayElement_12, mul2
	lh	arrayElement_13, 0(elementPtr_13)
	sw	zero, 0(elementPtr_13)
	j	.LBB1_11
.LBB1_11:                               # %for.inc_3
	lh	i_12, 0(i.addr)
	addi	postfix_inc_3, i_12, 1
	sw	postfix_inc_3, 0(i.addr)
	j	.LBB1_9
.LBB1_12:                               # %for.end_3
	lh	i_13, 0(i.addr)
	sw	zero, 0(i.addr)
	j	.LBB1_13
.LBB1_13:                               # %for.cond_4
	lh	i_14, 0(i.addr)
	lh	b_12, 0(b.addr)
	addi	elementPtr_14, b_12, 12
	lh	arrayElement_14, 0(elementPtr_14)
	addi	arrayElemPtr_5, arrayElement_14, -4
	lh	arraySize_5, 0(arrayElemPtr_5)
	blt	i_14, arraySize_5, .LBB1_14
	j	.LBB1_16
.LBB1_14:                               # %for.body_4
	lh	b_13, 0(b.addr)
	addi	elementPtr_15, b_13, 12
	lh	arrayElement_15, 0(elementPtr_15)
	lh	i_15, 0(i.addr)
	slli	mul3, i_15, 2
	add	elementPtr_16, arrayElement_15, mul3
	lh	arrayElement_16, 0(elementPtr_16)
	mv	a0, arrayElement_16
	call	_toString$$YGPADH$Z
	mv	funcCallRet_4, a0
	mv	a0, funcCallRet_4
	call	_print$$YGXPAD$Z
	j	.LBB1_15
.LBB1_15:                               # %for.inc_4
	lh	i_16, 0(i.addr)
	addi	postfix_inc_4, i_16, 1
	sw	postfix_inc_4, 0(i.addr)
	j	.LBB1_13
.LBB1_16:                               # %for.end_4
	sw	zero, 0(retval)
	j	.LBB1_17
.LBB1_17:                               # %return
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
	.globl	a
	.p2align	2
a:
	.word	0                       # 0

	.globl	__const.main.str0
__const.main.str0:
	.asciz	""

