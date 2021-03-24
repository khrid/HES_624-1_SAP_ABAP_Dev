# 0354 - Module Global
## Submitted challenge
```abap
*&---------------------------------------------------------------------*
*& Report ZPROG_MODULE_GLOBAL2_E27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprog_module_global2_e27 MESSAGE-ID zmsg_e27.

DATA :  gv_result_function  TYPE int1
      .

PARAMETERS : pa_01 TYPE int1 DEFAULT '10',
             pa_02 TYPE int1 DEFAULT '5'
             .

*-----------------------------------------------------------
START-OF-SELECTION . " Program Start at this point
*-----------------------------------------------------------
  IF pa_02 = 0.
    MESSAGE e000 WITH 'Number 01'(p01) 'Number 02'(p02).
*   Please, enter a correct parameter for &1 or &2
    EXIT.
  ENDIF.

* ADDITION
  CALL FUNCTION 'Z_FM_BASIS2_ADD_E27'
    EXPORTING
      iv_number01 = pa_01
      iv_number02 = pa_02
    IMPORTING
      ev_result   = gv_result_function.

  CASE sy-subrc.
    WHEN 0.
      WRITE : / pa_01, ' + ', pa_02, ' = ', gv_result_function.
  ENDCASE.

* SOUSTRACTION
  CALL FUNCTION 'Z_FM_BASIS2_SUBSTRACT_E27'
    EXPORTING
      iv_number01    = pa_01
      iv_number02    = pa_02
    IMPORTING
      ev_result      = gv_result_function
    EXCEPTIONS
      ex_num2_higher = 1
      OTHERS         = 2.

  CASE sy-subrc.
    WHEN 0.
      WRITE : / pa_01, ' - ', pa_02, ' = ', gv_result_function.
    WHEN 1.
      WRITE : / 'Substraction - Error conversion INT1, Number 02 is higher than Number 01'(t01).
    WHEN 2.
      WRITE : / 'Unknown error'(t03).
  ENDCASE.

* MULTIPLICATION
  CALL FUNCTION 'Z_FM_BASIS2_MULTIPLY_E27'
    EXPORTING
      iv_number01 = pa_01
      iv_number02 = pa_02
    IMPORTING
      ev_result   = gv_result_function.

  CASE sy-subrc.
    WHEN 0.
      WRITE : / pa_01, ' * ', pa_02, ' = ', gv_result_function.
  ENDCASE.

* DIVISION
  CALL FUNCTION 'Z_FM_BASIS2_DIVIDE_E27'
    EXPORTING
      iv_number01         = pa_01
      iv_number02         = pa_02
    IMPORTING
      ev_result           = gv_result_function
    EXCEPTIONS
      ex_division_by_zero = 1
      OTHERS              = 2.

  CASE sy-subrc.
    WHEN 0.
      WRITE : / pa_01, ' / ', pa_02, ' = ', gv_result_function.
    WHEN 1.
      WRITE : / 'Division - Can''t divide by zero'(t02).
    WHEN 2.
      WRITE : / 'Unknown error'(t03).
  ENDCASE.
```

## Teacher's feedback

