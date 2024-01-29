CLASS zcl_ex_lc_defining_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ex_lc_defining_local_class IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA operation TYPE REF TO lcl_operation.

    TRY.
        operation = NEW #(
            num1 = 2
            num2 = 5
        ).
        "Manera de la forma en que hay varios parametros para importar al metodo
*        operation->set_nums(
*            EXPORTING
*               num1 = 2
*        ).

        "Manera en que solo hay un parametro para importar al metodo
        "Por lo que se puede omitir la asignacion explciita y la palabra exporting
        operation->set_num1( 2 ).
        operation->set_num2( 5 ).
      CATCH cx_abap_invalid_value INTO DATA(err).
        out->write( |[{ err->get_text(  ) }] { err->get_longtext(  ) }| ).
    ENDTRY.

    DATA(sign) = lcl_operation=>sign_plus.

    DATA num1 TYPE lcl_operation=>number.
    DATA num2 TYPE lcl_operation=>number.
    operation->get_num1(
        IMPORTING num1 = num1
    ).
    operation->get_num2(
        IMPORTING num2 = num2
    ).
    operation->get_nums(
        IMPORTING
            num1 = num1
            num2 = num2
    ).

    out->write( |{ num1 } { sign } { num2 }| ).
*    out->write( operation ).

    DATA(num) = operation->get_first_number(  ).
    out->write( num ).
    out->write( |*********************************************************| ).

    DATA lt_operations TYPE TABLE OF REF TO lcl_operation.

    APPEND NEW #(
        num1 = 21
        num2 = 6
    ) TO lt_operations.
    APPEND NEW lcl_operation(
        num1 = 8
        num2 = 65
    ) TO lt_operations.
    APPEND operation TO lt_operations.

    out->write( lt_operations ).
    out->write( lt_operations[ 2 ] ).
    out->write( lt_operations[ lines( lt_operations ) ] ). "Lee la ultima fila de la internal table
  ENDMETHOD.
ENDCLASS.
