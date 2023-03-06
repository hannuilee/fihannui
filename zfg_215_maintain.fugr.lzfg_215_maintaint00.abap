*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZTTEST_215_HR...................................*
DATA:  BEGIN OF STATUS_ZTTEST_215_HR                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZTTEST_215_HR                 .
CONTROLS: TCTRL_ZTTEST_215_HR
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZVTEST_215_02...................................*
TABLES: ZVTEST_215_02, *ZVTEST_215_02. "view work areas
CONTROLS: TCTRL_ZVTEST_215_02
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZVTEST_215_02. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZVTEST_215_02.
* Table for entries selected to show on screen
DATA: BEGIN OF ZVTEST_215_02_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZVTEST_215_02.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVTEST_215_02_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZVTEST_215_02_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZVTEST_215_02.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZVTEST_215_02_TOTAL.

*.........table declarations:.................................*
TABLES: *ZTTEST_215_HR                 .
TABLES: ZTTEST_215_CERTI               .
TABLES: ZTTEST_215_COM                 .
TABLES: ZTTEST_215_HR                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
