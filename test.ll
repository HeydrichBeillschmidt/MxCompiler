@p = global i32 0, align 4
@__const.main.str2 = private unnamed_addr constant [3 x i8] c") \00", align 1
@i = global i32 0, align 4
@__const.main.str1 = private unnamed_addr constant [2 x i8] c"(\00", align 1
@__const.main.str0 = private unnamed_addr constant [4 x i8] c"<< \00", align 1
@k = global i32 0, align 4
@n = global i32 0, align 4
@__const.main.str4 = private unnamed_addr constant [4 x i8] c">> \00", align 1
@__const.main.str3 = private unnamed_addr constant [2 x i8] c" \00", align 1

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
	%p = load i32, i32* @p, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @p, align 4
	%k = load i32, i32* @k, align 4
	%funcCallRet_3 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_3, i32* @k, align 4
	%p_2 = load i32, i32* @p, align 4
	%k_2 = load i32, i32* @k, align 4
	%sub = sub i32 %p_2, %k_2
	%sgt = icmp sgt i32 %sub, 1
	br i1 %sgt, label %if.then, label %if.end

if.then:
	%__const.main.str0 = getelementptr [4 x i8], [4 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str0)
	br label %if.end

if.end:
	%i = load i32, i32* @i, align 4
	%p_3 = load i32, i32* @p, align 4
	%k_3 = load i32, i32* @k, align 4
	%sub_2 = sub i32 %p_3, %k_3
	store i32 %sub_2, i32* @i, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* @i, align 4
	%p_4 = load i32, i32* @p, align 4
	%k_4 = load i32, i32* @k, align 4
	%add = add i32 %p_4, %k_4
	%sle = icmp sle i32 %i_2, %add
	br i1 %sle, label %for.body, label %for.end

logicalAnd_branch:
	%i_4 = load i32, i32* @i, align 4
	%n_2 = load i32, i32* @n, align 4
	%sle_3 = icmp sle i32 %i_4, %n_2
	store i1 %sle_3, i1* %logicalAnd_tmpAddr, align 1
	br label %logicalAnd_end

logicalAnd_end:
	%logical_and = load i1, i1* %logicalAnd_tmpAddr, align 1
	br i1 %logical_and, label %if.then_3, label %if.end_3

if.then_2:
	%__const.main.str1 = getelementptr [2 x i8], [2 x i8]* @__const.main.str1, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str1)
	%i_6 = load i32, i32* @i, align 4
	%funcCallRet_4 = call i8* @_toString$$YGPADH$Z(i32 %i_6)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_4)
	%__const.main.str2 = getelementptr [3 x i8], [3 x i8]* @__const.main.str2, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str2)
	br label %if.end_2

if.else:
	%i_7 = load i32, i32* @i, align 4
	call void @_printInt$$YGXH$Z(i32 %i_7)
	%__const.main.str3 = getelementptr [2 x i8], [2 x i8]* @__const.main.str3, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str3)
	br label %if.end_2

if.end_2:
	br label %if.end_3

if.then_3:
	%i_5 = load i32, i32* @i, align 4
	%p_5 = load i32, i32* @p, align 4
	%eq = icmp eq i32 %i_5, %p_5
	br i1 %eq, label %if.then_2, label %if.else

if.end_3:
	br label %for.inc

for.body:
	%i_3 = load i32, i32* @i, align 4
	%sle_2 = icmp sle i32 1, %i_3
	%logicalAnd_tmpAddr = alloca i1, align 1
	store i1 %sle_2, i1* %logicalAnd_tmpAddr, align 1
	br i1 %sle_2, label %logicalAnd_branch, label %logicalAnd_end

for.inc:
	%i_8 = load i32, i32* @i, align 4
	%postfix_inc = add i32 %i_8, 1
	store i32 %postfix_inc, i32* @i, align 4
	br label %for.cond

for.end:
	%p_6 = load i32, i32* @p, align 4
	%k_5 = load i32, i32* @k, align 4
	%add_2 = add i32 %p_6, %k_5
	%n_3 = load i32, i32* @n, align 4
	%slt = icmp slt i32 %add_2, %n_3
	br i1 %slt, label %if.then_4, label %if.end_4

if.then_4:
	%__const.main.str4 = getelementptr [4 x i8], [4 x i8]* @__const.main.str4, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str4)
	br label %if.end_4

if.end_4:
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

