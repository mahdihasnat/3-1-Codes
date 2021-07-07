/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "1705003.y"


#include<bits/stdc++.h>
using namespace std;

#include "SymbolInfo.h"
#include "SymbolTable.h"

#include "ParserFunctions.h"
#include "PeepholeOptimizer.h"

#include "Info.h"
#include "ReutrnType.h"

/// declared in scanner.l 

int yyparse(void);
int yylex(void);
void yylex_destroy();
extern FILE *yyin;


/// declared in perser.y

SymbolTable<Info> *symboltable;
ofstream logstream ;
ofstream errorstream;
int error_count = 0;
vector< pair< string , int > > globals;
string currentFuncName = "";

#define FIXED_POINT_MULTIPLIER 100
#define gTL getTypeLocation

template<class T1,class T2>
ostream & operator << ( ostream & os ,const pair<T1,T2> &p)
{
	return os<<"{"<<p.first<<","<<p.second<<"}";
}


#line 112 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
	

#line 251 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  13
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   179

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  42
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  28
/* YYNRULES -- Number of rules.  */
#define YYNRULES  79
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  134

#define YYUNDEFTOK  2
#define YYMAXUTOK   296


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   106,   106,   158,   175,   183,   189,   195,   201,   209,
     223,   238,   238,   260,   260,   282,   291,   299,   306,   312,
     320,   320,   341,   341,   361,   375,   384,   390,   396,   404,
     412,   423,   429,   438,   446,   452,   470,   478,   484,   490,
     496,   527,   557,   579,   603,   625,   684,   719,   726,   735,
     750,   759,   771,   796,   802,   837,   843,   894,   901,   991,
     997,  1057,  1063,  1176,  1215,  1271,  1279,  1289,  1318,  1335,
    1358,  1380,  1476,  1573,  1580,  1585,  1592,  1617,  1633,  1639
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "IF", "ELSE", "FOR", "WHILE", "DO",
  "SWITCH", "CASE", "DEFAULT", "CONTINUE", "BREAK", "PRINTLN", "RETURN",
  "ASSIGNOP", "LOGICOP", "RELOP", "ADDOP", "MULOP", "NOT", "INCOP",
  "DECOP", "INT", "FLOAT", "VOID", "CHAR", "DOUBLE", "CONST_FLOAT",
  "CONST_INT", "CONST_CHAR", "LPAREN", "LCURL", "LTHIRD", "RPAREN",
  "RCURL", "RTHIRD", "SEMICOLON", "COMMA", "ID", "STRING", "SINGLE_IF",
  "$accept", "start", "program", "unit", "func_declaration",
  "func_definition", "$@1", "$@2", "parameter_list", "compound_statement",
  "$@3", "$@4", "var_declaration", "type_specifier", "declaration_list",
  "statements", "statement", "expression_statement", "variable",
  "expression", "logic_expression", "rel_expression", "simple_expression",
  "term", "unary_expression", "factor", "argument_list", "arguments", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296
};
# endif

#define YYPACT_NINF (-73)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-75)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      78,   -31,   -73,   -73,   -73,    18,   113,   -73,   -73,   -73,
     -73,     6,   -73,   -73,   -73,   -16,    -5,    12,   -73,    -9,
      11,   -73,   -73,    -4,    21,    19,    16,    30,    37,   -73,
      41,   -73,    47,    75,   -73,   -73,    59,    57,   -73,   -73,
      41,    80,    86,   103,    89,   -73,   -73,   -73,    94,    98,
      99,   102,   137,   137,   137,   -73,   -73,   137,   -73,    87,
     -73,   -73,   -73,   -73,    58,   -73,   -73,     9,   107,   -73,
     130,    -7,   128,   -73,   -73,   -73,   137,   121,   137,   109,
     114,    90,   -73,   -73,   127,    76,   137,   -73,   -73,   -73,
     137,   -73,   -73,   -73,   137,   137,   137,   137,   129,   121,
     133,   135,   -73,   -73,   137,   -73,   136,    22,   126,   -73,
     -73,   153,   128,   -73,   103,   125,   103,   138,   -73,   -73,
     -73,   137,   -73,   168,   103,   139,   -73,   -73,   -73,   103,
     -73,   103,   -73,   -73
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,    26,    27,    28,     0,     0,     4,     6,     7,
       5,     0,     8,     1,     3,     0,    31,     0,    25,     0,
       0,    33,    24,     0,    13,     0,    18,     0,    29,    10,
       0,    19,    11,     0,    17,    32,     0,    20,    14,     9,
       0,    16,     0,     0,     0,    12,    15,    30,     0,     0,
       0,     0,     0,     0,     0,    70,    69,     0,    49,    51,
      47,    48,    39,    37,     0,    34,    38,    66,     0,    53,
      55,    57,    59,    61,    65,    23,     0,     0,     0,     0,
       0,    66,    63,    64,     0,     0,     0,    36,    21,    35,
       0,    71,    72,    50,     0,     0,     0,     0,     0,     0,
       0,     0,    46,    68,    75,    77,     0,     0,     0,    54,
      56,    58,    60,    62,     0,     0,     0,     0,    79,    67,
      78,     0,    52,    42,     0,     0,    44,    45,    76,     0,
      41,     0,    43,    40
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -73,   -73,   -73,   171,    33,    74,   -73,   -73,   -73,   -21,
     -73,   -73,    85,   -11,   -73,   -73,   -62,   -72,   -53,   -40,
     -56,    84,    79,    83,   -50,   -73,   -73,   -73
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     5,     6,     7,    60,    61,    40,    30,    25,    62,
      43,    44,    63,    11,    17,    64,    65,    66,    67,    68,
      69,    70,    71,    72,    73,    74,   106,   107
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      81,    81,    89,    82,    83,    99,    12,    15,    26,    38,
      95,    96,    80,    21,     2,     3,     4,    84,    13,    45,
      31,    18,    41,   120,    90,    24,    19,   115,    20,   105,
      91,    92,    81,     8,   109,    28,    98,    81,   100,     8,
      27,    81,    81,    81,    81,    16,   108,   113,   118,    22,
      23,    81,   123,    32,   126,    34,   -73,    33,    29,    87,
     121,    48,   130,    49,    50,   128,    35,   132,    81,   133,
      36,    51,    52,    37,     9,   125,    53,   104,    54,     1,
       9,     2,     3,     4,    39,    10,    55,    56,    42,    57,
      37,    10,   -22,    88,    53,    58,    54,    59,     2,     3,
       4,     2,     3,     4,    55,    56,    48,    57,    49,    50,
     -74,    91,    92,    -2,     1,    59,    51,    52,    85,    46,
      86,    53,    47,    54,    75,    76,     2,     3,     4,    77,
      78,    55,    56,    79,    57,    37,     2,     3,     4,    53,
      58,    54,    59,    53,    93,    54,    94,    97,   101,    55,
      56,   102,    57,    55,    56,    53,    57,    54,    58,   124,
      59,   103,   122,   114,    59,    55,    56,   116,    57,   117,
     119,    96,   129,   131,   111,   127,    59,    14,   110,   112
};

