package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.Call;
import Mx.IR.Instruction.IRInst;
import Mx.IR.Instruction.Load;
import Mx.IR.Instruction.Store;

import java.util.ArrayList;

public class PeepholeOpt extends Pass {
    boolean changed;

    public PeepholeOpt(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        ArrayList<IRBlock> RPO = f.getRPO();
        for (var b: RPO) {
            ArrayList<IRInst> instList = b.getAllInst();
            for (var i: instList) {
                if (i.getPrevInst()!=null && i instanceof Load
                        && i.getPrevInst() instanceof Store) {
                    Load ld = (Load) i;
                    Store st = (Store) i.getPrevInst();
                    if (ld.getAddr()==st.getAddr()) {
                        ld.getDst().replaceUse(st.getValue());
                        ld.severDF();
                        ld.removeFromBlock();
                    }
                }
                else if (i.getPrevInst()!=null && i instanceof Store) {
                    Store cur = (Store) i;
                    for (IRInst replace = i.getPrevInst(); replace!=null;) {
                        IRInst prevInst = replace.getPrevInst();
                        if (replace instanceof Store) {
                            if (cur.getAddr()==((Store)replace).getAddr()) {
                                replace.severDF();
                                replace.removeFromBlock();
                            }
                            else break;
                        }
                        if (replace instanceof Call
                                || (replace instanceof Load
                                && cur.getAddr()==((Load)replace).getAddr()) ) break;
                        replace = prevInst;
                    }
                }
            }
        }
    }
}
