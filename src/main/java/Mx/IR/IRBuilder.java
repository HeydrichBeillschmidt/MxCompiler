package Mx.IR;

import Mx.AST.*;
import Mx.AST.Expressions.*;
import Mx.AST.Expressions.Literals.*;
import Mx.AST.Initializers.*;
import Mx.AST.Specifiers.*;
import Mx.AST.Statements.*;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.*;
import Mx.IR.TypeSystem.IRType;
import Mx.IR.TypeSystem.PointerType;
import Mx.IR.TypeSystem.VoidType;
import Mx.Types.*;
import Mx.Utils.*;

import java.util.ArrayList;

public class IRBuilder implements ASTVisitor {
    private final IRModule module;
    private final Scope globalScope;
    private final TypeTable astTypeTable;
    private final ExceptionHandler exceptionHandler;
    private final Function initializer;

    private IRBlock curBlock;
    private Function curFunc;

    public static Register pseudoReg = new Register(new VoidType(), "");

    public IRBuilder(Scope globalScope, TypeTable astTypeTable,
                     ExceptionHandler exceptionHandler) {
        this.module = new IRModule(astTypeTable);
        this.globalScope = globalScope;
        this.astTypeTable = astTypeTable;
        this.exceptionHandler = exceptionHandler;
        this.initializer = new Function(new VoidType(),
                "__init__", new ArrayList<>());
        module.addFunction(initializer);
        curBlock = null;
        curFunc = null;
    }

    public IRModule getModule() {
        return module;
    }

    @Override
    public void visit(ASTRoot node) {
        if (node.getDeclarations()!=null) {
            for (var decl: node.getDeclarations()) {
                if (decl instanceof VarNode) {
                    if (((VarNode)decl).getSpecifier().getTypeSpecifier()
                            instanceof ClassSpecifierNode ) {
                        ClassSpecifierNode csp = (ClassSpecifierNode)
                                ((VarNode)decl).getSpecifier().getTypeSpecifier();
                        if (csp.hasConstructor()) {
                            for (var c: csp.getConstructors())
                                c.addModularFunction(module, astTypeTable);
                        }
                        if (csp.getMethods()!=null) {
                            for (var m: csp.getMethods())
                                m.addModularFunction(module, astTypeTable);
                        }
                    }
                }
            }
            for (var decl: node.getDeclarations()) {
                if (decl instanceof FuncNode)
                    ((FuncNode) decl).addModularFunction(module, astTypeTable);
            }
            curFunc = initializer;
            curBlock = initializer.getEntranceBlock();
            for (var decl: node.getDeclarations()) {
                if (decl instanceof VarNode) decl.accept(this);
            }
            curBlock = initializer.getExitBlock();
            curFunc = initializer;
            curBlock.addInst(new Br(curBlock, null,
                    curFunc.getReturnBlock(), null));
            curFunc.addBlock(curFunc.getReturnBlock());
            for (var decl: node.getDeclarations()) {
                if (decl instanceof FuncNode) decl.accept(this);
            }
        }
    }

    /* expressions */

    @Override
    public void visit(ThisExprNode node) {
        Register ptrTmp = curFunc.getClassPtr();
        IRType type = ((PointerType)ptrTmp.getType()).getBaseType();
        Register dst = new Register(type, "this");
        curFunc.addSymbol(dst);
        curBlock.addInst(new Load(curBlock, dst, type, ptrTmp));

        node.setResult(dst);
    }

    @Override
    public void visit(BoolLiteralNode node) {
        node.setResult(new ConstBool(node.getValue()));
    }

    @Override
    public void visit(IntLiteralNode node) {
        node.setResult(new ConstInt(node.getValue(), 32));
    }

    @Override
    public void visit(StringLiteralNode node) {
        ConstString ptr = module.getConstStrByValue(node.getValue());
        String name;
        if (ptr==null) {
            name = "__const." + (curFunc==null ? "" : curFunc.getName())
                    + ".str" + module.getConstStrings().size();
            ptr = module.addConstString(node.getValue(), name);
        }
        else name = ptr.getName();
        Register dst = new Register(IRModule.stringT, name);
        ArrayList<Operand> index = new ArrayList<>();
        index.add(new ConstInt(0, 32));
        index.add(new ConstInt(0, 32));
        curBlock.addInst(new GetElementPtr(curBlock, dst, ptr, index));
        node.setResult(dst);
    }

    @Override
    public void visit(NullLiteralNode node) {
        node.setResult(new Null());
    }

    @Override
    public void visit(IdExprNode node) {
        Operand allocatedAddr = ((VarEntity)node.getEntity()).getAllocatedAddr();
        if (allocatedAddr!=null) {
            IRType type = ((PointerType)allocatedAddr.getType()).getBaseType();
            Register dst = new Register(type, node.getIdentifier());
            curFunc.addSymbol(dst);
            curBlock.addInst(new Load(curBlock, dst, type, allocatedAddr));

            node.setResult(dst);
            node.setAddr(allocatedAddr);
        }
        else {
            // load this
            Register classPtr = curFunc.getClassPtr();
            assert classPtr != null;
            IRType type = ((PointerType)classPtr.getType()).getBaseType();
            Register thisPtr = new Register(type, "this");
            curFunc.addSymbol(thisPtr);
            curBlock.addInst(new Load(curBlock, thisPtr, type, classPtr));

            // load this->id
            Type cType = node.getScope().getClassType();
            String name = node.getIdentifier();
            ArrayList<VarEntity> members = ((ClassType)cType).getMembers();
            int pos, it;
            for (pos = 0, it = members.size(); pos < it; ++pos) {
                if (members.get(pos).getName().equals(name)) break;
            }
            IRType irType = module.getIRType(astTypeTable.getType(members.get(pos).getSpecifier()));
            Register dst = new Register(new PointerType(irType), cType.getName()+"."+name+".addr");
            curFunc.addSymbol(dst);
            ArrayList<Operand> index = new ArrayList<>();
            index.add(new ConstInt(0, 32));
            index.add(new ConstInt(pos, 32));
            curBlock.addInst(new GetElementPtr(curBlock, dst, thisPtr, index));

            Register result = new Register(irType, cType.getName()+"."+name);
            curFunc.addSymbol(result);
            curBlock.addInst(new Load(curBlock, result, irType, dst));

            node.setResult(result);
            node.setAddr(dst);
        }
    }

