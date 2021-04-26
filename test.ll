%class.Heap_Node = type { %class.Array_Node* }
%class.Node = type { i32, i32 }
%class.Edge = type { i32, i32, i32 }
%class.EdgeList = type { %class.Edge**, i32*, i32*, i32 }
%class.Array_Node = type { %class.Node**, i32 }

@INF = global i32 10000000, align 4
@g = global %class.EdgeList* null, align 4
@__const.main.str2 = private unnamed_addr constant [1 x i8] c"\00", align 1
@__const.main.str1 = private unnamed_addr constant [2 x i8] c" \00", align 1
@__const.main.str0 = private unnamed_addr constant [3 x i8] c"-1\00", align 1
@m = global i32 0, align 4
@n = global i32 0, align 4

define void @_init$$YGXXZ() {
entry:
	%funcCallRet = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet, i32* @n, align 4
	%funcCallRet_2 = call i32 @_getInt$$YGHXZ()
	store i32 %funcCallRet_2, i32* @m, align 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 16)
	%castToClassPtr = bitcast i8* %malloc to %class.EdgeList*
	store %class.EdgeList* %castToClassPtr, %class.EdgeList** @g, align 4
	%g_2 = load %class.EdgeList*, %class.EdgeList** @g, align 4
	%n_2 = load i32, i32* @n, align 4
	%m_2 = load i32, i32* @m, align 4
	call void @_init$EdgeList$$QEAXHH$Z(%class.EdgeList* %g_2, i32 %n_2, i32 %m_2)
	br label %for.cond

for.cond:
	%i_4 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%m_3 = load i32, i32* @m, align 4
	%slt = icmp slt i32 %i_4, %m_3
	br i1 %slt, label %for.body, label %for.end

for.body:
	%funcCallRet_3 = call i32 @_getInt$$YGHXZ()
	%funcCallRet_4 = call i32 @_getInt$$YGHXZ()
	%funcCallRet_5 = call i32 @_getInt$$YGHXZ()
	%g_3 = load %class.EdgeList*, %class.EdgeList** @g, align 4
	call void @_addEdge$EdgeList$$QEAXHHH$Z(%class.EdgeList* %g_3, i32 %funcCallRet_3, i32 %funcCallRet_4, i32 %funcCallRet_5)
	%prefix_inc = add i32 %i_4, 1
	br label %for.cond

for.end:
	ret void
}

define void @_resize$Array_Node$$QEAXH$Z(%class.Array_Node* %this, i32 %newSize) {
entry:
	br label %while.cond

while.cond:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%castToIntPtr = bitcast %class.Node** %Array_Node.storage to i32*
	%arrayElemPtr = getelementptr i32, i32* %castToIntPtr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%slt = icmp slt i32 %arraySize, %newSize
	br i1 %slt, label %while.body, label %while.end

while.body:
	call void @_doubleStorage$Array_Node$$QEAXXZ(%class.Array_Node* %this)
	br label %while.cond

while.end:
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	store i32 %newSize, i32* %Array_Node.sz.addr, align 4
	ret void
}

define void @_doubleStorage$Array_Node$$QEAXXZ(%class.Array_Node* %this) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz = load i32, i32* %Array_Node.sz.addr, align 4
	%Array_Node.storage.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%castToIntPtr = bitcast %class.Node** %Array_Node.storage to i32*
	%arrayElemPtr = getelementptr i32, i32* %castToIntPtr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%mul = mul i32 %arraySize, 2
	%sizeTmp = mul i32 %mul, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %mul, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to %class.Node**
	store %class.Node** %arrayHeadPtr, %class.Node*** %Array_Node.storage.addr_2, align 4
	%Array_Node.sz.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	store i32 0, i32* %Array_Node.sz.addr_2, align 4
	br label %for.cond

for.cond:
	%Array_Node.sz.addr_3 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_3 = load i32, i32* %Array_Node.sz.addr_3, align 4
	%ne = icmp ne i32 %Array_Node.sz_3, %Array_Node.sz
	br i1 %ne, label %for.body, label %for.end

