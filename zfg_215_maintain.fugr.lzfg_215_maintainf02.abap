*----------------------------------------------------------------------*
***INCLUDE LZFG_215_MAINTAINF02.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form FILL_ZTTEST_215_HR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM FILL_ZTTEST_215_HR .
  DATA : LS_ZTTEST_215_HR LIKE ZTTEST_215_HR.

  IF ZTTEST_215_HR-ERDAT IS INITIAL.
    ZTTEST_215_HR-ERDAT = SY-DATUM.
    ZTTEST_215_HR-ERZET = SY-UZEIT.
    ZTTEST_215_HR-ERNAM = SY-UNAME.
  ENDIF.

  ZTTEST_215_HR-AEDAT = SY-DATUM.
  ZTTEST_215_HR-AEZET = SY-UZEIT.
  ZTTEST_215_HR-AENAM = SY-UNAME.

  IF ZTTEST_215_HR-ZNAME IS NOT INITIAL.
    SELECT SINGLE *
      INTO LS_ZTTEST_215_HR
      FROM ZTTEST_215_HR
      WHERE ZNAME = ZTTEST_215_HR-ZNAME.

    ZTTEST_215_HR-ZPHONE = LS_ZTTEST_215_HR-ZPHONE.
  ENDIF.

ENDFORM.
