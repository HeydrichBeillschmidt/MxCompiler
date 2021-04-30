%class.Slice_int = type { i32*, i32, i32 }

@$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0 = private unnamed_addr constant [40 x i8] c"Warning: Slice_int::slice: out of range\00", align 1
@$const.main.str3 = private unnamed_addr constant [1 x i8] c"\00", align 1
@$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1 = private unnamed_addr constant [46 x i8] c"Warning: Slice_int::copy: size() < arr.size()\00", align 1
@$const.main.str2 = private unnamed_addr constant [2 x i8] c" \00", align 1

define i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %this) {
entry:
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 2
	%Slice_int.end = load i32, i32* %Slice_int.end.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%sub = sub i32 %Slice_int.end, %Slice_int.beg
	ret i32 %sub
}

define void @_set$Slice_int$$QEAXHH$Z(%class.Slice_int* %this, i32 %n, i32 %val) {
entry:
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%add = add i32 %Slice_int.beg, %n
	%elementPtr = getelementptr i32, i32* %Slice_int.storage, i32 %add
	store i32 %val, i32* %elementPtr, align 4
	ret void
}

define %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %this, i32 %l, i32 %r) {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc to %class.Slice_int*
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 0
	%Slice_int.storage.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage_2 = load i32*, i32** %Slice_int.storage.addr_2, align 4
	store i32* %Slice_int.storage_2, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 1
	%Slice_int.beg.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg_2 = load i32, i32* %Slice_int.beg.addr_2, align 4
	%add = add i32 %Slice_int.beg_2, %l
	store i32 %add, i32* %Slice_int.beg.addr, align 4
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%Slice_int.beg.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg_3 = load i32, i32* %Slice_int.beg.addr_3, align 4
	%add_2 = add i32 %Slice_int.beg_3, %r
	store i32 %add_2, i32* %Slice_int.end.addr, align 4
	%Slice_int.beg.addr_4 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 1
	%Slice_int.beg_4 = load i32, i32* %Slice_int.beg.addr_4, align 4
	%Slice_int.storage.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage_3 = load i32*, i32** %Slice_int.storage.addr_3, align 4
	%arrayElemPtr = getelementptr i32, i32* %Slice_int.storage_3, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%sgt = icmp sgt i32 %Slice_int.beg_4, %arraySize
	br i1 %sgt, label %logical_or_end, label %logical_or_branch

logical_or_branch:
	%Slice_int.end.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%Slice_int.end_2 = load i32, i32* %Slice_int.end.addr_2, align 4
	%Slice_int.storage.addr_4 = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage_4 = load i32*, i32** %Slice_int.storage.addr_4, align 4
	%arrayElemPtr_2 = getelementptr i32, i32* %Slice_int.storage_4, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%sgt_2 = icmp sgt i32 %Slice_int.end_2, %arraySize_2
	br label %logical_or_end

logical_or_end:
	%logicalOr = phi i1 [ 1, %entry ], [ %sgt_2, %logical_or_branch ]
	br i1 %logicalOr, label %if.then, label %if.end

if.then:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	br label %if.end

if.end:
	ret %class.Slice_int* %castToClassPtr
}

define %class.Slice_int* @_tail$Slice_int$$QEAUSlice_int$$XZ(%class.Slice_int* %this) {
entry:
	%funcCallRet_2 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %this)
	%funcCallRet = call %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %this, i32 1, i32 %funcCallRet_2)
	ret %class.Slice_int* %funcCallRet
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	%sizeTmp = mul i32 %funcCallRet, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %funcCallRet, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	br label %for.cond

for.cond:
	%i_9 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%slt = icmp slt i32 %i_9, %funcCallRet
	br i1 %slt, label %for.body, label %for.end

for.body:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr, i32 %i_9
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_9, 1
	br label %for.cond

for.end:
	call void @_mergeSortInf$$YGXPAH$Z(i32* %arrayHeadPtr)
	br label %for.cond_2

for.cond_2:
	%i_10 = phi i32 [ 0, %for.end ], [ %prefix_inc_2, %for.body_2 ]
	%slt_2 = icmp slt i32 %i_10, %funcCallRet
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtr, i32 %i_10
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_2)
	%$const.main.str2 = getelementptr [2 x i8], [2 x i8]* @$const.main.str2, i32 0, i32 0
	%add = call i8* @_strcat$$YGPADPADPAD$Z(i8* %funcCallRet_3, i8* %$const.main.str2)
	call void @_print$$YGXPAD$Z(i8* %add)
	%prefix_inc_2 = add i32 %i_10, 1
	br label %for.cond_2

