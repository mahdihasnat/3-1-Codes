/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    ELSE = 259,
    FOR = 260,
    WHILE = 261,
    DO = 262,
    SWITCH = 263,
    CASE = 264,
    DEFAULT = 265,
    CONTINUE = 266,
    BREAK = 267,
    PRINTLN = 268,
    RETURN = 269,
    ASSIGNOP = 270,
    LOGICOP = 271,
    RELOP = 272,
    ADDOP = 273,
    MULOP = 274,
    NOT = 275,
    INCOP = 276,
    DECOP = 277,
    INT = 278,
    FLOAT = 279,
    VOID = 280,
    CHAR = 281,
    DOUBLE = 282,
    CONST_FLOAT = 283,
    CONST_INT = 284,
    CONST_CHAR = 285,
    LPAREN = 286,
    LCURL = 287,
    LTHIRD = 288,
    RPAREN = 289,
    RCURL = 290,
    RTHIRD = 291,
    SEMICOLON = 292,
    COMMA = 293,
    ID = 294,
    STRING = 295,
    SINGLE_IF = 296
  };
#endif
/* Tokens.  */
#define IF 258
#define ELSE 259
#define FOR 260
#define WHILE 261
#define DO 262
#define SWITCH 263
#define CASE 264
#define DEFAULT 265
#define CONTINUE 266
#define BREAK 267
#define PRINTLN 268
#define RETURN 269
#define ASSIGNOP 270
#define LOGICOP 271
#define RELOP 272
#define ADDOP 273
#define MULOP 274
#define NOT 275
#define INCOP 276
#define DECOP 277
#define INT 278
#define FLOAT 279
#define VOID 280
#define CHAR 281
#define DOUBLE 282
#define CONST_FLOAT 283
#define CONST_INT 284
#define CONST_CHAR 285
#define LPAREN 286
#define LCURL 287
#define LTHIRD 288
#define RPAREN 289
#define RCURL 290
#define RTHIRD 291
#define SEMICOLON 292
#define COMMA 293
#define ID 294
#define STRING 295
#define SINGLE_IF 296

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 43 "1705003.y"

		SymbolInfoPointer symbolInfoPointer;
	

#line 144 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
