; ModuleID = 'code.mx'
source_filename = 'code.mx'
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.Test = type { i8*** }

@reed = dso_local global i32 zeroinitializer, align 4
@n = dso_local global i32 zeroinitializer, align 4

@__const.?printme@Test@@QEAXXZ.str0 = private unnamed_addr constant [8 x i8] c"toInt: \00", align 1
@__const.?main@@YGHXZ.str4 = private unnamed_addr constant [11 x i8] c"BY Kipsora\00", align 1
@__const.?printme@Test@@QEAXXZ.str3 = private unnamed_addr constant [1 x i8] c"\00", align 1
@__const.?printme@Test@@QEAXXZ.str1 = private unnamed_addr constant [9 x i8] c"substr: \00", align 1
@__const.?printme@Test@@QEAXXZ.str2 = private unnamed_addr constant [2 x i8] c" \00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @?rand@@YGHXZ() {
entry:
    %const.addr = alloca i32, align4
    %retval = alloca i32, align4
    %reed = load i32, i32* @reed, align 4
    %reed2 = load i32, i32* @reed, align 4
    %reed3 = load i32, i32* @reed, align 4
    %shl = shl i32 %reed3, 5
    %add = add i32 %reed2, %shl
    %add2 = add i32 %add, 1727317
    store i32 %add2, i32* @reed, align 4
    %reed4 = load i32, i32* @reed, align 4
    %srem = srem i32 %reed4, 1772371
    %slt = icmp slt i1 %srem, 1000
    br i1 %slt, label %if.then, label %if.end

if.then:
    %reed5 = load i32, i32* @reed, align 4
    %reed6 = load i32, i32* @reed, align 4
    %reed7 = load i32, i32* @reed, align 4
    %add2 = add i32 %reed7, 818277
    %xor = xor i32 %reed6, %add2
    %reed8 = load i32, i32* @reed, align 4
    %sub = sub i32 %reed8, 18217
    %bitwise_or = or i32 %xor, %sub
    store i32 %bitwise_or, i32* @reed, align 4
    br label %if.end

if.end:
    %shl2 = shl i32 1, 30
    store i32 %shl2, i32* %const.addr, align 4
    %reed9 = load i32, i32* @reed, align 4
    %const = load i32, i32* %const.addr, align 4
    %prefix_op~ = xor i32 %const, -1
    %ashr = ashr i32 %prefix_op~, 2
    %bitwise_and = and i32 %reed9, %ashr
    store i32 %bitwise_and, i32* %retval, align 4
    br label %return

return:
    ret i32 %returnValue
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @?printme@Test@@QEAXXZ(%class.Test* %this) {
entry:
    %t.addr = alloca i32, align4
    %r.addr = alloca i32, align4
    %l.addr = alloca i32, align4
    %k.addr = alloca i32, align4
    %j.addr = alloca i32, align4
    %i.addr = alloca i32, align4
    %this.addr = alloca %class.Test*, align4
    store %class.Test* %this, %class.Test** %this.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    store i32 0, i32* %i.addr, align 4
    br label %for.cond

for.cond:
    %i2 = load i32, i32* %i.addr, align 4
    %n = load i32, i32* @n, align 4
    %slt = icmp slt i1 %i2, %n
    br i1 %slt, label %for.body3, label %for.end3

for.cond2:
    %j2 = load i32, i32* %j.addr, align 4
    %i3 = load i32, i32* %i.addr, align 4
    %i4 = load i32, i32* %i.addr, align 4
    %mul = mul i32 %i3, %i4
    %sub = sub i32 %j2, %mul
    %i5 = load i32, i32* %i.addr, align 4
    %add = add i32 %i5, 3
    %slt2 = icmp slt i1 %sub, %add
    br i1 %slt2, label %for.body2, label %for.end2

if.then:
    %t = load i32, i32* %t.addr, align 4
    %l3 = load i32, i32* %l.addr, align 4
    store i32 %l3, i32* %t.addr, align 4
    %l4 = load i32, i32* %l.addr, align 4
    %r3 = load i32, i32* %r.addr, align 4
    store i32 %r3, i32* %l.addr, align 4
    %r4 = load i32, i32* %r.addr, align 4
    %t2 = load i32, i32* %t.addr, align 4
    store i32 %t2, i32* %r.addr, align 4
    br label %if.end

if.end:
    %__const.?printme@Test@@QEAXXZ.str1 = getelementptr [9 x i8], [9 x i8]* [9 x i8] c"substr: \00", i32 0, i32 0
    %this4 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr3 = getelementptr %class.Test, %class.Test* %this4, i32 0, i32 0
    %Test.array3 = load i8***, i8**** %Test.array.addr3, align 4
    %i10 = load i32, i32* %i.addr, align 4
    %elementPtr9 = getelementptr i8**, i8*** %Test.array3, i32 %i10
    %arrayElement9 = load i8**, i8*** %elementPtr9, align 4
    %j7 = load i32, i32* %j.addr, align 4
    %elementPtr10 = getelementptr i8*, i8** %arrayElement9, i32 %j7
    %arrayElement10 = load i8*, i8** %elementPtr10, align 4
    %l5 = load i32, i32* %l.addr, align 4
    %r5 = load i32, i32* %r.addr, align 4
    %funcCallRet7 = call i8* @?substring@string@@QEAPADHH@Z(i8* %arrayElement10, i32 %l5, i32 %r5)
    %add3 = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str1, i8* %funcCallRet7)
    call void @?println@@YGXPAD@Z(i8* %add3)
    %k = load i32, i32* %k.addr, align 4
    store i32 0, i32* %k.addr, align 4
    br label %for.cond3