static const yytype_uint8 yycheck[] =
{
      53,    54,    64,    53,    54,    77,    37,     1,    19,    30,
      17,    18,    52,     1,    23,    24,    25,    57,     0,    40,
       1,    37,    33,     1,    15,    34,    31,    99,    33,    85,
      21,    22,    85,     0,    90,    39,    76,    90,    78,     6,
      29,    94,    95,    96,    97,    39,    86,    97,   104,    37,
      38,   104,   114,    34,   116,    39,    34,    38,    37,     1,
      38,     3,   124,     5,     6,   121,    36,   129,   121,   131,
      33,    13,    14,    32,     0,   115,    18,     1,    20,     1,
       6,    23,    24,    25,    37,     0,    28,    29,    29,    31,
      32,     6,    35,    35,    18,    37,    20,    39,    23,    24,
      25,    23,    24,    25,    28,    29,     3,    31,     5,     6,
      34,    21,    22,     0,     1,    39,    13,    14,    31,    39,
      33,    18,    36,    20,    35,    31,    23,    24,    25,    31,
      31,    28,    29,    31,    31,    32,    23,    24,    25,    18,
      37,    20,    39,    18,    37,    20,    16,    19,    39,    28,
      29,    37,    31,    28,    29,    18,    31,    20,    37,    34,
      39,    34,    36,    34,    39,    28,    29,    34,    31,    34,
      34,    18,     4,    34,    95,    37,    39,     6,    94,    96
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     1,    23,    24,    25,    43,    44,    45,    46,    47,
      54,    55,    37,     0,    45,     1,    39,    56,    37,    31,
      33,     1,    37,    38,    34,    50,    55,    29,    39,    37,
      49,     1,    34,    38,    39,    36,    33,    32,    51,    37,
      48,    55,    29,    52,    53,    51,    39,    36,     3,     5,
       6,    13,    14,    18,    20,    28,    29,    31,    37,    39,
      46,    47,    51,    54,    57,    58,    59,    60,    61,    62,
      63,    64,    65,    66,    67,    35,    31,    31,    31,    31,
      61,    60,    66,    66,    61,    31,    33,     1,    35,    58,
      15,    21,    22,    37,    16,    17,    18,    19,    61,    59,
      61,    39,    37,    34,     1,    62,    68,    69,    61,    62,
      63,    64,    65,    66,    34,    59,    34,    34,    62,    34,
       1,    38,    36,    58,    34,    61,    58,    37,    62,     4,
      58,    34,    58,    58
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    42,    43,    44,    44,    45,    45,    45,    45,    46,
      46,    48,    47,    49,    47,    50,    50,    50,    50,    50,
      52,    51,    53,    51,    54,    54,    55,    55,    55,    56,
      56,    56,    56,    56,    57,    57,    57,    58,    58,    58,
      58,    58,    58,    58,    58,    58,    58,    58,    58,    59,
      59,    60,    60,    61,    61,    62,    62,    63,    63,    64,
      64,    65,    65,    66,    66,    66,    67,    67,    67,    67,
      67,    67,    67,    68,    68,    68,    69,    69,    69,    69
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     2,     1,     1,     1,     1,     2,     6,
       5,     0,     7,     0,     6,     4,     3,     2,     1,     2,
       0,     4,     0,     3,     3,     3,     1,     1,     1,     3,
       6,     1,     4,     2,     1,     2,     2,     1,     1,     1,
       7,     6,     5,     7,     5,     5,     3,     1,     1,     1,
       2,     1,     4,     1,     3,     1,     3,     1,     3,     1,
       3,     1,     3,     2,     2,     1,     1,     4,     3,     1,
       1,     2,     2,     1,     0,     1,     3,     1,     2,     2
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 107 "1705003.y"
        {
		logRule("start : program");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		//print($$);
		DBG(error_count);
		
		if(noerror())
		{
			
			Code *code  = new Code(".MODEL SMALL");
			code = combine(code , ".STACK 1000H");

			code = combine(code , ".DATA");

			code = combine(code , "FIXED_POINT_MULTIPLIER DW 64H");

			for(pair<string,int > id_sz : globals)
			{
				code=combine(code , id_sz.first + " DW "+to_string(id_sz.second)+" DUP (0000H)");
			}
			code = combine(code , ".CODE");

			code = combine(code , loadLibrary());

			code = combine(code ,  (yyvsp[0].symbolInfoPointer) -> getTypeLocation()-> getCode());

			code = combine(
				code ,
				"END main"
			);


			ofstream codestream ;
			codestream.open("code.asm" , ios::trunc);
			
			// codestream<<(*code);
			code->write(codestream);
			codestream.close();
			
			codestream.open("optimized_code.asm" , ios::trunc);

			optimize(code);

			code -> write(codestream);
			codestream.close();
		}

		delete (yyval.symbolInfoPointer);
	}
#line 1577 "y.tab.c"
    break;

  case 3:
#line 159 "1705003.y"
        {
		logRule("program : program unit");
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				combine(
					(yyvsp[-1].symbolInfoPointer) -> gTL() -> getCode(),
					(yyvsp[0].symbolInfoPointer) -> gTL() -> getCode()
				)
			);
		}
	}
#line 1598 "y.tab.c"
    break;

  case 4:
