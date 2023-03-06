*&---------------------------------------------------------------------*
*& Report ZRTEST_215_MEMORY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_MEMORY.

TABLES : ZTTEST_215_UNI, ZTTEST_215_HR.

DATA : BEGIN OF GT_DATA OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
        ZMAJOR LIKE ZTTEST_215_UNI-ZMAJOR,
       END OF GT_DATA.

DATA : BEGIN OF GT_DATA_02 OCCURS 0,
        ZCODE LIKE ZTTEST_215_HR-ZCODE,
        ZNAME LIKE ZTTEST_215_HR-ZNAME,
       END OF GT_DATA_02.

DATA : GT_FCAT TYPE SLIS_T_FIELDCAT_ALV,
       GS_FCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GV_ZRTEST_215_10.

SELECT-OPTIONS : S_ZCODE FOR ZTTEST_215_HR-ZCODE.

INITIALIZATION.

START-OF-SELECTION.
  SELECT ZCODE ZMAJOR
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM ZTTEST_215_UNI
    WHERE ZCODE IN S_ZCODE.

  GV_ZRTEST_215_10 = 'X'.
  EXPORT GV_ZRTEST_215_10 TO MEMORY ID 'MEM_10'.

  SUBMIT ZRTEST_215_10 WITH S_ZCODE IN S_ZCODE
  AND RETURN.

  IMPORT GT_DATA_02[] FROM MEMORY ID 'MEM_GT_DATA_02'.
  FREE MEMORY ID 'MEM_GT_DATA_02'.

  IF GT_DATA_02[] IS NOT INITIAL.
    LOOP AT GT_DATA.
      READ TABLE GT_DATA_02 WITH KEY ZCODE = GT_DATA-ZCODE.
      IF SY-SUBRC = 0.
        GT_DATA-ZNAME = GT_DATA_02-ZNAME.
      ENDIF.

      MODIFY GT_DATA.
      CLEAR GT_DATA.
    ENDLOOP.
  ENDIF.

  GS_FCAT-FIELDNAME = 'ZCODE'.
  GS_FCAT-SELTEXT_L =
  GS_FCAT-SELTEXT_M =
  GS_FCAT-SELTEXT_S = '코드'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZNAME'.
  GS_FCAT-SELTEXT_L =
  GS_FCAT-SELTEXT_M =
  GS_FCAT-SELTEXT_S = '코드명'.
  APPEND GS_FCAT TO GT_FCAT.

  GS_FCAT-FIELDNAME = 'ZMAJOR'.
  GS_FCAT-SELTEXT_L =
  GS_FCAT-SELTEXT_M =
  GS_FCAT-SELTEXT_S = '전공'.
  APPEND GS_FCAT TO GT_FCAT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
   EXPORTING
*     I_INTERFACE_CHECK                 = ' '
*     I_BYPASSING_BUFFER                = ' '
*     I_BUFFER_ACTIVE                   = ' '
*     I_CALLBACK_PROGRAM                = ' '
*     I_CALLBACK_PF_STATUS_SET          = ' '
*     I_CALLBACK_USER_COMMAND           = ' '
*     I_CALLBACK_TOP_OF_PAGE            = ' '
*     I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*     I_CALLBACK_HTML_END_OF_LIST       = ' '
*     I_STRUCTURE_NAME                  =
*     I_BACKGROUND_ID                   = ' '
     I_GRID_TITLE                      = 'MEMORY'
*     I_GRID_SETTINGS                   =
*     IS_LAYOUT                         =
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
*     I_SCREEN_START_COLUMN             = 0
*     I_SCREEN_START_LINE               = 0
*     I_SCREEN_END_COLUMN               = 0
*     I_SCREEN_END_LINE                 = 0
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
      T_OUTTAB                          = GT_DATA[]
*   EXCEPTIONS
*     PROGRAM_ERROR                     = 1
*     OTHERS                            = 2
            .
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.
