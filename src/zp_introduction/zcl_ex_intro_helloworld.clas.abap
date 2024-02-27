CLASS zcl_ex_intro_helloworld DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_INTRO_HELLOWORLD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world!!' ).
  ENDMETHOD.
ENDCLASS.