#line 176 "1705003.y"
        {
		logRule("program : unit");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1608 "y.tab.c"
    break;

  case 5:
#line 184 "1705003.y"
        {
		logRule("unit : var_declaration");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1618 "y.tab.c"
    break;

  case 6:
#line 190 "1705003.y"
        {
		logRule("unit : func_declaration");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1628 "y.tab.c"
    break;

  case 7:
#line 196 "1705003.y"
        {
		logRule("unit : func_definition");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1638 "y.tab.c"
    break;

  case 8:
#line 202 "1705003.y"
        {
		logRule("unit :  error SEMICOLON");
		(yyval.symbolInfoPointer)  = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1648 "y.tab.c"
    break;

  case 9:
#line 210 "1705003.y"
        {
		logRule("func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-5].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		add_func_declaration((yyvsp[-5].symbolInfoPointer),(yyvsp[-4].symbolInfoPointer),(yyvsp[-2].symbolInfoPointer));

	}
#line 1666 "y.tab.c"
    break;

  case 10:
#line 224 "1705003.y"
        {
		logRule("func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-4].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		add_func_declaration((yyvsp[-4].symbolInfoPointer),(yyvsp[-3].symbolInfoPointer),nullptr);

	}
#line 1683 "y.tab.c"
    break;

  case 11:
#line 238 "1705003.y"
                                                                  {add_func_definition((yyvsp[-4].symbolInfoPointer) , (yyvsp[-3].symbolInfoPointer) , (yyvsp[-1].symbolInfoPointer));}
#line 1689 "y.tab.c"
    break;

  case 12:
#line 239 "1705003.y"
        {
		logRule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
		(yyvsp[-6].symbolInfoPointer) -> push_back( (yyvsp[-5].symbolInfoPointer) );
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-6].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		string funcName = (yyvsp[-5].symbolInfoPointer) -> getName();

		if(noerror())
		{
			SymbolInfoPointer compoundStatement = (yyvsp[0].symbolInfoPointer);
			Code * code = functionCode(funcName , compoundStatement);
			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(code);
		}
		currentFuncName = "";

	}
#line 1715 "y.tab.c"
    break;

  case 13:
#line 260 "1705003.y"
                                           {add_func_definition((yyvsp[-3].symbolInfoPointer) , (yyvsp[-2].symbolInfoPointer) , nullptr);}
#line 1721 "y.tab.c"
    break;

  case 14:
#line 261 "1705003.y"
        {
		logRule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-5].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		string funcName = (yyvsp[-4].symbolInfoPointer) -> getName();

		if(noerror())
		{
			SymbolInfoPointer compoundStatement = (yyvsp[0].symbolInfoPointer);
			Code * code = functionCode(funcName , compoundStatement);
			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(code);
		}
		currentFuncName = "";
	}
#line 1745 "y.tab.c"
    break;

  case 15:
#line 283 "1705003.y"
        {
		logRule("parameter_list : parameter_list COMMA type_specifier ID");
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-3].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1758 "y.tab.c"
    break;

  case 16:
#line 292 "1705003.y"
        {
		logRule("parameter_list : parameter_list COMMA type_specifier");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1770 "y.tab.c"
    break;

  case 17:
#line 300 "1705003.y"
        {
		logRule("parameter_list : type_specifier ID");
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1781 "y.tab.c"
    break;

  case 18:
#line 307 "1705003.y"
        {
		logRule("parameter_list : type_specifier");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1791 "y.tab.c"
    break;

  case 19:
#line 313 "1705003.y"
        {
		logRule("parameter_list : parameter_list error");
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1801 "y.tab.c"
    break;

  case 20:
#line 320 "1705003.y"
                           {enterScope();}
#line 1807 "y.tab.c"
    break;

  case 21:
#line 321 "1705003.y"
        {
		logRule("compound_statement : LCURL statements RCURL");
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-3].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror())
		{
			
			Code * code = nullptr;
			
			code = combine(code , (yyvsp[-1].symbolInfoPointer) -> getTypeLocation() -> getCode());
			code = combine(code ,exitScope());

			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(code);

		}
			
	}
#line 1832 "y.tab.c"
    break;

  case 22:
#line 341 "1705003.y"
                {enterScope();}
#line 1838 "y.tab.c"
    break;

  case 23:
#line 342 "1705003.y"
        {
		logRule("compound_statement : LCURL RCURL");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			
			Code * code = nullptr;

			code = combine(code ,exitScope());

			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(code);
		}

	}
#line 1860 "y.tab.c"
    break;

  case 24:
#line 362 "1705003.y"
        {
		logRule("var_declaration : type_specifier declaration_list SEMICOLON");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror())
		{
			
			(yyval.symbolInfoPointer)-> getTypeLocation()-> setCode( add_variable_declaration((yyval.symbolInfoPointer)) );
		}
	}
#line 1878 "y.tab.c"
    break;

  case 25:
#line 376 "1705003.y"
        {
		logRule("var_declaration : type_specifier error SEMICOLON");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1889 "y.tab.c"
    break;

  case 26:
#line 385 "1705003.y"
        {
		logRule("type_specifier : INT");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1899 "y.tab.c"
    break;

  case 27:
#line 391 "1705003.y"
        {
		logRule("type_specifier : FLOAT");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1909 "y.tab.c"
    break;

  case 28:
#line 397 "1705003.y"
        {
		logRule("type_specifier : VOID");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1919 "y.tab.c"
    break;

  case 29:
#line 405 "1705003.y"
        {
		logRule("declaration_list : declaration_list COMMA ID");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1931 "y.tab.c"
    break;

  case 30:
#line 413 "1705003.y"
        {
		logRule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-5].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1946 "y.tab.c"
    break;

  case 31:
#line 424 "1705003.y"
        {
		logRule("declaration_list : ID");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1956 "y.tab.c"
    break;

  case 32:
#line 430 "1705003.y"
        {
		logRule("declaration_list : ID LTHIRD CONST_INT RTHIRD");
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-3].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1969 "y.tab.c"
    break;

  case 33:
#line 439 "1705003.y"
        {
		logRule("declaration_list : declaration_list error");
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer) ;
		print((yyval.symbolInfoPointer));
	}
#line 1979 "y.tab.c"
    break;

  case 34:
#line 447 "1705003.y"
        {
		logRule("statements : statement");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 1989 "y.tab.c"
    break;

  case 35:
#line 453 "1705003.y"
        {
		logRule("statements : statements statement");
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			(yyval.symbolInfoPointer)-> getTypeLocation()->setCode(
				combine(
					(yyvsp[-1].symbolInfoPointer) -> getTypeLocation()->getCode(),
					(yyvsp[0].symbolInfoPointer) -> getTypeLocation()->getCode()
				)
			);
			
		}
	}
#line 2011 "y.tab.c"
    break;

  case 36:
#line 471 "1705003.y"
        {
		logRule("statements : statements error");
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2021 "y.tab.c"
    break;

  case 37:
#line 479 "1705003.y"
        {
		logRule("statement : var_declaration");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2031 "y.tab.c"
    break;

  case 38:
#line 485 "1705003.y"
        {
		logRule("statement : expression_statement");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2041 "y.tab.c"
    break;

  case 39:
#line 491 "1705003.y"
        {
		logRule("statement : compound_statement");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2051 "y.tab.c"
    break;

  case 40:
#line 497 "1705003.y"
        {
		logRule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		(yyvsp[-6].symbolInfoPointer) -> push_back( (yyvsp[-5].symbolInfoPointer) );
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-6].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			

			Code * code_init = (yyvsp[-4].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_check = (yyvsp[-3].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_statement = (yyvsp[0].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_step = (yyvsp[-2].symbolInfoPointer) -> gTL() -> getCode();

			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				loopImplementation(
					code_init,
					code_check,
					code_step,
					code_statement
				)
			);
		}
	}
#line 2086 "y.tab.c"
    break;

  case 41:
#line 528 "1705003.y"
        {
		logRule("statement : FOR LPAREN expression_statement expression_statement RPAREN statement");
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-5].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{

			Code * code_init = (yyvsp[-3].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_check = (yyvsp[-2].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_statement = (yyvsp[0].symbolInfoPointer) -> gTL() -> getCode();
			Code * code_step = nullptr;

			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				loopImplementation(
					code_init,
					code_check,
					code_step,
					code_statement
				)
			);
		}

	}
#line 2120 "y.tab.c"
    break;

  case 42:
#line 558 "1705003.y"
        {
		logRule("statement : IF LPAREN expression RPAREN statement");
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-4].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror())
		{
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				conditionImplementation(
					(yyvsp[-2].symbolInfoPointer)->gTL() -> getCode(),
					(yyvsp[0].symbolInfoPointer)->gTL() -> getCode(),
					nullptr 
				)
			);
		}

	}
#line 2146 "y.tab.c"
    break;

  case 43:
#line 580 "1705003.y"
        {
		logRule("statement : IF LPAREN expression RPAREN statement ELSE statement");
		(yyvsp[-6].symbolInfoPointer) -> push_back( (yyvsp[-5].symbolInfoPointer) );
		(yyvsp[-5].symbolInfoPointer) -> push_back( (yyvsp[-4].symbolInfoPointer) );
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-6].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				conditionImplementation(
					(yyvsp[-4].symbolInfoPointer)->gTL() -> getCode(),
					(yyvsp[-2].symbolInfoPointer)->gTL() -> getCode(),
					(yyvsp[0].symbolInfoPointer)->gTL() -> getCode()
				)
			);
		}

	}
#line 2174 "y.tab.c"
    break;

  case 44:
#line 604 "1705003.y"
        {
		logRule("statement : WHILE LPAREN expression RPAREN statement");
		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-4].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				loopImplementation(
					nullptr,
					(yyvsp[-2].symbolInfoPointer) -> gTL()->getCode(),
					nullptr,
					(yyvsp[0].symbolInfoPointer)-> gTL()->getCode()
				)
			);
		}
	}
#line 2200 "y.tab.c"
    break;

  case 45:
#line 626 "1705003.y"
        {
		logRule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON");

		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType( getVariableType( (yyvsp[-2].symbolInfoPointer) -> getName() ) );

		(yyvsp[-4].symbolInfoPointer) -> push_back( (yyvsp[-3].symbolInfoPointer) );
		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-4].symbolInfoPointer);
		print((yyval.symbolInfoPointer));


		if(noerror())
		{

			string var_name = (yyvsp[-2].symbolInfoPointer) -> getName();

			SymbolInfoPointer ref = symboltable -> lookUp(var_name);

			Code * code = nullptr;

			code = combine(
				code ,
				"MOV CX , "+getSingleVariableAddress(ref)
			);
			
			code = combine(
				code ,
				"PUSH CX"
			);

			string printFunc ="";

			switch (ref->getTypeLocation()->getReturnType())
			{
			case Int:
				printFunc = "println_int";
				break;
			case Float:
				printFunc = "println_float";
				break;
			default:
				assert(0);
				break;
			}

			code = combine(
				code ,
				"CALL "+printFunc
			);

			(yyval.symbolInfoPointer) -> getTypeLocation() -> setCode(
				code
			);
		}

	}
#line 2263 "y.tab.c"
    break;

  case 46:
#line 685 "1705003.y"
        {
		logRule("statement : RETURN expression SEMICOLON");
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		/// https://www.youtube.com/watch?v=z2_2cFityc4
		if(noerror())
		{
			// func()
			// {
			// 	int 
			// 	{
			// 		int 
			// 		return 
			// 	}
			// }
			Code * code = nullptr;

			code = combine(
				code ,
				(yyvsp[-1].symbolInfoPointer) -> gTL() -> getCode()
			);

			int current_stack_offset = symboltable -> getBaseIndex();

			code = combine(code, "SUB SP , "+ to_string(current_stack_offset) );
			code = combine(code, "JMP "+currentFuncName + "_exit");

			(yyval.symbolInfoPointer) -> gTL() -> setCode( code );

		}
	}
#line 2302 "y.tab.c"
    break;

  case 47:
#line 720 "1705003.y"
        {
		logRule("statement : func_declaration");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		//yyerror("Function declaration is not in global scope");
	}
#line 2313 "y.tab.c"
    break;

  case 48:
#line 727 "1705003.y"
        {
		logRule("statement : func_definition");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		yyerror("Function defination is not in global scope");
	}
#line 2324 "y.tab.c"
    break;

  case 49:
#line 736 "1705003.y"
        {
		logRule("expression_statement : SEMICOLON");
		
		(yyvsp[0].symbolInfoPointer)->getTypeLocation()->setReturnType(Void);

		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			(yyvsp[0].symbolInfoPointer) -> gTL()->setCode( new Code("MOV CX , 1"));
		}

	}
#line 2343 "y.tab.c"
    break;

  case 50:
#line 751 "1705003.y"
        {
		logRule("expression_statement : expression SEMICOLON");
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2354 "y.tab.c"
    break;

  case 51:
#line 760 "1705003.y"
        {
		logRule("variable : ID");
		
		string var_name = (yyvsp[0].symbolInfoPointer) -> getName() ;

		(yyvsp[0].symbolInfoPointer) -> getTypeLocation()-> setReturnType(getVariableType(var_name));
		
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

	}
#line 2370 "y.tab.c"
    break;

  case 52:
#line 772 "1705003.y"
        {
		logRule("variable : ID LTHIRD expression RTHIRD");

		string array_name = (yyvsp[-3].symbolInfoPointer) -> getName();

		(yyvsp[-3].symbolInfoPointer) -> getTypeLocation()-> setReturnType(getArrayType(array_name ));
		
		if(getReturnTypeFromSIP((yyvsp[-1].symbolInfoPointer)) != Int)
		{
			if( getReturnTypeFromSIP((yyvsp[-1].symbolInfoPointer)) != Error )
				// yyerror("Non-integer Array Index index type : "+ $3 -> getTypeLocation() -> getReturnType());
				yyerror("Expression inside third brackets not an integer");
		}

		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-3].symbolInfoPointer);
		print((yyval.symbolInfoPointer));


	}
#line 2397 "y.tab.c"
    break;

  case 53:
#line 797 "1705003.y"
        {
		logRule("expression : logic expression");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2407 "y.tab.c"
    break;

  case 54:
#line 803 "1705003.y"
        {
		logRule("expression : variable ASSIGNOP logic_expression");

		ReturnType type1 = getReturnTypeFromSIP((yyvsp[-2].symbolInfoPointer));
		ReturnType type2 = getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer));

		if( assignAbleType(type1 ,    type2 ) == false ){
			if(type1 != Error and type2 != Error)
				yyerror("Type Mismatch : "+ to_string(type1) + " " + (yyvsp[-1].symbolInfoPointer) -> getName() + " " + to_string(type2));
		}
			
		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType(type1);
		

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));


		if(noerror())
		{

			(yyval.symbolInfoPointer) -> getTypeLocation() -> setCode( 
				writeToVariable(
					(yyvsp[-2].symbolInfoPointer) ,
					(yyvsp[0].symbolInfoPointer) -> gTL() -> getCode()
				)
			 );

		}
	}
