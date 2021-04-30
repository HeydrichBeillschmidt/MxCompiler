%class.Slice_int = type { i32*, i32, i32 }

@$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0 = private unnamed_addr constant [40 x i8] c"Warning: Slice_int::slice: out of range\00", align 1
@$const.main.str3 = private unnamed_addr constant [1 x i8] c"\00", align 1
@$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1 = private unnamed_addr constant [46 x i8] c"Warning: Slice_int::copy: size() < arr.size()\00", align 1
@$const.main.str2 = private unnamed_addr constant [2 x i8] c" \00", align 1

define i32 @main() {
entry:
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	%sizeTmp = shl i32 %funcCallRet, 2
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %funcCallRet, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	br label %for.cond

for.cond:
	%i_9 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%slt = icmp slt i32 %i_9, %funcCallRet
	br i1 %slt, label %for.body, label %for.end

for.body:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 %i_9
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_9, 1
	br label %for.cond

for.end:
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc_2 to %class.Slice_int*
	%Slice_int.storage.addr_2 = bitcast %class.Slice_int* %castToClassPtr to i32**
	store i32* %arrayHeadPtrUnguarded, i32** %Slice_int.storage.addr_2, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr, align 4
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%arrayElemPtr = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	store i32 %arraySize, i32* %Slice_int.end.addr, align 4
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %castToClassPtr)
	br label %for.cond_2

for.cond_2:
	%i_10 = phi i32 [ 0, %for.end ], [ %prefix_inc_2, %for.body_2 ]
	%slt_2 = icmp slt i32 %i_10, %funcCallRet
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 %i_10
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
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 2
	%Slice_int.end = load i32, i32* %Slice_int.end.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%sub = sub i32 %Slice_int.end, %Slice_int.beg
	%eq = icmp eq i32 %sub, 0
	br i1 %eq, label %if.then, label %if.end

if.then:
	%Slice_int.end.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 2
	%Slice_int.end_2 = load i32, i32* %Slice_int.end.addr_2, align 4
	%Slice_int.beg.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_2 = load i32, i32* %Slice_int.beg.addr_2, align 4
	%sub_2 = sub i32 %Slice_int.end_2, %Slice_int.beg_2
	%sizeTmp_2 = shl i32 %sub_2, 2
	%size_2 = add i32 %sizeTmp_2, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size_2)
	%mallocInt32Ptr_2 = bitcast i8* %malloc_2 to i32*
	store i32 %sub_2, i32* %mallocInt32Ptr_2, align 4
	%arrayHeadPtrUnguarded_2 = getelementptr i32, i32* %mallocInt32Ptr_2, i32 1
	br label %for.cond

for.cond:
	%i = phi i32 [ 0, %if.then ], [ %prefix_inc, %for.body ]
	%Slice_int.end.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 2
	%Slice_int.end_3 = load i32, i32* %Slice_int.end.addr_3, align 4
	%Slice_int.beg.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_3 = load i32, i32* %Slice_int.beg.addr_3, align 4
	%sub_3 = sub i32 %Slice_int.end_3, %Slice_int.beg_3
	%slt_2 = icmp slt i32 %i, %sub_3
	br i1 %slt_2, label %for.body, label %for.end

for.body:
	%elementPtr_3 = getelementptr i32, i32* %arrayHeadPtrUnguarded_2, i32 %i
	%Slice_int.storage.addr_23 = bitcast %class.Slice_int* %r to i32**
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr_23, align 4
	%Slice_int.beg.addr_4 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_4 = load i32, i32* %Slice_int.beg.addr_4, align 4
	%add_2 = add i32 %Slice_int.beg_4, %i
	%elementPtr_4 = getelementptr i32, i32* %Slice_int.storage, i32 %add_2
	%arrayElement_3 = load i32, i32* %elementPtr_4, align 4
	store i32 %arrayElement_3, i32* %elementPtr_3, align 4
	%prefix_inc = add i32 %i, 1
	br label %for.cond

for.end:
	br label %return

if.end:
	%Slice_int.end.addr_4 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 2
	%Slice_int.end_4 = load i32, i32* %Slice_int.end.addr_4, align 4
	%Slice_int.beg.addr_5 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_5 = load i32, i32* %Slice_int.beg.addr_5, align 4
	%sub_4 = sub i32 %Slice_int.end_4, %Slice_int.beg_5
	%eq_2 = icmp eq i32 %sub_4, 0
	br i1 %eq_2, label %if.then_2, label %if.end_2

if.then_2:
	%Slice_int.end.addr_5 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 2
	%Slice_int.end_5 = load i32, i32* %Slice_int.end.addr_5, align 4
	%Slice_int.beg.addr_6 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_6 = load i32, i32* %Slice_int.beg.addr_6, align 4
	%sub_5 = sub i32 %Slice_int.end_5, %Slice_int.beg_6
	%sizeTmp_3 = shl i32 %sub_5, 2
	%size_3 = add i32 %sizeTmp_3, 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 %size_3)
	%mallocInt32Ptr_3 = bitcast i8* %malloc_3 to i32*
	store i32 %sub_5, i32* %mallocInt32Ptr_3, align 4
	%arrayHeadPtrUnguarded_3 = getelementptr i32, i32* %mallocInt32Ptr_3, i32 1
	br label %for.cond_2

