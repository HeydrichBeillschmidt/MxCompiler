package Mx.AST;

import Mx.Utils.Location;
import Mx.Utils.Scope;

abstract public class ASTNode {
    private Location location;
    private Scope scope;

    public ASTNode(Location loc) {
        this.location = loc;
        scope = null;
    }

    public Location getLocation() {
        return location;
    }
    public void setLocation(Location loc) {
        this.location = loc;
    }
    public Scope getScope() {
        return scope;
    }
    public void setScope(Scope scope) {
        this.scope = scope;
    }

    public final boolean equals(Object obj) {
        if (obj instanceof ASTNode) return toString().equals(obj.toString());
        else return false;
    }

    abstract public void accept(ASTVisitor visitor);
    abstract public String toString();
}
