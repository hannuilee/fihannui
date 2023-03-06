FUNCTION ZFC_SUWON_215_CAL.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUM1) TYPE  I
*"     REFERENCE(IV_NUM2) TYPE  I
*"     REFERENCE(IV_CHAR) TYPE  C
*"  EXPORTING
*"     REFERENCE(EV_RESULT) TYPE  I
*"  EXCEPTIONS
*"      DIV_ZERO
*"      215
*"      216
*"----------------------------------------------------------------------
  IF IV_CHAR = '+'.
    EV_RESULT = IV_NUM1 + IV_NUM2.

  ELSEIF IV_CHAR = '-'.
    EV_RESULT = IV_NUM1 - IV_NUM2.

  ELSEIF IV_CHAR = '*'.
    EV_RESULT = IV_NUM1 * IV_NUM2.

  ELSEIF IV_CHAR = '/'.
    IF IV_NUM2 = 0.
      RAISE DIV_ZERO.
      EXIT.
    ENDIF.

    EV_RESULT = IV_NUM1 / IV_NUM2.
  ENDIF.





ENDFUNCTION.
