@r = global i32* null, align 4
@ch = global i8* null, align 4
@w = global i32* null, align 4
@__const.main.str1 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@__const.main.str0 = private unnamed_addr constant [2 x i8] c" \00", align 1
@l = global i32* null, align 4
@M = global i32 0, align 4
@N = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_merge$$YGHHH$Z(i32 %x, i32 %y) {
entry:
	%eq = icmp eq i32 0, %x
	br i1 %eq, label %if.then, label %if.end

if.then:
	br label %return

if.end:
	%eq_2 = icmp eq i32 0, %y
	br i1 %eq_2, label %if.then_2, label %if.end_2

if.then_2:
	br label %return

if.end_2:
	%w = load i32*, i32** @w, align 4
	%elementPtr = getelementptr i32, i32* %w, i32 %x
	%arrayElement = load i32, i32* %elementPtr, align 4
	%w_2 = load i32*, i32** @w, align 4
	%elementPtr_2 = getelementptr i32, i32* %w_2, i32 %y
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%slt = icmp slt i32 %arrayElement, %arrayElement_2
	br i1 %slt, label %if.then_3, label %if.end_3

if.then_3:
	br label %if.end_3

if.end_3:
	%e_4 = phi i32 [ %x, %if.then_3 ], [ 0, %if.end_2 ]
	%y.addr_2 = phi i32 [ %x, %if.then_3 ], [ %y, %if.end_2 ]
	%x.addr_2 = phi i32 [ %y, %if.then_3 ], [ %x, %if.end_2 ]
	%r = load i32*, i32** @r, align 4
	%elementPtr_3 = getelementptr i32, i32* %r, i32 %x.addr_2
	%r_2 = load i32*, i32** @r, align 4
	%elementPtr_4 = getelementptr i32, i32* %r_2, i32 %x.addr_2
	%arrayElement_4 = load i32, i32* %elementPtr_4, align 4
	%funcCallRet = call i32 @_merge$$YGHHH$Z(i32 %arrayElement_4, i32 %y.addr_2)
	store i32 %funcCallRet, i32* %elementPtr_3, align 4
	%l = load i32*, i32** @l, align 4
	%elementPtr_5 = getelementptr i32, i32* %l, i32 %x.addr_2
	%arrayElement_5 = load i32, i32* %elementPtr_5, align 4
	%l_2 = load i32*, i32** @l, align 4
	%elementPtr_6 = getelementptr i32, i32* %l_2, i32 %x.addr_2
	%r_3 = load i32*, i32** @r, align 4
	%elementPtr_7 = getelementptr i32, i32* %r_3, i32 %x.addr_2
	%arrayElement_7 = load i32, i32* %elementPtr_7, align 4
	store i32 %arrayElement_7, i32* %elementPtr_6, align 4
	%r_4 = load i32*, i32** @r, align 4
	%elementPtr_8 = getelementptr i32, i32* %r_4, i32 %x.addr_2
	store i32 %arrayElement_5, i32* %elementPtr_8, align 4
	br label %return

return:
	%retval_2 = phi i32 [ %y, %if.then ], [ %x, %if.then_2 ], [ %x.addr_2, %if.end_3 ]
	%e_5 = phi i32 [ 0, %if.then ], [ 0, %if.then_2 ], [ %e_4, %if.end_3 ]
	%e_3 = phi i32 [ 0, %if.then ], [ 0, %if.then_2 ], [ %arrayElement_5, %if.end_3 ]
	%y.addr_3 = phi i32 [ %y, %if.then ], [ %y, %if.then_2 ], [ %y.addr_2, %if.end_3 ]
	%x.addr_3 = phi i32 [ %x, %if.then ], [ %x, %if.then_2 ], [ %x.addr_2, %if.end_3 ]
	ret i32 %retval_2
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @N, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @M, align 4
	%funcCallRet_3 = call i8* @_getString$$YGPADXZ()
	store i8* %funcCallRet_3, i8** @ch, align 4
	%N_2 = load i32, i32* @N, align 4
	%M_2 = load i32, i32* @M, align 4
	%add = add i32 %N_2, %M_2
	%add_2 = add i32 %add, 5
	%sizeTmp = mul i32 %add_2, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %add_2, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	store i32* %arrayHeadPtr, i32** @l, align 4
	%N_3 = load i32, i32* @N, align 4
	%M_3 = load i32, i32* @M, align 4
	%add_3 = add i32 %N_3, %M_3
	%add_4 = add i32 %add_3, 5
	%sizeTmp_2 = mul i32 %add_4, 4
	%size_2 = add i32 %sizeTmp_2, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size_2)
	%mallocInt32Ptr_2 = bitcast i8* %malloc_2 to i32*
	store i32 %add_4, i32* %mallocInt32Ptr_2, align 4
	%arrayHeadPtrUnguarded_2 = getelementptr i32, i32* %mallocInt32Ptr_2, i32 1
	%arrayHeadPtr_2 = bitcast i32* %arrayHeadPtrUnguarded_2 to i32*
	store i32* %arrayHeadPtr_2, i32** @r, align 4
	%N_4 = load i32, i32* @N, align 4
	%M_4 = load i32, i32* @M, align 4
	%add_5 = add i32 %N_4, %M_4
	%add_6 = add i32 %add_5, 5
	%sizeTmp_3 = mul i32 %add_6, 4
	%size_3 = add i32 %sizeTmp_3, 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 %size_3)
	%mallocInt32Ptr_3 = bitcast i8* %malloc_3 to i32*
	store i32 %add_6, i32* %mallocInt32Ptr_3, align 4
	%arrayHeadPtrUnguarded_3 = getelementptr i32, i32* %mallocInt32Ptr_3, i32 1
	%arrayHeadPtr_3 = bitcast i32* %arrayHeadPtrUnguarded_3 to i32*
	store i32* %arrayHeadPtr_3, i32** @w, align 4
	br label %for.cond

