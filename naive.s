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
	li	constInt, 4
	slli	sizeTmp, constInt, 2
	addi	size, sizeTmp, 4
	mv	a0, size
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	mallocInt32Ptr, malloc
	sw	constInt, 0(mallocInt32Ptr)
	addi	arrayHeadPtrUnguarded, mallocInt32Ptr, 4
	mv	arrayHeadPtr, arrayHeadPtrUnguarded
	lui	lui, %hi(a)
	sw	arrayHeadPtr, %lo(a)(lui)
	li	constInt1, 5
	slli	sizeTmp_2, constInt1, 2
	addi	size_2, sizeTmp_2, 4
	mv	a0, size_2
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	mallocInt32Ptr_2, malloc_2
	sw	constInt1, 0(mallocInt32Ptr_2)
	addi	arrayHeadPtrUnguarded_2, mallocInt32Ptr_2, 4
	mv	arrayHeadPtr_2, arrayHeadPtrUnguarded_2
	lui	lui1, %hi(b)
	sw	arrayHeadPtr_2, %lo(b)(lui1)
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

	.globl	_printNum$$YGXH$Z       # -- Begin function _printNum$$YGXH$Z
	.p2align	2
_printNum$$YGXH$Z:                      # @_printNum$$YGXH$Z
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
	mv	num, a0
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	num.addr, malloc
	sw	num, 0(num.addr)
	lw	num_2, 0(num.addr)
	mv	a0, num_2
	call	_toString$$YGPADH$Z
	mv	funcCallRet, a0
	mv	a0, funcCallRet
	call	_println$$YGXPAD$Z
	j	.LBB1_1
.LBB1_1:                                # %return
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
	lui	lui, %hi(i)
	lw	i, %lo(i)(lui)
	lui	lui1, %hi(i)
	sw	zero, %lo(i)(lui1)
	j	.LBB2_1
.LBB2_1:                                # %for.cond
	lui	lui2, %hi(i)
	lw	i_2, %lo(i)(lui2)
	li	constInt1, 4
	blt	i_2, constInt1, .LBB2_2
	j	.LBB2_4
.LBB2_2:                                # %for.body
	lui	lui3, %hi(a)
	lw	a, %lo(a)(lui3)
	lui	lui4, %hi(i)
	lw	i_3, %lo(i)(lui4)
	slli	mul1, i_3, 2
	add	elementPtr, a, mul1
	lw	arrayElement, 0(elementPtr)
	li	constInt2, 11
	slli	sizeTmp, constInt2, 2
	addi	size, sizeTmp, 4
	mv	a0, size
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	mallocInt32Ptr, malloc_2
	sw	constInt2, 0(mallocInt32Ptr)
	addi	arrayHeadPtrUnguarded, mallocInt32Ptr, 4
	mv	arrayHeadPtr, arrayHeadPtrUnguarded
	sw	arrayHeadPtr, 0(elementPtr)
	j	.LBB2_3
.LBB2_3:                                # %for.inc
	lui	lui5, %hi(i)
	lw	i_4, %lo(i)(lui5)
	addi	postfix_inc, i_4, 1
	lui	lui6, %hi(i)
	sw	postfix_inc, %lo(i)(lui6)
	j	.LBB2_1
.LBB2_4:                                # %for.end
	lui	lui7, %hi(i)
	lw	i_5, %lo(i)(lui7)
	lui	lui8, %hi(i)
	sw	zero, %lo(i)(lui8)
	j	.LBB2_5
.LBB2_5:                                # %for.cond_2
	lui	lui9, %hi(i)
	lw	i_6, %lo(i)(lui9)
	li	constInt3, 4
	blt	i_6, constInt3, .LBB2_10
	j	.LBB2_12
.LBB2_6:                                # %for.cond_3
	lui	lui10, %hi(j)
	lw	j_2, %lo(j)(lui10)
	li	constInt4, 10
	blt	j_2, constInt4, .LBB2_7
	j	.LBB2_9
.LBB2_7:                                # %for.body_2
	lui	lui11, %hi(a)
	lw	a_2, %lo(a)(lui11)
	lui	lui12, %hi(i)
	lw	i_7, %lo(i)(lui12)
	slli	mul2, i_7, 2
	add	elementPtr_2, a_2, mul2
	lw	arrayElement_2, 0(elementPtr_2)
	lui	lui13, %hi(j)
	lw	j_3, %lo(j)(lui13)
	slli	mul3, j_3, 2
	add	elementPtr_3, arrayElement_2, mul3
	lw	arrayElement_3, 0(elementPtr_3)
	li	constInt5, 888
	sw	constInt5, 0(elementPtr_3)
	j	.LBB2_8
