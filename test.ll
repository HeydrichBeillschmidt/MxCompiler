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
    %reed = load i32, i32* @reed, align 4
    %reed = load i32, i32* @reed, align 4
    %shl = shl i32 %reed, 5
    %add = add i32 %reed, %shl
    %add2 = add i32 %add, 1727317
    store i32 %add2 i32*, @reed, align 4
    %reed = load i32, i32* @reed, align 4
    %srem = srem i32 %reed, 1772371
    %slt = icmp slt i1 %srem, 1000
    br i1 %slt, label %if.then, label %if.end

if.then:
    %reed = load i32, i32* @reed, align 4
    %reed = load i32, i32* @reed, align 4
    %reed = load i32, i32* @reed, align 4
    %add = add i32 %reed, 818277
    %xor = xor i32 %reed, %add
    %reed = load i32, i32* @reed, align 4
    %sub = sub i32 %reed, 18217
    %bitwise_or = or i32 %xor, %sub
    store i32 %bitwise_or i32*, @reed, align 4
    br label %if.end

if.end:
    %shl = shl i32 1, 30
    store i32 %shl i32*, %const.addr, align 4
    %reed = load i32, i32* @reed, align 4
    %const = load i32, i32* %const.addr, align 4
    %prefix_op~ = xor i32 %const, -1
    %ashr = ashr i32 %prefix_op~, 2
    %bitwise_and = and i32 %reed, %ashr
    store i32 %bitwise_and i32*, %retval, align 4
    br label %return
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
    store %class.Test* %this %class.Test**, %this.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    store i32 0 i32*, %i.addr, align 4
    br label %for.cond

for.cond:
    %i = load i32, i32* %i.addr, align 4
    %n = load i32, i32* @n, align 4
    %slt = icmp slt i1 %i, %n
    br i1 %slt, label %for.body, label %for.end

for.cond:
    %j = load i32, i32* %j.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %mul = mul i32 %i, %i
    %sub = sub i32 %j, %mul
    %i = load i32, i32* %i.addr, align 4
    %add = add i32 %i, 3
    %slt = icmp slt i1 %sub, %add
    br i1 %slt, label %for.body, label %for.end

if.then:
    %t = load i32, i32* %t.addr, align 4
    %l = load i32, i32* %l.addr, align 4
    store i32 %l i32*, %t.addr, align 4
    %l = load i32, i32* %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    store i32 %r i32*, %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    %t = load i32, i32* %t.addr, align 4
    store i32 %t i32*, %r.addr, align 4
    br label %if.end

if.end:
    %__const.?printme@Test@@QEAXXZ.str1 = getelementptr [9 x i8], [9 x i8]* [9 x i8] c"substr: \00", i32 0, i32 0
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %l = load i32, i32* %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    %funcCallRet = call i8* @?substring@string@@QEAPADHH@Z(i8* %arrayElement, i32 %l, i32 %r)
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str1, i8* %funcCallRet)
    call void @?println@@YGXPAD@Z(i8* %add)
    %k = load i32, i32* %k.addr, align 4
    store i32 0 i32*, %k.addr, align 4
    br label %for.cond

for.cond:
    %k = load i32, i32* %k.addr, align 4
    %add = add i32 %k, 1
    %array = load i8***, i8**** %array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %add = add i32 %funcCallRet, 1
    %slt = icmp slt i1 %add, %add
    br i1 %slt, label %for.body, label %for.end

for.body:
    %array = load i8***, i8**** %array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %k = load i32, i32* %k.addr, align 4
    %funcCallRet = call i32 @?ord@string@@QEAHH@Z(i8* %arrayElement, i32 %k)
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    %__const.?printme@Test@@QEAXXZ.str2 = getelementptr [2 x i8], [2 x i8]* [2 x i8] c" \00", i32 0, i32 0
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %funcCallRet, i8* %__const.?printme@Test@@QEAXXZ.str2)
    call void @?print@@YGXPAD@Z(i8* %add)
    br label %for.inc

for.inc:
    %k = load i32, i32* %k.addr, align 4
    %k = load i32, i32* %k.addr, align 4
    %add = add i32 %k, 2
    store i32 %add i32*, %k.addr, align 4
    br label %for.cond

for.end:
    %__const.?printme@Test@@QEAXXZ.str3 = getelementptr [1 x i8], [1 x i8]* [1 x i8] c"\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str3)
    br label %for.inc

for.body:
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    call void @?println@@YGXPAD@Z(i8* %arrayElement)
    %__const.?printme@Test@@QEAXXZ.str0 = getelementptr [8 x i8], [8 x i8]* [8 x i8] c"toInt: \00", i32 0, i32 0
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %funcCallRet = call i32 @?parseInt@string@@QEAHXZ(i8* %arrayElement)
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str0, i8* %funcCallRet)
    call void @?println@@YGXPAD@Z(i8* %add)
    %l = load i32, i32* %l.addr, align 4
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %array = load i8***, i8**** %array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %srem = srem i32 %funcCallRet, %funcCallRet
    store i32 %srem i32*, %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %array = load i8***, i8**** %array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %srem = srem i32 %funcCallRet, %funcCallRet
    store i32 %srem i32*, %r.addr, align 4
    %l = load i32, i32* %l.addr, align 4
    %r = load i32, i32* %r.addr, align 4
    %sgt = icmp sgt i1 %l, %r
    br i1 %sgt, label %if.then, label %if.end

for.inc:
    %j = load i32, i32* %j.addr, align 4
    %postfix_op++ = add i32 %j, 1
    store i32 %postfix_op++ i32*, %j.addr, align 4
    br label %for.cond

