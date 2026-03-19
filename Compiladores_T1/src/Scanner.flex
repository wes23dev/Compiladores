%%
%standalone
%line
%column
%class Scanner

/* ---------------- MACROS ---------------- */

letra = [A-Za-z]
digito = [0-9]
digitos = {digito}+

ident = {letra}({letra}|{digito})*

numero = {digito}+(\.{digito}+)?
numeroCientifico = -?{digito}+(\.{digito}+)?[Ee]{digito}+

aspas = \"
conteudo = [^\"]*
strLiteral = {aspas}{conteudo}{aspas}

espaco = ({fimdeLinha}|[ \t]|{branco})+
branco = " "

fimdeLinha = \r|\n|\r\n

/* palavras-chave */

KW_STRING = "String"
KW_INT = "int"
KW_BOOL = "bool"
KW_CHAR = "char"
KW_DOUBLE = "double"
KW_string = "string"
KW_FLOAT = "float"
KW_WHILE = "while"
KW_COUT = "cout"
kw_program = "program"
kw_class = "class"
kw_void = "void"
kw_main = "main"
kw_new = "new"
kw_print = "print"
KW_if = "if"
KW_else = "else"
KW_for = "for"

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
virgula = ","


/* ---------------- EXPRESSÕES ---------------- */
tipoVariavel = {KW_INT}|{KW_FLOAT}|{KW_DOUBLE}|{KW_CHAR}|{KW_STRING}|{KW_BOOL}|{KW_string}

tipoMetodo = {kw_void}

tipoEstrutura = {kw_program}|{kw_class}|{kw_main}

tipoComando = {kw_print}|{kw_new}

tipoCondicao = {KW_if}|{KW_else}|{KW_for}|{KW_WHILE}

palavrasReservadas = {tipoVariavel}|{tipoCondicao}|{tipoMetodo}|{tipoEstrutura}|{tipoComando}

relop = ("="|"=="|"!="|"<"|">"|"<="|">=")

declaracaoVariavel = {tipoVariavel}{espaco}*{ident}{espaco}*{relop}{espaco}*{strLiteral}?{espaco}*";"

declaracaoSimples = {tipoVariavel}{espaco}*{ident}{espaco}*";"

fracao = ("\."{digitos})?

exponencial = ("E"("+"|"-")?{digitos})?

numReal = ("-"?){digitos}{fracao}{exponencial}

letraHex = [A-Fa-f]

hexadecimal = "0x"({letraHex}|{digito})+

PONTO = "\."

comentarioG = "/*"~"*/"

simbolo = {PONTO_VIRG}|{ABRE_PAR}|{FECHA_PAR}|{ABRE_CH}|{FECHA_CH}|{OP_ATRIB}|{OP_CONCAT}|{OP_MENORIGUAL}|{PONTO}|{virgula}

%%


{comentarioG} { System.out.println("[" + yyline + "," + yycolumn + "]" + " comentario_grande: " + yytext()); }

{espaco} { /* ignorar */ }

{palavrasReservadas} { System.out.println("[" + yyline + "," + yycolumn + "]" + " palavra_reservada: " + yytext()); }

{simbolo} { System.out.println("[" + yyline + "," + yycolumn + "]" + " simbolo: " + yytext()); }

{ident} { System.out.println("[" + yyline + "," + yycolumn + "]" + " ident: " + yytext()); }

{numReal} { System.out.println("[" + yyline + "," + yycolumn + "]" + " num_real: " + yytext()); }

{hexadecimal} { System.out.println("[" + yyline + "," + yycolumn + "]" + " num_hexadecimal: " + yytext()); }

{strLiteral} { System.out.println("[" + yyline + "," + yycolumn + "]" + " str_literal: " + yytext()); }