.LBB2_8:                                # %for.inc_2
	lui	lui14, %hi(j)
	lw	j_4, %lo(j)(lui14)
	addi	postfix_inc_2, j_4, 1
	lui	lui15, %hi(j)
	sw	postfix_inc_2, %lo(j)(lui15)
	j	.LBB2_6
.LBB2_9:                                # %for.end_2
	j	.LBB2_11
.LBB2_10:                               # %for.body_3
	lui	lui16, %hi(j)
	lw	j, %lo(j)(lui16)
	lui	lui17, %hi(j)
	sw	zero, %lo(j)(lui17)
	j	.LBB2_6
.LBB2_11:                               # %for.inc_3
	lui	lui18, %hi(i)
	lw	i_8, %lo(i)(lui18)
	addi	postfix_inc_3, i_8, 1
	lui	lui19, %hi(i)
	sw	postfix_inc_3, %lo(i)(lui19)
	j	.LBB2_5
.LBB2_12:                               # %for.end_3
	lui	lui20, %hi(i)
	lw	i_9, %lo(i)(lui20)
	lui	lui21, %hi(i)
	sw	zero, %lo(i)(lui21)
	j	.LBB2_13
.LBB2_13:                               # %for.cond_4
	lui	lui22, %hi(i)
	lw	i_10, %lo(i)(lui22)
	li	constInt6, 5
	blt	i_10, constInt6, .LBB2_14
	j	.LBB2_16
.LBB2_14:                               # %for.body_4
	lui	lui23, %hi(b)
	lw	b, %lo(b)(lui23)
	lui	lui24, %hi(i)
	lw	i_11, %lo(i)(lui24)
	slli	mul4, i_11, 2
	add	elementPtr_4, b, mul4
	lw	arrayElement_4, 0(elementPtr_4)
	li	constInt7, 8
	mv	a0, constInt7
	call	_malloc$$YGPADH$Z
	mv	malloc_3, a0
	mv	castToClassPtr, malloc_3
	sw	castToClassPtr, 0(elementPtr_4)
	lui	lui25, %hi(b)
	lw	b_2, %lo(b)(lui25)
	lui	lui26, %hi(i)
	lw	i_12, %lo(i)(lui26)
	slli	mul5, i_12, 2
	add	elementPtr_5, b_2, mul5
	lw	arrayElement_5, 0(elementPtr_5)
	lw	rec.num, 0(arrayElement_5)
	addi	prefix_neg, zero, -1
	sw	prefix_neg, 0(arrayElement_5)
	j	.LBB2_15
.LBB2_15:                               # %for.inc_4
	lui	lui27, %hi(i)
	lw	i_13, %lo(i)(lui27)
	addi	postfix_inc_4, i_13, 1
	lui	lui28, %hi(i)
	sw	postfix_inc_4, %lo(i)(lui28)
	j	.LBB2_13
.LBB2_16:                               # %for.end_4
	lui	lui29, %hi(i)
	lw	i_14, %lo(i)(lui29)
	lui	lui30, %hi(i)
	sw	zero, %lo(i)(lui30)
	j	.LBB2_17
.LBB2_17:                               # %for.cond_5
	lui	lui31, %hi(i)
	lw	i_15, %lo(i)(lui31)
	li	constInt8, 5
	blt	i_15, constInt8, .LBB2_18
	j	.LBB2_20
.LBB2_18:                               # %for.body_5
	lui	lui32, %hi(b)
	lw	b_3, %lo(b)(lui32)
	lui	lui33, %hi(i)
	lw	i_16, %lo(i)(lui33)
	slli	mul6, i_16, 2
	add	elementPtr_6, b_3, mul6
	lw	arrayElement_6, 0(elementPtr_6)
	lw	rec.num_2, 0(arrayElement_6)
	mv	a0, rec.num_2
	call	_printNum$$YGXH$Z
	j	.LBB2_19
