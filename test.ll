%class.TA = type { i8*, i32 }

@init_anger = global i32 100, align 4
@__const._work$$YGXPADUTA$$$Z.str0 = private unnamed_addr constant [3 x i8] c", \00", align 1
@__const._work$$YGXPADUTA$$$Z.str1 = private unnamed_addr constant [22 x i8] c" enjoys this work. XD\00", align 1
@__const.main.str6 = private unnamed_addr constant [5 x i8] c"Mars\00", align 1
@__const._work$$YGXPADUTA$$$Z.str2 = private unnamed_addr constant [23 x i8] c" wants to give up!!!!!\00", align 1
@__const.main.str5 = private unnamed_addr constant [3 x i8] c"MR\00", align 1
@work_anger = global i32 10, align 4
@__const.main.str4 = private unnamed_addr constant [16 x i8] c"the striking TA\00", align 1
@__const.main.str3 = private unnamed_addr constant [15 x i8] c"the leading TA\00", align 1

define void @___init__$$YGXXZ() {
entry:
	br label %return

return:
	ret void
}

define void @_work$$YGXPADUTA$$$Z(i8* %st, %class.TA* %ta) {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%st.addr = bitcast i8* %malloc to i8**
	store i8* %st, i8** %st.addr, align 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%ta.addr = bitcast i8* %malloc_2 to %class.TA**
	store %class.TA* %ta, %class.TA** %ta.addr, align 4
	%ta_2 = load %class.TA*, %class.TA** %ta.addr, align 4
	%TA.anger.addr = getelementptr %class.TA, %class.TA* %ta_2, i32 0, i32 1
	%TA.anger = load i32, i32* %TA.anger.addr, align 4
	%sle = icmp sle i32 %TA.anger, 100
	br i1 %sle, label %if.then, label %if.else

if.then:
	%st_2 = load i8*, i8** %st.addr, align 4
	%__const._work$$YGXPADUTA$$$Z.str0 = getelementptr [3 x i8], [3 x i8]* @__const._work$$YGXPADUTA$$$Z.str0, i32 0, i32 0
	%add = call i8* @_strcat$$YGPADPADPAD$Z(i8* %st_2, i8* %__const._work$$YGXPADUTA$$$Z.str0)
	%ta_3 = load %class.TA*, %class.TA** %ta.addr, align 4
	%TA.state.addr = getelementptr %class.TA, %class.TA* %ta_3, i32 0, i32 0
	%TA.state = load i8*, i8** %TA.state.addr, align 4
	%add_2 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add, i8* %TA.state)
	%__const._work$$YGXPADUTA$$$Z.str1 = getelementptr [22 x i8], [22 x i8]* @__const._work$$YGXPADUTA$$$Z.str1, i32 0, i32 0
	%add_3 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_2, i8* %__const._work$$YGXPADUTA$$$Z.str1)
	call void @_println$$YGXPAD$Z(i8* %add_3)
	br label %if.end

if.else:
	%st_3 = load i8*, i8** %st.addr, align 4
	%__const._work$$YGXPADUTA$$$Z.str2 = getelementptr [3 x i8], [3 x i8]* @__const._work$$YGXPADUTA$$$Z.str0, i32 0, i32 0
	%add_4 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %st_3, i8* %__const._work$$YGXPADUTA$$$Z.str2)
	%ta_4 = load %class.TA*, %class.TA** %ta.addr, align 4
	%TA.state.addr_2 = getelementptr %class.TA, %class.TA* %ta_4, i32 0, i32 0
	%TA.state_2 = load i8*, i8** %TA.state.addr_2, align 4
	%add_5 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_4, i8* %TA.state_2)
	%__const._work$$YGXPADUTA$$$Z.str2_2 = getelementptr [23 x i8], [23 x i8]* @__const._work$$YGXPADUTA$$$Z.str2, i32 0, i32 0
	%add_6 = call i8* @_strcat$$YGPADPADPAD$Z(i8* %add_5, i8* %__const._work$$YGXPADUTA$$$Z.str2_2)
	call void @_println$$YGXPAD$Z(i8* %add_6)
	br label %if.end