    @Override
    public void visit(SubscriptExprNode node) {
        node.getName().accept(this);
        node.getIndex().accept(this);

        Operand ptr = node.getName().getResult();
        Register dst = new Register(ptr.getType(), "elementPtr");
        curFunc.addSymbol(dst);
        ArrayList<Operand> index = new ArrayList<>();
        index.add(node.getIndex().getResult());
        curBlock.addInst(new GetElementPtr(curBlock, dst, ptr, index));

        IRType type = ((PointerType)ptr.getType()).getBaseType();
        Register result = new Register(type, "arrayElement");
        curFunc.addSymbol(result);
        curBlock.addInst(new Load(curBlock, result, type, dst));

        node.setResult(result);
        node.setAddr(dst);
    }

    @Override
    public void visit(FuncCallExprNode node) {
        ExprNode funcName = node.getName();
        Function func;
        if (funcName instanceof MemberExprNode) { // method call
            ExprNode objectName = ((MemberExprNode)funcName).getObjectName();
            String methodName = ((MemberExprNode)funcName).getMemberName();
            Type objectType = objectName.getType();
            objectName.accept(this);
            Operand objectPtr = objectName.getResult();
            if (objectType instanceof ArrayType) {
                assert methodName.equals("size");
                Register dst = new Register(new PointerType(IRModule.int32T), "arrayElemPtr");
                curFunc.addSymbol(dst);
                Register ptr;
                if (objectPtr.getType().equals(new PointerType(IRModule.int32T))) {
                    ptr = (Register)objectPtr;
                }
                else {
                    ptr = new Register(new PointerType(IRModule.int32T), "castToIntPtr");
                    curFunc.addSymbol(ptr);
                    curBlock.addInst(new BitCast(curBlock, ptr, objectPtr,
                            new PointerType(IRModule.int32T)));
                }
                ArrayList<Operand> index = new ArrayList<>();
                index.add(new ConstInt(-1, 32));
                curBlock.addInst(new GetElementPtr(curBlock, dst, ptr, index));

                Register result = new Register(IRModule.int32T, "arraySize");
                curFunc.addSymbol(result);
                curBlock.addInst(new Load(curBlock, result, IRModule.int32T, dst));

                node.setResult(result);
            }
            else {
                if (objectType instanceof StringType)
                    func = module.getExternalFunction(methodName);
                else {
                    func = module.getFunction(node.getEntity().getName());
                }
                assert func!=null;
                IRType retType = func.getFunctionType().getReturnType();
                Register dst = pseudoReg;
                if (retType!=null && !(retType instanceof VoidType)) {
                    dst = new Register(retType, "funcCallRet");
                    curFunc.addSymbol(dst);
                }
                ArrayList<Operand> parameters = new ArrayList<>();
                parameters.add(objectPtr);
                if (node.getParameters()!=null) {
                    for (var p: node.getParameters()) {
                        p.accept(this);
                        parameters.add(p.getResult());
                    }
                }
                curBlock.addInst(new Call(curBlock, dst, func, parameters));

                node.setResult(dst);
            }
        }
        else {
            assert funcName instanceof IdExprNode;
            FunctionEntity funcEntity = (FunctionEntity) node.getEntity();
            func = module.getFunction(funcEntity.getName());
            assert func != null;
            IRType retType = func.getFunctionType().getReturnType();
            Register dst = pseudoReg;
            if (!(retType instanceof VoidType)) {
                dst = new Register(retType, "funcCallRet");
                curFunc.addSymbol(dst);
            }
            ArrayList<Operand> parameters = new ArrayList<>();
            if (funcEntity.getFuncEntityType()
                    != FunctionEntity.FuncEntityType.function) {
                Register ptrTmp = curFunc.getClassPtr();
                IRType type = ((PointerType)ptrTmp.getType()).getBaseType();
                Register ptrThis = new Register(type, "this");
                curFunc.addSymbol(ptrThis);
                curBlock.addInst(new Load(curBlock, ptrThis, type, ptrTmp));
                parameters.add(ptrThis);
            }
            if (node.getParameters()!=null) {
                for (var p: node.getParameters()) {
                    p.accept(this);
                    parameters.add(p.getResult());
                }
            }
            curBlock.addInst(new Call(curBlock, dst, func, parameters));

            node.setResult(dst);
        }
    }

    @Override
    public void visit(MemberExprNode node) {
        node.getObjectName().accept(this);
        Type objectType = node.getObjectName().getType();
        assert objectType instanceof ClassType;
        String memberName = node.getMemberName();

        Operand ptr = node.getObjectName().getResult();
        ArrayList<Operand> index = new ArrayList<>();
        index.add(new ConstInt(0, 32));
        ArrayList<VarEntity> members = ((ClassType)objectType).getMembers();
        int pos, sz = members.size();
        for (pos = 0; pos < sz; ++pos) {
            if (members.get(pos).getName().equals(memberName)) break;
        }
        index.add(new ConstInt(pos, 32));
        IRType irType = module.getIRType(
                astTypeTable.getType(members.get(pos).getSpecifier()) );
        Register dst = new Register(new PointerType(irType),
                objectType.getName() + "." + memberName + ".addr");
        curFunc.addSymbol(dst);
        curBlock.addInst(new GetElementPtr(curBlock, dst, ptr, index));

        Register result = new Register(irType,
                objectType.getName() + "." + memberName);
        curFunc.addSymbol(result);
        curBlock.addInst(new Load(curBlock, result, irType, dst));

        node.setResult(result);
        node.setAddr(dst);
    }

    @Override
    public void visit(PostfixExprNode node) {
        node.getSubExpr().accept(this);
        Operand value = node.getSubExpr().getResult();
        Operand addr = node.getSubExpr().getAddr();
        Register result = new Register(IRModule.int32T,
                "postfix_op" + node.getOperator());
        curFunc.addSymbol(result);
        curBlock.addInst(new BinaryOp(curBlock, result,
                node.getOperator().equals("++")
                        ? BinaryOp.BinaryOpName.add
                        : BinaryOp.BinaryOpName.sub,
                value, new ConstInt(1, 32)));
        curBlock.addInst(new Store(curBlock, result, addr));
        node.setResult(value);
    }

