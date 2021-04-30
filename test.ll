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
	%eq_2 = icmp eq i32 %w, %e
	br i1 %eq_2, label %if.then_3, label %if.else_4

if.then_3:
	%ne_3 = icmp ne i32 %e, %r
	br i1 %ne_3, label %logical_or_end_2, label %logical_or_branch_2

logical_or_branch_2:
	%ne_4 = icmp ne i32 %r, %t
	br label %logical_or_end_2

logical_or_end_2:
	%logicalOr_2 = phi i1 [ 1, %if.then_3 ], [ %ne_4, %logical_or_branch_2 ]
	br i1 %logicalOr_2, label %if.then_4, label %if.else_3

if.then_4:
	%eq_5 = icmp eq i32 %e, %r
	br i1 %eq_5, label %if.then_9, label %if.else_16

if.then_9:
	%ne_9 = icmp ne i32 %r, %t
	br i1 %ne_9, label %logical_or_end_5, label %logical_or_branch_5

logical_or_branch_5:
	%ne_10 = icmp ne i32 %t, %y
	br label %logical_or_end_5

logical_or_end_5:
	%logicalOr_5 = phi i1 [ 1, %if.then_9 ], [ %ne_10, %logical_or_branch_5 ]
	br i1 %logicalOr_5, label %if.then_10, label %if.else_11

if.then_10:
	%eq_6 = icmp eq i32 %r, %t
	br i1 %eq_6, label %if.then_11, label %if.else_10

if.then_11:
	%ne_11 = icmp ne i32 %t, %y
	br i1 %ne_11, label %logical_or_end_6, label %logical_or_branch_6

logical_or_branch_6:
	%ne_12 = icmp ne i32 %y, %u
	br label %logical_or_end_6

logical_or_end_6:
	%logicalOr_6 = phi i1 [ 1, %if.then_11 ], [ %ne_12, %logical_or_branch_6 ]
	br i1 %logicalOr_6, label %if.then_12, label %if.else_9

if.then_12:
	%funcCallRet_8 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %t, i32 %y, i32 %u, i32 %i, i32 %o, i32 %p, i32 %q, i32 %w, i32 %e, i32 %r)
	%add_17 = add i32 %funcCallRet_8, 1
	br label %return_5

if.else_9:
	%sub_9 = sub i32 %o, 1
	%sub_10 = sub i32 %p, 2
	%funcCallRet_9 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %t, i32 %y, i32 %u, i32 %i, i32 %sub_9, i32 %sub_10, i32 %q, i32 %w, i32 %e, i32 %r)
	%add_18 = add i32 %funcCallRet_9, 2
	br label %return_5

if.else_10:
	%add_19 = add i32 %r, %t
	%add_20 = add i32 %add_19, %r
	br label %return_5

return_5:
	%retval_6 = phi i32 [ %add_17, %if.then_12 ], [ %add_18, %if.else_9 ], [ %add_20, %if.else_10 ]
	%add_21 = add i32 %retval_6, 1
	br label %return_8

if.else_11:
	%sub_11 = sub i32 %i, 1
	%sub_12 = sub i32 %o, 2
	%eq_7 = icmp eq i32 %r, %t
	br i1 %eq_7, label %if.then_13, label %if.else_15

if.then_13:
	%ne_13 = icmp ne i32 %t, %y
	br i1 %ne_13, label %logical_or_end_7, label %logical_or_branch_7

logical_or_branch_7:
	%ne_14 = icmp ne i32 %y, %u
	br label %logical_or_end_7

logical_or_end_7:
	%logicalOr_7 = phi i1 [ 1, %if.then_13 ], [ %ne_14, %logical_or_branch_7 ]
	br i1 %logicalOr_7, label %if.then_14, label %if.else_14

if.then_14:
	%eq_8 = icmp eq i32 %t, %y
	br i1 %eq_8, label %if.then_15, label %if.else_13

if.then_15:
	%ne_15 = icmp ne i32 %y, %u
	br i1 %ne_15, label %logical_or_end_8, label %logical_or_branch_8

logical_or_branch_8:
	%ne_16 = icmp ne i32 %u, %sub_11
	br label %logical_or_end_8

logical_or_end_8:
	%logicalOr_8 = phi i1 [ 1, %if.then_15 ], [ %ne_16, %logical_or_branch_8 ]
	br i1 %logicalOr_8, label %if.then_16, label %if.else_12

if.then_16:
	%funcCallRet_10 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %y, i32 %u, i32 %sub_11, i32 %sub_12, i32 %p, i32 %q, i32 %w, i32 %e, i32 %r, i32 %t)
	%add_22 = add i32 %funcCallRet_10, 1
	br label %return_6

