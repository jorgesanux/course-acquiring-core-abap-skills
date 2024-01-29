CLASS zcl_ex_intro_data_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_intro_data_objects IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    TYPES char_10 TYPE c LENGTH 10.
    TYPES char_d_10 TYPE n LENGTH 11.

    CONSTANTS unit_weigh TYPE string VALUE 'KG'.

    DATA name TYPE char_10.
    DATA cellphone_number TYPE char_d_10.
    DATA birthdate TYPE d.

    name = 'Jorge Andres'.
    cellphone_number = '3167727446'.
    birthdate = '19990913'.

    out->write( name ).
    out->write( cellphone_number ).
    out->write( birthdate ).
    out->write( unit_weigh ).


* Example 2: Global Types
**********************************************************************

* Variable based on global type .
    " Place cursor on variable and press F2 or F3
    DATA airport TYPE /dmo/airport_id VALUE 'FRA'.

    out->write(  `airport (TYPE /DMO/AIRPORT_ID )` ).
    out->write(   airport ).

* Example 3: Constants
**********************************************************************

    CONSTANTS c_text   TYPE string VALUE `Hello World`.
    CONSTANTS c_number TYPE i      VALUE 12345.

    "Uncomment this line to see syntax error ( VALUE is mandatory)
*  constants c_text2   type string.

    out->write(  `c_text (TYPE STRING)` ).
    out->write(   c_text ).
    out->write(  '---------' ).

    out->write(  `c_number (TYPE I )` ).
    out->write(   c_number ).
    out->write(  `---------` ).

* Example 4: Literals
**********************************************************************

    out->write(  '12345               ' ).    "Text Literal   (Type C)
    out->write(  `12345               ` ).    "String Literal (Type STRING)
    out->write(  12345                  ).    "Number Literal (Type I)

    "uncomment this line to see syntax error (no number literal with digits)
*    out->write(  12345.67                  ).

    DATA first_name TYPE string.
    DATA last_name TYPE string.
    DATA full_name TYPE string.
    DATA full_name2 TYPE string.
*
    first_name = `Jorge`.
    last_name = 'Sanabria'.
    full_name = first_name && ` ` && last_name. "Una forma de concatenar
    full_name2 = |{ first_name } { last_name }|. "Otra forma de concatenar
    out->write( full_name ).
    out->write( full_name2 ).

    clear full_name.
    clear full_name2.

    out->write( full_name ).
    out->write( full_name2 ).

**********************************************************************
* Inline declarations
    data(age) = 24.
    data(name2) = `Jorge`.
    data(date) = '20231219'.

    out->write( age ).
    out->write( name2 ).
    out->write( date ).



  ENDMETHOD.
ENDCLASS.
