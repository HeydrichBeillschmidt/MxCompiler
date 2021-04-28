@_const._cd$$YGHHPADPADPADH$Z.str1 = private unnamed_addr constant [6 x i8] c" --> \00", align 1
@_const.main.str4 = private unnamed_addr constant [2 x i8] c"C\00", align 1
@_const._cd$$YGHHPADPADPADH$Z.str0 = private unnamed_addr constant [6 x i8] c"move \00", align 1
@_const.main.str2 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@_const.main.str3 = private unnamed_addr constant [2 x i8] c"B\00", align 1

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
	%eq_2 = icmp eq i32 %sub, 1
	br i1 %eq_2, label %if.then_2, label %if.else_2

if.then_2:
	% = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_7 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %, i8* %a)
	%_const._5 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_8 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_7, i8* %_const._5)
	%add_9 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_8, i8* %b)
	call void @_println$$YGXPAD$Z(i8* %add_9)
	%postfix_3 = add i32 %sum, 1
	br label %if.end_2

if.else_2:
	%sub_3 = sub i32 %sub, 1
	%eq_5 = icmp eq i32 %sub_3, 1
	br i1 %eq_5, label %if.then_5, label %if.else_5

if.then_5:
	%_4 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_25 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_4, i8* %a)
	%_const._14 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_26 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_25, i8* %_const._14)
	%add_27 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_26, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_27)
	%postfix_9 = add i32 %sum, 1
	br label %if.end_8

if.else_5:
	%sub_6 = sub i32 %sub_3, 1
	%eq_6 = icmp eq i32 %sub_6, 1
	br i1 %eq_6, label %if.then_6, label %if.else_6

if.then_6:
	%_5 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_28 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_5, i8* %a)
	%_const._15 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_29 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_28, i8* %_const._15)
	%add_30 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_29, i8* %b)
	call void @_println$$YGXPAD$Z(i8* %add_30)
	%postfix_10 = add i32 %sum, 1
	br label %if.end_5

if.else_6:
	%sub_7 = sub i32 %sub_6, 1
	%funcCallRet_8 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_7, i8* %a, i8* %b, i8* %c, i32 %sum)
	%_const._16 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_31 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._16, i8* %a)
	%_const._17 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_32 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_31, i8* %_const._17)
	%add_33 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_32, i8* %b)
	call void @_println$$YGXPAD$Z(i8* %add_33)
	%funcCallRet_9 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_7, i8* %c, i8* %a, i8* %b, i32 %funcCallRet_8)
	%postfix_11 = add i32 %funcCallRet_9, 1
	br label %if.end_5

if.end_5:
	%sum.addr_6 = phi i32 [ %postfix_10, %if.then_6 ], [ %postfix_11, %if.else_6 ]
	%_const._18 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_34 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._18, i8* %a)
	%_const._19 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_35 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_34, i8* %_const._19)
	%add_36 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_35, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_36)
	%eq_7 = icmp eq i32 %sub_6, 1
	br i1 %eq_7, label %if.then_7, label %if.else_7

if.then_7:
	%_6 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_37 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_6, i8* %b)
	%_const._20 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_38 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_37, i8* %_const._20)
	%add_39 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_38, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_39)
	%postfix_12 = add i32 %sum.addr_6, 1
	br label %if.end_7

if.else_7:
	%sub_8 = sub i32 %sub_6, 1
	%eq_8 = icmp eq i32 %sub_8, 1
	br i1 %eq_8, label %if.then_8, label %if.else_8

if.then_8:
	%_7 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_40 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_7, i8* %b)
	%_const._21 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_41 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_40, i8* %_const._21)
	%add_42 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_41, i8* %a)
	call void @_println$$YGXPAD$Z(i8* %add_42)
	%postfix_13 = add i32 %sum.addr_6, 1
	br label %if.end_6

if.else_8:
	%sub_9 = sub i32 %sub_8, 1
	%funcCallRet_10 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_9, i8* %b, i8* %a, i8* %c, i32 %sum.addr_6)
	%_const._22 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_43 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._22, i8* %b)
	%_const._23 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_44 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_43, i8* %_const._23)
	%add_45 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_44, i8* %a)
	call void @_println$$YGXPAD$Z(i8* %add_45)
	%funcCallRet_11 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_9, i8* %c, i8* %b, i8* %a, i32 %funcCallRet_10)
	%postfix_14 = add i32 %funcCallRet_11, 1
	br label %if.end_6

