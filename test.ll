@p = global i32 0, align 4
@q = global i32 0, align 4
@r = global i32 0, align 4
@x = global i32 0, align 4
@y = global i32 0, align 4
@i = global i32 0, align 4
@__const.main.str1 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@z = global i32 0, align 4
@__const.main.str0 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
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
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @n, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* @i, align 4
	%n_2 = load i32, i32* @n, align 4
	%slt = icmp slt i32 %i_2, %n_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @p, align 4
	%funcCallRet_3 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_3, i32* @q, align 4
	%funcCallRet_4 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_4, i32* @r, align 4
	%x_2 = load i32, i32* @x, align 4
	%p_2 = load i32, i32* @p, align 4
	%add = add i32 %x_2, %p_2
	store i32 %add, i32* @x, align 4
	%y_2 = load i32, i32* @y, align 4
	%q_2 = load i32, i32* @q, align 4
	%add_2 = add i32 %y_2, %q_2
	store i32 %add_2, i32* @y, align 4
	%z_2 = load i32, i32* @z, align 4
	%r_2 = load i32, i32* @r, align 4
	%add_3 = add i32 %z_2, %r_2
	store i32 %add_3, i32* @z, align 4
	br label %for.inc

for.inc:
	%i_3 = load i32, i32* @i, align 4
	%postfix_inc = add i32 %i_3, 1
	store i32 %postfix_inc, i32* @i, align 4
	br label %for.cond

for.end:
	%x_3 = load i32, i32* @x, align 4
	%eq = icmp eq i32 %x_3, 0
	br i1 %eq, label %logicalAnd_branch, label %logicalAnd_end

logicalAnd_branch:
	%y_3 = load i32, i32* @y, align 4
	%eq_2 = icmp eq i32 %y_3, 0
	br i1 %eq_2, label %logicalAnd_branch2, label %logicalAnd_end

logicalAnd_branch2:
	%z_3 = load i32, i32* @z, align 4
	%eq_3 = icmp eq i32 %z_3, 0
	br label %logicalAnd_end

logicalAnd_end:
	%logical_and = phi i1 [ 0, %for.end ], [ %eq_2, %logicalAnd_branch ], [ %eq_3, %logicalAnd_branch2 ]
	br i1 %logical_and, label %if.then, label %if.else

if.then:
	%__const.main.str0 = getelementptr [4 x i8], [4 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str0)
	br label %if.end

if.else:
	%__const.main.str1 = getelementptr [3 x i8], [3 x i8]* @__const.main.str1, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str1)
	br label %if.end

if.end:
	br label %return

return:
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