if.else_12:
	%sub_13 = sub i32 %p, 1
	%sub_14 = sub i32 %q, 2
	%funcCallRet_11 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %y, i32 %u, i32 %sub_11, i32 %sub_12, i32 %sub_13, i32 %sub_14, i32 %w, i32 %e, i32 %r, i32 %t)
	%add_23 = add i32 %funcCallRet_11, 2
	br label %return_6

if.else_13:
	%add_24 = add i32 %t, %y
	%add_25 = add i32 %add_24, %t
	br label %return_6

return_6:
	%retval_7 = phi i32 [ %add_22, %if.then_16 ], [ %add_23, %if.else_12 ], [ %add_25, %if.else_13 ]
	%add_26 = add i32 %retval_7, 1
	br label %return_7

if.else_14:
	%sub_15 = sub i32 %sub_12, 1
	%sub_16 = sub i32 %p, 2
	%funcCallRet_12 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %t, i32 %y, i32 %u, i32 %sub_11, i32 %sub_15, i32 %sub_16, i32 %q, i32 %w, i32 %e, i32 %r)
	%add_27 = add i32 %funcCallRet_12, 2
	br label %return_7

if.else_15:
	%add_28 = add i32 %r, %t
	%add_29 = add i32 %add_28, %r
	br label %return_7

return_7:
	%retval_8 = phi i32 [ %add_26, %return_6 ], [ %add_27, %if.else_14 ], [ %add_29, %if.else_15 ]
	%add_30 = add i32 %retval_8, 2
	br label %return_8

if.else_16:
	%add_31 = add i32 %e, %r
	%add_32 = add i32 %add_31, %e
	br label %return_8

return_8:
	%retval_9 = phi i32 [ %add_21, %return_5 ], [ %add_30, %return_7 ], [ %add_32, %if.else_16 ]
	%add_5 = add i32 %retval_9, 1
	br label %return_2

if.else_3:
	%sub_3 = sub i32 %u, 1
	%sub_4 = sub i32 %i, 2
	%funcCallRet_4 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %e, i32 %r, i32 %t, i32 %y, i32 %sub_3, i32 %sub_4, i32 %o, i32 %p, i32 %q, i32 %w)
	%add_6 = add i32 %funcCallRet_4, 2
	br label %return_2

if.else_4:
	%add_7 = add i32 %w, %e
	%add_8 = add i32 %add_7, %w
	br label %return_2

return_2:
	%retval_3 = phi i32 [ %add_5, %return_8 ], [ %add_6, %if.else_3 ], [ %add_8, %if.else_4 ]
	%add = add i32 %retval_3, 1
	br label %return

if.else:
	%sub = sub i32 %y, 1
	%sub_2 = sub i32 %u, 2
	%eq_3 = icmp eq i32 %w, %e
	br i1 %eq_3, label %if.then_5, label %if.else_8

if.then_5:
	%ne_5 = icmp ne i32 %e, %r
	br i1 %ne_5, label %logical_or_end_3, label %logical_or_branch_3

logical_or_branch_3:
	%ne_6 = icmp ne i32 %r, %t
	br label %logical_or_end_3

logical_or_end_3:
	%logicalOr_3 = phi i1 [ 1, %if.then_5 ], [ %ne_6, %logical_or_branch_3 ]
	br i1 %logicalOr_3, label %if.then_6, label %if.else_7

if.then_6:
	%eq_4 = icmp eq i32 %e, %r
	br i1 %eq_4, label %if.then_7, label %if.else_6

if.then_7:
	%ne_7 = icmp ne i32 %r, %t
	br i1 %ne_7, label %logical_or_end_4, label %logical_or_branch_4

logical_or_branch_4:
	%ne_8 = icmp ne i32 %t, %sub
	br label %logical_or_end_4

logical_or_end_4:
	%logicalOr_4 = phi i1 [ 1, %if.then_7 ], [ %ne_8, %logical_or_branch_4 ]
	br i1 %logicalOr_4, label %if.then_8, label %if.else_5

if.then_8:
	%funcCallRet_5 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %r, i32 %t, i32 %sub, i32 %sub_2, i32 %i, i32 %o, i32 %p, i32 %q, i32 %w, i32 %e)
	%add_9 = add i32 %funcCallRet_5, 1
	br label %return_3

if.else_5:
	%sub_5 = sub i32 %i, 1
	%sub_6 = sub i32 %o, 2
	%funcCallRet_6 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %r, i32 %t, i32 %sub, i32 %sub_2, i32 %sub_5, i32 %sub_6, i32 %p, i32 %q, i32 %w, i32 %e)
	%add_10 = add i32 %funcCallRet_6, 2
	br label %return_3

