*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection_mng definition.

  public section.
    methods constructor
        importing
            id_airline type /dmo/carrier_id
            id_connection type /dmo/connection_id
        raising
            cx_abap_invalid_value.
    methods to_table_string
        returning value(table_data) type string_table.

  protected section.
  private section.
    data id_connection type /dmo/connection_id.

    data id_carrier type /dmo/carrier_id.
    data name_carrier type /dmo/carrier_name.

    data id_aiport_from type /dmo/airport_from_id.
    data name_aiport_from type /dmo/airport_name.

    data id_aiport_to type /dmo/airport_to_id.
    data name_aiport_to type /dmo/airport_name.

endclass.

class lcl_connection_mng implementation.
    method constructor.
        if id_airline is initial or id_connection is INITIAL.
            raise EXCEPTION type cx_abap_invalid_value.
        endif.

        me->id_carrier = id_airline.
        me->id_connection = id_connection.

        select single
            DepartureAirport,
            \_DepartureAirport-Name,
            DestinationAirport,
            \_DestinationAirport-Name,
            \_Airline-Name
        from /DMO/I_Connection
        where AirlineID = @me->id_carrier and ConnectionID = @me->id_connection
        into (
            @me->id_aiport_from,
            @me->name_aiport_from,
            @me->id_aiport_to,
            @me->name_aiport_to,
            @me->name_carrier
        ).

        if sy-subrc <> 0.
            raise exception type cx_abap_invalid_value.
        endif.
    endmethod.

    method to_table_string.
        append |From: [{ me->id_aiport_from }] { me->name_aiport_to }| to table_data.
        append |To: [{ me->id_aiport_to }] { me->name_aiport_from }| to table_data.
        append |Carrier: [{ me->id_aiport_to }] { me->name_carrier }| to table_data.
    endmethod.
endclass.
