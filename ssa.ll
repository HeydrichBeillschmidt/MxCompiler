%class.vector = type { i32* }

@__const.main.str8 = private unnamed_addr constant [15 x i8] c"(1 << 3) * y: \00", align 1
@__const.main.str7 = private unnamed_addr constant [8 x i8] c"x * y: \00", align 1
@__const._tostring$vector$$QEAPADXZ.str2 = private unnamed_addr constant [3 x i8] c" )\00", align 1
@__const._tostring$vector$$QEAPADXZ.str1 = private unnamed_addr constant [3 x i8] c", \00", align 1
@__const._tostring$vector$$QEAPADXZ.str0 = private unnamed_addr constant [3 x i8] c"( \00", align 1
@__const.main.str6 = private unnamed_addr constant [8 x i8] c"x + y: \00", align 1
@__const.main.str5 = private unnamed_addr constant [11 x i8] c"vector y: \00", align 1
@__const.main.str4 = private unnamed_addr constant [9 x i8] c"excited!\00", align 1
@__const.main.str3 = private unnamed_addr constant [11 x i8] c"vector x: \00", align 1

define i1 @_copy$vector$$QEA_NUvector$$$Z(%class.vector* %this, %class.vector* %rhs) {
entry:
	%eq = icmp eq %class.vector* %rhs, null
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %rhs)
	%eq_2 = icmp eq i32 %funcCallRet, 0
	br i1 %eq_2, label %if.then_2, label %if.else

if.then_2:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	store i32* null, i32** %vector.data.addr, align 4
	br label %if.end_2

for.cond:
	%i_7 = phi i32 [ 0, %if.else ], [ %prefix_inc, %for.body ]
	%funcCallRet_3 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %i_7, %funcCallRet_3
	br i1 %slt, label %for.body, label %for.end

for.body:
	%vector.data.addr_3 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_3 = load i32*, i32** %vector.data.addr_3, align 4
	%elementPtr = getelementptr i32, i32* %vector.data_3, i32 %i_7
	%vector.data.addr_4 = getelementptr %class.vector, %class.vector* %rhs, i32 0, i32 0
	%vector.data_4 = load i32*, i32** %vector.data.addr_4, align 4
	%elementPtr_2 = getelementptr i32, i32* %vector.data_4, i32 %i_7
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	store i32 %arrayElement_2, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_7, 1
	br label %for.cond

for.end:
	br label %if.end_2

if.else:
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%funcCallRet_2 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %rhs)
	%sizeTmp = mul i32 %funcCallRet_2, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %funcCallRet_2, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** %vector.data.addr_2, align 4
	br label %for.cond

if.end_2:
	%i_6 = phi i32 [ 0, %if.then_2 ], [ %i_7, %for.end ]
	br label %return

return:
	%retval_2 = phi i1 [ 0, %if.then ], [ 1, %if.end_2 ]
	%i_8 = phi i32 [ 0, %if.then ], [ %i_6, %if.end_2 ]
	ret i1 %retval_2
}

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i8* @_tostring$vector$$QEAPADXZ(%class.vector* %this) {
entry:
	%__const._tostring$vector$$QEAPADXZ.str0 = getelementptr [3 x i8], [3 x i8]* @__const._tostring$vector$$QEAPADXZ.str0, i32 0, i32 0
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%sgt = icmp sgt i32 %funcCallRet, 0
	br i1 %sgt, label %if.then, label %if.end

if.then:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data = load i32*, i32** %vector.data.addr, align 4
	%elementPtr = getelementptr i32, i32* %vector.data, i32 0
	%arrayElement = load i32, i32* %elementPtr, align 4
	%funcCallRet_2 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement)
	%add = call i8* @_strcat$$YGPADPADPAD$Z(i8* %__const._tostring$vector$$QEAPADXZ.str0, i8* %funcCallRet_2)
	br label %if.end

if.end:
	%temp_9 = phi i8* [ %add, %if.then ], [ %__const._tostring$vector$$QEAPADXZ.str0, %entry ]
	br label %for.cond

for.cond:
	%temp_8 = phi i8* [ %temp_9, %if.end ], [ %add_3, %for.body ]
	%i_5 = phi i32 [ 1, %if.end ], [ %prefix_inc, %for.body ]
	%funcCallRet_3 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %i_5, %funcCallRet_3
	br i1 %slt, label %for.body, label %for.end

for.body:
	%__const._tostring$vector$$QEAPADXZ.str1 = getelementptr [3 x i8], [3 x i8]* @__const._tostring$vector$$QEAPADXZ.str1, i32 0, i32 0
	%add_2 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %temp_8, i8* %__const._tostring$vector$$QEAPADXZ.str1)
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%elementPtr_2 = getelementptr i32, i32* %vector.data_2, i32 %i_5
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%funcCallRet_4 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_2)
	%add_3 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_2, i8* %funcCallRet_4)
	%prefix_inc = add i32 %i_5, 1
	br label %for.cond

