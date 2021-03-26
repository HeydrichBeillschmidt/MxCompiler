package Mx.AST.Expressions;

import Mx.AST.ASTNode;
import Mx.Entities.Entity;
import Mx.IR.Operand.Operand;
import Mx.Types.Type;
import Mx.Utils.Location;

abstract public class ExprNode extends ASTNode {
    private Type type;
    private Boolean isLvalue;
    private Entity entity;
    private String text;

    private Operand result;
    private Operand addr;

    public ExprNode(Location loc, String text) {
        super(loc);
        type = null;
        isLvalue = null;
        entity = null;
        this.text = text;
        result = null;
        addr = null;
    }

    public Type getType() {
        return type;
    }
    public void setType(Type type) {
        this.type = type;
    }
    public Boolean isLvalue() {
        return isLvalue;
    }
    public void assureLvalue(Boolean isLvalue) {
        this.isLvalue = isLvalue;
    }
    public Entity getEntity() {
        return entity;
    }
    public void setEntity(Entity entity) {
        this.entity = entity;
    }
    public String getText() {
        return text;
    }
    public void setText(String text) {
        this.text = text;
    }

    public Operand getResult() {
        return result;
    }
    public void setResult(Operand result) {
        this.result = result;
    }
    public Operand getAddr() {
        return addr;
    }
    public void setAddr(Operand addr) {
        this.addr = addr;
    }

    @Override
    abstract public String toString();
}
