*&---------------------------------------------------------------------*
*& Report ZRTEST_215_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_08.

TABLES : ZTTEST_215_HR.

TYPES : BEGIN OF TY_DATA,
         ZCODE LIKE ZTTEST_215_HR-ZCODE,
         ZNAME LIKE ZTTEST_215_HR-ZNAME,
         ZPHONE LIKE ZTTEST_215_HR-ZPHONE,
         ZADDRESS LIKE ZTTEST_215_HR-ZADDRESS,
        END OF TY_DATA.

DATA : GT_DATA TYPE TABLE OF TY_DATA.
DATA : GS_DATA TYPE TY_DATA.

DATA : OK_CODE TYPE SY-UCOMM.

*DATA : BEGIN OF GT_DATA OCCURS 0,
*        ZCODE LIKE ZTTEST_215_HR-ZCODE,
*        ZNAME LIKE ZTTEST_215_HR-ZNAME,
*       END OF GT_DATA.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO TABLE GT_DATA
    FROM ZTTEST_215_HR
    WHERE ZCODE IN S_ZCODE.

  READ TABLE GT_DATA INTO GS_DATA INDEX 1.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  DATA : LT_FCODE TYPE TABLE OF SY-UCOMM.

  APPEND 'TEST' TO LT_FCODE.

  SET PF-STATUS 'STATUS100' EXCLUDING LT_FCODE.
  SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  DATA : LV_COMM TYPE SY-UCOMM.
  LV_COMM = OK_CODE.
  CLEAR OK_CODE.

  CASE LV_COMM.
    WHEN 'TEST2'.
      MESSAGE 'TEST2!!!' TYPE 'S'.

    WHEN 'BACK'.
      LEAVE TO SCREEN 0.

    WHEN 'DISP'.
      IF GS_DATA-ZADDRESS IS INITIAL.
        MESSAGE '주소가 없습니다.' TYPE 'S' DISPLAY LIKE 'E'.
      ELSE.
        MESSAGE GS_DATA-ZADDRESS TYPE 'I'.
      ENDIF.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE exit INPUT.

  CASE OK_CODE.
*    WHEN 'BACK' OR 'CANC' OR 'EXIT'.
    WHEN 'CANC' OR 'EXIT'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  ZCODE_CHECK  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE zcode_check INPUT.
  DATA : LV_ZNAME LIKE ZTTEST_215_HR-ZNAME.

  CLEAR : LV_ZNAME.
  SELECT SINGLE ZNAME ZPHONE ZADDRESS
    INTO ( LV_ZNAME,
           GS_DATA-ZPHONE,
           GS_DATA-ZADDRESS )
    FROM ZTTEST_215_HR
    WHERE ZCODE = GS_DATA-ZCODE.

  IF LV_ZNAME <> GS_DATA-ZNAME.
    MESSAGE '이름이 다릅니다.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module INIT_DISPLAY OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE init_display OUTPUT.

  LOOP AT SCREEN.
    IF SCREEN-GROUP2 = 'DIS'.
      SCREEN-INPUT = 0.
      SCREEN-INVISIBLE = 1.
    ENDIF.

    MODIFY SCREEN.
  ENDLOOP.

ENDMODULE.
