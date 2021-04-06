@r = global i32 0, align 4
@c = global i32 0, align 4
@i = global i32 0, align 4
@j = global i32 0, align 4
@n = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define i32 @_abs$$YGHH$Z(i32 %c) {
entry:
	%retval = alloca i32, align 4
	%c.addr = alloca i32, align 4
	store i32 %c, i32* %c.addr, align 4
	%c_2 = load i32, i32* %c.addr, align 4
	%sgt = icmp sgt i32 %c_2, 0
	br i1 %sgt, label %if.then, label %if.end

if.then:
	%c_3 = load i32, i32* %c.addr, align 4
	store i32 %c_3, i32* %retval, align 4
	br label %return

if.end:
	%c_4 = load i32, i32* %c.addr, align 4
	%prefix_neg = sub i32 0, %c_4
	store i32 %prefix_neg, i32* %retval, align 4
	br label %return

return:
	%returnValue = load i32, i32* %retval, align 4
	ret i32 %returnValue
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%retval = alloca i32, align 4
	%i = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* @i, align 4
	%slt = icmp slt i32 %i_2, 5
	br i1 %slt, label %for.body_2, label %for.end_2

for.cond_2:
	%j_2 = load i32, i32* @j, align 4
	%slt_2 = icmp slt i32 %j_2, 5
	br i1 %slt_2, label %for.body, label %for.end

if.then:
	%r = load i32, i32* @r, align 4
	%i_3 = load i32, i32* @i, align 4
	store i32 %i_3, i32* @r, align 4
	%c = load i32, i32* @c, align 4
	%j_3 = load i32, i32* @j, align 4
	store i32 %j_3, i32* @c, align 4
	br label %if.end

if.end:
	br label %for.inc

for.body:
	%n = load i32, i32* @n, align 4
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @n, align 4
	%n_2 = load i32, i32* @n, align 4
	%eq = icmp eq i32 %n_2, 1
	br i1 %eq, label %if.then, label %if.end

for.inc:
	%j_4 = load i32, i32* @j, align 4
	%postfix_inc = add i32 %j_4, 1
	store i32 %postfix_inc, i32* @j, align 4
	br label %for.cond_2

for.end:
	br label %for.inc_2

for.body_2:
	%j = load i32, i32* @j, align 4
	store i32 0, i32* @j, align 4
	br label %for.cond_2

for.inc_2:
	%i_4 = load i32, i32* @i, align 4
	%postfix_inc_2 = add i32 %i_4, 1
	store i32 %postfix_inc_2, i32* @i, align 4
	br label %for.cond

for.end_2:
	%r_2 = load i32, i32* @r, align 4
	%sub = sub i32 2, %r_2
	%funcCallRet_2 = call i32 @_abs$$YGHH$Z(i32 %sub)
	%c_2 = load i32, i32* @c, align 4
	%sub_2 = sub i32 2, %c_2
	%funcCallRet_3 = call i32 @_abs$$YGHH$Z(i32 %sub_2)
	%add = add i32 %funcCallRet_2, %funcCallRet_3
	call void @_printInt$$YGXH$Z(i32 %add)
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

