define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_test$$YGHXZ() {
entry:
	%sizeTmp = mul i32 10000, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 10000, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	br label %for.cond

for.cond:
	%i_11 = phi i32 [ 0, %entry ], [ %postfix_inc_4, %for.end_3 ]
	%k_15 = phi i32 [ 0, %entry ], [ %k_13, %for.end_3 ]
	%j_13 = phi i32 [ 0, %entry ], [ %j_10, %for.end_3 ]
	%l_19 = phi i32 [ 0, %entry ], [ %l_17, %for.end_3 ]
	%slt = icmp slt i32 %i_11, 10
	br i1 %slt, label %for.body_4, label %for.end_4

for.cond_2:
	%k_13 = phi i32 [ %k_15, %for.body_4 ], [ %k_10, %for.end_2 ]
	%j_10 = phi i32 [ 0, %for.body_4 ], [ %postfix_inc_3, %for.end_2 ]
	%l_17 = phi i32 [ %l_19, %for.body_4 ], [ %l_15, %for.end_2 ]
	%slt_2 = icmp slt i32 %j_10, 10
	br i1 %slt_2, label %for.body_3, label %for.end_3

for.cond_3:
	%k_10 = phi i32 [ 0, %for.body_3 ], [ %postfix_inc_2, %for.end ]
	%l_15 = phi i32 [ %l_17, %for.body_3 ], [ %l_12, %for.end ]
	%slt_3 = icmp slt i32 %k_10, 10
	br i1 %slt_3, label %for.body_2, label %for.end_2

for.cond_4:
	%l_12 = phi i32 [ 0, %for.body_2 ], [ %postfix_inc, %for.body ]
	%slt_4 = icmp slt i32 %l_12, 10
	br i1 %slt_4, label %for.body, label %for.end

for.body:
	%mul = mul i32 %i_11, 1000
	%mul_2 = mul i32 %j_10, 100
	%add = add i32 %mul, %mul_2
	%mul_3 = mul i32 %k_10, 10
	%add_2 = add i32 %add, %mul_3
	%add_3 = add i32 %add_2, %l_12
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr, i32 %add_3
	%add_4 = add i32 %i_11, %l_12
	store i32 %add_4, i32* %elementPtr, align 4
	%postfix_inc = add i32 %l_12, 1
	br label %for.cond_4

for.end:
	%postfix_inc_2 = add i32 %k_10, 1
	br label %for.cond_3

for.body_2:
	br label %for.cond_4

for.end_2:
	%postfix_inc_3 = add i32 %j_10, 1
	br label %for.cond_2

for.body_3:
	br label %for.cond_3

for.end_3:
	%postfix_inc_4 = add i32 %i_11, 1
	br label %for.cond

for.body_4:
	br label %for.cond_2

for.end_4:
	br label %for.cond_5

for.cond_5:
	%i_12 = phi i32 [ 0, %for.end_4 ], [ %postfix_inc_8, %for.end_7 ]
	%sum_10 = phi i32 [ 0, %for.end_4 ], [ %sum_9, %for.end_7 ]
	%k_14 = phi i32 [ %k_15, %for.end_4 ], [ %k_12, %for.end_7 ]
	%j_11 = phi i32 [ %j_13, %for.end_4 ], [ %j_12, %for.end_7 ]
	%l_18 = phi i32 [ %l_19, %for.end_4 ], [ %l_16, %for.end_7 ]
	%slt_5 = icmp slt i32 %i_12, 10
	br i1 %slt_5, label %for.body_8, label %for.end_8

for.cond_6:
	%sum_9 = phi i32 [ %sum_10, %for.body_8 ], [ %sum_8, %for.end_6 ]
	%k_12 = phi i32 [ %k_14, %for.body_8 ], [ %k_11, %for.end_6 ]
	%j_12 = phi i32 [ 0, %for.body_8 ], [ %postfix_inc_7, %for.end_6 ]
	%l_16 = phi i32 [ %l_18, %for.body_8 ], [ %l_14, %for.end_6 ]
	%slt_6 = icmp slt i32 %j_12, 10
	br i1 %slt_6, label %for.body_7, label %for.end_7

for.cond_7:
	%sum_8 = phi i32 [ %sum_9, %for.body_7 ], [ %sum_7, %for.end_5 ]
	%k_11 = phi i32 [ 0, %for.body_7 ], [ %postfix_inc_6, %for.end_5 ]
	%l_14 = phi i32 [ %l_16, %for.body_7 ], [ %l_13, %for.end_5 ]
	%slt_7 = icmp slt i32 %k_11, 10
	br i1 %slt_7, label %for.body_6, label %for.end_6

for.cond_8:
	%sum_7 = phi i32 [ %sum_8, %for.body_6 ], [ %sum_6, %if.end ]
	%l_13 = phi i32 [ 0, %for.body_6 ], [ %postfix_inc_5, %if.end ]
	%slt_8 = icmp slt i32 %l_13, 10
	br i1 %slt_8, label %for.body_5, label %for.end_5

if.then:
	%mul_4 = mul i32 %i_12, 1000
	%mul_5 = mul i32 %j_12, 100
	%add_5 = add i32 %mul_4, %mul_5
	%mul_6 = mul i32 %k_11, 10
	%add_6 = add i32 %add_5, %mul_6
	%add_7 = add i32 %add_6, %l_13
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtr, i32 %add_7
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%add_8 = add i32 %sum_7, %arrayElement_2
	br label %if.end

if.else:
	%mul_7 = mul i32 %i_12, 1000
	%mul_8 = mul i32 %j_12, 100
	%add_9 = add i32 %mul_7, %mul_8
	%mul_9 = mul i32 %k_11, 10
	%add_10 = add i32 %add_9, %mul_9
	%add_11 = add i32 %add_10, %l_13
	%elementPtr_3 = getelementptr i32, i32* %arrayHeadPtr, i32 %add_11
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%sub = sub i32 %sum_7, %arrayElement_3
	br label %if.end

if.end:
	%sum_6 = phi i32 [ %add_8, %if.then ], [ %sub, %if.else ]
	%postfix_inc_5 = add i32 %l_13, 1
	br label %for.cond_8

for.body_5:
	%bitwise_and = and i32 %l_13, 1
	%eq = icmp eq i32 %bitwise_and, 1
	br i1 %eq, label %if.then, label %if.else

for.end_5:
	%postfix_inc_6 = add i32 %k_11, 1
	br label %for.cond_7

for.body_6:
	br label %for.cond_8

for.end_6:
	%postfix_inc_7 = add i32 %j_12, 1
	br label %for.cond_6

for.body_7:
	br label %for.cond_7

for.end_7:
	%postfix_inc_8 = add i32 %i_12, 1
	br label %for.cond_5

for.body_8:
	br label %for.cond_6

for.end_8:
	ret i32 %sum_10
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet = call i32 @_test$$YGHXZ()
	%xor = xor i32 %funcCallRet, 5000
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

