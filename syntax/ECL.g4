grammar ECL;
expressionconstraint : ws ( refinedexpressionconstraint | compoundexpressionconstraint | dottedexpressionconstraint | subexpressionconstraint ) ws;
refinedexpressionconstraint : subexpressionconstraint ws COLON ws eclrefinement;
compoundexpressionconstraint : conjunctionexpressionconstraint | disjunctionexpressionconstraint | exclusionexpressionconstraint;
conjunctionexpressionconstraint : subexpressionconstraint (ws conjunction ws subexpressionconstraint)+;
disjunctionexpressionconstraint : subexpressionconstraint (ws disjunction ws subexpressionconstraint)+;
exclusionexpressionconstraint : subexpressionconstraint ws exclusion ws subexpressionconstraint;
dottedexpressionconstraint : subexpressionconstraint (ws dottedexpressionattribute)+;
dottedexpressionattribute : dot ws eclattributename;
subexpressionconstraint: (constraintoperator ws)? ( ( (memberof ws)? (eclfocusconcept | (LEFT_PAREN ws expressionconstraint ws RIGHT_PAREN)) (ws memberfilterconstraint)*) | (eclfocusconcept | (LEFT_PAREN ws expressionconstraint ws RIGHT_PAREN)) ) (ws (descriptionfilterconstraint | conceptfilterconstraint))* (ws historysupplement)?;
eclfocusconcept : eclconceptreference | wildcard;
dot : PERIOD;
memberof : CARAT ( ws LEFT_BRACE ws (refsetfieldset | wildcard) ws RIGHT_BRACE )?;
refsetfieldset : refsetfield (ws COMMA ws refsetfield)*;
refsetfield : refsetfieldname | refsetfieldref;
refsetfieldname : alpha+;
refsetfieldref : eclconceptreference;
eclconceptreference : conceptid (ws PIPE ws term ws PIPE)?;
eclconceptreferenceset : LEFT_PAREN ws eclconceptreference (mws eclconceptreference)+ ws RIGHT_PAREN;
conceptid : sctid;
term : nonwsnonpipe+ ( sp+ nonwsnonpipe+ )*;
wildcard : ASTERISK;
constraintoperator : childof | childorselfof | descendantorselfof | descendantof | parentof | parentorselfof | ancestororselfof | ancestorof;
descendantof : LESS_THAN;
descendantorselfof : (LESS_THAN LESS_THAN);
childof : (LESS_THAN EXCLAMATION);
childorselfof : (LESS_THAN LESS_THAN EXCLAMATION);
ancestorof : GREATER_THAN;
ancestororselfof : (GREATER_THAN GREATER_THAN);
parentof : (GREATER_THAN EXCLAMATION);
parentorselfof : (GREATER_THAN GREATER_THAN EXCLAMATION);
conjunction : (((CAP_A | A)|(CAP_A | A)) ((CAP_N | N)|(CAP_N | N)) ((CAP_D | D)|(CAP_D | D)) mws) | COMMA;
disjunction : ((CAP_O | O)|(CAP_O | O)) ((CAP_R | R)|(CAP_R | R)) mws;
exclusion : ((CAP_M | M)|(CAP_M | M)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N)) ((CAP_U | U)|(CAP_U | U)) ((CAP_S | S)|(CAP_S | S)) mws;
eclrefinement : subrefinement ws (conjunctionrefinementset | disjunctionrefinementset)?;
conjunctionrefinementset : (ws conjunction ws subrefinement)+;
disjunctionrefinementset : (ws disjunction ws subrefinement)+;
subrefinement : eclattributeset | eclattributegroup | (LEFT_PAREN ws eclrefinement ws RIGHT_PAREN);
eclattributeset : subattributeset ws (conjunctionattributeset | disjunctionattributeset)?;
conjunctionattributeset : (ws conjunction ws subattributeset)+;
disjunctionattributeset : (ws disjunction ws subattributeset)+;
subattributeset : eclattribute | (LEFT_PAREN ws eclattributeset ws RIGHT_PAREN);
eclattributegroup : (LEFT_BRACE cardinality RIGHT_BRACE ws)? LEFT_CURLY_BRACE ws eclattributeset ws RIGHT_CURLY_BRACE;
eclattribute : (LEFT_BRACE cardinality RIGHT_BRACE ws)? (reverseflag ws)? eclattributename ws ((expressioncomparisonoperator ws subexpressionconstraint) | (numericcomparisonoperator ws HASH numericvalue) | (stringcomparisonoperator ws (typedsearchterm | typedsearchtermset)) | (booleancomparisonoperator ws booleanvalue));
cardinality : minvalue to maxvalue;
minvalue : nonnegativeintegervalue;
to : (PERIOD PERIOD);
maxvalue : nonnegativeintegervalue | many;
many : ASTERISK;
reverseflag : (CAP_R | R);
eclattributename : subexpressionconstraint;
expressioncomparisonoperator : EQUALS | (EXCLAMATION EQUALS);
numericcomparisonoperator : EQUALS | (EXCLAMATION EQUALS) | (LESS_THAN EQUALS) | LESS_THAN | (GREATER_THAN EQUALS) | GREATER_THAN;
timecomparisonoperator : EQUALS | (EXCLAMATION EQUALS) | (LESS_THAN EQUALS) | LESS_THAN | (GREATER_THAN EQUALS) | GREATER_THAN;
stringcomparisonoperator : EQUALS | (EXCLAMATION EQUALS);
booleancomparisonoperator : EQUALS | (EXCLAMATION EQUALS);
descriptionfilterconstraint : (LEFT_CURLY_BRACE LEFT_CURLY_BRACE) ws ( (CAP_D | D) | (CAP_D | D) )? ws descriptionfilter (ws COMMA ws descriptionfilter)* ws (RIGHT_CURLY_BRACE RIGHT_CURLY_BRACE);
descriptionfilter : termfilter | languagefilter | typefilter | dialectfilter | modulefilter | effectivetimefilter | activefilter;
termfilter : termkeyword ws stringcomparisonoperator ws (typedsearchterm | typedsearchtermset);
termkeyword : ((CAP_T | T)|(CAP_T | T)) ((CAP_E | E)|(CAP_E | E)) ((CAP_R | R)|(CAP_R | R)) ((CAP_M | M)|(CAP_M | M));
typedsearchterm : ( ( matchkeyword ws COLON ws )? matchsearchtermset ) | ( wild ws COLON ws wildsearchtermset );
typedsearchtermset : LEFT_PAREN ws typedsearchterm (mws typedsearchterm)* ws RIGHT_PAREN;
wild : ((CAP_W | W)|(CAP_W | W)) ((CAP_I | I)|(CAP_I | I)) ((CAP_L | L)|(CAP_L | L)) ((CAP_D | D)|(CAP_D | D));
matchkeyword : ((CAP_M | M)|(CAP_M | M)) ((CAP_A | A)|(CAP_A | A)) ((CAP_T | T)|(CAP_T | T)) ((CAP_C | C)|(CAP_C | C)) ((CAP_H | H)|(CAP_H | H));
matchsearchterm : (nonwsnonescapedchar | escapedchar)+;
matchsearchtermset : qm ws matchsearchterm (mws matchsearchterm)* ws qm;
wildsearchterm : (anynonescapedchar | escapedwildchar)+;
wildsearchtermset : qm wildsearchterm qm;
languagefilter : language ws booleancomparisonoperator ws (languagecode | languagecodeset);
language : ((CAP_L | L)|(CAP_L | L)) ((CAP_A | A)|(CAP_A | A)) ((CAP_N | N)|(CAP_N | N)) ((CAP_G | G)|(CAP_G | G)) ((CAP_U | U)|(CAP_U | U)) ((CAP_A | A)|(CAP_A | A)) ((CAP_G | G)|(CAP_G | G)) ((CAP_E | E)|(CAP_E | E));
languagecode : (alpha alpha);
languagecodeset : LEFT_PAREN ws languagecode (mws languagecode)* ws RIGHT_PAREN;
typefilter : typeidfilter | typetokenfilter;
typeidfilter : typeid ws booleancomparisonoperator ws (subexpressionconstraint | eclconceptreferenceset);
typeid : ((CAP_T | T)|(CAP_T | T)) ((CAP_Y | Y)|(CAP_Y | Y)) ((CAP_P | P)|(CAP_P | P)) ((CAP_E | E)|(CAP_E | E)) ((CAP_I | I)|(CAP_I | I)) ((CAP_D | D)|(CAP_D | D));
typetokenfilter : type ws booleancomparisonoperator ws (typetoken | typetokenset);
type : ((CAP_T | T)|(CAP_T | T)) ((CAP_Y | Y)|(CAP_Y | Y)) ((CAP_P | P)|(CAP_P | P)) ((CAP_E | E)|(CAP_E | E));
typetoken : synonym | fullyspecifiedname | definition;
typetokenset : LEFT_PAREN ws typetoken (mws typetoken)* ws RIGHT_PAREN;
synonym : ((CAP_S | S)|(CAP_S | S)) ((CAP_Y | Y)|(CAP_Y | Y)) ((CAP_N | N)|(CAP_N | N));
fullyspecifiedname : ((CAP_F | F)|(CAP_F | F)) ((CAP_S | S)|(CAP_S | S)) ((CAP_N | N)|(CAP_N | N));
definition : ((CAP_D | D)|(CAP_D | D)) ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F));
dialectfilter : (dialectidfilter | dialectaliasfilter) ( ws acceptabilityset )?;
dialectidfilter : dialectid ws booleancomparisonoperator ws (subexpressionconstraint | dialectidset);
dialectid : ((CAP_D | D)|(CAP_D | D)) ((CAP_I | I)|(CAP_I | I)) ((CAP_A | A)|(CAP_A | A)) ((CAP_L | L)|(CAP_L | L)) ((CAP_E | E)|(CAP_E | E)) ((CAP_C | C)|(CAP_C | C)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_D | D)|(CAP_D | D));
dialectaliasfilter : dialect ws booleancomparisonoperator ws (dialectalias | dialectaliasset);
dialect : ((CAP_D | D)|(CAP_D | D)) ((CAP_I | I)|(CAP_I | I)) ((CAP_A | A)|(CAP_A | A)) ((CAP_L | L)|(CAP_L | L)) ((CAP_E | E)|(CAP_E | E)) ((CAP_C | C)|(CAP_C | C)) ((CAP_T | T)|(CAP_T | T));
dialectalias : alpha ( dash | alpha | integervalue)*;
dialectaliasset : LEFT_PAREN ws dialectalias (ws acceptabilityset)? (mws dialectalias (ws acceptabilityset)? )* ws RIGHT_PAREN;
dialectidset : LEFT_PAREN ws eclconceptreference (ws acceptabilityset)? (mws eclconceptreference (ws acceptabilityset)? )* ws RIGHT_PAREN;
acceptabilityset : acceptabilityconceptreferenceset | acceptabilitytokenset;
acceptabilityconceptreferenceset : LEFT_PAREN ws eclconceptreference (mws eclconceptreference)* ws RIGHT_PAREN;
acceptabilitytokenset : LEFT_PAREN ws acceptabilitytoken (mws acceptabilitytoken)* ws RIGHT_PAREN;
acceptabilitytoken : acceptable | preferred;
acceptable : ((CAP_A | A)|(CAP_A | A)) ((CAP_C | C)|(CAP_C | C)) ((CAP_C | C)|(CAP_C | C)) ((CAP_E | E)|(CAP_E | E)) ((CAP_P | P)|(CAP_P | P)) ((CAP_T | T)|(CAP_T | T));
preferred : ((CAP_P | P)|(CAP_P | P)) ((CAP_R | R)|(CAP_R | R)) ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F)) ((CAP_E | E)|(CAP_E | E)) ((CAP_R | R)|(CAP_R | R));
conceptfilterconstraint : (LEFT_CURLY_BRACE LEFT_CURLY_BRACE) ws ((CAP_C | C) | (CAP_C | C)) ws conceptfilter (ws COMMA ws conceptfilter)* ws (RIGHT_CURLY_BRACE RIGHT_CURLY_BRACE);
conceptfilter : definitionstatusfilter | modulefilter | effectivetimefilter | activefilter;
definitionstatusfilter : definitionstatusidfilter | definitionstatustokenfilter;
definitionstatusidfilter : definitionstatusidkeyword ws booleancomparisonoperator ws (subexpressionconstraint | eclconceptreferenceset);
definitionstatusidkeyword : ((CAP_D | D)|(CAP_D | D)) ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N)) ((CAP_I | I)|(CAP_I | I)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_O | O)|(CAP_O | O)) ((CAP_N | N)|(CAP_N | N)) ((CAP_S | S)|(CAP_S | S)) ((CAP_T | T)|(CAP_T | T)) ((CAP_A | A)|(CAP_A | A)) ((CAP_T | T)|(CAP_T | T)) ((CAP_U | U)|(CAP_U | U)) ((CAP_S | S)|(CAP_S | S)) ((CAP_I | I)|(CAP_I | I)) ((CAP_D | D)|(CAP_D | D));
definitionstatustokenfilter : definitionstatuskeyword ws booleancomparisonoperator ws (definitionstatustoken | definitionstatustokenset);
definitionstatuskeyword : ((CAP_D | D)|(CAP_D | D)) ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N)) ((CAP_I | I)|(CAP_I | I)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_O | O)|(CAP_O | O)) ((CAP_N | N)|(CAP_N | N)) ((CAP_S | S)|(CAP_S | S)) ((CAP_T | T)|(CAP_T | T)) ((CAP_A | A)|(CAP_A | A)) ((CAP_T | T)|(CAP_T | T)) ((CAP_U | U)|(CAP_U | U)) ((CAP_S | S)|(CAP_S | S));
definitionstatustoken : primitivetoken | definedtoken;
definitionstatustokenset : LEFT_PAREN ws definitionstatustoken (mws definitionstatustoken)* ws RIGHT_PAREN;
primitivetoken : ((CAP_P | P)|(CAP_P | P)) ((CAP_R | R)|(CAP_R | R)) ((CAP_I | I)|(CAP_I | I)) ((CAP_M | M)|(CAP_M | M)) ((CAP_I | I)|(CAP_I | I)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_V | V)|(CAP_V | V)) ((CAP_E | E)|(CAP_E | E));
definedtoken : ((CAP_D | D)|(CAP_D | D)) ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N)) ((CAP_E | E)|(CAP_E | E)) ((CAP_D | D)|(CAP_D | D));
modulefilter : moduleidkeyword ws booleancomparisonoperator ws (subexpressionconstraint | eclconceptreferenceset);
moduleidkeyword : ((CAP_M | M)|(CAP_M | M)) ((CAP_O | O)|(CAP_O | O)) ((CAP_D | D)|(CAP_D | D)) ((CAP_U | U)|(CAP_U | U)) ((CAP_L | L)|(CAP_L | L)) ((CAP_E | E)|(CAP_E | E)) ((CAP_I | I)|(CAP_I | I)) ((CAP_D | D)|(CAP_D | D));
effectivetimefilter : effectivetimekeyword ws timecomparisonoperator ws ( timevalue | timevalueset );
effectivetimekeyword : ((CAP_E | E)|(CAP_E | E)) ((CAP_F | F)|(CAP_F | F)) ((CAP_F | F)|(CAP_F | F)) ((CAP_E | E)|(CAP_E | E)) ((CAP_C | C)|(CAP_C | C)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_V | V)|(CAP_V | V)) ((CAP_E | E)|(CAP_E | E)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_M | M)|(CAP_M | M)) ((CAP_E | E)|(CAP_E | E));
timevalue : qm ( year month day )? qm;
timevalueset : LEFT_PAREN ws timevalue (mws timevalue)* ws RIGHT_PAREN;
year : digitnonzero digit digit digit;
month : (ZERO ONE) | (ZERO TWO) | (ZERO THREE) | (ZERO FOUR) | (ZERO FIVE) | (ZERO SIX) | (ZERO SEVEN) | (ZERO EIGHT) | (ZERO NINE) | (ONE ZERO) | (ONE ONE) | (ONE TWO);
day : (ZERO ONE) | (ZERO TWO) | (ZERO THREE) | (ZERO FOUR) | (ZERO FIVE) | (ZERO SIX) | (ZERO SEVEN) | (ZERO EIGHT) | (ZERO NINE) | (ONE ZERO) | (ONE ONE) | (ONE TWO) | (ONE THREE) | (ONE FOUR) | (ONE FIVE) | (ONE SIX) | (ONE SEVEN) | (ONE EIGHT) | (ONE NINE) | (TWO ZERO) | (TWO ONE) | (TWO TWO) | (TWO THREE) | (TWO FOUR) | (TWO FIVE) | (TWO SIX) | (TWO SEVEN) | (TWO EIGHT) | (TWO NINE) | (THREE ZERO) | (THREE ONE);
activefilter : activekeyword ws booleancomparisonoperator ws activevalue;
activekeyword : ((CAP_A | A)|(CAP_A | A)) ((CAP_C | C)|(CAP_C | C)) ((CAP_T | T)|(CAP_T | T)) ((CAP_I | I)|(CAP_I | I)) ((CAP_V | V)|(CAP_V | V)) ((CAP_E | E)|(CAP_E | E));
activevalue : activetruevalue | activefalsevalue;
activetruevalue : ONE | ((CAP_T | T) (CAP_R | R) (CAP_U | U) (CAP_E | E));
activefalsevalue : ZERO | ((CAP_F | F) (CAP_A | A) (CAP_L | L) (CAP_S | S) (CAP_E | E));
memberfilterconstraint : (LEFT_CURLY_BRACE LEFT_CURLY_BRACE) ws ((CAP_M | M) | (CAP_M | M)) ws memberfilter (ws COMMA ws memberfilter)* ws (RIGHT_CURLY_BRACE RIGHT_CURLY_BRACE);
memberfilter : memberfieldfilter | modulefilter | effectivetimefilter | activefilter;
memberfieldfilter : refsetfieldname ws ((expressioncomparisonoperator ws subexpressionconstraint) | (numericcomparisonoperator ws HASH numericvalue) | (stringcomparisonoperator ws (typedsearchterm | typedsearchtermset)) | (booleancomparisonoperator ws booleanvalue) | (ws timecomparisonoperator ws (timevalue | timevalueset)) );
historysupplement : (LEFT_CURLY_BRACE LEFT_CURLY_BRACE) ws PLUS ws historykeyword ( historyprofilesuffix | (ws historysubset) )? ws (RIGHT_CURLY_BRACE RIGHT_CURLY_BRACE);
historykeyword : ((CAP_H | H)|(CAP_H | H)) ((CAP_I | I)|(CAP_I | I)) ((CAP_S | S)|(CAP_S | S)) ((CAP_T | T)|(CAP_T | T)) ((CAP_O | O)|(CAP_O | O)) ((CAP_R | R)|(CAP_R | R)) ((CAP_Y | Y)|(CAP_Y | Y));
historyprofilesuffix : historyminimumsuffix | historymoderatesuffix | historymaximumsuffix;
historyminimumsuffix : (DASH|UNDERSCORE) ((CAP_M | M)|(CAP_M | M)) ((CAP_I | I)|(CAP_I | I)) ((CAP_N | N)|(CAP_N | N));
historymoderatesuffix : (DASH|UNDERSCORE) ((CAP_M | M)|(CAP_M | M)) ((CAP_O | O)|(CAP_O | O)) ((CAP_D | D)|(CAP_D | D));
historymaximumsuffix : (DASH|UNDERSCORE) ((CAP_M | M)|(CAP_M | M)) ((CAP_A | A)|(CAP_A | A)) ((CAP_X | X)|(CAP_X | X));
historysubset : LEFT_PAREN ws expressionconstraint ws RIGHT_PAREN;
numericvalue : (DASH|PLUS)? (decimalvalue | integervalue);
stringvalue : (anynonescapedchar | escapedchar)+;
integervalue : (digitnonzero digit*) | zero;
decimalvalue : integervalue PERIOD digit+;
booleanvalue : true_1 | false_1;
true_1 : ((CAP_T | T)|(CAP_T | T)) ((CAP_R | R)|(CAP_R | R)) ((CAP_U | U)|(CAP_U | U)) ((CAP_E | E)|(CAP_E | E));
false_1 : ((CAP_F | F)|(CAP_F | F)) ((CAP_A | A)|(CAP_A | A)) ((CAP_L | L)|(CAP_L | L)) ((CAP_S | S)|(CAP_S | S)) ((CAP_E | E)|(CAP_E | E));
nonnegativeintegervalue : (digitnonzero digit* ) | zero;
sctid : digitnonzero (( digit ) (digit) (digit) (digit) (digit) (((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit) (digit)) | ((digit) (digit) (digit) (digit)) | ((digit) (digit) (digit)) | ((digit) (digit)) | (digit)?));
ws : ( sp | htab | cr | lf | comment )*; // optional white space
mws : ( sp | htab | cr | lf | comment )+; // mandatory white space
comment : (SLASH ASTERISK) (nonstarchar | starwithnonfslash)* (ASTERISK SLASH);
nonstarchar : sp | htab | cr | lf | (EXCLAMATION | QUOTE | HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN) | (PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE | BACKSLASH | RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE | PIPE | RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
starwithnonfslash : ASTERISK nonfslash;
nonfslash : sp | htab | cr | lf | (EXCLAMATION | QUOTE | HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD) | (ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE | BACKSLASH | RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE | PIPE | RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
sp : SPACE; // space
htab : TAB; // tab
cr : CR; // carriage return
lf : LF; // line feed
qm : QUOTE; // quotation mark
bs : BACKSLASH; // back slash
star : ASTERISK; // asterisk
digit : (ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE);
zero : ZERO;
digitnonzero : (ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE);
nonwsnonpipe : (EXCLAMATION | QUOTE | HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE | BACKSLASH | RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE) | (RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
anynonescapedchar : sp | htab | cr | lf | (SPACE | EXCLAMATION) | (HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE) | (RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE | PIPE | RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
escapedchar : (bs qm) | (bs bs);
escapedwildchar : (bs qm) | (bs bs) | (bs star);
nonwsnonescapedchar : EXCLAMATION | (HASH | DOLLAR | PERCENT | AMPERSAND | APOSTROPHE | LEFT_PAREN | RIGHT_PAREN | ASTERISK | PLUS | COMMA | DASH | PERIOD | SLASH | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE | COLON | SEMICOLON | LESS_THAN | EQUALS | GREATER_THAN | QUESTION | AT | CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z | LEFT_BRACE) | (RIGHT_BRACE | CARAT | UNDERSCORE | ACCENT | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z | LEFT_CURLY_BRACE | PIPE | RIGHT_CURLY_BRACE | TILDE) | UTF8_LETTER;
alpha : (CAP_A | CAP_B | CAP_C | CAP_D | CAP_E | CAP_F | CAP_G | CAP_H | CAP_I | CAP_J | CAP_K | CAP_L | CAP_M | CAP_N | CAP_O | CAP_P | CAP_Q | CAP_R | CAP_S | CAP_T | CAP_U | CAP_V | CAP_W | CAP_X | CAP_Y | CAP_Z) | (A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z);
dash : DASH;

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
