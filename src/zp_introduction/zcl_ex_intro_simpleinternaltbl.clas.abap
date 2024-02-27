CLASS zcl_ex_intro_simpleinternaltbl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_INTRO_SIMPLEINTERNALTBL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA t_users TYPE TABLE OF string.

    " Adds rows to the internal table
    APPEND 'Jorge' TO t_users.
    APPEND 'Andres' TO t_users.
    APPEND 'Carlos' TO t_users.
    APPEND 'Juan' TO t_users.

    " It accesses a row in the internal table. It is similar to retrieving an index in an array.
    DATA manual_name TYPE string.
    manual_name = t_users[ 1 ].

    " It loops over internal table as an for loop
    DATA name TYPE string.
    LOOP AT t_users INTO name.
      out->write( |Row: { sy-tabix } \| Name: { name }| ).
    ENDLOOP.

    LOOP AT t_users INTO data(name2).
      out->write( |Row: { sy-tabix } { sy-index } \| Name2: { name2 }| ).
    ENDLOOP.

    " It clears the internal table to its original value. In this case, it is a table with zero rows
    CLEAR t_users.

    DATA flight TYPE /dmo/t_flight.


  ENDMETHOD.
ENDCLASS.