if.end:
	%ta_5 = load %class.TA*, %class.TA** %ta.addr, align 4
	%TA.anger.addr_2 = getelementptr %class.TA, %class.TA* %ta_5, i32 0, i32 1
	%TA.anger_2 = load i32, i32* %TA.anger.addr_2, align 4
	%ta_6 = load %class.TA*, %class.TA** %ta.addr, align 4
	%TA.anger.addr_3 = getelementptr %class.TA, %class.TA* %ta_6, i32 0, i32 1
	%TA.anger_3 = load i32, i32* %TA.anger.addr_3, align 4
	%work_anger = load i32, i32* @work_anger, align 4
	%add_7 = add i32 %TA.anger_3, %work_anger
	store i32 %add_7, i32* %TA.anger.addr_2, align 4
	br label %return

return:
	ret void
}

define i32 @main() {
entry:
	call void @___init__$$YGXXZ()
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%mars.addr = bitcast i8* %malloc_3 to %class.TA**
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%mr.addr = bitcast i8* %malloc_2 to %class.TA**
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 4)
	%retval = bitcast i8* %malloc to i32*
	%mr = load %class.TA*, %class.TA** %mr.addr, align 4
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr = bitcast i8* %malloc_4 to %class.TA*
	store %class.TA* %castToClassPtr, %class.TA** %mr.addr, align 4
	%mr_2 = load %class.TA*, %class.TA** %mr.addr, align 4
	%TA.state.addr = getelementptr %class.TA, %class.TA* %mr_2, i32 0, i32 0
	%TA.state = load i8*, i8** %TA.state.addr, align 4
	%__const.main.str3 = getelementptr [15 x i8], [15 x i8]* @__const.main.str3, i32 0, i32 0
	store i8* %__const.main.str3, i8** %TA.state.addr, align 4
	%mr_3 = load %class.TA*, %class.TA** %mr.addr, align 4
	%TA.anger.addr = getelementptr %class.TA, %class.TA* %mr_3, i32 0, i32 1
	%TA.anger = load i32, i32* %TA.anger.addr, align 4
	store i32 0, i32* %TA.anger.addr, align 4
	%mars = load %class.TA*, %class.TA** %mars.addr, align 4
	%malloc_5 = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr_2 = bitcast i8* %malloc_5 to %class.TA*
	store %class.TA* %castToClassPtr_2, %class.TA** %mars.addr, align 4
	%mars_2 = load %class.TA*, %class.TA** %mars.addr, align 4
	%TA.state.addr_2 = getelementptr %class.TA, %class.TA* %mars_2, i32 0, i32 0
	%TA.state_2 = load i8*, i8** %TA.state.addr_2, align 4
	%__const.main.str4 = getelementptr [16 x i8], [16 x i8]* @__const.main.str4, i32 0, i32 0
	store i8* %__const.main.str4, i8** %TA.state.addr_2, align 4
	%mars_3 = load %class.TA*, %class.TA** %mars.addr, align 4
	%TA.anger.addr_2 = getelementptr %class.TA, %class.TA* %mars_3, i32 0, i32 1
	%TA.anger_2 = load i32, i32* %TA.anger.addr_2, align 4
	%init_anger = load i32, i32* @init_anger, align 4
	store i32 %init_anger, i32* %TA.anger.addr_2, align 4
	%__const.main.str5 = getelementptr [3 x i8], [3 x i8]* @__const.main.str5, i32 0, i32 0
	%mr_4 = load %class.TA*, %class.TA** %mr.addr, align 4
	call void @_work$$YGXPADUTA$$$Z(i8* %__const.main.str5, %class.TA* %mr_4)
	%__const.main.str6 = getelementptr [5 x i8], [5 x i8]* @__const.main.str6, i32 0, i32 0
	%mars_4 = load %class.TA*, %class.TA** %mars.addr, align 4
	call void @_work$$YGXPADUTA$$$Z(i8* %__const.main.str6, %class.TA* %mars_4)
	%__const.main.str7 = getelementptr [5 x i8], [5 x i8]* @__const.main.str6, i32 0, i32 0
	%mars_5 = load %class.TA*, %class.TA** %mars.addr, align 4
	call void @_work$$YGXPADUTA$$$Z(i8* %__const.main.str7, %class.TA* %mars_5)
	store i32 0, i32* %retval, align 4
	br label %return

return:
	%returnValue = load i32, i32* %retval, align 4
	ret i32 %returnValue
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

