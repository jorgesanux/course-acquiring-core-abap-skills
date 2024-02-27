CLASS zcl_ex_working_structured_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EX_WORKING_STRUCTURED_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ls_connection,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF ls_connection.

    TYPES: BEGIN OF ls_connection_info,
             airport_to_id   TYPE /dmo/airport_to_id,
             airport_from_id TYPE /dmo/airport_from_id,
             message         TYPE symsg,
           END OF ls_connection_info.

    DATA lv_connection TYPE ls_connection.

    " Short and elegant form to fill the components of an structure
    lv_connection = VALUE #(
         airport_from_id = 'ABC'
         airport_to_id = 'XYZ'
         carrier_name = 'Buenas'
     ).

    out->write( lv_connection ).
    out->write( |\n| ).

    DATA lv_connection_info TYPE ls_connection_info.

    " When we do this assignment, the order of the components in structures determine where it is copied,
    lv_connection_info = lv_connection.

    out->write( lv_connection_info ).
    out->write( |\n| ).

    " This assignment map component of the structure in its corresponding destination component with the same name.
    lv_connection_info = CORRESPONDING #( lv_connection ).

    out->write( lv_connection_info ).
    out->write( |\n| ).

    " Nested structure assignment with Value #()
    lv_connection_info = VALUE #(
        airport_from_id  = 'AS'
        airport_to_id = 'WE'
        message = VALUE #(
            msgid = 'buenas'
            msgno = '321'
            msgty = 'E'
            msgv1 = 'Error not found'
        )
    ).

    out->write( lv_connection_info ).
    out->write( |\n| ).

    " Auto order mapping in result of query
    TYPES: BEGIN OF ls_connection_simple,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF ls_connection_simple.

    DATA lv_connection_simple TYPE ls_connection_simple.

    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
    INTO @lv_connection_simple.

    out->write( lv_connection_simple ).
    out->write( |\n| ).

    " Full mapping with SQL Query
    DATA lv_connection_full TYPE /DMO/I_Connection.

    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS *
    INTO  @lv_connection_full.

    out->write( lv_connection_full ).
    out->write( |\n| ).

    " Partial mapping regardless the order using  CORRESPONDING FIELDS
    DATA lv_connection_partial TYPE /DMO/I_Connection.
    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS Distance, ConnectionID
    INTO  CORRESPONDING FIELDS OF @lv_connection_partial.

    out->write( lv_connection_partial ).
    out->write( |\n| ).

    " Mapping with custom components names that not matches with original structure using AS

    TYPES: BEGIN OF ls_connection_names,
             origin_airport      TYPE /dmo/airport_from_id,
             destination_airport TYPE /dmo/airport_to_id,
             airport_name        TYPE /dmo/carrier_name,
           END OF ls_connection_names.

    DATA lv_connection_names TYPE ls_connection_names.

    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS
        \_Airline-Name AS airport_name,
*        DepartureAirport AS origin_airport,
        DestinationAirport AS destination_airport
    INTO CORRESPONDING FIELDS OF @lv_connection_names.

    out->write( lv_connection_names ).
    out->write( |\n| ).

    " Creating an in line typed variable with the structure result of the query
    SELECT SINGLE
    FROM /DMO/I_Connection
    FIELDS
        \_Airline-Name AS airport_name,
        Distance * 2 AS double_distance, "Expressions must have an alias
        DestinationAirport AS destination_airport
    INTO @DATA(lv_connection_inline).

    out->write( lv_connection_inline ).
    out->write( |\n| ).

    " Querying tables directly with joins
    SELECT SINGLE
    FROM /dmo/connection AS conn
    LEFT JOIN /dmo/airport AS air_from ON conn~airport_from_id = air_from~airport_id
    LEFT JOIN /dmo/airport AS air_to ON conn~airport_to_id = air_to~airport_id
    FIELDS
        conn~connection_id AS conn_id,
        air_from~name AS aiport_from,
        air_to~name AS airport_to
    INTO @DATA(lv_connection_join).

    out->write( lv_connection_join ).

  ENDMETHOD.
ENDCLASS.
