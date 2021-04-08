define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%c.addr = bitcast i8* %malloc_4 to i32*
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%b.addr = bitcast i8* %malloc_3 to i32*
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%a.addr = bitcast i8* %malloc_2 to i32*
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	store i32 5, i32* %a.addr, align 4
	%c = load i32, i32* %c.addr, align 4
	%a = load i32, i32* %a.addr, align 4
	%postfix_inc = add i32 %a, 1
	store i32 %postfix_inc, i32* %a.addr, align 4
	store i32 %a, i32* %c.addr, align 4
	%b = load i32, i32* %b.addr, align 4
	%c_2 = load i32, i32* %c.addr, align 4
	store i32 %c_2, i32* %b.addr, align 4
	%a_2 = load i32, i32* %a.addr, align 4
	store i32 %a_2, i32* %retval, align 4
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

