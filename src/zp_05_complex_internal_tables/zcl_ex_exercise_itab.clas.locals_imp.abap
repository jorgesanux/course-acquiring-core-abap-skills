*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connections DEFINITION CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
        importing connection_id type /dmo/connection_id.
    METHODS get_output
        RETURNING VALUE(r_output) type string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      BEGIN OF st_airport,
        AirportID TYPE /dmo/airport_id,
        Name      TYPE /dmo/airport_name,
      END OF st_airport,

      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/carrier_name,
      END OF st_details,

      tt_airports TYPE STANDARD TABLE OF st_airport WITH NON-UNIQUE DEFAULT KEY.

    CLASS-DATA airports TYPE tt_airports.

    DATA details TYPE st_details.

ENDCLASS.

CLASS lcl_connections IMPLEMENTATION.

  METHOD constructor.
    SELECT
        AirportId, Name
    FROM /DMO/I_Airport
    INTO TABLE @airports.

    select single
        DepartureAirport,
        DestinationAirport,
        ConnectionId as AirlineName
    from /DMO/I_Connection
    where ConnectionId = @connection_id
    into @me->details.

  ENDMETHOD.

  METHOD get_output.
    data(departure_airport) = airports[ AirportID = me->details-departureairport ].
    data(destination_airport) = airports[ AirportID = me->details-destinationairport ].

    APPEND |Departure: { departure_airport-name }| to r_output.
    APPEND |Destination: { destination_airport-name }| to r_output.
  ENDMETHOD.

ENDCLASS.