.LBB2_19:                               # %for.inc_5
	lui	lui34, %hi(i)
	lw	i_17, %lo(i)(lui34)
	addi	postfix_inc_5, i_17, 1
	lui	lui35, %hi(i)
	sw	postfix_inc_5, %lo(i)(lui35)
	j	.LBB2_17
.LBB2_20:                               # %for.end_5
	lui	lui36, %hi(a)
	lw	a_3, %lo(a)(lui36)
	addi	elementPtr_7, a_3, 12
	lw	arrayElement_7, 0(elementPtr_7)
	addi	elementPtr_8, arrayElement_7, 36
	lw	arrayElement_8, 0(elementPtr_8)
	mv	a0, arrayElement_8
	call	_printNum$$YGXH$Z
	lui	lui37, %hi(i)
	lw	i_18, %lo(i)(lui37)
	lui	lui38, %hi(i)
	sw	zero, %lo(i)(lui38)
	j	.LBB2_21
.LBB2_21:                               # %for.cond_6
	lui	lui39, %hi(i)
	lw	i_19, %lo(i)(lui39)
	li	constInt9, 3
	ble	i_19, constInt9, .LBB2_26
	j	.LBB2_28
.LBB2_22:                               # %for.cond_7
	lui	lui40, %hi(j)
	lw	j_6, %lo(j)(lui40)
	li	constInt10, 9
	ble	j_6, constInt10, .LBB2_23
	j	.LBB2_25
.LBB2_23:                               # %for.body_6
	lui	lui41, %hi(a)
	lw	a_4, %lo(a)(lui41)
	lui	lui42, %hi(i)
	lw	i_20, %lo(i)(lui42)
	slli	mul7, i_20, 2
	add	elementPtr_9, a_4, mul7
	lw	arrayElement_9, 0(elementPtr_9)
	lui	lui43, %hi(j)
	lw	j_7, %lo(j)(lui43)
	slli	mul8, j_7, 2
	add	elementPtr_10, arrayElement_9, mul8
	lw	arrayElement_10, 0(elementPtr_10)
	lui	lui44, %hi(i)
	lw	i_21, %lo(i)(lui44)
	li	constInt11, 10
	mul	mul, i_21, constInt11
	lui	lui45, %hi(j)
	lw	j_8, %lo(j)(lui45)
	add	add, mul, j_8
	sw	add, 0(elementPtr_10)
	j	.LBB2_24
.LBB2_24:                               # %for.inc_6
	lui	lui46, %hi(j)
	lw	j_9, %lo(j)(lui46)
	addi	postfix_inc_6, j_9, 1
	lui	lui47, %hi(j)
	sw	postfix_inc_6, %lo(j)(lui47)
	j	.LBB2_22
.LBB2_25:                               # %for.end_6
	j	.LBB2_27
.LBB2_26:                               # %for.body_7
	lui	lui48, %hi(j)
	lw	j_5, %lo(j)(lui48)
	lui	lui49, %hi(j)
	sw	zero, %lo(j)(lui49)
	j	.LBB2_22
.LBB2_27:                               # %for.inc_7
	lui	lui50, %hi(i)
	lw	i_22, %lo(i)(lui50)
	addi	postfix_inc_7, i_22, 1
	lui	lui51, %hi(i)
	sw	postfix_inc_7, %lo(i)(lui51)
	j	.LBB2_21
.LBB2_28:                               # %for.end_7
	lui	lui52, %hi(i)
	lw	i_23, %lo(i)(lui52)
	lui	lui53, %hi(i)
	sw	zero, %lo(i)(lui53)
	j	.LBB2_29
.LBB2_29:                               # %for.cond_8
	lui	lui54, %hi(i)
	lw	i_24, %lo(i)(lui54)
	li	constInt12, 3
	ble	i_24, constInt12, .LBB2_34
	j	.LBB2_36
.LBB2_30:                               # %for.cond_9
	lui	lui55, %hi(j)
	lw	j_11, %lo(j)(lui55)
	li	constInt13, 9
	ble	j_11, constInt13, .LBB2_31
	j	.LBB2_33