for.body:
	%Array_Node.storage.addr_3 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage_3 = load %class.Node**, %class.Node*** %Array_Node.storage.addr_3, align 4
	%Array_Node.sz.addr_4 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_4 = load i32, i32* %Array_Node.sz.addr_4, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage_3, i32 %Array_Node.sz_4
	%Array_Node.sz.addr_5 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_5 = load i32, i32* %Array_Node.sz.addr_5, align 4
	%elementPtr_2 = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %Array_Node.sz_5
	%arrayElement_2 = load %class.Node*, %class.Node** %elementPtr_2, align 4
	store %class.Node* %arrayElement_2, %class.Node** %elementPtr, align 4
	%Array_Node.sz.addr_6 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_6 = load i32, i32* %Array_Node.sz.addr_6, align 4
	%prefix_inc = add i32 %Array_Node.sz_6, 1
	store i32 %prefix_inc, i32* %Array_Node.sz.addr_6, align 4
	br label %for.cond

for.end:
	ret void
}

define i32 @_lchild$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x) {
entry:
	%mul = mul i32 %x, 2
	%add = add i32 %mul, 1
	ret i32 %add
}

define %class.Node* @_back$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %this) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz = load i32, i32* %Array_Node.sz.addr, align 4
	%sub = sub i32 %Array_Node.sz, 1
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %sub
	%arrayElement = load %class.Node*, %class.Node** %elementPtr, align 4
	ret %class.Node* %arrayElement
}

define i32 @_nVertices$EdgeList$$QEAHXZ(%class.EdgeList* %this) {
entry:
	%EdgeList.first.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 2
	%EdgeList.first = load i32*, i32** %EdgeList.first.addr, align 4
	%arrayElemPtr = getelementptr i32, i32* %EdgeList.first, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	ret i32 %arraySize
}

define %class.Node* @_top$Heap_Node$$QEAUNode$$XZ(%class.Heap_Node* %this) {
entry:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr, align 4
	%funcCallRet = call %class.Node* @_front$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %Heap_Node.storage)
	ret %class.Node* %funcCallRet
}

define void @_maxHeapify$Heap_Node$$QEAXH$Z(%class.Heap_Node* %this, i32 %x) {
entry:
	%funcCallRet = call i32 @_lchild$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x)
	%funcCallRet_2 = call i32 @_rchild$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x)
	%funcCallRet_3 = call i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %this)
	%slt = icmp slt i32 %funcCallRet, %funcCallRet_3
	br i1 %slt, label %logicalAnd_branch, label %logicalAnd_end

logicalAnd_branch:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr, align 4
	%funcCallRet_4 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage, i32 %funcCallRet)
	%funcCallRet_5 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_4)
	%Heap_Node.storage.addr_2 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_2 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_2, align 4
	%funcCallRet_6 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage_2, i32 %x)
	%funcCallRet_7 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_6)
	%sgt = icmp sgt i32 %funcCallRet_5, %funcCallRet_7
	br label %logicalAnd_end

logicalAnd_end:
	%logical_and = phi i1 [ 0, %entry ], [ %sgt, %logicalAnd_branch ]
	br i1 %logical_and, label %if.then, label %if.end

if.then:
	br label %if.end

if.end:
	%largest_8 = phi i32 [ %funcCallRet, %if.then ], [ %x, %logicalAnd_end ]
	%funcCallRet_8 = call i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %this)
	%slt_2 = icmp slt i32 %funcCallRet_2, %funcCallRet_8
	br i1 %slt_2, label %logicalAnd_branch_2, label %logicalAnd_end_2

logicalAnd_branch_2:
	%Heap_Node.storage.addr_3 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_3 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_3, align 4
	%funcCallRet_9 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage_3, i32 %funcCallRet_2)
	%funcCallRet_10 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_9)
	%Heap_Node.storage.addr_4 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_4 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_4, align 4
	%funcCallRet_11 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage_4, i32 %largest_8)
	%funcCallRet_12 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_11)
	%sgt_2 = icmp sgt i32 %funcCallRet_10, %funcCallRet_12
	br label %logicalAnd_end_2

logicalAnd_end_2:
	%logical_and_2 = phi i1 [ 0, %if.end ], [ %sgt_2, %logicalAnd_branch_2 ]
	br i1 %logical_and_2, label %if.then_2, label %if.end_2

if.then_2:
	br label %if.end_2

if.end_2:
	%largest_9 = phi i32 [ %funcCallRet_2, %if.then_2 ], [ %largest_8, %logicalAnd_end_2 ]
	%eq = icmp eq i32 %largest_9, %x
	br i1 %eq, label %if.then_3, label %if.end_3

if.then_3:
	br label %return

if.end_3:
	%Heap_Node.storage.addr_5 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_5 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_5, align 4
	call void @_swap$Array_Node$$QEAXHH$Z(%class.Array_Node* %Heap_Node.storage_5, i32 %x, i32 %largest_9)
	call void @_maxHeapify$Heap_Node$$QEAXH$Z(%class.Heap_Node* %this, i32 %largest_9)
	br label %return

