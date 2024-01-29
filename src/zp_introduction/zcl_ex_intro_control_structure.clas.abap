CLASS zcl_ex_intro_control_structure DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_intro_control_structure IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    CONSTANTS min TYPE i VALUE 1.
    CONSTANTS max TYPE i VALUE 100.
    DATA(lo_random) = cl_abap_random_int=>create(
        seed = cl_abap_random=>seed( )
        min = min
        max = max
    ).

    DATA(lv_random_number) = lo_random->get_next(  ).

    "If, elseif, else
    IF lv_random_number MOD 2 = 0.
      out->write( |{ lv_random_number } is even| ).
    ELSE.
      out->write( |{ lv_random_number } is odd| ).
    ENDIF.

    IF lv_random_number < 20.
      out->write( |{ lv_random_number } is less than 20.| ).
    ELSEIF lv_random_number < 40.
      out->write( |{ lv_random_number } is less than 40.| ).
    ELSEIF lv_random_number < 60.
      out->write( |{ lv_random_number } is less than 60.| ).
    ELSEIF lv_random_number < 80.
      out->write( |{ lv_random_number } is less than 80.| ).
    ELSEIF lv_random_number < 100.
      out->write( |{ lv_random_number } is less than 100.| ).
    ELSE.
      out->write( |{ lv_random_number } is out of range.| ).
    ENDIF.


    "Case when
    DATA(lv_middle_max) = max / 2.
    DATA(lv_double_min) = min * 2.
    CASE lv_random_number.
      WHEN floor( lv_middle_max ).
        out->write( |{ lv_random_number } is the middle of the range.| ).
      WHEN lv_double_min.
        out->write( |{ lv_random_number } is double of the min.| ).
      WHEN OTHERS.
        out->write( |{ lv_random_number } not have a specific logic.| ).
    ENDCASE.

    "Do times
    DATA(lv_random_number_loops) = lo_random->get_next( ).
    DO lv_random_number_loops / 50 TIMES. "Se divide en 50 para no rellenar la consola de saltos de linea
      out->write( lv_random_number_loops ).
    ENDDO.

    "Do with exit
    DO.
      lv_random_number_loops = lo_random->get_next( ).
      out->write( |Index: { sy-index } \| Random number: { lv_random_number_loops }| ).
      IF lv_random_number_loops = max. EXIT. ENDIF.
    ENDDO.

    "Do times
    DATA lt_random_numbers TYPE TABLE OF i.
    DO 10 TIMES.
      APPEND lo_random->get_next( ) TO lt_random_numbers.
    ENDDO.

    "for loop or simply loop
    LOOP AT lt_random_numbers INTO DATA(rand_num).
      out->write( |Random number table: { rand_num }| ).
    ENDLOOP.

    "Try catch
    DATA num1 TYPE i VALUE 2.
    DATA num2 TYPE i VALUE 0.
    TRY.
        DATA(result) = num1 / num2.
        out->write( result ).
      CATCH cx_sy_arithmetic_error INTO DATA(err).
        out->write( |[{ err->get_text(  ) }] { err->get_longtext(  ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
