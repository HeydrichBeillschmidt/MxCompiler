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

	.globl	_work$$YGXPADUTA$$$Z    # -- Begin function _work$$YGXPADUTA$$$Z
	.p2align	2
_work$$YGXPADUTA$$$Z:                   # @_work$$YGXPADUTA$$$Z
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
	mv	st, a0
	mv	ta, a1
	li	constInt, 4
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	st.addr, malloc
	sw	st, 0(st.addr)
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	ta.addr, malloc_2
	sw	ta, 0(ta.addr)
	lh	ta_2, 0(ta.addr)
	lh	TA.anger, 4(ta_2)
	li	constInt1, 100
	ble	TA.anger, constInt1, .LBB1_1
	j	.LBB1_2
.LBB1_1:                                # %if.then
	lh	st_2, 0(st.addr)
	la	__const._work$$YGXPADUTA$$$Z.str0, __const._work$$YGXPADUTA$$$Z.str0
	mv	a0, st_2
	mv	a1, __const._work$$YGXPADUTA$$$Z.str0
	call	_strcat$$YGPADPADPAD$Z
	mv	add, a0
	lh	ta_3, 0(ta.addr)
	addi	TA.state.addr, ta_3, 0
	lh	TA.state, 0(TA.state.addr)
	mv	a0, add
	mv	a1, TA.state
	call	_strcat$$YGPADPADPAD$Z
	mv	add_2, a0
	la	__const._work$$YGXPADUTA$$$Z.str1, __const._work$$YGXPADUTA$$$Z.str1
	mv	a0, add_2
	mv	a1, __const._work$$YGXPADUTA$$$Z.str1
	call	_strcat$$YGPADPADPAD$Z
	mv	add_3, a0
	mv	a0, add_3
	call	_println$$YGXPAD$Z
	j	.LBB1_3
.LBB1_2:                                # %if.else
	lh	st_3, 0(st.addr)
	la	__const._work$$YGXPADUTA$$$Z.str2, __const._work$$YGXPADUTA$$$Z.str0
	mv	a0, st_3
	mv	a1, __const._work$$YGXPADUTA$$$Z.str2
	call	_strcat$$YGPADPADPAD$Z
	mv	add_4, a0
	lh	ta_4, 0(ta.addr)
	addi	TA.state.addr_2, ta_4, 0
	lh	TA.state_2, 0(TA.state.addr_2)
	mv	a0, add_4
	mv	a1, TA.state_2
	call	_strcat$$YGPADPADPAD$Z
	mv	add_5, a0
	la	__const._work$$YGXPADUTA$$$Z.str2_2, __const._work$$YGXPADUTA$$$Z.str2
	mv	a0, add_5
	mv	a1, __const._work$$YGXPADUTA$$$Z.str2_2
	call	_strcat$$YGPADPADPAD$Z
	mv	add_6, a0
	mv	a0, add_6
	call	_println$$YGXPAD$Z
	j	.LBB1_3
.LBB1_3:                                # %if.end
	lh	ta_5, 0(ta.addr)
	lh	TA.anger_2, 4(ta_5)
	lh	ta_6, 0(ta.addr)
	lh	TA.anger_3, 4(ta_6)
	lui	lui, %hi(work_anger)
	lh	work_anger, %lo(work_anger)(lui)
	add	add_7, TA.anger_3, work_anger
	sw	add_7, 4(ta_5)
	j	.LBB1_4
.LBB1_4:                                # %return
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
	mv	malloc_3, a0
	mv	mars.addr, malloc_3
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc_2, a0
	mv	mr.addr, malloc_2
	mv	a0, constInt
	call	_malloc$$YGPADH$Z
	mv	malloc, a0
	mv	retval, malloc
	lh	mr, 0(mr.addr)
	li	constInt1, 8
	mv	a0, constInt1
	call	_malloc$$YGPADH$Z
	mv	malloc_4, a0
	mv	castToClassPtr, malloc_4
	sw	castToClassPtr, 0(mr.addr)
	lh	mr_2, 0(mr.addr)
	addi	TA.state.addr, mr_2, 0
	lh	TA.state, 0(TA.state.addr)
	la	__const.main.str3, __const.main.str3
	sw	__const.main.str3, 0(TA.state.addr)
	lh	mr_3, 0(mr.addr)
	lh	TA.anger, 4(mr_3)
	sw	zero, 4(mr_3)
	lh	mars, 0(mars.addr)
	mv	a0, constInt1
	call	_malloc$$YGPADH$Z
	mv	malloc_5, a0
	mv	castToClassPtr_2, malloc_5
	sw	castToClassPtr_2, 0(mars.addr)
	lh	mars_2, 0(mars.addr)
	addi	TA.state.addr_2, mars_2, 0
	lh	TA.state_2, 0(TA.state.addr_2)
	la	__const.main.str4, __const.main.str4
	sw	__const.main.str4, 0(TA.state.addr_2)
	lh	mars_3, 0(mars.addr)
	lh	TA.anger_2, 4(mars_3)
	lui	lui, %hi(init_anger)
	lh	init_anger, %lo(init_anger)(lui)
	sw	init_anger, 4(mars_3)
	la	__const.main.str5, __const.main.str5
	lh	mr_4, 0(mr.addr)
	mv	a0, __const.main.str5
	mv	a1, mr_4
	call	_work$$YGXPADUTA$$$Z
	la	__const.main.str6, __const.main.str6
	lh	mars_4, 0(mars.addr)
	mv	a0, __const.main.str6
	mv	a1, mars_4
	call	_work$$YGXPADUTA$$$Z
	la	__const.main.str7, __const.main.str6
	lh	mars_5, 0(mars.addr)
	mv	a0, __const.main.str7
	mv	a1, mars_5
	call	_work$$YGXPADUTA$$$Z
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
	.globl	init_anger
	.p2align	2
init_anger:
	.word	100                     # 100

	.globl	__const._work$$YGXPADUTA$$$Z.str0
__const._work$$YGXPADUTA$$$Z.str0:
	.asciz	", "

	.globl	__const._work$$YGXPADUTA$$$Z.str1
__const._work$$YGXPADUTA$$$Z.str1:
	.asciz	" enjoys this work. XD"

	.globl	__const.main.str6
__const.main.str6:
	.asciz	"Mars"

	.globl	__const._work$$YGXPADUTA$$$Z.str2
__const._work$$YGXPADUTA$$$Z.str2:
	.asciz	" wants to give up!!!!!"

	.globl	__const.main.str5
__const.main.str5:
	.asciz	"MR"

	.globl	work_anger
	.p2align	2
work_anger:
	.word	10                      # 10

	.globl	__const.main.str4
__const.main.str4:
	.asciz	"the striking TA"

	.globl	__const.main.str3
__const.main.str3:
	.asciz	"the leading TA"

