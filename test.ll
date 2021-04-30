@a = global i32* null, align 4
@.const.main.str1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.const.main.str0 = private unnamed_addr constant [2 x i8] c" \00", align 1
@n = global i32 10000, align 4

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
	%i_10 = phi i32 [ %postfix_inc_2, %if.then ], [ %i_11, %while.end_2 ]
	br label %while.cond

while.body_3:
	br label %while.cond_2

while.end_3:
	%slt_2 = icmp slt i32 %l, %j_12
	br i1 %slt_2, label %if.then_2, label %if.end_2

if.then_2:
	%a_8 = load i32*, i32** @a, align 4
	%add_2 = add i32 %l, %j_12
	%sdiv_2 = sdiv i32 %add_2, 2
	%elementPtr_8 = getelementptr i32, i32* %a_8, i32 %sdiv_2
	%arrayElement_8 = load i32, i32* %elementPtr_8, align 4
	br label %while.cond_4

while.cond_4:
	%j_13 = phi i32 [ %j_12, %if.then_2 ], [ %j_15, %if.end_4 ]
	%i_13 = phi i32 [ %l, %if.then_2 ], [ %i_15, %if.end_4 ]
	%sle_3 = icmp sle i32 %i_13, %j_13
	br i1 %sle_3, label %while.body_4, label %while.end_6

while.body_4:
	br label %while.cond_5

while.cond_5:
	%i_14 = phi i32 [ %i_13, %while.body_4 ], [ %postfix_inc_3, %while.body_5 ]
	%a_9 = load i32*, i32** @a, align 4
	%elementPtr_9 = getelementptr i32, i32* %a_9, i32 %i_14
	%arrayElement_9 = load i32, i32* %elementPtr_9, align 4
	%slt_4 = icmp slt i32 %arrayElement_9, %arrayElement_8
	br i1 %slt_4, label %while.body_5, label %while.end_4

while.body_5:
	%postfix_inc_3 = add i32 %i_14, 1
	br label %while.cond_5

while.end_4:
	br label %while.cond_6

while.cond_6:
	%j_14 = phi i32 [ %j_13, %while.end_4 ], [ %postfix_dec_3, %while.body_6 ]
	%a_10 = load i32*, i32** @a, align 4
	%elementPtr_10 = getelementptr i32, i32* %a_10, i32 %j_14
	%arrayElement_10 = load i32, i32* %elementPtr_10, align 4
	%sgt_2 = icmp sgt i32 %arrayElement_10, %arrayElement_8
	br i1 %sgt_2, label %while.body_6, label %while.end_5

while.body_6:
	%postfix_dec_3 = sub i32 %j_14, 1
	br label %while.cond_6

while.end_5:
	%sle_4 = icmp sle i32 %i_14, %j_14
	br i1 %sle_4, label %if.then_4, label %if.end_4

if.then_4:
	%a_11 = load i32*, i32** @a, align 4
	%elementPtr_11 = getelementptr i32, i32* %a_11, i32 %i_14
	%arrayElement_11 = load i32, i32* %elementPtr_11, align 4
	%a_12 = load i32*, i32** @a, align 4
	%elementPtr_12 = getelementptr i32, i32* %a_12, i32 %i_14
	%a_13 = load i32*, i32** @a, align 4
	%elementPtr_13 = getelementptr i32, i32* %a_13, i32 %j_14
	%arrayElement_12 = load i32, i32* %elementPtr_13, align 4
	store i32 %arrayElement_12, i32* %elementPtr_12, align 4
	%a_14 = load i32*, i32** @a, align 4
	%elementPtr_14 = getelementptr i32, i32* %a_14, i32 %j_14
	store i32 %arrayElement_11, i32* %elementPtr_14, align 4
	%postfix_inc_4 = add i32 %i_14, 1
	%postfix_dec_4 = sub i32 %j_14, 1
	br label %if.end_4

if.end_4:
	%j_15 = phi i32 [ %postfix_dec_4, %if.then_4 ], [ %j_14, %while.end_5 ]
	%i_15 = phi i32 [ %postfix_inc_4, %if.then_4 ], [ %i_14, %while.end_5 ]
	br label %while.cond_4

while.end_6:
	%slt_5 = icmp slt i32 %l, %j_13
	br i1 %slt_5, label %if.then_5, label %if.end_5

if.then_5:
	%funcCallRet_3 = call i32 @_qsrt$$YGHHH$Z(i32 %l, i32 %j_13)
	br label %if.end_5

