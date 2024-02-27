CLASS zcl_ex_dfd_selects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_DFD_SELECTS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lc_airport_from_id TYPE /dmo/airport_from_id.
    DATA lc_airport_to_id TYPE /dmo/airport_to_id.

    DATA lt_airports_from TYPE TABLE OF /dmo/airport_from_id.

    SELECT SINGLE
    FROM /dmo/connection
    FIELDS airport_from_id, airport_to_id
    WHERE carrier_id = 'LH'
        AND connection_id = '0400'
    INTO ( @lc_airport_from_id, @lc_airport_to_id ).

    SELECT DISTINCT airport_from_id
    FROM /dmo/connection
    INTO TABLE @lt_airports_from.

    out->write( |From: { lc_airport_from_id } - To: { lc_airport_to_id }| ).
    LOOP AT lt_airports_from INTO DATA(aiport_from).
      out->write( |Aiport: { aiport_from }| ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
