package Mx.Optimize;

import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.IRInst;
import Mx.IR.Instruction.Phi;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/* an extremely naive, local(in-block) CSE
 * todo: apply advanced algorithms by data flow analysis tricks
 * possible ref for further study:
 * - Partial Redundant Elimination:
 * http://www.cs.cmu.edu/~hopper/745project/ssapre1.pdf
 */

// common subexpression elimination
public class CSE extends Pass {
    private boolean changed;

    public CSE(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        for (var f: module.getFunctions().values()) {
            ArrayList<IRBlock> PO = f.getPO();
            PO.forEach(this::runForBlock);
        }
        return changed;
    }
    private void runForBlock(IRBlock block) {
        boolean loopCond = true;
        while (loopCond) {
            loopCond = false;

            Set<IRInst> retained = new HashSet<>();
            ArrayList<IRInst> instList = block.getAllInst();
            for (var i: instList) {
                if (i.hasNoSideEffect() || i instanceof Phi) {
                    boolean replace = false;
                    for (var ri: retained) {
                        if (i.isCommonExpr(ri)) {
                            replace = true;
                            i.getDst().replaceUse(ri.getDst());
                            i.severDF();
                            i.removeFromBlock();
                            break;
                        }
                    }
                    if (replace) loopCond = true;
                    else retained.add(i);
                }
            }

            changed |= loopCond;
        }
    }
}
