CLASS zcl_ex_structured_data_object DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_STRUCTURED_DATA_OBJECT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA ls_connection TYPE /DMO/I_Connection.

    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport "Also can be used the * to select all fields and put that into structure.
    WHERE AirlineID = 'LH'
      AND ConnectionID = '0400'
    INTO @ls_connection.

    out->write( ls_connection ).
    out->write( |\n| ).

    " Standard global structure
    DATA ls_message TYPE symsg.

    " Structure defined in CDS form
    DATA ls_http_error TYPE zstrc_http_error.

    ls_http_error-message = 'User not found'.
    ls_http_error-status_code = 404.
    ls_http_error-status_message = 'Not found'.

    out->write( ls_http_error ).
    out->write( |\n| ).

    " Long form to define Abap structure
    TYPES BEGIN OF ls_person.
    TYPES name TYPE string.
    TYPES lastname TYPE string.
    TYPES birthdate TYPE d..
    TYPES END OF ls_person.

    " Short form to define Abap structure
    TYPES: BEGIN OF ls_car,
             engine          TYPE string,
             quantity_wheels TYPE i,
             model           TYPE i,
             quantity_doors  TYPE i,
           END OF ls_car.

    " Nested structures
    TYPES: BEGIN OF ls_rich_person,
             person TYPE ls_person,
             car    TYPE ls_car,
           END OF ls_rich_person.

    DATA lv_rich_person TYPE ls_rich_person.
    lv_rich_person-person-name = 'Jorge'.
    lv_rich_person-person-lastname = 'Sanabria'.
    lv_rich_person-person-birthdate = '19880824'.
    lv_rich_person-car-engine = 'v8'.
    lv_rich_person-car-model = 2024.
    lv_rich_person-car-quantity_doors = 4.
    lv_rich_person-car-quantity_wheels = 4.

    out->write( lv_rich_person ).
    out->write( |\n| ).

    " Structure to save the result of a query
    TYPES: BEGIN OF st_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    DATA connection TYPE st_connection.

    " The order of the structure components must match with fields order in the query
    SELECT SINGLE FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name AS carrier_name
    WHERE AirlineID = 'LH' AND ConnectionID = '0400'
    INTO @connection.

    out->write( connection ).
    out->write( |\n| ).


  ENDMETHOD.
ENDCLASS.
