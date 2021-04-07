@a = global i32* null, align 4
@__const.main.str0 = private unnamed_addr constant [1 x i8] c"\00", align 1

define void @___init__$$YGXXZ() {
entry:
	%sizeTmp = mul i32 4, 32
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 4, i32* %mallocInt32Ptr, align 4
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
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 32)
	%i.addr = bitcast i8* %malloc_4 to i32*
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 32)
	%b.addr = bitcast i8* %malloc_2 to i32***
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 32)
	%retval = bitcast i8* %malloc to i32*
	%sizeTmp = mul i32 4, 32
	%size = add i32 %sizeTmp, 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc_3 to i32*
	store i32 4, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32**
	store i32** %arrayHeadPtr, i32*** %b.addr, align 4
	%b = load i32**, i32*** %b.addr, align 4
	%elementPtr = getelementptr i32*, i32** %b, i32 0
	%arrayElement = load i32*, i32** %elementPtr, align 4
	%a = load i32*, i32** @a, align 4
	store i32* %a, i32** %elementPtr, align 4
	%b_2 = load i32**, i32*** %b.addr, align 4
	%elementPtr_2 = getelementptr i32*, i32** %b_2, i32 1
	%arrayElement_2 = load i32*, i32** %elementPtr_2, align 4
	%a_2 = load i32*, i32** @a, align 4
	store i32* %a_2, i32** %elementPtr_2, align 4
	%b_3 = load i32**, i32*** %b.addr, align 4
	%elementPtr_3 = getelementptr i32*, i32** %b_3, i32 2
	%arrayElement_3 = load i32*, i32** %elementPtr_3, align 4
	%a_3 = load i32*, i32** @a, align 4
	store i32* %a_3, i32** %elementPtr_3, align 4
	%b_4 = load i32**, i32*** %b.addr, align 4
	%elementPtr_4 = getelementptr i32*, i32** %b_4, i32 3
	%arrayElement_4 = load i32*, i32** %elementPtr_4, align 4
	%a_4 = load i32*, i32** @a, align 4
	store i32* %a_4, i32** %elementPtr_4, align 4
	%b_5 = load i32**, i32*** %b.addr, align 4
	%castToIntPtr = bitcast i32** %b_5 to i32*
	%arrayElemPtr = getelementptr i32, i32* %castToIntPtr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%funcCallRet = call i8* @_toString$$YGPADH$Z(i32 %arraySize)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	%i = load i32, i32* %i.addr, align 4
	store i32 0, i32* %i.addr, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* %i.addr, align 4
	%b_6 = load i32**, i32*** %b.addr, align 4
	%elementPtr_5 = getelementptr i32*, i32** %b_6, i32 0
	%arrayElement_5 = load i32*, i32** %elementPtr_5, align 4
	%arrayElemPtr_2 = getelementptr i32, i32* %arrayElement_5, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%slt = icmp slt i32 %i_2, %arraySize_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%b_7 = load i32**, i32*** %b.addr, align 4
	%elementPtr_6 = getelementptr i32*, i32** %b_7, i32 0
	%arrayElement_6 = load i32*, i32** %elementPtr_6, align 4
	%i_3 = load i32, i32* %i.addr, align 4
	%elementPtr_7 = getelementptr i32, i32* %arrayElement_6, i32 %i_3
	%arrayElement_7 = load i32, i32* %elementPtr_7, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* %elementPtr_7, align 4
	br label %for.inc

for.inc:
	%i_4 = load i32, i32* %i.addr, align 4
	%postfix_inc = add i32 %i_4, 1
	store i32 %postfix_inc, i32* %i.addr, align 4
	br label %for.cond

for.end:
	%i_5 = load i32, i32* %i.addr, align 4
	store i32 0, i32* %i.addr, align 4
	br label %for.cond_2