    @Override
    public void visit(PrefixExprNode node) {
        node.getSubExpr().accept(this);
        Operand value = node.getSubExpr().getResult();
        Operand addr;
        Register result = new Register(IRModule.int32T,
                "prefix_op" + node.getOperator());
        curFunc.addSymbol(result);
        switch (node.getOperator()) {
            case "++":  // ++x
                addr = node.getSubExpr().getAddr();
                curBlock.addInst(new BinaryOp(curBlock, result,
                        BinaryOp.BinaryOpName.add,
                        value, new ConstInt(1, 32)));
                curBlock.addInst(new Store(curBlock, result, addr));
                node.setResult(result);
                node.setAddr(addr);
                break;
            case "--":  // --x
                addr = node.getSubExpr().getAddr();
                curBlock.addInst(new BinaryOp(curBlock, result,
                        BinaryOp.BinaryOpName.sub,
                        value, new ConstInt(1, 32)));
                curBlock.addInst(new Store(curBlock, result, addr));
                node.setResult(result);
                node.setAddr(addr);
                break;
            case "+": // +x
                node.setResult(value);
                break;
            case "-": // -x
                curBlock.addInst(new BinaryOp(curBlock, result,
                        BinaryOp.BinaryOpName.sub,
                        new ConstInt(0, 32), value));
                node.setResult(result);
                break;
            case "~":  // ~x
                curBlock.addInst(new BinaryOp(curBlock, result,
                        BinaryOp.BinaryOpName.xor,
                        value, new ConstInt(-1, 32)));
                node.setResult(result);
                break;
            case "!": // !x
                result = new Register(IRModule.boolT, "prefix_op!");
                curBlock.addInst(new BinaryOp(curBlock, result,
                        BinaryOp.BinaryOpName.xor,
                        value, new ConstBool(true)));
                node.setResult(result);
            default:
        }
    }

    @Override
    public void visit(NewExprNode node) {
        if (node.getDimension()==0) { // class
            Type astType = astTypeTable.getType(node.getSpecifier());
            assert astType instanceof ClassType;

            // char* dst = malloc(sizeof(T));
            Register dst = new Register(IRModule.stringT, "malloc");
            curFunc.addSymbol(dst);
            Function func = module.getExternalFunction("malloc");
            int sz = module.getStructure("class."+astType.getName()).size();
            ArrayList<Operand> parameters = new ArrayList<>();
            parameters.add(new ConstInt(sz, 32));
            curBlock.addInst(new Call(curBlock, dst, func, parameters));

            // T cast = *((T*)dst);
            IRType irType = module.getIRType(astType);
            Register cast = new Register(irType, "castToClassPtr");
            curFunc.addSymbol(cast);
            curBlock.addInst(new BitCast(curBlock, cast, dst, irType));

            if (((ClassType)astType).hasConstructor()) {
                String decoratedName = ((ClassType)astType).getDefaultConstructor().getName();
                func = module.getFunction(decoratedName);
                assert func != null;
                parameters = new ArrayList<>();
                parameters.add(cast);
                curBlock.addInst(new Call(curBlock, pseudoReg, func, parameters));
            }

            node.setResult(cast);
        }
        else { // array
            ArrayList<ExprNode> newIndexList = node.getIndexes();
            IRType irType = module.getIRType(
                    astTypeTable.getType(node.getSpecifier()) );
            for (int i = 0, it = newIndexList.size(); i < it; ++i) {
                irType = new PointerType(irType);
            }
            ArrayList<Operand> newIndexes = new ArrayList<>();
            for (var i: newIndexList) {
                i.accept(this);
                newIndexes.add(i.getResult());
            }
            Operand dst = arrayMalloc(0, newIndexes, irType);
            node.setResult(dst);
        }
    }
    private Operand arrayMalloc(int dim, ArrayList<Operand> indexes, IRType irType) {
        if (indexes.get(dim) instanceof Null) return new Null();
        /* to malloc an array of 4-byte array size at head,
         * followed by the elements of the array
         */

        // char* dst = malloc(4 + sizeof(T) * arraySize);
        Register dst = new Register(IRModule.stringT, "malloc");
        curFunc.addSymbol(dst);
        Function func = module.getExternalFunction("malloc");
        ArrayList<Operand> parameters = new ArrayList<>();
        int elementSize = ((PointerType)irType).getBaseType().size();
        Register sizeTmp = new Register(IRModule.int32T, "sizeTmp");
        curFunc.addSymbol(sizeTmp);
        curBlock.addInst(new BinaryOp(curBlock, sizeTmp, BinaryOp.BinaryOpName.mul,
                indexes.get(dim), new ConstInt(elementSize, 32)));

        Register size = new Register(IRModule.int32T, "size");
        curFunc.addSymbol(size);
        curBlock.addInst(new BinaryOp(curBlock, size, BinaryOp.BinaryOpName.add,
                sizeTmp, new ConstInt(4, 32)));

        parameters.add(size);
        curBlock.addInst(new Call(curBlock, dst, func, parameters));

        // store arraySize ((int*)dst);
        Register castPtr = new Register(new PointerType(IRModule.int32T), "mallocInt32Ptr");
        curFunc.addSymbol(castPtr);
        curBlock.addInst(new BitCast(curBlock, castPtr, dst, new PointerType(IRModule.int32T)));
        curBlock.addInst(new Store(curBlock, indexes.get(dim), castPtr));

        // T* arrayHead = (T*) &((int*) dst)[1];
        Register arrayHeadPtrUnguarded = new Register(
                new PointerType(IRModule.int32T), "arrayHeadPtrUnguarded");
        curFunc.addSymbol(arrayHeadPtrUnguarded);
        ArrayList<Operand> index = new ArrayList<>();
        index.add(new ConstInt(1, 32));
        curBlock.addInst(new GetElementPtr(curBlock, arrayHeadPtrUnguarded, castPtr, index));

        Register arrayHeadPtr = new Register(irType, "arrayHeadPtr");
        curFunc.addSymbol(arrayHeadPtr);
        curBlock.addInst(new BitCast(curBlock, arrayHeadPtr, arrayHeadPtrUnguarded, irType));

        if ((dim < indexes.size()-1)
                && !(indexes.get(dim+1) instanceof Null)) {
            /* to malloc the lower dimensions
             * at the tail of the high-dimension array
             */

            // T* arrayTail = &arrayHead[arraySize];
            Register arrayTailPtr = new Register(irType, "arrayTailPtr");
            curFunc.addSymbol(arrayTailPtr);
            index = new ArrayList<>();
            index.add(indexes.get(dim));
            curBlock.addInst(new GetElementPtr(curBlock, arrayTailPtr, arrayHeadPtr, index));

            // store arrayHead somewhere;
            Register ptrTmp = new Register(new PointerType(irType), "ptrIntoArray");
            curFunc.addSymbol(ptrTmp);
            curFunc.getEntranceBlock().addInstAtHead(new Alloca(
                    curFunc.getEntranceBlock(), ptrTmp, irType) );
            curBlock.addInst(new Store(curBlock, arrayHeadPtr, ptrTmp));

            // iteratively malloc lower dimensions
            IRBlock arrMallocIteCond = new IRBlock("arrMallocIteCond");
            IRBlock arrMallocIteBody = new IRBlock("arrMallocIteBody");
            IRBlock arrMallocIteEnd = new IRBlock("arrMallocIteEnd");
            curBlock.addInst(new Br(curBlock, null, arrMallocIteCond, null));

            // iteration
            curBlock = arrMallocIteCond;
            curFunc.addBlock(arrMallocIteCond);
            // -- condition
            Register arrayPtrIte = new Register(irType, "arrayPtrIte");
            curFunc.addSymbol(arrayPtrIte);
            curBlock.addInst(new Load(curBlock, arrayPtrIte, irType, ptrTmp));

            Register cmpTmp = new Register(IRModule.boolT, "iteCmpTmp");
            curFunc.addSymbol(cmpTmp);
            curBlock.addInst(new Icmp(curBlock, cmpTmp, Icmp.IcmpOpName.slt,
                    irType, arrayPtrIte, arrayTailPtr));
            curBlock.addInst(new Br(curBlock, cmpTmp, arrMallocIteBody, arrMallocIteEnd));
            // -- body
            curBlock = arrMallocIteBody;
            curFunc.addBlock(arrMallocIteBody);
            Operand arrElem = arrayMalloc(
                    dim+1, indexes, ((PointerType)irType).getBaseType() );
            curBlock.addInst(new Store(curBlock, arrElem, arrayPtrIte));

            Register nextElemPtr = new Register(irType, "nextElemPtr");
            curFunc.addSymbol(nextElemPtr);
            index = new ArrayList<>();
            index.add(new ConstInt(1, 32));
            curBlock.addInst(new GetElementPtr(curBlock, nextElemPtr, arrayPtrIte, index));
            curBlock.addInst(new Store(curBlock, nextElemPtr, ptrTmp));
            curBlock.addInst(new Br(curBlock, null, arrMallocIteCond, null));
            // -- end
            curBlock = arrMallocIteEnd;
            curFunc.addBlock(arrMallocIteEnd);
        }

        return arrayHeadPtr;
    }

