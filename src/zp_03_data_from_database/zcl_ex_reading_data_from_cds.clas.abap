CLASS zcl_ex_reading_data_from_cds DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_READING_DATA_FROM_CDS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA lv_airport_to TYPE /dmo/airport_to_id.
    DATA lv_airport_from TYPE /dmo/airport_from_id.
    DATA carrier_name TYPE /dmo/carrier_name.
    Data carrier_currency type /dmo/currency_code.

    SELECT SINGLE
        DepartureAirport, DestinationAirport, \_Airline-Name, \_Airline-CurrencyCode
    FROM /DMO/I_Connection
*    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
    WHERE AirlineID = 'LH'
        AND ConnectionID = '0400'
    INTO ( @lv_airport_from, @lv_airport_to, @carrier_name, @carrier_currency ).

    out->write( |{ lv_airport_from } \| { lv_airport_to } \| { carrier_name } \| { carrier_currency }| ).
  ENDMETHOD.
ENDCLASS.
