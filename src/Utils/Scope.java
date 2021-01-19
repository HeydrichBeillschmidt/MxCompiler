package Mx.Utils;

import Mx.Entities.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class Scope {
    private Scope parentScope;
    private ArrayList<Scope> childrenScope;
    private Map<String, Entity> entities;

    public Scope(Scope parent) {
        this.parentScope = parent;
        if (this.parentScope != null) {
            parentScope.childrenScope.add(this);
        }
        this.childrenScope = new ArrayList<>();
        this.entities = new HashMap<>();
    }

    public Scope getParentScope() {
        return parentScope;
    }
    public ArrayList<Scope> getChildrenScope() {
        return childrenScope;
    }
    public Map<String, Entity> getEntities() {
        return entities;
    }
}
