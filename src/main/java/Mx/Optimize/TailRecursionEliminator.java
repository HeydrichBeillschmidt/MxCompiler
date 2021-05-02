package Mx.Optimize;

import Mx.IR.Function;
import Mx.IR.IRBlock;
import Mx.IR.IRModule;
import Mx.IR.Instruction.*;
import Mx.IR.Operand.ConstInt;
import Mx.IR.Operand.Operand;
import Mx.IR.Operand.Parameter;
import Mx.IR.Operand.Register;
import Mx.IR.TypeSystem.VoidType;

import java.util.*;

public class TailRecursionEliminator extends Pass {
    private boolean changed;

    public TailRecursionEliminator(IRModule module) {
        super(module);
    }

    @Override
    public boolean run() {
        changed = false;
        module.getFunctions().values().forEach(this::runForFn);
        return changed;
    }
    private void runForFn(Function f) {
        Map<IRBlock, Integer> incMap = new HashMap<>();
        BinaryOp.BinaryOpName opName = null;
        // detect tail recursion
        IRBlock retBlock = f.getReturnBlock();
        Ret retInst = (Ret) retBlock.getTailInst();
        Queue<Call> W = new LinkedList<>();
        if (retInst.getPrevInst()!=null) {
            if (retInst.getPrevInst() instanceof Phi) {
                Phi tailPhi = (Phi) retInst.getPrevInst();
                if (!(retInst.getRetType() instanceof VoidType)
                        && tailPhi.getDst().equals(retInst.getRetValue())) {
                    ArrayList<IRBlock> blocksSwept = new ArrayList<>();
                    ArrayList<BinaryOp> pendingInc = new ArrayList<>();
                    for (int i = 0, it = tailPhi.getBlocks().size(); i < it; ++i) {
                        IRBlock lastBlock = tailPhi.getBlocks().get(i);
                        Operand lastValue = tailPhi.getValues().get(i);
                        ArrayList<IRInst> lastInstList = lastBlock.getAllInst();
                        int sz = lastInstList.size();
                        if (((Br)lastInstList.get(sz-1)).getCondition()==null) {
                            if (sz>=2 && lastInstList.get(sz-2) instanceof Call) {
                                Call tailCS = (Call) lastInstList.get(sz-2);
                                if (tailCS.getCallee()==f && tailCS.hasDst() &&
                                        tailCS.getDst().equals(lastValue) ) {
                                    W.offer(tailCS);
                                    blocksSwept.add(lastBlock);
                                }
                            }
                            else if (TREWithOffset(lastInstList, f, lastValue))
                                pendingInc.add((BinaryOp) lastInstList.get(sz-2));
                        }
                    }
                    if (!pendingInc.isEmpty()) {
                        boolean doInc = true;
                        for (var bi: pendingInc) {
                            if (opName==null) opName = bi.getOpName();
                            else if (opName!=bi.getOpName()) {
                                doInc = false;break;
                            }
                        }
                        if (doInc) {
                            for (var bi: pendingInc) {
                                Call tailCS = (Call) bi.getPrevInst();
                                IRBlock lastBlock = bi.getBlock();
                                incMap.put(lastBlock, ((ConstInt)bi.getOp2()).getValue());
                                W.offer(tailCS);
                                blocksSwept.add(lastBlock);
                            }
                        }
                    }
                    if (!blocksSwept.isEmpty()) {
                        blocksSwept.forEach(tailPhi::removeEntry);
                        if (tailPhi.getBlocks().isEmpty()) tailPhi.removeFromBlock();
                    }
                }
            }
        }

        // eliminate tail recursion
        if (W.isEmpty()) return;
        changed = true;
        boolean firstHit = false;
        IRBlock entryOld = f.getEntranceBlock();
        IRBlock entryTRE = new IRBlock("entryTRE");
        ArrayList<Register> formalArgs = new ArrayList<>();
        ArrayList<IRBlock> phiBlocks = new ArrayList<>();
        Map<Register, ArrayList<Operand>> phiValues = new HashMap<>();
        while (!W.isEmpty()) {
            Call tailRecursive = W.poll();
            IRBlock blockRecursive = tailRecursive.getBlock();
            if (!firstHit) {
                firstHit = true;
                entryTRE.addInst(new Br(entryTRE, null, entryOld, null));
                f.addPrevBlock(entryOld, entryTRE);
                phiBlocks.add(entryTRE);

                ArrayList<Parameter> parameterList = f.getParameterList();
                for (int i = 0, it = parameterList.size(); i < it; ++i) {
                    Parameter p = parameterList.get(i);
                    Register oldFA = new Register(p.getType(), p.getName());
                    f.addSymbol(oldFA);
                    p.replaceUse(oldFA);
                    formalArgs.add(oldFA);
                    phiValues.put(oldFA, new ArrayList<>());

                    Parameter newFA = new Parameter(oldFA.getType(), "TRE."+oldFA.getName());
                    f.addSymbol(newFA);
                    parameterList.set(i, newFA);
                    phiValues.get(oldFA).add(newFA);
                }
            }

            phiBlocks.add(blockRecursive);
            ArrayList<Operand> actualArgs = tailRecursive.getParameterList();
            for (int i = 0, it = formalArgs.size(); i < it; ++i) {
                phiValues.get(formalArgs.get(i)).add(actualArgs.get(i));
            }

            IRInst tailInst = blockRecursive.getTailInst();
            tailInst.severDF();
            tailInst.severCF();
            tailInst.removeFromBlock();
            tailRecursive.severDF();
            tailRecursive.removeFromBlock();
            f.removeCallSite(tailRecursive);
            blockRecursive.addInst(new Br(blockRecursive, null, entryOld, null));
        }
        phiValues.forEach((fa, values) -> {
            Phi phiInst = new Phi(entryOld, fa, values, phiBlocks);
            fa.setDef(phiInst);
            entryOld.addInstAtHead(phiInst);
        });
        if (!incMap.isEmpty()) {
            // %recursiveInc = phi i32 [0, %entryTRE], [c1, block1], ...
            Register recurInc = new Register(IRModule.int32T, "recursiveInc");
            f.addSymbol(recurInc);
            ArrayList<Operand> valueIncs = new ArrayList<>();
            for (var pb: phiBlocks) {
                int incVal = incMap.getOrDefault(pb, 0);
                valueIncs.add(new ConstInt(incVal, 4));
            }
            Phi incPhi = new Phi(entryOld, recurInc, valueIncs, phiBlocks);
            ArrayList<Phi> entryPhis = entryOld.getAllPhi();
            Phi lastPhi = entryPhis.get(entryPhis.size()-1);
            entryOld.addNextInst(lastPhi, incPhi);

            // %recursiveIncCnt = phi i32 [0, %entryTRE], [%incCntTmp, otherwise]
            // %incCntTmp = op i32 %recursiveIncCnt, %recursiveInc
            Register cntInc = new Register(IRModule.int32T, "recursiveIncCnt");
            f.addSymbol(cntInc);
            Register tmpInc = new Register(IRModule.int32T, "incCntTmp");
            f.addSymbol(tmpInc);
            ArrayList<Operand> valueTmp = new ArrayList<>();
            for (var pb: phiBlocks) {
                if (pb==entryTRE) valueTmp.add(new ConstInt(0, 4));
                else valueTmp.add(tmpInc);
            }
            Phi cntPhi = new Phi(entryOld, cntInc, valueTmp, phiBlocks);
            entryOld.addNextInst(incPhi, cntPhi);

            BinaryOp compensationInst = new BinaryOp(entryOld, tmpInc, opName, cntInc, recurInc);
            entryOld.addNextInst(cntPhi, compensationInst);

            // %trueRetVal = op i32 retVal, %incCntTmp
            // ret i32 %trueRetVal
            Register sumInc = new Register(IRModule.int32T, "recursiveIncOverall");
            f.addSymbol(sumInc);
            BinaryOp sumInst = new BinaryOp(retBlock, sumInc, opName, retInst.getRetValue(), tmpInc);
            retBlock.addPrevInst(retInst, sumInst);
            retInst.replaceUse(retInst.getRetValue(), sumInc);
        }
    }

    private boolean TREWithOffset(ArrayList<IRInst> instList, Function callee, Operand retVal) {
        int sz = instList.size();
        if (sz<3 || !(instList.get(sz-2) instanceof BinaryOp)) return false;
        BinaryOp incInst = (BinaryOp) instList.get(sz-2);
        if (!incInst.getDst().equals(retVal) ||
                !(incInst.getOp1() instanceof ConstInt
                || incInst.getOp2() instanceof ConstInt) ) return false;
        if (!(instList.get(sz-3) instanceof Call)) return false;
        Call tailCS = (Call) instList.get(sz-3);
        incInst.skewToLeft();
        return tailCS.getCallee()==callee && tailCS.hasDst()
                && tailCS.getDst().getUses().size()==1 && incInst.isCommutable()
                && incInst.getOp1().equals(tailCS.getDst());
    }
}