for.cond3:
    %k2 = load i32, i32* %k.addr, align 4
    %add4 = add i32 %k2, 1
    %array3 = load i8***, i8**** %array.addr, align 4
    %i11 = load i32, i32* %i.addr, align 4
    %elementPtr11 = getelementptr i8**, i8*** %array3, i32 %i11
    %arrayElement11 = load i8**, i8*** %elementPtr11, align 4
    %j8 = load i32, i32* %j.addr, align 4
    %elementPtr12 = getelementptr i8*, i8** %arrayElement11, i32 %j8
    %arrayElement12 = load i8*, i8** %elementPtr12, align 4
    %funcCallRet8 = call i32 @?length@string@@QEAHXZ(i8* %arrayElement12)
    %add5 = add i32 %funcCallRet8, 1
    %slt3 = icmp slt i1 %add4, %add5
    br i1 %slt3, label %for.body, label %for.end

for.body:
    %array4 = load i8***, i8**** %array.addr, align 4
    %i12 = load i32, i32* %i.addr, align 4
    %elementPtr13 = getelementptr i8**, i8*** %array4, i32 %i12
    %arrayElement13 = load i8**, i8*** %elementPtr13, align 4
    %j9 = load i32, i32* %j.addr, align 4
    %elementPtr14 = getelementptr i8*, i8** %arrayElement13, i32 %j9
    %arrayElement14 = load i8*, i8** %elementPtr14, align 4
    %k3 = load i32, i32* %k.addr, align 4
    %funcCallRet10 = call i32 @?ord@string@@QEAHH@Z(i8* %arrayElement14, i32 %k3)
    %funcCallRet9 = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet10)
    %__const.?printme@Test@@QEAXXZ.str2 = getelementptr [2 x i8], [2 x i8]* [2 x i8] c" \00", i32 0, i32 0
    %add6 = call i8* @?strcat@@YGPADPADPAD@Z(i8* %funcCallRet9, i8* %__const.?printme@Test@@QEAXXZ.str2)
    call void @?print@@YGXPAD@Z(i8* %add6)
    br label %for.inc

for.inc:
    %k4 = load i32, i32* %k.addr, align 4
    %k5 = load i32, i32* %k.addr, align 4
    %add7 = add i32 %k5, 2
    store i32 %add7, i32* %k.addr, align 4
    br label %for.cond3

for.end:
    %__const.?printme@Test@@QEAXXZ.str3 = getelementptr [1 x i8], [1 x i8]* [1 x i8] c"\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str3)
    br label %for.inc2

