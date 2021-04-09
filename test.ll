%class.rec = type { i32, i32 }

@a = global i32** null, align 4
@b = global %class.rec** null, align 4
@i = global i32 0, align 4
@j = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	%sizeTmp = mul i32 4, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 4, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32**
	store i32** %arrayHeadPtr, i32*** @a, align 4
	%sizeTmp_2 = mul i32 5, 4
	%size_2 = add i32 %sizeTmp_2, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size_2)
	%mallocInt32Ptr_2 = bitcast i8* %malloc_2 to i32*
	store i32 5, i32* %mallocInt32Ptr_2, align 4
	%arrayHeadPtrUnguarded_2 = getelementptr i32, i32* %mallocInt32Ptr_2, i32 1
	%arrayHeadPtr_2 = bitcast i32* %arrayHeadPtrUnguarded_2 to %class.rec**
	store %class.rec** %arrayHeadPtr_2, %class.rec*** @b, align 4
	br label %return

return:
	ret void
}

define void @_printNum$$YGXH$Z(i32 %num) {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%num.addr = bitcast i8* %malloc to i32*
	store i32 %num, i32* %num.addr, align 4
	%num_2 = load i32, i32* %num.addr, align 4
	%funcCallRet = call i8* @_toString$$YGPADH$Z(i32 %num_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	%i = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* @i, align 4
	%slt = icmp slt i32 %i_2, 4
	br i1 %slt, label %for.body, label %for.end

for.body:
	%a = load i32**, i32*** @a, align 4
	%i_3 = load i32, i32* @i, align 4
	%elementPtr = getelementptr i32*, i32** %a, i32 %i_3
	%arrayElement = load i32*, i32** %elementPtr, align 4
	%sizeTmp = mul i32 11, 4
	%size = add i32 %sizeTmp, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc_2 to i32*
	store i32 11, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** %elementPtr, align 4
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

for.cond_2:
	%i_6 = load i32, i32* @i, align 4
	%slt_2 = icmp slt i32 %i_6, 4
	br i1 %slt_2, label %for.body_3, label %for.end_3

for.cond_3:
	%j_2 = load i32, i32* @j, align 4
	%slt_3 = icmp slt i32 %j_2, 10
	br i1 %slt_3, label %for.body_2, label %for.end_2

for.body_2:
	%a_2 = load i32**, i32*** @a, align 4
	%i_7 = load i32, i32* @i, align 4
	%elementPtr_2 = getelementptr i32*, i32** %a_2, i32 %i_7
	%arrayElement_2 = load i32*, i32** %elementPtr_2, align 4
	%j_3 = load i32, i32* @j, align 4
	%elementPtr_3 = getelementptr i32, i32* %arrayElement_2, i32 %j_3
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	store i32 888, i32* %elementPtr_3, align 4
	br label %for.inc_2

for.inc_2:
	%j_4 = load i32, i32* @j, align 4
	%postfix_inc_2 = add i32 %j_4, 1
	store i32 %postfix_inc_2, i32* @j, align 4
	br label %for.cond_3

for.end_2:
	br label %for.inc_3

for.body_3:
	%j = load i32, i32* @j, align 4
	store i32 0, i32* @j, align 4
	br label %for.cond_3

for.inc_3:
	%i_8 = load i32, i32* @i, align 4
	%postfix_inc_3 = add i32 %i_8, 1
	store i32 %postfix_inc_3, i32* @i, align 4
	br label %for.cond_2

for.end_3:
	%i_9 = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond_4

for.cond_4:
	%i_10 = load i32, i32* @i, align 4
	%slt_4 = icmp slt i32 %i_10, 5
	br i1 %slt_4, label %for.body_4, label %for.end_4

for.body_4:
	%b = load %class.rec**, %class.rec*** @b, align 4
	%i_11 = load i32, i32* @i, align 4
	%elementPtr_4 = getelementptr %class.rec*, %class.rec** %b, i32 %i_11
	%arrayElement_4 = load %class.rec*, %class.rec** %elementPtr_4, align 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr = bitcast i8* %malloc_3 to %class.rec*
	store %class.rec* %castToClassPtr, %class.rec** %elementPtr_4, align 4
	%b_2 = load %class.rec**, %class.rec*** @b, align 4
	%i_12 = load i32, i32* @i, align 4
	%elementPtr_5 = getelementptr %class.rec*, %class.rec** %b_2, i32 %i_12
	%arrayElement_5 = load %class.rec*, %class.rec** %elementPtr_5, align 4
	%rec.num.addr = getelementptr %class.rec, %class.rec* %arrayElement_5, i32 0, i32 0
	%rec.num = load i32, i32* %rec.num.addr, align 4
	%prefix_neg = sub i32 0, 1
	store i32 %prefix_neg, i32* %rec.num.addr, align 4
	br label %for.inc_4

for.inc_4:
	%i_13 = load i32, i32* @i, align 4
	%postfix_inc_4 = add i32 %i_13, 1
	store i32 %postfix_inc_4, i32* @i, align 4
	br label %for.cond_4

for.end_4:
	%a_3 = load i32**, i32*** @a, align 4
	%elementPtr_6 = getelementptr i32*, i32** %a_3, i32 3
	%arrayElement_6 = load i32*, i32** %elementPtr_6, align 4
	%elementPtr_7 = getelementptr i32, i32* %arrayElement_6, i32 9
	%arrayElement_7 = load i32, i32* %elementPtr_7, align 4
	call void @_printNum$$YGXH$Z(i32 %arrayElement_7)
	%i_14 = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond_5

for.cond_5:
	%i_15 = load i32, i32* @i, align 4
	%sle = icmp sle i32 %i_15, 3
	br i1 %sle, label %for.body_6, label %for.end_6

for.cond_6:
	%j_6 = load i32, i32* @j, align 4
	%sle_2 = icmp sle i32 %j_6, 9
	br i1 %sle_2, label %for.body_5, label %for.end_5

for.body_5:
	%a_4 = load i32**, i32*** @a, align 4
	%i_16 = load i32, i32* @i, align 4
	%elementPtr_8 = getelementptr i32*, i32** %a_4, i32 %i_16
	%arrayElement_8 = load i32*, i32** %elementPtr_8, align 4
	%j_7 = load i32, i32* @j, align 4
	%elementPtr_9 = getelementptr i32, i32* %arrayElement_8, i32 %j_7
	%arrayElement_9 = load i32, i32* %elementPtr_9, align 4
	%i_17 = load i32, i32* @i, align 4
	%mul = mul i32 %i_17, 10
	%j_8 = load i32, i32* @j, align 4
	%add = add i32 %mul, %j_8
	store i32 %add, i32* %elementPtr_9, align 4
	br label %for.inc_5

for.inc_5:
	%j_9 = load i32, i32* @j, align 4
	%postfix_inc_5 = add i32 %j_9, 1
	store i32 %postfix_inc_5, i32* @j, align 4
	br label %for.cond_6

for.end_5:
	br label %for.inc_6

for.body_6:
	%j_5 = load i32, i32* @j, align 4
	store i32 0, i32* @j, align 4
	br label %for.cond_6

for.inc_6:
	%i_18 = load i32, i32* @i, align 4
	%postfix_inc_6 = add i32 %i_18, 1
	store i32 %postfix_inc_6, i32* @i, align 4
	br label %for.cond_5

for.end_6:
	%i_19 = load i32, i32* @i, align 4
	store i32 0, i32* @i, align 4
	br label %for.cond_7

for.cond_7:
	%i_20 = load i32, i32* @i, align 4
	%sle_3 = icmp sle i32 %i_20, 3
	br i1 %sle_3, label %for.body_8, label %for.end_8

for.cond_8:
	%j_11 = load i32, i32* @j, align 4
	%sle_4 = icmp sle i32 %j_11, 9
	br i1 %sle_4, label %for.body_7, label %for.end_7

for.body_7:
	%a_5 = load i32**, i32*** @a, align 4
	%i_21 = load i32, i32* @i, align 4
	%elementPtr_10 = getelementptr i32*, i32** %a_5, i32 %i_21
	%arrayElement_10 = load i32*, i32** %elementPtr_10, align 4
	%j_12 = load i32, i32* @j, align 4
	%elementPtr_11 = getelementptr i32, i32* %arrayElement_10, i32 %j_12
	%arrayElement_11 = load i32, i32* %elementPtr_11, align 4
	call void @_printNum$$YGXH$Z(i32 %arrayElement_11)
	br label %for.inc_7

for.inc_7:
	%j_13 = load i32, i32* @j, align 4
	%postfix_inc_7 = add i32 %j_13, 1
	store i32 %postfix_inc_7, i32* @j, align 4
	br label %for.cond_8

for.end_7:
	br label %for.inc_8

for.body_8:
	%j_10 = load i32, i32* @j, align 4
	store i32 0, i32* @j, align 4
	br label %for.cond_8

for.inc_8:
	%i_22 = load i32, i32* @i, align 4
	%postfix_inc_8 = add i32 %i_22, 1
	store i32 %postfix_inc_8, i32* @i, align 4
	br label %for.cond_7

for.end_8:
	%a_6 = load i32**, i32*** @a, align 4
	%elementPtr_12 = getelementptr i32*, i32** %a_6, i32 2
	%arrayElement_12 = load i32*, i32** %elementPtr_12, align 4
	%elementPtr_13 = getelementptr i32, i32* %arrayElement_12, i32 10
	%arrayElement_13 = load i32, i32* %elementPtr_13, align 4
	store i32 0, i32* %elementPtr_13, align 4
	%a_7 = load i32**, i32*** @a, align 4
	%elementPtr_14 = getelementptr i32*, i32** %a_7, i32 2
	%arrayElement_14 = load i32*, i32** %elementPtr_14, align 4
	%elementPtr_15 = getelementptr i32, i32* %arrayElement_14, i32 10
	%arrayElement_15 = load i32, i32* %elementPtr_15, align 4
	call void @_printNum$$YGXH$Z(i32 %arrayElement_15)
	%b_3 = load %class.rec**, %class.rec*** @b, align 4
	%elementPtr_16 = getelementptr %class.rec*, %class.rec** %b_3, i32 0
	%arrayElement_16 = load %class.rec*, %class.rec** %elementPtr_16, align 4
	%rec.num.addr_2 = getelementptr %class.rec, %class.rec* %arrayElement_16, i32 0, i32 0
	%rec.num_2 = load i32, i32* %rec.num.addr_2, align 4
	%prefix_neg_2 = sub i32 0, 2
	store i32 %prefix_neg_2, i32* %rec.num.addr_2, align 4
	%b_4 = load %class.rec**, %class.rec*** @b, align 4
	%a_8 = load i32**, i32*** @a, align 4
	%elementPtr_17 = getelementptr i32*, i32** %a_8, i32 2
	%arrayElement_17 = load i32*, i32** %elementPtr_17, align 4
	%elementPtr_18 = getelementptr i32, i32* %arrayElement_17, i32 10
	%arrayElement_18 = load i32, i32* %elementPtr_18, align 4
	%elementPtr_19 = getelementptr %class.rec*, %class.rec** %b_4, i32 %arrayElement_18
	%arrayElement_19 = load %class.rec*, %class.rec** %elementPtr_19, align 4
	%rec.num.addr_3 = getelementptr %class.rec, %class.rec* %arrayElement_19, i32 0, i32 0
	%rec.num_3 = load i32, i32* %rec.num.addr_3, align 4
	%prefix_neg_3 = sub i32 0, 10
	store i32 %prefix_neg_3, i32* %rec.num.addr_3, align 4
	%b_5 = load %class.rec**, %class.rec*** @b, align 4
	%elementPtr_20 = getelementptr %class.rec*, %class.rec** %b_5, i32 0
	%arrayElement_20 = load %class.rec*, %class.rec** %elementPtr_20, align 4
	%rec.num.addr_4 = getelementptr %class.rec, %class.rec* %arrayElement_20, i32 0, i32 0
	%rec.num_4 = load i32, i32* %rec.num.addr_4, align 4
	call void @_printNum$$YGXH$Z(i32 %rec.num_4)
	%b_6 = load %class.rec**, %class.rec*** @b, align 4
	%elementPtr_21 = getelementptr %class.rec*, %class.rec** %b_6, i32 1
	%arrayElement_21 = load %class.rec*, %class.rec** %elementPtr_21, align 4
	%rec.num.addr_5 = getelementptr %class.rec, %class.rec* %arrayElement_21, i32 0, i32 0
	%rec.num_5 = load i32, i32* %rec.num.addr_5, align 4
	call void @_printNum$$YGXH$Z(i32 %rec.num_5)
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