for.cond_2:
	%i_6 = load i32, i32* %i.addr, align 4
	%b_8 = load i32**, i32*** %b.addr, align 4
	%elementPtr_8 = getelementptr i32*, i32** %b_8, i32 1
	%arrayElement_8 = load i32*, i32** %elementPtr_8, align 4
	%arrayElemPtr_3 = getelementptr i32, i32* %arrayElement_8, i32 -1
	%arraySize_3 = load i32, i32* %arrayElemPtr_3, align 4
	%slt_2 = icmp slt i32 %i_6, %arraySize_3
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%b_9 = load i32**, i32*** %b.addr, align 4
	%elementPtr_9 = getelementptr i32*, i32** %b_9, i32 1
	%arrayElement_9 = load i32*, i32** %elementPtr_9, align 4
	%i_7 = load i32, i32* %i.addr, align 4
	%elementPtr_10 = getelementptr i32, i32* %arrayElement_9, i32 %i_7
	%arrayElement_10 = load i32, i32* %elementPtr_10, align 4
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_10)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_3)
	br label %for.inc_2

for.inc_2:
	%i_8 = load i32, i32* %i.addr, align 4
	%postfix_inc_2 = add i32 %i_8, 1
	store i32 %postfix_inc_2, i32* %i.addr, align 4
	br label %for.cond_2

for.end_2:
	%__const.main.str0 = getelementptr [1 x i8], [1 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %__const.main.str0)
	%i_9 = load i32, i32* %i.addr, align 4
	store i32 0, i32* %i.addr, align 4
	br label %for.cond_3

for.cond_3:
	%i_10 = load i32, i32* %i.addr, align 4
	%b_10 = load i32**, i32*** %b.addr, align 4
	%elementPtr_11 = getelementptr i32*, i32** %b_10, i32 2
	%arrayElement_11 = load i32*, i32** %elementPtr_11, align 4
	%arrayElemPtr_4 = getelementptr i32, i32* %arrayElement_11, i32 -1
	%arraySize_4 = load i32, i32* %arrayElemPtr_4, align 4
	%slt_3 = icmp slt i32 %i_10, %arraySize_4
	br i1 %slt_3, label %for.body_3, label %for.end_3

for.body_3:
	%b_11 = load i32**, i32*** %b.addr, align 4
	%elementPtr_12 = getelementptr i32*, i32** %b_11, i32 2
	%arrayElement_12 = load i32*, i32** %elementPtr_12, align 4
	%i_11 = load i32, i32* %i.addr, align 4
	%elementPtr_13 = getelementptr i32, i32* %arrayElement_12, i32 %i_11
	%arrayElement_13 = load i32, i32* %elementPtr_13, align 4
	store i32 0, i32* %elementPtr_13, align 4
	br label %for.inc_3

for.inc_3:
	%i_12 = load i32, i32* %i.addr, align 4
	%postfix_inc_3 = add i32 %i_12, 1
	store i32 %postfix_inc_3, i32* %i.addr, align 4
	br label %for.cond_3

for.end_3:
	%i_13 = load i32, i32* %i.addr, align 4
	store i32 0, i32* %i.addr, align 4
	br label %for.cond_4

for.cond_4:
	%i_14 = load i32, i32* %i.addr, align 4
	%b_12 = load i32**, i32*** %b.addr, align 4
	%elementPtr_14 = getelementptr i32*, i32** %b_12, i32 3
	%arrayElement_14 = load i32*, i32** %elementPtr_14, align 4
	%arrayElemPtr_5 = getelementptr i32, i32* %arrayElement_14, i32 -1
	%arraySize_5 = load i32, i32* %arrayElemPtr_5, align 4
	%slt_4 = icmp slt i32 %i_14, %arraySize_5
	br i1 %slt_4, label %for.body_4, label %for.end_4

for.body_4:
	%b_13 = load i32**, i32*** %b.addr, align 4
	%elementPtr_15 = getelementptr i32*, i32** %b_13, i32 3
	%arrayElement_15 = load i32*, i32** %elementPtr_15, align 4
	%i_15 = load i32, i32* %i.addr, align 4
	%elementPtr_16 = getelementptr i32, i32* %arrayElement_15, i32 %i_15
	%arrayElement_16 = load i32, i32* %elementPtr_16, align 4
	%funcCallRet_4 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_16)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_4)
	br label %for.inc_4

for.inc_4:
	%i_16 = load i32, i32* %i.addr, align 4
	%postfix_inc_4 = add i32 %i_16, 1
	store i32 %postfix_inc_4, i32* %i.addr, align 4
	br label %for.cond_4

for.end_4:
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

