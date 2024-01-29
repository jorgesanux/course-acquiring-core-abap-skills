CLASS zcl_ex_intro_helloworld DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_ex_intro_helloworld IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world!!' ).
  ENDMETHOD.
ENDCLASS.