if.end_5:
	%slt_6 = icmp slt i32 %i_13, %j_12
	br i1 %slt_6, label %if.then_6, label %if.end_6

if.then_6:
	%funcCallRet_4 = call i32 @_qsrt$$YGHHH$Z(i32 %i_13, i32 %j_12)
	br label %if.end_6

if.end_6:
	br label %if.end_2

if.end_2:
	%slt_3 = icmp slt i32 %i_12, %r
	br i1 %slt_3, label %if.then_3, label %if.end_3

if.then_3:
	%a_15 = load i32*, i32** @a, align 4
	%add_3 = add i32 %i_12, %r
	%sdiv_3 = sdiv i32 %add_3, 2
	%elementPtr_15 = getelementptr i32, i32* %a_15, i32 %sdiv_3
	%arrayElement_13 = load i32, i32* %elementPtr_15, align 4
	br label %while.cond_7

while.cond_7:
	%j_16 = phi i32 [ %r, %if.then_3 ], [ %j_18, %if.end_7 ]
	%i_16 = phi i32 [ %i_12, %if.then_3 ], [ %i_18, %if.end_7 ]
	%sle_5 = icmp sle i32 %i_16, %j_16
	br i1 %sle_5, label %while.body_7, label %while.end_9

while.body_7:
	br label %while.cond_8

while.cond_8:
	%i_17 = phi i32 [ %i_16, %while.body_7 ], [ %postfix_inc_5, %while.body_8 ]
	%a_16 = load i32*, i32** @a, align 4
	%elementPtr_16 = getelementptr i32, i32* %a_16, i32 %i_17
	%arrayElement_14 = load i32, i32* %elementPtr_16, align 4
	%slt_7 = icmp slt i32 %arrayElement_14, %arrayElement_13
	br i1 %slt_7, label %while.body_8, label %while.end_7

while.body_8:
	%postfix_inc_5 = add i32 %i_17, 1
	br label %while.cond_8

while.end_7:
	br label %while.cond_9

while.cond_9:
	%j_17 = phi i32 [ %j_16, %while.end_7 ], [ %postfix_dec_5, %while.body_9 ]
	%a_17 = load i32*, i32** @a, align 4
	%elementPtr_17 = getelementptr i32, i32* %a_17, i32 %j_17
	%arrayElement_15 = load i32, i32* %elementPtr_17, align 4
	%sgt_3 = icmp sgt i32 %arrayElement_15, %arrayElement_13
	br i1 %sgt_3, label %while.body_9, label %while.end_8

while.body_9:
	%postfix_dec_5 = sub i32 %j_17, 1
	br label %while.cond_9

while.end_8:
	%sle_6 = icmp sle i32 %i_17, %j_17
	br i1 %sle_6, label %if.then_7, label %if.end_7

if.then_7:
	%a_18 = load i32*, i32** @a, align 4
	%elementPtr_18 = getelementptr i32, i32* %a_18, i32 %i_17
	%arrayElement_16 = load i32, i32* %elementPtr_18, align 4
	%a_19 = load i32*, i32** @a, align 4
	%elementPtr_19 = getelementptr i32, i32* %a_19, i32 %i_17
	%a_20 = load i32*, i32** @a, align 4
	%elementPtr_20 = getelementptr i32, i32* %a_20, i32 %j_17
	%arrayElement_17 = load i32, i32* %elementPtr_20, align 4
	store i32 %arrayElement_17, i32* %elementPtr_19, align 4
	%a_21 = load i32*, i32** @a, align 4
	%elementPtr_21 = getelementptr i32, i32* %a_21, i32 %j_17
	store i32 %arrayElement_16, i32* %elementPtr_21, align 4
	%postfix_inc_6 = add i32 %i_17, 1
	%postfix_dec_6 = sub i32 %j_17, 1
	br label %if.end_7

if.end_7:
	%j_18 = phi i32 [ %postfix_dec_6, %if.then_7 ], [ %j_17, %while.end_8 ]
	%i_18 = phi i32 [ %postfix_inc_6, %if.then_7 ], [ %i_17, %while.end_8 ]
	br label %while.cond_7

while.end_9:
	%slt_8 = icmp slt i32 %i_12, %j_16
	br i1 %slt_8, label %if.then_8, label %if.end_11

if.then_8:
	%a_22 = load i32*, i32** @a, align 4
	%add_4 = add i32 %i_12, %j_16
	%sdiv_4 = sdiv i32 %add_4, 2
	%elementPtr_22 = getelementptr i32, i32* %a_22, i32 %sdiv_4
	%arrayElement_18 = load i32, i32* %elementPtr_22, align 4
	br label %while.cond_10