return:
	ret void
}

define %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %this, i32 %i) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %i
	%arrayElement = load %class.Node*, %class.Node** %elementPtr, align 4
	ret %class.Node* %arrayElement
}

define void @_push$Heap_Node$$QEAXUNode$$$Z(%class.Heap_Node* %this, %class.Node* %v) {
entry:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr, align 4
	call void @_push_back$Array_Node$$QEAXUNode$$$Z(%class.Array_Node* %Heap_Node.storage, %class.Node* %v)
	%funcCallRet = call i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %this)
	%sub = sub i32 %funcCallRet, 1
	br label %while.cond

while.cond:
	%x_6 = phi i32 [ %sub, %entry ], [ %funcCallRet_2, %if.end ]
	%sgt = icmp sgt i32 %x_6, 0
	br i1 %sgt, label %while.body, label %while.end

if.then:
	br label %while.end

if.end:
	%Heap_Node.storage.addr_4 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_4 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_4, align 4
	call void @_swap$Array_Node$$QEAXHH$Z(%class.Array_Node* %Heap_Node.storage_4, i32 %funcCallRet_2, i32 %x_6)
	br label %while.cond

while.body:
	%funcCallRet_2 = call i32 @_pnt$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x_6)
	%Heap_Node.storage.addr_2 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_2 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_2, align 4
	%funcCallRet_3 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage_2, i32 %funcCallRet_2)
	%funcCallRet_4 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_3)
	%Heap_Node.storage.addr_3 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_3 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_3, align 4
	%funcCallRet_5 = call %class.Node* @_get$Array_Node$$QEAUNode$$H$Z(%class.Array_Node* %Heap_Node.storage_3, i32 %x_6)
	%funcCallRet_6 = call i32 @_key_$Node$$QEAHXZ(%class.Node* %funcCallRet_5)
	%sge = icmp sge i32 %funcCallRet_4, %funcCallRet_6
	br i1 %sge, label %if.then, label %if.end

while.end:
	ret void
}

define void @_addEdge$EdgeList$$QEAXHHH$Z(%class.EdgeList* %this, i32 %u, i32 %v, i32 %w) {
entry:
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 12)
	%castToClassPtr = bitcast i8* %malloc to %class.Edge*
	%Edge.from.addr = getelementptr %class.Edge, %class.Edge* %castToClassPtr, i32 0, i32 0
	store i32 %u, i32* %Edge.from.addr, align 4
	%Edge.to.addr = getelementptr %class.Edge, %class.Edge* %castToClassPtr, i32 0, i32 1
	store i32 %v, i32* %Edge.to.addr, align 4
	%Edge.weight.addr = getelementptr %class.Edge, %class.Edge* %castToClassPtr, i32 0, i32 2
	store i32 %w, i32* %Edge.weight.addr, align 4
	%EdgeList.edges.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 0
	%EdgeList.edges = load %class.Edge**, %class.Edge*** %EdgeList.edges.addr, align 4
	%EdgeList.size.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 3
	%EdgeList.size = load i32, i32* %EdgeList.size.addr, align 4
	%elementPtr = getelementptr %class.Edge*, %class.Edge** %EdgeList.edges, i32 %EdgeList.size
	store %class.Edge* %castToClassPtr, %class.Edge** %elementPtr, align 4
	%EdgeList.next.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 1
	%EdgeList.next = load i32*, i32** %EdgeList.next.addr, align 4
	%EdgeList.size.addr_2 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 3
	%EdgeList.size_2 = load i32, i32* %EdgeList.size.addr_2, align 4
	%elementPtr_2 = getelementptr i32, i32* %EdgeList.next, i32 %EdgeList.size_2
	%EdgeList.first.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 2
	%EdgeList.first = load i32*, i32** %EdgeList.first.addr, align 4
	%elementPtr_3 = getelementptr i32, i32* %EdgeList.first, i32 %u
	%arrayElement_3 = load i32, i32* %elementPtr_3, align 4
	store i32 %arrayElement_3, i32* %elementPtr_2, align 4
	%EdgeList.first.addr_2 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 2
	%EdgeList.first_2 = load i32*, i32** %EdgeList.first.addr_2, align 4
	%elementPtr_4 = getelementptr i32, i32* %EdgeList.first_2, i32 %u
	%EdgeList.size.addr_3 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 3
	%EdgeList.size_3 = load i32, i32* %EdgeList.size.addr_3, align 4
	store i32 %EdgeList.size_3, i32* %elementPtr_4, align 4
	%EdgeList.size.addr_4 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 3
	%EdgeList.size_4 = load i32, i32* %EdgeList.size.addr_4, align 4
	%prefix_inc = add i32 %EdgeList.size_4, 1
	store i32 %prefix_inc, i32* %EdgeList.size.addr_4, align 4
	ret void
}

