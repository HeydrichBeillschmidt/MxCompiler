	.text
	.file	"builtin.c"
	.globl	_print$$YGXPAD$Z        # -- Begin function _print$$YGXPAD$Z
	.p2align	2
	.type	_print$$YGXPAD$Z,@function
_print$$YGXPAD$Z:                       # @"_print$$YGXPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	lw	a1, -16(s0)
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	printf
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end0:
	.size	_print$$YGXPAD$Z, .Lfunc_end0-_print$$YGXPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_println$$YGXPAD$Z      # -- Begin function _println$$YGXPAD$Z
	.p2align	2
	.type	_println$$YGXPAD$Z,@function
_println$$YGXPAD$Z:                     # @"_println$$YGXPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	lw	a1, -16(s0)
	lui	a0, %hi(.L.str.1)
	addi	a0, a0, %lo(.L.str.1)
	call	printf
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end1:
	.size	_println$$YGXPAD$Z, .Lfunc_end1-_println$$YGXPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_printInt$$YGXH$Z       # -- Begin function _printInt$$YGXH$Z
	.p2align	2
	.type	_printInt$$YGXH$Z,@function
_printInt$$YGXH$Z:                      # @"_printInt$$YGXH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	lui	a0, %hi(.L.str.2)
	addi	a0, a0, %lo(.L.str.2)
	call	printf
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end2:
	.size	_printInt$$YGXH$Z, .Lfunc_end2-_printInt$$YGXH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_printlnInt$$YGXH$Z     # -- Begin function _printlnInt$$YGXH$Z
	.p2align	2
	.type	_printlnInt$$YGXH$Z,@function
_printlnInt$$YGXH$Z:                    # @"_printlnInt$$YGXH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	lui	a0, %hi(.L.str.3)
	addi	a0, a0, %lo(.L.str.3)
	call	printf
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end3:
	.size	_printlnInt$$YGXH$Z, .Lfunc_end3-_printlnInt$$YGXH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_getString$$YGPADXZ     # -- Begin function _getString$$YGPADXZ
	.p2align	2
	.type	_getString$$YGPADXZ,@function
_getString$$YGPADXZ:                    # @"_getString$$YGPADXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	addi	a0, zero, 1024
	mv	a1, zero
	call	malloc
	sw	a0, -16(s0)
	lw	a1, -16(s0)
	lui	a0, %hi(.L.str)
	addi	a0, a0, %lo(.L.str)
	call	__isoc99_scanf
	lw	a0, -16(s0)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end4:
	.size	_getString$$YGPADXZ, .Lfunc_end4-_getString$$YGPADXZ
	.cfi_endproc
                                        # -- End function
	.globl	_getInt$$YGHXZ          # -- Begin function _getInt$$YGHXZ
	.p2align	2
	.type	_getInt$$YGHXZ,@function
_getInt$$YGHXZ:                         # @"_getInt$$YGHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	lui	a0, %hi(.L.str.2)
	addi	a0, a0, %lo(.L.str.2)
	addi	a1, s0, -12
	call	__isoc99_scanf
	lw	a0, -12(s0)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	_getInt$$YGHXZ, .Lfunc_end5-_getInt$$YGHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_toString$$YGPADH$Z     # -- Begin function _toString$$YGPADH$Z
	.p2align	2
	.type	_toString$$YGPADH$Z,@function
_toString$$YGPADH$Z:                    # @"_toString$$YGPADH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -12(s0)
	addi	a0, zero, 16
	mv	a1, zero
	call	malloc
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	lw	a2, -12(s0)
	lui	a1, %hi(.L.str.2)
	addi	a1, a1, %lo(.L.str.2)
	call	sprintf
	lw	a0, -16(s0)
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end6:
	.size	_toString$$YGPADH$Z, .Lfunc_end6-_toString$$YGPADH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_malloc$$YGPADH$Z       # -- Begin function _malloc$$YGPADH$Z
	.p2align	2
	.type	_malloc$$YGPADH$Z,@function
_malloc$$YGPADH$Z:                      # @"_malloc$$YGPADH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	srai	a1, a0, 31
	call	malloc
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end7:
	.size	_malloc$$YGPADH$Z, .Lfunc_end7-_malloc$$YGPADH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_length$string$$QEAHXZ  # -- Begin function _length$string$$QEAHXZ
	.p2align	2
	.type	_length$string$$QEAHXZ,@function
_length$string$$QEAHXZ:                 # @"_length$string$$QEAHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -16
	.cfi_def_cfa_offset 16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 16
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	call	strlen
	lw	s0, 8(sp)
	lw	ra, 12(sp)
	addi	sp, sp, 16
	ret
.Lfunc_end8:
	.size	_length$string$$QEAHXZ, .Lfunc_end8-_length$string$$QEAHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_substring$string$$QEAPADHH$Z # -- Begin function _substring$string$$QEAPADHH$Z
	.p2align	2
	.type	_substring$string$$QEAPADHH$Z,@function
_substring$string$$QEAPADHH$Z:          # @"_substring$string$$QEAPADHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	sw	a2, -24(s0)
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	sub	a0, a0, a1
	addi	a0, a0, 1
	srai	a1, a0, 31
	call	malloc
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	lw	a3, -24(s0)
	sub	a2, a3, a2
	call	memcpy
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	lw	a2, -20(s0)
	sub	a1, a1, a2
	add	a0, a0, a1
	sb	zero, 0(a0)
	lw	a0, -32(s0)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	_substring$string$$QEAPADHH$Z, .Lfunc_end9-_substring$string$$QEAPADHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_parseInt$string$$QEAHXZ # -- Begin function _parseInt$string$$QEAHXZ
	.p2align	2
	.type	_parseInt$string$$QEAHXZ,@function