    @Override
    public void visit(MultiplicativeExprNode node) {
        ArrayList<ExprNode> factors = node.getSubExpressions();
        factors.get(0).accept(this);
        Operand value = factors.get(0).getResult();
        if (factors.size() > 1) {
            ArrayList<String> ops = node.getOps();
            BinaryOp.BinaryOpName opName;

            factors.get(1).accept(this);
            Operand valueE = factors.get(1).getResult();
            switch (ops.get(0)) {
                case "*":   opName = BinaryOp.BinaryOpName.mul;break;
                case "/":   opName = BinaryOp.BinaryOpName.sdiv;break;
                default:    opName = BinaryOp.BinaryOpName.srem;
            }
            Register mul = new Register(IRModule.int32T, opName.toString());
            curFunc.addSymbol(mul);
            curBlock.addInst(new BinaryOp(curBlock, mul, opName, value, valueE));

            if (ops.size() > 1) {
                Register mulE;
                for (int i = 1, it = ops.size(); i < it; ++i) {
                    factors.get(i+1).accept(this);
                    valueE = factors.get(i+1).getResult();
                    switch (ops.get(i)) {
                        case "*":   opName = BinaryOp.BinaryOpName.mul;break;
                        case "/":   opName = BinaryOp.BinaryOpName.sdiv;break;
                        default:    opName = BinaryOp.BinaryOpName.srem;
                    }
                    mulE = new Register(IRModule.int32T, opName.toString()+(i+1));
                    curFunc.addSymbol(mulE);
                    curBlock.addInst(new BinaryOp(curBlock, mulE, opName, mul, valueE));
                    mul = mulE;
                }
            }
            node.setResult(mul);
        }
        else {
            node.setResult(value);
            node.setAddr(factors.get(0).getAddr());
        }
    }

    @Override
    public void visit(AdditiveExprNode node) {
        ArrayList<MultiplicativeExprNode> terms = node.getSubExpressions();
        terms.get(0).accept(this);
        Operand value = terms.get(0).getResult();
        if (terms.size() > 1) {
            ArrayList<String> ops = node.getOps();

            terms.get(1).accept(this);
            Operand valueE = terms.get(1).getResult();
            Register add;
            if (terms.get(0).getType() instanceof IntType) {
                BinaryOp.BinaryOpName opName = ops.get(0).equals("+")
                        ? BinaryOp.BinaryOpName.add
                        : BinaryOp.BinaryOpName.sub;
                add = new Register(IRModule.int32T, opName.toString());
                curFunc.addSymbol(add);
                curBlock.addInst(new BinaryOp(curBlock, add, opName, value, valueE));

                if (ops.size() > 1) {
                    Register addE;
                    for (int i = 1, it = ops.size(); i < it; ++i) {
                        terms.get(i+1).accept(this);
                        valueE = terms.get(i+1).getResult();
                        opName = ops.get(i).equals("+")
                                ? BinaryOp.BinaryOpName.add
                                : BinaryOp.BinaryOpName.sub;
                        addE = new Register(IRModule.int32T, opName.toString()+(i+1));
                        curFunc.addSymbol(addE);
                        curBlock.addInst(new BinaryOp(curBlock, addE, opName, add, valueE));
                        add = addE;
                    }
                }
            }
            else { // string concatenation
                add = new Register(IRModule.stringT, "add");
                curFunc.addSymbol(add);
                Function func = module.getExternalFunction("strcat");
                ArrayList<Operand> parameters = new ArrayList<>();
                parameters.add(value);
                parameters.add(valueE);
                curBlock.addInst(new Call(curBlock, add, func, parameters));

                if (ops.size() > 1) {
                    Register addE;
                    for (int i = 1, it = ops.size(); i < it; ++i) {
                        terms.get(i+1).accept(this);
                        valueE = terms.get(i+1).getResult();
                        addE = new Register(IRModule.stringT, "add"+(i+1));
                        curFunc.addSymbol(addE);
                        parameters.clear();
                        parameters.add(add);
                        parameters.add(valueE);
                        curBlock.addInst(new Call(curBlock, addE, func, parameters));
                        add = addE;
                    }
                }
            }
            node.setResult(add);
        }
        else {
            node.setResult(value);
            node.setAddr(terms.get(0).getAddr());
        }
    }

    @Override
    public void visit(ShiftExprNode node) {
        ArrayList<AdditiveExprNode> terms = node.getSubExpressions();
        terms.get(0).accept(this);
        Operand value = terms.get(0).getResult();
        if (terms.size() > 1) {
            ArrayList<String> ops = node.getOps();
            BinaryOp.BinaryOpName opName;

            terms.get(1).accept(this);
            Operand valueE = terms.get(1).getResult();
            opName = ops.get(0).equals(">>")
                    ? BinaryOp.BinaryOpName.ashr
                    : BinaryOp.BinaryOpName.shl;
            Register shift = new Register(IRModule.int32T, opName.toString());
            curFunc.addSymbol(shift);
            curBlock.addInst(new BinaryOp(curBlock, shift, opName, value, valueE));

            if (ops.size() > 1) {
                Register shiftE;
                for (int i = 1, it = ops.size(); i < it; ++i) {
                    terms.get(i+1).accept(this);
                    valueE = terms.get(i+1).getResult();
                    opName = ops.get(i).equals(">>")
                            ? BinaryOp.BinaryOpName.ashr
                            : BinaryOp.BinaryOpName.shl;
                    shiftE = new Register(IRModule.int32T, opName.toString()+(i+1));
                    curFunc.addSymbol(shiftE);
                    curBlock.addInst(new BinaryOp(curBlock, shiftE, opName, shift, valueE));
                    shift = shiftE;
                }
            }
            node.setResult(shift);
        }
        else {
            node.setResult(value);
            node.setAddr(terms.get(0).getAddr());
        }
    }

