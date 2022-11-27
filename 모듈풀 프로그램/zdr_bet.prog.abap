*&---------------------------------------------------------------------*
*& Module Pool      ZDR_BET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM ZDR_BET.

TABLES : ZTBET_02.

DATA : GS_DATA LIKE ZTBET_02,
       GT_DATA LIKE TABLE OF ZTBET_02.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : RA01(1), RA02(1).

CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 200.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'ST100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.
    WHEN 'SUBM'.
        IF  GS_DATA-ZNAME IS NOT INITIAL.
        IF  RA01 = 'X'.
            GS_DATA-ZSELECT = '우루과이'.
        ELSEIF RA02 = 'X'.
            GS_DATA-ZSELECT = '대한민국'.
        ENDIF.

        IF  GS_DATA-ZNAME IS NOT INITIAL
        AND GS_DATA-ZSELECT IS NOT INITIAL.

        GS_DATA-ERDAT = SY-DATUM.
        GS_DATA-ERZET = SY-UZEIT.
        GS_DATA-ERNAM = SY-UNAME.

        MODIFY ZTBET_02 FROM GS_DATA.
        COMMIT WORK.
        ENDIF.
        IF SY-SUBRC = 0.
            MESSAGE '도박은 중독입니다.' TYPE 'I'.
        ENDIF.
        ENDIF.
     WHEN 'DISP'.

        CALL SCREEN 200.

  ENDCASE.

  CLEAR OK_CODE.


ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT INPUT.

    CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
 SET PF-STATUS 'ST200'.
 SET TITLEBAR 'T200'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  EXIT2  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE EXIT2 INPUT.

   CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN OTHERS.
  ENDCASE.

  CLEAR OK_CODE.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

ENDMODULE.