for.body2:
    %this2 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this2, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %i6 = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i6
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j3 = load i32, i32* %j.addr, align 4
    %elementPtr2 = getelementptr i8*, i8** %arrayElement, i32 %j3
    %arrayElement2 = load i8*, i8** %elementPtr2, align 4
    call void @?println@@YGXPAD@Z(i8* %arrayElement2)
    %__const.?printme@Test@@QEAXXZ.str0 = getelementptr [8 x i8], [8 x i8]* [8 x i8] c"toInt: \00", i32 0, i32 0
    %this3 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr2 = getelementptr %class.Test, %class.Test* %this3, i32 0, i32 0
    %Test.array2 = load i8***, i8**** %Test.array.addr2, align 4
    %i7 = load i32, i32* %i.addr, align 4
    %elementPtr3 = getelementptr i8**, i8*** %Test.array2, i32 %i7
    %arrayElement3 = load i8**, i8*** %elementPtr3, align 4
    %j4 = load i32, i32* %j.addr, align 4
    %elementPtr4 = getelementptr i8*, i8** %arrayElement3, i32 %j4
    %arrayElement4 = load i8*, i8** %elementPtr4, align 4
    %funcCallRet2 = call i32 @?parseInt@string@@QEAHXZ(i8* %arrayElement4)
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet2)
    %add2 = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str0, i8* %funcCallRet)
    call void @?println@@YGXPAD@Z(i8* %add2)
    %l = load i32, i32* %l.addr, align 4
    %funcCallRet3 = call i32 @?rand@@YGHXZ()
    %array = load i8***, i8**** %array.addr, align 4
    %i8 = load i32, i32* %i.addr, align 4
    %elementPtr5 = getelementptr i8**, i8*** %array, i32 %i8
    %arrayElement5 = load i8**, i8*** %elementPtr5, align 4
    %j5 = load i32, i32* %j.addr, align 4
    %elementPtr6 = getelementptr i8*, i8** %arrayElement5, i32 %j5
    %arrayElement6 = load i8*, i8** %elementPtr6, align 4
    %funcCallRet4 = call i32 @?length@string@@QEAHXZ(i8* %arrayElement6)
    %srem = srem i32 %funcCallRet3, %funcCallRet4
    store i32 %srem, i32* %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    %funcCallRet5 = call i32 @?rand@@YGHXZ()
    %array2 = load i8***, i8**** %array.addr, align 4
    %i9 = load i32, i32* %i.addr, align 4
    %elementPtr7 = getelementptr i8**, i8*** %array2, i32 %i9
    %arrayElement7 = load i8**, i8*** %elementPtr7, align 4
    %j6 = load i32, i32* %j.addr, align 4
    %elementPtr8 = getelementptr i8*, i8** %arrayElement7, i32 %j6
    %arrayElement8 = load i8*, i8** %elementPtr8, align 4
    %funcCallRet6 = call i32 @?length@string@@QEAHXZ(i8* %arrayElement8)
    %srem2 = srem i32 %funcCallRet5, %funcCallRet6
    store i32 %srem2, i32* %r.addr, align 4
    %l2 = load i32, i32* %l.addr, align 4
    %r2 = load i32, i32* %r.addr, align 4
    %sgt = icmp sgt i1 %l2, %r2
    br i1 %sgt, label %if.then, label %if.end

for.inc2:
    %j10 = load i32, i32* %j.addr, align 4
    %postfix_op++ = add i32 %j10, 1
    store i32 %postfix_op++, i32* %j.addr, align 4
    br label %for.cond2

for.end2:
    br label %for.inc3

for.body3:
    %j = load i32, i32* %j.addr, align 4
    store i32 0, i32* %j.addr, align 4
    br label %for.cond2

for.inc3:
    %i13 = load i32, i32* %i.addr, align 4
    %postfix_op++2 = add i32 %i13, 1
    store i32 %postfix_op++2, i32* %i.addr, align 4
    br label %for.cond

for.end3:
    br label %return

