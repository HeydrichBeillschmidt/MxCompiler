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
	%funcCallRet_3 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet_2)
	%funcCallRet_4 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet_3)
	%funcCallRet_5 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet_4)
	%funcCallRet_6 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet_5)
	%funcCallRet_7 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet_6)
	%bitwise_and_3 = and i32 %funcCallRet_3, 3
	%ashr = ashr i32 %funcCallRet_3, 28
	%bitwise_and_4 = and i32 %funcCallRet_4, 1
	%ashr_2 = ashr i32 %funcCallRet_4, 29
	%ashr_3 = ashr i32 %funcCallRet_5, 25
	%bitwise_and_5 = and i32 %funcCallRet_5, 31
	%ashr_4 = ashr i32 %funcCallRet_6, 15
	%bitwise_and_6 = and i32 %funcCallRet_6, 32767
	%ashr_5 = ashr i32 %funcCallRet_7, 15
	%bitwise_and_7 = and i32 %funcCallRet_7, 32767
	%funcCallRet_8 = call i32 @_test$$YGHHHHHHHHHHH$Z(i32 %bitwise_and_3, i32 %ashr, i32 %bitwise_and_4, i32 %ashr_2, i32 %ashr_3, i32 %bitwise_and_5, i32 %ashr_4, i32 %bitwise_and_6, i32 %ashr_5, i32 %bitwise_and_7)
	%xor = xor i32 %sum_4, %funcCallRet_8
	br label %for.body

if.else:
	%sub = sub i32 %sum_4, 19
	ret i32 %sub

for.body:
	%rng_seed_5 = phi i32 [ 19260817, %entry ], [ %funcCallRet_7, %if.then ]
	%sum_4 = phi i32 [ 0, %entry ], [ %xor, %if.then ]
	%funcCallRet = call i32 @_rng$$YGHH$Z(i32 %rng_seed_5)
	%funcCallRet_2 = call i32 @_rng$$YGHH$Z(i32 %funcCallRet)
	%bitwise_and = and i32 %funcCallRet, 255
	%bitwise_and_2 = and i32 %funcCallRet_2, 255
	%ne = icmp ne i32 %bitwise_and, %bitwise_and_2
	br i1 %ne, label %if.then, label %if.else
}

define i32 @_rng$$YGHH$Z(i32 %rng_seed) {
entry:
	%funcCallRet = call i32 @_unsigned_shl$$YGHHH$Z(i32 %rng_seed, i32 13)
	%xor = xor i32 %rng_seed, %funcCallRet
	%funcCallRet_2 = call i32 @_unsigned_shr$$YGHHH$Z(i32 %xor, i32 17)
	%xor_2 = xor i32 %xor, %funcCallRet_2
	%funcCallRet_3 = call i32 @_unsigned_shl$$YGHHH$Z(i32 %xor_2, i32 5)
	%xor_3 = xor i32 %xor_2, %funcCallRet_3
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