for.end_2:
	%$const.main.str3 = getelementptr [1 x i8], [1 x i8]* @$const.main.str3, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const.main.str3)
	ret i32 0
}

define i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %l, %class.Slice_int* %r) {
entry:
	%funcCallRet = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %l)
	%eq = icmp eq i32 %funcCallRet, 0
	br i1 %eq, label %if.then, label %if.end

if.then:
	%funcCallRet_2 = call i32* @_cloneArray$Slice_int$$QEAPAHXZ(%class.Slice_int* %r)
	br label %return

if.end:
	%funcCallRet_3 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %r)
	%eq_2 = icmp eq i32 %funcCallRet_3, 0
	br i1 %eq_2, label %if.then_2, label %if.end_2

if.then_2:
	%funcCallRet_4 = call i32* @_cloneArray$Slice_int$$QEAPAHXZ(%class.Slice_int* %l)
	br label %return

if.end_2:
	%funcCallRet_5 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %l)
	%funcCallRet_6 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %r)
	%add = add i32 %funcCallRet_5, %funcCallRet_6
	%sizeTmp = mul i32 %add, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %add, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	%funcCallRet_7 = call %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %arrayHeadPtr)
	%funcCallRet_8 = call %class.Slice_int* @_tail$Slice_int$$QEAUSlice_int$$XZ(%class.Slice_int* %funcCallRet_7)
	%funcCallRet_9 = call i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %l, i32 0)
	%funcCallRet_10 = call i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %r, i32 0)
	%slt = icmp slt i32 %funcCallRet_9, %funcCallRet_10
	br i1 %slt, label %if.then_3, label %if.else

if.then_3:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr, i32 0
	%funcCallRet_11 = call i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %l, i32 0)
	store i32 %funcCallRet_11, i32* %elementPtr, align 4
	%funcCallRet_14 = call %class.Slice_int* @_tail$Slice_int$$QEAUSlice_int$$XZ(%class.Slice_int* %l)
	%funcCallRet_13 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %funcCallRet_14, %class.Slice_int* %r)
	%funcCallRet_12 = call %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %funcCallRet_13)
	call void @_copy$Slice_int$$QEAXUSlice_int$$$Z(%class.Slice_int* %funcCallRet_8, %class.Slice_int* %funcCallRet_12)
	br label %if.end_3

if.else:
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtr, i32 0
	%funcCallRet_15 = call i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %r, i32 0)
	store i32 %funcCallRet_15, i32* %elementPtr_2, align 4
	%funcCallRet_18 = call %class.Slice_int* @_tail$Slice_int$$QEAUSlice_int$$XZ(%class.Slice_int* %r)
	%funcCallRet_17 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %l, %class.Slice_int* %funcCallRet_18)
	%funcCallRet_16 = call %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %funcCallRet_17)
	call void @_copy$Slice_int$$QEAXUSlice_int$$$Z(%class.Slice_int* %funcCallRet_8, %class.Slice_int* %funcCallRet_16)
	br label %if.end_3

if.end_3:
	br label %return

return:
	%tail_3 = phi %class.Slice_int* [ null, %if.then ], [ null, %if.then_2 ], [ %funcCallRet_8, %if.end_3 ]
	%retval_2 = phi i32* [ %funcCallRet_2, %if.then ], [ %funcCallRet_4, %if.then_2 ], [ %arrayHeadPtr, %if.end_3 ]
	%res_5 = phi i32* [ null, %if.then ], [ null, %if.then_2 ], [ %arrayHeadPtr, %if.end_3 ]
	ret i32* %retval_2
}

define void @_mergeSortInf$$YGXPAH$Z(i32* %a) {
entry:
	%funcCallRet = call %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %a)
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %funcCallRet)
	ret void
}

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %this, i32 %n) {
entry:
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%add = add i32 %Slice_int.beg, %n
	%elementPtr = getelementptr i32, i32* %Slice_int.storage, i32 %add
	%arrayElement = load i32, i32* %elementPtr, align 4
	ret i32 %arrayElement
}

