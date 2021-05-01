define i32 @main() {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 40004)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 10000, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	br label %for.cond

for.cond:
	%i = phi i32 [ 0, %entry ], [ %postfix_inc_4, %for.end_3 ]
	%slt = icmp slt i32 %i, 10
	br i1 %slt, label %for.body, label %for.end_4

for.body:
	%mul = mul i32 %i, 1000
	br label %for.cond_2

for.cond_2:
	%j = phi i32 [ 0, %for.body ], [ %postfix_inc_3, %for.end_2 ]
	%slt_2 = icmp slt i32 %j, 10
	br i1 %slt_2, label %for.body_2, label %for.end_3

for.body_2:
	%mul_2 = mul i32 %j, 100
	%add = add i32 %mul, %mul_2
	br label %for.cond_3

for.cond_3:
	%k = phi i32 [ 0, %for.body_2 ], [ %postfix_inc_2, %for.end ]
	%slt_3 = icmp slt i32 %k, 10
	br i1 %slt_3, label %for.body_3, label %for.end_2

for.body_3:
	%mul_3 = mul i32 %k, 10
	%add_2 = add i32 %add, %mul_3
	br label %for.cond_4

for.cond_4:
	%l = phi i32 [ 0, %for.body_3 ], [ %postfix_inc, %for.body_4 ]
	%slt_4 = icmp slt i32 %l, 10
	br i1 %slt_4, label %for.body_4, label %for.end

for.body_4:
	%add_3 = add i32 %add_2, %l
	%elementPtr = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 %add_3
	%add_4 = add i32 %i, %l
	store i32 %add_4, i32* %elementPtr, align 4
	%postfix_inc = add i32 %l, 1
	br label %for.cond_4

for.end:
	%postfix_inc_2 = add i32 %k, 1
	br label %for.cond_3

for.end_2:
	%postfix_inc_3 = add i32 %j, 1
	br label %for.cond_2

for.end_3:
	%postfix_inc_4 = add i32 %i, 1
	br label %for.cond

for.end_4:
	br label %for.cond_5

for.cond_5:
	%i_2 = phi i32 [ 0, %for.end_4 ], [ %postfix_inc_8, %for.end_7 ]
	%sum = phi i32 [ 0, %for.end_4 ], [ %sum_2, %for.end_7 ]
	%slt_5 = icmp slt i32 %i_2, 10
	br i1 %slt_5, label %for.body_5, label %for.end_8

for.body_5:
	%mul_4 = mul i32 %i_2, 1000
	br label %for.cond_6

for.cond_6:
	%sum_2 = phi i32 [ %sum, %for.body_5 ], [ %sum_3, %for.end_6 ]
	%j_2 = phi i32 [ 0, %for.body_5 ], [ %postfix_inc_7, %for.end_6 ]
	%slt_6 = icmp slt i32 %j_2, 10
	br i1 %slt_6, label %for.body_6, label %for.end_7

for.body_6:
	%mul_5 = mul i32 %j_2, 100
	%add_5 = add i32 %mul_4, %mul_5
	br label %for.cond_7

for.cond_7:
	%sum_3 = phi i32 [ %sum_2, %for.body_6 ], [ %sum_4, %for.end_5 ]
	%k_2 = phi i32 [ 0, %for.body_6 ], [ %postfix_inc_6, %for.end_5 ]
	%slt_7 = icmp slt i32 %k_2, 10
	br i1 %slt_7, label %for.body_7, label %for.end_6

for.body_7:
	%mul_6 = mul i32 %k_2, 10
	%add_6 = add i32 %add_5, %mul_6
	br label %for.cond_8

for.cond_8:
	%sum_4 = phi i32 [ %sum_3, %for.body_7 ], [ %sum_5, %if.end ]
	%l_2 = phi i32 [ 0, %for.body_7 ], [ %postfix_inc_5, %if.end ]
	%slt_8 = icmp slt i32 %l_2, 10
	br i1 %slt_8, label %for.body_8, label %for.end_5

for.body_8:
	%bitwise_and = and i32 %l_2, 1
	%eq = icmp eq i32 %bitwise_and, 1
	br i1 %eq, label %if.then, label %if.else

if.then:
	%add_9 = add i32 %add_6, %l_2
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 %add_9
	%arrayElement = load i32, i32* %elementPtr_2, align 4
	%add_10 = add i32 %sum_4, %arrayElement
	br label %if.end

if.else:
	%add_11 = add i32 %add_6, %l_2
	%elementPtr_3 = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 %add_11
	%arrayElement_2 = load i32, i32* %elementPtr_3, align 4
	%sub = sub i32 %sum_4, %arrayElement_2
	br label %if.end

if.end:
	%sum_5 = phi i32 [ %add_10, %if.then ], [ %sub, %if.else ]
	%postfix_inc_5 = add i32 %l_2, 1
	br label %for.cond_8

for.end_5:
	%postfix_inc_6 = add i32 %k_2, 1
	br label %for.cond_7

for.end_6:
	%postfix_inc_7 = add i32 %j_2, 1
	br label %for.cond_6

for.end_7:
	%postfix_inc_8 = add i32 %i_2, 1
	br label %for.cond_5

for.end_8:
	%xor = xor i32 %sum, 5000
	ret i32 %xor
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

