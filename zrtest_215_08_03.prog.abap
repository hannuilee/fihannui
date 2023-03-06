*&---------------------------------------------------------------------*
*& Report ZRTEST_215_08_03
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_08_03.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA_01 OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA_01.

DATA : BEGIN OF GT_DATA_02 OCCURS 0,
        ZCODE LIKE ZTTEST_215_UNI-ZCODE,
        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
       END OF GT_DATA_02.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_REPID TYPE SY-REPID,
       GV_DYNNR TYPE SY-DYNNR.

INITIALIZATION.

START-OF-SELECTION.
  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 IF GV_REPID IS INITIAL.
   GV_REPID = SY-REPID.
   GV_DYNNR = '110'.
 ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'SUB1'.
      GV_REPID = SY-REPID.
      GV_DYNNR = '110'.

    WHEN 'SUB2'.
      GV_REPID = SY-REPID.
      GV_DYNNR = '120'.
  ENDCASE.

ENDMODULE.