    @Override
    public void visit(RelationalExprNode node) {
        ArrayList<ShiftExprNode> ariths = node.getSubExpressions();
        ariths.get(0).accept(this);
        Operand value = ariths.get(0).getResult();
        if (ariths.size() > 1) {
            ArrayList<String> ops = node.getOps();
            assert ops.size()==1;

            ariths.get(1).accept(this);
            Operand valueE = ariths.get(1).getResult();
            Register cmp;
            if (ariths.get(0).getType() instanceof IntType) {
                Icmp.IcmpOpName opName;
                switch (ops.get(0)) {
                    case "<":   opName = Icmp.IcmpOpName.slt;break;
                    case ">":   opName = Icmp.IcmpOpName.sgt;break;
                    case "<=":  opName = Icmp.IcmpOpName.sle;break;
                    default:    opName = Icmp.IcmpOpName.sge;
                }
                cmp = new Register(IRModule.boolT, opName.toString());
                curFunc.addSymbol(cmp);
                curBlock.addInst(new Icmp(curBlock, cmp, opName,
                        IRModule.int32T, value, valueE));
            }
            else { // string comparison
                cmp = new Register(IRModule.boolT, "strcmp");
                curFunc.addSymbol(cmp);
                String funcName;
                switch (ops.get(0)) {
                    case "<":   funcName = "strcmp_lt";break;
                    case ">":   funcName = "strcmp_gt";break;
                    case "<=":  funcName = "strcmp_le";break;
                    default:    funcName = "strcmp_ge";
                }
                Function func = module.getExternalFunction(funcName);
                ArrayList<Operand> parameters = new ArrayList<>();
                parameters.add(value);
                parameters.add(valueE);
                curBlock.addInst(new Call(curBlock, cmp, func, parameters));
            }
            node.setResult(cmp);
        }
        else {
            node.setResult(value);
            node.setAddr(ariths.get(0).getAddr());
        }
    }

    @Override
    public void visit(EqualityExprNode node) {
        ArrayList<RelationalExprNode> ariths = node.getSubExpressions();
        ariths.get(0).accept(this);
        Operand value = ariths.get(0).getResult();
        if (ariths.size() > 1) {
            ArrayList<String> ops = node.getOps();

            ariths.get(1).accept(this);
            Operand valueE = ariths.get(1).getResult();
            Register cmp;
            if (ariths.get(0).getType() instanceof BoolType) {
                Icmp.IcmpOpName opName = ops.get(0).equals("==")
                        ? Icmp.IcmpOpName.eq
                        : Icmp.IcmpOpName.ne;
                cmp = new Register(IRModule.boolT, opName.toString());
                curFunc.addSymbol(cmp);
                curBlock.addInst(new Icmp(curBlock, cmp, opName,
                        IRModule.boolT, value, valueE));

                if (ops.size() > 1) {
                    Register cmpE;
                    for (int i = 1, it = ops.size(); i < it; ++i) {
                        ariths.get(i+1).accept(this);
                        valueE = ariths.get(i+1).getResult();
                        opName = ops.get(i).equals("==")
                                ? Icmp.IcmpOpName.eq
                                : Icmp.IcmpOpName.ne;
                        cmpE = new Register(IRModule.boolT, opName.toString()+(i+1));
                        curFunc.addSymbol(cmpE);
                        curBlock.addInst(new Icmp(curBlock, cmpE, opName,
                                IRModule.boolT, cmp, valueE));
                        cmp = cmpE;
                    }
                }
                node.setResult(cmp);
            }
            else {
                assert ops.size() == 1;
                if (ariths.get(0).getType() instanceof StringType) {
                    cmp = new Register(IRModule.boolT, "strcmp");
                    curFunc.addSymbol(cmp);
                    String funcName = ops.get(0).equals("==") ? "strcmp_eq" : "strcmp_neq";
                    Function func = module.getExternalFunction(funcName);
                    ArrayList<Operand> parameters = new ArrayList<>();
                    parameters.add(value);
                    parameters.add(valueE);
                    curBlock.addInst(new Call(curBlock, cmp, func, parameters));
                    node.setResult(cmp);
                }
                else {
                    Icmp.IcmpOpName opName = ops.get(0).equals("==")
                            ? Icmp.IcmpOpName.eq
                            : Icmp.IcmpOpName.ne;
                    cmp = new Register(IRModule.boolT, opName.toString());
                    curFunc.addSymbol(cmp);
                    if (ariths.get(0).getType() instanceof IntType) {
                        curBlock.addInst(new Icmp(curBlock, cmp, opName,
                                IRModule.int32T, value, valueE));
                        node.setResult(cmp);
                    }
                    else if (ariths.get(0).getType() instanceof NullType) {
                        if (ariths.get(1).getType() instanceof NullType) {
                            node.setResult(new ConstBool(true));
                        }
                        else { // null cmp array/class
                            curBlock.addInst(new Icmp(curBlock, cmp, opName,
                                    valueE.getType(), value, valueE));
                            node.setResult(cmp);
                        }
                    }
                    else { // array/class cmp null
                        curBlock.addInst(new Icmp(curBlock, cmp, opName,
                                value.getType(), value, valueE));
                        node.setResult(cmp);
                    }
                }
            }
        }
        else {
            node.setResult(value);
            node.setAddr(ariths.get(0).getAddr());
        }
    }

    @Override
    public void visit(AndExprNode node) {
        ArrayList<EqualityExprNode> tests = node.getSubExpressions();
        tests.get(0).accept(this);
        Operand value = tests.get(0).getResult();
        if (tests.size() > 1) {
            tests.get(1).accept(this);
            Operand valueE = tests.get(1).getResult();
            Register tst = new Register(IRModule.int32T, "bitwise_and");
            curFunc.addSymbol(tst);
            curBlock.addInst(new BinaryOp(curBlock, tst,
                    BinaryOp.BinaryOpName.and, value, valueE));

            if (node.getOpNum() > 1) {
                Register tstE;
                for (int i = 2, it = node.getOpNum(); i <= it; ++i) {
                    tests.get(i).accept(this);
                    valueE = tests.get(i).getResult();
                    tstE = new Register(IRModule.int32T, "bitwise_and"+i);
                    curFunc.addSymbol(tstE);
                    curBlock.addInst(new BinaryOp(curBlock, tstE,
                            BinaryOp.BinaryOpName.and, tst, valueE));
                    tst = tstE;
                }
            }
            node.setResult(tst);
        }
        else {
            node.setResult(value);
            node.setAddr(tests.get(0).getAddr());
        }
    }