#line 2444 "y.tab.c"
    break;

  case 55:
#line 838 "1705003.y"
        {
		logRule("logic_expression : rel_expression");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2454 "y.tab.c"
    break;

  case 56:
#line 844 "1705003.y"
        {
		logRule("logic_expression : rel_expression LOGICOP rel_expression");

		ReturnType type1  = (yyvsp[-2].symbolInfoPointer)->getTypeLocation()->getReturnType();
		ReturnType type2  = (yyvsp[0].symbolInfoPointer)->getTypeLocation()->getReturnType();
		ReturnType resultType = Error;

		if(type1!=Int or type2 != Int ){
			if(type1 != Error and type2 != Error)
				yyerror("Type mismatch of Logic operation : " + to_string(type1) + " "+ (yyvsp[-1].symbolInfoPointer) ->getTypeLocation()->getType() +  " " + to_string(type2));
		}
		else 
			resultType = Int;

		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType(resultType);

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code * code  = nullptr;
			string op = (yyvsp[-1].symbolInfoPointer) -> getName();
			if(op == "&&")	
			{
				string end_label = newLabel("after_and");
				code = combine(code , (yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> getCode());
				code = combine(code ,"JCXZ "+end_label );
				code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
				code = combine(code , end_label + ":");
			}
			else if(op == "||")
			{
				string end_label = newLabel("after_or");
				code = combine(code , (yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> getCode());
				code = combine(code ,"CMP CX , 0");
				code = combine(code ,"JNZ "+end_label );
				code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
				code = combine(code , end_label + ":");
			}
			else assert(0);

			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}

	}
#line 2507 "y.tab.c"
    break;

  case 57:
#line 895 "1705003.y"
        {
		logRule("rel_expression : simple_expression");

		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2518 "y.tab.c"
    break;

  case 58:
#line 902 "1705003.y"
        {
		logRule("rel_expression : simple_expression RELOP simple_expression");

		ReturnType type1 = getReturnTypeFromSIP((yyvsp[-2].symbolInfoPointer));
		ReturnType type2 = getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer));
		ReturnType resultType = Error;
		if(type1 == Error or type2 == Error)
			;
		else if(type1 == Void or type2 == Void )
			yyerror("Type mismatch of relational operation : " + to_string(type1) + " "+ (yyvsp[-1].symbolInfoPointer) ->getTypeLocation()->getType() +  " " + to_string(type2));
		else 
			resultType = Int;
		
		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType(resultType);

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			/// notice: stack is pushed for temp variable
			
			Code * code  = nullptr;
			code = combine(code,Comment("Relational operator checking"));
			code = combine(
				code ,
				(yyvsp[-2].symbolInfoPointer) -> getTypeLocation()->getCode()
			);
			// cx = simple expr
			bool to_float = type1 ==Float or type2 == Float;
			
			if(to_float and type1 != Float)
			{
				code = combine(code , Comment("Int to float"));
				code = combine(code , "MOV AX , CX");
				code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
				code = combine(code , "MOV CX , AX");
			}

			code = combine(code , "PUSH CX");
				//inside push
				code = combine(
					code ,
					(yyvsp[0].symbolInfoPointer) -> getTypeLocation()->getCode()
				);
				if(to_float and type2 != Float)
				{
					code = combine(code , Comment("Int to float"));
					code = combine(code , "MOV AX , CX");
					code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
					code = combine(code , "MOV CX , AX");
				}

			code = combine(code , "POP AX");

			// ax = arg1 , cx = arg2

			string op = (yyvsp[-1].symbolInfoPointer) -> getName();
			string opcode = "";

			if(op == "<") opcode ="JL";
			else if(op == ">") opcode ="JG";
			else if(op == ">=") opcode ="JGE";
			else if(op == "<=") opcode ="JLE";
			else if(op == "==") opcode ="JE";
			else if(op == "!=") opcode ="JNE";
			else assert(0);

			code = combine(code , "CMP AX , CX");


			int labelCounter = newLabelCounter();
			string label_ok = "relop_is_ok" + to_string(labelCounter);
			string label_end = "relop_end"+ to_string(labelCounter);

			code = combine(code , opcode + " " + label_ok);
			code = combine(code , "MOV CX , 0");
			code = combine(code , "JMP " + label_end);
			code = combine(code , label_ok + ":");
			code = combine(code , "MOV CX , 1");
			code = combine(code , label_end + ":");

			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}	
	}
