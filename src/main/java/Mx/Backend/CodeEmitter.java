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
    private ASMModule module;

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
        this.module = module;
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
        writer.println("\t.text");
        writer.println("\t.file\t\"code.mx\"");
        node.getFunctions().values().forEach(f -> f.accept(this));
        node.getGlobalVars().values().forEach(g -> g.accept(this));
        node.getStrValues().forEach(this::runForStr);
    }
    private void runForStr(GlobalVar gv, String value) {
        writer.println("\t.type\t" + gv.getName() + ",@object");
        writer.println("\t.section\t.rodata");
        writer.println(gv.getName() + ":");
        String str = value.replace("\\", "\\\\");
        str = str.replace("\n", "\\n");
        str = str.replace("\0", "");
        str = str.replace("\t", "\\t");
        str = str.replace("\"", "\\\"");
        writer.println("\t.asciz\t\"" + str + "\"");
        writer.println("\t.size\t" + gv.getName() + ", " + value.length() + "\n");
    }

    @Override
    public void visit(ASMFunction node) {
        writer.print("\t.global\t" + node.getName());
        writer.print(" ".repeat(Integer.max(1, 24-node.getName().length())));
        writer.println("# -- Begin function" + node.getName());
        writer.println("\t.p2align\t2");
        writer.println("\t.type\t" + node.getName() + ",@function");
        writer.print(node.getName() + ":");
        writer.print(" ".repeat(Integer.max(1, 39-node.getName().length())));
        writer.println("# @" + node.getName());
        node.getLiteralOrder().forEach(b -> b.accept(this));
        writer.println(".Lfunc_end" + node.getFuncID() + ":");
        writer.println("\t.size\t" + node.getName() + ", .Lfunc_end"
                + node.getFuncID() + "-" + node.getName());
        writer.print(" ".repeat(40));
        writer.println("# -- End function");
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
        if (!module.getStrValues().containsKey(node)) {
            writer.println("\t.type\t" + node.getName() + ",@object");
            writer.println("\t.section\t.bss");
            writer.println("\t.global\t" + node.getName());
            writer.println("\t.p2align\t2");
            writer.println(node.getName() + ":");
            writer.println("\t.word\t0");
            writer.println("\t.size\t" + node.getName() + ", 4\n");
        }
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
