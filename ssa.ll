define i32 @_gcd3$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd2$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_gcd5$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd2$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define i32 @_gcd$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd5$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define i32 @_gcd1$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define i32 @_gcd4$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define i32 @_gcd2$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%srem = srem i32 %x, %y
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.else

if.then:
	br label %return

if.else:
	%srem_2 = srem i32 %x, %y
	%funcCallRet = call i32 @_gcd1$$YGHHH$Z(i32 %y, i32 %srem_2)
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %funcCallRet, %if.else ]
	ret i32 %retval_2
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet_2 = call i32 @_gcd$$YGHHH$Z(i32 10, i32 1)
	%funcCallRet = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	%funcCallRet_4 = call i32 @_gcd$$YGHHH$Z(i32 34986, i32 3087)
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_4)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_3)
	%funcCallRet_6 = call i32 @_gcd$$YGHHH$Z(i32 2907, i32 1539)
	%funcCallRet_5 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_6)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_5)
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