return:
    ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local  @??0Test@@QEAXZ(%class.Test* %this) {
entry:
    %s.addr = alloca i32, align4
    %sum.addr = alloca i32, align4
    %j.addr = alloca i32, align4
    %i.addr = alloca i32, align4
    %this.addr = alloca %class.Test*, align4
    store %class.Test* %this, %class.Test** %this.addr, align 4
    %this2 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this2, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %n = load i32, i32* @n, align 4
    %sizeTmp = mul i32 %n, 32
    %size = add i32 %sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 %n, i32* %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    store i8*** %arrayHeadPtr, i8**** %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    store i32 0, i32* %i.addr, align 4
    br label %for.cond

for.cond:
    %i2 = load i32, i32* %i.addr, align 4
    %n2 = load i32, i32* @n, align 4
    %slt = icmp slt i1 %i2, %n2
    br i1 %slt, label %for.body2, label %for.end2

for.cond2:
    %j3 = load i32, i32* %j.addr, align 4
    %i6 = load i32, i32* %i.addr, align 4
    %i7 = load i32, i32* %i.addr, align 4
    %i8 = load i32, i32* %i.addr, align 4
    %mul2 = mul i32 %i7, %i8
    %add2 = add i32 %i6, %mul2
    %add22 = add i32 %add2, 2
    %bitwise_or2 = or i32 %add22, 13
    %slt2 = icmp slt i1 %j3, %bitwise_or2
    br i1 %slt2, label %for.body, label %for.end

for.body:
    %this4 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr3 = getelementptr %class.Test, %class.Test* %this4, i32 0, i32 0
    %Test.array3 = load i8***, i8**** %Test.array.addr3, align 4
    %i9 = load i32, i32* %i.addr, align 4
    %elementPtr2 = getelementptr i8**, i8*** %Test.array3, i32 %i9
    %arrayElement2 = load i8**, i8*** %elementPtr2, align 4
    %j4 = load i32, i32* %j.addr, align 4
    %elementPtr3 = getelementptr i8*, i8** %arrayElement2, i32 %j4
    %arrayElement3 = load i8*, i8** %elementPtr3, align 4
    %funcCallRet2 = call i32 @?rand@@YGHXZ()
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet2)
    store i8* %funcCallRet, i8** %elementPtr3, align 4
    br label %for.inc

for.inc:
    %j5 = load i32, i32* %j.addr, align 4
    %postfix_op++ = add i32 %j5, 1
    store i32 %postfix_op++, i32* %j.addr, align 4
    br label %for.cond2

for.end:
    br label %for.inc2

for.body2:
    %sum = load i32, i32* %sum.addr, align 4
    store i32 0, i32* %sum.addr, align 4
    %this3 = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr2 = getelementptr %class.Test, %class.Test* %this3, i32 0, i32 0
    %Test.array2 = load i8***, i8**** %Test.array.addr2, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array2, i32 %j
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %i3 = load i32, i32* %i.addr, align 4
    %i4 = load i32, i32* %i.addr, align 4
    %i5 = load i32, i32* %i.addr, align 4
    %mul = mul i32 %i4, %i5
    %add = add i32 %i3, %mul
    %add2 = add i32 %add, 3
    %bitwise_or = or i32 %add2, 13
    %sizeTmp2 = mul i32 %bitwise_or, 32
    %size2 = add i32 %sizeTmp2, 4
    %malloc2 = call i8* @?malloc@@YGPADH@Z(i32 %size2)
    %mallocInt32Ptr2 = bitcast i8* %malloc2 to i32*
    store i32 %bitwise_or, i32* %mallocInt32Ptr2, align 4
    %arrayHeadPtrUnguarded2 = getelementptr i32, i32* %mallocInt32Ptr2, i32 1
    %arrayHeadPtr2 = bitcast i32* %arrayHeadPtrUnguarded2 to i8**
    store i8** %arrayHeadPtr2, i8*** %elementPtr, align 4
    store i32 0, i32* %s.addr, align 4
    %j2 = load i32, i32* %j.addr, align 4
    store i32 0, i32* %j.addr, align 4
    br label %for.cond2

for.inc2:
    %i10 = load i32, i32* %i.addr, align 4
    %postfix_op++2 = add i32 %i10, 1
    store i32 %postfix_op++2, i32* %i.addr, align 4
    br label %for.cond

for.end2:
    br label %return