for.cond_2:
	%i_2 = phi i32 [ 0, %if.then_2 ], [ %prefix_inc_2, %for.body_2 ]
	%Slice_int.end.addr_6 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 2
	%Slice_int.end_6 = load i32, i32* %Slice_int.end.addr_6, align 4
	%Slice_int.beg.addr_7 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_7 = load i32, i32* %Slice_int.beg.addr_7, align 4
	%sub_6 = sub i32 %Slice_int.end_6, %Slice_int.beg_7
	%slt_3 = icmp slt i32 %i_2, %sub_6
	br i1 %slt_3, label %for.body_2, label %for.end_2

for.body_2:
	%elementPtr_5 = getelementptr i32, i32* %arrayHeadPtrUnguarded_3, i32 %i_2
	%Slice_int.storage.addr_24 = bitcast %class.Slice_int* %l to i32**
	%Slice_int.storage_2 = load i32*, i32** %Slice_int.storage.addr_24, align 4
	%Slice_int.beg.addr_8 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_8 = load i32, i32* %Slice_int.beg.addr_8, align 4
	%add_3 = add i32 %Slice_int.beg_8, %i_2
	%elementPtr_6 = getelementptr i32, i32* %Slice_int.storage_2, i32 %add_3
	%arrayElement_4 = load i32, i32* %elementPtr_6, align 4
	store i32 %arrayElement_4, i32* %elementPtr_5, align 4
	%prefix_inc_2 = add i32 %i_2, 1
	br label %for.cond_2

for.end_2:
	br label %return

if.end_2:
	%Slice_int.end.addr_7 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 2
	%Slice_int.end_7 = load i32, i32* %Slice_int.end.addr_7, align 4
	%Slice_int.beg.addr_9 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_9 = load i32, i32* %Slice_int.beg.addr_9, align 4
	%sub_7 = sub i32 %Slice_int.end_7, %Slice_int.beg_9
	%Slice_int.end.addr_8 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 2
	%Slice_int.end_8 = load i32, i32* %Slice_int.end.addr_8, align 4
	%Slice_int.beg.addr_10 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_10 = load i32, i32* %Slice_int.beg.addr_10, align 4
	%sub_8 = sub i32 %Slice_int.end_8, %Slice_int.beg_10
	%add = add i32 %sub_7, %sub_8
	%sizeTmp = shl i32 %add, 2
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %add, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc_4 to %class.Slice_int*
	%Slice_int.storage.addr_25 = bitcast %class.Slice_int* %castToClassPtr to i32**
	store i32* %arrayHeadPtrUnguarded, i32** %Slice_int.storage.addr_25, align 4
	%Slice_int.beg.addr_11 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr_11, align 4
	%Slice_int.end.addr_9 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%arrayElemPtr = getelementptr i32, i32* %arrayHeadPtrUnguarded, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	store i32 %arraySize, i32* %Slice_int.end.addr_9, align 4
	%Slice_int.end_9 = load i32, i32* %Slice_int.end.addr_9, align 4
	%Slice_int.beg_11 = load i32, i32* %Slice_int.beg.addr_11, align 4
	%sub_9 = sub i32 %Slice_int.end_9, %Slice_int.beg_11
	%malloc_5 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_2 = bitcast i8* %malloc_5 to %class.Slice_int*
	%Slice_int.storage.addr_26 = bitcast %class.Slice_int* %castToClassPtr_2 to i32**
	%Slice_int.storage_3 = load i32*, i32** %Slice_int.storage.addr_25, align 4
	store i32* %Slice_int.storage_3, i32** %Slice_int.storage.addr_26, align 4
	%Slice_int.beg.addr_13 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg_12 = load i32, i32* %Slice_int.beg.addr_11, align 4
	%add_4 = add i32 %Slice_int.beg_12, 1
	store i32 %add_4, i32* %Slice_int.beg.addr_13, align 4
	%Slice_int.end.addr_11 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.beg_13 = load i32, i32* %Slice_int.beg.addr_11, align 4
	%add_5 = add i32 %Slice_int.beg_13, %sub_9
	store i32 %add_5, i32* %Slice_int.end.addr_11, align 4
	%Slice_int.beg_14 = load i32, i32* %Slice_int.beg.addr_13, align 4
	%Slice_int.storage_4 = load i32*, i32** %Slice_int.storage.addr_25, align 4
	%arrayElemPtr_2 = getelementptr i32, i32* %Slice_int.storage_4, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%sgt = icmp sgt i32 %Slice_int.beg_14, %arraySize_2
	br i1 %sgt, label %logical_or_end, label %logical_or_branch

logical_or_branch:
	%Slice_int.end.addr_12 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.end_10 = load i32, i32* %Slice_int.end.addr_12, align 4
	%Slice_int.storage.addr_28 = bitcast %class.Slice_int* %castToClassPtr to i32**
	%Slice_int.storage_5 = load i32*, i32** %Slice_int.storage.addr_28, align 4
	%arrayElemPtr_3 = getelementptr i32, i32* %Slice_int.storage_5, i32 -1
	%arraySize_3 = load i32, i32* %arrayElemPtr_3, align 4
	%sgt_2 = icmp sgt i32 %Slice_int.end_10, %arraySize_3
	br label %logical_or_end

