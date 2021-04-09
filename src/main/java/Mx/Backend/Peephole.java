package Mx.Backend;

import Mx.ASM.ASMBlock;
import Mx.ASM.ASMFunction;
import Mx.ASM.ASMModule;
import Mx.ASM.Instruction.ASMInst;
import Mx.ASM.Instruction.LD;
import Mx.ASM.Instruction.MV;
import Mx.ASM.Instruction.ST;
import Mx.ASM.Operand.Address;
import Mx.ASM.Operand.PhysicalReg;

import java.util.ArrayList;

public class Peephole {
    private final ASMModule module;

    public Peephole(ASMModule module) {
        this.module = module;
    }

    public void run() {
        for (var f: module.getFunctions().values()) {
            removeRedundantLoads(f);
        }
    }

    private void removeRedundantLoads(ASMFunction f) {
        ArrayList<ASMBlock> order = f.getLiteralOrder();
        for (var b: order) {
            for (ASMInst i = b.getHeadInst(); i!=null; i = i.getNextInst()) {
                if (i instanceof LD) {
                    PhysicalReg rd = i.getRd().getColor();
                    PhysicalReg addr = ((LD) i).getAddr().getBase().getColor();
                    if (rd==addr) continue;
                    for (ASMInst replace = i.getNextInst();
                         replace!=null; replace = replace.getNextInst()) {
                        if (replace instanceof LD
                                && sameAddr( ((LD) i).getAddr(),
                                    ((LD) replace).getAddr() ) ) {
                            if (rd==replace.getRd().getColor()) replace.removeSelfFromBlock();
                            else replace.replaceByInst(new MV(b, replace.getRd(), i.getRd()));
                        }

                        // traverse living interval
                        boolean interrupt = false;
                        for (var d: replace.getDefs()) {
                            if (d.getColor()==rd || d.getColor()==addr) {
                                interrupt = true;
                                break;
                            }
                        }
                        if (replace instanceof ST
                                && sameAddr( ((LD)i).getAddr(),
                                    ((ST)replace).getAddr() ) ) {
                            interrupt = true;
                        }
                        if (interrupt) break;
                    }
                }
                else if (i instanceof ST) {
                    PhysicalReg rs = ((ST) i).getRs().getColor();
                    PhysicalReg addr = ((ST) i).getAddr().getBase().getColor();
                    for (ASMInst replace = i.getNextInst();
                         replace!=null; replace = replace.getNextInst()) {
                        if (replace instanceof LD
                                && sameAddr( ((ST) i).getAddr(),
                                    ((LD) replace).getAddr() ) ) {
                            if (rs==replace.getRd().getColor()) replace.removeSelfFromBlock();
                            else replace.replaceByInst(new MV(b, replace.getRd(), ((ST) i).getRs()));
                        }

                        // traverse living interval
                        boolean interrupt = false;
                        for (var d: replace.getDefs()) {
                            if (d.getColor()==rs || d.getColor()==addr) {
                                interrupt = true;
                                break;
                            }
                        }
                        if (replace instanceof ST
                                && sameAddr( ((ST)i).getAddr(),
                                    ((ST)replace).getAddr() ) ) {
                            interrupt = true;
                        }
                        if (interrupt) break;
                    }
                }
            }
        }
    }
    private boolean sameAddr(Address addr1, Address addr2) {
        return addr1.getBase().getColor()==addr2.getBase().getColor()
                && addr1.getOffset().getValue()==addr2.getOffset().getValue();
    }
}
