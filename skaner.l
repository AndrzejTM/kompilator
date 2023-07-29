%{
    #include <stdio.h>
    #include <string.h>
    #include <limits.h>

    enum {TOKEN_PLUS, TOKEN_MINUS, TOKEN_MULT, TOKEN_DIV, TOKEN_MODULUS,
        TOKEN_EXP, TOKEN_INCREMENT, TOKEN_DECREMENT, TOKEN_NOT, TOKEN_AND, TOKEN_OR,
        TOKEN_ASSIGNMENT, TOKEN_GE, TOKEN_GT, TOKEN_LE, TOKEN_LT, TOKEN_EQ, TOKEN_NEQ,
        TOKEN_AUTO, TOKEN_ELSE, TOKEN_TRUE, TOKEN_FALSE, TOKEN_FOR, TOKEN_WHILE, TOKEN_IF,
        TOKEN_FUNCTION, TOKEN_PRINT, TOKEN_RETURN, TOKEN_VOID, TOKEN_ARRAY, TOKEN_CHAR,
        TOKEN_STRING, TOKEN_BOOLEAN, TOKEN_LEFTPAREN, TOKEN_RIGHTPAREN, TOKEN_LEFTSQ, TOKEN_RIGHTSQ,
        TOKEN_LEFTCURL, TOKEN_RIGHTCURL, TOKEN_IDENT, TOKEN_STRING_LITERAL, TOKEN_CHAR_LITERAL,
        TOKEN_INT_LITERAL, TOKEN_INT, TOKEN_ERROR, TOKEN_SEMICOLON, TOKEN_COLON, TOKEN_COMMA};

    char *tokentotext(int t)
    {
        if (t == TOKEN_ERROR) return "ERROR";
        else if (t == TOKEN_PLUS) return "PLUS";
        else if (t == TOKEN_MINUS) return "MINUS";
        else if (t == TOKEN_MULT) return "MULT";
        else if (t == TOKEN_DIV) return "DIV";
        else if (t == TOKEN_MODULUS) return "MODULUS";
        else if (t == TOKEN_EXP) return "EXP";
        else if (t == TOKEN_INCREMENT) return "INCREMENT";
        else if (t == TOKEN_DECREMENT) return "DECREMENT";
        else if (t == TOKEN_NOT) return "LOGIC_NOT";
        else if (t == TOKEN_AND) return "LOGIC_AND";
        else if (t == TOKEN_OR) return "LOGIC_OR";
        else if (t == TOKEN_ASSIGNMENT) return "ASSIGNMENT";
        else if (t == TOKEN_GE) return "GE";
        else if (t == TOKEN_GT) return "GT";
        else if (t == TOKEN_LE) return "LT";
        else if (t == TOKEN_EQ) return "EQ";
        else if (t == TOKEN_LT) return "LT";
        else if (t == TOKEN_NEQ) return "NEQ";
        else if (t == TOKEN_AUTO) return "AUTO";
        else if (t == TOKEN_ELSE) return "ELSE";
        else if (t == TOKEN_TRUE) return "TRUE";
        else if (t == TOKEN_FALSE) return "FALSE";
        else if (t == TOKEN_FOR) return "FOR";
        else if (t == TOKEN_WHILE) return "WHILE";
        else if (t == TOKEN_IF) return "IF";
        else if (t == TOKEN_FUNCTION) return "FUNCTION";
        else if (t == TOKEN_PRINT) return "PRINT";
        else if (t == TOKEN_RETURN) return "RETURN";
        else if (t == TOKEN_VOID) return "VOID";
        else if (t == TOKEN_ARRAY) return "ARRAY";
        else if (t == TOKEN_CHAR) return "CHARACTER";
        else if (t == TOKEN_STRING) return "STRING";
        else if (t == TOKEN_BOOLEAN) return "BOOLEAN";
        else if (t == TOKEN_LEFTPAREN) return "LEFT_PARENTHESIS";
        else if (t == TOKEN_RIGHTPAREN) return "RIGHT_PARENTHESIS";
        else if (t == TOKEN_LEFTSQ) return "LEFT_SQUARE";
        else if (t == TOKEN_RIGHTSQ) return "RIGHT_SQUARE";
        else if (t == TOKEN_LEFTCURL) return "LEFT_CURLY";
        else if (t == TOKEN_RIGHTCURL) return "RIGHT_CURLY";
        else if (t == TOKEN_IDENT) return "IDENTIFIER";
        else if (t == TOKEN_STRING_LITERAL) return "STRING_LITERAL";
        else if (t == TOKEN_CHAR_LITERAL) return "CHARACTER_LITERAL";
        else if (t == TOKEN_INT_LITERAL) return "INTEGER_LITERAL";
        else if (t == TOKEN_INT) return "INTEGER";
        else if (t == TOKEN_ERROR) return "ERROR";
        else if (t == TOKEN_SEMICOLON) return "SEMICOLON";
        else if (t == TOKEN_COLON) return "COLON";
        else if (t == TOKEN_COMMA) return "COMMA";
        else return 0;
    }
%}

