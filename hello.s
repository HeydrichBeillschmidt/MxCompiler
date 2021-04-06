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
	.globl	main                    # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	sw	s1, 20(sp)
	sw	s2, 16(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	call	___init__$$YGXXZ
	lui	s0, %hi(n)
	call	_getInt$$YGHXZ
	sw	a0, %lo(n)(s0)
	lui	s1, %hi(m)
	call	_getInt$$YGHXZ
	sw	a0, %lo(m)(s1)
	lui	s2, %hi(a)
	call	_getInt$$YGHXZ
	lw	a1, %lo(m)(s1)
	sw	a0, %lo(a)(s2)
	lw	a2, %lo(n)(s0)
	add	a1, a1, a0
	addi	a1, a1, -1
	div	a1, a1, a0
	add	a2, a2, a0
	addi	a2, a2, -1
	div	a0, a2, a0
	mul	a0, a1, a0
	call	_toString$$YGPADH$Z
	call	_print$$YGXPAD$Z
	sw	zero, 12(sp)
	lw	a0, 12(sp)
	lw	s2, 16(sp)
	lw	s1, 20(sp)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	a,@object               # @a
	.section	.sbss,"aw",@nobits
	.globl	a
	.p2align	2
a:
	.word	0                       # 0x0
	.size	a, 4

	.type	m,@object               # @m
	.globl	m
	.p2align	2
m:
	.word	0                       # 0x0
	.size	m, 4

	.type	n,@object               # @n
	.globl	n
	.p2align	2
n:
	.word	0                       # 0x0
	.size	n, 4

	.section	".note.GNU-stack","",@progbits