for.end:
	%__const._tostring$vector$$QEAPADXZ.str2 = getelementptr [3 x i8], [3 x i8]* @__const._tostring$vector$$QEAPADXZ.str2, i32 0, i32 0
	%add_4 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %temp_8, i8* %__const._tostring$vector$$QEAPADXZ.str2)
	ret i8* %add_4
}

define void @_init$vector$$QEAXPAH$Z(%class.vector* %this, i32* %vec) {
entry:
	%eq = icmp eq i32* %vec, null
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%arrayElemPtr = getelementptr i32, i32* %vec, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%sizeTmp = mul i32 %arraySize, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %arraySize, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** %vector.data.addr, align 4
	br label %for.cond

for.cond:
	%i_7 = phi i32 [ 0, %if.end ], [ %prefix_inc, %for.body ]
	%arrayElemPtr_2 = getelementptr i32, i32* %vec, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%slt = icmp slt i32 %i_7, %arraySize_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%elementPtr = getelementptr i32, i32* %vector.data_2, i32 %i_7
	%elementPtr_2 = getelementptr i32, i32* %vec, i32 %i_7
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	store i32 %arrayElement_2, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_7, 1
	br label %for.cond

for.end:
	br label %return

return:
	%i_6 = phi i32 [ 0, %if.then ], [ %i_7, %for.end ]
	ret void
}

define i1 @_set$vector$$QEA_NHH$Z(%class.vector* %this, i32 %idx, i32 %value) {
entry:
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %funcCallRet, %idx
	br i1 %slt, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data = load i32*, i32** %vector.data.addr, align 4
	%elementPtr = getelementptr i32, i32* %vector.data, i32 %idx
	store i32 %value, i32* %elementPtr, align 4
	br label %return

return:
	%retval_2 = phi i1 [ 0, %if.then ], [ 1, %if.end ]
	ret i1 %retval_2
}

define i32 @_getDim$vector$$QEAHXZ(%class.vector* %this) {
entry:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data = load i32*, i32** %vector.data.addr, align 4
	%eq = icmp eq i32* %vector.data, null
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%arrayElemPtr = getelementptr i32, i32* %vector.data_2, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	br label %return

return:
	%retval_2 = phi i32 [ 0, %if.then ], [ %arraySize, %if.end ]
	ret i32 %retval_2
}

define %class.vector* @_add$vector$$QEAUvector$$Uvector$$$Z(%class.vector* %this, %class.vector* %rhs) {
entry:
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%funcCallRet_2 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %rhs)
	%ne = icmp ne i32 %funcCallRet, %funcCallRet_2
	br i1 %ne, label %logicalOr_end, label %logicalOr_branch

logicalOr_branch:
	%funcCallRet_3 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%eq = icmp eq i32 %funcCallRet_3, 0
	br label %logicalOr_end

logicalOr_end:
	%logical_or = phi i1 [ 1, %entry ], [ %eq, %logicalOr_branch ]
	br i1 %logical_or, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc to %class.vector*
	%vector.data.addr = getelementptr %class.vector, %class.vector* %castToClassPtr, i32 0, i32 0
	%funcCallRet_4 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%sizeTmp = mul i32 %funcCallRet_4, 4
	%size = add i32 %sizeTmp, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc_2 to i32*
	store i32 %funcCallRet_4, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** %vector.data.addr, align 4
	br label %for.cond

for.cond:
	%i_8 = phi i32 [ 0, %if.end ], [ %prefix_inc, %for.body ]
	%funcCallRet_5 = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %i_8, %funcCallRet_5
	br i1 %slt, label %for.body, label %for.end

for.body:
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %castToClassPtr, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%elementPtr = getelementptr i32, i32* %vector.data_2, i32 %i_8
	%vector.data.addr_3 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_3 = load i32*, i32** %vector.data.addr_3, align 4
	%elementPtr_2 = getelementptr i32, i32* %vector.data_3, i32 %i_8
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%vector.data.addr_4 = getelementptr %class.vector, %class.vector* %rhs, i32 0, i32 0
	%vector.data_4 = load i32*, i32** %vector.data.addr_4, align 4
	%elementPtr_3 = getelementptr i32, i32* %vector.data_4, i32 %i_8
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	%add = add i32 %arrayElement_2, %arrayElement_3
	store i32 %add, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_8, 1
	br label %for.cond

for.end:
	br label %return

return:
	%i_7 = phi i32 [ 0, %if.then ], [ %i_8, %for.end ]
	%retval_2 = phi %class.vector* [ null, %if.then ], [ %castToClassPtr, %for.end ]
	%temp_4 = phi %class.vector* [ null, %if.then ], [ %castToClassPtr, %for.end ]
	ret %class.vector* %retval_2
}