%option nounput
%option noinput
%option yylineno
%option noyywrap

DIGIT [0-9]
LETTER [a-zA-Z]

%%
(\t|\n|\r|\ )+  // biale znaki

(\/\/.+)|"/*"([^*]|(\*+[^*/]))*\*+\/

\+\+    {return TOKEN_INCREMENT;}
\+      {return TOKEN_PLUS;}
-       {return TOKEN_MINUS;}
--      {return TOKEN_DECREMENT;}
\*      {return TOKEN_MULT;}
\/      {return TOKEN_DIV;}
%       {return TOKEN_MODULUS;}
\^      {return TOKEN_EXP;}
!       {return TOKEN_NOT;}
&&      {return TOKEN_AND;}
\|\|    {return TOKEN_OR;}
\=      {return TOKEN_ASSIGNMENT;}
\<      {return TOKEN_LT;}
\<\=    {return TOKEN_LE;}
\>      {return TOKEN_GT;}
\>\=    {return TOKEN_GE;}
\=\=    {return TOKEN_EQ;}
\!\=    {return TOKEN_NEQ;}
auto    {return TOKEN_AUTO;}
else    {return TOKEN_ELSE;}
true    {return TOKEN_TRUE;}
false   {return TOKEN_FALSE;}
for     {return TOKEN_FOR;}
while   {return TOKEN_WHILE;}
if      {return TOKEN_IF;}
function {return TOKEN_FUNCTION;}
print   {return TOKEN_PRINT;}
return  {return TOKEN_RETURN;}
void    {return TOKEN_VOID;}
array   {return TOKEN_ARRAY;}
boolean {return TOKEN_BOOLEAN;}
string  {return TOKEN_STRING;}
char    {return TOKEN_CHAR;}
integer {return TOKEN_INT;}
\(      {return TOKEN_LEFTPAREN;}
\)      {return TOKEN_RIGHTPAREN;}
\[      {return TOKEN_LEFTSQ;}
\]      {return TOKEN_RIGHTSQ;}
\{      {return TOKEN_LEFTCURL;}
\}      {return TOKEN_RIGHTCURL;}
;       {return TOKEN_SEMICOLON;}
:       {return TOKEN_COLON;}
,       {return TOKEN_COMMA;}
\"([^"\\]|\\.|\\\n)*\"  {if (strlen(yytext) > 160) {
                fprintf(stderr, "error: string drnluzszy niz 160 znakow\n");
                return TOKEN_ERROR;}
                return TOKEN_STRING_LITERAL;}
'(\\?.?)'   {if (!strcmp(yytext, "''")){
                fprintf(stderr, "skan error: nie moze byc pusty znak\n");
                return TOKEN_ERROR;}               
            else if(!strcmp(yytext, "'\\'")){
                fprintf(stderr, "skan error: nieprawidlowy znak");
                return TOKEN_ERROR;}
            char BUFF[160];
            for (int i=0; i<strlen(yytext); i++)
            {
                BUFF[i] = yytext[i+1];
            }
            BUFF[strlen(yytext) - 2] = '\0';
            if (BUFF[0] = '\\') 
            {
                if((BUFF[1] == 'n') || (BUFF[1] == '0')
                || (BUFF[1] == '\\'))
                {
                    return TOKEN_CHAR_LITERAL;
                }
                else
                {
                    return TOKEN_CHAR_LITERAL;
                }
            }
            return TOKEN_CHAR_LITERAL;
}
{DIGIT}+    {if (strtol(yytext, NULL, 10) == LONG_MIN)
            {
                fprintf(stderr, "skan error: integer underflow\n");
                return TOKEN_ERROR;
            }
            else if (strtol(yytext, NULL, 10) == LONG_MAX)
            {
                fprintf(stderr, "skan error: integer overflow\n");
                return TOKEN_ERROR;
            }
            else
            {
                return TOKEN_INT_LITERAL;
            }}
({LETTER}|_)(({LETTER}|{DIGIT}|_)*) {
            if(strlen(yytext)>160)
            {
                fprintf(stderr, "skan error: nazwa dluzsza niz 160 znakow\n");
                return TOKEN_ERROR;
            }
            return TOKEN_IDENT;}

.   {
        fprintf(stderr, "skan error: %s to niewlasciwy token\n", yytext);
        return TOKEN_ERROR;
    }
%%

int main(int argc, char **argv)
{
    int tok;
    while(1)
    {  
        tok = yylex();
        printf("%s\n", tokentotext(tok));
        if (tok == TOKEN_IDENT)
        {
            printf("%s\n", yytext);
        }
        else if (tok == TOKEN_INT_LITERAL)
        {
            printf("%s\n", yytext);
        }
    }
    return 0;
}