logical_or_end:
	%logicalOr = phi i1 [ 1, %if.end_2 ], [ %sgt_2, %logical_or_branch ]
	br i1 %logicalOr, label %if.then_4, label %if.end_4

if.then_4:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	br label %if.end_4

if.end_4:
	%Slice_int.storage.addr_29 = bitcast %class.Slice_int* %l to i32**
	%Slice_int.storage_6 = load i32*, i32** %Slice_int.storage.addr_29, align 4
	%Slice_int.beg.addr_15 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_15 = load i32, i32* %Slice_int.beg.addr_15, align 4
	%elementPtr_7 = getelementptr i32, i32* %Slice_int.storage_6, i32 %Slice_int.beg_15
	%arrayElement_5 = load i32, i32* %elementPtr_7, align 4
	%Slice_int.storage.addr_30 = bitcast %class.Slice_int* %r to i32**
	%Slice_int.storage_7 = load i32*, i32** %Slice_int.storage.addr_30, align 4
	%Slice_int.beg.addr_16 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_16 = load i32, i32* %Slice_int.beg.addr_16, align 4
	%elementPtr_8 = getelementptr i32, i32* %Slice_int.storage_7, i32 %Slice_int.beg_16
	%arrayElement_6 = load i32, i32* %elementPtr_8, align 4
	%slt = icmp slt i32 %arrayElement_5, %arrayElement_6
	br i1 %slt, label %if.then_3, label %if.else

if.then_3:
	%Slice_int.storage.addr_31 = bitcast %class.Slice_int* %l to i32**
	%Slice_int.storage_8 = load i32*, i32** %Slice_int.storage.addr_31, align 4
	%Slice_int.beg.addr_17 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 1
	%Slice_int.beg_17 = load i32, i32* %Slice_int.beg.addr_17, align 4
	%elementPtr_9 = getelementptr i32, i32* %Slice_int.storage_8, i32 %Slice_int.beg_17
	%arrayElement_7 = load i32, i32* %elementPtr_9, align 4
	store i32 %arrayElement_7, i32* %arrayHeadPtrUnguarded, align 4
	%Slice_int.end.addr_13 = getelementptr %class.Slice_int, %class.Slice_int* %l, i32 0, i32 2
	%Slice_int.end_11 = load i32, i32* %Slice_int.end.addr_13, align 4
	%Slice_int.beg_18 = load i32, i32* %Slice_int.beg.addr_17, align 4
	%sub_10 = sub i32 %Slice_int.end_11, %Slice_int.beg_18
	%malloc_6 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_3 = bitcast i8* %malloc_6 to %class.Slice_int*
	%Slice_int.storage.addr_32 = bitcast %class.Slice_int* %castToClassPtr_3 to i32**
	%Slice_int.storage_9 = load i32*, i32** %Slice_int.storage.addr_31, align 4
	store i32* %Slice_int.storage_9, i32** %Slice_int.storage.addr_32, align 4
	%Slice_int.beg.addr_19 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 1
	%Slice_int.beg_19 = load i32, i32* %Slice_int.beg.addr_17, align 4
	%add_9 = add i32 %Slice_int.beg_19, 1
	store i32 %add_9, i32* %Slice_int.beg.addr_19, align 4
	%Slice_int.end.addr_14 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 2
	%Slice_int.beg_20 = load i32, i32* %Slice_int.beg.addr_17, align 4
	%add_10 = add i32 %Slice_int.beg_20, %sub_10
	store i32 %add_10, i32* %Slice_int.end.addr_14, align 4
	%Slice_int.beg_21 = load i32, i32* %Slice_int.beg.addr_19, align 4
	%Slice_int.storage_10 = load i32*, i32** %Slice_int.storage.addr_31, align 4
	%arrayElemPtr_4 = getelementptr i32, i32* %Slice_int.storage_10, i32 -1
	%arraySize_4 = load i32, i32* %arrayElemPtr_4, align 4
	%sgt_3 = icmp sgt i32 %Slice_int.beg_21, %arraySize_4
	br i1 %sgt_3, label %logical_or_end_2, label %logical_or_branch_2

logical_or_branch_2:
	%Slice_int.end.addr_15 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 2
	%Slice_int.end_12 = load i32, i32* %Slice_int.end.addr_15, align 4
	%Slice_int.storage.addr_34 = bitcast %class.Slice_int* %l to i32**
	%Slice_int.storage_11 = load i32*, i32** %Slice_int.storage.addr_34, align 4
	%arrayElemPtr_5 = getelementptr i32, i32* %Slice_int.storage_11, i32 -1
	%arraySize_5 = load i32, i32* %arrayElemPtr_5, align 4
	%sgt_4 = icmp sgt i32 %Slice_int.end_12, %arraySize_5
	br label %logical_or_end_2

logical_or_end_2:
	%logicalOr_2 = phi i1 [ 1, %if.then_3 ], [ %sgt_4, %logical_or_branch_2 ]
	br i1 %logicalOr_2, label %if.then_5, label %if.end_5

if.then_5:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_2 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_2)
	br label %if.end_5