if.else_6:
	%add_11 = add i32 %e, %r
	%add_12 = add i32 %add_11, %e
	br label %return_3

return_3:
	%retval_4 = phi i32 [ %add_9, %if.then_8 ], [ %add_10, %if.else_5 ], [ %add_12, %if.else_6 ]
	%add_13 = add i32 %retval_4, 1
	br label %return_4

if.else_7:
	%sub_7 = sub i32 %sub_2, 1
	%sub_8 = sub i32 %i, 2
	%funcCallRet_7 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %e, i32 %r, i32 %t, i32 %sub, i32 %sub_7, i32 %sub_8, i32 %o, i32 %p, i32 %q, i32 %w)
	%add_14 = add i32 %funcCallRet_7, 2
	br label %return_4

if.else_8:
	%add_15 = add i32 %w, %e
	%add_16 = add i32 %add_15, %w
	br label %return_4

return_4:
	%retval_5 = phi i32 [ %add_13, %return_3 ], [ %add_14, %if.else_7 ], [ %add_16, %if.else_8 ]
	%add_2 = add i32 %retval_5, 2
	br label %return

if.then_2:
	%ne = icmp ne i32 %w, %e
	br i1 %ne, label %logical_or_end, label %logical_or_branch

if.else_2:
	%add_3 = add i32 %q, %w
	%add_4 = add i32 %add_3, %q
	br label %return

return:
	%retval_2 = phi i32 [ %add, %return_2 ], [ %add_2, %return_4 ], [ %add_4, %if.else_2 ]
	ret i32 %retval_2
}

define i32 @main() {
entry:
	br label %for.body

if.then:
	%shl_7 = shl i32 %bitwise_and_9, 13
	%xor_10 = xor i32 %bitwise_and_9, %shl_7
	%sge_3 = icmp sge i32 %xor_10, 0
	br i1 %sge_3, label %if.then_4, label %if.else_4

if.then_4:
	%ashr_10 = ashr i32 %xor_10, 17
	br label %return_4

if.else_4:
	%xor_11 = xor i32 %xor_10, -2147483648
	%ashr_11 = ashr i32 %xor_11, 17
	%bitwise_or_3 = or i32 16384, %ashr_11
	br label %return_4

return_4:
	%retval_4 = phi i32 [ %ashr_10, %if.then_4 ], [ %bitwise_or_3, %if.else_4 ]
	%xor_12 = xor i32 %xor_10, %retval_4
	%shl_9 = shl i32 %xor_12, 5
	%xor_13 = xor i32 %xor_12, %shl_9
	%bitwise_and_10 = and i32 %xor_13, 1073741823
	%shl_10 = shl i32 %bitwise_and_10, 13
	%xor_14 = xor i32 %bitwise_and_10, %shl_10
	%sge_4 = icmp sge i32 %xor_14, 0
	br i1 %sge_4, label %if.then_5, label %if.else_5

if.then_5:
	%ashr_12 = ashr i32 %xor_14, 17
	br label %return_5

if.else_5:
	%xor_15 = xor i32 %xor_14, -2147483648
	%ashr_13 = ashr i32 %xor_15, 17
	%bitwise_or_4 = or i32 16384, %ashr_13
	br label %return_5

return_5:
	%retval_5 = phi i32 [ %ashr_12, %if.then_5 ], [ %bitwise_or_4, %if.else_5 ]
	%xor_16 = xor i32 %xor_14, %retval_5
	%shl_12 = shl i32 %xor_16, 5
	%xor_17 = xor i32 %xor_16, %shl_12
	%bitwise_and_11 = and i32 %xor_17, 1073741823
	%shl_13 = shl i32 %bitwise_and_11, 13
	%xor_18 = xor i32 %bitwise_and_11, %shl_13
	%sge_5 = icmp sge i32 %xor_18, 0
	br i1 %sge_5, label %if.then_6, label %if.else_6

if.then_6:
	%ashr_14 = ashr i32 %xor_18, 17
	br label %return_6

if.else_6:
	%xor_19 = xor i32 %xor_18, -2147483648
	%ashr_15 = ashr i32 %xor_19, 17
	%bitwise_or_5 = or i32 16384, %ashr_15
	br label %return_6

return_6:
	%retval_6 = phi i32 [ %ashr_14, %if.then_6 ], [ %bitwise_or_5, %if.else_6 ]
	%xor_20 = xor i32 %xor_18, %retval_6
	%shl_15 = shl i32 %xor_20, 5
	%xor_21 = xor i32 %xor_20, %shl_15
	%bitwise_and_12 = and i32 %xor_21, 1073741823
	%shl_16 = shl i32 %bitwise_and_12, 13
	%xor_22 = xor i32 %bitwise_and_12, %shl_16
	%sge_6 = icmp sge i32 %xor_22, 0
	br i1 %sge_6, label %if.then_7, label %if.else_7

if.then_7:
	%ashr_16 = ashr i32 %xor_22, 17
	br label %return_7

if.else_7:
	%xor_23 = xor i32 %xor_22, -2147483648
	%ashr_17 = ashr i32 %xor_23, 17
	%bitwise_or_6 = or i32 16384, %ashr_17
	br label %return_7

return_7:
	%retval_7 = phi i32 [ %ashr_16, %if.then_7 ], [ %bitwise_or_6, %if.else_7 ]
	%xor_24 = xor i32 %xor_22, %retval_7
	%shl_18 = shl i32 %xor_24, 5
	%xor_25 = xor i32 %xor_24, %shl_18
	%bitwise_and_13 = and i32 %xor_25, 1073741823
	%shl_19 = shl i32 %bitwise_and_13, 13
	%xor_26 = xor i32 %bitwise_and_13, %shl_19
	%sge_7 = icmp sge i32 %xor_26, 0
	br i1 %sge_7, label %if.then_8, label %if.else_8

if.then_8:
	%ashr_18 = ashr i32 %xor_26, 17
	br label %return_8

if.else_8:
	%xor_27 = xor i32 %xor_26, -2147483648
	%ashr_19 = ashr i32 %xor_27, 17
	%bitwise_or_7 = or i32 16384, %ashr_19
	br label %return_8

return_8:
	%retval_8 = phi i32 [ %ashr_18, %if.then_8 ], [ %bitwise_or_7, %if.else_8 ]
	%xor_28 = xor i32 %xor_26, %retval_8
	%shl_21 = shl i32 %xor_28, 5
	%xor_29 = xor i32 %xor_28, %shl_21
	%bitwise_and_14 = and i32 %xor_29, 1073741823
	%bitwise_and_3 = and i32 %xor_13, 3
	%ashr = ashr i32 %bitwise_and_10, 28
	%bitwise_and_4 = and i32 %xor_17, 1
	%ashr_2 = ashr i32 %bitwise_and_11, 29
	%ashr_3 = ashr i32 %bitwise_and_12, 25
	%bitwise_and_5 = and i32 %xor_21, 31
	%ashr_4 = ashr i32 %bitwise_and_13, 15
	%bitwise_and_6 = and i32 %xor_25, 32767
	%ashr_5 = ashr i32 %bitwise_and_14, 15
	%bitwise_and_7 = and i32 %xor_29, 32767
	%funcCallRet_8 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %bitwise_and_3, i32 %ashr, i32 %bitwise_and_4, i32 %ashr_2, i32 %ashr_3, i32 %bitwise_and_5, i32 %ashr_4, i32 %bitwise_and_6, i32 %ashr_5, i32 %bitwise_and_7)
	%xor = xor i32 %sum_4, %funcCallRet_8
	br label %for.body

