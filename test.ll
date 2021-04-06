@a = global i32 0, align 4
@m = global i32 0, align 4
@n = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%retval = alloca i32, align 4
	%n = load i32, i32* @n, align 4
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @n, align 4
	%m = load i32, i32* @m, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @m, align 4
	%a = load i32, i32* @a, align 4
	%funcCallRet_3 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_3, i32* @a, align 4
	%m_2 = load i32, i32* @m, align 4
	%a_2 = load i32, i32* @a, align 4
	%add = add i32 %m_2, %a_2
	%sub = sub i32 %add, 1
	%a_3 = load i32, i32* @a, align 4
	%sdiv = sdiv i32 %sub, %a_3
	%n_2 = load i32, i32* @n, align 4
	%a_4 = load i32, i32* @a, align 4
	%add_2 = add i32 %n_2, %a_4
	%sub_2 = sub i32 %add_2, 1
	%a_5 = load i32, i32* @a, align 4
	%sdiv_2 = sdiv i32 %sub_2, %a_5
	%mul = mul i32 %sdiv, %sdiv_2
	%funcCallRet_4 = call i8* @_toString$$YGPADH$Z(i32 %mul)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_4)
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

