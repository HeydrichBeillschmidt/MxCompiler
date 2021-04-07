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
	.globl	_work$$YGXPADUTA$$$Z    # -- Begin function _work$$YGXPADUTA$$$Z
	.p2align	2
	.type	_work$$YGXPADUTA$$$Z,@function
_work$$YGXPADUTA$$$Z:                   # @"_work$$YGXPADUTA$$$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	sw	s1, 4(sp)
	sw	s2, 0(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	mv	s0, a1
	mv	s2, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s1, a0
	sw	s2, 0(a0)
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s2, a0
	sw	s0, 0(a0)
	lw	a0, 4(s0)
	addi	a1, zero, 100
	blt	a1, a0, .LBB1_2
# %bb.1:                                # %if.then
	lw	a0, 0(s1)
	lui	a1, %hi(.L__const._work$$YGXPADUTA$$$Z.str0)
	addi	a1, a1, %lo(.L__const._work$$YGXPADUTA$$$Z.str0)
	call	_strcat$$YGPADPADPAD$Z
	lw	a1, 0(s2)
	lw	a1, 0(a1)
	call	_strcat$$YGPADPADPAD$Z
	lui	a1, %hi(.L__const._work$$YGXPADUTA$$$Z.str1)
	addi	a1, a1, %lo(.L__const._work$$YGXPADUTA$$$Z.str1)
	j	.LBB1_3
.LBB1_2:                                # %if.else
	lw	a0, 0(s1)
	lui	a1, %hi(.L__const._work$$YGXPADUTA$$$Z.str0)
	addi	a1, a1, %lo(.L__const._work$$YGXPADUTA$$$Z.str0)
	call	_strcat$$YGPADPADPAD$Z
	lw	a1, 0(s2)
	lw	a1, 0(a1)
	call	_strcat$$YGPADPADPAD$Z
	lui	a1, %hi(.L__const._work$$YGXPADUTA$$$Z.str2)
	addi	a1, a1, %lo(.L__const._work$$YGXPADUTA$$$Z.str2)
.LBB1_3:                                # %if.end
	call	_strcat$$YGPADPADPAD$Z
	call	_println$$YGXPAD$Z
	lw	a0, 0(s2)
	lw	a1, 4(a0)
	lui	a2, %hi(work_anger)
	lw	a2, %lo(work_anger)(a2)
	add	a1, a1, a2
	sw	a1, 4(a0)
	lw	s2, 0(sp)
	lw	s1, 4(sp)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	_work$$YGXPADUTA$$$Z, .Lfunc_end1-_work$$YGXPADUTA$$$Z
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
	sw	s1, 4(sp)
	sw	s2, 0(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	call	___init__$$YGXXZ
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s0, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s1, a0
	addi	a0, zero, 4
	call	_malloc$$YGPADH$Z
	mv	s2, a0
	addi	a0, zero, 8
	call	_malloc$$YGPADH$Z
	sw	a0, 0(s1)
	lui	a1, %hi(.L__const.main.str3)
	addi	a1, a1, %lo(.L__const.main.str3)
	sw	a1, 0(a0)
	lw	a0, 0(s1)
	sw	zero, 4(a0)
	addi	a0, zero, 8
	call	_malloc$$YGPADH$Z
	sw	a0, 0(s0)
	lui	a1, %hi(.L__const.main.str4)
	addi	a1, a1, %lo(.L__const.main.str4)
	sw	a1, 0(a0)
	lw	a0, 0(s0)
	lui	a1, %hi(init_anger)
	lw	a1, %lo(init_anger)(a1)
	sw	a1, 4(a0)
	lw	a1, 0(s1)
	lui	a0, %hi(.L__const.main.str5)
	addi	a0, a0, %lo(.L__const.main.str5)
	call	_work$$YGXPADUTA$$$Z
	lw	a1, 0(s0)
	lui	a0, %hi(.L__const.main.str6)
	addi	s1, a0, %lo(.L__const.main.str6)
	mv	a0, s1
	call	_work$$YGXPADUTA$$$Z
	lw	a1, 0(s0)
	mv	a0, s1
	call	_work$$YGXPADUTA$$$Z
	sw	zero, 0(s2)
	mv	a0, zero
	lw	s2, 0(sp)
	lw	s1, 4(sp)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
	.cfi_endproc
                                        # -- End function
	.type	init_anger,@object      # @init_anger
	.section	.sdata,"aw",@progbits
	.globl	init_anger
	.p2align	2
init_anger:
	.word	100                     # 0x64
	.size	init_anger, 4

	.type	.L__const._work$$YGXPADUTA$$$Z.str0,@object # @"__const._work$$YGXPADUTA$$$Z.str0"
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const._work$$YGXPADUTA$$$Z.str0:
	.asciz	", "
	.size	.L__const._work$$YGXPADUTA$$$Z.str0, 3

	.type	.L__const._work$$YGXPADUTA$$$Z.str1,@object # @"__const._work$$YGXPADUTA$$$Z.str1"
.L__const._work$$YGXPADUTA$$$Z.str1:
	.asciz	" enjoys this work. XD"
	.size	.L__const._work$$YGXPADUTA$$$Z.str1, 22

	.type	.L__const.main.str6,@object # @__const.main.str6
.L__const.main.str6:
	.asciz	"Mars"
	.size	.L__const.main.str6, 5

	.type	.L__const._work$$YGXPADUTA$$$Z.str2,@object # @"__const._work$$YGXPADUTA$$$Z.str2"
.L__const._work$$YGXPADUTA$$$Z.str2:
	.asciz	" wants to give up!!!!!"
	.size	.L__const._work$$YGXPADUTA$$$Z.str2, 23

	.type	.L__const.main.str5,@object # @__const.main.str5
.L__const.main.str5:
	.asciz	"MR"
	.size	.L__const.main.str5, 3

	.type	work_anger,@object      # @work_anger
	.section	.sdata,"aw",@progbits
	.globl	work_anger
	.p2align	2
work_anger:
	.word	10                      # 0xa
	.size	work_anger, 4

	.type	.L__const.main.str4,@object # @__const.main.str4
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str4:
	.asciz	"the striking TA"
	.size	.L__const.main.str4, 16

	.type	.L__const.main.str3,@object # @__const.main.str3
.L__const.main.str3:
	.asciz	"the leading TA"
	.size	.L__const.main.str3, 15

	.section	".note.GNU-stack","",@progbits