define i32 @_key_$Node$$QEAHXZ(%class.Node* %this) {
entry:
	%Node.dist.addr = getelementptr %class.Node, %class.Node* %this, i32 0, i32 1
	%Node.dist = load i32, i32* %Node.dist.addr, align 4
	%prefix_neg = sub i32 0, %Node.dist
	ret i32 %prefix_neg
}

define i32 @_rchild$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x) {
entry:
	%mul = mul i32 %x, 2
	%add = add i32 %mul, 2
	ret i32 %add
}

define i32 @_size$Array_Node$$QEAHXZ(%class.Array_Node* %this) {
entry:
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz = load i32, i32* %Array_Node.sz.addr, align 4
	ret i32 %Array_Node.sz
}

define i32 @_nEdges$EdgeList$$QEAHXZ(%class.EdgeList* %this) {
entry:
	%EdgeList.edges.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 0
	%EdgeList.edges = load %class.Edge**, %class.Edge*** %EdgeList.edges.addr, align 4
	%castToIntPtr = bitcast %class.Edge** %EdgeList.edges to i32*
	%arrayElemPtr = getelementptr i32, i32* %castToIntPtr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	ret i32 %arraySize
}

define void @_swap$Array_Node$$QEAXHH$Z(%class.Array_Node* %this, i32 %i, i32 %j) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %i
	%arrayElement = load %class.Node*, %class.Node** %elementPtr, align 4
	%Array_Node.storage.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage_2 = load %class.Node**, %class.Node*** %Array_Node.storage.addr_2, align 4
	%elementPtr_2 = getelementptr %class.Node*, %class.Node** %Array_Node.storage_2, i32 %i
	%Array_Node.storage.addr_3 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage_3 = load %class.Node**, %class.Node*** %Array_Node.storage.addr_3, align 4
	%elementPtr_3 = getelementptr %class.Node*, %class.Node** %Array_Node.storage_3, i32 %j
	%arrayElement_3 = load %class.Node*, %class.Node** %elementPtr_3, align 4
	store %class.Node* %arrayElement_3, %class.Node** %elementPtr_2, align 4
	%Array_Node.storage.addr_4 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage_4 = load %class.Node**, %class.Node*** %Array_Node.storage.addr_4, align 4
	%elementPtr_4 = getelementptr %class.Node*, %class.Node** %Array_Node.storage_4, i32 %j
	store %class.Node* %arrayElement, %class.Node** %elementPtr_4, align 4
	ret void
}

define void @_set$Array_Node$$QEAXHUNode$$$Z(%class.Array_Node* %this, i32 %i, %class.Node* %v) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %i
	store %class.Node* %v, %class.Node** %elementPtr, align 4
	ret void
}

define %class.Node* @_front$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %this) {
entry:
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 0
	%arrayElement = load %class.Node*, %class.Node** %elementPtr, align 4
	ret %class.Node* %arrayElement
}

define i32 @main() {
entry:
	call void @_init$$YGXXZ()
	br label %for.cond

for.cond:
	%i_5 = phi i32 [ 0, %entry ], [ %prefix_inc_2, %for.end ]
	%n = load i32, i32* @n, align 4
	%slt = icmp slt i32 %i_5, %n
	br i1 %slt, label %for.body_2, label %for.end_2

for.cond_2:
	%j_7 = phi i32 [ 0, %for.body_2 ], [ %prefix_inc, %if.end ]
	%n_2 = load i32, i32* @n, align 4
	%slt_2 = icmp slt i32 %j_7, %n_2
	br i1 %slt_2, label %for.body, label %for.end

if.then:
	%__const.main.str0 = getelementptr [3 x i8], [3 x i8]* @__const.main.str0, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str0)
	br label %if.end

if.else:
	%elementPtr_2 = getelementptr i32, i32* %funcCallRet, i32 %j_7
	%arrayElement_2 = load i32, i32* %elementPtr_2, align 4
	%funcCallRet_2 = call i8* @_toString$$YGPADH$Z(i32 %arrayElement_2)
	call void @_print$$YGXPAD$Z(i8* %funcCallRet_2)
	br label %if.end