for.cond:
	%i_24 = phi i32 [ 1, %entry ], [ %postfix, %for.body ]
	%N_5 = load i32, i32* @N, align 4
	%sle = icmp sle i32 %i_24, %N_5
	br i1 %sle, label %for.body, label %for.end

for.body:
	%w_2 = load i32*, i32** @w, align 4
	%elementPtr = getelementptr i32, i32* %w_2, i32 %i_24
	%funcCallRet_4 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_4, i32* %elementPtr, align 4
	%l_2 = load i32*, i32** @l, align 4
	%elementPtr_2 = getelementptr i32, i32* %l_2, i32 %i_24
	store i32 0, i32* %elementPtr_2, align 4
	%r_2 = load i32*, i32** @r, align 4
	%elementPtr_3 = getelementptr i32, i32* %r_2, i32 %i_24
	store i32 0, i32* %elementPtr_3, align 4
	%postfix = add i32 %i_24, 1
	br label %for.cond

for.end:
	br label %for.cond_2

for.cond_2:
	%i_23 = phi i32 [ 1, %for.end ], [ %postfix_2, %for.body_2 ]
	%M_5 = load i32, i32* @M, align 4
	%sle_2 = icmp sle i32 %i_23, %M_5
	br i1 %sle_2, label %for.body_2, label %for.end_2

for.body_2:
	%w_3 = load i32*, i32** @w, align 4
	%N_6 = load i32, i32* @N, align 4
	%add_7 = add i32 %i_23, %N_6
	%elementPtr_4 = getelementptr i32, i32* %w_3, i32 %add_7
	%ch_2 = load i8*, i8** @ch, align 4
	%sub = sub i32 %i_23, 1
	%funcCallRet_5 = call i32 @_ord$string$$QEAHH$Z(i8* %ch_2, i32 %sub)
	store i32 %funcCallRet_5, i32* %elementPtr_4, align 4
	%l_3 = load i32*, i32** @l, align 4
	%N_7 = load i32, i32* @N, align 4
	%add_8 = add i32 %i_23, %N_7
	%elementPtr_5 = getelementptr i32, i32* %l_3, i32 %add_8
	store i32 0, i32* %elementPtr_5, align 4
	%r_3 = load i32*, i32** @r, align 4
	%N_8 = load i32, i32* @N, align 4
	%add_9 = add i32 %i_23, %N_8
	%elementPtr_6 = getelementptr i32, i32* %r_3, i32 %add_9
	store i32 0, i32* %elementPtr_6, align 4
	%postfix_2 = add i32 %i_23, 1
	br label %for.cond_2

for.end_2:
	%N_9 = load i32, i32* @N, align 4
	%add_10 = add i32 %N_9, 1
	br label %for.cond_3

for.cond_3:
	%rt0_5 = phi i32 [ 1, %for.end_2 ], [ %funcCallRet_6, %for.body_3 ]
	%i_22 = phi i32 [ 2, %for.end_2 ], [ %postfix_3, %for.body_3 ]
	%N_10 = load i32, i32* @N, align 4
	%sle_3 = icmp sle i32 %i_22, %N_10
	br i1 %sle_3, label %for.body_3, label %for.end_3

for.body_3:
	%funcCallRet_6 = call i32 @_merge$$YGHHH$Z(i32 %rt0_5, i32 %i_22)
	%postfix_3 = add i32 %i_22, 1
	br label %for.cond_3

for.end_3:
	%N_11 = load i32, i32* @N, align 4
	%add_11 = add i32 %N_11, 2
	br label %for.cond_4

for.cond_4:
	%i_25 = phi i32 [ %add_11, %for.end_3 ], [ %postfix_4, %for.body_4 ]
	%rt1_6 = phi i32 [ %add_10, %for.end_3 ], [ %funcCallRet_7, %for.body_4 ]
	%N_12 = load i32, i32* @N, align 4
	%M_6 = load i32, i32* @M, align 4
	%add_12 = add i32 %N_12, %M_6
	%sle_4 = icmp sle i32 %i_25, %add_12
	br i1 %sle_4, label %for.body_4, label %for.end_4

for.body_4:
	%funcCallRet_7 = call i32 @_merge$$YGHHH$Z(i32 %rt1_6, i32 %i_25)
	%postfix_4 = add i32 %i_25, 1
	br label %for.cond_4

for.end_4:
	%w_4 = load i32*, i32** @w, align 4
	%elementPtr_7 = getelementptr i32, i32* %w_4, i32 %rt0_5
	%arrayElement_7 = load i32, i32* %elementPtr_7, align 4
	%funcCallRet_8 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_7)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_8)
	%_ = getelementptr [2 x i8], [2 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %_)
	%ch_3 = load i8*, i8** @ch, align 4
	%N_13 = load i32, i32* @N, align 4
	%sub_2 = sub i32 %rt1_6, %N_13
	%sub_3 = sub i32 %sub_2, 1
	%N_14 = load i32, i32* @N, align 4
	%sub_4 = sub i32 %rt1_6, %N_14
	%funcCallRet_9 = call i8* @_substring$string$$QEAPADHH$Z(i8* %ch_3, i32 %sub_3, i32 %sub_4)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_9)
	%__2 = getelementptr [2 x i8], [2 x i8]* @__const.main.str1, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__2)
	%funcCallRet_11 = call i32 @_merge$$YGHHH$Z(i32 %rt0_5, i32 %rt1_6)
	%funcCallRet_10 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_11)
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

