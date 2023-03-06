*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_TEMP02_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .
  DATA : LV_TABIX TYPE SY-TABIX.

  SELECT A~MATNR B~MAKTX
    INTO CORRESPONDING FIELDS OF TABLE GT_DATA
    FROM MARA AS A
    INNER JOIN MAKT AS B
    ON A~MATNR = B~MATNR
    WHERE A~MATNR IN S_MATNR.

  LOOP AT GT_DATA INTO GS_DATA.
    LV_TABIX = SY-TABIX.

    GS_DATA-INT = LV_TABIX.

    MODIFY GT_DATA FROM GS_DATA.
    CLEAR : GS_DATA.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CREATE_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CREATE_OBJECT .

CREATE OBJECT GC_DOCKING
  EXPORTING
*    PARENT                      =
    REPID                       = SY-REPID
    DYNNR                       = SY-DYNNR
*    SIDE                        = DOCK_AT_LEFT
    EXTENSION                   = 5000
*    STYLE                       =
*    LIFETIME                    = lifetime_default
*    CAPTION                     =
*    METRIC                      = 0
*    RATIO                       =
*    NO_AUTODEF_PROGID_DYNNR     =
*    NAME                        =
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

CREATE OBJECT GC_SPLITTER
  EXPORTING
*    LINK_DYNNR        =
*    LINK_REPID        =
*    SHELLSTYLE        =
*    LEFT              =
*    TOP               =
*    WIDTH             =
*    HEIGHT            =
*    METRIC            = cntl_metric_dynpro
*    ALIGN             = 15
    PARENT            = GC_DOCKING
    ROWS              = 2
    COLUMNS           = 1
*    NO_AUTODEF_PROGID_DYNNR =
*    NAME              =
*  EXCEPTIONS
*    CNTL_ERROR        = 1
*    CNTL_SYSTEM_ERROR = 2
*    OTHERS            = 3
    .
IF SY-SUBRC <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

CALL METHOD GC_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 1
    COLUMN    = 1
  RECEIVING
    CONTAINER = GC_CONTAINER_1
    .

CALL METHOD GC_SPLITTER->GET_CONTAINER
  EXPORTING
    ROW       = 2
    COLUMN    = 1
  RECEIVING
    CONTAINER = GC_CONTAINER_2
    .

CREATE OBJECT GC_GRID_1
  EXPORTING
*    I_SHELLSTYLE      = 0
*    I_LIFETIME        =
    I_PARENT          = GC_CONTAINER_1
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

CREATE OBJECT GC_GRID_2
  EXPORTING
*    I_SHELLSTYLE      = 0
*    I_LIFETIME        =
    I_PARENT          = GC_CONTAINER_2
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

ENDFORM.
*&---------------------------------------------------------------------*
*& Form FIELD_CATALOG
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM FIELD_CATALOG .

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'ICON'.
GS_FCAT-COLTEXT   = '신호등'.
GS_FCAT-JUST      = 'C'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'MATNR'.
GS_FCAT-COLTEXT   = '자재'.
GS_FCAT-HOTSPOT   = 'X'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'MAKTX'.
GS_FCAT-COLTEXT   = '자재명'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'INT'.
GS_FCAT-COLTEXT   = '숫자'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'CHAR'.
GS_FCAT-COLTEXT   = '메모'.
GS_FCAT-EDIT      = 'X'.
APPEND GS_FCAT TO GT_FCAT.

CLEAR GS_FCAT.
GS_FCAT-FIELDNAME = 'CHAR2'.
GS_FCAT-COLTEXT   = '메모2'.
APPEND GS_FCAT TO GT_FCAT.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM LAYOUT .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ETC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM ETC .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY .

CALL METHOD GC_GRID_1->SET_TABLE_FOR_FIRST_DISPLAY
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

CALL METHOD GC_GRID_2->SET_TABLE_FOR_FIRST_DISPLAY
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