if.end:
	%__const.main.str1 = getelementptr [2 x i8], [2 x i8]* @__const.main.str1, i32 0, i32 0
	call void @_print$$YGXPAD$Z(i8* %__const.main.str1)
	%prefix_inc = add i32 %j_7, 1
	br label %for.cond_2

for.body:
	%elementPtr = getelementptr i32, i32* %funcCallRet, i32 %j_7
	%arrayElement = load i32, i32* %elementPtr, align 4
	%INF = load i32, i32* @INF, align 4
	%eq = icmp eq i32 %arrayElement, %INF
	br i1 %eq, label %if.then, label %if.else

for.end:
	%__const.main.str2 = getelementptr [1 x i8], [1 x i8]* @__const.main.str2, i32 0, i32 0
	call void @_println$$YGXPAD$Z(i8* %__const.main.str2)
	%prefix_inc_2 = add i32 %i_5, 1
	br label %for.cond

for.body_2:
	%funcCallRet = call i32* @_dijkstra$$YGPAHH$Z(i32 %i_5)
	br label %for.cond_2

for.end_2:
	ret i32 0
}

define %class.Node* @_pop_back$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %this) {
entry:
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz = load i32, i32* %Array_Node.sz.addr, align 4
	%prefix_dec = sub i32 %Array_Node.sz, 1
	store i32 %prefix_dec, i32* %Array_Node.sz.addr, align 4
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%Array_Node.sz.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_2 = load i32, i32* %Array_Node.sz.addr_2, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage, i32 %Array_Node.sz_2
	%arrayElement = load %class.Node*, %class.Node** %elementPtr, align 4
	ret %class.Node* %arrayElement
}

define %class.Node* @_pop$Heap_Node$$QEAUNode$$XZ(%class.Heap_Node* %this) {
entry:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr, align 4
	%funcCallRet = call %class.Node* @_front$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %Heap_Node.storage)
	%Heap_Node.storage.addr_2 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_2 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_2, align 4
	%funcCallRet_2 = call i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %this)
	%sub = sub i32 %funcCallRet_2, 1
	call void @_swap$Array_Node$$QEAXHH$Z(%class.Array_Node* %Heap_Node.storage_2, i32 0, i32 %sub)
	%Heap_Node.storage.addr_3 = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage_3 = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr_3, align 4
	%funcCallRet_3 = call %class.Node* @_pop_back$Array_Node$$QEAUNode$$XZ(%class.Array_Node* %Heap_Node.storage_3)
	call void @_maxHeapify$Heap_Node$$QEAXH$Z(%class.Heap_Node* %this, i32 0)
	ret %class.Node* %funcCallRet
}

define void @_init$EdgeList$$QEAXHH$Z(%class.EdgeList* %this, i32 %n, i32 %m) {
entry:
	%EdgeList.edges.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 0
	%sizeTmp = mul i32 %m, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %m, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to %class.Edge**
	store %class.Edge** %arrayHeadPtr, %class.Edge*** %EdgeList.edges.addr, align 4
	%EdgeList.next.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 1
	%sizeTmp_2 = mul i32 %m, 4
	%size_2 = add i32 %sizeTmp_2, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size_2)
	%mallocInt32Ptr_2 = bitcast i8* %malloc_2 to i32*
	store i32 %m, i32* %mallocInt32Ptr_2, align 4
	%arrayHeadPtrUnguarded_2 = getelementptr i32, i32* %mallocInt32Ptr_2, i32 1
	%arrayHeadPtr_2 = bitcast i32* %arrayHeadPtrUnguarded_2 to i32*
	store i32* %arrayHeadPtr_2, i32** %EdgeList.next.addr, align 4
	%EdgeList.first.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 2
	%sizeTmp_3 = mul i32 %n, 4
	%size_3 = add i32 %sizeTmp_3, 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 %size_3)
	%mallocInt32Ptr_3 = bitcast i8* %malloc_3 to i32*
	store i32 %n, i32* %mallocInt32Ptr_3, align 4
	%arrayHeadPtrUnguarded_3 = getelementptr i32, i32* %mallocInt32Ptr_3, i32 1
	%arrayHeadPtr_3 = bitcast i32* %arrayHeadPtrUnguarded_3 to i32*
	store i32* %arrayHeadPtr_3, i32** %EdgeList.first.addr, align 4
	br label %for.cond

for.cond:
	%i_9 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%slt = icmp slt i32 %i_9, %m
	br i1 %slt, label %for.body, label %for.end

