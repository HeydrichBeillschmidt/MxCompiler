define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_unsigned_shr$$YGHHH$Z(i32 %x, i32 %k) {
entry:
	%sge = icmp sge i32 %x, 0
	br i1 %sge, label %if.then, label %if.else

if.then:
	%ashr = ashr i32 %x, %k
	br label %return

if.else:
	%sub = sub i32 31, %k
	%shl_2 = shl i32 1, %sub
	%xor = xor i32 %x, -2147483648
	%ashr_2 = ashr i32 %xor, %k
	%bitwise_or = or i32 %shl_2, %ashr_2
	br label %return

return:
	%retval_2 = phi i32 [ %ashr, %if.then ], [ %bitwise_or, %if.else ]
	ret i32 %retval_2
}

define i32 @_unsigned_shl$$YGHHH$Z(i32 %x, i32 %k) {
entry:
	%shl = shl i32 %x, %k
	ret i32 %shl
}

define i32 @_test$$YGHHHHHHHHHHH$Z(i32 %q, i32 %w, i32 %e, i32 %r, i32 %t, i32 %y, i32 %u, i32 %i, i32 %o, i32 %p) {
entry:
	%eq = icmp eq i32 %q, %w
	br i1 %eq, label %if.then_2, label %if.else_2

logicalOr_branch:
	%ne_2 = icmp ne i32 %e, %r
	br label %logicalOr_end

logicalOr_end:
	%logical_or = phi i1 [ 1, %if.then_2 ], [ %ne_2, %logicalOr_branch ]
	br i1 %logical_or, label %if.then, label %if.else

if.then:
	%funcCallRet = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %w, i32 %e, i32 %r, i32 %t, i32 %y, i32 %u, i32 %i, i32 %o, i32 %p, i32 %q)
	%add = add i32 %funcCallRet, 1
	br label %return

if.else:
	%sub = sub i32 %y, 1
	%sub_2 = sub i32 %u, 2
	%funcCallRet_2 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %w, i32 %e, i32 %r, i32 %t, i32 %sub, i32 %sub_2, i32 %i, i32 %o, i32 %p, i32 %q)
	%add_2 = add i32 %funcCallRet_2, 2
	br label %return

if.then_2:
	%ne = icmp ne i32 %w, %e
	br i1 %ne, label %logicalOr_end, label %logicalOr_branch

if.else_2:
	%add_3 = add i32 %q, %w
	%add_4 = add i32 %add_3, %q
	br label %return

return:
	%retval_2 = phi i32 [ %add, %if.then ], [ %add_2, %if.else ], [ %add_4, %if.else_2 ]
	ret i32 %retval_2
}

