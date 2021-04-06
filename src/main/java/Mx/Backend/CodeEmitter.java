package Mx.Backend;

import Mx.ASM.*;
import Mx.ASM.Instruction.*;
import Mx.ASM.Operand.GlobalVar;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

public class CodeEmitter implements ASMVisitor {
    private final OutputStream sOut;
    private final PrintWriter writer;

    public CodeEmitter(String fileName) {
        try {
            File targetFile = new File(fileName);
            assert targetFile.exists() || targetFile.createNewFile();
            sOut = new FileOutputStream(fileName, false);
            writer = new PrintWriter(sOut);
        }
        catch (Exception exception) {
            exception.printStackTrace();
            throw new RuntimeException(exception.getMessage());
        }
    }

    public void run(ASMModule module) {
        module.accept(this);
        try {
            writer.close();
            sOut.close();
        }
        catch (Exception exception) {
            exception.printStackTrace();
            throw new RuntimeException(exception.getMessage());
        }
    }

    @Override
    public void visit(ASMModule node) {
        writer.println("\t.text\n");
        node.getFunctions().values().forEach(f -> f.accept(this));
        writer.println("\n\t.section\t.sdata,\"aw\",@progbits");
        node.getGlobalVars().values().forEach(g -> g.accept(this));
    }

    @Override
    public void visit(ASMFunction node) {
        writer.print("\t.globl\t" + node.getName());
        writer.print(" ".repeat(Integer.max(1, 24-node.getName().length())));
        writer.println("# -- Begin function " + node.getName());
        writer.println("\t.p2align\t2");
        writer.print(node.getName() + ":");
        writer.print(" ".repeat(Integer.max(1, 39-node.getName().length())));
        writer.println("# @" + node.getName());
        node.getLiteralOrder().forEach(b -> b.accept(this));
        writer.print(" ".repeat(40));
        writer.println("# -- End function\n");
    }

    @Override
    public void visit(ASMBlock node) {
        String blockHead = (node==node.getFunc().getEntranceBlock()
                ? "# %bb.0"
                : node.getAsmName() ) + ":";
        writer.print(blockHead + " ".repeat(Integer.max(1,40-blockHead.length())));
        writer.println("# %" + node.getName());
        node.getAllInst().forEach(i -> writer.println(i.emitCode()));
    }

    @Override
    public void visit(GlobalVar node) {
        writer.println("\t.globl\t" + node.getName());
        if (!node.isString()) {
            writer.println("\t.p2align\t2");
        }
        writer.println(node.getName() + ":");
        writer.println(node.emitCode());
        writer.println("");
    }

    @Override
    public void visit(BR node) {}

    @Override
    public void visit(BZ node) {}

    @Override
    public void visit(CALL node) {}

    @Override
    public void visit(IAL node) {}

    @Override
    public void visit(JP node) {}

    @Override
    public void visit(LA node) {}

    @Override
    public void visit(LD node) {}

    @Override
    public void visit(LI node) {}

    @Override
    public void visit(LUI node) {}

    @Override
    public void visit(MV node) {}

    @Override
    public void visit(RAL node) {}

    @Override
    public void visit(RET node) {}

    @Override
    public void visit(ST node) {}

    @Override
    public void visit(SZ node) {}
}
