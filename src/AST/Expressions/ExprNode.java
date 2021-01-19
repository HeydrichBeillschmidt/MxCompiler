package Mx.AST.Expressions;

import Mx.AST.ASTNode;
import Mx.Entities.Entity;
import Mx.Types.Type;
import Mx.Utils.Location;

abstract public class ExprNode extends ASTNode {
    private Type type;
    private Boolean isLvalue;
    private Entity entity;
    private String text;

    public ExprNode(Location loc, String text) {
        super(loc);
        type = null;
        isLvalue = null;
        entity = null;
        this.text = text;
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

    @Override
    abstract public String toString();
}
