package scanner;

import java_cup.runtime.Symbol;
import erros.ListaErros;
import parser.sym;

%%

%class Scanner
%unicode
%cup
%line
%column
%public

%{
    private ListaErros listaErros;

    public Scanner(java.io.Reader in, ListaErros listaErros) {
        this(in);
        this.listaErros = listaErros;
    }

    private Symbol criaSimbolo(int tipo) {
        return new Symbol(tipo, yyline + 1, yycolumn + 1);
    }

    private Symbol criaSimbolo(int tipo, Object valor) {
        return new Symbol(tipo, yyline + 1, yycolumn + 1, valor);
    }

    private void defineErro(String mensagem) {
        listaErros.addErro(yyline + 1, yycolumn + 1, mensagem);
    }
%}

/* Definicoes */
Letra         = [a-zA-Z]
Digito        = [0-9]
DigitoHex     = [0-9a-fA-F]
Identificador = {Letra}({Letra}|{Digito}|_)*
NumInteiro    = {Digito}+
NumReal       = {Digito}+\.{Digito}+
NumHex        = 0x{DigitoHex}+
Espaco        = [ \t\r\n]+

%state COMENTARIO_BLOCO

%%

/* Comentarios de multiplas linhas */
<YYINITIAL> "/*"           { yybegin(COMENTARIO_BLOCO); }
<COMENTARIO_BLOCO> "*/"    { yybegin(YYINITIAL); }
<COMENTARIO_BLOCO> [^*]+   { /* ignorar conteudo do comentario */ }
<COMENTARIO_BLOCO> "*"     { /* ignorar asterisco isolado */ }
<COMENTARIO_BLOCO> <<EOF>> { defineErro("Léxico - Comentário de bloco não fechado (EOF inesperado)"); yybegin(YYINITIAL); }

/* Comentarios de linha unica */
<YYINITIAL> "//"[^\n]*     { /* ignorar comentario de linha */ }

/* Espacos em branco */
<YYINITIAL> {Espaco}       { /* ignorar espacos */ }

/* Palavras reservadas */
<YYINITIAL> "program"      { return criaSimbolo(sym.PROGRAM, yytext()); }
<YYINITIAL> "class"        { return criaSimbolo(sym.CLASS, yytext()); }
<YYINITIAL> "if"           { return criaSimbolo(sym.IF, yytext()); }
<YYINITIAL> "else"         { return criaSimbolo(sym.ELSE, yytext()); }
<YYINITIAL> "while"        { return criaSimbolo(sym.WHILE, yytext()); }
<YYINITIAL> "read"         { return criaSimbolo(sym.READ, yytext()); }
<YYINITIAL> "print"        { return criaSimbolo(sym.PRINT, yytext()); }
<YYINITIAL> "return"       { return criaSimbolo(sym.RETURN, yytext()); }
<YYINITIAL> "void"         { return criaSimbolo(sym.VOID, yytext()); }
<YYINITIAL> "break"        { return criaSimbolo(sym.BREAK, yytext()); }
<YYINITIAL> "final"        { return criaSimbolo(sym.FINAL, yytext()); }
<YYINITIAL> "new"          { return criaSimbolo(sym.NEW, yytext()); }
<YYINITIAL> "int"          { return criaSimbolo(sym.INT, yytext()); }
<YYINITIAL> "float"        { return criaSimbolo(sym.FLOAT, yytext()); }

/* Numeros hexadecimais (deve vir antes de inteiro) */
<YYINITIAL> {NumHex}       { return criaSimbolo(sym.NUM_INTEIRO, yytext()); }

/* Numeros reais (deve vir antes de inteiro) */
<YYINITIAL> {NumReal}      { return criaSimbolo(sym.NUM_REAL, yytext()); }

/* Numeros inteiros */
<YYINITIAL> {NumInteiro}   { return criaSimbolo(sym.NUM_INTEIRO, yytext()); }

/* Simbolos compostos (devem vir antes dos simples) */
<YYINITIAL> "=="           { return criaSimbolo(sym.IGUAL); }
<YYINITIAL> "!="           { return criaSimbolo(sym.DIFERENTE); }
<YYINITIAL> "<="           { return criaSimbolo(sym.MENOR_IGUAL); }
<YYINITIAL> ">="           { return criaSimbolo(sym.MAIOR_IGUAL); }
<YYINITIAL> "&&"           { return criaSimbolo(sym.AND); }
<YYINITIAL> "||"           { return criaSimbolo(sym.OR); }
<YYINITIAL> "++"           { return criaSimbolo(sym.INCREMENTO); }
<YYINITIAL> "--"           { return criaSimbolo(sym.DECREMENTO); }

/* Simbolos simples */
<YYINITIAL> "+"            { return criaSimbolo(sym.MAIS); }
<YYINITIAL> "-"            { return criaSimbolo(sym.MENOS); }
<YYINITIAL> "*"            { return criaSimbolo(sym.MULT); }
<YYINITIAL> "/"            { return criaSimbolo(sym.DIV); }
<YYINITIAL> "%"            { return criaSimbolo(sym.MOD); }
<YYINITIAL> "="            { return criaSimbolo(sym.ATRIB); }
<YYINITIAL> "<"            { return criaSimbolo(sym.MENOR); }
<YYINITIAL> ">"            { return criaSimbolo(sym.MAIOR); }
<YYINITIAL> ";"            { return criaSimbolo(sym.PTVIRG); }
<YYINITIAL> ","            { return criaSimbolo(sym.VIRGULA); }
<YYINITIAL> "."            { return criaSimbolo(sym.PONTO); }
<YYINITIAL> "("            { return criaSimbolo(sym.ABRE_PAR); }
<YYINITIAL> ")"            { return criaSimbolo(sym.FECHA_PAR); }
<YYINITIAL> "["            { return criaSimbolo(sym.ABRE_COL); }
<YYINITIAL> "]"            { return criaSimbolo(sym.FECHA_COL); }
<YYINITIAL> "{"            { return criaSimbolo(sym.ABRE_CHAVE); }
<YYINITIAL> "}"            { return criaSimbolo(sym.FECHA_CHAVE); }

/* Identificadores */
<YYINITIAL> {Identificador} { return criaSimbolo(sym.IDENT, yytext()); }

/* Caractere nao reconhecido - erro lexico */
<YYINITIAL> . {
    defineErro("Léxico - Símbolo desconhecido: " + yytext());
}