.LBB2_31:                               # %for.body_8
	lui	lui56, %hi(a)
	lw	a_5, %lo(a)(lui56)
	lui	lui57, %hi(i)
	lw	i_25, %lo(i)(lui57)
	slli	mul9, i_25, 2
	add	elementPtr_11, a_5, mul9
	lw	arrayElement_11, 0(elementPtr_11)
	lui	lui58, %hi(j)
	lw	j_12, %lo(j)(lui58)
	slli	mul10, j_12, 2
	add	elementPtr_12, arrayElement_11, mul10
	lw	arrayElement_12, 0(elementPtr_12)
	mv	a0, arrayElement_12
	call	_printNum$$YGXH$Z
	j	.LBB2_32
.LBB2_32:                               # %for.inc_8
	lui	lui59, %hi(j)
	lw	j_13, %lo(j)(lui59)
	addi	postfix_inc_8, j_13, 1
	lui	lui60, %hi(j)
	sw	postfix_inc_8, %lo(j)(lui60)
	j	.LBB2_30
.LBB2_33:                               # %for.end_8
	j	.LBB2_35
.LBB2_34:                               # %for.body_9
	lui	lui61, %hi(j)
	lw	j_10, %lo(j)(lui61)
	lui	lui62, %hi(j)
	sw	zero, %lo(j)(lui62)
	j	.LBB2_30
.LBB2_35:                               # %for.inc_9
	lui	lui63, %hi(i)
	lw	i_26, %lo(i)(lui63)
	addi	postfix_inc_9, i_26, 1
	lui	lui64, %hi(i)
	sw	postfix_inc_9, %lo(i)(lui64)
	j	.LBB2_29
.LBB2_36:                               # %for.end_9
	lui	lui65, %hi(a)
	lw	a_6, %lo(a)(lui65)
	addi	elementPtr_13, a_6, 8
	lw	arrayElement_13, 0(elementPtr_13)
	addi	elementPtr_14, arrayElement_13, 40
	lw	arrayElement_14, 0(elementPtr_14)
	sw	zero, 0(elementPtr_14)
	lui	lui66, %hi(a)
	lw	a_7, %lo(a)(lui66)
	addi	elementPtr_15, a_7, 8
	lw	arrayElement_15, 0(elementPtr_15)
	addi	elementPtr_16, arrayElement_15, 40
	lw	arrayElement_16, 0(elementPtr_16)
	mv	a0, arrayElement_16
	call	_printNum$$YGXH$Z
	lui	lui67, %hi(b)
	lw	b_4, %lo(b)(lui67)
	addi	elementPtr_17, b_4, 0
	lw	arrayElement_17, 0(elementPtr_17)
	lw	rec.num_3, 0(arrayElement_17)
	addi	prefix_neg_2, zero, -2
	sw	prefix_neg_2, 0(arrayElement_17)
	lui	lui68, %hi(b)
	lw	b_5, %lo(b)(lui68)
	lui	lui69, %hi(a)
	lw	a_8, %lo(a)(lui69)
	addi	elementPtr_18, a_8, 8
	lw	arrayElement_18, 0(elementPtr_18)
	addi	elementPtr_19, arrayElement_18, 40
	lw	arrayElement_19, 0(elementPtr_19)
	slli	mul11, arrayElement_19, 2
	add	elementPtr_20, b_5, mul11
	lw	arrayElement_20, 0(elementPtr_20)
	lw	rec.num_4, 0(arrayElement_20)
	addi	prefix_neg_3, zero, -10
	sw	prefix_neg_3, 0(arrayElement_20)
	lui	lui70, %hi(b)
	lw	b_6, %lo(b)(lui70)
	addi	elementPtr_21, b_6, 0
	lw	arrayElement_21, 0(elementPtr_21)
	lw	rec.num_5, 0(arrayElement_21)
	mv	a0, rec.num_5
	call	_printNum$$YGXH$Z
	lui	lui71, %hi(b)
	lw	b_7, %lo(b)(lui71)
	addi	elementPtr_22, b_7, 4
	lw	arrayElement_22, 0(elementPtr_22)
	lw	rec.num_6, 0(arrayElement_22)
	mv	a0, rec.num_6
	call	_printNum$$YGXH$Z
	sw	zero, 0(retval)
	j	.LBB2_37
.LBB2_37:                               # %return
	lw	returnValue, 0(retval)
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
	.globl	a
	.p2align	2
a:
	.word	0                       # 0

	.globl	b
	.p2align	2
b:
	.word	0                       # 0

	.globl	i
	.p2align	2
i:
	.word	0                       # 0

	.globl	j
	.p2align	2
j:
	.word	0                       # 0

