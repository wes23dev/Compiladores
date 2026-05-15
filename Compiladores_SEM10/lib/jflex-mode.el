import java.io.PrintWriter;
import java.io.FileOutputStream;

public class CriarScanner {
    public static void main(String[] args) {
        try (PrintWriter writer = new PrintWriter(new FileOutputStream("src/Scanner.flex"))) {
            writer.print("%{\n");
            writer.print("import java_cup.runtime.Symbol;\n");
            writer.print("%}\n\n");
            writer.print("%class Scanner\n");
            writer.print("%cupsym sym\n");
            writer.print("%cup\n");
            writer.print("%unicode\n");
            writer.print("%line\n");
            writer.print("%column\n");
            writer.print("%public\n\n");
            writer.print("%%\n\n");
            writer.print("[0-9]+(\\.[0-9]+)? { return new Symbol(sym.NUMBER, Double.valueOf(Double.parseDouble(yytext()))); }\n");
            writer.print("\"if\"              { return new Symbol(sym.KW_IF); }\n");
            writer.print("\"else\"            { return new Symbol(sym.KW_ELSE); }\n");
            writer.print("\">\"|\"<\"|\">=\"|\"<=\"|\"==\"|\"!=\" { return new Symbol(sym.OP_RELACIONAL, yytext()); }\n");
            writer.print("\"+\"               { return new Symbol(sym.MAIS); }\n");
            writer.print("\"-\"               { return new Symbol(sym.MENOS); }\n");
            writer.print("\"/\"               { return new Symbol(sym.DIV); }\n");
            writer.print("\"*\"               { return new Symbol(sym.MULT); }\n");
            writer.print("\"%\"               { return new Symbol(sym.MOD); }\n");
            writer.print(\"\";\"               { return new Symbol(sym.PTVIRG); }\n");
            writer.print("\"(\"               { return new Symbol(sym.ABRE_PARENT); }\n");
            writer.print(\")\"               { return new Symbol(sym.FECHA_PARENT); }\n");
            writer.print(\"{\"               { return new Symbol(sym.ABRE_CHAVE); }\n");
            writer.print(\"}\"               { return new Symbol(sym.FECHA_CHAVE); }\n");
            writer.print(\"[\"               { return new Symbol(sym.ABRE_COLCH); }\n");
            writer.print(\"]\"               { return new Symbol(sym.FECHA_COLCH); }\n");
            writer.print(\".\"               { return new Symbol(sym.PTO); }\n");
            writer.print("[ \\t\\r\\n\\f]+      { /* Ignora espacos */ }\n");
            writer.print("[a-zA-Z][a-zA-Z0-9]* { return new Symbol(sym.IDENT, yytext()); }\n");
            writer.print("[^]               { return new Symbol(sym.EOF, yyline, yycolumn, yytext()); }\n");
            System.out.println("Arquivo Scanner.flex gerado com sucesso e totalmente limpo!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}