CLASS zcl_ex_exercise_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_exercise_itab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO lcl_connections.
    connection = NEW #( connection_id = '0002' ).
*    DATA(output) = connection->get_output(  ).
    out->write( connection->get_output(  ) ).
  ENDMETHOD.
ENDCLASS.
