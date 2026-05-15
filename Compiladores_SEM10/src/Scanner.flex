import java_cup.runtime.Symbol;

%%

%class Scanner
%unicode
%cup
%line
%column
%public

%{
        public Scanner(java.io.InputStream in) {
                this(new java.io.InputStreamReader(in, java.nio.charset.Charset.forName("UTF-8")));
        }
%}

digito = [0-9]
letra = [a-zA-Z]
inteiro = 0 | [1-9][0-9]*

fimdeLinha = \r|\n|\r\n
espaco = {fimdeLinha} | [ \t\f]
opMais = "+"

%%

"if"        { return new Symbol(sym.KW_IF); }
"else"      { return new Symbol(sym.KW_ELSE); }

{inteiro} {
    double aux = Double.parseDouble(yytext());
    return new Symbol(sym.NUMBER, Double.valueOf(aux));
}

">"|"<"|">="|"<="|"=="|"!=" { return new Symbol(sym.OP_RELACIONAL, yytext()); }

{opMais}    { return new Symbol(sym.MAIS); }
"-"         { return new Symbol(sym.MENOS); }
"/"         { return new Symbol(sym.DIV); }
"*"         { return new Symbol(sym.MULT); }
"%"         { return new Symbol(sym.MOD); }
";"         { return new Symbol(sym.PTVIRG); }

"("         { return new Symbol(sym.ABRE_PARENT); }
")"         { return new Symbol(sym.FECHA_PARENT); }
"{"         { return new Symbol(sym.ABRE_CHAVE); }
"}"         { return new Symbol(sym.FECHA_CHAVE); }
"["         { return new Symbol(sym.ABRE_COLCH); }
"]"         { return new Symbol(sym.FECHA_COLCH); }
"."         { return new Symbol(sym.PTO); }

[a-zA-Z][a-zA-Z0-9]* { return new Symbol(sym.IDENT, yytext()); }

{espaco}    { /* despreza */ }

[^] {
  System.err.println("Caractere inválido '" + yytext() + "' na linha " + yyline + ":" + yycolumn);
  return new Symbol(sym.EOF); 
}