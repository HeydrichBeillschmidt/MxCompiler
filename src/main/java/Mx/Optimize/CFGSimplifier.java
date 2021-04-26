package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Br;
import Mx.IR.Operand.ConstBool;

import java.util.ArrayList;

public class CFGSimplifier extends Pass {
    public CFGSimplifier(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        boolean changed = false;
        for (var f: module.getFunctions().values()) changed |= runForFn(f);
        return changed;
    }
    private boolean runForFn(Function f) {
        boolean changed = false;
        while (true) {
            boolean loopCond = false;

            ArrayList<IRBlock> PO = f.getPO();
            for (var b: PO) {
                if (b.getTailInst() instanceof Br) {
                    Br instBR = (Br) b.getTailInst();
                    if (instBR.getThenBlock()==instBR.getElseBlock()) {
                        instBR.rewriteToJump(instBR.getThenBlock());
                        loopCond = true;
                    }
                    else if (instBR.getCondition() instanceof ConstBool) {
                        boolean tune = ((ConstBool)instBR.getCondition()).getValue();
                        IRBlock dstBlock = tune ? instBR.getThenBlock() : instBR.getElseBlock();
                        IRBlock redundant = tune ? instBR.getElseBlock() : instBR.getThenBlock();
                        b.severCF(redundant);
                        instBR.rewriteToJump(dstBlock);
                        loopCond = true;
                    }
                }
            }
            ArrayList<IRBlock> literal = f.getAllBlocks();
            for (var b: literal) {
                if (!PO.contains(b)) {
                    f.removeBlock(b);
                    loopCond = true;
                }
                else loopCond |= b.checkAndMerge(f);
            }

            if (loopCond) changed = true;
            else break;
        }
        return changed;
    }
}
