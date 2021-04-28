@_const._cd$$YGHHPADPADPADH$Z.str1 = private unnamed_addr constant [6 x i8] c" --> \00", align 1
@_const.main.str4 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@_const._cd$$YGHHPADPADPADH$Z.str0 = private unnamed_addr constant [6 x i8] c"move \00", align 1
@_const.main.str2 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@_const.main.str3 = private unnamed_addr constant [2 x i8] c"B\00", align 1

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_cd$$YGHHPADPADPADH$Z(i32 %d, i8* %a, i8* %b, i8* %c, i32 %sum) {
entry:
	%eq = icmp eq i32 %d, 1
	br i1 %eq, label %if.then, label %if.else

if.then:
	%_const. = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const., i8* %a)
	%_const._2 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_2 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add, i8* %_const._2)
	%add_3 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_2, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_3)
	%postfix = add i32 %sum, 1
	br label %if.end

if.else:
	%sub = sub i32 %d, 1
	%funcCallRet = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub, i8* %a, i8* %c, i8* %b, i32 %sum)
	%_const._3 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_4 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._3, i8* %a)
	%_const._4 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_5 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_4, i8* %_const._4)
	%add_6 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_5, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_6)
	%sub_2 = sub i32 %d, 1
	%funcCallRet_2 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_2, i8* %b, i8* %a, i8* %c, i32 %funcCallRet)
	%postfix_2 = add i32 %funcCallRet_2, 1
	br label %if.end

if.end:
	%sum.addr_2 = phi i32 [ %postfix, %if.then ], [ %postfix_2, %if.else ]
	ret i32 %sum.addr_2
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	% = getelementptr [2 x i8], [2 x i8]* @_const.main.str2, i32 0, i32 0
	%_2 = getelementptr [2 x i8], [2 x i8]* @_const.main.str3, i32 0, i32 0
	%_3 = getelementptr [2 x i8], [2 x i8]* @_const.main.str4, i32 0, i32 0
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	%funcCallRet_2 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %funcCallRet, i8* %, i8* %_2, i8* %_3, i32 0)
	%funcCallRet_3 = call i8* @_toString$$YGPADH$Z(i32 %funcCallRet_2)
	call void @_println$$YGXPAD$Z(i8* %funcCallRet_3)
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