if.end_6:
	%sum.addr_7 = phi i32 [ %postfix_13, %if.then_8 ], [ %postfix_14, %if.else_8 ]
	%_const._24 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_46 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._24, i8* %b)
	%_const._25 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_47 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_46, i8* %_const._25)
	%add_48 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_47, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_48)
	%funcCallRet_12 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_8, i8* %a, i8* %b, i8* %c, i32 %sum.addr_7)
	%postfix_15 = add i32 %funcCallRet_12, 1
	br label %if.end_7

if.end_7:
	%sum.addr_8 = phi i32 [ %postfix_12, %if.then_7 ], [ %postfix_15, %if.end_6 ]
	%postfix_16 = add i32 %sum.addr_8, 1
	br label %if.end_8

if.end_8:
	%sum.addr_9 = phi i32 [ %postfix_9, %if.then_5 ], [ %postfix_16, %if.end_7 ]
	%_const._6 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_10 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._6, i8* %a)
	%_const._7 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_11 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_10, i8* %_const._7)
	%add_12 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_11, i8* %b)
	call void @_println$$YGXPAD$Z(i8* %add_12)
	%funcCallRet_4 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_3, i8* %c, i8* %a, i8* %b, i32 %sum.addr_9)
	%postfix_4 = add i32 %funcCallRet_4, 1
	br label %if.end_2

if.end_2:
	%sum.addr_3 = phi i32 [ %postfix_3, %if.then_2 ], [ %postfix_4, %if.end_8 ]
	%_const._3 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_4 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._3, i8* %a)
	%_const._4 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_5 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_4, i8* %_const._4)
	%add_6 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_5, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_6)
	%eq_3 = icmp eq i32 %sub, 1
	br i1 %eq_3, label %if.then_3, label %if.else_3

if.then_3:
	%_2 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_13 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_2, i8* %b)
	%_const._8 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_14 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_13, i8* %_const._8)
	%add_15 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_14, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_15)
	%postfix_5 = add i32 %sum.addr_3, 1
	br label %if.end_4

if.else_3:
	%sub_4 = sub i32 %sub, 1
	%eq_4 = icmp eq i32 %sub_4, 1
	br i1 %eq_4, label %if.then_4, label %if.else_4

if.then_4:
	%_3 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_16 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_3, i8* %b)
	%_const._9 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_17 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_16, i8* %_const._9)
	%add_18 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_17, i8* %a)
	call void @_println$$YGXPAD$Z(i8* %add_18)
	%postfix_6 = add i32 %sum.addr_3, 1
	br label %if.end_3

if.else_4:
	%sub_5 = sub i32 %sub_4, 1
	%funcCallRet_5 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_5, i8* %b, i8* %a, i8* %c, i32 %sum.addr_3)
	%_const._10 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_19 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._10, i8* %b)
	%_const._11 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_20 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_19, i8* %_const._11)
	%add_21 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_20, i8* %a)
	call void @_println$$YGXPAD$Z(i8* %add_21)
	%funcCallRet_6 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_5, i8* %c, i8* %b, i8* %a, i32 %funcCallRet_5)
	%postfix_7 = add i32 %funcCallRet_6, 1
	br label %if.end_3

if.end_3:
	%sum.addr_4 = phi i32 [ %postfix_6, %if.then_4 ], [ %postfix_7, %if.else_4 ]
	%_const._12 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str0, i32 0, i32 0
	%add_22 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %_const._12, i8* %b)
	%_const._13 = getelementptr [6 x i8], [6 x i8]* @_const._cd$$YGHHPADPADPADH$Z.str1, i32 0, i32 0
	%add_23 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_22, i8* %_const._13)
	%add_24 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_23, i8* %c)
	call void @_println$$YGXPAD$Z(i8* %add_24)
	%funcCallRet_7 = call i32 @_cd$$YGHHPADPADPADH$Z(i32 %sub_4, i8* %a, i8* %b, i8* %c, i32 %sum.addr_4)
	%postfix_8 = add i32 %funcCallRet_7, 1
	br label %if.end_4

if.end_4:
	%sum.addr_5 = phi i32 [ %postfix_5, %if.then_3 ], [ %postfix_8, %if.end_3 ]
	%postfix_2 = add i32 %sum.addr_5, 1
	br label %if.end

if.end:
	%sum.addr_2 = phi i32 [ %postfix, %if.then ], [ %postfix_2, %if.end_4 ]
	ret i32 %sum.addr_2
}

define i32 @main() {
entry:
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