#line 2610 "y.tab.c"
    break;

  case 59:
#line 992 "1705003.y"
        {
		logRule("simple_expression : term");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2620 "y.tab.c"
    break;

  case 60:
#line 998 "1705003.y"
        {
		logRule("simple_expression : simple_expression ADDOP term");

		ReturnType type1 = getReturnTypeFromSIP((yyvsp[-2].symbolInfoPointer));
		ReturnType type2 = getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer));

		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType( combineArithmaticType(type1 , type2) );

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror())
		{
			Code * code  = nullptr;
			string op = (yyvsp[-1].symbolInfoPointer) -> getName();
			string opcode = "";
			
			if(op == "+")	opcode = "ADD";
			else if(op == "-")	opcode = "SUB";
			else assert(0);
			
			code = combine(code , (yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> getCode());
			code = combine(code ,"PUSH CX");
				code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
			code = combine(code ,"POP AX");
			
			// ax = simple expr , cx = term

			if((type1 == Int xor type2 == Int))
			{
				
				if(type2 == Int)
				{
					code = combine(code , "XCHG AX , CX");
				}
				// ax -> int
				// cx -> float
				
				code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
				// dx:ax = ax * FIXED_POINT_MULTIPLIER

				// swap back 
				if(type2 == Int)
				{
					code = combine(code , "XCHG AX , CX");
				}

			}

			code = combine(code , opcode + " AX , CX");
			code = combine(code , "MOV CX , AX");
	
			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}
	}
