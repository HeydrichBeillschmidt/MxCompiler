define i32 @_test$$YGHHHHHHHHHHH$Z(i32 %q, i32 %w, i32 %e, i32 %r, i32 %t, i32 %y, i32 %u, i32 %i, i32 %o, i32 %p) {
entry:
	%eq = icmp eq i32 %q, %w
	br i1 %eq, label %if.then_2, label %if.else_2

logical_or_branch:
	%ne_2 = icmp ne i32 %e, %r
	br label %logical_or_end

logical_or_end:
	%logicalOr = phi i1 [ 1, %if.then_2 ], [ %ne_2, %logical_or_branch ]
	br i1 %logicalOr, label %if.then, label %if.else

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
	br i1 %ne, label %logical_or_end, label %logical_or_branch

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
	%shl_19 = shl i32 %bitwise_6, 13
	%xor_26 = xor i32 %bitwise_6, %shl_19
	%sge_7 = icmp sge i32 %xor_26, 0
	br i1 %sge_7, label %if.then_8, label %if.else_8

if.then_8:
	%ashr_18 = ashr i32 %xor_26, 17
	br label %return_2_7

if.else_8:
	%xor_27 = xor i32 %xor_26, -2147483648
	%ashr_19 = ashr i32 %xor_27, 17
	%bitwise_13 = or i32 16384, %ashr_19
	br label %return_2_7

return_2_7:
	%retval_8 = phi i32 [ %ashr_18, %if.then_8 ], [ %bitwise_13, %if.else_8 ]
	%xor_28 = xor i32 %xor_26, %retval_8
	%shl_21 = shl i32 %xor_28, 5
	%xor_29 = xor i32 %xor_28, %shl_21
	%bitwise_14 = and i32 %xor_29, 1073741823
	%shl_2 = shl i32 %bitwise_14, 13
	%xor_2 = xor i32 %bitwise_14, %shl_2
	%sge = icmp sge i32 %xor_2, 0
	br i1 %sge, label %if.then_2, label %if.else_2

if.then_2:
	%ashr_6 = ashr i32 %xor_2, 17
	br label %return_2

if.else_2:
	%xor_3 = xor i32 %xor_2, -2147483648
	%ashr_7 = ashr i32 %xor_3, 17
	%bitwise_or = or i32 16384, %ashr_7
	br label %return_2

return_2:
	%retval_2 = phi i32 [ %ashr_6, %if.then_2 ], [ %bitwise_or, %if.else_2 ]
	%xor_4 = xor i32 %xor_2, %retval_2
	%shl_3 = shl i32 %xor_4, 5
	%xor_5 = xor i32 %xor_4, %shl_3
	%bitwise_2 = and i32 %xor_5, 1073741823
	%shl_16 = shl i32 %bitwise_2, 13
	%xor_22 = xor i32 %bitwise_2, %shl_16
	%sge_6 = icmp sge i32 %xor_22, 0
	br i1 %sge_6, label %if.then_7, label %if.else_7

if.then_7:
	%ashr_16 = ashr i32 %xor_22, 17
	br label %return_2_6

if.else_7:
	%xor_23 = xor i32 %xor_22, -2147483648
	%ashr_17 = ashr i32 %xor_23, 17
	%bitwise_11 = or i32 16384, %ashr_17
	br label %return_2_6

return_2_6:
	%retval_7 = phi i32 [ %ashr_16, %if.then_7 ], [ %bitwise_11, %if.else_7 ]
	%xor_24 = xor i32 %xor_22, %retval_7
	%shl_18 = shl i32 %xor_24, 5
	%xor_25 = xor i32 %xor_24, %shl_18
	%bitwise_12 = and i32 %xor_25, 1073741823
	%shl_4 = shl i32 %bitwise_12, 13
	%xor_6 = xor i32 %bitwise_12, %shl_4
	%sge_2 = icmp sge i32 %xor_6, 0
	br i1 %sge_2, label %if.then_3, label %if.else_3

if.then_3:
	%ashr_8 = ashr i32 %xor_6, 17
	br label %return_2_2

if.else_3:
	%xor_7 = xor i32 %xor_6, -2147483648
	%ashr_9 = ashr i32 %xor_7, 17
	%bitwise_3 = or i32 16384, %ashr_9
	br label %return_2_2

return_2_2:
	%retval_3 = phi i32 [ %ashr_8, %if.then_3 ], [ %bitwise_3, %if.else_3 ]
	%xor_8 = xor i32 %xor_6, %retval_3
	%shl_6 = shl i32 %xor_8, 5
	%xor_9 = xor i32 %xor_8, %shl_6
	%bitwise_4 = and i32 %xor_9, 1073741823
	%shl_10 = shl i32 %bitwise_4, 13
	%xor_14 = xor i32 %bitwise_4, %shl_10
	%sge_4 = icmp sge i32 %xor_14, 0
	br i1 %sge_4, label %if.then_5, label %if.else_5

if.then_5:
	%ashr_12 = ashr i32 %xor_14, 17
	br label %return_2_4

if.else_5:
	%xor_15 = xor i32 %xor_14, -2147483648
	%ashr_13 = ashr i32 %xor_15, 17
	%bitwise_7 = or i32 16384, %ashr_13
	br label %return_2_4

return_2_4:
	%retval_5 = phi i32 [ %ashr_12, %if.then_5 ], [ %bitwise_7, %if.else_5 ]
	%xor_16 = xor i32 %xor_14, %retval_5
	%shl_12 = shl i32 %xor_16, 5
	%xor_17 = xor i32 %xor_16, %shl_12
	%bitwise_8 = and i32 %xor_17, 1073741823
	%bitwise_and_3 = and i32 %bitwise_14, 3
	%ashr = ashr i32 %bitwise_14, 28
	%bitwise_and_4 = and i32 %bitwise_2, 1
	%ashr_2 = ashr i32 %bitwise_2, 29
	%ashr_3 = ashr i32 %bitwise_12, 25
	%bitwise_and_5 = and i32 %bitwise_12, 31
	%ashr_4 = ashr i32 %bitwise_4, 15
	%bitwise_and_6 = and i32 %bitwise_4, 32767
	%ashr_5 = ashr i32 %bitwise_8, 15
	%bitwise_and_7 = and i32 %bitwise_8, 32767
	%funcCallRet_8 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %bitwise_and_3, i32 %ashr, i32 %bitwise_and_4, i32 %ashr_2, i32 %ashr_3, i32 %bitwise_and_5, i32 %ashr_4, i32 %bitwise_and_6, i32 %ashr_5, i32 %bitwise_and_7)
	%xor = xor i32 %sum_4, %funcCallRet_8
	br label %for.body