for.body:
	%EdgeList.next.addr_2 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 1
	%EdgeList.next_2 = load i32*, i32** %EdgeList.next.addr_2, align 4
	%elementPtr = getelementptr i32, i32* %EdgeList.next_2, i32 %i_9
	store i32 -1, i32* %elementPtr, align 4
	%prefix_inc = add i32 %i_9, 1
	br label %for.cond

for.end:
	br label %for.cond_2

for.cond_2:
	%i_10 = phi i32 [ 0, %for.end ], [ %prefix_inc_2, %for.body_2 ]
	%slt_2 = icmp slt i32 %i_10, %n
	br i1 %slt_2, label %for.body_2, label %for.end_2

for.body_2:
	%EdgeList.first.addr_2 = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 2
	%EdgeList.first_2 = load i32*, i32** %EdgeList.first.addr_2, align 4
	%elementPtr_2 = getelementptr i32, i32* %EdgeList.first_2, i32 %i_10
	store i32 -1, i32* %elementPtr_2, align 4
	%prefix_inc_2 = add i32 %i_10, 1
	br label %for.cond_2

for.end_2:
	%EdgeList.size.addr = getelementptr %class.EdgeList, %class.EdgeList* %this, i32 0, i32 3
	store i32 0, i32* %EdgeList.size.addr, align 4
	ret void
}

define void @___init__$$YGXXZ() {
entry:
	ret void
}

define i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %this) {
entry:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%Heap_Node.storage = load %class.Array_Node*, %class.Array_Node** %Heap_Node.storage.addr, align 4
	%funcCallRet = call i32 @_size$Array_Node$$QEAHXZ(%class.Array_Node* %Heap_Node.storage)
	ret i32 %funcCallRet
}

define void @__0Array_Node$$QEAXZ(%class.Array_Node* %this) {
entry:
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	store i32 0, i32* %Array_Node.sz.addr, align 4
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 68)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 16, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to %class.Node**
	store %class.Node** %arrayHeadPtr, %class.Node*** %Array_Node.storage.addr, align 4
	ret void
}

define void @__0Heap_Node$$QEAXZ(%class.Heap_Node* %this) {
entry:
	%Heap_Node.storage.addr = getelementptr %class.Heap_Node, %class.Heap_Node* %this, i32 0, i32 0
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr = bitcast i8* %malloc to %class.Array_Node*
	call void @__0Array_Node$$QEAXZ(%class.Array_Node* %castToClassPtr)
	store %class.Array_Node* %castToClassPtr, %class.Array_Node** %Heap_Node.storage.addr, align 4
	ret void
}