define void @_copy$Slice_int$$QEAXUSlice_int$$$Z(%class.Slice_int* %this, %class.Slice_int* %arr) {
entry:
	%funcCallRet = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %this)
	%funcCallRet_2 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %arr)
	%slt = icmp slt i32 %funcCallRet, %funcCallRet_2
	br i1 %slt, label %if.then, label %if.end

if.then:
	%$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1 = getelementptr [46 x i8], [46 x i8]* @$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	br label %if.end

if.end:
	br label %for.cond

for.cond:
	%i_6 = phi i32 [ 0, %if.end ], [ %prefix_inc, %for.body ]
	%funcCallRet_3 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %arr)
	%slt_2 = icmp slt i32 %i_6, %funcCallRet_3
	br i1 %slt_2, label %for.body, label %for.end

for.body:
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%add = add i32 %Slice_int.beg, %i_6
	%elementPtr = getelementptr i32, i32* %Slice_int.storage, i32 %add
	%funcCallRet_4 = call i32 @_get$Slice_int$$QEAHH$Z(%class.Slice_int* %arr, i32 %i_6)
	store i32 %funcCallRet_4, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_6, 1
	br label %for.cond

for.end:
	ret void
}

define void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %a) {
entry:
	%funcCallRet = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %a)
	%eq = icmp eq i32 %funcCallRet, 1
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%funcCallRet_2 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %a)
	%sdiv = sdiv i32 %funcCallRet_2, 2
	%funcCallRet_3 = call %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %a, i32 0, i32 %sdiv)
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %funcCallRet_3)
	%funcCallRet_4 = call %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %a, i32 %sdiv, i32 %funcCallRet_2)
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %funcCallRet_4)
	%funcCallRet_7 = call %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %a, i32 0, i32 %sdiv)
	%funcCallRet_8 = call %class.Slice_int* @_slice$Slice_int$$QEAUSlice_int$$HH$Z(%class.Slice_int* %a, i32 %sdiv, i32 %funcCallRet_2)
	%funcCallRet_6 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %funcCallRet_7, %class.Slice_int* %funcCallRet_8)
	%funcCallRet_5 = call %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %funcCallRet_6)
	call void @_copy$Slice_int$$QEAXUSlice_int$$$Z(%class.Slice_int* %a, %class.Slice_int* %funcCallRet_5)
	br label %return

return:
	%m_5 = phi i32 [ 0, %if.then ], [ %sdiv, %if.end ]
	%n_4 = phi i32 [ 0, %if.then ], [ %funcCallRet_2, %if.end ]
	ret void
}

define %class.Slice_int* @_makeSlice_int$$YGUSlice_int$$PAH$Z(i32* %arr) {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc to %class.Slice_int*
	call void @_init$Slice_int$$QEAXPAH$Z(%class.Slice_int* %castToClassPtr, i32* %arr)
	ret %class.Slice_int* %castToClassPtr
}

define i32* @_cloneArray$Slice_int$$QEAPAHXZ(%class.Slice_int* %this) {
entry:
	%funcCallRet = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %this)
	%sizeTmp = mul i32 %funcCallRet, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %funcCallRet, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	br label %for.cond

for.cond:
	%i_6 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%funcCallRet_2 = call i32 @_size$Slice_int$$QEAHXZ(%class.Slice_int* %this)
	%slt = icmp slt i32 %i_6, %funcCallRet_2
	br i1 %slt, label %for.body, label %for.end

for.body:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr, i32 %i_6
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%add = add i32 %Slice_int.beg, %i_6
	%elementPtr_2 = getelementptr i32, i32* %Slice_int.storage, i32 %add
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	store i32 %arrayElement_2, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_6, 1
	br label %for.cond

for.end:
	ret i32* %arrayHeadPtr
}

define void @_init$Slice_int$$QEAXPAH$Z(%class.Slice_int* %this, i32* %arr) {
entry:
	%Slice_int.storage.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 0
	store i32* %arr, i32** %Slice_int.storage.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr, align 4
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %this, i32 0, i32 2
	%arrayElemPtr = getelementptr i32, i32* %arr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	store i32 %arraySize, i32* %Slice_int.end.addr, align 4
	ret void
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

