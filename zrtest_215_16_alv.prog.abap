*&---------------------------------------------------------------------*
*& Include          ZRTEST_215_15_ALV
*&---------------------------------------------------------------------*

CLASS CLASS_EVENT DEFINITION. "정의부
  PUBLIC SECTION.

  METHODS HANDLE_TOOLBAR FOR EVENT TOOLBAR
                                OF CL_GUI_ALV_GRID
                         IMPORTING E_OBJECT
                                   E_INTERACTIVE.

  METHODS HANDLE_USER_COMMAND FOR EVENT USER_COMMAND
                                     OF CL_GUI_ALV_GRID
                              IMPORTING E_UCOMM.

  METHODS HANDLE_DOUBLE_CLICK FOR EVENT DOUBLE_CLICK
                                     OF CL_GUI_ALV_GRID
                              IMPORTING E_ROW
                                        E_COLUMN
                                        ES_ROW_NO.

  METHODS HANDLE_HOTSPOT_CLICK FOR EVENT HOTSPOT_CLICK
                                      OF CL_GUI_ALV_GRID
                               IMPORTING E_ROW_ID
                                         E_COLUMN_ID
                                         ES_ROW_NO.

  METHODS HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED
                                     OF CL_GUI_ALV_GRID
                              IMPORTING ER_DATA_CHANGED.

  METHODS HANDLE_CHANGED_FINISHED FOR EVENT DATA_CHANGED_FINISHED
                                         OF CL_GUI_ALV_GRID
                                  IMPORTING ET_GOOD_CELLS.

ENDCLASS.

CLASS CLASS_EVENT IMPLEMENTATION. "실행부
  METHOD HANDLE_TOOLBAR.
    PERFORM ALV_HANDLE_TOOLBAR USING E_OBJECT E_INTERACTIVE.
  ENDMETHOD.

  METHOD HANDLE_USER_COMMAND.
    PERFORM ALV_HANDLE_USER_COMMAND USING E_UCOMM.
  ENDMETHOD.

  METHOD HANDLE_DOUBLE_CLICK.
    PERFORM ALV_HANDLE_DOUBLE_CLICK USING E_ROW E_COLUMN ES_ROW_NO.
  ENDMETHOD.

  METHOD HANDLE_HOTSPOT_CLICK.
    PERFORM ALV_HANDLE_HOTSPOT_CLICK USING E_ROW_ID E_COLUMN_ID ES_ROW_NO.
  ENDMETHOD.

  METHOD HANDLE_DATA_CHANGED.
    PERFORM ALV_HANDLE_DATA_CHANGED USING ER_DATA_CHANGED.
  ENDMETHOD.

  METHOD HANDLE_CHANGED_FINISHED.
    PERFORM ALV_HANDLE_CHANGED_FINISHED USING ET_GOOD_CELLS.
  ENDMETHOD.
ENDCLASS.
