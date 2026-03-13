%%
%standalone
%line
%column
%class Scanner

/* ---------------- MACROS ---------------- */

letra = [A-Za-z]
digito = [0-9]

ident = {letra}({letra}|{digito})*

aspas = \"
conteudoString = [^\"]*
texto = {aspas}{conteudoString}{aspas}

espaco = [ \t\r\n]*

pontoVirgula = ";"

/* palavras-chave */

KW_STRING = "String"
KW_COUT = "cout"

/* operadores */

OP_ATRIB = "="
OP_CONCAT = "<<"

/* ---------------- REGRAS COMPLEXAS ---------------- */

/* declaração de string */

declString = {KW_STRING}{espaco}{ident}{espaco}{OP_ATRIB}{espaco}{texto}{espaco}{pontoVirgula}

/* cout simples */

msgTela = {KW_COUT}{espaco}{OP_CONCAT}{espaco}{texto}{espaco}{pontoVirgula}

/* cout com variável */

msgTelaVar = {KW_COUT}{espaco}{OP_CONCAT}{espaco}{texto}{espaco}{OP_CONCAT}{espaco}{ident}{espaco}{pontoVirgula}

%%

{declString} {
System.out.println("<declString: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{msgTelaVar} {
System.out.println("<msgTelaVar: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}

{msgTela} {
System.out.println("<msgTela: "+yytext()+", linha:"+yyline+", coluna:"+yycolumn+">");
}
