@n = global i32 0, align 4

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_test$$YGHXZ() {
entry:
	%n = load i32, i32* @n, align 4
	br label %for.cond

for.cond:
	%t19_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t26_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t0_10 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t32_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t43_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t10_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t38_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t21_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t33_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t6_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t7_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t14_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t22_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t48_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t13_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t15_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t41_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t37_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%k_4 = phi i32 [ 0, %entry ], [ %k_3, %if.end ]
	%t18_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t34_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t28_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t31_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t46_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t3_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t30_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t49_11 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t42_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t24_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t44_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t9_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t25_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%i_5 = phi i32 [ 0, %entry ], [ %postfix_inc, %if.end ]
	%t16_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t39_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t29_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t35_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t40_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t27_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t8_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t20_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t36_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t17_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t45_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t12_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t5_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t47_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t11_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t23_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t4_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t2_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%t1_17 = phi i32 [ 0, %entry ], [ %add, %if.end ]
	%slt = icmp slt i32 %i_5, %n
	br i1 %slt, label %for.body, label %for.end

if.then:
	br label %if.end

if.end:
	%k_3 = phi i32 [ %add, %if.then ], [ %k_4, %for.body ]
	%postfix_inc = add i32 %i_5, 1
	br label %for.cond

for.body:
	%add = add i32 %i_5, 1
	%ne = icmp ne i32 %add, 0
	br i1 %ne, label %if.then, label %if.end

for.end:
	ret i32 %k_4
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	store i32 100, i32* @n, align 4
	%funcCallRet = call i32 @_test$$YGHXZ()
	store i32 200, i32* @n, align 4
	%funcCallRet_2 = call i32 @_test$$YGHXZ()
	%add = add i32 %funcCallRet, %funcCallRet_2
	%sub = sub i32 %add, 300
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