return:
    ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__init__() {
entry:
    %array.addr = alloca i8***, align4
    store i32 12883127, i32* @reed, align 4
    br label %return

return:
    ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @?main@@YGHXZ() {
entry:
    call void @__init__()
    %a.addr5 = alloca i32, align4
    %a.addr4 = alloca i32, align4
    %a.addr3 = alloca i32, align4
    %a.addr2 = alloca i32, align4
    %ptrIntoArray = alloca i8***, align4
    %a.addr = alloca %class.Test*, align4
    %retval = alloca i32, align4
    %n = load i32, i32* @n, align 4
    %funcCallRet = call i32 @?getInt@@YGHXZ()
    store i32 %funcCallRet, i32* @n, align 4
    %__const.?main@@YGHXZ.str4 = getelementptr [11 x i8], [11 x i8]* [11 x i8] c"BY Kipsora\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?main@@YGHXZ.str4)
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 0)
    %castToClassPtr = bitcast i8* %malloc to %class.Test*
    call  @??0Test@@QEAXZ(%class.Test* %castToClassPtr)
    store %class.Test* %castToClassPtr, %class.Test** %a.addr, align 4
    %a = load %class.Test*, %class.Test** %a.addr, align 4
    call void @?printme@Test@@QEAXXZ(%class.Test* %a)
    %a2 = load %class.Test*, %class.Test** %a.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %a2, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %sizeTmp = mul i32 3, 32
    %size = add i32 %sizeTmp, 4
    %malloc2 = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc2 to i32*
    store i32 3, i32* %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    %arrayTailPtr = getelementptr i8**, i8*** %arrayHeadPtr, i32 3
    store i8*** %arrayHeadPtr, i8**** %ptrIntoArray, align 4
    br label %arrMallocIteCond

arrMallocIteCond:
    %arrayPtrIte = load i8***, i8**** %ptrIntoArray, align 4
    %iteCmpTmp = icmp slt i1 %arrayPtrIte, %arrayTailPtr
    br i1 %iteCmpTmp, label %arrMallocIteBody, label %arrMallocIteEnd

arrMallocIteBody:
    %sizeTmp2 = mul i32 3, 32
    %size2 = add i32 %sizeTmp2, 4
    %malloc3 = call i8* @?malloc@@YGPADH@Z(i32 %size2)
    %mallocInt32Ptr2 = bitcast i8* %malloc3 to i32*
    store i32 3, i32* %mallocInt32Ptr2, align 4
    %arrayHeadPtrUnguarded2 = getelementptr i32, i32* %mallocInt32Ptr2, i32 1
    %arrayHeadPtr2 = bitcast i32* %arrayHeadPtrUnguarded2 to i8**
    store i8** %arrayHeadPtr2, i8*** %arrayPtrIte, align 4
    %nextElemPtr = getelementptr i8**, i8*** %arrayPtrIte, i32 1
    store i8*** %nextElemPtr, i8**** %ptrIntoArray, align 4
    br label %arrMallocIteCond

arrMallocIteEnd:
    store i8*** %arrayHeadPtr, i8**** %Test.array.addr, align 4
    br i1 1, label %if.then, label %if.else

if.then:
    br label %if.end

if.else:
    br label %if.end

if.end:
    br label %for.body

for.body:
    br label %for.body

for.end:
    br label %while.cond

while.cond:
    br i1 1, label %while.body, label %while.end

while.body:
    br label %while.cond

while.end:
    br label %return

return:
    ret i32 %returnValue
}

declare dso_local i1 @?strcmp_ge@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i32 @?parseInt@string@@QEAHXZ(i8* %str)

declare dso_local i1 @?strcmp_le@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i8* @?substring@string@@QEAPADHH@Z(i8* %str, i32 %left, i32 %right)

declare dso_local i8* @?malloc@@YGPADH@Z(i32 %size)

declare dso_local void @?println@@YGXPAD@Z(i8* %str)

declare dso_local i1 @?strcmp_eq@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i32 @?length@string@@QEAHXZ(i8* %str)

declare dso_local i32 @?ord@string@@QEAHH@Z(i8* %str, i32 %pos)

declare dso_local void @?printInt@@YGXH@Z(i32 %n)

declare dso_local i1 @?strcmp_gt@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i32 @?getInt@@YGHXZ()

declare dso_local void @?print@@YGXPAD@Z(i8* %str)

declare dso_local void @?printlnInt@@YGXH@Z(i32 %n)

declare dso_local i1 @?strcmp_neq@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i8* @?getString@@YGPADXZ()

declare dso_local i32 @?size@array@@QEAHXZ(i8* %arr)

declare dso_local i8* @?strcat@@YGPADPADPAD@Z(i8* %str1, i8* %str2)

declare dso_local i8* @?toString@@YGPADH@Z(i32 %i)

declare dso_local i1 @?strcmp_lt@@YG_NPADPAD@Z(i8* %str1, i8* %str2)

