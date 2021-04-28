%class.older = type { i32 }

@__const.main.str0 = private unnamed_addr constant [9 x i8] c"eternal!\00", align 1

define i32 @main() {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc to %class.older*
	br label %for.cond

for.cond:
	%i = phi i32 [ 1, %entry ], [ %postfix_3, %for.end_2 ]
	%slt = icmp slt i32 %i, 100
	br i1 %slt, label %for.body, label %for.end_3

for.body:
	%add = add i32 %i, 1
	br label %for.cond_2

for.cond_2:
	%j = phi i32 [ %add, %for.body ], [ %postfix_2, %for.end ]
	%slt_2 = icmp slt i32 %j, 100
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%add_2 = add i32 %j, 1
	br label %for.cond_3

for.cond_3:
	%k = phi i32 [ %add_2, %for.body_2 ], [ %postfix, %if.end_2 ]
	%slt_3 = icmp slt i32 %k, 100
	br i1 %slt_3, label %for.body_3, label %for.end

for.body_3:
	%sub = sub i32 %i, %i
	%add_3 = add i32 %sub, %i
	%add_4 = add i32 %add_3, %j
	%sub_2 = sub i32 %add_4, %j
	%add_5 = add i32 %sub_2, %j
	%add_6 = add i32 %add_5, %k
	%sub_3 = sub i32 %add_6, %k
	%add_7 = add i32 %sub_3, %k
	%mul = mul i32 100, %i
	%mul_2 = mul i32 10, %j
	%add_8 = add i32 %mul, %mul_2
	%add_9 = add i32 %add_8, %k
	%mul_3 = mul i32 %add_7, %add_9
	%srem = srem i32 %mul_3, 1926
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then_2, label %if.end_2

if.then_2:
	%older.age.addr_2 = getelementptr %class.older, %class.older* %castToClassPtr, i32 0, i32 0
	%sub_4 = sub i32 %i, %i
	%add_10 = add i32 %sub_4, %i
	%add_11 = add i32 %add_10, %j
	%sub_5 = sub i32 %add_11, %j
	%add_12 = add i32 %sub_5, %j
	%add_13 = add i32 %add_12, %k
	%sub_6 = sub i32 %add_13, %k
	%add_14 = add i32 %sub_6, %k
	%mul_4 = mul i32 100, %i
	%mul_5 = mul i32 10, %j
	%add_15 = add i32 %mul_4, %mul_5
	%add_16 = add i32 %add_15, %k
	%mul_6 = mul i32 %add_14, %add_16
	store i32 %mul_6, i32* %older.age.addr_2, align 4
	br label %if.end_2

if.end_2:
	%postfix = add i32 %k, 1
	br label %for.cond_3

for.end:
	%postfix_2 = add i32 %j, 1
	br label %for.cond_2

for.end_2:
	%postfix_3 = add i32 %i, 1
	br label %for.cond

for.end_3:
	%older.age.addr = getelementptr %class.older, %class.older* %castToClassPtr, i32 0, i32 0
	%older.age = load i32, i32* %older.age.addr, align 4
	%sgt = icmp sgt i32 %older.age, 10000
	br i1 %sgt, label %if.then, label %if.end

if.then:
	%_ = getelementptr [9 x i8], [9 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %_)
	br label %if.end

if.end:
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

