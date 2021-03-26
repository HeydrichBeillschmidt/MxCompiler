; ModuleID = 'code.mx'
source_filename = 'code.mx'
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.Test = type { i8*** }

@reed = global i32 zeroinitializer, align 0
@n = global i32 zeroinitializer, align 0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @?rand@@YGHXZ() {
entry:
    %const.addr = alloca i32
    %retval = alloca i32
    %reed = load i32, i32* @reed
    %reed = load i32, i32* @reed
    %reed = load i32, i32* @reed
    %shl = shli32%reed, 5
    %add = addi32%reed, %shl
    %add2 = addi32%add, 1727317
    store i32 %add2, i32*, @reed
    %reed = load i32, i32* @reed
    %srem = sremi32%reed, 1772371
    %slt = icmp slti1%srem, 1000
    br i1 %slt, label %if.then, label %if.end

if.then:
    %reed = load i32, i32* @reed
    %reed = load i32, i32* @reed
    %reed = load i32, i32* @reed
    %add = addi32%reed, 818277
    %xor = xori32%reed, %add
    %reed = load i32, i32* @reed
    %sub = subi32%reed, 18217
    %bitwise_or = ori32%xor, %sub
    store i32 %bitwise_or, i32*, @reed
    br label %if.end

if.end:
    %shl = shli321, 30
    store i32 %shl, i32*, %const.addr
    %reed = load i32, i32* @reed
    %const = load i32, i32* %const.addr
    %prefix_op~ = xori32%const, -1
    %ashr = ashri32%prefix_op~, 2
    %bitwise_and = andi32%reed, %ashr
    store i32 %bitwise_and, i32*, %retval
    br label %return
    br label %return

return:
    ret i32 %returnValue
}
define dso_local void @?printme@Test@@QEAXXZ(%class.Test* %this) {
entry:
    %t.addr = alloca i32
    %r.addr = alloca i32
    %l.addr = alloca i32
    %k.addr = alloca i32
    %j.addr = alloca i32
    %i.addr = alloca i32
    %this.addr = alloca %class.Test*
    store %class.Test* %this, %class.Test**, %this.addr
    %i = load i32, i32* %i.addr
    store i32 0, i32*, %i.addr
    br label %for.cond

for.cond:
    %i = load i32, i32* %i.addr
    %n = load i32, i32* @n
    %slt = icmp slti1%i, %n
    br i1 %slt, label %for.body, label %for.end

for.cond:
    %j = load i32, i32* %j.addr
    %i = load i32, i32* %i.addr
    %i = load i32, i32* %i.addr
    %mul = muli32%i, %i
    %sub = subi32%j, %mul
    %i = load i32, i32* %i.addr
    %add = addi32%i, 3
    %slt = icmp slti1%sub, %add
    br i1 %slt, label %for.body, label %for.end

if.then:
    %t = load i32, i32* %t.addr
    %l = load i32, i32* %l.addr
    store i32 %l, i32*, %t.addr
    %l = load i32, i32* %l.addr
    %r = load i32, i32* %r.addr
    store i32 %r, i32*, %l.addr
    %r = load i32, i32* %r.addr
    %t = load i32, i32* %t.addr
    store i32 %t, i32*, %r.addr
    br label %if.end

if.end:
    %__const.?printme@Test@@QEAXXZ.str1 = getelementptr [9 x i8], [9 x i8]* "substr: \00", i32 0, i32 0
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %l = load i32, i32* %l.addr
    %r = load i32, i32* %r.addr
    %funcCallRet = call i8* @?substring@string@@QEAPADHH@Z(i8* %arrayElement, i32 %l, i32 %r)
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str1, i8* %funcCallRet)
    call void @?println@@YGXPAD@Z(i8* %add)
    %k = load i32, i32* %k.addr
    store i32 0, i32*, %k.addr
    br label %for.cond

for.cond:
    %k = load i32, i32* %k.addr
    %add = addi32%k, 1
    %array = load i8***, i8**** %array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %add = addi32%funcCallRet, 1
    %slt = icmp slti1%add, %add
    br i1 %slt, label %for.body, label %for.end

