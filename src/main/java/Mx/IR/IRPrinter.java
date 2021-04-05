package Mx.IR;

import Mx.IR.Instruction.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

public class IRPrinter implements IRVisitor {
    private final OutputStream sOut;
    private final PrintWriter writer;

    public IRPrinter(String fileName) {
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

    public void run(IRModule module) {
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
    public void visit(IRModule node) {
        //writer.println("; ModuleID = 'code.mx'");
        //writer.println("target datalayout = \"e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\"");
        //writer.println("target triple = \"x86_64-pc-linux-gnu\"");
        //writer.println("");

        if (node.getStructures().size() > 0) {
            for (var s: node.getStructures().values())
                writer.println(s.structureToString());
            writer.println("");
        }
        if (node.getGlobalVariables().size() > 0) {
            for (var g: node.getGlobalVariables().values())
                writer.println(g.printToString());
            writer.println("");
        }
        if (node.getFunctions().size() > 0) {
            for (var f: node.getFunctions().values()) {
                //writer.println("; Function Attrs: noinline nounwind optnone uwtable");
                f.accept(this);
                writer.println("");
            }
        }
        for (var ef: node.getExternalFunctions().values()) {
            writer.println("declare " + ef.declareToString());
            writer.println("");
        }
    }

    @Override
    public void visit(Function node) {
        writer.println("define " + node.declareToString() + " {");
        IRBlock block = node.getEntranceBlock();
        while (block!=null) {
            block.accept(this);
            if (block.hasNextBlock()) writer.println("");
            block = block.getNextBlock();
        }
        writer.println("}");
    }

    @Override
    public void visit(IRBlock node) {
        writer.println(node.getName() + ":");
        IRInst inst = node.getHeadInst();
        while (inst!=null) {
            writer.println("\t"+inst.toString());
            inst = inst.getNextInst();
        }
    }

    @Override
    public void visit(Alloca node) {}

    @Override
    public void visit(BinaryOp node) {}

    @Override
    public void visit(BitCast node) {}

    @Override
    public void visit(Br node) {}

    @Override
    public void visit(Call node) {}

    @Override
    public void visit(GetElementPtr node) {}

    @Override
    public void visit(Icmp node) {}

    @Override
    public void visit(Load node) {}

    @Override
    public void visit(Move node) {}

    @Override
    public void visit(Phi node) {}

    @Override
    public void visit(Ret node) {}

    @Override
    public void visit(Store node) {}
}
