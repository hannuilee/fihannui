*&---------------------------------------------------------------------*
*& Report ZRTEST_215_TEMP01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_TEMP01.

"DATA 선언

"조회조건

"INITIALIZAION

"START-OF-SELECTION

"ENE-OF-SELECTION

TABLES : MARA.

DATA : BEGIN OF GS_DATA,
        MATNR TYPE MARA-MATNR,
        MAKTX TYPE MAKT-MAKTX,
       END OF GS_DATA.

DATA : GT_DATA LIKE TABLE OF GS_DATA.

DATA : OK_CODE TYPE SY-UCOMM.

DATA : GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

DATA : GT_FCAT TYPE LVC_T_FCAT.
DATA : GS_FCAT TYPE LVC_S_FCAT.

SELECT-OPTIONS : S_MATNR FOR MARA-MATNR.

INITIALIZATION.

START-OF-SELECTION.
  SELECT A~MATNR B~MAKTX
    INTO TABLE GT_DATA
    FROM MARA AS A
    INNER JOIN MAKT AS B
    ON A~MATNR = B~MATNR
    WHERE A~MATNR IN S_MATNR.

  CALL SCREEN 100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.
 SET PF-STATUS 'STATUS100'.
 SET TITLEBAR 'T100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module ALV_DISPLAY_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE ALV_DISPLAY_0100 OUTPUT.

CREATE OBJECT GC_CUSTOM
  EXPORTING
*    PARENT                      =
    CONTAINER_NAME              = 'GC_CONTROL'
*    STYLE                       =
*    LIFETIME                    = lifetime_default
*    REPID                       =
*    DYNNR                       =
*    NO_AUTODEF_PROGID_DYNNR     =
*  EXCEPTIONS
*    CNTL_ERROR                  = 1
*    CNTL_SYSTEM_ERROR           = 2
*    CREATE_ERROR                = 3
*    LIFETIME_ERROR              = 4
*    LIFETIME_DYNPRO_DYNPRO_LINK = 5
*    OTHERS                      = 6
    .
IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CREATE OBJECT GC_GRID
  EXPORTING
*    I_SHELLSTYLE      = 0
*    I_LIFETIME        =
    I_PARENT          = GC_CUSTOM
*    I_APPL_EVENTS     = SPACE
*    I_PARENTDBG       =
*    I_APPLOGPARENT    =
*    I_GRAPHICSPARENT  =
*    I_NAME            =
*    I_FCAT_COMPLETE   = SPACE
*    O_PREVIOUS_SRAL_HANDLER =
*  EXCEPTIONS
*    ERROR_CNTL_CREATE = 1
*    ERROR_CNTL_INIT   = 2
*    ERROR_CNTL_LINK   = 3
*    ERROR_DP_CREATE   = 4
*    OTHERS            = 5
    .
IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'MATNR'.
GS_FCAT-COLTEXT   = '자재'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'MAKTX'.
GS_FCAT-COLTEXT   = '자재명'.
APPEND GS_FCAT TO GT_FCAT.

CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY
*  EXPORTING
*    I_BUFFER_ACTIVE               =
*    I_BYPASSING_BUFFER            =
*    I_CONSISTENCY_CHECK           =
*    I_STRUCTURE_NAME              =
*    IS_VARIANT                    =
*    I_SAVE                        =
*    I_DEFAULT                     = 'X'
*    IS_LAYOUT                     =
*    IS_PRINT                      =
*    IT_SPECIAL_GROUPS             =
*    IT_TOOLBAR_EXCLUDING          =
*    IT_HYPERLINK                  =
*    IT_ALV_GRAPHICS               =
*    IT_EXCEPT_QINFO               =
*    IR_SALV_ADAPTER               =
  CHANGING
    IT_OUTTAB                     = GT_DATA
    IT_FIELDCATALOG               = GT_FCAT
*    IT_SORT                       =
*    IT_FILTER                     =
*  EXCEPTIONS
*    INVALID_PARAMETER_COMBINATION = 1
*    PROGRAM_ERROR                 = 2
*    TOO_MANY_LINES                = 3
*    OTHERS                        = 4
        .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.



ENDMODULE.
