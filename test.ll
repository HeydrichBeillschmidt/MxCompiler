define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define i32 @_qpow$$YGHHHH$Z(i32 %a, i32 %p, i32 %mod) {
entry:
	%malloc_6 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%y.addr = bitcast i8* %malloc_6 to i32*
	%malloc_5 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%t.addr = bitcast i8* %malloc_5 to i32*
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%a.addr = bitcast i8* %malloc_2 to i32*
	store i32 %a, i32* %a.addr, align 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%p.addr = bitcast i8* %malloc_3 to i32*
	store i32 %p, i32* %p.addr, align 4
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%mod.addr = bitcast i8* %malloc_4 to i32*
	store i32 %mod, i32* %mod.addr, align 4
	store i32 1, i32* %t.addr, align 4
	%a_2 = load i32, i32* %a.addr, align 4
	store i32 %a_2, i32* %y.addr, align 4
	br label %while.cond

while.cond:
	%p_2 = load i32, i32* %p.addr, align 4
	%sgt = icmp sgt i32 %p_2, 0
	br i1 %sgt, label %while.body, label %while.end

if.then:
	%t = load i32, i32* %t.addr, align 4
	%t_2 = load i32, i32* %t.addr, align 4
	%y = load i32, i32* %y.addr, align 4
	%mul = mul i32 %t_2, %y
	%mod_2 = load i32, i32* %mod.addr, align 4
	%srem = srem i32 %mul, %mod_2
	store i32 %srem, i32* %t.addr, align 4
	br label %if.end

if.end:
	%y_2 = load i32, i32* %y.addr, align 4
	%y_3 = load i32, i32* %y.addr, align 4
	%y_4 = load i32, i32* %y.addr, align 4
	%mul_2 = mul i32 %y_3, %y_4
	%mod_3 = load i32, i32* %mod.addr, align 4
	%srem_2 = srem i32 %mul_2, %mod_3
	store i32 %srem_2, i32* %y.addr, align 4
	%p_4 = load i32, i32* %p.addr, align 4
	%p_5 = load i32, i32* %p.addr, align 4
	%sdiv = sdiv i32 %p_5, 2
	store i32 %sdiv, i32* %p.addr, align 4
	br label %while.cond

while.body:
	%p_3 = load i32, i32* %p.addr, align 4
	%bitwise_and = and i32 %p_3, 1
	%eq = icmp eq i32 %bitwise_and, 1
	br i1 %eq, label %if.then, label %if.end

while.end:
	%t_3 = load i32, i32* %t.addr, align 4
	store i32 %t_3, i32* %retval, align 4
	br label %return

return:
	%returnValue = load i32, i32* %retval, align 4
	ret i32 %returnValue
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	%funcCallRet_2 = call i32 @_qpow$$YGHHHH$Z(i32 2, i32 10, i32 10000)
	%funcCallRet = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	store i32 0, i32* %retval, align 4
	br label %return

return:
	%returnValue = load i32, i32* %retval, align 4
	ret i32 %returnValue
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