    @Override
    public void visit(ExclusiveOrExprNode node) {
        ArrayList<AndExprNode> tests = node.getSubExpressions();
        tests.get(0).accept(this);
        Operand value = tests.get(0).getResult();
        if (tests.size() > 1) {
            tests.get(1).accept(this);
            Operand valueE = tests.get(1).getResult();
            Register tst = new Register(IRModule.int32T, "xor");
            curFunc.addSymbol(tst);
            curBlock.addInst(new BinaryOp(curBlock, tst,
                    BinaryOp.BinaryOpName.xor, value, valueE));

            if (node.getOpNum() > 1) {
                Register tstE;
                for (int i = 2, it = node.getOpNum(); i <= it; ++i) {
                    tests.get(i).accept(this);
                    valueE = tests.get(i).getResult();
                    tstE = new Register(IRModule.int32T, "xor"+i);
                    curFunc.addSymbol(tstE);
                    curBlock.addInst(new BinaryOp(curBlock, tstE,
                            BinaryOp.BinaryOpName.xor, tst, valueE));
                    tst = tstE;
                }
            }
            node.setResult(tst);
        }
        else {
            node.setResult(value);
            node.setAddr(tests.get(0).getAddr());
        }
    }

    @Override
    public void visit(InclusiveOrExprNode node) {
        ArrayList<ExclusiveOrExprNode> tests = node.getSubExpressions();
        tests.get(0).accept(this);
        Operand value = tests.get(0).getResult();
        if (tests.size() > 1) {
            tests.get(1).accept(this);
            Operand valueE = tests.get(1).getResult();
            Register tst = new Register(IRModule.int32T, "bitwise_or");
            curFunc.addSymbol(tst);
            curBlock.addInst(new BinaryOp(curBlock, tst,
                    BinaryOp.BinaryOpName.or, value, valueE));

            if (node.getOpNum() > 1) {
                Register tstE;
                for (int i = 2, it = node.getOpNum(); i <= it; ++i) {
                    tests.get(i).accept(this);
                    valueE = tests.get(i).getResult();
                    tstE = new Register(IRModule.int32T, "bitwise_or"+i);
                    curFunc.addSymbol(tstE);
                    curBlock.addInst(new BinaryOp(curBlock, tstE,
                            BinaryOp.BinaryOpName.or, tst, valueE));
                    tst = tstE;
                }
            }
            node.setResult(tst);
        }
        else {
            node.setResult(value);
            node.setAddr(tests.get(0).getAddr());
        }
    }

    @Override
    public void visit(LogicalAndExprNode node) {
        ArrayList<InclusiveOrExprNode> tests = node.getSubExpressions();
        tests.get(0).accept(this);
        Operand value = tests.get(0).getResult();

        if (tests.size() > 1) {
            ArrayList<Operand> values = new ArrayList<>();
            ArrayList<IRBlock> blocks = new ArrayList<>();
            values.add(new ConstBool(false));
            blocks.add(curBlock);

            IRBlock branchBlock = new IRBlock("logicalAnd_branch");
            IRBlock endBlock = new IRBlock("logicalAnd_end");
            curBlock.addInst(new Br(curBlock, value, branchBlock, endBlock));

            curBlock = branchBlock;
            tests.get(1).accept(this);
            Operand valueE = tests.get(1).getResult();
            values.add(valueE);
            blocks.add(curBlock);
            curFunc.addBlock(branchBlock);

            int opNum = node.getOpNum();
            if (opNum > 1) {
                for (int i = 2; i <= opNum; ++i) {
                    branchBlock = new IRBlock("logicalAnd_branch"+i);
                    curBlock.addInst(new Br(curBlock, valueE, branchBlock, endBlock));

                    curBlock = branchBlock;
                    tests.get(i).accept(this);
                    valueE = tests.get(i).getResult();
                    values.add(valueE);
                    blocks.add(curBlock);
                    curFunc.addBlock(branchBlock);
                }
            }
            curBlock.addInst(new Br(curBlock, null, endBlock, null));

            curBlock = endBlock;
            Register dst = new Register(IRModule.boolT, "logical_and");
            curFunc.addSymbol(dst);
            curBlock.addInst(new Phi(curBlock, dst, values, blocks));
            curFunc.addBlock(endBlock);
            node.setResult(dst);
        }
        else {
            node.setResult(value);
            node.setAddr(tests.get(0).getAddr());
        }
    }

    @Override
    public void visit(LogicalOrExprNode node) {
        ArrayList<LogicalAndExprNode> tests = node.getSubExpressions();
        tests.get(0).accept(this);
        Operand value = tests.get(0).getResult();

        if (tests.size() > 1) {
            ArrayList<Operand> values = new ArrayList<>();
            ArrayList<IRBlock> blocks = new ArrayList<>();
            values.add(new ConstBool(false));
            blocks.add(curBlock);

            IRBlock branchBlock = new IRBlock("logicalOr_branch");
            IRBlock endBlock = new IRBlock("logicalOr_end");
            curBlock.addInst(new Br(curBlock, value, branchBlock, endBlock));

            curBlock = branchBlock;
            tests.get(1).accept(this);
            Operand valueE = tests.get(1).getResult();
            values.add(valueE);
            blocks.add(curBlock);
            curFunc.addBlock(branchBlock);

            int opNum = node.getOpNum();
            if (opNum > 1) {
                for (int i = 2; i <= opNum; ++i) {
                    branchBlock = new IRBlock("logicalOr_branch"+i);
                    curBlock.addInst(new Br(curBlock, valueE, branchBlock, endBlock));

                    curBlock = branchBlock;
                    tests.get(i).accept(this);
                    valueE = tests.get(i).getResult();
                    values.add(valueE);
                    blocks.add(curBlock);
                    curFunc.addBlock(branchBlock);
                }
            }
            curBlock.addInst(new Br(curBlock, null, endBlock, null));

            curBlock = endBlock;
            Register dst = new Register(IRModule.boolT, "logical_or");
            curFunc.addSymbol(dst);
            curBlock.addInst(new Phi(curBlock, dst, values, blocks));
            curFunc.addBlock(endBlock);
            node.setResult(dst);
        }
        else {
            node.setResult(value);
            node.setAddr(tests.get(0).getAddr());
        }
    }