#line 2682 "y.tab.c"
    break;

  case 61:
#line 1058 "1705003.y"
        {
		logRule("term : unary_expression");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2692 "y.tab.c"
    break;

  case 62:
#line 1064 "1705003.y"
        {
		logRule("term : term MULOP unary_expression");

		ReturnType type1 = getReturnTypeFromSIP((yyvsp[-2].symbolInfoPointer));
		ReturnType type2 = getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer));
		ReturnType resultType  = Error;
		if((yyvsp[-1].symbolInfoPointer) -> getName() == "%")
		{
			if(type1 != Int or type2 != Int) 
			{
				if(type1 != Error and type2 != Error)
					yyerror("Non-Integer operand on modulus operator");
			}
			else if( isZero((yyvsp[0].symbolInfoPointer) -> getName()) )
				yyerror("Modulus by Zero");
			else
				resultType = Int;
		}
		else 
			resultType  = combineArithmaticType(type1 , type2);
	
		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> setReturnType( resultType);

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code * code  = nullptr;
			string op = (yyvsp[-1].symbolInfoPointer) -> getName();
			
			
			code = combine(code , ";>>");
			code = combine(code , Comment(op));

			code = combine(code , (yyvsp[-2].symbolInfoPointer) -> getTypeLocation() -> getCode());
			code = combine(code ,"PUSH CX");
				code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
			code = combine(code ,"POP AX");

			// ax = term , cx = unary
			
			if(op == "*")
			{
				code = combine(code , "IMUL CX");
				if(type1 == Float and type2 == Float)
				{
					code = combine(code , "IDIV " + to_string(FIXED_POINT_MULTIPLIER));
				}
				code = combine(code , "MOV CX , AX");
			}
			else if(op == "/")
			{
				
				// ax = term ,cx = unary , term/unary
				switch (type1)
				{
				case Int:
					switch (type2)
					{
					case Int:
						code = combine(code , "CWD");
						break;
					case Float:
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						break;
					default:
						assert(0);
						break;
					}
					break;
				case Float:
					switch (type2)
					{
					case Int:
						code = combine(code , "CWD");
						break;
					case Float:
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						break;
					default:
						assert(0);
						break;
					}
					break;
				default:
					assert(0);
					break;
				}
				code = combine(code , "IDIV CX");
				code = combine(code , "MOV CX , AX");
				
			}
			else if(op == "%")
			{
				code = combine(code , "CWD");
				code = combine(code , "IDIV CX");
				code = combine(code , "MOV CX , DX");

			}
			else assert(0);
			
			code = combine(code , ";<<");

			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}
	}
#line 2807 "y.tab.c"
    break;

  case 63:
#line 1177 "1705003.y"
        {
		logRule("unary_expression : ADDOP unary_expression");

		ReturnType type = getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer));
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		default:
			resultType = type;
			break;
		}

		(yyvsp[-1].symbolInfoPointer)->getTypeLocation()->setReturnType(resultType);

		(yyvsp[-1].symbolInfoPointer)->push_back((yyvsp[0].symbolInfoPointer));
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code * code  = nullptr;
			string op = (yyvsp[-1].symbolInfoPointer) -> getName();
			
			code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
			
			if(op == "+")	;
			else if(op == "-")	code = combine(code , "NEG CX");
			else assert(0);

			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}

	}
#line 2850 "y.tab.c"
    break;

  case 64:
#line 1216 "1705003.y"
        {
		logRule("unary_expression : NOT unary expression");

		ReturnType type = (yyvsp[0].symbolInfoPointer)->getTypeLocation()->getReturnType();
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Float:
			yyerror("Invalid not operation for float type");
			break;

		case Int:
			resultType = Int;
			break;
		
		default:
			break;
		}

		(yyvsp[-1].symbolInfoPointer)->getTypeLocation()->setReturnType(resultType);

		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code * code  = nullptr;
			

			code = combine(code , (yyvsp[0].symbolInfoPointer) -> getTypeLocation() -> getCode());
			

			int labelCounter = newLabelCounter();
			string label_end = "not_end" + to_string(labelCounter);
			string label_one = "not_one" + to_string(labelCounter);

			code = combine(code , "JCXZ "+label_one);
			code = combine(code , "MOV CX , 0");
			code = combine(code , "JMP "+label_end);
			code = combine(code , label_one + ":");
			code = combine(code , "MOV CX , 1");
			code = combine(code , label_end + ":");


			(yyval.symbolInfoPointer) -> getTypeLocation()-> setCode(code);
		}


	}
