package Mx.IR;

import Mx.IR.Instruction.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

public class IRPrinter implements IRVisitor {
    private final OutputStream sOut;
    private final PrintWriter writer;
    private final String indent = "    ";

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

    public void exec(IRModule module) {
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
        writer.println("; ModuleID = 'code.mx'");
        writer.println("source_filename = 'code.mx'");
        writer.println("target datalayout = \"e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128\"");
        writer.println("target triple = \"x86_64-pc-linux-gnu\"");
        writer.println("");

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
        if (node.getConstStrings().size() > 0) {
            for (var cs: node.getConstStrings().values())
                writer.println("@" + cs.getName()
                        + " = private unnamed_addr constant "
                        + cs.toString() + ", align 1");
            writer.println("");
        }
        if (node.getFunctions().size() > 0) {
            for (var f: node.getFunctions().values()) {
                writer.println("; Function Attrs: noinline nounwind optnone uwtable");
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
            inst.accept(this);
            inst = inst.getNextInst();
        }
    }

    @Override
    public void visit(Alloca node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(BinaryOp node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(BitCast node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Br node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Call node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(GetElementPtr node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Icmp node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Load node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Phi node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Ret node) {
        writer.println(indent + node.toString());
    }

    @Override
    public void visit(Store node) {
        writer.println(indent + node.toString());
    }
}