    @Override
    public void visit(ConditionalExprNode node) {
        if (node.getConditionExpr()!=null) {
            node.getConditionExpr().accept(this);
            node.setResult(node.getConditionExpr().getResult());
            node.setAddr(node.getConditionExpr().getAddr());
        }
        else node.setResult(new Null());
    }

    @Override
    public void visit(AssignmentExprNode node) {
        node.getLhs().accept(this);
        node.getRhs().accept(this);
        Operand lValue = node.getLhs().getResult();
        Operand lAddr = node.getLhs().getAddr();
        Operand rValue = node.getRhs().getResult();

        Register tmp;
        switch (node.getOperator()) {
            case "=": lValue = rValue;break;
            case "*=": {
                tmp = new Register(IRModule.int32T, "mul");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.mul, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "/=": {
                tmp = new Register(IRModule.int32T, "sdiv");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.sdiv, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "%=": {
                tmp = new Register(IRModule.int32T, "srem");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.srem, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "+=": {
                if (node.getLhs().getType() instanceof IntType) {
                    tmp = new Register(IRModule.int32T, "add");
                    curBlock.addInst(new BinaryOp(curBlock, tmp,
                            BinaryOp.BinaryOpName.add, lValue, rValue));
                }
                else {
                    tmp = new Register(IRModule.stringT, "add");
                    Function func = module.getExternalFunction("strcat");
                    ArrayList<Operand> parameters = new ArrayList<>();
                    parameters.add(lValue);
                    parameters.add(rValue);
                    curBlock.addInst(new Call(curBlock, tmp, func, parameters));
                }
                curFunc.addSymbol(tmp);
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "-=": {
                tmp = new Register(IRModule.int32T, "sub");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.sub, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case ">>=": {
                tmp = new Register(IRModule.int32T, "ashr");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.ashr, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "<<=": {
                tmp = new Register(IRModule.int32T, "shl");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.shl, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "&=": {
                tmp = new Register(IRModule.int32T, "bitwise_and");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.and, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            case "^=": {
                tmp = new Register(IRModule.int32T, "xor");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.xor, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
            default: { // "|="
                tmp = new Register(IRModule.int32T, "bitwise_or");
                curFunc.addSymbol(tmp);
                curBlock.addInst(new BinaryOp(curBlock, tmp,
                        BinaryOp.BinaryOpName.or, lValue, rValue));
                node.getLhs().setResult(tmp);
                lValue = tmp;
                break;
            }
        }

        curBlock.addInst(new Store(curBlock, lValue, lAddr));
        node.setResult(lValue);
    }

    @Override
    public void visit(ExprSeqNode node) {
        for (var exp: node.getSubExpressions())
            exp.accept(this);
    }

    /* statements */

    @Override
    public void visit(ExprStmtNode node) {
        if (node.getExpr()!=null)
            node.getExpr().accept(this);
    }

    @Override
    public void visit(CompoundStmtNode node) {
        if (node.getStatements()!=null) {
            for (var stmt : node.getStatements())
                stmt.accept(this);
        }
    }

    @Override
    public void visit(IfStmtNode node) {
        IRBlock thenBlock = new IRBlock("if.then");
        IRBlock elseBlock = node.hasElseBody() ? new IRBlock("if.else") : null;
        IRBlock endBlock = new IRBlock("if.end");

        node.getCondition().accept(this);
        Operand conditionResult = node.getCondition().getResult();
        if (node.hasElseBody())
            curBlock.addInst(new Br(curBlock, conditionResult, thenBlock, elseBlock));
        else
            curBlock.addInst(new Br(curBlock, conditionResult, thenBlock, endBlock));

        curBlock = thenBlock;
        node.getThenBody().accept(this);
        curBlock.addInst(new Br(curBlock, null, endBlock, null));
        curFunc.addBlock(thenBlock);

        if (node.hasElseBody()) {
            curBlock = elseBlock;
            node.getElseBody().accept(this);
            curBlock.addInst(new Br(curBlock, null, endBlock, null));
            curFunc.addBlock(elseBlock);
        }
        curBlock = endBlock;
        curFunc.addBlock(endBlock);
    }

    @Override
    public void visit(WhileStmtNode node) {
        IRBlock condBlock = new IRBlock("while.cond");
        IRBlock bodyBlock = new IRBlock("while.body");
        IRBlock endBlock = new IRBlock("while.end");
        node.setCondBlock(condBlock);
        node.setEndBlock(endBlock);
        curBlock.addInst(new Br(curBlock, null, condBlock, null));

        curBlock = condBlock;
        node.getCondition().accept(this);
        Operand conditionResult = node.getCondition().getResult();
        curBlock.addInst(new Br(curBlock, conditionResult, bodyBlock, endBlock));
        curFunc.addBlock(condBlock);

        curBlock = bodyBlock;
        node.getLoopBody().accept(this);
        curBlock.addInst(new Br(curBlock, null, condBlock, null));
        curFunc.addBlock(bodyBlock);

        curBlock = endBlock;
        curFunc.addBlock(endBlock);
    }

    @Override
    public void visit(ForStmtNode node) {
        IRBlock condBlock = new IRBlock("for.cond");
        IRBlock bodyBlock = new IRBlock("for.body");
        IRBlock incBlock = new IRBlock("for.inc");
        IRBlock endBlock = new IRBlock("for.end");
        node.setCondBlock(condBlock);
        node.setIncBlock(incBlock);
        node.setEndBlock(endBlock);

        if (node.hasInit()) node.getForInitStmt().accept(this);
        if (node.hasCondition()) {
            curBlock.addInst(new Br(curBlock, null, condBlock, null));

            curBlock = condBlock;
            node.getCondition().accept(this);
            Operand conditionResult = node.getCondition().getResult();
            curBlock.addInst(new Br(curBlock, conditionResult, bodyBlock, endBlock));
            curFunc.addBlock(condBlock);

            curBlock = bodyBlock;
            node.getLoopBody().accept(this);
            if (node.hasStepExpr())
                curBlock.addInst(new Br(curBlock, null, incBlock, null));
            else
                curBlock.addInst(new Br(curBlock, null, condBlock, null));
            curFunc.addBlock(bodyBlock);

            if (node.hasStepExpr()) {
                curBlock = incBlock;
                node.getStepExpr().accept(this);
                curBlock.addInst(new Br(curBlock, null, condBlock, null));
                curFunc.addBlock(incBlock);
            }
        }
        else {
            curBlock.addInst(new Br(curBlock, null, bodyBlock, null));

            curBlock = bodyBlock;
            node.getLoopBody().accept(this);
            if (node.hasStepExpr())
                curBlock.addInst(new Br(curBlock, null, incBlock, null));
            else
                curBlock.addInst(new Br(curBlock, null, bodyBlock, null));
            curFunc.addBlock(bodyBlock);

            if (node.hasStepExpr()) {
                curBlock = incBlock;
                node.getStepExpr().accept(this);
                curBlock.addInst(new Br(curBlock, null, bodyBlock, null));
                curFunc.addBlock(incBlock);
            }
        }

        curBlock = endBlock;
        curFunc.addBlock(endBlock);
    }

    @Override
    public void visit(BreakStmtNode node) {
        IRBlock endBlock = null;
        if (node.getDst() instanceof WhileStmtNode)
            endBlock = ((WhileStmtNode)node.getDst()).getEndBlock();
        else if (node.getDst() instanceof ForStmtNode)
            endBlock = ((ForStmtNode)node.getDst()).getEndBlock();
        curBlock.addInst(new Br(curBlock, null, endBlock, null));
    }

    @Override
    public void visit(ContinueStmtNode node) {
        IRBlock dstBlock = null;
        if (node.getDst() instanceof WhileStmtNode)
            dstBlock = ((WhileStmtNode)node.getDst()).getCondBlock();
        else if (node.getDst() instanceof ForStmtNode) {
            ForStmtNode forStmt = (ForStmtNode) node.getDst();
            if (forStmt.hasStepExpr())
                dstBlock = forStmt.getIncBlock();
            else if (forStmt.hasCondition())
                dstBlock = forStmt.getCondBlock();
            else
                dstBlock = forStmt.getEndBlock();
        }
        curBlock.addInst(new Br(curBlock, null, dstBlock, null));
    }

    @Override
    public void visit(ReturnStmtNode node) {
        if (node.hasReturnValue()) {
            node.getReturnValue().accept(this);
            Operand ret = node.getReturnValue().getResult();
            curBlock.addInst(new Store(curBlock, ret, curFunc.getRetVal()));
        }
        curBlock.addInst(new Br(curBlock, null,
                curFunc.getReturnBlock(), null));
    }

    @Override
    public void visit(DeclarationStmtNode node) {
        if (node.getVarNodes()!=null) {
            for (var decl : node.getVarNodes())
                decl.accept(this);
        }
    }

    /* specifiers */

    @Override
    public void visit(DeclSpecifierSeqNode node) {
        node.getTypeSpecifier().accept(this);
    }

    @Override
    public void visit(NonTypeSpecifierNode node) {}

    @Override
    public void visit(ClassSpecifierNode node) {
        if (node.getMembers()!=null) {
            for (var mem: node.getMembers())
                mem.accept(this);
        }
        if (node.hasConstructor()) {
            for (var constructor: node.getConstructors()) {
                if (module.hasNoFunction(constructor.getDecoratedName()))
                    constructor.addModularFunction(module, astTypeTable);
            }
        }
        if (node.getMethods()!=null) {
            for (var method: node.getMethods()) {
                if (module.hasNoFunction(method.getDecoratedName()))
                    method.addModularFunction(module, astTypeTable);
            }
        }
        if (node.hasConstructor()) {
            for (var constructor: node.getConstructors()) {
                constructor.accept(this);
            }
        }
        if (node.getMethods()!=null) {
            for (var method: node.getMethods()) {
                method.accept(this);
            }
        }
    }

    @Override
    public void visit(ArrayTypeSpecifierNode node) {}

    @Override
    public void visit(BuiltInTypeSpecifierNode node) {}

    @Override
    public void visit(ClassTypeSpecifierNode node) {}

    /* declaration */

    @Override
    public void visit(VarNode node) {
        node.getSpecifier().accept(this);
        if (node.getName()!=null) {
            Type astType = astTypeTable.getType(node.getSpecifier());
            IRType irType = module.getIRType(astType);
            String name = node.getName();
            VarEntity varEntity = node.getScope().getVarEntity(name);
            if (node.getScope()==globalScope) {
                GlobalVariable globalVar
                        = new GlobalVariable(new PointerType(irType), name);
                varEntity.setAllocatedAddr(globalVar);
                module.addGlobalVariable(globalVar);
                if (node.hasInitializer()) {
                    node.getInitializer().accept(this);
                    Operand init = node.getInitializer().getResult();
                    curBlock.addInst(new Store(curBlock, init, globalVar));
                }
            }
            else {
                Register ptrTmp = new Register(new PointerType(irType), name + ".addr");
                curFunc.addSymbol(ptrTmp);
                varEntity.setAllocatedAddr(ptrTmp);
                IRBlock entranceBlock = curFunc.getEntranceBlock();
                entranceBlock.addInstAtHead(new Alloca(entranceBlock, ptrTmp, irType));
                if (node.hasInitializer()) {
                    node.getInitializer().accept(this);
                    Operand init = node.getInitializer().getResult();
                    curBlock.addInst(new Store(curBlock, init, ptrTmp));
                }
            }
        }
    }

    @Override
    public void visit(VarSeqNode node) {
        if (node.getVarNodes()!=null) {
            for (var varNode: node.getVarNodes())
                varNode.accept(this);
        }
    }

    @Override
    public void visit(ParenedInitializerNode node) {}

    @Override
    public void visit(InitializerClauseNode node) {
        if (node.isAtomic()) {
            node.getAssignmentExpr().accept(this);
            node.setResult(node.getAssignmentExpr().getResult());
        }
        else {
            node.getBraced().accept(this);
            node.setResult(node.getBraced().getResult());
        }
    }

    @Override
    public void visit(InitializerListNode node) {}

    @Override
    public void visit(BracedInitListNode node) {}

    /* function */

        // ParametersAndQualifiersNode will not be reached by visitor
    @Override
    public void visit(ParametersAndQualifiersNode node) {}

    @Override
    public void visit(FuncNode node) {
        String funcName = node.getDecoratedName();
        assert module.getFunctions().containsKey(funcName);
        Function func = module.getFunction(funcName);
        curFunc = func;
        curBlock = func.getEntranceBlock();
        node.getFuncBody().accept(this);
        if (curBlock.endWithNonTerminalInst()) {
            curBlock.addInst(new Br(curBlock, null,
                    curFunc.getReturnBlock(), null) );
        }

        func.addBlock(func.getReturnBlock());
        func.checkTermination(exceptionHandler);
        if (node.getPureName().equals("main")) {
            func = module.getFunction("__init__");
            func.checkTermination(exceptionHandler);
            curFunc.getEntranceBlock().addInstAtHead(
                    new Call(curFunc.getEntranceBlock(), pseudoReg,
                            func, new ArrayList<>()));
        }
    }

    /* class */

        // MemberSpecificationNode will not be reached by visitor
    @Override
    public void visit(MemberSpecificationNode node) {}
}
