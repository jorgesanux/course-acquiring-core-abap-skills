CLASS zcl_ex_connection_mng DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_connection_mng IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    data lit_connections type table of ref to lcl_connection_mng.
    try.
        append new #( id_airline = 'SQ' id_connection = '0011' ) to lit_connections.
        append new #( id_airline = 'AA' id_connection = '0017' ) to lit_connections.
        append new #( id_airline = 'JL' id_connection = '0408' ) to lit_connections.
        append new #( id_airline = 'AZ' id_connection = '0789' ) to lit_connections.
    catch cx_abap_invalid_value into data(error).
        out->write( |Error: [{ error->get_text( ) }] { error->get_longtext( ) } | ).
    endtry.

    loop at lit_connections into data(connection).
        out->write( connection->to_table_string(  ) ).
        out->write( |\n| ).
    endloop.

  ENDMETHOD.
ENDCLASS.
