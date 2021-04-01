package Mx.ASM;

import Mx.ASM.Operand.GlobalVar;
import Mx.ASM.Instruction.*;

public interface ASMVisitor {
    void visit(ASMModule node);
    void visit(ASMFunction node);
    void visit(ASMBlock node);
    void visit(GlobalVar node);
    void visit(BR node);
    void visit(BZ node);
    void visit(CALL node);
    void visit(IAL node);
    void visit(JP node);
    void visit(LA node);
    void visit(LD node);
    void visit(LI node);
    void visit(LUI node);
    void visit(MV node);
    void visit(RAL node);
    void visit(RET node);
    void visit(ST node);
    void visit(SZ node);
}
