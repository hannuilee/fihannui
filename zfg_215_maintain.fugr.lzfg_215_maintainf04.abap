*----------------------------------------------------------------------*
***INCLUDE LZFG_215_MAINTAINF04.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form NEW_ZTTEST_215_HR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM NEW_ZTTEST_215_HR .

  DATA : LS_ZTTEST_215_HR LIKE ZTTEST_215_HR.

*  ZTTEST_215_HR-ERDAT = SY-DATUM.
*  ZTTEST_215_HR-ERZET = SY-UZEIT.
*  ZTTEST_215_HR-ERNAM = SY-UNAME.

  IF ZTTEST_215_HR-ZNAME IS NOT INITIAL.
    SELECT SINGLE *
      INTO LS_ZTTEST_215_HR
      FROM ZTTEST_215_HR
      WHERE ZNAME = ZTTEST_215_HR-ZNAME.

    ZTTEST_215_HR-ZPHONE = LS_ZTTEST_215_HR-ZPHONE.
  ENDIF.

ENDFORM.