if.else:
	%sub = sub i32 %sum_4, 19
	ret i32 %sub

for.body:
	%rng_seed_5 = phi i32 [ 19260817, %entry ], [ %bitwise_and_14, %return_8 ]
	%sum_4 = phi i32 [ 0, %entry ], [ %xor, %return_8 ]
	%shl = shl i32 %rng_seed_5, 13
	%xor_2 = xor i32 %rng_seed_5, %shl
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
	%bitwise_and_8 = and i32 %xor_5, 1073741823
	%shl_4 = shl i32 %bitwise_and_8, 13
	%xor_6 = xor i32 %bitwise_and_8, %shl_4
	%sge_2 = icmp sge i32 %xor_6, 0
	br i1 %sge_2, label %if.then_3, label %if.else_3

if.then_3:
	%ashr_8 = ashr i32 %xor_6, 17
	br label %return_3

if.else_3:
	%xor_7 = xor i32 %xor_6, -2147483648
	%ashr_9 = ashr i32 %xor_7, 17
	%bitwise_or_2 = or i32 16384, %ashr_9
	br label %return_3

return_3:
	%retval_3 = phi i32 [ %ashr_8, %if.then_3 ], [ %bitwise_or_2, %if.else_3 ]
	%xor_8 = xor i32 %xor_6, %retval_3
	%shl_6 = shl i32 %xor_8, 5
	%xor_9 = xor i32 %xor_8, %shl_6
	%bitwise_and_9 = and i32 %xor_9, 1073741823
	%bitwise_and = and i32 %xor_5, 255
	%bitwise_and_2 = and i32 %xor_9, 255
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

