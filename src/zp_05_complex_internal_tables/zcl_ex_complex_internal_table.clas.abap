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
    TYPES: BEGIN OF ls_simple_connection,
             connection_id TYPE /dmo/connection_id,
             airport_from  TYPE /dmo/airport_from_id,
             airport_to    TYPE /dmo/airport_to_id,
           END OF ls_simple_connection.

    DATA lt_connections TYPE TABLE OF ls_simple_connection.

    SELECT
    FROM /DMO/I_Connection
    FIELDS
        " These columns are assigned by order.
        " If you want to assign regardless the order, you must use CORRESPONDING OF and AS on each column
        ConnectionID,
        DepartureAirport,
        DestinationAirport
    WHERE DepartureAirport = 'SFO'
    INTO TABLE @lt_connections.

    APPEND VALUE #(
        connection_id = '0003'
        airport_from = 'EXE'
        airport_to = 'XEX'
    ) TO lt_connections.

    out->write( data = lt_connections name = 'lt_connections' ).
    out->write( |\n| ).

    " Index access
    out->write( lt_connections[ 2 ] ).
    " Key access
    out->write( lt_connections[ airport_from = 'EXE' ] ).

    "Definition for each type of table (standard, hashed and sorted)
    DATA lt_connections_1 TYPE TABLE OF ls_simple_connection. "Short syntax of TYPE STANDARD TABLE OF <type> WITH NON-UNIQUE DEFAULT KEY. and 1 or more keys
    DATA lt_connections_2 TYPE STANDARD TABLE OF ls_simple_connection WITH NON-UNIQUE DEFAULT KEY. "Long syntax of TYPE TABLE OF <type>. and 1 or more keys
    DATA lt_connections_3 TYPE SORTED TABLE OF ls_simple_connection WITH UNIQUE KEY connection_id. "valid with UNIQUE and NON-UNIQUE and 1 or more keys
    DATA lt_connections_4 TYPE HASHED TABLE OF ls_simple_connection WITH UNIQUE KEY airport_from airport_to. "valid with UNIQUE and NON-UNIQUE and 1 or more keys

    "Type of a global definition
    data lt_connection_global_type type zt_connections.

  ENDMETHOD.
ENDCLASS.
