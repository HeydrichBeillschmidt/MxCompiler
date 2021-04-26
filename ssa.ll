@rng_seed = global i32 19260817, align 4

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_unsigned_shr$$YGHHH$Z(i32 %x, i32 %k) {
entry:
	%shl = shl i32 1, 31
	%sge = icmp sge i32 %x, 0
	br i1 %sge, label %if.then, label %if.else

if.then:
	%ashr = ashr i32 %x, %k
	br label %return

if.else:
	%sub = sub i32 31, %k
	%shl_2 = shl i32 1, %sub
	%xor = xor i32 %x, %shl
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

define i32 @_rng$$YGHXZ() {
entry:
	%rng_seed = load i32, i32* @rng_seed, align 4
	%funcCallRet = call i32 @_unsigned_shl$$YGHHH$Z(i32 %rng_seed, i32 13)
	%xor = xor i32 %rng_seed, %funcCallRet
	%funcCallRet_2 = call i32 @_unsigned_shr$$YGHHH$Z(i32 %xor, i32 17)
	%xor_2 = xor i32 %xor, %funcCallRet_2
	%funcCallRet_3 = call i32 @_unsigned_shl$$YGHHH$Z(i32 %xor_2, i32 5)
	%xor_3 = xor i32 %xor_2, %funcCallRet_3
	store i32 %xor_3, i32* @rng_seed, align 4
	%bitwise_and = and i32 %xor_3, 1073741823
	ret i32 %bitwise_and
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	br label %while.cond

while.cond:
	%rng_seed = load i32, i32* @rng_seed, align 4
	%srem = srem i32 %rng_seed, 100
	%ne = icmp ne i32 %srem, 0
	br i1 %ne, label %while.body, label %while.end

while.body:
	%rng_seed_2 = load i32, i32* @rng_seed, align 4
	%postfix_dec = sub i32 %rng_seed_2, 1
	store i32 %postfix_dec, i32* @rng_seed, align 4
	br label %while.cond

while.end:
	%funcCallRet = call i32 @_rng$$YGHXZ()
	%funcCallRet_2 = call i32 @_rng$$YGHXZ()
	%bitwise_and = and i32 %funcCallRet_2, 127
	%add = add i32 %bitwise_and, 100000
	br label %for.cond

for.cond:
	%a_24 = phi i32 [ %funcCallRet, %while.end ], [ %add_6, %for.body ]
	%i_7 = phi i32 [ 0, %while.end ], [ %prefix_inc, %for.body ]
	%slt = icmp slt i32 %i_7, %add
	br i1 %slt, label %for.body, label %for.end

for.body:
	%mul = mul i32 %a_24, 2
	%add_2 = add i32 %mul, 1
	%sdiv = sdiv i32 %add_2, 2
	%sdiv_2 = sdiv i32 %sdiv, 3
	%add_3 = add i32 %i_7, 1
	%sdiv_3 = sdiv i32 %sdiv_2, %add_3
	%add_4 = add i32 %sdiv_3, %i_7
	%sdiv_4 = sdiv i32 %add_4, 100
	%add_5 = add i32 %sdiv_4, %i_7
	%mul_2 = mul i32 %add_5, %add_5
	%sdiv_5 = sdiv i32 %mul_2, 10000
	%add_6 = add i32 %sdiv_5, 1
	%prefix_inc = add i32 %i_7, 1
	br label %for.cond

for.end:
	ret i32 0
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