while.cond_10:
	%j_19 = phi i32 [ %j_16, %if.then_8 ], [ %j_21, %if.end_8 ]
	%i_19 = phi i32 [ %i_12, %if.then_8 ], [ %i_21, %if.end_8 ]
	%sle_7 = icmp sle i32 %i_19, %j_19
	br i1 %sle_7, label %while.body_10, label %while.end_12

while.body_10:
	br label %while.cond_11

while.cond_11:
	%i_20 = phi i32 [ %i_19, %while.body_10 ], [ %postfix_inc_7, %while.body_11 ]
	%a_23 = load i32*, i32** @a, align 4
	%elementPtr_23 = getelementptr i32, i32* %a_23, i32 %i_20
	%arrayElement_19 = load i32, i32* %elementPtr_23, align 4
	%slt_9 = icmp slt i32 %arrayElement_19, %arrayElement_18
	br i1 %slt_9, label %while.body_11, label %while.end_10

while.body_11:
	%postfix_inc_7 = add i32 %i_20, 1
	br label %while.cond_11

while.end_10:
	br label %while.cond_12

while.cond_12:
	%j_20 = phi i32 [ %j_19, %while.end_10 ], [ %postfix_dec_7, %while.body_12 ]
	%a_24 = load i32*, i32** @a, align 4
	%elementPtr_24 = getelementptr i32, i32* %a_24, i32 %j_20
	%arrayElement_20 = load i32, i32* %elementPtr_24, align 4
	%sgt_4 = icmp sgt i32 %arrayElement_20, %arrayElement_18
	br i1 %sgt_4, label %while.body_12, label %while.end_11

while.body_12:
	%postfix_dec_7 = sub i32 %j_20, 1
	br label %while.cond_12

while.end_11:
	%sle_8 = icmp sle i32 %i_20, %j_20
	br i1 %sle_8, label %if.then_9, label %if.end_8

if.then_9:
	%a_25 = load i32*, i32** @a, align 4
	%elementPtr_25 = getelementptr i32, i32* %a_25, i32 %i_20
	%arrayElement_21 = load i32, i32* %elementPtr_25, align 4
	%a_26 = load i32*, i32** @a, align 4
	%elementPtr_26 = getelementptr i32, i32* %a_26, i32 %i_20
	%a_27 = load i32*, i32** @a, align 4
	%elementPtr_27 = getelementptr i32, i32* %a_27, i32 %j_20
	%arrayElement_22 = load i32, i32* %elementPtr_27, align 4
	store i32 %arrayElement_22, i32* %elementPtr_26, align 4
	%a_28 = load i32*, i32** @a, align 4
	%elementPtr_28 = getelementptr i32, i32* %a_28, i32 %j_20
	store i32 %arrayElement_21, i32* %elementPtr_28, align 4
	%postfix_inc_8 = add i32 %i_20, 1
	%postfix_dec_8 = sub i32 %j_20, 1
	br label %if.end_8

if.end_8:
	%j_21 = phi i32 [ %postfix_dec_8, %if.then_9 ], [ %j_20, %while.end_11 ]
	%i_21 = phi i32 [ %postfix_inc_8, %if.then_9 ], [ %i_20, %while.end_11 ]
	br label %while.cond_10

while.end_12:
	%slt_10 = icmp slt i32 %i_12, %j_19
	br i1 %slt_10, label %if.then_10, label %if.end_9

if.then_10:
	%funcCallRet_5 = call i32 @_qsrt$$YGHHH$Z(i32 %i_12, i32 %j_19)
	br label %if.end_9

if.end_9:
	%slt_11 = icmp slt i32 %i_19, %j_16
	br i1 %slt_11, label %if.then_11, label %if.end_10

if.then_11:
	%funcCallRet_6 = call i32 @_qsrt$$YGHHH$Z(i32 %i_19, i32 %j_16)
	br label %if.end_10

if.end_10:
	br label %if.end_11

if.end_11:
	%slt_12 = icmp slt i32 %i_16, %r
	br i1 %slt_12, label %if.then_12, label %if.end_12

if.then_12:
	%funcCallRet_7 = call i32 @_qsrt$$YGHHH$Z(i32 %i_16, i32 %r)
	br label %if.end_12

if.end_12:
	br label %if.end_3

if.end_3:
	ret i32 0
}

define i32 @main() {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 40404)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 10100, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	store i32* %arrayHeadPtrUnguarded, i32** @a, align 4
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