for.body:
    %array = load i8***, i8**** %array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %k = load i32, i32* %k.addr
    %funcCallRet = call i32 @?ord@string@@QEAHH@Z(i8* %arrayElement, i32 %k)
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    %__const.?printme@Test@@QEAXXZ.str2 = getelementptr [2 x i8], [2 x i8]* " \00", i32 0, i32 0
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %funcCallRet, i8* %__const.?printme@Test@@QEAXXZ.str2)
    call void @?print@@YGXPAD@Z(i8* %add)
    br label %for.inc

for.inc:
    %k = load i32, i32* %k.addr
    %k = load i32, i32* %k.addr
    %add = addi32%k, 2
    store i32 %add, i32*, %k.addr
    br label %for.cond

for.end:
    %__const.?printme@Test@@QEAXXZ.str3 = getelementptr [1 x i8], [1 x i8]* "\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str3)
    br label %for.inc

for.body:
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    call void @?println@@YGXPAD@Z(i8* %arrayElement)
    %__const.?printme@Test@@QEAXXZ.str0 = getelementptr [8 x i8], [8 x i8]* "toInt: \00", i32 0, i32 0
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %funcCallRet = call i32 @?parseInt@string@@QEAHXZ(i8* %arrayElement)
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    %add = call i8* @?strcat@@YGPADPADPAD@Z(i8* %__const.?printme@Test@@QEAXXZ.str0, i8* %funcCallRet)
    call void @?println@@YGXPAD@Z(i8* %add)
    %l = load i32, i32* %l.addr
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %array = load i8***, i8**** %array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %srem = sremi32%funcCallRet, %funcCallRet
    store i32 %srem, i32*, %l.addr
    %r = load i32, i32* %r.addr
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %array = load i8***, i8**** %array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %funcCallRet = call i32 @?length@string@@QEAHXZ(i8* %arrayElement)
    %srem = sremi32%funcCallRet, %funcCallRet
    store i32 %srem, i32*, %r.addr
    %l = load i32, i32* %l.addr
    %r = load i32, i32* %r.addr
    %sgt = icmp sgti1%l, %r
    br i1 %sgt, label %if.then, label %if.end

for.inc:
    %j = load i32, i32* %j.addr
    %postfix_op++ = addi32%j, 1
    store i32 %postfix_op++, i32*, %j.addr
    br label %for.cond

for.end:
    br label %for.inc

for.body:
    %j = load i32, i32* %j.addr
    store i32 0, i32*, %j.addr
    br label %for.cond

for.inc:
    %i = load i32, i32* %i.addr
    %postfix_op++ = addi32%i, 1
    store i32 %postfix_op++, i32*, %i.addr
    br label %for.cond

for.end:
    br label %return