if.end_5:
	%funcCallRet_13 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %castToClassPtr_3, %class.Slice_int* %r)
	%malloc_7 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_4 = bitcast i8* %malloc_7 to %class.Slice_int*
	%Slice_int.storage.addr_35 = bitcast %class.Slice_int* %castToClassPtr_4 to i32**
	store i32* %funcCallRet_13, i32** %Slice_int.storage.addr_35, align 4
	%Slice_int.beg.addr_21 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr_21, align 4
	%Slice_int.end.addr_16 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 2
	%arrayElemPtr_6 = getelementptr i32, i32* %funcCallRet_13, i32 -1
	%arraySize_6 = load i32, i32* %arrayElemPtr_6, align 4
	store i32 %arraySize_6, i32* %Slice_int.end.addr_16, align 4
	%Slice_int.end.addr_17 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.end_13 = load i32, i32* %Slice_int.end.addr_17, align 4
	%Slice_int.beg.addr_22 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg_22 = load i32, i32* %Slice_int.beg.addr_22, align 4
	%sub_11 = sub i32 %Slice_int.end_13, %Slice_int.beg_22
	%Slice_int.end_14 = load i32, i32* %Slice_int.end.addr_16, align 4
	%Slice_int.beg_23 = load i32, i32* %Slice_int.beg.addr_21, align 4
	%sub_12 = sub i32 %Slice_int.end_14, %Slice_int.beg_23
	%slt_4 = icmp slt i32 %sub_11, %sub_12
	br i1 %slt_4, label %if.then_6, label %if.end_6

if.then_6:
	%$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1 = getelementptr [46 x i8], [46 x i8]* @$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	br label %if.end_6

if.end_6:
	br label %for.cond_3

for.cond_3:
	%i_3 = phi i32 [ 0, %if.end_6 ], [ %prefix_inc_3, %for.body_3 ]
	%Slice_int.end.addr_19 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 2
	%Slice_int.end_15 = load i32, i32* %Slice_int.end.addr_19, align 4
	%Slice_int.beg.addr_24 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 1
	%Slice_int.beg_24 = load i32, i32* %Slice_int.beg.addr_24, align 4
	%sub_13 = sub i32 %Slice_int.end_15, %Slice_int.beg_24
	%slt_5 = icmp slt i32 %i_3, %sub_13
	br i1 %slt_5, label %for.body_3, label %for.end_3

for.body_3:
	%Slice_int.storage.addr_36 = bitcast %class.Slice_int* %castToClassPtr_2 to i32**
	%Slice_int.storage_12 = load i32*, i32** %Slice_int.storage.addr_36, align 4
	%Slice_int.beg.addr_25 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg_25 = load i32, i32* %Slice_int.beg.addr_25, align 4
	%add_11 = add i32 %Slice_int.beg_25, %i_3
	%elementPtr_10 = getelementptr i32, i32* %Slice_int.storage_12, i32 %add_11
	%Slice_int.storage.addr_37 = bitcast %class.Slice_int* %castToClassPtr_4 to i32**
	%Slice_int.storage_13 = load i32*, i32** %Slice_int.storage.addr_37, align 4
	%Slice_int.beg.addr_26 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 1
	%Slice_int.beg_26 = load i32, i32* %Slice_int.beg.addr_26, align 4
	%add_12 = add i32 %Slice_int.beg_26, %i_3
	%elementPtr_11 = getelementptr i32, i32* %Slice_int.storage_13, i32 %add_12
	%arrayElement_8 = load i32, i32* %elementPtr_11, align 4
	store i32 %arrayElement_8, i32* %elementPtr_10, align 4
	%prefix_inc_3 = add i32 %i_3, 1
	br label %for.cond_3

for.end_3:
	br label %if.end_3

if.else:
	%Slice_int.storage.addr_38 = bitcast %class.Slice_int* %r to i32**
	%Slice_int.storage_14 = load i32*, i32** %Slice_int.storage.addr_38, align 4
	%Slice_int.beg.addr_27 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 1
	%Slice_int.beg_27 = load i32, i32* %Slice_int.beg.addr_27, align 4
	%elementPtr_12 = getelementptr i32, i32* %Slice_int.storage_14, i32 %Slice_int.beg_27
	%arrayElement_9 = load i32, i32* %elementPtr_12, align 4
	store i32 %arrayElement_9, i32* %arrayHeadPtrUnguarded, align 4
	%Slice_int.end.addr_20 = getelementptr %class.Slice_int, %class.Slice_int* %r, i32 0, i32 2
	%Slice_int.end_16 = load i32, i32* %Slice_int.end.addr_20, align 4
	%Slice_int.beg_28 = load i32, i32* %Slice_int.beg.addr_27, align 4
	%sub_14 = sub i32 %Slice_int.end_16, %Slice_int.beg_28
	%malloc_8 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_5 = bitcast i8* %malloc_8 to %class.Slice_int*
	%Slice_int.storage.addr_39 = bitcast %class.Slice_int* %castToClassPtr_5 to i32**
	%Slice_int.storage_15 = load i32*, i32** %Slice_int.storage.addr_38, align 4
	store i32* %Slice_int.storage_15, i32** %Slice_int.storage.addr_39, align 4
	%Slice_int.beg.addr_29 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 1
	%Slice_int.beg_29 = load i32, i32* %Slice_int.beg.addr_27, align 4
	%add_14 = add i32 %Slice_int.beg_29, 1
	store i32 %add_14, i32* %Slice_int.beg.addr_29, align 4
	%Slice_int.end.addr_21 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 2
	%Slice_int.beg_30 = load i32, i32* %Slice_int.beg.addr_27, align 4
	%add_15 = add i32 %Slice_int.beg_30, %sub_14
	store i32 %add_15, i32* %Slice_int.end.addr_21, align 4
	%Slice_int.beg_31 = load i32, i32* %Slice_int.beg.addr_29, align 4
	%Slice_int.storage_16 = load i32*, i32** %Slice_int.storage.addr_38, align 4
	%arrayElemPtr_7 = getelementptr i32, i32* %Slice_int.storage_16, i32 -1
	%arraySize_7 = load i32, i32* %arrayElemPtr_7, align 4
	%sgt_5 = icmp sgt i32 %Slice_int.beg_31, %arraySize_7
	br i1 %sgt_5, label %logical_or_end_3, label %logical_or_branch_3

