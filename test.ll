define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	br label %for.cond

for.cond:
	%f1_4 = phi i32 [ 1, %entry ], [ %add, %for.body ]
	%f0_3 = phi i32 [ 0, %entry ], [ %f1_4, %for.body ]
	%i_4 = phi i32 [ 1, %entry ], [ %prefix_inc, %for.body ]
	%f2_4 = phi i32 [ 0, %entry ], [ %add, %for.body ]
	%slt = icmp slt i32 %i_4, 10
	br i1 %slt, label %for.body, label %for.end

for.body:
	%add = add i32 %f0_3, %f1_4
	%prefix_inc = add i32 %i_4, 1
	br label %for.cond

for.end:
	ret i32 %f2_4
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

