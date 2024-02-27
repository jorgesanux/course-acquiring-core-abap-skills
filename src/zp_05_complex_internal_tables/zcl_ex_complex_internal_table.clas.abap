CLASS zcl_ex_complex_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_complex_internal_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    types: begin of ls_simple_connection,
           connection_id type /dmo/connection_id,
           airport_from type /dmo/airport_from_id,
           airport_to type /dmo/airport_to_id,
           end of ls_simple_connection.

    data lt_connections type table of ls_simple_connection.

    select
    from /DMO/I_Connection
    fields
        " These columns are assigned by order.
        " If you want to assign regardless the order, you must use CORRESPONDING OF and AS on each column
        ConnectionID,
        DepartureAirport,
        DestinationAirport
    where DepartureAirport = 'SFO'
    into table @lt_connections.

    append value #(
        connection_id = '0003'
        airport_from = 'EXE'
        airport_to = 'XEX'
    ) to lt_connections.

    out->write( lt_connections ).
    out->write( |\n| ).

    " Index access
    out->write( lt_connections[ 2 ] ).
    " Key access
    out->write( lt_connections[ airport_from = 'EXE' ] ).

  ENDMETHOD.
ENDCLASS.