logical_or_branch_3:
	%Slice_int.end.addr_22 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 2
	%Slice_int.end_17 = load i32, i32* %Slice_int.end.addr_22, align 4
	%Slice_int.storage.addr_41 = bitcast %class.Slice_int* %r to i32**
	%Slice_int.storage_17 = load i32*, i32** %Slice_int.storage.addr_41, align 4
	%arrayElemPtr_8 = getelementptr i32, i32* %Slice_int.storage_17, i32 -1
	%arraySize_8 = load i32, i32* %arrayElemPtr_8, align 4
	%sgt_6 = icmp sgt i32 %Slice_int.end_17, %arraySize_8
	br label %logical_or_end_3

logical_or_end_3:
	%logicalOr_3 = phi i1 [ 1, %if.else ], [ %sgt_6, %logical_or_branch_3 ]
	br i1 %logicalOr_3, label %if.then_7, label %if.end_7

if.then_7:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_3 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_3)
	br label %if.end_7

if.end_7:
	%funcCallRet_17 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %l, %class.Slice_int* %castToClassPtr_5)
	%malloc_9 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_6 = bitcast i8* %malloc_9 to %class.Slice_int*
	%Slice_int.storage.addr_42 = bitcast %class.Slice_int* %castToClassPtr_6 to i32**
	store i32* %funcCallRet_17, i32** %Slice_int.storage.addr_42, align 4
	%Slice_int.beg.addr_31 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_6, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr_31, align 4
	%Slice_int.end.addr_23 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_6, i32 0, i32 2
	%arrayElemPtr_9 = getelementptr i32, i32* %funcCallRet_17, i32 -1
	%arraySize_9 = load i32, i32* %arrayElemPtr_9, align 4
	store i32 %arraySize_9, i32* %Slice_int.end.addr_23, align 4
	%Slice_int.end.addr_24 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.end_18 = load i32, i32* %Slice_int.end.addr_24, align 4
	%Slice_int.beg.addr_32 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg_32 = load i32, i32* %Slice_int.beg.addr_32, align 4
	%sub_15 = sub i32 %Slice_int.end_18, %Slice_int.beg_32
	%Slice_int.end_19 = load i32, i32* %Slice_int.end.addr_23, align 4
	%Slice_int.beg_33 = load i32, i32* %Slice_int.beg.addr_31, align 4
	%sub_16 = sub i32 %Slice_int.end_19, %Slice_int.beg_33
	%slt_6 = icmp slt i32 %sub_15, %sub_16
	br i1 %slt_6, label %if.then_8, label %if.end_8

if.then_8:
	%$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1_2 = getelementptr [46 x i8], [46 x i8]* @$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1_2)
	br label %if.end_8

if.end_8:
	br label %for.cond_4

for.cond_4:
	%i_4 = phi i32 [ 0, %if.end_8 ], [ %prefix_inc_4, %for.body_4 ]
	%Slice_int.end.addr_26 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_6, i32 0, i32 2
	%Slice_int.end_20 = load i32, i32* %Slice_int.end.addr_26, align 4
	%Slice_int.beg.addr_34 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_6, i32 0, i32 1
	%Slice_int.beg_34 = load i32, i32* %Slice_int.beg.addr_34, align 4
	%sub_17 = sub i32 %Slice_int.end_20, %Slice_int.beg_34
	%slt_7 = icmp slt i32 %i_4, %sub_17
	br i1 %slt_7, label %for.body_4, label %for.end_4

for.body_4:
	%Slice_int.storage.addr_43 = bitcast %class.Slice_int* %castToClassPtr_2 to i32**
	%Slice_int.storage_18 = load i32*, i32** %Slice_int.storage.addr_43, align 4
	%Slice_int.beg.addr_35 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg_35 = load i32, i32* %Slice_int.beg.addr_35, align 4
	%add_16 = add i32 %Slice_int.beg_35, %i_4
	%elementPtr_13 = getelementptr i32, i32* %Slice_int.storage_18, i32 %add_16
	%Slice_int.storage.addr_44 = bitcast %class.Slice_int* %castToClassPtr_6 to i32**
	%Slice_int.storage_19 = load i32*, i32** %Slice_int.storage.addr_44, align 4
	%Slice_int.beg.addr_36 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_6, i32 0, i32 1
	%Slice_int.beg_36 = load i32, i32* %Slice_int.beg.addr_36, align 4
	%add_17 = add i32 %Slice_int.beg_36, %i_4
	%elementPtr_14 = getelementptr i32, i32* %Slice_int.storage_19, i32 %add_17
	%arrayElement_10 = load i32, i32* %elementPtr_14, align 4
	store i32 %arrayElement_10, i32* %elementPtr_13, align 4
	%prefix_inc_4 = add i32 %i_4, 1
	br label %for.cond_4