define i32 @_dot$vector$$QEAHUvector$$$Z(%class.vector* %this, %class.vector* %rhs) {
entry:
	br label %while.cond

while.cond:
	%result_3 = phi i32 [ 0, %entry ], [ %mul, %while.body ]
	%i_5 = phi i32 [ 0, %entry ], [ %prefix_inc, %while.body ]
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %i_5, %funcCallRet
	br i1 %slt, label %while.body, label %while.end

while.body:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data = load i32*, i32** %vector.data.addr, align 4
	%elementPtr = getelementptr i32, i32* %vector.data, i32 %i_5
	%arrayElement = load i32, i32* %elementPtr, align 4
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %rhs, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%elementPtr_2 = getelementptr i32, i32* %vector.data_2, i32 %i_5
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%mul = mul i32 %arrayElement, %arrayElement_2
	%prefix_inc = add i32 %i_5, 1
	br label %while.cond

while.end:
	ret i32 %result_3
}

define %class.vector* @_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z(%class.vector* %this, i32 %c) {
entry:
	%vector.data.addr = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data = load i32*, i32** %vector.data.addr, align 4
	%eq = icmp eq i32* %vector.data, null
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	br label %for.cond

for.cond:
	%i_7 = phi i32 [ 0, %if.end ], [ %prefix_inc, %for.body ]
	%funcCallRet = call i32 @_getDim$vector$$QEAHXZ(%class.vector* %this)
	%slt = icmp slt i32 %i_7, %funcCallRet
	br i1 %slt, label %for.body, label %for.end

for.body:
	%vector.data.addr_2 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_2 = load i32*, i32** %vector.data.addr_2, align 4
	%elementPtr = getelementptr i32, i32* %vector.data_2, i32 %i_7
	%vector.data.addr_3 = getelementptr %class.vector, %class.vector* %this, i32 0, i32 0
	%vector.data_3 = load i32*, i32** %vector.data.addr_3, align 4
	%elementPtr_2 = getelementptr i32, i32* %vector.data_3, i32 %i_7
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%mul = mul i32 %c, %arrayElement_2
	store i32 %mul, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_7, 1
	br label %for.cond

for.end:
	br label %return

return:
	%i_6 = phi i32 [ 0, %if.then ], [ %i_7, %for.end ]
	%retval_2 = phi %class.vector* [ null, %if.then ], [ %this, %for.end ]
	ret %class.vector* %retval_2
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc to %class.vector*
	%sizeTmp = mul i32 10, 4
	%size = add i32 %sizeTmp, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc_2 to i32*
	store i32 10, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	br label %for.cond

for.cond:
	%i_6 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%slt = icmp slt i32 %i_6, 10
	br i1 %slt, label %for.body, label %for.end

for.body:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr, i32 %i_6
	%sub = sub i32 9, %i_6
	store i32 %sub, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_6, 1
	br label %for.cond

for.end:
	call void @_init$vector$$QEAXPAH$Z(%class.vector* %castToClassPtr, i32* %arrayHeadPtr)
	%__const.main.str3 = getelementptr [11 x i8], [11 x i8]* @__const.main.str3, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str3)
	%funcCallRet = call i8* @_tostring$vector$$QEAPADXZ(%class.vector* %castToClassPtr)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet)
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr_2 = bitcast i8* %malloc_3 to %class.vector*
	%funcCallRet_2 = call i1 @_copy$vector$$QEA_NUvector$$$Z(%class.vector* %castToClassPtr_2, %class.vector* %castToClassPtr)
	%funcCallRet_3 = call i1 @_set$vector$$QEA_NHH$Z(%class.vector* %castToClassPtr_2, i32 3, i32 817)
	br i1 %funcCallRet_3, label %if.then, label %if.end

if.then:
	%__const.main.str4 = getelementptr [9 x i8], [9 x i8]* @__const.main.str4, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %__const.main.str4)
	br label %if.end

if.end:
	%__const.main.str5 = getelementptr [11 x i8], [11 x i8]* @__const.main.str5, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str5)
	%funcCallRet_4 = call i8* @_tostring$vector$$QEAPADXZ(%class.vector* %castToClassPtr_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_4)
	%__const.main.str6 = getelementptr [8 x i8], [8 x i8]* @__const.main.str6, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str6)
	%funcCallRet_5 = call %class.vector* @_add$vector$$QEAUvector$$Uvector$$$Z(%class.vector* %castToClassPtr, %class.vector* %castToClassPtr_2)
	%funcCallRet_6 = call i8* @_tostring$vector$$QEAPADXZ(%class.vector* %funcCallRet_5)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_6)
	%__const.main.str7 = getelementptr [8 x i8], [8 x i8]* @__const.main.str7, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str7)
	%funcCallRet_8 = call i32 @_dot$vector$$QEAHUvector$$$Z(%class.vector* %castToClassPtr, %class.vector* %castToClassPtr_2)
	%funcCallRet_7 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_8)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_7)
	%__const.main.str8 = getelementptr [15 x i8], [15 x i8]* @__const.main.str8, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str8)
	%shl = shl i32 1, 3
	%funcCallRet_9 = call %class.vector* @_scalarInPlaceMultiply$vector$$QEAUvector$$H$Z(%class.vector* %castToClassPtr_2, i32 %shl)
	%funcCallRet_10 = call i8* @_tostring$vector$$QEAPADXZ(%class.vector* %funcCallRet_9)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_10)
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

