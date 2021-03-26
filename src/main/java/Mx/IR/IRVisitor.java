package Mx.IR;

import Mx.IR.Instruction.*;

public interface IRVisitor {
    void visit(IRModule node);
    void visit(Function node);
    void visit(IRBlock node);
    void visit(Alloca node);
    void visit(BinaryOp node);
    void visit(BitCast node);
    void visit(Br node);
    void visit(Call node);
    void visit(GetElementPtr node);
    void visit(Icmp node);
    void visit(Load node);
    void visit(Phi node);
    void visit(Ret node);
    void visit(Store node);
}
