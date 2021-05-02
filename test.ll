@a = global i32* null, align 4
@i = global i32 0, align 4
@n = global i32 0, align 4

define i32 @main() {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 84)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 20, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	store i32* %arrayHeadPtrUnguarded, i32** @a, align 4
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
	%a = load i32*, i32** @a, align 4
	%i_3 = load i32, i32* @i, align 4
	%elementPtr = getelementptr i32, i32* %a, i32 %i_3
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* %elementPtr, align 4
	%i_4 = load i32, i32* @i, align 4
	%postfix_inc = add i32 %i_4, 1
	store i32 %postfix_inc, i32* @i, align 4
	br label %for.cond

for.end:
	%n_3 = load i32, i32* @n, align 4
	store i32 %n_3, i32* @i, align 4
	br label %for.cond_2

for.cond_2:
	%i_6 = load i32, i32* @i, align 4
	%sgt = icmp sgt i32 %i_6, 0
	br i1 %sgt, label %for.body_2, label %for.end_2

if.then:
	%i_8 = load i32, i32* @i, align 4
	%funcCallRet_4 = call i8* @_toString$$YGPADH$Z(i32 %i_8)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_4)
	br label %return

if.end:
	%i_10 = load i32, i32* @i, align 4
	%sdiv = sdiv i32 %i_10, 2
	store i32 %sdiv, i32* @i, align 4
	br label %for.cond_2

for.body_2:
	%i_7 = load i32, i32* @i, align 4
	%sub = sub i32 %i_7, 1
	br label %for.cond_3

for.cond_3:
	%i_11 = phi i32 [ 0, %for.body_2 ], [ %postfix_inc_4, %if.end_3 ]
	%i_12 = phi i32 [ 0, %for.body_2 ], [ %postfix_inc_5, %if.end_3 ]
	%i_13 = phi i32 [ 1, %for.body_2 ], [ %postfix_inc_7, %if.end_3 ]
	%n_4 = load i32, i32* @n, align 4
	%sdiv_2 = sdiv i32 %n_4, %i_7
	%slt_2 = icmp slt i32 %i_11, %sdiv_2
	br i1 %slt_2, label %for.body_3, label %for.end_4

for.body_3:
	br label %for.cond_4

for.cond_4:
	%j = phi i32 [ 0, %for.body_3 ], [ %postfix_inc_2, %if.end_2 ]
	%j_2 = phi i32 [ %i_12, %for.body_3 ], [ %postfix_inc_3, %if.end_2 ]
	%j_3 = phi i32 [ %i_13, %for.body_3 ], [ %postfix_inc_6, %if.end_2 ]
	%flag = phi i1 [ 0, %for.body_3 ], [ %flag_2, %if.end_2 ]
	%slt_3 = icmp slt i32 %j, %sub
	br i1 %slt_3, label %for.body_4, label %for.end_3

for.body_4:
	%a_2 = load i32*, i32** @a, align 4
	%elementPtr_2 = getelementptr i32, i32* %a_2, i32 %j_2
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%a_3 = load i32*, i32** @a, align 4
	%elementPtr_3 = getelementptr i32, i32* %a_3, i32 %j_3
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%sgt_3 = icmp sgt i32 %arrayElement_2, %arrayElement_3
	br i1 %sgt_3, label %if.then_2, label %if.end_2

if.then_2:
	br label %if.end_2

if.end_2:
	%flag_2 = phi i1 [ 1, %if.then_2 ], [ %flag, %for.body_4 ]
	%postfix_inc_2 = add i32 %j, 1
	%postfix_inc_3 = add i32 %j_2, 1
	%postfix_inc_6 = add i32 %j_3, 1
	br label %for.cond_4

for.end_3:
	%prefix_logicalNot = xor i1 %flag, 1
	br i1 %prefix_logicalNot, label %if.then_3, label %if.end_3

if.then_3:
	br label %return_2

if.end_3:
	%postfix_inc_4 = add i32 %i_11, 1
	%postfix_inc_5 = add i32 %i_12, %i_7
	%postfix_inc_7 = add i32 %i_13, %i_7
	br label %for.cond_3

for.end_4:
	br label %return_2

return_2:
	%retval_3 = phi i32 [ 1, %if.then_3 ], [ 0, %for.end_4 ]
	%sgt_2 = icmp sgt i32 %retval_3, 0
	br i1 %sgt_2, label %if.then, label %if.end

for.end_2:
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

