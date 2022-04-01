grammar ECL;
expressionconstraint : ws ( refinedexpressionconstraint | compoundexpressionconstraint | simpleexpressionconstraint ) ws;
simpleexpressionconstraint :  (constraintoperator ws)? focusconcept;
refinedexpressionconstraint : simpleexpressionconstraint  ws COLON ws refinement;
compoundexpressionconstraint : conjunctionexpressionconstraint | disjunctionexpressionconstraint | exclusionexpressionconstraint;
conjunctionexpressionconstraint : subexpressionconstraint (ws conjunction ws subexpressionconstraint)+;
disjunctionexpressionconstraint : subexpressionconstraint (ws disjunction ws subexpressionconstraint)+;
exclusionexpressionconstraint : subexpressionconstraint ws exclusion ws subexpressionconstraint;
subexpressionconstraint : simpleexpressionconstraint | 	(LEFT_PAREN ws (compoundexpressionconstraint | refinedexpressionconstraint) ws RIGHT_PAREN);
focusconcept : ( memberof ws )? (conceptreference | wildcard);
memberof : CARAT;
conceptreference : conceptid (ws PIPE ws term ws PIPE)?;
conceptid : sctid;
term : nonwsnonpipe+ ( sp+ nonwsnonpipe+ )*;
wildcard : ASTERISK;
constraintoperator : descendantorselfof | descendantof |  ancestororselfof | ancestorof;
descendantof : LESS_THAN;
descendantorselfof : (LESS_THAN LESS_THAN);
ancestorof : GREATER_THAN;
ancestororselfof : (GREATER_THAN GREATER_THAN);
conjunction : (((CAP_A | A)|(CAP_A | A)) ((CAP_N | N)|(CAP_N | N)) ((CAP_D | D)|(CAP_D | D)) mws) | COMMA;
disjunction : ((CAP_O | O)|(CAP_O | O)) ((CAP_R | R)|(CAP_R | R)) mws;
exclusion : ((CAP_M | M)|(CAP_M | M)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N)) ((CAP_U | U)|(CAP_U | U)) ((CAP_S | S)|(CAP_S | S)) mws;
refinement : subrefinement ws (conjunctionrefinementset | disjunctionrefinementset)?;
conjunctionrefinementset : (ws conjunction ws subrefinement)+;
disjunctionrefinementset : (ws disjunction ws subrefinement)+;
subrefinement : attributeset | attributegroup | (LEFT_PAREN ws refinement ws RIGHT_PAREN);
attributeset : subattributeset ws (conjunctionattributeset | disjunctionattributeset)?;
conjunctionattributeset : (ws conjunction ws subattributeset)+;
disjunctionattributeset : (ws disjunction ws subattributeset)+;
subattributeset : attribute | (LEFT_PAREN ws attributeset ws RIGHT_PAREN);
attributegroup : (cardinality ws)? LEFT_CURLY_BRACE ws attributeset ws RIGHT_CURLY_BRACE;
attribute : (cardinality ws)? (reverseflag ws)? (attributeoperator ws)? attributename ws ((expressioncomparisonoperator ws expressionconstraintvalue) | (numericcomparisonoperator ws numericvalue) | (stringcomparisonoperator ws stringvalue) );
cardinality : LEFT_BRACE nonnegativeintegervalue to (nonnegativeintegervalue | many) RIGHT_BRACE;
to : (PERIOD PERIOD);
many : ASTERISK;
reverseflag :  (CAP_R | R);
attributeoperator : descendantorselfof | descendantof;
attributename : conceptreference | wildcard;
expressionconstraintvalue : simpleexpressionconstraint | (LEFT_PAREN ws (refinedexpressionconstraint | compoundexpressionconstraint) ws RIGHT_PAREN);
expressioncomparisonoperator : EQUALS | (EXCLAMATION EQUALS);
numericcomparisonoperator : EQUALS | (EXCLAMATION EQUALS) | (LESS_THAN EQUALS) | LESS_THAN | (GREATER_THAN EQUALS) | GREATER_THAN;
stringcomparisonoperator : EQUALS | (EXCLAMATION EQUALS);
numericvalue :  HASH ( decimalvalue | integervalue);
stringvalue :  qm (anynonescapedchar | escapedchar)+ qm;
integervalue : ( (DASH|PLUS)? digitnonzero digit* ) | zero;
decimalvalue : integervalue PERIOD digit+;
nonnegativeintegervalue : (digitnonzero digit* ) | zero;
sctid : digitnonzero (( digit ) (digit) (digit) (digit) (digit) (((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit)) | ((digit) (digit) (digit)) | ((digit) (digit)) | (digit)?));
ws : ( sp | htab | cr | lf )*; // optional white space
mws : ( sp | htab | cr | lf )+; // mandatory white space
sp : SPACE; // space
htab : TAB; // tab
cr : CR; // carriage return
lf : LF; // line feed
qm : QUOTE; // quotation mark
bs : BACKSLASH; // back slash
digit : (ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE);
zero : ZERO;
digitnonzero : (ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE);
nonwsnonpipe : (EXCLAMATION | QUOTE | HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE | BACKSLASH | RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE) | (RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
anynonescapedchar : htab | cr | lf | (SPACE | EXCLAMATION) | (HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE) | (RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE | PIPE | RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
escapedchar : (bs qm) | (bs bs);

////////////////////////////////////////////////////////////////////////////////////////////
// Lexer rules generated for each distinct character in original grammar
// Simplified character names based on Unicode (http://www.unicode.org/charts/PDF/U0000.pdf)
////////////////////////////////////////////////////////////////////////////////////////////
UTF8_LETTER
   : '\u00C0' .. '\u02FF'
   | '\u0370' .. '\u037D'
   | '\u037F' .. '\u1FFF'
   | '\u200C' .. '\u200D'
   | '\u2070' .. '\u218F'
   | '\u2C00' .. '\u2FEF'
   | '\u3001' .. '\uD7FF'
   | '\uF900' .. '\uFDCF'
   | '\uFDF0' .. '\uFFFD'
   ;
TAB : '\u0009';
LF : '\u000A';
CR : '\u000D';
SPACE : ' ';
EXCLAMATION : '!';
QUOTE : '"';
HASH : '#';
DOLLAR : '$';
PERCENT : '%';
AMPERSAND : '&';
APOSTROPHE : '\'';
LEFT_PAREN : '(';
RIGHT_PAREN : ')';
ASTERISK : '*';
PLUS : '+';
COMMA : ',';
DASH : '-';
PERIOD : '.';
SLASH : '/';
ZERO : '0';
ONE : '1';
TWO : '2';
THREE : '3';
FOUR : '4';
FIVE : '5';
SIX : '6';
SEVEN : '7';
EIGHT : '8';
NINE : '9';
COLON : ':';
SEMICOLON : ';';
LESS_THAN : '<';
EQUALS : '=';
GREATER_THAN : '>';
QUESTION : '?';
AT : '@';
CAP_A : 'A';
CAP_B : 'B';
CAP_C : 'C';
CAP_D : 'D';
CAP_E : 'E';
CAP_F : 'F';
CAP_G : 'G';
CAP_H : 'H';
CAP_I : 'I';
CAP_J : 'J';
CAP_K : 'K';
CAP_L : 'L';
CAP_M : 'M';
CAP_N : 'N';
CAP_O : 'O';
CAP_P : 'P';
CAP_Q : 'Q';
CAP_R : 'R';
CAP_S : 'S';
CAP_T : 'T';
CAP_U : 'U';
CAP_V : 'V';
CAP_W : 'W';
CAP_X : 'X';
CAP_Y : 'Y';
CAP_Z : 'Z';
LEFT_BRACE : '[';
BACKSLASH : '\\';
RIGHT_BRACE : ']';
CARAT : '^';
UNDERSCORE : '_';
ACCENT : '`';
A : 'a';
B : 'b';
C : 'c';
D : 'd';
E : 'e';
F : 'f';
G : 'g';
H : 'h';
I : 'i';
J : 'j';
K : 'k';
L : 'l';
M : 'm';
N : 'n';
O : 'o';
P : 'p';
Q : 'q';
R : 'r';
S : 's';
T : 't';
U : 'u';
V : 'v';
W : 'w';
X : 'x';
Y : 'y';
Z : 'z';
LEFT_CURLY_BRACE : '{';
PIPE : '|';
RIGHT_CURLY_BRACE : '}';
TILDE : '~';
