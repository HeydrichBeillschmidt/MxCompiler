package Mx.AST;

import Mx.AST.Specifiers.DeclSpecifierSeqNode;
import Mx.AST.Statements.CompoundStmtNode;
import Mx.Entities.FunctionEntity;
import Mx.Entities.VarEntity;
import Mx.Utils.Location;

import java.util.ArrayList;

public class FuncNode extends DeclarationNode {
    private final DeclSpecifierSeqNode specifier;
    private final String name;
    private final ArrayList<VarNode> parameters;
    private final CompoundStmtNode funcBody;

    public FuncNode(Location loc,
                    DeclSpecifierSeqNode specifier,
                    String name,
                    ArrayList<VarNode> parameters,
                    CompoundStmtNode funcBody) {
        super(loc);
        this.specifier = specifier;
        this.name = name;
        this.parameters = parameters;
        this.funcBody = funcBody;
    }

    public DeclSpecifierSeqNode getSpecifier() {
        return specifier;
    }
    public String getName() {
        return name;
    }
    public ArrayList<VarNode> getParameters() {
        return parameters;
    }
    public void addParameter(VarNode newParameter) {
        parameters.add(newParameter);
    }
    public void addParameters(ArrayList<VarNode> newParameters) {
        parameters.addAll(newParameters);
    }
    public CompoundStmtNode getFuncBody() {
        return funcBody;
    }
    public FunctionEntity generateEntity(FunctionEntity.FuncEntityType entityType) {
        ArrayList<VarEntity> generatedParameters = new ArrayList<>();
        for (var parameter: parameters)
            generatedParameters.add(parameter.generateEntity(VarEntity.VarEntityType.parameter));
        return new FunctionEntity(name, getLocation(),
                specifier, generatedParameters, funcBody, entityType);
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<FunctionNode>\n");
        if (specifier!=null)
            string.append("return type specifier:\n").append(specifier.toString());
        string.append("function name:\n").append(name);
        string.append("parameters:\n");
        for (var parameter: parameters)
            string.append(parameter.toString());
        string.append("body of function:\n").append(funcBody.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
