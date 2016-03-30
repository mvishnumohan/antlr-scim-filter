/*
 * antlr-scim-filter is available under the MIT License (2008). See http://opensource.org/licenses/MIT for full text.
 *
 * Copyright (c) 2016, Gluu
 *
 * Author: Val Pecaoco
 */
grammar ScimFilter;

options
{
  language = Java;
}

scimFilter
 : expression* EOF
 ;

expression
 : NOT WS+? expression                        # NOT_EXPR
 | expression WS+? AND WS+? expression        # EXPR_AND_EXPR
 | expression WS+? OR WS+ expression          # EXPR_OR_EXPR
 | expression WS+? operator WS+? expression   # EXPR_OPER_EXPR
 | ATTRNAME WS+? PR                           # ATTR_PR
 | ATTRNAME WS+? operator WS+? expression     # ATTR_OPER_EXPR
 | ATTRNAME WS+? operator WS+? criteria       # ATTR_OPER_CRITERIA
 | LPAREN WS*? expression WS*? RPAREN         # LPAREN_EXPR_RPAREN
 | ATTRNAME LBRAC WS*? expression WS*? RBRAC  # LBRAC_EXPR_RBRAC
 ;

criteria : '"' .+? '"';

operator
 : 'eq' | 'ne' | 'co' | 'sw' | 'ew' | 'gt' | 'lt' | 'ge' | 'le'
 ;

NOT : 'not';

AND : 'and';
OR  : 'or';

PR : 'pr';

LPAREN : '(';
RPAREN : ')';

LBRAC : '[';
RBRAC : ']';

WS : ' ';

ATTRNAME : [-_.:a-zA-Z0-9]+;

ANY : ~('"' | '(' | ')' | '[' | ']');

EOL : [\t\r\n\u000C]+ -> skip;