#line 2910 "y.tab.c"
    break;

  case 65:
#line 1272 "1705003.y"
        {
		logRule("unary_expression : factor");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 2920 "y.tab.c"
    break;

  case 66:
#line 1280 "1705003.y"
        {
		logRule("factor : variable");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror())
			readFromVariable((yyval.symbolInfoPointer));

	}
#line 2934 "y.tab.c"
    break;

  case 67:
#line 1290 "1705003.y"
        {
		logRule("factor : ID LPAREN argument_list RPAREN");

		string funcName = (yyvsp[-3].symbolInfoPointer) -> getName() ;

		(yyvsp[-3].symbolInfoPointer) -> getTypeLocation() -> setReturnType( getFuncReturnType(funcName, (yyvsp[-1].symbolInfoPointer)) );

		(yyvsp[-3].symbolInfoPointer) -> push_back( (yyvsp[-2].symbolInfoPointer) );
		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-3].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code * code = nullptr ;

			code = combine(
				code ,
				(yyvsp[-1].symbolInfoPointer) ? (yyvsp[-1].symbolInfoPointer) -> gTL() ->getCode() : nullptr
			);

			code = combine(code, "CALL "+funcName);

			(yyval.symbolInfoPointer) -> gTL() -> setCode(code);
		}

	}
#line 2967 "y.tab.c"
    break;

  case 68:
#line 1319 "1705003.y"
        {
		logRule("factor : LPAREN expression RPAREN");

		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation()->setReturnType( getReturnTypeFromSIP((yyvsp[-1].symbolInfoPointer)));

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		if(noerror())
		{
			(yyval.symbolInfoPointer) -> getTypeLocation() -> setCode(
				(yyvsp[-1].symbolInfoPointer) -> getTypeLocation()->getCode()
			);
		}
	}
#line 2988 "y.tab.c"
    break;

  case 69:
#line 1336 "1705003.y"
        {
		logRule("factor : CONST_INT");

		(yyvsp[0].symbolInfoPointer)->getTypeLocation() -> setReturnType(Int);

		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		

		if(noerror())
		{	
			string num_str = (yyval.symbolInfoPointer) -> getName();

			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(
				combine(
					new Code(Comment("integar = "+ num_str) ) ,
					"MOV CX , " + num_str   
				)
			);
		}
	}
#line 3015 "y.tab.c"
    break;

  case 70:
#line 1359 "1705003.y"
        {
		logRule("factor : CONST_FLOAT");

		(yyvsp[0].symbolInfoPointer)->getTypeLocation() -> setReturnType(Float);

		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			int num = stof( (yyval.symbolInfoPointer) -> getName() ) * FIXED_POINT_MULTIPLIER;
			
			(yyval.symbolInfoPointer) -> getTypeLocation()->setCode(
				combine(
					new Code(Comment("float number = "+ (yyval.symbolInfoPointer) -> getName()) ) ,
					"MOV CX , " + to_string(num)
				)
			);
		}
		
	}
#line 3041 "y.tab.c"
    break;

  case 71:
#line 1381 "1705003.y"
        {
		logRule("factor : variable INCOP");


		ReturnType type = getReturnTypeFromSIP((yyvsp[-1].symbolInfoPointer));
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Int:
		case Float:
			resultType = type;
			break;
			
		default:
			break;
		}

		(yyvsp[-1].symbolInfoPointer) -> getTypeLocation() -> setReturnType(resultType);

		// if(getReturnTypeFromSIP($1) != Int and getReturnTypeFromSIP($1) != Float )
		// 	yyerror("Type Mismatch : "+ to_string(getReturnTypeFromSIP($1)) + " INCOP");

		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code *code = nullptr;
			SymbolInfoPointer sip = (yyvsp[-1].symbolInfoPointer);

			string var_name = sip->getName();
			SymbolInfoPointer ref = symboltable->lookUp(var_name);
			assert(ref);

			int changeAmount = 1;
			if(resultType == Int) changeAmount = 1;
			else if(resultType == Float) changeAmount = FIXED_POINT_MULTIPLIER;
			else assert(0);

			if (ref->getTypeLocation()->isArray())
			{
				SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

				code = combine(
					code,
					expr->getTypeLocation()->getCode() /// CX e expr ache
				);

				int idx = ref->getTypeLocation()->getBasedIndex();

				if (idx == -1)
				{
					code = combine(code, Comment("set  element to memory array"));
					code = combine(code, "SAL CX , 1"); 
					code = combine(code, "MOV BX , CX");
					code = combine(code, "MOV CX , PTR WORD " + var_name + "[BX]");
					code = combine(code, "MOV AX , CX");
					code = combine(code, "ADD AX , " +to_string(changeAmount) );
					code = combine(code, "MOV PTR WORD " + var_name + "[BX] , AX");
				}
				else
				{
					code = combine(code, Comment("put element to stack array"));
					code = combine(code, "PUSH BP");
						code = combine(code, "SAL CX , 1");
						code = combine(code, "ADD CX , " + to_string(idx));
						code = combine(code, "ADD BP , CX");
						code = combine(code, "MOV CX , PTR WORD [BP]");
						code = combine(code, "MOV AX , CX");
						code = combine(code, "ADD AX , " +to_string(changeAmount) );
						code = combine(code, "MOV PTR WORD [BP] , AX");
					code = combine(code, "POP BP");
				}
			}
			else
			{
				
				code = combine(code, "MOV CX , " + getSingleVariableAddress(ref));
				code = combine(code, "MOV AX , CX");
				code = combine(code, "ADD AX , " +to_string(changeAmount) );
				code = combine(code, "MOV " + getSingleVariableAddress(ref) + " , AX");
			}
			
			(yyval.symbolInfoPointer) -> gTL()->setCode(
				code
			);
		}

	}
#line 3141 "y.tab.c"
    break;

  case 72:
