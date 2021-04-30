@a = global i32* null, align 4
@.const.main.str1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.const.main.str0 = private unnamed_addr constant [2 x i8] c" \00", align 1
@n = global i32 10000, align 4

define void @___init__$$YGXXZ() {
entry:
	%sizeTmp = mul i32 10100, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 10100, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** @a, align 4
	ret void
}

define i32 @_qsrt$$YGHHH$Z(i32 %l, i32 %r) {
entry:
	%a = load i32*, i32** @a, align 4
	%add = add i32 %l, %r
	%sdiv = sdiv i32 %add, 2
	%elementPtr = getelementptr i32, i32* %a, i32 %sdiv
	%arrayElement = load i32, i32* %elementPtr, align 4
	br label %while.cond

while.cond:
	%j_12 = phi i32 [ %r, %entry ], [ %j_10, %if.end ]
	%temp_3 = phi i32 [ 0, %entry ], [ %temp_2, %if.end ]
	%i_12 = phi i32 [ %l, %entry ], [ %i_10, %if.end ]
	%sle = icmp sle i32 %i_12, %j_12
	br i1 %sle, label %while.body_3, label %while.end_3

while.cond_2:
	%i_11 = phi i32 [ %i_12, %while.body_3 ], [ %postfix_inc, %while.body ]
	%a_2 = load i32*, i32** @a, align 4
	%elementPtr_2 = getelementptr i32, i32* %a_2, i32 %i_11
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%slt = icmp slt i32 %arrayElement_2, %arrayElement
	br i1 %slt, label %while.body, label %while.end

while.body:
	%postfix_inc = add i32 %i_11, 1
	br label %while.cond_2

while.end:
	br label %while.cond_3

while.cond_3:
	%j_11 = phi i32 [ %j_12, %while.end ], [ %postfix_dec, %while.body_2 ]
	%a_3 = load i32*, i32** @a, align 4
	%elementPtr_3 = getelementptr i32, i32* %a_3, i32 %j_11
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%sgt = icmp sgt i32 %arrayElement_3, %arrayElement
	br i1 %sgt, label %while.body_2, label %while.end_2

while.body_2:
	%postfix_dec = sub i32 %j_11, 1
	br label %while.cond_3

while.end_2:
	%sle_2 = icmp sle i32 %i_11, %j_11
	br i1 %sle_2, label %if.then, label %if.end

if.then:
	%a_4 = load i32*, i32** @a, align 4
	%elementPtr_4 = getelementptr i32, i32* %a_4, i32 %i_11
	%arrayElement_4 = load i32, i32* %elementPtr_4, align 4
	%a_5 = load i32*, i32** @a, align 4
	%elementPtr_5 = getelementptr i32, i32* %a_5, i32 %i_11
	%a_6 = load i32*, i32** @a, align 4
	%elementPtr_6 = getelementptr i32, i32* %a_6, i32 %j_11
	%arrayElement_6 = load i32, i32* %elementPtr_6, align 4
	store i32 %arrayElement_6, i32* %elementPtr_5, align 4
	%a_7 = load i32*, i32** @a, align 4
	%elementPtr_7 = getelementptr i32, i32* %a_7, i32 %j_11
	store i32 %arrayElement_4, i32* %elementPtr_7, align 4
	%postfix_inc_2 = add i32 %i_11, 1
	%postfix_dec_2 = sub i32 %j_11, 1
	br label %if.end

if.end:
	%j_10 = phi i32 [ %postfix_dec_2, %if.then ], [ %j_11, %while.end_2 ]
	%temp_2 = phi i32 [ %arrayElement_4, %if.then ], [ %temp_3, %while.end_2 ]
	%i_10 = phi i32 [ %postfix_inc_2, %if.then ], [ %i_11, %while.end_2 ]
	br label %while.cond

while.body_3:
	br label %while.cond_2

while.end_3:
	%slt_2 = icmp slt i32 %l, %j_12
	br i1 %slt_2, label %if.then_2, label %if.end_2

if.then_2:
	%funcCallRet = call i32 @_qsrt$$YGHHH$Z(i32 %l, i32 %j_12)
	br label %if.end_2

if.end_2:
	%slt_3 = icmp slt i32 %i_12, %r
	br i1 %slt_3, label %if.then_3, label %if.end_3

if.then_3:
	%funcCallRet_2 = call i32 @_qsrt$$YGHHH$Z(i32 %i_12, i32 %r)
	br label %if.end_3

if.end_3:
	ret i32 0
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	br label %for.cond

for.cond:
	%i_10 = phi i32 [ 1, %entry ], [ %postfix_inc, %for.body ]
	%n = load i32, i32* @n, align 4
	%sle = icmp sle i32 %i_10, %n
	br i1 %sle, label %for.body, label %for.end

for.body:
	%a = load i32*, i32** @a, align 4
	%elementPtr = getelementptr i32, i32* %a, i32 %i_10
	%n_2 = load i32, i32* @n, align 4
	%add = add i32 %n_2, 1
	%sub = sub i32 %add, %i_10
	store i32 %sub, i32* %elementPtr, align 4
	%postfix_inc = add i32 %i_10, 1
	br label %for.cond

for.end:
	%n_3 = load i32, i32* @n, align 4
	%funcCallRet = call i32 @_qsrt$$YGHHH$Z(i32 1, i32 %n_3)
	br label %for.cond_2

for.cond_2:
	%i_11 = phi i32 [ 1, %for.end ], [ %postfix_inc_2, %for.body_2 ]
	%n_4 = load i32, i32* @n, align 4
	%sle_2 = icmp sle i32 %i_11, %n_4
	br i1 %sle_2, label %for.body_2, label %for.end_2

for.body_2:
	%a_2 = load i32*, i32** @a, align 4
	%elementPtr_2 = getelementptr i32, i32* %a_2, i32 %i_11
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%funcCallRet_2 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_2)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_2)
	%.const.main.str0 = getelementptr [2 x i8], [2 x i8]* @.const.main.str0, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %.const.main.str0)
	%postfix_inc_2 = add i32 %i_11, 1
	br label %for.cond_2

for.end_2:
	%.const.main.str1 = getelementptr [2 x i8], [2 x i8]* @.const.main.str1, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %.const.main.str1)
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

