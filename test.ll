@a = global i32* null, align 4
@i = global i32 0, align 4
@k = global i32 0, align 4
@m = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	%sizeTmp = mul i32 50, 32
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 50, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** @a, align 4
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%retval = alloca i32, align 4
	%m = load i32, i32* @m, align 4
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @m, align 4
	%k = load i32, i32* @k, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @k, align 4
	%i = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* @i, align 4
	%m_2 = load i32, i32* @m, align 4
	%slt = icmp slt i32 %i_2, %m_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%a = load i32*, i32** @a, align 4
	%i_3 = load i32, i32* @i, align 4
	%elementPtr = getelementptr i32, i32* %a, i32 %i_3
	%arrayElement = load i32, i32* %elementPtr, align 4
	%funcCallRet_3 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_3, i32* %elementPtr, align 4
	br label %for.inc

for.inc:
	%i_4 = load i32, i32* @i, align 4
	%postfix_inc = add i32 %i_4, 1
	store i32 %postfix_inc, i32* @i, align 4
	br label %for.cond

for.end:
	%i_5 = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond_2

logicalAnd_branch:
	%a_4 = load i32*, i32** @a, align 4
	%i_7 = load i32, i32* @i, align 4
	%elementPtr_4 = getelementptr i32, i32* %a_4, i32 %i_7
	%arrayElement_4 = load i32, i32* %elementPtr_4, align 4
	%sgt = icmp sgt i32 %arrayElement_4, 0
	store i1 %sgt, i1* %logicalAnd_tmpAddr, align 1
	br i1 %sgt, label %logicalAnd_branch2, label %logicalAnd_end

logicalAnd_branch2:
	%i_8 = load i32, i32* @i, align 4
	%m_3 = load i32, i32* @m, align 4
	%slt_2 = icmp slt i32 %i_8, %m_3
	store i1 %slt_2, i1* %logicalAnd_tmpAddr, align 1
	br label %logicalAnd_end

logicalAnd_end:
	%logical_and = load i1, i1* %logicalAnd_tmpAddr, align 1
	br i1 %logical_and, label %for.body_2, label %for.end_2

for.cond_2:
	%a_2 = load i32*, i32** @a, align 4
	%i_6 = load i32, i32* @i, align 4
	%elementPtr_2 = getelementptr i32, i32* %a_2, i32 %i_6
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%a_3 = load i32*, i32** @a, align 4
	%k_2 = load i32, i32* @k, align 4
	%sub = sub i32 %k_2, 1
	%elementPtr_3 = getelementptr i32, i32* %a_3, i32 %sub
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%sge = icmp sge i32 %arrayElement_2, %arrayElement_3
	%logicalAnd_tmpAddr = alloca i1, align 1
	store i1 %sge, i1* %logicalAnd_tmpAddr, align 1
	br i1 %sge, label %logicalAnd_branch, label %logicalAnd_end

for.body_2:
	br label %for.inc_2

for.inc_2:
	%i_9 = load i32, i32* @i, align 4
	%postfix_inc_2 = add i32 %i_9, 1
	store i32 %postfix_inc_2, i32* @i, align 4
	br label %for.cond_2

for.end_2:
	%i_10 = load i32, i32* @i, align 4
	call void @_printInt$$YGXH$Z(i32 %i_10)
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

