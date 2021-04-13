define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define i32 @_gcd$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%retval$addr = alloca i32, align 4
	store i32 0, i32* %retval$addr, align 4
	%x.addr = alloca i32, align 4
	store i32 %x, i32* %x.addr, align 4
	%y.addr = alloca i32, align 4
	store i32 %y, i32* %y.addr, align 4
	%x_2 = load i32, i32* %x.addr, align 4
	%y_2 = load i32, i32* %y.addr, align 4
	%srem = srem i32 %x_2, %y_2
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	%y_3 = load i32, i32* %y.addr, align 4
	store i32 %y_3, i32* %retval$addr, align 4
	br label %return

if.else:
	%y_4 = load i32, i32* %y.addr, align 4
	%x_3 = load i32, i32* %x.addr, align 4
	%y_5 = load i32, i32* %y.addr, align 4
	%srem_2 = srem i32 %x_3, %y_5
	%funcCallRet = call i32 @_gcd$$YGHHH$Z(i32 %y_4, i32 %srem_2)
	store i32 %funcCallRet, i32* %retval$addr, align 4
	br label %return

if.end:
	br label %return

return:
	%retval = load i32, i32* %retval$addr, align 4
	ret i32 %retval
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%retval$addr = alloca i32, align 4
	store i32 0, i32* %retval$addr, align 4
	%funcCallRet_2 = call i32 @_gcd$$YGHHH$Z(i32 10, i32 1)
	%funcCallRet = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	%funcCallRet_4 = call i32 @_gcd$$YGHHH$Z(i32 34986, i32 3087)
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_4)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_3)
	%funcCallRet_6 = call i32 @_gcd$$YGHHH$Z(i32 2907, i32 1539)
	%funcCallRet_5 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_6)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_5)
	store i32 0, i32* %retval$addr, align 4
	br label %return

return:
	%retval = load i32, i32* %retval$addr, align 4
	ret i32 %retval
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

