*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_calculator DEFINITION.

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_calculator  IMPLEMENTATION.

ENDCLASS.


CLASS lcl_operation DEFINITION.

  PUBLIC SECTION.
    CONSTANTS sign_plus TYPE c VALUE '+'.
    CONSTANTS sign_minus TYPE c VALUE '-'.
    CONSTANTS sign_division TYPE c VALUE '/'.
    CONSTANTS sign_multiplication TYPE c VALUE '*'.
    TYPES number TYPE p LENGTH 16 DECIMALS 2.

    METHODS constructor
      IMPORTING
        num1 TYPE number
        num2 TYPE number
      RAISING
        cx_abap_invalid_value.

    "SETS
    METHODS set_num1
      IMPORTING
        num1 TYPE number
      RAISING
        cx_abap_invalid_value.
    METHODS set_num2
      IMPORTING
        num2 TYPE number
      RAISING
        cx_abap_invalid_value.

    "GETS
    METHODS get_num1
      EXPORTING
        num1 TYPE number.
    METHODS get_num2
      EXPORTING
        num2 TYPE number.
    METHODS get_nums
      EXPORTING
        num1 TYPE number
        num2 TYPE number.
    METHODS get_first_number
      RETURNING VALUE(num) TYPE number.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA num1 TYPE number.
    DATA num2 TYPE number.
ENDCLASS.

CLASS lcl_operation IMPLEMENTATION.

  METHOD constructor.
    IF num1 IS INITIAL OR num2 IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->num1 = num1.
    me->num2 = num2.
  ENDMETHOD.

  "Only use "me->" when the param's name are equal to the properties of the class.
  "If names are different then don't use "me" preferably.
  " "me" is as "this" in JavaScript

  "GETS
  METHOD get_num1.
    num1 = me->num1.
  ENDMETHOD.

  METHOD get_num2.
    num2 = me->num2.
  ENDMETHOD.

  METHOD get_nums.
    num1 = me->num1.
    num2 = me->num2.
  ENDMETHOD.

  METHOD get_first_number.
    num = num1.
  ENDMETHOD.

  "SETS
  METHOD set_num1.
    me->num1 = num1.
  ENDMETHOD.

  METHOD set_num2.
    me->num2 = num2.
  ENDMETHOD.
ENDCLASS.