define i32 @main() {
entry:
	br label %for.body

if.then:
	%shl_3 = shl i32 %bitwise_and_9, 13
	%xor_4 = xor i32 %bitwise_and_9, %shl_3
	%sge_3 = icmp sge i32 %xor_4, 0
	br i1 %sge_3, label %inline_inline_if.then_3, label %inline_inline_if.else_3

inline_inline_if.then_3:
	%ashr_8 = ashr i32 %xor_4, 17
	br label %inline_inline_return_3

inline_inline_if.else_3:
	%xor_4_3 = xor i32 %xor_4, -2147483648
	%ashr_2_3 = ashr i32 %xor_4_3, 17
	%bitwise_or_3 = or i32 16384, %ashr_2_3
	br label %inline_inline_return_3

inline_inline_return_3:
	%retval_2_3 = phi i32 [ %ashr_8, %inline_inline_if.then_3 ], [ %bitwise_or_3, %inline_inline_if.else_3 ]
	%xor_2_3 = xor i32 %xor_4, %retval_2_3
	%shl_2_6 = shl i32 %xor_2_3, 5
	%xor_3_3 = xor i32 %xor_2_3, %shl_2_6
	%bitwise_and_10 = and i32 %xor_3_3, 1073741823
	%shl = shl i32 %bitwise_and_10, 13
	%xor_2 = xor i32 %bitwise_and_10, %shl
	%sge = icmp sge i32 %xor_2, 0
	br i1 %sge, label %inline_inline_if.then, label %inline_inline_if.else

inline_inline_if.then:
	%ashr_6 = ashr i32 %xor_2, 17
	br label %inline_inline_return

inline_inline_if.else:
	%xor_4 = xor i32 %xor_2, -2147483648
	%ashr_2 = ashr i32 %xor_4, 17
	%bitwise_or = or i32 16384, %ashr_2
	br label %inline_inline_return

inline_inline_return:
	%retval_2 = phi i32 [ %ashr_6, %inline_inline_if.then ], [ %bitwise_or, %inline_inline_if.else ]
	%xor_2 = xor i32 %xor_2, %retval_2
	%shl_2_2 = shl i32 %xor_2, 5
	%xor_3 = xor i32 %xor_2, %shl_2_2
	%bitwise_and_8 = and i32 %xor_3, 1073741823
	%shl_5 = shl i32 %bitwise_and_8, 13
	%xor_6 = xor i32 %bitwise_and_8, %shl_5
	%sge_5 = icmp sge i32 %xor_6, 0
	br i1 %sge_5, label %inline_inline_if.then_5, label %inline_inline_if.else_5

inline_inline_if.then_5:
	%ashr_10 = ashr i32 %xor_6, 17
	br label %inline_inline_return_5

inline_inline_if.else_5:
	%xor_4_5 = xor i32 %xor_6, -2147483648
	%ashr_2_5 = ashr i32 %xor_4_5, 17
	%bitwise_or_5 = or i32 16384, %ashr_2_5
	br label %inline_inline_return_5

inline_inline_return_5:
	%retval_2_5 = phi i32 [ %ashr_10, %inline_inline_if.then_5 ], [ %bitwise_or_5, %inline_inline_if.else_5 ]
	%xor_2_5 = xor i32 %xor_6, %retval_2_5
	%shl_2_10 = shl i32 %xor_2_5, 5
	%xor_3_5 = xor i32 %xor_2_5, %shl_2_10
	%bitwise_and_12 = and i32 %xor_3_5, 1073741823
	%shl_4 = shl i32 %bitwise_and_12, 13
	%xor_5 = xor i32 %bitwise_and_12, %shl_4
	%sge_4 = icmp sge i32 %xor_5, 0
	br i1 %sge_4, label %inline_inline_if.then_4, label %inline_inline_if.else_4

inline_inline_if.then_4:
	%ashr_9 = ashr i32 %xor_5, 17
	br label %inline_inline_return_4

inline_inline_if.else_4:
	%xor_4_4 = xor i32 %xor_5, -2147483648
	%ashr_2_4 = ashr i32 %xor_4_4, 17
	%bitwise_or_4 = or i32 16384, %ashr_2_4
	br label %inline_inline_return_4

inline_inline_return_4:
	%retval_2_4 = phi i32 [ %ashr_9, %inline_inline_if.then_4 ], [ %bitwise_or_4, %inline_inline_if.else_4 ]
	%xor_2_4 = xor i32 %xor_5, %retval_2_4
	%shl_2_8 = shl i32 %xor_2_4, 5
	%xor_3_4 = xor i32 %xor_2_4, %shl_2_8
	%bitwise_and_11 = and i32 %xor_3_4, 1073741823
	%shl_6 = shl i32 %bitwise_and_11, 13
	%xor_7 = xor i32 %bitwise_and_11, %shl_6
	%sge_6 = icmp sge i32 %xor_7, 0
	br i1 %sge_6, label %inline_inline_if.then_6, label %inline_inline_if.else_6

inline_inline_if.then_6:
	%ashr_11 = ashr i32 %xor_7, 17
	br label %inline_inline_return_6

inline_inline_if.else_6:
	%xor_4_6 = xor i32 %xor_7, -2147483648
	%ashr_2_6 = ashr i32 %xor_4_6, 17
	%bitwise_or_6 = or i32 16384, %ashr_2_6
	br label %inline_inline_return_6

inline_inline_return_6:
	%retval_2_6 = phi i32 [ %ashr_11, %inline_inline_if.then_6 ], [ %bitwise_or_6, %inline_inline_if.else_6 ]
	%xor_2_6 = xor i32 %xor_7, %retval_2_6
	%shl_2_12 = shl i32 %xor_2_6, 5
	%xor_3_6 = xor i32 %xor_2_6, %shl_2_12
	%bitwise_and_13 = and i32 %xor_3_6, 1073741823
	%bitwise_and_3 = and i32 %bitwise_and_10, 3
	%ashr = ashr i32 %bitwise_and_10, 28
	%bitwise_and_4 = and i32 %bitwise_and_8, 1
	%ashr_2 = ashr i32 %bitwise_and_8, 29
	%ashr_3 = ashr i32 %bitwise_and_12, 25
	%bitwise_and_5 = and i32 %bitwise_and_12, 31
	%ashr_4 = ashr i32 %bitwise_and_11, 15
	%bitwise_and_6 = and i32 %bitwise_and_11, 32767
	%ashr_5 = ashr i32 %bitwise_and_13, 15
	%bitwise_and_7 = and i32 %bitwise_and_13, 32767
	%funcCallRet_8 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %bitwise_and_3, i32 %ashr, i32 %bitwise_and_4, i32 %ashr_2, i32 %ashr_3, i32 %bitwise_and_5, i32 %ashr_4, i32 %bitwise_and_6, i32 %ashr_5, i32 %bitwise_and_7)
	%xor = xor i32 %sum_4, %funcCallRet_8
	br label %for.body

if.else:
	%sub = sub i32 %sum_4, 19
	ret i32 %sub

