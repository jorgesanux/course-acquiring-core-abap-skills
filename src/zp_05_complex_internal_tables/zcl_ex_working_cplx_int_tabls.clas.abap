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
    connections = VALUE #(
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
    TYPES: BEGIN OF st_vehicle,
             model TYPE i,
             brand TYPE c LENGTH 10,
             doors TYPE i,
           END OF st_vehicle.

    TYPES: BEGIN OF st_car,
             model  TYPE i,
             brand  TYPE c LENGTH 10,
             engine TYPE c LENGTH 5,
             wheels TYPE i,
           END OF st_car.

    TYPES tt_vehicles TYPE STANDARD TABLE OF st_vehicle WITH NON-UNIQUE KEY model brand.
    TYPES tt_cars TYPE STANDARD TABLE OF st_car WITH NON-UNIQUE KEY model brand engine.

    DATA vehicles TYPE tt_vehicles.
    DATA cars TYPE tt_cars.

    vehicles = VALUE #(
        ( model = 2020 brand = 'BMW' doors = 4 )
        ( model = 2015 brand = 'Mercedez' doors = 2 )
        ( model = 1999 brand = 'Lada' doors = 5 )
        ( model = 2020 brand = 'BMW' doors = 2 )
    ).

    "CORRESPONDING creates the same quantity of rows, but only match the same columns (name)
    cars = CORRESPONDING #( vehicles ).

    out->write( name = '**vehicles' data = vehicles ).
    out->write( name = '**cars' data = cars ).

    "Accessing to data from complex tables
    DATA vehicle LIKE LINE OF vehicles.
    vehicle = vehicles[ model = 2020 ].

    out->write( name = '**vehicle' data = vehicle ).

    TRY.
        DATA counter TYPE i VALUE 0.
        LOOP AT vehicles INTO vehicle WHERE model <> 2020.
          counter += 1.
          out->write( name = |**vehicle loop { counter }| data = vehicle ).
        ENDLOOP.
      CATCH cx_sy_itab_line_not_found INTO DATA(err).
        out->write( |[{ err->get_text(  ) }] { err->get_longtext(  ) }| ).
    ENDTRY.

    "Modify table statement
    DATA vehicle_modified LIKE LINE OF vehicles.

    vehicle_modified = vehicles[ brand = 'BMW' doors = 4 ].
    vehicle_modified-doors = 99.
    MODIFY TABLE vehicles FROM vehicle_modified.

    out->write( name = '**vehicle modified' data = vehicles ).

    "Modify statement
    DATA car_modified LIKE LINE OF cars.
    car_modified = VALUE #(
        model = 2024
        brand = 'Renault'
        engine = 2
        wheels = 4
    ).
    MODIFY cars FROM car_modified INDEX 1.

    out->write( name = '**modify car' data = cars ).

    LOOP AT cars INTO DATA(car_to_modify) WHERE engine IS INITIAL.
      car_to_modify-engine = 1.
      MODIFY cars FROM car_to_modify.
    ENDLOOP.

    out->write( name = '**modify car loop' data = cars ).

  ENDMETHOD.
ENDCLASS.