define i32* @_dijkstra$$YGPAHH$Z(i32 %s) {
entry:
	%n = load i32, i32* @n, align 4
	%sizeTmp = mul i32 %n, 4
	%size = add i32 %sizeTmp, 4
	%malloc = call i8* @_malloc$$YGPADH$Z(i32 %size)
	%mallocInt32Ptr = bitcast i8* %malloc to i32*
	store i32 %n, i32* %mallocInt32Ptr, align 4
	%arrayHeadPtrUnguarded = getelementptr i32, i32* %mallocInt32Ptr, i32 1
	%arrayHeadPtr = bitcast i32* %arrayHeadPtrUnguarded to i32*
	%n_2 = load i32, i32* @n, align 4
	%sizeTmp_2 = mul i32 %n_2, 4
	%size_2 = add i32 %sizeTmp_2, 4
	%malloc_2 = call i8* @_malloc$$YGPADH$Z(i32 %size_2)
	%mallocInt32Ptr_2 = bitcast i8* %malloc_2 to i32*
	store i32 %n_2, i32* %mallocInt32Ptr_2, align 4
	%arrayHeadPtrUnguarded_2 = getelementptr i32, i32* %mallocInt32Ptr_2, i32 1
	%arrayHeadPtr_2 = bitcast i32* %arrayHeadPtrUnguarded_2 to i32*
	br label %for.cond

for.cond:
	%i_6 = phi i32 [ 0, %entry ], [ %prefix_inc, %for.body ]
	%n_3 = load i32, i32* @n, align 4
	%slt = icmp slt i32 %i_6, %n_3
	br i1 %slt, label %for.body, label %for.end

for.body:
	%elementPtr = getelementptr i32, i32* %arrayHeadPtr_2, i32 %i_6
	%INF = load i32, i32* @INF, align 4
	store i32 %INF, i32* %elementPtr, align 4
	%elementPtr_2 = getelementptr i32, i32* %arrayHeadPtr, i32 %i_6
	store i32 0, i32* %elementPtr_2, align 4
	%prefix_inc = add i32 %i_6, 1
	br label %for.cond

for.end:
	%elementPtr_3 = getelementptr i32, i32* %arrayHeadPtr_2, i32 %s
	store i32 0, i32* %elementPtr_3, align 4
	%malloc_3 = call i8* @_malloc$$YGPADH$Z(i32 4)
	%castToClassPtr = bitcast i8* %malloc_3 to %class.Heap_Node*
	call void @__0Heap_Node$$QEAXZ(%class.Heap_Node* %castToClassPtr)
	%malloc_4 = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr_2 = bitcast i8* %malloc_4 to %class.Node*
	%Node.dist.addr = getelementptr %class.Node, %class.Node* %castToClassPtr_2, i32 0, i32 1
	store i32 0, i32* %Node.dist.addr, align 4
	%Node.node.addr = getelementptr %class.Node, %class.Node* %castToClassPtr_2, i32 0, i32 0
	store i32 %s, i32* %Node.node.addr, align 4
	call void @_push$Heap_Node$$QEAXUNode$$$Z(%class.Heap_Node* %castToClassPtr, %class.Node* %castToClassPtr_2)
	br label %while.cond

while.cond:
	%funcCallRet = call i32 @_size$Heap_Node$$QEAHXZ(%class.Heap_Node* %castToClassPtr)
	%ne = icmp ne i32 %funcCallRet, 0
	br i1 %ne, label %while.body, label %while.end

if.then:
	br label %while.cond

if.end:
	%elementPtr_5 = getelementptr i32, i32* %arrayHeadPtr, i32 %Node.node_2
	store i32 1, i32* %elementPtr_5, align 4
	%g = load %class.EdgeList*, %class.EdgeList** @g, align 4
	%EdgeList.first.addr = getelementptr %class.EdgeList, %class.EdgeList* %g, i32 0, i32 2
	%EdgeList.first = load i32*, i32** %EdgeList.first.addr, align 4
	%elementPtr_6 = getelementptr i32, i32* %EdgeList.first, i32 %Node.node_2
	%arrayElement_6 = load i32, i32* %elementPtr_6, align 4
	br label %for.cond_2

for.cond_2:
	%k_7 = phi i32 [ %arrayElement_6, %if.end ], [ %arrayElement_13, %for.inc_2 ]
	%ne_2 = icmp ne i32 %k_7, -1
	br i1 %ne_2, label %for.body_2, label %for.end_2

if.then_2:
	br label %for.inc_2

if.end_2:
	%elementPtr_11 = getelementptr i32, i32* %arrayHeadPtr_2, i32 %Edge.to
	store i32 %add, i32* %elementPtr_11, align 4
	%malloc_5 = call i8* @_malloc$$YGPADH$Z(i32 8)
	%castToClassPtr_3 = bitcast i8* %malloc_5 to %class.Node*
	%Node.node.addr_3 = getelementptr %class.Node, %class.Node* %castToClassPtr_3, i32 0, i32 0
	store i32 %Edge.to, i32* %Node.node.addr_3, align 4
	%Node.dist.addr_2 = getelementptr %class.Node, %class.Node* %castToClassPtr_3, i32 0, i32 1
	%elementPtr_12 = getelementptr i32, i32* %arrayHeadPtr_2, i32 %Edge.to
	%arrayElement_12 = load i32, i32* %elementPtr_12, align 4
	store i32 %arrayElement_12, i32* %Node.dist.addr_2, align 4
	call void @_push$Heap_Node$$QEAXUNode$$$Z(%class.Heap_Node* %castToClassPtr, %class.Node* %castToClassPtr_3)
	br label %for.inc_2

for.body_2:
	%g_2 = load %class.EdgeList*, %class.EdgeList** @g, align 4
	%EdgeList.edges.addr = getelementptr %class.EdgeList, %class.EdgeList* %g_2, i32 0, i32 0
	%EdgeList.edges = load %class.Edge**, %class.Edge*** %EdgeList.edges.addr, align 4
	%elementPtr_7 = getelementptr %class.Edge*, %class.Edge** %EdgeList.edges, i32 %k_7
	%arrayElement_7 = load %class.Edge*, %class.Edge** %elementPtr_7, align 4
	%Edge.to.addr = getelementptr %class.Edge, %class.Edge* %arrayElement_7, i32 0, i32 1
	%Edge.to = load i32, i32* %Edge.to.addr, align 4
	%g_3 = load %class.EdgeList*, %class.EdgeList** @g, align 4
	%EdgeList.edges.addr_2 = getelementptr %class.EdgeList, %class.EdgeList* %g_3, i32 0, i32 0
	%EdgeList.edges_2 = load %class.Edge**, %class.Edge*** %EdgeList.edges.addr_2, align 4
	%elementPtr_8 = getelementptr %class.Edge*, %class.Edge** %EdgeList.edges_2, i32 %k_7
	%arrayElement_8 = load %class.Edge*, %class.Edge** %elementPtr_8, align 4
	%Edge.weight.addr = getelementptr %class.Edge, %class.Edge* %arrayElement_8, i32 0, i32 2
	%Edge.weight = load i32, i32* %Edge.weight.addr, align 4
	%elementPtr_9 = getelementptr i32, i32* %arrayHeadPtr_2, i32 %Node.node_2
	%arrayElement_9 = load i32, i32* %elementPtr_9, align 4
	%add = add i32 %arrayElement_9, %Edge.weight
	%elementPtr_10 = getelementptr i32, i32* %arrayHeadPtr_2, i32 %Edge.to
	%arrayElement_10 = load i32, i32* %elementPtr_10, align 4
	%sge = icmp sge i32 %add, %arrayElement_10
	br i1 %sge, label %if.then_2, label %if.end_2

for.inc_2:
	%g_4 = load %class.EdgeList*, %class.EdgeList** @g, align 4
	%EdgeList.next.addr = getelementptr %class.EdgeList, %class.EdgeList* %g_4, i32 0, i32 1
	%EdgeList.next = load i32*, i32** %EdgeList.next.addr, align 4
	%elementPtr_13 = getelementptr i32, i32* %EdgeList.next, i32 %k_7
	%arrayElement_13 = load i32, i32* %elementPtr_13, align 4
	br label %for.cond_2

for.end_2:
	br label %while.cond

while.body:
	%funcCallRet_2 = call %class.Node* @_pop$Heap_Node$$QEAUNode$$XZ(%class.Heap_Node* %castToClassPtr)
	%Node.node.addr_2 = getelementptr %class.Node, %class.Node* %funcCallRet_2, i32 0, i32 0
	%Node.node_2 = load i32, i32* %Node.node.addr_2, align 4
	%elementPtr_4 = getelementptr i32, i32* %arrayHeadPtr, i32 %Node.node_2
	%arrayElement_4 = load i32, i32* %elementPtr_4, align 4
	%eq = icmp eq i32 %arrayElement_4, 1
	br i1 %eq, label %if.then, label %if.end

while.end:
	ret i32* %arrayHeadPtr_2
}