for.end_4:
	br label %if.end_3

if.end_3:
	br label %return

return:
	%retval_2 = phi i32* [ %arrayHeadPtrUnguarded_2, %for.end ], [ %arrayHeadPtrUnguarded_3, %for.end_2 ], [ %arrayHeadPtrUnguarded, %if.end_3 ]
	ret i32* %retval_2
}

define void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %a) {
entry:
	%Slice_int.end.addr = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 2
	%Slice_int.end = load i32, i32* %Slice_int.end.addr, align 4
	%Slice_int.beg.addr = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg = load i32, i32* %Slice_int.beg.addr, align 4
	%sub = sub i32 %Slice_int.end, %Slice_int.beg
	%eq = icmp eq i32 %sub, 1
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%Slice_int.end.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 2
	%Slice_int.end_2 = load i32, i32* %Slice_int.end.addr_2, align 4
	%Slice_int.beg.addr_2 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_2 = load i32, i32* %Slice_int.beg.addr_2, align 4
	%sub_2 = sub i32 %Slice_int.end_2, %Slice_int.beg_2
	%sdiv = sdiv i32 %sub_2, 2
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc to %class.Slice_int*
	%Slice_int.storage.addr_16 = bitcast %class.Slice_int* %castToClassPtr to i32**
	%Slice_int.storage.addr_17 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage = load i32*, i32** %Slice_int.storage.addr_17, align 4
	store i32* %Slice_int.storage, i32** %Slice_int.storage.addr_16, align 4
	%Slice_int.beg.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 1
	%Slice_int.beg_3 = load i32, i32* %Slice_int.beg.addr_2, align 4
	store i32 %Slice_int.beg_3, i32* %Slice_int.beg.addr_3, align 4
	%Slice_int.end.addr_3 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%Slice_int.beg_4 = load i32, i32* %Slice_int.beg.addr_2, align 4
	%add_2 = add i32 %Slice_int.beg_4, %sdiv
	store i32 %add_2, i32* %Slice_int.end.addr_3, align 4
	%Slice_int.beg_5 = load i32, i32* %Slice_int.beg.addr_3, align 4
	%Slice_int.storage_2 = load i32*, i32** %Slice_int.storage.addr_17, align 4
	%arrayElemPtr = getelementptr i32, i32* %Slice_int.storage_2, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%sgt = icmp sgt i32 %Slice_int.beg_5, %arraySize
	br i1 %sgt, label %logical_or_end, label %logical_or_branch

logical_or_branch:
	%Slice_int.end.addr_4 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr, i32 0, i32 2
	%Slice_int.end_3 = load i32, i32* %Slice_int.end.addr_4, align 4
	%Slice_int.storage.addr_18 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_3 = load i32*, i32** %Slice_int.storage.addr_18, align 4
	%arrayElemPtr_2 = getelementptr i32, i32* %Slice_int.storage_3, i32 -1
	%arraySize_2 = load i32, i32* %arrayElemPtr_2, align 4
	%sgt_2 = icmp sgt i32 %Slice_int.end_3, %arraySize_2
	br label %logical_or_end

logical_or_end:
	%logicalOr = phi i1 [ 1, %if.end ], [ %sgt_2, %logical_or_branch ]
	br i1 %logicalOr, label %if.then_2, label %if.end_2

if.then_2:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0)
	br label %if.end_2

if.end_2:
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %castToClassPtr)
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_2 = bitcast i8* %malloc_2 to %class.Slice_int*
	%Slice_int.storage.addr_19 = bitcast %class.Slice_int* %castToClassPtr_2 to i32**
	%Slice_int.storage.addr_20 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_4 = load i32*, i32** %Slice_int.storage.addr_20, align 4
	store i32* %Slice_int.storage_4, i32** %Slice_int.storage.addr_19, align 4
	%Slice_int.beg.addr_5 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 1
	%Slice_int.beg.addr_6 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_6 = load i32, i32* %Slice_int.beg.addr_6, align 4
	%add_3 = add i32 %Slice_int.beg_6, %sdiv
	store i32 %add_3, i32* %Slice_int.beg.addr_5, align 4
	%Slice_int.end.addr_5 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.beg_7 = load i32, i32* %Slice_int.beg.addr_6, align 4
	%add_4 = add i32 %Slice_int.beg_7, %sub_2
	store i32 %add_4, i32* %Slice_int.end.addr_5, align 4
	%Slice_int.beg_8 = load i32, i32* %Slice_int.beg.addr_5, align 4
	%Slice_int.storage_5 = load i32*, i32** %Slice_int.storage.addr_20, align 4
	%arrayElemPtr_3 = getelementptr i32, i32* %Slice_int.storage_5, i32 -1
	%arraySize_3 = load i32, i32* %arrayElemPtr_3, align 4
	%sgt_3 = icmp sgt i32 %Slice_int.beg_8, %arraySize_3
	br i1 %sgt_3, label %logical_or_end_2, label %logical_or_branch_2