#line 1477 "1705003.y"
        {
		logRule("factor : variable DECOP");

		ReturnType type = getReturnTypeFromSIP((yyvsp[-1].symbolInfoPointer));
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Int:
		case Float:
			resultType = type;
			break;

		default:
			break;
		}

		// if(getReturnTypeFromSIP($1) != Int and getReturnTypeFromSIP($1) != Float )
		// 	yyerror("Type Mismatch : "+ to_string(getReturnTypeFromSIP($1)) + " DECOP");

		(yyvsp[-1].symbolInfoPointer) -> getTypeLocation() -> setReturnType(resultType);

		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror())
		{
			Code *code = nullptr;
			SymbolInfoPointer sip = (yyvsp[-1].symbolInfoPointer);

			string var_name = sip->getName();
			SymbolInfoPointer ref = symboltable->lookUp(var_name);
			assert(ref);

			int changeAmount = 1;
			if(resultType == Int) changeAmount = 1;
			else if(resultType == Float) changeAmount = FIXED_POINT_MULTIPLIER;
			else assert(0);

			if (ref->getTypeLocation()->isArray())
			{
				SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

				code = combine(
					code,
					expr->getTypeLocation()->getCode() /// CX e expr ache
				);

				int idx = ref->getTypeLocation()->getBasedIndex();

				if (idx == -1)
				{
					code = combine(code, Comment("set  element to memory array"));
					code = combine(code, "SAL CX , 1"); 
					code = combine(code, "MOV BX , CX");
					code = combine(code, "MOV CX , PTR WORD " + var_name + "[BX]");
					code = combine(code, "MOV AX , CX");
					code = combine(code, "SUB AX , " +to_string(changeAmount) );
					code = combine(code, "MOV PTR WORD " + var_name + "[BX] , AX");
				}
				else
				{
					code = combine(code, Comment("put element to stack array"));
					code = combine(code, "PUSH BP");
						code = combine(code, "SAL CX , 1");
						code = combine(code, "ADD CX , " + to_string(idx));
						code = combine(code, "ADD BP , CX");
						code = combine(code, "MOV CX , PTR WORD [BP]");
						code = combine(code, "MOV AX , CX");
						code = combine(code, "SUB AX , " +to_string(changeAmount) );
						code = combine(code, "MOV PTR WORD [BP] , AX");
					code = combine(code, "POP BP");
				}
			}
			else
			{
				
				code = combine(code, "MOV CX , " + getSingleVariableAddress(ref));
				code = combine(code, "MOV AX , CX");
				code = combine(code, "SUB AX , " +to_string(changeAmount) );
				code = combine(code, "MOV " + getSingleVariableAddress(ref) + " , AX");
			}
			
			(yyval.symbolInfoPointer) -> gTL()->setCode(
				code
			);
		}

	}
#line 3240 "y.tab.c"
    break;

  case 73:
#line 1574 "1705003.y"
        {
		logRule("argument_list : arguments");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 3250 "y.tab.c"
    break;

  case 74:
#line 1580 "1705003.y"
        {
		logRule("argument_list :");
		(yyval.symbolInfoPointer)=nullptr;
		print((yyval.symbolInfoPointer));
	}
#line 3260 "y.tab.c"
    break;

  case 75:
#line 1586 "1705003.y"
        {
		logRule("argument_list : error");
		(yyval.symbolInfoPointer) = nullptr;
	}
#line 3269 "y.tab.c"
    break;

  case 76:
#line 1593 "1705003.y"
        {
		logRule("arguments : arguments COMMA logic_expression");

		(yyvsp[-2].symbolInfoPointer) -> getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer)));

		(yyvsp[-2].symbolInfoPointer) -> push_back( (yyvsp[-1].symbolInfoPointer) );
		(yyvsp[-1].symbolInfoPointer) -> push_back( (yyvsp[0].symbolInfoPointer) );
		(yyval.symbolInfoPointer) = (yyvsp[-2].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
		
		if(noerror()){
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				combine(
					combine(
						(yyvsp[0].symbolInfoPointer) -> gTL()->getCode(),
						"PUSH CX"
					),
					(yyvsp[-2].symbolInfoPointer) -> gTL()->getCode() 
				)
				
			);
		}

	}
#line 3298 "y.tab.c"
    break;

  case 77:
#line 1618 "1705003.y"
        {
		logRule("arguments : logic_expression");
		(yyvsp[0].symbolInfoPointer) -> getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP((yyvsp[0].symbolInfoPointer)));
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		print((yyval.symbolInfoPointer));

		if(noerror()){
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				combine(
					(yyvsp[0].symbolInfoPointer) -> gTL()->getCode(),
					"PUSH CX"
				)
			);
		}
	}
#line 3318 "y.tab.c"
    break;

  case 78:
#line 1634 "1705003.y"
        {
		logRule("arguments : arguments error");
		(yyval.symbolInfoPointer) = (yyvsp[-1].symbolInfoPointer);
		print((yyval.symbolInfoPointer));
	}
#line 3328 "y.tab.c"
    break;

  case 79:
#line 1640 "1705003.y"
        {
		logRule("arguments : error logic_expression");
		(yyval.symbolInfoPointer) = (yyvsp[0].symbolInfoPointer);
		(yyval.symbolInfoPointer) ->  getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP((yyval.symbolInfoPointer)));
		print((yyval.symbolInfoPointer));

		if(noerror()){
			(yyval.symbolInfoPointer) -> gTL() -> setCode(
				combine(
					(yyvsp[0].symbolInfoPointer) -> gTL()->getCode(),
					"PUSH CX"
				)
			);
		}
	}
#line 3348 "y.tab.c"
    break;


#line 3352 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 1656 "1705003.y"

int main(int argc,char *argv[])
{

	if(argc < 2 )
	{
		printf("Provide input_file [log_file=log.txt] [error_file=error.txt]");
		exit(1);
	}

	FILE * fp ;

	fp=fopen(argv[1],"r");
	if( fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	string log_file = argc >= 3 ? string(argv[2]) : "log.txt";
	string error_file = argc >= 4 ? string(argv[3]) : "error.txt";
	

	logstream.open(log_file , ios::out);
	errorstream.open(error_file , ios::out);
	
	

	ScopeTable<Info>::setTotalBucket(30);
	symboltable = new SymbolTable<Info>();

	yyin=fp;
	yyparse();
	
	

	//logstream<<"\n\t\tsymbol table:\n";
	symboltable->printNonEmptyBuckets(logstream);

	logstream<<"\nTotal lines: "<<yylineno<<endl;
	logstream<<"Total errors: "<<error_count<<endl<<endl;
	errorstream<<"\nTotal errors: "<<error_count<<endl;
	

	yylex_destroy();
	delete symboltable;

	fclose(fp);
	
	
	return 0;
}

