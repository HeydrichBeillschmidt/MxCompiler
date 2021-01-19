package Mx.Entities;

import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.AST.Statements.StmtNode;
import Mx.Utils.Location;

import java.util.ArrayList;

public class FunctionEntity extends Entity {
    public enum FuncEntityType {
        function, constructor, method
    }
    private final DeclSpecifierSeqNode returnType;
    private final ArrayList<VarEntity> parameters;
    private final StmtNode funcBody;
    private final FuncEntityType funcEntityType;

    public FunctionEntity(String name, Location loc,
                          DeclSpecifierSeqNode returnType, ArrayList<VarEntity> parameters,
                          StmtNode funcBody, FuncEntityType funcEntityType) {
        super(name, loc);
        this.returnType = returnType;
        this.parameters = parameters;
        this.funcBody = funcBody;
        this.funcEntityType = funcEntityType;
    }

    public DeclSpecifierSeqNode getReturnType() {
        return returnType;
    }
    public ArrayList<VarEntity> getParameters() {
        return parameters;
    }
    public StmtNode getFuncBody() {
        return funcBody;
    }
    public FuncEntityType getFuncEntityType() {
        return funcEntityType;
    }
}
