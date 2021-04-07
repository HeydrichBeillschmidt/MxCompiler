%class.older = type { i32 }

@__const.main.str0 = private unnamed_addr constant [9 x i8] c"eternal!\00", align 1

define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define void @_solveAge$older$$QEAXXZ(%class.older* %this) {
entry:
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%k.addr = bitcast i8* %malloc_4 to i32*
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%j.addr = bitcast i8* %malloc_3 to i32*
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%i.addr = bitcast i8* %malloc_2 to i32*
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%this.addr = bitcast i8* %malloc to %class.older**
	store %class.older* %this, %class.older** %this.addr, align 4
	%i = load i32, i32* %i.addr, align 4
	store i32 1, i32* %i.addr, align 4
	br label %for.cond

for.cond:
	%i_2 = load i32, i32* %i.addr, align 4
	%slt = icmp slt i32 %i_2, 100
	br i1 %slt, label %for.body_3, label %for.end_3

for.cond_2:
	%j_2 = load i32, i32* %j.addr, align 4
	%slt_2 = icmp slt i32 %j_2, 100
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.cond_3:
	%k_2 = load i32, i32* %k.addr, align 4
	%slt_3 = icmp slt i32 %k_2, 100
	br i1 %slt_3, label %for.body, label %for.end

if.then:
	%this_2 = load %class.older*, %class.older** %this.addr, align 4
	%older.age.addr = getelementptr %class.older, %class.older* %this_2, i32 0, i32 0
	%older.age = load i32, i32* %older.age.addr, align 4
	%i_8 = load i32, i32* %i.addr, align 4
	%i_9 = load i32, i32* %i.addr, align 4
	%sub_4 = sub i32 %i_8, %i_9
	%i_10 = load i32, i32* %i.addr, align 4
	%add_10 = add i32 %sub_4, %i_10
	%j_8 = load i32, i32* %j.addr, align 4
	%add_11 = add i32 %add_10, %j_8
	%j_9 = load i32, i32* %j.addr, align 4
	%sub_5 = sub i32 %add_11, %j_9
	%j_10 = load i32, i32* %j.addr, align 4
	%add_12 = add i32 %sub_5, %j_10
	%k_7 = load i32, i32* %k.addr, align 4
	%add_13 = add i32 %add_12, %k_7
	%k_8 = load i32, i32* %k.addr, align 4
	%sub_6 = sub i32 %add_13, %k_8
	%k_9 = load i32, i32* %k.addr, align 4
	%add_14 = add i32 %sub_6, %k_9
	%i_11 = load i32, i32* %i.addr, align 4
	%mul_4 = mul i32 100, %i_11
	%j_11 = load i32, i32* %j.addr, align 4
	%mul_5 = mul i32 10, %j_11
	%add_15 = add i32 %mul_4, %mul_5
	%k_10 = load i32, i32* %k.addr, align 4
	%add_16 = add i32 %add_15, %k_10
	%mul_6 = mul i32 %add_14, %add_16
	store i32 %mul_6, i32* %older.age.addr, align 4
	br label %if.end

if.end:
	br label %for.inc

for.body:
	%i_4 = load i32, i32* %i.addr, align 4
	%i_5 = load i32, i32* %i.addr, align 4
	%sub = sub i32 %i_4, %i_5
	%i_6 = load i32, i32* %i.addr, align 4
	%add_3 = add i32 %sub, %i_6
	%j_4 = load i32, i32* %j.addr, align 4
	%add_4 = add i32 %add_3, %j_4
	%j_5 = load i32, i32* %j.addr, align 4
	%sub_2 = sub i32 %add_4, %j_5
	%j_6 = load i32, i32* %j.addr, align 4
	%add_5 = add i32 %sub_2, %j_6
	%k_3 = load i32, i32* %k.addr, align 4
	%add_6 = add i32 %add_5, %k_3
	%k_4 = load i32, i32* %k.addr, align 4
	%sub_3 = sub i32 %add_6, %k_4
	%k_5 = load i32, i32* %k.addr, align 4
	%add_7 = add i32 %sub_3, %k_5
	%i_7 = load i32, i32* %i.addr, align 4
	%mul = mul i32 100, %i_7
	%j_7 = load i32, i32* %j.addr, align 4
	%mul_2 = mul i32 10, %j_7
	%add_8 = add i32 %mul, %mul_2
	%k_6 = load i32, i32* %k.addr, align 4
	%add_9 = add i32 %add_8, %k_6
	%mul_3 = mul i32 %add_7, %add_9
	%srem = srem i32 %mul_3, 1926
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.end

for.inc:
	%k_11 = load i32, i32* %k.addr, align 4
	%postfix_inc = add i32 %k_11, 1
	store i32 %postfix_inc, i32* %k.addr, align 4
	br label %for.cond_3

for.end:
	br label %for.inc_2

for.body_2:
	%k = load i32, i32* %k.addr, align 4
	%j_3 = load i32, i32* %j.addr, align 4
	%add_2 = add i32 %j_3, 1
	store i32 %add_2, i32* %k.addr, align 4
	br label %for.cond_3

for.inc_2:
	%j_12 = load i32, i32* %j.addr, align 4
	%postfix_inc_2 = add i32 %j_12, 1
	store i32 %postfix_inc_2, i32* %j.addr, align 4
	br label %for.cond_2

for.end_2:
	br label %for.inc_3

for.body_3:
	%j = load i32, i32* %j.addr, align 4
	%i_3 = load i32, i32* %i.addr, align 4
	%add = add i32 %i_3, 1
	store i32 %add, i32* %j.addr, align 4
	br label %for.cond_2

for.inc_3:
	%i_12 = load i32, i32* %i.addr, align 4
	%postfix_inc_3 = add i32 %i_12, 1
	store i32 %postfix_inc_3, i32* %i.addr, align 4
	br label %for.cond

for.end_3:
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%mrJiang.addr = bitcast i8* %malloc_2 to %class.older**
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc_3 to %class.older*
	store %class.older* %castToClassPtr, %class.older** %mrJiang.addr, align 4
	%mrJiang = load %class.older*, %class.older** %mrJiang.addr, align 4
	call void @_solveAge$older$$QEAXXZ(%class.older* %mrJiang)
	%mrJiang_2 = load %class.older*, %class.older** %mrJiang.addr, align 4
	%older.age.addr = getelementptr %class.older, %class.older* %mrJiang_2, i32 0, i32 0
	%older.age = load i32, i32* %older.age.addr, align 4
	%sgt = icmp sgt i32 %older.age, 10000
	br i1 %sgt, label %if.then, label %if.end

if.then:
	%__const.main.str0 = getelementptr [9 x i8], [9 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %__const.main.str0)
	br label %if.end

if.end:
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

