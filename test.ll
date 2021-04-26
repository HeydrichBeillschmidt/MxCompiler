@N = global i32 80, align 4

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_dceconst$$YGHXZ() {
entry:
	ret i32 114514
}

define i32 @_test$$YGHXZ() {
entry:
	br label %for.cond

for.cond:
	%i_5 = phi i32 [ 0, %entry ], [ %postfix_inc_3, %for.body ]
	%j_7 = phi i32 [ 0, %entry ], [ %postfix_inc_2, %for.body ]
	%slt = icmp slt i32 %i_5, 200
	br i1 %slt, label %for.body, label %for.end

for.body:
	%postfix_inc = add i32 %i_5, 1
	%postfix_inc_2 = add i32 %j_7, 1
	%postfix_inc_3 = add i32 %postfix_inc, 1
	br label %for.cond

for.end:
	ret i32 %j_7
}

define i32 @_naivedce$$YGHXZ() {
entry:
	ret i32 1919
}

define i32 @main() {
entry:
	%funcCallRet = call i32 @_test$$YGHXZ()
	%funcCallRet_2 = call i32 @_naivedce$$YGHXZ()
	%add = add i32 %funcCallRet, %funcCallRet_2
	%funcCallRet_3 = call i32 @_dceconst$$YGHXZ()
	%add_2 = add i32 %add, %funcCallRet_3
	%sub = sub i32 %add_2, 50997
	ret i32 %sub
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

