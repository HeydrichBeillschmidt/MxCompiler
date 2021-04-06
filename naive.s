	.text
	.global	___init__$$YGXXZ        # -- Begin function___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
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
	.global	main                    # -- Begin functionmain
	.p2align	2
	.type	main,@function
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
	mv	, a0
	lui	lui, %hi(w)
	lh	w, %lo(w)(lui)
	call	_getInt$$YGHXZ
	lui	lui1, %hi(w)
	sw	funcCallRet, %lo(w)(lui1)
	lui	lui2, %hi(w)
	lh	w_2, %lo(w)(lui2)
	li	constInt, 2
	rem	srem, w_2, constInt
	xori	xor, srem, 0
	seqz	eq, xor
	sb	eq, 0(logicalAnd_tmpAddr)
	beqz	eq, .LBB1_2
	j	.LBB1_1
.LBB1_1:                                # %logicalAnd_branch
	lui	lui3, %hi(w)
	lh	w_3, %lo(w)(lui3)
	slt	sgt, constInt, w_3
	sb	sgt, 0(logicalAnd_tmpAddr)
	j	.LBB1_2
.LBB1_2:                                # %logicalAnd_end
	lb	logical_and, 0(logicalAnd_tmpAddr)
	beqz	logical_and, .LBB1_4
	j	.LBB1_3
.LBB1_3:                                # %if.then
	la	__const.main.str0, __const.main.str0
	mv	a0, __const.main.str0
	call	_print$$YGXPAD$Z
	mv	, a0
	j	.LBB1_5
.LBB1_4:                                # %if.else
	la	__const.main.str1, __const.main.str1
	mv	a0, __const.main.str1
	call	_print$$YGXPAD$Z
	mv	, a0
	j	.LBB1_5
.LBB1_5:                                # %if.end
	sw	zero, 0(retval)
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
	addi	sp, sp, 0
	ret
                                        # -- End function
	.type	w,@object
	.section	.bss
	.global	w
	.p2align	2
w:
	.word	0                       # 0
	.size	w, 4

	.type	__const.main.str1,@object
	.section	.sdata
	.global	__const.main.str1
__const.main.str1:
	.asciz	"NO"
	.size	__const.main.str1, 3

	.type	__const.main.str0,@object
	.section	.sdata
	.global	__const.main.str0
__const.main.str0:
	.asciz	"YES"
	.size	__const.main.str0, 4

