*&---------------------------------------------------------------------*
*& Report ZRTEST_215_BACKJOB_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZRTEST_215_BACKJOB_02.

DATA : GV_JOBNAME LIKE TBTCJOB-JOBNAME.
DATA : GV_JOBCOUNT LIKE TBTCJOB-JOBCOUNT.

PARAMETERS : P_CHAR TYPE CHAR10.

CONCATENATE 'ZRTEST_215_BACKJOB' SY-DATUM '/' SY-UZEIT INTO GV_JOBNAME.

CALL FUNCTION 'JOB_OPEN'
  EXPORTING
*   DELANFREP              = ' '
*   JOBGROUP               = ' '
    JOBNAME                = GV_JOBNAME
*   SDLSTRTDT              = NO_DATE
*   SDLSTRTTM              = NO_TIME
*   JOBCLASS               =
*   CHECK_JOBCLASS         =
 IMPORTING
   JOBCOUNT               = GV_JOBCOUNT
*   INFO                   =
* CHANGING
*   RET                    =
* EXCEPTIONS
*   CANT_CREATE_JOB        = 1
*   INVALID_JOB_DATA       = 2
*   JOBNAME_MISSING        = 3
*   OTHERS                 = 4
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

SUBMIT ZRTEST_215_BACKJOB VIA JOB GV_JOBNAME
                          NUMBER GV_JOBCOUNT
                          WITH P_CHAR = 'BACKGROUND'
TO SAP-SPOOL WITHOUT SPOOL DYNPRO AND RETURN.

CALL FUNCTION 'JOB_CLOSE'
  EXPORTING
*   AT_OPMODE                         = ' '
*   AT_OPMODE_PERIODIC                = ' '
*   CALENDAR_ID                       = ' '
*   EVENT_ID                          = ' '
*   EVENT_PARAM                       = ' '
*   EVENT_PERIODIC                    = ' '
    JOBCOUNT                          = GV_JOBCOUNT
    JOBNAME                           = GV_JOBNAME
*   LASTSTRTDT                        = NO_DATE
*   LASTSTRTTM                        = NO_TIME
*   PRDDAYS                           = 0
*   PRDHOURS                          = 0
*   PRDMINS                           = 0
*   PRDMONTHS                         = 0
*   PRDWEEKS                          = 0
*   PREDJOB_CHECKSTAT                 = ' '
*   PRED_JOBCOUNT                     = ' '
*   PRED_JOBNAME                      = ' '
*   SDLSTRTDT                         = NO_DATE
*   SDLSTRTTM                         = NO_TIME
*   STARTDATE_RESTRICTION             = BTC_PROCESS_ALWAYS
   STRTIMMED                         = 'X'
*   TARGETSYSTEM                      = ' '
*   START_ON_WORKDAY_NOT_BEFORE       = SY-DATUM
*   START_ON_WORKDAY_NR               = 0
*   WORKDAY_COUNT_DIRECTION           = 0
*   RECIPIENT_OBJ                     =
*   TARGETSERVER                      = ' '
*   DONT_RELEASE                      = ' '
*   TARGETGROUP                       = ' '
*   DIRECT_START                      =
*   INHERIT_RECIPIENT                 =
*   INHERIT_TARGET                    =
*   REGISTER_CHILD                    = ABAP_FALSE
*   TIME_ZONE                         =
*   EMAIL_NOTIFICATION                =
* IMPORTING
*   JOB_WAS_RELEASED                  =
* CHANGING
*   RET                               =
* EXCEPTIONS
*   CANT_START_IMMEDIATE              = 1
*   INVALID_STARTDATE                 = 2
*   JOBNAME_MISSING                   = 3
*   JOB_CLOSE_FAILED                  = 4
*   JOB_NOSTEPS                       = 5
*   JOB_NOTEX                         = 6
*   LOCK_FAILED                       = 7
*   INVALID_TARGET                    = 8
*   INVALID_TIME_ZONE                 = 9
*   OTHERS                            = 10
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

WRITE : / GV_JOBNAME, 'BACKJOB 생성 완료하였습니다.'.
