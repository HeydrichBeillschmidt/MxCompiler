	.text
	.file	"test.ll"
	.globl	___init__$$YGXXZ        # -- Begin function ___init__$$YGXXZ
	.p2align	2
	.type	___init__$$YGXXZ,@function
___init__$$YGXXZ:                       # @"___init__$$YGXXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	.cfi_offset ra, -4
	addi	a0, zero, 1604
	call	_malloc$$YGPADH$Z
	addi	a1, zero, 50
	sw	a1, 0(a0)
	addi	a0, a0, 4
	lui	a1, %hi(a)
	sw	a0, %lo(a)(a1)
	lw	ra, 12(sp)
	addi	sp, sp, 16
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
	sw	s3, 12(sp)
	sw	s4, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	.cfi_offset s1, -12
	.cfi_offset s2, -16
	.cfi_offset s3, -20
	.cfi_offset s4, -24
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	call	___init__$$YGXXZ
	lui	s2, %hi(m)
	call	_getInt$$YGHXZ
	sw	a0, %lo(m)(s2)
	lui	s1, %hi(k)
	call	_getInt$$YGHXZ
	sw	a0, %lo(k)(s1)
	lui	s4, %hi(i)
	sw	zero, %lo(i)(s4)
	lui	s3, %hi(a)
.LBB1_1:                                # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	lw	a0, %lo(i)(s4)
	lw	a1, %lo(m)(s2)
	bge	a0, a1, .LBB1_3
# %bb.2:                                # %for.body
                                        #   in Loop: Header=BB1_1 Depth=1
	lw	a0, %lo(i)(s4)
	lw	a1, %lo(a)(s3)
	slli	a0, a0, 2
	add	s1, a1, a0
	call	_getInt$$YGHXZ
	sw	a0, 0(s1)
	lw	a0, %lo(i)(s4)
	addi	a0, a0, 1
	sw	a0, %lo(i)(s4)
	j	.LBB1_1
.LBB1_3:                                # %for.end
	lui	a0, %hi(i)
	sw	zero, %lo(i)(a0)
	lui	a1, %hi(a)
	lui	t0, %hi(k)
	addi	a7, zero, 1
	lui	a6, %hi(m)
.LBB1_4:                                # %for.cond_2
                                        # =>This Inner Loop Header: Depth=1
	lw	a4, %lo(i)(a0)
	lw	a5, %lo(a)(a1)
	lw	s1, %lo(k)(t0)
	slli	a4, a4, 2
	add	a4, a5, a4
	lw	a4, 0(a4)
	slli	s1, s1, 2
	add	a5, s1, a5
	lw	s1, -4(a5)
	slt	a5, a4, s1
	xori	a3, a5, 1
	mv	a2, sp
	addi	a5, a2, -16
	mv	sp, a5
	sb	a3, -16(a2)
	blt	a4, s1, .LBB1_7
# %bb.5:                                # %logicalAnd_branch
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	s1, %lo(i)(a0)
	lw	a4, %lo(a)(a1)
	slli	s1, s1, 2
	add	a4, a4, s1
	lw	a4, 0(a4)
	sgtz	s1, a4
	sb	s1, 0(a5)
	blt	a4, a7, .LBB1_7
# %bb.6:                                # %logicalAnd_branch2
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a4, %lo(i)(a0)
	lw	s1, %lo(m)(a6)
	slt	a4, a4, s1
	sb	a4, 0(a5)
.LBB1_7:                                # %logicalAnd_end
                                        #   in Loop: Header=BB1_4 Depth=1
	lbu	a4, 0(a5)
	beqz	a4, .LBB1_9
# %bb.8:                                # %for.body_2
                                        #   in Loop: Header=BB1_4 Depth=1
	lw	a2, %lo(i)(a0)
	addi	a2, a2, 1
	sw	a2, %lo(i)(a0)
	j	.LBB1_4
.LBB1_9:                                # %for.end_2
	lui	a0, %hi(i)
	lw	a0, %lo(i)(a0)
	call	_printInt$$YGXH$Z
	lw	a0, -28(s0)
	addi	sp, s0, -32
	lw	s4, 8(sp)
	lw	s3, 12(sp)
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
	.word	0
	.size	a, 4

	.type	i,@object               # @i
	.globl	i
	.p2align	2
i:
	.word	0                       # 0x0
	.size	i, 4

	.type	k,@object               # @k
	.globl	k
	.p2align	2
k:
	.word	0                       # 0x0
	.size	k, 4

	.type	m,@object               # @m
	.globl	m
	.p2align	2
m:
	.word	0                       # 0x0
	.size	m, 4

	.section	".note.GNU-stack","",@progbits