for.end:
    br label %for.inc

for.body:
    %j = load i32, i32* %j.addr, align 4
    store i32 0 i32*, %j.addr, align 4
    br label %for.cond

for.inc:
    %i = load i32, i32* %i.addr, align 4
    %postfix_op++ = add i32 %i, 1
    store i32 %postfix_op++ i32*, %i.addr, align 4
    br label %for.cond

for.end:
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
    store %class.Test* %this %class.Test**, %this.addr, align 4
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %n = load i32, i32* @n, align 4
    %sizeTmp = mul i32 %n, 32
    %size = add i32 %sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 %n i32*, %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    store i8*** %arrayHeadPtr i8****, %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    store i32 0 i32*, %i.addr, align 4
    br label %for.cond

for.cond:
    %i = load i32, i32* %i.addr, align 4
    %n = load i32, i32* @n, align 4
    %slt = icmp slt i1 %i, %n
    br i1 %slt, label %for.body, label %for.end

for.cond:
    %j = load i32, i32* %j.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %mul = mul i32 %i, %i
    %add = add i32 %i, %mul
    %add2 = add i32 %add, 2
    %bitwise_or = or i32 %add2, 13
    %slt = icmp slt i1 %j, %bitwise_or
    br i1 %slt, label %for.body, label %for.end

for.body:
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr, align 4
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    store i8* %funcCallRet i8**, %elementPtr, align 4
    br label %for.inc

for.inc:
    %j = load i32, i32* %j.addr, align 4
    %postfix_op++ = add i32 %j, 1
    store i32 %postfix_op++ i32*, %j.addr, align 4
    br label %for.cond

for.end:
    br label %for.inc

for.body:
    %sum = load i32, i32* %sum.addr, align 4
    store i32 0 i32*, %sum.addr, align 4
    %this = load %class.Test*, %class.Test** %this.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %j = load i32, i32* %j.addr, align 4
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %j
    %arrayElement = load i8**, i8*** %elementPtr, align 4
    %i = load i32, i32* %i.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %i = load i32, i32* %i.addr, align 4
    %mul = mul i32 %i, %i
    %add = add i32 %i, %mul
    %add2 = add i32 %add, 3
    %bitwise_or = or i32 %add2, 13
    %sizeTmp = mul i32 %bitwise_or, 32
    %size = add i32 %sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 %bitwise_or i32*, %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8**
    store i8** %arrayHeadPtr i8***, %elementPtr, align 4
    store i32 0 i32*, %s.addr, align 4
    %j = load i32, i32* %j.addr, align 4
    store i32 0 i32*, %j.addr, align 4
    br label %for.cond

for.inc:
    %i = load i32, i32* %i.addr, align 4
    %postfix_op++ = add i32 %i, 1
    store i32 %postfix_op++ i32*, %i.addr, align 4
    br label %for.cond

for.end:
    br label %return

return:
    ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @__init__() {
entry:
    %array.addr = alloca i8***, align4
    store i32 12883127 i32*, @reed, align 4
    br label %return

return:
    ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @?main@@YGHXZ() {
entry:
    call void @__init__()
    %a.addr = alloca i32, align4
    %a.addr = alloca i32, align4
    %a.addr = alloca i32, align4
    %a.addr = alloca i32, align4
    %ptrIntoArray = alloca i8***, align4
    %a.addr = alloca %class.Test*, align4
    %retval = alloca i32, align4
    %n = load i32, i32* @n, align 4
    %funcCallRet = call i32 @?getInt@@YGHXZ()
    store i32 %funcCallRet i32*, @n, align 4
    %__const.?main@@YGHXZ.str4 = getelementptr [11 x i8], [11 x i8]* [11 x i8] c"BY Kipsora\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?main@@YGHXZ.str4)
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 0)
    %castToClassPtr = bitcast i8* %malloc to %class.Test*
    call  @??0Test@@QEAXZ(%class.Test* %castToClassPtr)
    store %class.Test* %castToClassPtr %class.Test**, %a.addr, align 4
    %a = load %class.Test*, %class.Test** %a.addr, align 4
    call void @?printme@Test@@QEAXXZ(%class.Test* %a)
    %a = load %class.Test*, %class.Test** %a.addr, align 4
    %Test.array.addr = getelementptr %class.Test, %class.Test* %a, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr, align 4
    %sizeTmp = mul i32 3, 32
    %size = add i32 %sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 3 i32*, %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    %arrayTailPtr = getelementptr i8**, i8*** %arrayHeadPtr, i32 3
    store i8*** %arrayHeadPtr i8****, %ptrIntoArray, align 4
    br label %arrMallocIteCond

arrMallocIteCond:
    %arrayPtrIte = load i8***, i8**** %ptrIntoArray, align 4
    %iteCmpTmp = icmp slt i1 %arrayPtrIte, %arrayTailPtr
    br i1 %iteCmpTmp, label %arrMallocIteBody, label %arrMallocIteEnd

arrMallocIteBody:
    %sizeTmp = mul i32 3, 32
    %size = add i32 %sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 3 i32*, %mallocInt32Ptr, align 4
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8**
    store i8** %arrayHeadPtr i8***, %arrayPtrIte, align 4
    %nextElemPtr = getelementptr i8**, i8*** %arrayPtrIte, i32 1
    store i8*** %nextElemPtr i8****, %ptrIntoArray, align 4
    br label %arrMallocIteCond

arrMallocIteEnd:
    store i8*** %arrayHeadPtr i8****, %Test.array.addr, align 4
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

