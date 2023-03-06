*&---------------------------------------------------------------------*
*& Report ZRTEST_215_FUNCTION_ALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_FUNCTION_ALV.

TABLES : ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA.

DATA : GT_FCAT TYPE SLIS_T_FIELDCAT_ALV.
DATA : GS_FCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZNAME
    INTO TABLE GT_DATA
    FROM ZTTEST_215_HR
    WHERE ZCODE IN S_ZCODE.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-SELTEXT_L = '코드'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-SELTEXT_L = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_LAYOUT-ZEBRA = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
*     I_CALLBACK_PROGRAM                = ' '
     I_CALLBACK_PROGRAM                = SY-REPID
     I_CALLBACK_PF_STATUS_SET          = 'PF_STATUS_SET'
     I_CALLBACK_USER_COMMAND           = 'USER_COMMAND'
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
     I_GRID_TITLE                      = 'TITLE 215'
*     I_GRID_SETTINGS                   =
     IS_LAYOUT                         = GS_LAYOUT
     IT_FIELDCAT                       = GT_FCAT
*     IT_EXCLUDING                      =
*     IT_SPECIAL_GROUPS                 =
*     IT_SORT                           =
*     IT_FILTER                         =
*     IS_SEL_HIDE                       =
*     I_DEFAULT                         = 'X'
*     I_SAVE                            = ' '
*     IS_VARIANT                        =
*     IT_EVENTS                         =
*     IT_EVENT_EXIT                     =
*     IS_PRINT                          =
*     IS_REPREP_ID                      =
     I_SCREEN_START_COLUMN             = 10
     I_SCREEN_START_LINE               = 10
     I_SCREEN_END_COLUMN               = 100
     I_SCREEN_END_LINE                 = 80
*     I_HTML_HEIGHT_TOP                 = 0
*     I_HTML_HEIGHT_END                 = 0
*     IT_ALV_GRAPHICS                   =
*     IT_HYPERLINK                      =
*     IT_ADD_FIELDCAT                   =
*     IT_EXCEPT_QINFO                   =
*     IR_SALV_FULLSCREEN_ADAPTER        =
*     O_PREVIOUS_SRAL_HANDLER           =
*   IMPORTING
*     E_EXIT_CAUSED_BY_CALLER           =
*     ES_EXIT_CAUSED_BY_USER            =
    TABLES
      t_outtab                          = GT_DATA[]
*   EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS                            = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  FORM PF_STATUS_SET.
    SET PF-STATUS '0100' .
    SET TITLEBAR '0100'.
  ENDFORM.

*  FORM PF_STATUS_SET USING RT_EXTAB TYPE SLIS_T_EXTAB.
*    SET PF-STATUS '0100' .
*    SET TITLEBAR '0100'.
*  ENDFORM.

  FORM USER_COMMAND USING R_UCOMM LIKE SY-UCOMM
                          RS_SELFIELD TYPE SLIS_SELFIELD.

    CASE R_UCOMM.
      WHEN 'BACK' OR 'CANC'.
        LEAVE TO SCREEN 0.
    ENDCASE.

  ENDFORM.