return:
    ret void
}
define dso_local  @??0Test@@QEAXZ(%class.Test* %this) {
entry:
    %s.addr = alloca i32
    %sum.addr = alloca i32
    %j.addr = alloca i32
    %i.addr = alloca i32
    %this.addr = alloca %class.Test*
    store %class.Test* %this, %class.Test**, %this.addr
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %n = load i32, i32* @n
    %sizeTmp = muli32%n, 4
    %size = addi32%sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 %n, i32*, %mallocInt32Ptr
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    store i8*** %arrayHeadPtr, i8****, %Test.array.addr
    %i = load i32, i32* %i.addr
    store i32 0, i32*, %i.addr
    br label %for.cond

for.cond:
    %i = load i32, i32* %i.addr
    %n = load i32, i32* @n
    %slt = icmp slti1%i, %n
    br i1 %slt, label %for.body, label %for.end

for.cond:
    %j = load i32, i32* %j.addr
    %i = load i32, i32* %i.addr
    %i = load i32, i32* %i.addr
    %i = load i32, i32* %i.addr
    %mul = muli32%i, %i
    %add = addi32%i, %mul
    %add2 = addi32%add, 2
    %bitwise_or = ori32%add2, 13
    %slt = icmp slti1%j, %bitwise_or
    br i1 %slt, label %for.body, label %for.end

for.body:
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %i = load i32, i32* %i.addr
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %i
    %arrayElement = load i8**, i8*** %elementPtr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8*, i8** %arrayElement, i32 %j
    %arrayElement = load i8*, i8** %elementPtr
    %funcCallRet = call i32 @?rand@@YGHXZ()
    %funcCallRet = call i8* @?toString@@YGPADH@Z(i32 %funcCallRet)
    store i8* %funcCallRet, i8**, %elementPtr
    br label %for.inc

for.inc:
    %j = load i32, i32* %j.addr
    %postfix_op++ = addi32%j, 1
    store i32 %postfix_op++, i32*, %j.addr
    br label %for.cond

for.end:
    br label %for.inc

for.body:
    %sum = load i32, i32* %sum.addr
    store i32 0, i32*, %sum.addr
    %this = load %class.Test*, %class.Test** %this.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %this, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %j = load i32, i32* %j.addr
    %elementPtr = getelementptr i8**, i8*** %Test.array, i32 %j
    %arrayElement = load i8**, i8*** %elementPtr
    %i = load i32, i32* %i.addr
    %i = load i32, i32* %i.addr
    %i = load i32, i32* %i.addr
    %mul = muli32%i, %i
    %add = addi32%i, %mul
    %add2 = addi32%add, 3
    %bitwise_or = ori32%add2, 13
    %sizeTmp = muli32%bitwise_or, 4
    %size = addi32%sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 %bitwise_or, i32*, %mallocInt32Ptr
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8**
    store i8** %arrayHeadPtr, i8***, %elementPtr
    store i32 0, i32*, %s.addr
    %j = load i32, i32* %j.addr
    store i32 0, i32*, %j.addr
    br label %for.cond

for.inc:
    %i = load i32, i32* %i.addr
    %postfix_op++ = addi32%i, 1
    store i32 %postfix_op++, i32*, %i.addr
    br label %for.cond

for.end:
    br label %return

return:
    ret void
}
define dso_local void @__init__() {
entry:
    %array.addr = alloca i8***
    store i32 12883127, i32*, @reed
    br label %return

return:
    ret void
}
define dso_local i32 @?main@@YGHXZ() {
entry:
    call void @__init__()
    %a.addr = alloca i32
    %a.addr = alloca i32
    %a.addr = alloca i32
    %a.addr = alloca i32
    %ptrIntoArray = alloca i8***
    %a.addr = alloca %class.Test*
    %retval = alloca i32
    %n = load i32, i32* @n
    %funcCallRet = call i32 @?getInt@@YGHXZ()
    store i32 %funcCallRet, i32*, @n
    %__const.?main@@YGHXZ.str4 = getelementptr [11 x i8], [11 x i8]* "BY Kipsora\00", i32 0, i32 0
    call void @?println@@YGXPAD@Z(i8* %__const.?main@@YGHXZ.str4)
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 0)
    %castToClassPtr = bitcast i8* %malloc to %class.Test*
    call  @??0Test@@QEAXZ(%class.Test* %castToClassPtr)
    store %class.Test* %castToClassPtr, %class.Test**, %a.addr
    %a = load %class.Test*, %class.Test** %a.addr
    call void @?printme@Test@@QEAXXZ(%class.Test* %a)
    %a = load %class.Test*, %class.Test** %a.addr
    %Test.array.addr = getelementptr %class.Test, %class.Test* %a, i32 0, i32 0
    %Test.array = load i8***, i8**** %Test.array.addr
    %sizeTmp = muli323, 4
    %size = addi32%sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 3, i32*, %mallocInt32Ptr
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8***
    %arrayTailPtr = getelementptr i8**, i8*** %arrayHeadPtr, i32 3
    store i8*** %arrayHeadPtr, i8****, %ptrIntoArray
    br label %arrMallocIteCond

arrMallocIteCond:
    %arrayPtrIte = load i8***, i8**** %ptrIntoArray
    %iteCmpTmp = icmp slti1%arrayPtrIte, %arrayTailPtr
    br i1 %iteCmpTmp, label %arrMallocIteBody, label %arrMallocIteEnd

arrMallocIteBody:
    %sizeTmp = muli323, 4
    %size = addi32%sizeTmp, 4
    %malloc = call i8* @?malloc@@YGPADH@Z(i32 %size)
    %mallocInt32Ptr = bitcast i8* %malloc to i32*
    store i32 3, i32*, %mallocInt32Ptr
    %arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
    %arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i8**
    store i8** %arrayHeadPtr, i8***, %arrayPtrIte
    %nextElemPtr = getelementptr i8**, i8*** %arrayPtrIte, i32 1
    store i8*** %nextElemPtr, i8****, %ptrIntoArray
    br label %arrMallocIteCond

arrMallocIteEnd:
    store i8*** %arrayHeadPtr, i8****, %Test.array.addr
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