define void @_push_back$Array_Node$$QEAXUNode$$$Z(%class.Array_Node* %this, %class.Node* %v) {
entry:
	%funcCallRet = call i32 @_size$Array_Node$$QEAHXZ(%class.Array_Node* %this)
	%Array_Node.storage.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage = load %class.Node**, %class.Node*** %Array_Node.storage.addr, align 4
	%castToIntPtr = bitcast %class.Node** %Array_Node.storage to i32*
	%arrayElemPtr = getelementptr i32, i32* %castToIntPtr, i32 -1
	%arraySize = load i32, i32* %arrayElemPtr, align 4
	%eq = icmp eq i32 %funcCallRet, %arraySize
	br i1 %eq, label %if.then, label %if.end

if.then:
	call void @_doubleStorage$Array_Node$$QEAXXZ(%class.Array_Node* %this)
	br label %if.end

if.end:
	%Array_Node.storage.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 0
	%Array_Node.storage_2 = load %class.Node**, %class.Node*** %Array_Node.storage.addr_2, align 4
	%Array_Node.sz.addr = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz = load i32, i32* %Array_Node.sz.addr, align 4
	%elementPtr = getelementptr %class.Node*, %class.Node** %Array_Node.storage_2, i32 %Array_Node.sz
	store %class.Node* %v, %class.Node** %elementPtr, align 4
	%Array_Node.sz.addr_2 = getelementptr %class.Array_Node, %class.Array_Node* %this, i32 0, i32 1
	%Array_Node.sz_2 = load i32, i32* %Array_Node.sz.addr_2, align 4
	%prefix_inc = add i32 %Array_Node.sz_2, 1
	store i32 %prefix_inc, i32* %Array_Node.sz.addr_2, align 4
	ret void
}

define i32 @_pnt$Heap_Node$$QEAHH$Z(%class.Heap_Node* %this, i32 %x) {
entry:
	%sub = sub i32 %x, 1
	%sdiv = sdiv i32 %sub, 2
	ret i32 %sdiv
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