_parseInt$string$$QEAHXZ:               # @"_parseInt$string$$QEAHXZ"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	lui	a1, %hi(.L.str.2)
	addi	a1, a1, %lo(.L.str.2)
	addi	a2, s0, -20
	call	__isoc99_sscanf
	lw	a0, -20(s0)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	_parseInt$string$$QEAHXZ, .Lfunc_end10-_parseInt$string$$QEAHXZ
	.cfi_endproc
                                        # -- End function
	.globl	_ord$string$$QEAHH$Z    # -- Begin function _ord$string$$QEAHH$Z
	.p2align	2
	.type	_ord$string$$QEAHH$Z,@function
_ord$string$$QEAHH$Z:                   # @"_ord$string$$QEAHH$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -20(s0)
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lb	a0, 0(a0)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end11:
	.size	_ord$string$$QEAHH$Z, .Lfunc_end11-_ord$string$$QEAHH$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcat$$YGPADPADPAD$Z  # -- Begin function _strcat$$YGPADPADPAD$Z
	.p2align	2
	.type	_strcat$$YGPADPADPAD$Z,@function
_strcat$$YGPADPADPAD$Z:                 # @"_strcat$$YGPADPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	addi	a0, zero, 1024
	mv	a1, zero
	call	malloc
	sw	a0, -32(s0)
	lw	a0, -32(s0)
	lw	a1, -16(s0)
	call	strcpy
	lw	a0, -32(s0)
	lw	a1, -24(s0)
	call	strcat
	lw	a0, -32(s0)
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	_strcat$$YGPADPADPAD$Z, .Lfunc_end12-_strcat$$YGPADPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_eq$$YG_NPADPAD$Z # -- Begin function _strcmp_eq$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_eq$$YG_NPADPAD$Z,@function
_strcmp_eq$$YG_NPADPAD$Z:               # @"_strcmp_eq$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	seqz	a0, a0
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end13:
	.size	_strcmp_eq$$YG_NPADPAD$Z, .Lfunc_end13-_strcmp_eq$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_neq$$YG_NPADPAD$Z # -- Begin function _strcmp_neq$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_neq$$YG_NPADPAD$Z,@function
_strcmp_neq$$YG_NPADPAD$Z:              # @"_strcmp_neq$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	snez	a0, a0
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end14:
	.size	_strcmp_neq$$YG_NPADPAD$Z, .Lfunc_end14-_strcmp_neq$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_lt$$YG_NPADPAD$Z # -- Begin function _strcmp_lt$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_lt$$YG_NPADPAD$Z,@function
_strcmp_lt$$YG_NPADPAD$Z:               # @"_strcmp_lt$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	srli	a0, a0, 31
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end15:
	.size	_strcmp_lt$$YG_NPADPAD$Z, .Lfunc_end15-_strcmp_lt$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_gt$$YG_NPADPAD$Z # -- Begin function _strcmp_gt$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_gt$$YG_NPADPAD$Z,@function
_strcmp_gt$$YG_NPADPAD$Z:               # @"_strcmp_gt$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	sgtz	a0, a0
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end16:
	.size	_strcmp_gt$$YG_NPADPAD$Z, .Lfunc_end16-_strcmp_gt$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_le$$YG_NPADPAD$Z # -- Begin function _strcmp_le$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_le$$YG_NPADPAD$Z,@function
_strcmp_le$$YG_NPADPAD$Z:               # @"_strcmp_le$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	slti	a0, a0, 1
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end17:
	.size	_strcmp_le$$YG_NPADPAD$Z, .Lfunc_end17-_strcmp_le$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.globl	_strcmp_ge$$YG_NPADPAD$Z # -- Begin function _strcmp_ge$$YG_NPADPAD$Z
	.p2align	2
	.type	_strcmp_ge$$YG_NPADPAD$Z,@function
_strcmp_ge$$YG_NPADPAD$Z:               # @"_strcmp_ge$$YG_NPADPAD$Z"
	.cfi_startproc
# %bb.0:                                # %entry
	addi	sp, sp, -32
	.cfi_def_cfa_offset 32
	sw	ra, 28(sp)
	sw	s0, 24(sp)
	.cfi_offset ra, -4
	.cfi_offset s0, -8
	addi	s0, sp, 32
	.cfi_def_cfa s0, 0
	sw	a0, -16(s0)
	sw	a1, -24(s0)
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	call	strcmp
	not	a0, a0
	srli	a0, a0, 31
	lw	s0, 24(sp)
	lw	ra, 28(sp)
	addi	sp, sp, 32
	ret
.Lfunc_end18:
	.size	_strcmp_ge$$YG_NPADPAD$Z, .Lfunc_end18-_strcmp_ge$$YG_NPADPAD$Z
	.cfi_endproc
                                        # -- End function
	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"%s"
	.size	.L.str, 3

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"%s\n"
	.size	.L.str.1, 4

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"%d"
	.size	.L.str.2, 3

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"%d\n"
	.size	.L.str.3, 4

	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