ENDFORM.
*&---------------------------------------------------------------------*
*& Form REFRESH
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM REFRESH .
  DATA : LS_STABLE TYPE LVC_S_STBL.

*  LS_STABLE-ROW = 'X'.
*  LS_STABLE-COL = 'X'.


CALL METHOD GC_GRID_1->REFRESH_TABLE_DISPLAY
  EXPORTING
    IS_STABLE      = LS_STABLE
*    I_SOFT_REFRESH =
*  EXCEPTIONS
*    FINISHED       = 1
*    OTHERS         = 2
        .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_OBJECT
*&      --> E_INTERFACE
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_TOOLBAR  USING  E_OBJECT TYPE REF TO CL_ALV_EVENT_TOOLBAR_SET
                                E_INTERACTIVE.

  "CL_ALV_EVENT_TOOLBAR_SET=>MT_TOOLBAR
  "MT_TOOLBAR-TTB_BUTTON-STB_BUTTON

  DATA : LS_TOOLBAR TYPE STB_BUTTON.

  LS_TOOLBAR-FUNCTION = 'TEXT'.
  LS_TOOLBAR-ICON     = ICON_CHECKED.
  LS_TOOLBAR-TEXT     = '텍스트'.
  LS_TOOLBAR-QUICKINFO = 'INFO'.
*  APPEND LS_TOOLBAR TO MT_TOOLBAR.
  APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form EVENT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM EVENT .

  CREATE OBJECT GO_EVENT.

  CALL METHOD GC_GRID_1->REGISTER_EDIT_EVENT
    EXPORTING
      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED
*    EXCEPTIONS
*      ERROR      = 1
*      OTHERS     = 2
          .
  IF SY-SUBRC <> 0.
*   Implement suitable error handling here
  ENDIF.


  SET HANDLER GO_EVENT->HANDLE_TOOLBAR FOR GC_GRID_1.
  SET HANDLER GO_EVENT->HANDLE_USER_COMMAND FOR GC_GRID_1.
  SET HANDLER GO_EVENT->HANDLE_DOUBLE_CLICK FOR GC_GRID_1.
  SET HANDLER GO_EVENT->HANDLE_HOTSPOT_CLICK FOR GC_GRID_1.
  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID_1.
  SET HANDLER GO_EVENT->HANDLE_DATA_FINISHED FOR GC_GRID_1.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_UCOMM
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_USER_COMMAND  USING  E_UCOMM TYPE SY-UCOMM..

  CASE E_UCOMM.
    WHEN 'TEXT'.
      MESSAGE '215!!!!!!' TYPE 'I'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DOUBLE_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW
*&      --> E_COLUMN
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_DOUBLE_CLICK  USING    E_ROW TYPE LVC_S_ROW
                                       E_COLUMN TYPE LVC_S_COL
                                       ES_ROW_NO TYPE LVC_S_ROID.
  DATA : LV_CHAR(2).

  CASE E_COLUMN-FIELDNAME.
    WHEN 'INT'.
      CLEAR GS_DATA.
      READ TABLE GT_DATA INTO GS_DATA INDEX ES_ROW_NO-ROW_ID.
      IF SY-SUBRC = 0.
        LV_CHAR = GS_DATA-INT.
        MESSAGE LV_CHAR TYPE 'I'.
      ENDIF.

  ENDCASE.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_HOTSPOT_CLICK
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_ROW_ID
*&      --> E_COLUMN_ID
*&      --> ES_ROW_NO
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_HOTSPOT_CLICK  USING  E_ROW_ID TYPE LVC_S_ROW
                                      E_COLUMN_ID TYPE LVC_S_COL
                                      ES_ROW_NO TYPE LVC_S_ROID.

  CASE E_COLUMN_ID-FIELDNAME.
    WHEN 'MATNR'.
      CLEAR GS_DATA.
      READ TABLE GT_DATA INTO GS_DATA INDEX ES_ROW_NO-ROW_ID.
      SET PARAMETER ID 'MAT' FIELD GS_DATA-MATNR.
      CALL TRANSACTION 'MM03'.
  ENDCASE.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DATA_CHANGED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ER_DATA_CHANGED
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_DATA_CHANGED  USING ER_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL.

