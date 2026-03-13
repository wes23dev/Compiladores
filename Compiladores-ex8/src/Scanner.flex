%%
%standalone
%line
%column
%class Scanner

/* ---------------- MACROS ---------------- */

letra = [A-Za-z]
digito = [0-9]

ident = {letra}({letra}|{digito})*

numero = {digito}+(\.{digito}+)?
numeroCientifico = -?{digito}+(\.{digito}+)?[Ee]{digito}+

aspas = \"
conteudo = [^\"]*
texto = {aspas}{conteudo}{aspas}

espaco = [ \t\r\n]+

/* palavras-chave */

KW_STRING = "String"
KW_FLOAT = "float"
KW_WHILE = "while"
KW_COUT = "cout"

/* operadores */

OP_ATRIB = "="
OP_CONCAT = "<<"
OP_MENORIGUAL = "<="

/* símbolos */

PONTO_VIRG = ";"
ABRE_PAR = "("
FECHA_PAR = ")"
ABRE_CH = "{"
FECHA_CH = "}"

/* ---------------- EXPRESSÕES ---------------- */

declString = {KW_STRING}{espaco}{ident}{espaco}{OP_ATRIB}{espaco}{texto}{PONTO_VIRG}

declFloat = {KW_FLOAT}{espaco}{ident}{PONTO_VIRG}

msgTexto = {KW_COUT}{espaco}{OP_CONCAT}{espaco}{texto}{PONTO_VIRG}

msgTextoVar = {KW_COUT}{espaco}{OP_CONCAT}{espaco}{texto}{espaco}{OP_CONCAT}{espaco}{ident}{PONTO_VIRG}

whileLoop = {KW_WHILE}{ABRE_PAR}{ident}{espaco}{OP_MENORIGUAL}{espaco}{numero}{FECHA_PAR}

atribNumero = {ident}{espaco}{OP_ATRIB}{espaco}{numeroCientifico}{PONTO_VIRG}

%%

{declString} {
System.out.println("<declString: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{declFloat} {
System.out.println("<declFloat: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{msgTextoVar} {
System.out.println("<msgTelaVar: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{msgTexto} {
System.out.println("<msgTela: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{whileLoop} {
System.out.println("<while: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{atribNumero} {
System.out.println("<atribNumero: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

/* chaves */

{ABRE_CH} {
System.out.println("<abreChave>");
}

{FECHA_CH} {
System.out.println("<fechaChave>");
}

/* ignorar espaços */

{espaco} { }