if.else:
	%sub = sub i32 %sum_4, 19
	ret i32 %sub

for.body:
	%sum_4 = phi i32 [ 0, %entry ], [ %xor, %return_2_4 ]
	%rng_seed_5 = phi i32 [ 19260817, %entry ], [ %bitwise_8, %return_2_4 ]
	%shl_13 = shl i32 %rng_seed_5, 13
	%xor_18 = xor i32 %rng_seed_5, %shl_13
	%sge_5 = icmp sge i32 %xor_18, 0
	br i1 %sge_5, label %if.then_6, label %if.else_6

if.then_6:
	%ashr_14 = ashr i32 %xor_18, 17
	br label %return_2_5

if.else_6:
	%xor_19 = xor i32 %xor_18, -2147483648
	%ashr_15 = ashr i32 %xor_19, 17
	%bitwise_9 = or i32 16384, %ashr_15
	br label %return_2_5

return_2_5:
	%retval_6 = phi i32 [ %ashr_14, %if.then_6 ], [ %bitwise_9, %if.else_6 ]
	%xor_20 = xor i32 %xor_18, %retval_6
	%shl_15 = shl i32 %xor_20, 5
	%xor_21 = xor i32 %xor_20, %shl_15
	%bitwise_10 = and i32 %xor_21, 1073741823
	%shl_7 = shl i32 %bitwise_10, 13
	%xor_10 = xor i32 %bitwise_10, %shl_7
	%sge_3 = icmp sge i32 %xor_10, 0
	br i1 %sge_3, label %if.then_4, label %if.else_4

if.then_4:
	%ashr_10 = ashr i32 %xor_10, 17
	br label %return_2_3

if.else_4:
	%xor_11 = xor i32 %xor_10, -2147483648
	%ashr_11 = ashr i32 %xor_11, 17
	%bitwise_5 = or i32 16384, %ashr_11
	br label %return_2_3

return_2_3:
	%retval_4 = phi i32 [ %ashr_10, %if.then_4 ], [ %bitwise_5, %if.else_4 ]
	%xor_12 = xor i32 %xor_10, %retval_4
	%shl_9 = shl i32 %xor_12, 5
	%xor_13 = xor i32 %xor_12, %shl_9
	%bitwise_6 = and i32 %xor_13, 1073741823
	%bitwise_and = and i32 %bitwise_10, 255
	%bitwise_and_2 = and i32 %bitwise_6, 255
	%ne = icmp ne i32 %bitwise_and, %bitwise_and_2
	br i1 %ne, label %if.then, label %if.else
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

