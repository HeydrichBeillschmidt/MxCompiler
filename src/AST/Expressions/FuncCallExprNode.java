package Mx.AST.Expressions;

import Mx.AST.ASTVisitor;
import Mx.Utils.Location;

import java.util.ArrayList;

public class FuncCallExprNode extends ExprNode {
    private ExprNode name;
    private final ArrayList<ExprNode> parameters;

    public FuncCallExprNode(Location location, String text,
                            ExprNode name, ArrayList<ExprNode> parameters) {
        super(location, text);
        this.name = name;
        this.parameters = parameters;
    }

    public ExprNode getName() {
        return name;
    }
    public void setName(ExprNode name) {
        this.name = name;
    }
    public ArrayList<ExprNode> getParameters() {
        return parameters;
    }
    public void addParameter(ExprNode newParameter) {
        parameters.add(newParameter);
    }
    public void addParameters(ArrayList<ExprNode> newParameters) {
        parameters.addAll(newParameters);
    }

    @Override
    public String toString() {
        StringBuilder string = new StringBuilder("<FuncCallExprNode>\n");
        string.append("function name:\n").append(name.toString());
        string.append("parameters:\n");
        for (ExprNode parameter : parameters)
            string.append(parameter.toString());
        return string.toString();
    }
    @Override
    public void accept(ASTVisitor visitor) {
        visitor.visit(this);
    }
}