for.body:
	%rng_seed_5 = phi i32 [ 19260817, %entry ], [ %bitwise_and_13, %inline_inline_return_6 ]
	%sum_4 = phi i32 [ 0, %entry ], [ %xor, %inline_inline_return_6 ]
	%shl_7 = shl i32 %rng_seed_5, 13
	%xor_8 = xor i32 %rng_seed_5, %shl_7
	%sge_7 = icmp sge i32 %xor_8, 0
	br i1 %sge_7, label %inline_inline_if.then_7, label %inline_inline_if.else_7

inline_inline_if.then_7:
	%ashr_12 = ashr i32 %xor_8, 17
	br label %inline_inline_return_7

inline_inline_if.else_7:
	%xor_4_7 = xor i32 %xor_8, -2147483648
	%ashr_2_7 = ashr i32 %xor_4_7, 17
	%bitwise_or_7 = or i32 16384, %ashr_2_7
	br label %inline_inline_return_7

inline_inline_return_7:
	%retval_2_7 = phi i32 [ %ashr_12, %inline_inline_if.then_7 ], [ %bitwise_or_7, %inline_inline_if.else_7 ]
	%xor_2_7 = xor i32 %xor_8, %retval_2_7
	%shl_2_14 = shl i32 %xor_2_7, 5
	%xor_3_7 = xor i32 %xor_2_7, %shl_2_14
	%bitwise_and_14 = and i32 %xor_3_7, 1073741823
	%shl_2 = shl i32 %bitwise_and_14, 13
	%xor_3 = xor i32 %bitwise_and_14, %shl_2
	%sge_2 = icmp sge i32 %xor_3, 0
	br i1 %sge_2, label %inline_inline_if.then_2, label %inline_inline_if.else_2

inline_inline_if.then_2:
	%ashr_7 = ashr i32 %xor_3, 17
	br label %inline_inline_return_2

inline_inline_if.else_2:
	%xor_4_2 = xor i32 %xor_3, -2147483648
	%ashr_2_2 = ashr i32 %xor_4_2, 17
	%bitwise_or_2 = or i32 16384, %ashr_2_2
	br label %inline_inline_return_2

inline_inline_return_2:
	%retval_2_2 = phi i32 [ %ashr_7, %inline_inline_if.then_2 ], [ %bitwise_or_2, %inline_inline_if.else_2 ]
	%xor_2_2 = xor i32 %xor_3, %retval_2_2
	%shl_2_4 = shl i32 %xor_2_2, 5
	%xor_3_2 = xor i32 %xor_2_2, %shl_2_4
	%bitwise_and_9 = and i32 %xor_3_2, 1073741823
	%bitwise_and = and i32 %bitwise_and_14, 255
	%bitwise_and_2 = and i32 %bitwise_and_9, 255
	%ne = icmp ne i32 %bitwise_and, %bitwise_and_2
	br i1 %ne, label %if.then, label %if.else
}

define i32 @_rng$$YGHH$Z(i32 %rng_seed) {
entry:
	%shl = shl i32 %rng_seed, 13
	%xor = xor i32 %rng_seed, %shl
	%sge = icmp sge i32 %xor, 0
	br i1 %sge, label %inline_if.then, label %inline_if.else

inline_if.then:
	%ashr = ashr i32 %xor, 17
	br label %inline_return

inline_if.else:
	%xor_4 = xor i32 %xor, -2147483648
	%ashr_2 = ashr i32 %xor_4, 17
	%bitwise_or = or i32 16384, %ashr_2
	br label %inline_return

inline_return:
	%retval_2 = phi i32 [ %ashr, %inline_if.then ], [ %bitwise_or, %inline_if.else ]
	%xor_2 = xor i32 %xor, %retval_2
	%shl_2 = shl i32 %xor_2, 5
	%xor_3 = xor i32 %xor_2, %shl_2
	%bitwise_and = and i32 %xor_3, 1073741823
	ret i32 %bitwise_and
}

declare i32 @_length$string$$QEAHXZ(i8* %str)

declare i32 @_ord$string$$QEAHH$Z(i8* %str, i32 %pos)

declare i8* @_strcat$$YGPADPADPAD$Z(i8* %str1, i8* %str2)

declare i32 @_parseInt$string$$QEAHXZ(i8* %str)

declare void @_printInt$$YGXH$Z(i32 %n)

declare i1 @_strcmp_le$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_malloc$$YGPADH$Z(i32 %size)

declare i1 @_strcmp_ge$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i1 @_strcmp_lt$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_getString$$YGPADXZ()

declare i1 @_strcmp_eq$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i32 @_getInt$$YGHXZ()

declare void @_print$$YGXPAD$Z(i8* %str)

declare i1 @_strcmp_neq$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare i8* @_substring$string$$QEAPADHH$Z(i8* %str, i32 %left, i32 %right)

declare i1 @_strcmp_gt$$YG_NPADPAD$Z(i8* %str1, i8* %str2)

declare void @_println$$YGXPAD$Z(i8* %str)

declare void @_printlnInt$$YGXH$Z(i32 %n)

declare i8* @_toString$$YGPADH$Z(i32 %i)

