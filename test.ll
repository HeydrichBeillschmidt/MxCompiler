@a = global i32* null, align 4
@__const.main.str0 = private unnamed_addr constant [1 x i8] c"\00", align 1

define void @___init__$$YGXXZ() {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 20)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 4, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** @a, align 4
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%a = load i32*, i32** @a, align 4
	%arrayElemPtr = getelementptr i32, i32* %a, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%sizeTmp = mul i32 %arraySize, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %arraySize, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	br label %for.cond

for.cond:
	%i_16 = phi i32 [ 0, %entry ], [ %postfix_inc, %for.body ]
	%a_2 = load i32*, i32** @a, align 4
	%arrayElemPtr_2 = getelementptr i32, i32* %a_2, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%slt = icmp slt i32 %i_16, %arraySize_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%a_3 = load i32*, i32** @a, align 4
	%elementPtr = getelementptr i32, i32* %a_3, i32 %i_16
	store i32 0, i32* %elementPtr, align 4
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtr, i32 %i_16
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* %elementPtr_2, align 4
	%postfix_inc = add i32 %i_16, 1
	br label %for.cond

for.end:
	br label %for.cond_2

for.cond_2:
	%i_15 = phi i32 [ 0, %for.end ], [ %postfix_inc_2, %for.body_2 ]
	%a_4 = load i32*, i32** @a, align 4
	%arrayElemPtr_3 = getelementptr i32, i32* %a_4, i32 -1
	%arraySize_3 = load i32, i32* %arrayElemPtr_3, align 4
	%slt_2 = icmp slt i32 %i_15, %arraySize_3
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%a_5 = load i32*, i32** @a, align 4
	%elementPtr_3 = getelementptr i32, i32* %a_5, i32 %i_15
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%funcCallRet_2 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_3)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_2)
	%postfix_inc_2 = add i32 %i_15, 1
	br label %for.cond_2

for.end_2:
	%__const.main.str0 = getelementptr [1 x i8], [1 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %__const.main.str0)
	store i32* %arrayHeadPtr, i32** @a, align 4
	br label %for.cond_3

for.cond_3:
	%i_14 = phi i32 [ 0, %for.end_2 ], [ %postfix_inc_3, %for.body_3 ]
	%a_7 = load i32*, i32** @a, align 4
	%arrayElemPtr_4 = getelementptr i32, i32* %a_7, i32 -1
	%arraySize_4 = load i32, i32* %arrayElemPtr_4, align 4
	%slt_3 = icmp slt i32 %i_14, %arraySize_4
	br i1 %slt_3, label %for.body_3, label %for.end_3

for.body_3:
	%a_8 = load i32*, i32** @a, align 4
	%elementPtr_4 = getelementptr i32, i32* %a_8, i32 %i_14
	%arrayElement_4 = load i32, i32* %elementPtr_4, align 4
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_4)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_3)
	%postfix_inc_3 = add i32 %i_14, 1
	br label %for.cond_3

for.end_3:
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

