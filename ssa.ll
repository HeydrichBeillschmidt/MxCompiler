@w = global i32 0, align 4
@N = global i32 1, align 4

define i32 @_bblock$$YGHXZ() {
entry:
	%funcCallRet = call i32 @_wpppp$$YGHXZ()
	%funcCallRet_2 = call i32 @_wpppp$$YGHXZ()
	%funcCallRet_3 = call i32 @_bblock$$YGHXZ()
	%funcCallRet_4 = call i32 @_bblock$$YGHXZ()
	ret i32 %funcCallRet_4
}

define i32 @_wpp$$YGHXZ() {
entry:
	%w = load i32, i32* @w, align 4
	%postfix_inc = add i32 %w, 1
	store i32 %postfix_inc, i32* @w, align 4
	%w_2 = load i32, i32* @w, align 4
	%prefix_inc = add i32 %w_2, 1
	store i32 %prefix_inc, i32* @w, align 4
	ret i32 %prefix_inc
}

define i32 @_add128$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add64$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add64$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add262144$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add131072$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add131072$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add1$$YGHH$Z(i32 %x) {
entry:
	%add = add i32 %x, 1
	ret i32 %add
}

define i32 @_add2$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add1$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add1$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_sanity_check$$YGHXZ() {
entry:
	%funcCallRet = call i32 @_wP$$YGHXZ()
	%add = add i32 %funcCallRet, 1
	ret i32 %add
}

define i32 @_add4$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add2$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add2$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add8192$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add4096$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add4096$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add32768$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add16384$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add16384$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_wP$$YGHXZ() {
entry:
	br label %for.body_2

for.cond:
	%j_6 = phi i32 [ 2, %for.body_2 ], [ %postfix_inc_2, %if.end ]
	%slt = icmp slt i32 %j_6, %ashr
	br i1 %slt, label %for.body, label %for.end

if.then:
	%postfix_inc = add i32 %i_10, 1
	br label %for.end

if.end:
	%postfix_inc_2 = add i32 %j_6, 1
	br label %for.cond

for.body:
	%srem = srem i32 %i_10, %j_6
	%eq = icmp eq i32 %srem, 0
	br i1 %eq, label %if.then, label %if.end

for.end:
	%i_11 = phi i32 [ %postfix_inc, %if.then ], [ %i_10, %for.cond ]
	%isp_6 = phi i32 [ 0, %if.then ], [ 1, %for.cond ]
	%sgt = icmp sgt i32 %i_11, 0
	br i1 %sgt, label %logical_and_branch, label %logical_and_end

logical_and_branch:
	%add = add i32 %i_11, %isp_6
	%srem_2 = srem i32 %add, 9
	%eq_2 = icmp eq i32 %srem_2, 0
	br label %logical_and_end

logical_and_end:
	%logicalAnd = phi i1 [ 0, %for.end ], [ %eq_2, %logical_and_branch ]
	br i1 %logicalAnd, label %if.then_2, label %if.end_2

if.then_2:
	%N_3 = load i32, i32* @N, align 4
	%funcCallRet = call i32 @_wpppp$$YGHXZ()
	%add_4 = add i32 %N_3, %funcCallRet
	%srem_3 = srem i32 %add_4, 2
	%eq_3 = icmp eq i32 %srem_3, 0
	br i1 %eq_3, label %if.then_3, label %if.end_3

if.end_2:
	%N_2 = load i32, i32* @N, align 4
	%add_2 = add i32 %N_2, %isp_6
	store i32 %add_2, i32* @N, align 4
	%add_3 = add i32 %i_11, %isp_6
	%postfix_inc_3 = add i32 %add_3, 1
	br label %for.body_2

for.body_2:
	%j_5 = phi i32 [ 0, %entry ], [ %j_6, %if.end_2 ]
	%ii_3 = phi i32 [ 0, %entry ], [ %ashr, %if.end_2 ]
	%i_10 = phi i32 [ 3, %entry ], [ %postfix_inc_3, %if.end_2 ]
	%isp_7 = phi i32 [ 0, %entry ], [ %isp_6, %if.end_2 ]
	%ashr = ashr i32 %i_10, 1
	br label %for.cond

if.then_3:
	%N_4 = load i32, i32* @N, align 4
	%funcCallRet_2 = call i32 @_add524288$$YGHH$Z(i32 %N_4)
	%sub = sub i32 %funcCallRet_2, 524288
	%sub_2 = sub i32 %sub, 4
	br label %return

if.end_3:
	%funcCallRet_3 = call i32 @_block$$YGHXZ()
	%funcCallRet_4 = call i32 @_block$$YGHXZ()
	%funcCallRet_5 = call i32 @_block$$YGHXZ()
	%funcCallRet_6 = call i32 @_block$$YGHXZ()
	%funcCallRet_7 = call i32 @_bblock$$YGHXZ()
	br label %return

return:
	%retval_2 = phi i32 [ %sub_2, %if.then_3 ], [ %funcCallRet_7, %if.end_3 ]
	ret i32 %retval_2
}

define i32 @_add64$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add32$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add32$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_wppp$$YGHXZ() {
entry:
	%funcCallRet = call i32 @_wpp$$YGHXZ()
	%funcCallRet_2 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_3 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_4 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_5 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_6 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_7 = call i32 @_wpp$$YGHXZ()
	%funcCallRet_8 = call i32 @_wpp$$YGHXZ()
	ret i32 %funcCallRet_8
}

define i32 @_add16384$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add8192$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add8192$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add32$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add16$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add16$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_wpppp$$YGHXZ() {
entry:
	%funcCallRet = call i32 @_wppp$$YGHXZ()
	%funcCallRet_2 = call i32 @_wppp$$YGHXZ()
	%funcCallRet_3 = call i32 @_wppp$$YGHXZ()
	%funcCallRet_4 = call i32 @_wppp$$YGHXZ()
	%funcCallRet_5 = call i32 @_wppp$$YGHXZ()
	%funcCallRet_6 = call i32 @_wppp$$YGHXZ()
	%funcCallRet_7 = call i32 @_wppp$$YGHXZ()
	ret i32 %funcCallRet_7
}

define i32 @_add2048$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add1024$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add1024$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add16$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add8$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add8$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add1024$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add512$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add512$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%funcCallRet = call i32 @_sanity_check$$YGHXZ()
	%sub = sub i32 %funcCallRet, 3
	ret i32 %sub
}

define i32 @_block$$YGHXZ() {
entry:
	%funcCallRet = call i32 @_block$$YGHXZ()
	ret i32 %funcCallRet
}

define i32 @_add524288$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add262144$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add262144$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_add65536$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add32768$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add32768$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add4096$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add2048$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add2048$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add512$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add256$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add256$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add8$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add4$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add4$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add131072$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add65536$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add65536$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
}

define i32 @_add256$$YGHH$Z(i32 %x) {
entry:
	%funcCallRet_2 = call i32 @_add128$$YGHH$Z(i32 %x)
	%funcCallRet = call i32 @_add128$$YGHH$Z(i32 %funcCallRet_2)
	ret i32 %funcCallRet
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