"CL_ALV_CHANGED_DATA_PROTOCOL=>MT_GOOD_CELLS
"MT_GOOD_CELLS-LVC_T_MODI
"LVC_T_MODI-LVC_S_MODI
"LVC_S_MODI-FIELNAME / ROW_ID / VALUE

DATA : LS_MODI TYPE LVC_S_MODI.

*LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*
*  IF LS_MODI-FIELDNAME = 'CHAR'.
*    CLEAR GS_DATA.
*    READ TABLE GT_DATA INTO GS_DATA INDEX LS_MODI-ROW_ID.
*
*    IF LS_MODI-VALUE = '이원오'.
*      GS_DATA-ICON = ICON_LED_GREEN.
*    ELSE.
*      GS_DATA-ICON = ICON_LED_RED.
*    ENDIF.
*
*
*    MODIFY GT_DATA FROM GS_DATA INDEX LS_MODI-ROW_ID.
*  ENDIF.
*
*ENDLOOP.
*
*PERFORM REFRESH.

*LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
*  IF LS_MODI-FIELDNAME = 'CHAR'.
*    CLEAR GS_DATA.
*    READ TABLE GT_DATA INTO GS_DATA INDEX LS_MODI-ROW_ID.
*
*    IF LS_MODI-VALUE = '이원오'.
*      CALL METHOD ER_DATA_CHANGED->MODIFY_CELL
*        EXPORTING
*          I_ROW_ID    = LS_MODI-ROW_ID
**          I_TABIX     =
*          I_FIELDNAME = 'ICON'
*          I_VALUE     = ICON_LED_GREEN
*          .
*
*    ELSE.
*      CALL METHOD ER_DATA_CHANGED->MODIFY_CELL
*        EXPORTING
*          I_ROW_ID    = LS_MODI-ROW_ID
**          I_TABIX     =
*          I_FIELDNAME = 'ICON'
*          I_VALUE     = ICON_LED_RED
*          .
*    ENDIF.
*  ENDIF.
*ENDLOOP.

LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.
  IF LS_MODI-FIELDNAME = 'CHAR'.
    CLEAR GS_DATA.
    READ TABLE GT_DATA INTO GS_DATA INDEX LS_MODI-ROW_ID.

    IF LS_MODI-VALUE = '이원오'.
      GS_DATA-ICON = ICON_LED_GREEN.
    ELSE.
      GS_DATA-ICON = ICON_LED_RED.
    ENDIF.
  ENDIF.

  MODIFY GT_DATA FROM GS_DATA INDEX LS_MODI-ROW_ID.
ENDLOOP.

  CALL METHOD CL_GUI_CFW=>SET_NEW_OK_CODE
    EXPORTING
      NEW_CODE = 'OK'
*    IMPORTING
*      RC       =
      .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form ALV_HANDLE_DATA_FINISHED
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> ET_GOOD_CELLS
*&---------------------------------------------------------------------*
FORM ALV_HANDLE_DATA_FINISHED  USING ET_GOOD_CELLS TYPE LVC_T_MODI.

  DATA : LS_MODI TYPE LVC_S_MODI.

  LOOP AT ET_GOOD_CELLS INTO LS_MODI.
    IF LS_MODI-FIELDNAME = 'CHAR'.
      CLEAR GS_DATA.
      READ TABLE GT_DATA INTO GS_DATA INDEX LS_MODI-ROW_ID.

      IF GS_DATA-ICON = ICON_LED_GREEN.
        GS_DATA-CHAR2 = GS_DATA-CHAR.
      ENDIF.
    ENDIF.

    MODIFY GT_DATA FROM GS_DATA INDEX LS_MODI-ROW_ID.
  ENDLOOP.

ENDFORM.
