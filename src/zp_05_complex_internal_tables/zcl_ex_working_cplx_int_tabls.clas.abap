CLASS zcl_ex_working_cplx_int_tabls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_working_cplx_int_tabls IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connections TYPE zt_connections.

    "Form to set data to a complex table
    connections = value #(
        ( airport_from = 'EE' airport_to = 'HH' connection_id = '5' )
        ( airport_from = 'AA' airport_to = 'YY' connection_id = '6' )
        ( airport_from = 'XX' airport_to = 'BB' connection_id = '7' )
    ).

    "Add a empty initial row to the complex table
    APPEND INITIAL LINE TO connections.
    connections[ connection_id = '0000' ] = VALUE #(
        airport_from = 'CC'
        airport_to = 'BB'
        connection_id = '3'
    ).

    "It is known as 'work area'
    DATA connection LIKE LINE OF connections. "It's equal to DATA connection type ZSTRC_SIMPLE_CONNECTION.

    "Forms to add data to the complex table
    connection = VALUE #(
        airport_from = 'AA'
        airport_to = 'BB'
        connection_id = '1'
    ).
    APPEND connection TO connections.
    CLEAR connection.

    connection-airport_from = 'BB'.
    connection-airport_to = 'AA'.
    connection-connection_id = '2'.
    APPEND connection TO connections.

    APPEND VALUE #(
        airport_from = 'DD'
        airport_to = 'CC'
        connection_id = '4'
    ) TO connections.

    out->write( name = '**connections' data = connections ).

    "Examples cases using corresponding with complex tables
    types: BEGIN OF st_vehicle,
           model type i,
           brand type c LENGTH 10,
           doors type i,
    end of st_vehicle.

    types: BEGIN OF st_car,
           model type i,
           brand type c LENGTH 10,
           engine type c LENGTH 5,
           wheels type i,
    END OF st_car.

    types tt_vehicles type STANDARD TABLE OF st_vehicle with NON-UNIQUE KEY model brand.
    types tt_cars type STANDARD TABLE OF st_car with NON-UNIQUE KEY model brand engine.

    data vehicles type tt_vehicles.
    data cars type tt_cars.

    vehicles = value #(
        ( model = 2020 brand = 'BMW' doors = 4 )
        ( model = 2015 brand = 'Mercedez' doors = 2 )
        ( model = 1999 brand = 'Lada' doors = 5 )
        ( model = 2020 brand = 'BMW' doors = 2 )
    ).

    cars = CORRESPONDING #( vehicles ).

    out->write( name = '**vehicles' data = vehicles ).
    out->write( name = '**cars' data = cars ).



  ENDMETHOD.
ENDCLASS.
