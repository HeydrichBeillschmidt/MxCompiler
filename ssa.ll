%class.older = type { i32 }

@__const.main.str0 = private unnamed_addr constant [9 x i8] c"eternal!\00", align 1

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define void @_solveAge$older$$QEAXXZ(%class.older* %this) {
entry:
	br label %for.cond

for.cond:
	%j_14 = phi i32 [ 0, %entry ], [ %j_13, %for.end_2 ]
	%i_13 = phi i32 [ 1, %entry ], [ %postfix_3, %for.end_2 ]
	%k_14 = phi i32 [ 0, %entry ], [ %k_13, %for.end_2 ]
	%slt = icmp slt i32 %i_13, 100
	br i1 %slt, label %for.body_3, label %for.end_3

for.cond_2:
	%j_13 = phi i32 [ %add, %for.body_3 ], [ %postfix_2, %for.end ]
	%k_13 = phi i32 [ %k_14, %for.body_3 ], [ %k_12, %for.end ]
	%slt_2 = icmp slt i32 %j_13, 100
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.cond_3:
	%k_12 = phi i32 [ %add_2, %for.body_2 ], [ %postfix, %if.end ]
	%slt_3 = icmp slt i32 %k_12, 100
	br i1 %slt_3, label %for.body, label %for.end

if.then:
	%older.age.addr = getelementptr %class.older, %class.older* %this, i32 0, i32 0
	%sub_4 = sub i32 %i_13, %i_13
	%add_10 = add i32 %sub_4, %i_13
	%add_11 = add i32 %add_10, %j_13
	%sub_5 = sub i32 %add_11, %j_13
	%add_12 = add i32 %sub_5, %j_13
	%add_13 = add i32 %add_12, %k_12
	%sub_6 = sub i32 %add_13, %k_12
	%add_14 = add i32 %sub_6, %k_12
	%mul_4 = mul i32 100, %i_13
	%mul_5 = mul i32 10, %j_13
	%add_15 = add i32 %mul_4, %mul_5
	%add_16 = add i32 %add_15, %k_12
	%mul_6 = mul i32 %add_14, %add_16
	store i32 %mul_6, i32* %older.age.addr, align 4
	br label %if.end

if.end:
	%postfix = add i32 %k_12, 1
	br label %for.cond_3

for.body:
	%sub = sub i32 %i_13, %i_13
	%add_3 = add i32 %sub, %i_13
	%add_4 = add i32 %add_3, %j_13
	%sub_2 = sub i32 %add_4, %j_13
	%add_5 = add i32 %sub_2, %j_13
	%add_6 = add i32 %add_5, %k_12
	%sub_3 = sub i32 %add_6, %k_12
	%add_7 = add i32 %sub_3, %k_12
	%mul = mul i32 100, %i_13
	%mul_2 = mul i32 10, %j_13
	%add_8 = add i32 %mul, %mul_2
	%add_9 = add i32 %add_8, %k_12
	%mul_3 = mul i32 %add_7, %add_9
	%srem = srem i32 %mul_3, 1926
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.end

for.end:
	%postfix_2 = add i32 %j_13, 1
	br label %for.cond_2

for.body_2:
	%add_2 = add i32 %j_13, 1
	br label %for.cond_3

for.end_2:
	%postfix_3 = add i32 %i_13, 1
	br label %for.cond

for.body_3:
	%add = add i32 %i_13, 1
	br label %for.cond_2

for.end_3:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc to %class.older*
	call void @_solveAge$older$$QEAXXZ(%class.older* %castToClassPtr)
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

