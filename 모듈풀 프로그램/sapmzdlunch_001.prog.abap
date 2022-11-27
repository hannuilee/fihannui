*&---------------------------------------------------------------------*
*& Module Pool      SAPMZDSUWON_13_M_EX
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM SAPMZDSUWON_13_M_EX2.

TABLES : ZDLUNCH002.

DATA :  GS_DATA TYPE ZDLUNCH002,
        GT_DATA TYPE TABLE OF ZDLUNCH002.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : RA01(1), RA02(1), RA03(1), RA04(1), RA05(1),
       RA06(1), RA07(1), RA08(1), RA09(1), RA10(1),
       RA11(1), RA12(1), MENU_ETC(20).
DATA : GV_ZDATE TYPE SY-DATUM.

CONTROLS TC100 TYPE TABLEVIEW USING SCREEN 200.



*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'PF100'.
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
      IF GS_DATA-ZNAME IS NOT INITIAL.
        IF RA01 = 'X'.
           GS_DATA-ZMENU = '한식뷔페'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA02 = 'X'.
           GS_DATA-ZMENU = '햄버거'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA03 = 'X'.
           GS_DATA-ZMENU = '중국집'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA04 = 'X'.
           GS_DATA-ZMENU = '한솥'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA05 = 'X'.
           GS_DATA-ZMENU = '부리또'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA06 = 'X'.
           GS_DATA-ZMENU = '도시의 맛(등촌)'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA07 = 'X'.
           GS_DATA-ZMENU = '편의점'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA08 = 'X'.
           GS_DATA-ZMENU = '김밥천국'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA09 = 'X'.
           GS_DATA-ZMENU = '국밥'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA10 = 'X'.
           GS_DATA-ZMENU = '무공돈까스'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA11  = 'X'.
           GS_DATA-ZMENU = '이치돈'.
           GS_DATA-ZDATE = SY-DATUM.
        ELSEIF RA12  = 'X'.
           GS_DATA-ZMENU = MENU_ETC.
           GS_DATA-ZDATE = SY-DATUM.
        ENDIF.

      ENDIF.

    IF  GS_DATA-ZNAME IS NOT INITIAL
    AND GS_DATA-ZMENU IS NOT INITIAL.

        GS_DATA-ERDAT = SY-DATUM.
        GS_DATA-ERZET = SY-UZEIT.              "UZEIT = 생성시간
        GS_DATA-ERNAM = SY-UNAME.

      INSERT ZDLUNCH002 FROM GS_DATA.
      COMMIT WORK.
      IF SY-SUBRC = 0.
           MESSAGE '밥무러 가자' TYPE 'I'.
      ENDIF.

    ENDIF.

    WHEN 'RESU'.

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
    WHEN 'CANC' OR 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

  CLEAR OK_CODE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0200 OUTPUT.
 SET PF-STATUS 'PF200'.
 SET TITLEBAR 'T200'.

 DESCRIBE TABLE GT_DATA LINES TC100-LINES.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0200 INPUT.

   GV_ZDATE = SY-DATUM.

   CASE OK_CODE.
   WHEN 'DISP'.

      IF GV_ZDATE IS NOT INITIAL.

        SELECT *
          FROM ZDLUNCH002
          INTO CORRESPONDING FIELDS OF TABLE GT_DATA
          WHERE ZDATE = GV_ZDATE.


*        SELECT *
*          FROM ZDLUNCH002
*          INTO CORRESPONDING FIELDS OF TABLE GT_DATA
*          WHERE ZDATE = GV_ZDATE.
      ENDIF.

    WHEN 'REFR'.

      CLEAR : GV_ZDATE, GS_DATA, GT_DATA[].

    WHEN 'DELE'.

      DELETE FROM ZDLUNCH002 WHERE ZDATE < SY-DATUM.

       MESSAGE '삭제되었습니다.' TYPE 'I'.


    ENDCASE.

      CLEAR OK_CODE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ABAP_TO_SCREEN OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE ABAP_TO_SCREEN OUTPUT.
READ TABLE GT_DATA INTO GS_DATA INDEX TC100-CURRENT_LINE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  SCREEN_TO_ABAP  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE SCREEN_TO_ABAP INPUT.

MODIFY GT_DATA FROM GS_DATA INDEX TC100-CURRENT_LINE.

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
    WHEN 'CANC' OR 'EXIT'.
      LEAVE PROGRAM.
  ENDCASE.

 CLEAR OK_CODE.

ENDMODULE.
