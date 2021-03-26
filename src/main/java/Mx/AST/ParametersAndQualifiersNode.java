package Mx.AST;

import Mx.Utils.Location;

import java.util.ArrayList;

public class ParametersAndQualifiersNode extends DeclarationNode {
    private final ArrayList<VarNode> parameters;

    public ParametersAndQualifiersNode(Location loc,
                                       ArrayList<VarNode> parameters) {
        super(loc);
        this.parameters = parameters;
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

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("parameters:\n");
        for (var parameter: parameters)
            string.append(parameter.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
