*&---------------------------------------------------------------------*
*& Report ZRTEST_215_08_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_08_02.

CONTROLS : GT_DATA_CON TYPE TABLEVIEW USING SCREEN 100.

TYPES : BEGIN OF TY_DATA,
         CARRID LIKE SFLIGHT-CARRID,
         CONNID LIKE SFLIGHT-CONNID,
         FLDATE LIKE SFLIGHT-FLDATE,
        END OF TY_DATA.

DATA : GT_DATA TYPE TABLE OF TY_DATA.
DATA : GS_DATA TYPE TY_DATA.

*DATA : BEGIN OF GT_DATA OCCURS 0,
*        CARRID LIKE SFLIGHT-CARRID,
*        CONNID LIKE SFLIGHT-CONNID,
*        FLDATE LIKE SFLIGHT-FLDATE,
*       END OF GT_DATA.

DATA : OK_CODE TYPE SY-UCOMM.

INITIALIZATION.

START-OF-SELECTION.
  SELECT CARRID CONNID FLDATE
    INTO TABLE GT_DATA
    FROM SFLIGHT
    WHERE CARRID = 'AA'.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.

 DESCRIBE TABLE GT_DATA LINES GT_DATA_CON-LINES.
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
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module MOVE_ABAP_SCREEN_DATA OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE move_abap_screen_data OUTPUT.
*  DESCRIBE TABLE GT_DATA LINES GT_DATA_CON-LINES.
  READ TABLE GT_DATA INTO GS_DATA INDEX GT_DATA_CON-CURRENT_LINE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  MOVE_SCREEN_ABAP_DATA  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE move_screen_abap_data INPUT.

  IF GT_DATA_CON-LINES < GT_DATA_CON-CURRENT_LINE.
    APPEND GS_DATA TO GT_DATA.
*    INSERT GS_DATA INTO GT_DATA INDEX GT_DATA_CON-CURRENT_LINE.

  ELSE.
    MODIFY GT_DATA FROM GS_DATA INDEX GT_DATA_CON-CURRENT_LINE.
  ENDIF.


ENDMODULE.