logical_or_branch_2:
	%Slice_int.end.addr_6 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_2, i32 0, i32 2
	%Slice_int.end_4 = load i32, i32* %Slice_int.end.addr_6, align 4
	%Slice_int.storage.addr_21 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_6 = load i32*, i32** %Slice_int.storage.addr_21, align 4
	%arrayElemPtr_4 = getelementptr i32, i32* %Slice_int.storage_6, i32 -1
	%arraySize_4 = load i32, i32* %arrayElemPtr_4, align 4
	%sgt_4 = icmp sgt i32 %Slice_int.end_4, %arraySize_4
	br label %logical_or_end_2

logical_or_end_2:
	%logicalOr_2 = phi i1 [ 1, %if.end_2 ], [ %sgt_4, %logical_or_branch_2 ]
	br i1 %logicalOr_2, label %if.then_3, label %if.end_3

if.then_3:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_2 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_2)
	br label %if.end_3

if.end_3:
	call void @_mergeSort$$YGXUSlice_int$$$Z(%class.Slice_int* %castToClassPtr_2)
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_3 = bitcast i8* %malloc_3 to %class.Slice_int*
	%Slice_int.storage.addr_22 = bitcast %class.Slice_int* %castToClassPtr_3 to i32**
	%Slice_int.storage.addr_23 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_7 = load i32*, i32** %Slice_int.storage.addr_23, align 4
	store i32* %Slice_int.storage_7, i32** %Slice_int.storage.addr_22, align 4
	%Slice_int.beg.addr_7 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 1
	%Slice_int.beg.addr_8 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_9 = load i32, i32* %Slice_int.beg.addr_8, align 4
	store i32 %Slice_int.beg_9, i32* %Slice_int.beg.addr_7, align 4
	%Slice_int.end.addr_7 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 2
	%Slice_int.beg_10 = load i32, i32* %Slice_int.beg.addr_8, align 4
	%add_6 = add i32 %Slice_int.beg_10, %sdiv
	store i32 %add_6, i32* %Slice_int.end.addr_7, align 4
	%Slice_int.beg_11 = load i32, i32* %Slice_int.beg.addr_7, align 4
	%Slice_int.storage_8 = load i32*, i32** %Slice_int.storage.addr_23, align 4
	%arrayElemPtr_5 = getelementptr i32, i32* %Slice_int.storage_8, i32 -1
	%arraySize_5 = load i32, i32* %arrayElemPtr_5, align 4
	%sgt_5 = icmp sgt i32 %Slice_int.beg_11, %arraySize_5
	br i1 %sgt_5, label %logical_or_end_3, label %logical_or_branch_3

logical_or_branch_3:
	%Slice_int.end.addr_8 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_3, i32 0, i32 2
	%Slice_int.end_5 = load i32, i32* %Slice_int.end.addr_8, align 4
	%Slice_int.storage.addr_24 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_9 = load i32*, i32** %Slice_int.storage.addr_24, align 4
	%arrayElemPtr_6 = getelementptr i32, i32* %Slice_int.storage_9, i32 -1
	%arraySize_6 = load i32, i32* %arrayElemPtr_6, align 4
	%sgt_6 = icmp sgt i32 %Slice_int.end_5, %arraySize_6
	br label %logical_or_end_3

logical_or_end_3:
	%logicalOr_3 = phi i1 [ 1, %if.end_3 ], [ %sgt_6, %logical_or_branch_3 ]
	br i1 %logicalOr_3, label %if.then_4, label %if.end_4

if.then_4:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_3 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_3)
	br label %if.end_4

if.end_4:
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_4 = bitcast i8* %malloc_4 to %class.Slice_int*
	%Slice_int.storage.addr_25 = bitcast %class.Slice_int* %castToClassPtr_4 to i32**
	%Slice_int.storage.addr_26 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_10 = load i32*, i32** %Slice_int.storage.addr_26, align 4
	store i32* %Slice_int.storage_10, i32** %Slice_int.storage.addr_25, align 4
	%Slice_int.beg.addr_9 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 1
	%Slice_int.beg.addr_10 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_12 = load i32, i32* %Slice_int.beg.addr_10, align 4
	%add_7 = add i32 %Slice_int.beg_12, %sdiv
	store i32 %add_7, i32* %Slice_int.beg.addr_9, align 4
	%Slice_int.end.addr_9 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 2
	%Slice_int.beg_13 = load i32, i32* %Slice_int.beg.addr_10, align 4
	%add_8 = add i32 %Slice_int.beg_13, %sub_2
	store i32 %add_8, i32* %Slice_int.end.addr_9, align 4
	%Slice_int.beg_14 = load i32, i32* %Slice_int.beg.addr_9, align 4
	%Slice_int.storage_11 = load i32*, i32** %Slice_int.storage.addr_26, align 4
	%arrayElemPtr_7 = getelementptr i32, i32* %Slice_int.storage_11, i32 -1
	%arraySize_7 = load i32, i32* %arrayElemPtr_7, align 4
	%sgt_7 = icmp sgt i32 %Slice_int.beg_14, %arraySize_7
	br i1 %sgt_7, label %logical_or_end_4, label %logical_or_branch_4

