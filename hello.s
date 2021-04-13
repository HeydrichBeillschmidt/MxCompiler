	.text
	.file	"test.ll"
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	j	.LBB0_1
.LBB0_1:                                # %return
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
	.cfi_offset ra, -4
	call	___init__$$YGXXZ
	call	_getInt$$YGHXZ
	lui	a1, %hi(n)
	sw	a0, %lo(n)(a1)
	lui	a0, %hi(i)
	mv	a1, zero
	sw	a1, %lo(i)(a0)
	j	.LBB1_1
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	lui	a1, %hi(n)
	lw	a1, %lo(n)(a1)
	bge	a0, a1, .LBB1_4
	j	.LBB1_2
.LBB1_2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	call	_getInt$$YGHXZ
	lui	a1, %hi(p)
	sw	a0, %lo(p)(a1)
	sw	a1, 20(sp)
	call	_getInt$$YGHXZ
	lui	a1, %hi(q)
	sw	a0, %lo(q)(a1)
	sw	a1, 16(sp)
	call	_getInt$$YGHXZ
	lui	a1, %hi(r)
	sw	a0, %lo(r)(a1)
	lui	a1, %hi(x)
	lw	a2, %lo(x)(a1)
	lw	a3, 20(sp)
	lw	a4, %lo(p)(a3)
	add	a2, a2, a4
	sw	a2, %lo(x)(a1)
	lui	a1, %hi(y)
	lw	a2, %lo(y)(a1)
	lw	a4, 16(sp)
	lw	a5, %lo(q)(a4)
	add	a2, a2, a5
	sw	a2, %lo(y)(a1)
	lui	a1, %hi(z)
	lw	a2, %lo(z)(a1)
	add	a0, a2, a0
	sw	a0, %lo(z)(a1)
	j	.LBB1_3
.LBB1_3:                                # %for.inc
                                        #   in Loop: Header=BB1_1 Depth=1
	lui	a0, %hi(i)
	lw	a1, %lo(i)(a0)
	addi	a1, a1, 1
	sw	a1, %lo(i)(a0)
	j	.LBB1_1
.LBB1_4:                                # %for.end
	lui	a0, %hi(x)
	lw	a0, %lo(x)(a0)
	mv	a1, zero
	mv	a2, a1
	sw	a2, 12(sp)
	bne	a0, a1, .LBB1_7
	j	.LBB1_5
.LBB1_5:                                # %logicalAnd_branch
	lui	a0, %hi(y)
	lw	a0, %lo(y)(a0)
	seqz	a1, a0
	mv	a2, zero
	sw	a1, 12(sp)
	bne	a0, a2, .LBB1_7
	j	.LBB1_6
.LBB1_6:                                # %logicalAnd_branch2
	lui	a0, %hi(z)
	lw	a0, %lo(z)(a0)
	seqz	a0, a0
	sw	a0, 12(sp)
	j	.LBB1_7
.LBB1_7:                                # %logicalAnd_end
	lw	a0, 12(sp)
	mv	a1, zero
	beq	a0, a1, .LBB1_9
	j	.LBB1_8
.LBB1_8:                                # %if.then
	lui	a0, %hi(.L__const.main.str0)
	addi	a0, a0, %lo(.L__const.main.str0)
	call	_print$$YGXPAD$Z
	j	.LBB1_10
.LBB1_9:                                # %if.else
	lui	a0, %hi(.L__const.main.str1)
	addi	a0, a0, %lo(.L__const.main.str1)
	call	_print$$YGXPAD$Z
	j	.LBB1_10
.LBB1_10:                               # %if.end
	j	.LBB1_11
.LBB1_11:                               # %return
	lw	a0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function
	.type	p,@object               # @p
	.section	.sbss,"aw",@nobits
	.globl	p
	.p2align	2
p:
	.word	0                       # 0x0
	.size	p, 4

	.type	q,@object               # @q
	.globl	q
	.p2align	2
q:
	.word	0                       # 0x0
	.size	q, 4

	.type	r,@object               # @r
	.globl	r
	.p2align	2
r:
	.word	0                       # 0x0
	.size	r, 4

	.type	x,@object               # @x
	.globl	x
	.p2align	2
x:
	.word	0                       # 0x0
	.size	x, 4

	.type	y,@object               # @y
	.globl	y
	.p2align	2
y:
	.word	0                       # 0x0
	.size	y, 4

	.type	i,@object               # @i
	.globl	i
	.p2align	2
i:
	.word	0                       # 0x0
	.size	i, 4

	.type	.L__const.main.str1,@object # @__const.main.str1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str1:
	.asciz	"NO"
	.size	.L__const.main.str1, 3

	.type	z,@object               # @z
	.section	.sbss,"aw",@nobits
	.globl	z
	.p2align	2
z:
	.word	0                       # 0x0
	.size	z, 4

	.type	.L__const.main.str0,@object # @__const.main.str0
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.main.str0:
	.asciz	"YES"
	.size	.L__const.main.str0, 4

	.type	n,@object               # @n
	.section	.sbss,"aw",@nobits
	.globl	n
	.p2align	2
n:
	.word	0                       # 0x0
	.size	n, 4

	.section	".note.GNU-stack","",@progbits
