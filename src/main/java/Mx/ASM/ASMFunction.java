package Mx.ASM;

public class ASMFunction {
    private final String name;

    private ASMBlock entranceBlock;
    private ASMBlock exitBlock;

    public ASMFunction(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public ASMBlock getEntranceBlock() {
        return entranceBlock;
    }
}