logical_or_branch_4:
	%Slice_int.end.addr_10 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_4, i32 0, i32 2
	%Slice_int.end_6 = load i32, i32* %Slice_int.end.addr_10, align 4
	%Slice_int.storage.addr_27 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_12 = load i32*, i32** %Slice_int.storage.addr_27, align 4
	%arrayElemPtr_8 = getelementptr i32, i32* %Slice_int.storage_12, i32 -1
	%arraySize_8 = load i32, i32* %arrayElemPtr_8, align 4
	%sgt_8 = icmp sgt i32 %Slice_int.end_6, %arraySize_8
	br label %logical_or_end_4

logical_or_end_4:
	%logicalOr_4 = phi i1 [ 1, %if.end_4 ], [ %sgt_8, %logical_or_branch_4 ]
	br i1 %logicalOr_4, label %if.then_5, label %if.end_5

if.then_5:
	%$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_4 = getelementptr [40 x i8], [40 x i8]* @$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._slice$Slice_int$$QEAUSlice_int$$HH$Z.str0_4)
	br label %if.end_5

if.end_5:
	%funcCallRet_6 = call i32* @_merge$$YGPAHUSlice_int$$USlice_int$$$Z(%class.Slice_int* %castToClassPtr_3, %class.Slice_int* %castToClassPtr_4)
	%malloc_5 = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr_5 = bitcast i8* %malloc_5 to %class.Slice_int*
	%Slice_int.storage.addr_28 = bitcast %class.Slice_int* %castToClassPtr_5 to i32**
	store i32* %funcCallRet_6, i32** %Slice_int.storage.addr_28, align 4
	%Slice_int.beg.addr_11 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 1
	store i32 0, i32* %Slice_int.beg.addr_11, align 4
	%Slice_int.end.addr_11 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 2
	%arrayElemPtr_9 = getelementptr i32, i32* %funcCallRet_6, i32 -1
	%arraySize_9 = load i32, i32* %arrayElemPtr_9, align 4
	store i32 %arraySize_9, i32* %Slice_int.end.addr_11, align 4
	%Slice_int.end.addr_12 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 2
	%Slice_int.end_7 = load i32, i32* %Slice_int.end.addr_12, align 4
	%Slice_int.beg.addr_12 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_15 = load i32, i32* %Slice_int.beg.addr_12, align 4
	%sub_3 = sub i32 %Slice_int.end_7, %Slice_int.beg_15
	%Slice_int.end_8 = load i32, i32* %Slice_int.end.addr_11, align 4
	%Slice_int.beg_16 = load i32, i32* %Slice_int.beg.addr_11, align 4
	%sub_4 = sub i32 %Slice_int.end_8, %Slice_int.beg_16
	%slt = icmp slt i32 %sub_3, %sub_4
	br i1 %slt, label %if.then_6, label %if.end_6

if.then_6:
	%$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1 = getelementptr [46 x i8], [46 x i8]* @$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %$const._copy$Slice_int$$QEAXUSlice_int$$$Z.str1)
	br label %if.end_6

if.end_6:
	br label %for.cond

for.cond:
	%i = phi i32 [ 0, %if.end_6 ], [ %prefix_inc, %for.body ]
	%Slice_int.end.addr_14 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 2
	%Slice_int.end_9 = load i32, i32* %Slice_int.end.addr_14, align 4
	%Slice_int.beg.addr_14 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 1
	%Slice_int.beg_17 = load i32, i32* %Slice_int.beg.addr_14, align 4
	%sub_5 = sub i32 %Slice_int.end_9, %Slice_int.beg_17
	%slt_2 = icmp slt i32 %i, %sub_5
	br i1 %slt_2, label %for.body, label %for.end

for.body:
	%Slice_int.storage.addr_29 = bitcast %class.Slice_int* %a to i32**
	%Slice_int.storage_13 = load i32*, i32** %Slice_int.storage.addr_29, align 4
	%Slice_int.beg.addr_15 = getelementptr %class.Slice_int, %class.Slice_int* %a, i32 0, i32 1
	%Slice_int.beg_18 = load i32, i32* %Slice_int.beg.addr_15, align 4
	%add_9 = add i32 %Slice_int.beg_18, %i
	%elementPtr = getelementptr i32, i32* %Slice_int.storage_13, i32 %add_9
	%Slice_int.storage.addr_30 = bitcast %class.Slice_int* %castToClassPtr_5 to i32**
	%Slice_int.storage_14 = load i32*, i32** %Slice_int.storage.addr_30, align 4
	%Slice_int.beg.addr_16 = getelementptr %class.Slice_int, %class.Slice_int* %castToClassPtr_5, i32 0, i32 1
	%Slice_int.beg_19 = load i32, i32* %Slice_int.beg.addr_16, align 4
	%add_10 = add i32 %Slice_int.beg_19, %i
	%elementPtr_2 = getelementptr i32, i32* %Slice_int.storage_14, i32 %add_10
	%arrayElement = load i32, i32* %elementPtr_2, align 4
	store i32 %arrayElement, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i, 1
	br label %for.cond

for.end:
	br label %return

return:
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

