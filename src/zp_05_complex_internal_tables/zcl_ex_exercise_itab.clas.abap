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
    select distinct ConnectionId
    from /DMO/I_Connection
    into table @data(list_connections).

    loop at list_connections into data(connection_id).
        DATA connection TYPE REF TO lcl_connections.
        connection = NEW #( connection_id = connection_id-ConnectionID ).
        out->write( connection->get_output(  ) ).
        out->write( |\n| ).
    endloop.
  ENDMETHOD.
ENDCLASS.
