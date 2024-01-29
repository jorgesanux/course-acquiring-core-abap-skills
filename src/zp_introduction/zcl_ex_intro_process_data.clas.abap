CLASS zcl_ex_intro_process_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_intro_process_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA num1 TYPE i VALUE 2.
    DATA num2 TYPE i VALUE 5.
    DATA num3 TYPE i VALUE 49.
    data result_div type decfloat16 value 0.

    DATA(result_sum) = num1 + num2.
    DATA(result_minus) = num1 - num2.
    DATA(result_multi) = num1 * num2.
    result_div = num1 / num2.
    DATA(result_div_key) = num1 DIV num2.
    DATA(result_mod) = num1 MOD num2.
    DATA(result_sqrt) = sqrt( num3 ).

    out->write( result_sum ).
    out->write( result_minus ).
    out->write( result_multi ).
    out->write( result_div ).
    out->write( result_div_key ).
    out->write( result_mod ).
    out->write( result_sqrt ).


* Declarations
**********************************************************************

    " comment/uncomment these line for different result types
    TYPES t_result TYPE p LENGTH 8 DECIMALS 2.
*    TYPES t_result TYPE p LENGTH 8 DECIMALS 0.
*    TYPES t_result TYPE i.

    DATA result TYPE t_result.

* Calculations
**********************************************************************
    " comment/uncomment these lines for different calculations

*    result = 2 + 3.
*    result = 2 - 3.
*    result = 2 * 3.
*    result = 2 / 3.
*
*    result = sqrt( 2 ).
    result = ipow( base = 2 exp = 3 ).
*
*    result = ( 8 * 7 - 6 ) / ( 5 + 4 ).
*   result = 8 * 7 - 6 / 5 + 4.

* Output
**********************************************************************

    out->write( |Result: { result }| ).

**********************************************************************
    data test_template type string.
    test_template = |Buenas los hptas|.

    out->write( test_template ).

**********************************************************************

* Declarations
**********************************************************************
    TYPES t_amount TYPE  p LENGTH 8 DECIMALS 2.

    DATA amount   TYPE t_amount VALUE '3.30'.
    DATA amount1  TYPE t_amount VALUE '1.20'.
    DATA amount2  TYPE t_amount VALUE '2.10'.

    DATA the_date  TYPE d                     VALUE '19891109'.
    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.

    DATA part1 TYPE string VALUE `Hello`.
    DATA part2 TYPE string VALUE `World`.

* String Templates
**********************************************************************

    " comment/uncomment the following lines for different examples
    DATA(text) = |Hello World|.
*    DATA(text) = |Total: { amount } EUR|.
*    DATA(text) = |Total: { amount1 + amount2 } EUR|.

* Format Options
**********************************************************************

    "Date
*    DATA(text) = |Raw Date: { the_date             }|.
*    DATA(text) = |ISO Date: { the_date Date = ISO  }|.
*    DATA(text) = |USER Date:{ the_date Date = USER }|.

    "Number
*    DATA(text) = |Raw Number { my_numer                    }|.
*    DATA(text) = |User Format{ my_numer NUMBER = USER      }|.
*    DATA(text) = |Sign Right { my_number SIGN = RIGHT      }|.
*    DATA(text) = |Scientific { my_number STYLE = SCIENTIFIC }|.

* String expression (concatenation Operator)
**********************************************************************

*    DATA(text) = part1 && part2.
*    DATA(text) = part1 && | | && part2.
*    DATA(text) = |{ amount1 } + { amount2 }| &&
*                 | = | &&
*                 |{ amount1 + amount2 }|.


* Output
**********************************************************************

    out->write( text ).



  ENDMETHOD.
ENDCLASS.
