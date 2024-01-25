*&---------------------------------------------------------------------*
*& Include          ZVALIDATION_INTALV
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form getData
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM getdata.

********************************
***Fetching Sale Order Data.
********************************
  SELECT a~vbeln, "vbpa
           a~kunnr, "vbpa
           a~lifnr, "vbpa
           a~pernr, "vbpa
           b~vbeln, "vbak
           b~erdat, "vbak
           b~ernam, "vbak
           b~audat, "vbak
           b~auart, "vbak
           b~vgbel, "vbak
           c~vbeln, "vbap
           c~posnr, "vbap
           c~matnr, "vbap
           c~matkl, "vbap
           c~arktx, "vbap
           c~netwr  "vbap
     INTO TABLE @it_screen1 FROM vbpa AS a INNER JOIN vbak AS b ON a~vbeln = b~vbeln
                                 INNER JOIN vbap AS c ON b~vbeln = c~vbeln WHERE a~vbeln IN @s_vbeln.

***********************************
***Fetching Customer Personal Data.
***********************************
  SELECT d~kunnr, "kna1
         d~land1, "kna1
         d~name1, "kna1
         d~ort01, "kna1
         d~pstlz, "kna1
         d~regio, "kna1
         d~telf1, "kna1
         d~adrnr, "kna1
         b1~spras, "t005t
         b1~landx, "t005t
         b1~natio  "t005t
    INTO TABLE @it_screen2 FROM kna1 AS d INNER JOIN t005t AS b1 ON d~land1 = b1~land1.

***********************************
***Fetching Material Data.
***********************************
  SELECT a1~matnr, "mara
         a1~mtart,
         a1~herkl,
         a1~ersda,
         a1~matkl,
         a1~bstme, "mara
         e~werks, "marc
         e~pstat,
         e~perkz
    INTO TABLE @it_screen3 FROM mara AS a1 INNER JOIN marc AS e ON a1~matnr = e~matnr.

****************************************
****Check for sales order customer data.
****************************************
  IF it_screen1[] IS NOT INITIAL.

    DATA: lt_events TYPE TABLE OF slis_alv_event,
          wa_events TYPE slis_alv_event.

************************
****Events Structure.
************************
*    wa_events-name = 'Sale Order Data'.
*    wa_events-form = 'Top_Sales'.
*
*    APPEND wa_events TO lt_events.
*    CLEAR : wa_events.
*
*    wa_events-name = 'End of Sale Order Data'.
*    wa_events-form = 'footer_Sales'.
*
*    APPEND  wa_events TO lt_events.
*    CLEAR : wa_events.

*    PERFORM top_sales.
*    PERFORM footer_sales.



****************************************
****Field Catalogue Structure.
****************************************
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'VBELN' seltext_m = 'Sale Document' key = 'X') TO it_fcat1.
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'KUNNR' seltext_m = 'Customer Number' key = 'X') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'LIFNR' seltext_m = 'Vendor Id') TO it_fcat1.
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'PERNR' seltext_m = 'Personnel Number') TO it_fcat1.
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'VBELN' seltext_m = 'Sales Document') TO it_fcat1.
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'ERDAT' seltext_m = 'Created On') TO it_fcat1.
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'ERNAM' seltext_m = 'Created By') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'AUDAT' seltext_m = 'Doc date') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'AUART' seltext_m = 'Doc Type') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'VGBEL' seltext_m = 'Ref Doc') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'VBELN' seltext_m = 'Sale Document') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'POSNR' seltext_m = 'Sale Doc Item') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'MATNR' seltext_m = 'Mat Number') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'MATKL' seltext_m = 'Mat Group') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'ARKTX' seltext_m = 'short Text') TO it_fcat1 .
    ADD 1 TO lv_pos1.
    APPEND VALUE #( col_pos = lv_pos1 fieldname = 'NETWR' seltext_m = 'Net Value') TO it_fcat1 .

****Calling ALV Report Basic List (List Index-0).
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program      = sy-repid
        i_callback_user_command = 'UCOMM'
        it_fieldcat             = it_fcat1
*       it_events               = lt_events
        i_callback_top_of_page  = 'TOP_OF_PAGE'
      TABLES
        t_outtab                = it_screen1
      EXCEPTIONS
        program_error           = 1
        OTHERS                  = 2.

*    BREAK-POINT.

  ENDIF.
ENDFORM.

FORM ucomm  USING action LIKE sy-ucomm
                  index TYPE slis_selfield.

  DATA: wa_final2 TYPE st_screen2.

****check for User Command on screen-1.
  IF action EQ '&IC1'.

****Reading the captured record from Screen-1 using Tabindex.
    READ TABLE it_screen1 INTO wa_screen1 INDEX index-tabindex.
    IF sy-subrc = 0.

****Looping on Customer Personal Data (KNA1,t005t).
      LOOP AT it_screen2 INTO wa_screen2 WHERE kunnr1 EQ wa_screen1-kunnr.
        wa_final2-kunnr1 = wa_screen2-kunnr1.
        wa_final2-land1 = wa_screen2-land1.
        wa_final2-name1 = wa_screen2-name1.
        wa_final2-ort01 = wa_screen2-ort01.
        wa_final2-pstlz = wa_screen2-pstlz.
        wa_final2-regio = wa_screen2-regio.
        wa_final2-telf1 = wa_screen2-telf1.
        wa_final2-adrnr = wa_screen2-adrnr.
        wa_final2-spras = wa_screen2-spras.
        wa_final2-landx = wa_screen2-landx.
        wa_final2-natio = wa_screen2-natio.

****Appending records of second screen from work area to respective internal table.
        APPEND wa_final2 TO lt_final2.

****clearing the work area mentioned in the loop.
        CLEAR: wa_screen2, wa_final2.
      ENDLOOP.

****Field Catalogu for Secondary List-1 (List Index-2).
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'KUNNR1' seltext_m = 'Customer Number' key = 'X') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'LAND1' seltext_m = 'Location') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'NAME1' seltext_m = 'Name') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'ORT01' seltext_m = 'City') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'PSTLZ' seltext_m = 'Postal Code') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'REGIO' seltext_m = 'Region') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'TELF1' seltext_m = 'Telephone Number') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'ADRNR' seltext_m = 'Address') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'SPRAS' seltext_m = 'Language') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'LANDX' seltext_m = 'Ref. Document') TO it_fcat2.
      ADD 1 TO lv_pos2.
      APPEND VALUE #( col_pos = lv_pos2 fieldname = 'NATIO' seltext_m = 'Sales Doc') TO it_fcat2.

****Calling ALV Report Secondary List (List Index-2).
      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program      = sy-repid
          i_callback_user_command = 'UCOMM1'
          i_grid_title            = 'Customer Personal Data'
          it_fieldcat             = it_fcat2
          i_callback_top_of_page  = 'TOP_OF_PAGE_CUSTOMER'
        TABLES
          t_outtab                = lt_final2
        EXCEPTIONS
          program_error           = 1
          OTHERS                  = 2.
    ENDIF.

    IF sy-subrc EQ 0.

      DATA: lv_filename TYPE string.
      DATA(hours) = sy-uzeit+0(2).
      DATA(minutes) = sy-uzeit+2(2).
      DATA(seconds) = sy-uzeit+4(2).

****Concatination the date values as per the human readable.
      CONCATENATE 'Desktop\' 'Customer Report(' hours ':' minutes ':' seconds ')' INTO lv_filename.

****Downloading Customer Personal Data.
      CALL METHOD cl_gui_frontend_services=>gui_download
        EXPORTING
          filename                = 'Desktop\Customer Sale Report.xls' "lv_filename
          filetype                = 'DAT' "'ASC'
        CHANGING
          data_tab                = lt_final2
        EXCEPTIONS
          file_write_error        = 1
          no_batch                = 2
          gui_refuse_filetransfer = 3
          invalid_type            = 4
          no_authority            = 5
          unknown_error           = 6
          header_not_allowed      = 7
          separator_not_allowed   = 8
          filesize_not_allowed    = 9
          header_too_long         = 10
          dp_error_create         = 11
          dp_error_send           = 12
          dp_error_write          = 13
          unknown_dp_error        = 14
          access_denied           = 15
          dp_out_of_memory        = 16
          disk_full               = 17
          dp_timeout              = 18
          file_not_found          = 19
          dataprovider_exception  = 20
          control_flush_error     = 21
          not_supported_by_gui    = 22
          error_no_gui            = 23
          OTHERS                  = 24.

****success Message upon file Download.
      IF sy-subrc = 0.
        MESSAGE 'File Downloaded' TYPE 'S'.
      ELSE.
        MESSAGE 'Unable to downlod file' TYPE 'E'.
      ENDIF.

    ENDIF.

****Clearing the work area mentioned in Read statement.
    CLEAR: wa_screen1.
  ENDIF.
ENDFORM.

FORM ucomm1  USING action_1 LIKE sy-ucomm
                         index_1 TYPE slis_selfield.
  DATA: wa_final3 TYPE st_screen3.
****check for User Command on screen-1.
  IF action_1 EQ '&IC1'.

****Reading the captured record from Screen-2 using Tabindex.
    READ TABLE lt_final2 INTO DATA(wa) INDEX index_1-tabindex.
    IF sy-subrc = 0.

****Looping on  Material Data (MARA,MARC).
      LOOP AT it_screen3 INTO DATA(wa_s3) WHERE herkl = wa-land1.
        wa_final3-bstme = wa_s3-bstme.
        wa_final3-ersda = wa_s3-ersda.
        wa_final3-herkl = wa_s3-herkl.
        wa_final3-matkl = wa_s3-matkl.
        wa_final3-matnr = wa_s3-matnr.
        wa_final3-matnr1 = wa_s3-matnr1.
        wa_final3-mtart = wa_s3-mtart.
        wa_final3-perkz = wa_s3-perkz.
        wa_final3-pstat = wa_s3-pstat.
        wa_final3-werks = wa_s3-werks.

****appending Record level data to Internal table.
        APPEND wa_final3 TO lt_final3.

****Clearing Work area's of loop statement.
        CLEAR:wa_s3,wa_final3.
      ENDLOOP.

      IF sy-subrc = 0.
****Filed Catalogue.

        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'BSTME' seltext_m = 'Order Unit') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'ERSDA' seltext_m = 'Created On') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'HERKL' seltext_m = 'City') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'MATKL' seltext_m = 'Mat Group') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'MATNR' seltext_m = 'Material Number') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'MATNR1' seltext_m = 'Material Number') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'MTART' seltext_m = 'Material Type') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'PERKZ' seltext_m = 'Period') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'PSTAT' seltext_m = 'Main. Status') TO it_fcat3.
        ADD 1 TO lv_pos3.
        APPEND VALUE #( col_pos = lv_pos3 fieldname = 'WERKS' seltext_m = 'Plant') TO it_fcat3.

****Calling ALV FM Secondary List (List Index-3).
        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING
            i_callback_program     = sy-repid
            it_fieldcat            = it_fcat3
            i_callback_top_of_page = 'TOP_OF_PAGE_MATERIAL'
          TABLES
            t_outtab               = lt_final3
          EXCEPTIONS
            program_error          = 1
            OTHERS                 = 2.

      ELSE.
        DATA: lv_concat TYPE string.
        lv_concat = |No Mateial data against to Customer Number:| & |{ wa-kunnr1 }|.
        MESSAGE lv_concat TYPE 'E' DISPLAY LIKE 'I'.
      ENDIF.
****Clearing Read staement Work area.
      CLEAR: wa,lv_concat.
    ENDIF.


  ENDIF.

ENDFORM.

FORM top_sales.

  DATA: lt_comwrite TYPE TABLE OF slis_listheader,
        wa_comwrite TYPE slis_listheader.

  wa_comwrite-typ = 'H'.
  wa_comwrite-info = 'Sales Order'.

  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_comwrite
      i_logo             = 'MYLOGO'.

  CLEAR:lt_comwrite.

ENDFORM.

FORM footer_sales.
  DATA: lt_comwrite TYPE TABLE OF slis_listheader,
        wa_comwrite TYPE slis_listheader.

  wa_comwrite-typ = 'A'.
  wa_comwrite-info = 'Sales Order'.

  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_comwrite.

ENDFORM.

**************************************************
******Report Header for Customer sale Order*******
**************************************************

FORM top_of_page.

  DATA: lt_comwrite TYPE TABLE OF slis_listheader,
        wa_comwrite TYPE slis_listheader.

****Top of Page Heading Data.
  wa_comwrite-typ = 'H'.
  wa_comwrite-info = 'Customer-Sale Order Report'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of Page Username Data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Created By: '.
  wa_comwrite-info = sy-uname.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of Page Date Data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Date: '.
  DATA(lv_year) = sy-datum+0(4).
  DATA(lv_month) = sy-datum+4(2).
  DATA(lv_day) = sy-datum+6(2).

****Concatination the date values as per the human readable.
  CONCATENATE lv_day lv_month lv_year INTO wa_comwrite-info SEPARATED BY '/'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Logo Part and Header data for report.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_comwrite
      i_logo             = 'SDLOGO'.

  CLEAR:lt_comwrite.
ENDFORM.

*****************************************************
******Report Header for Customer Personal Data*******
*****************************************************

FORM top_of_page_customer.
  DATA: lt_comwrite TYPE TABLE OF SLIS_T_LISTHEADER,
        wa_comwrite TYPE slis_listheader.

****Top of Page Heading Data.
  wa_comwrite-typ = 'H'.
  wa_comwrite-info = 'Customers Personal Information'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of page Sales Documetn Number data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Sale Doc. Number: '.
  wa_comwrite-info = wa_screen1-vbeln.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of Page Username Data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Created By: '.
  wa_comwrite-info = sy-uname.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of Page Date data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Date: '.
  DATA(lv_year) = sy-datum+0(4).
  DATA(lv_month) = sy-datum+4(2).
  DATA(lv_day) = sy-datum+6(2).

****Concatination the date values as per the human readable.
  CONCATENATE lv_day lv_month lv_year INTO wa_comwrite-info SEPARATED BY '/'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR:wa_comwrite,lv_year,lv_month,lv_day.

****Logo Part and Header data for report.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_comwrite
      i_logo             = 'CRLOGO'.
  CLEAR: lt_comwrite.
ENDFORM.

*****************************************************
******Report Header for customer Material Data*******
*****************************************************

FORM top_of_page_material.
  DATA: lt_comwrite TYPE TABLE OF slis_listheader,
        wa_comwrite TYPE slis_listheader.

****Top of Page Heading Data.
  wa_comwrite-typ = 'H'.
  wa_comwrite-info = 'Customers Personal Information'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of page Username data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Created By: '.
  wa_comwrite-info = sy-uname.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR: wa_comwrite.

****Top of Page Date data.
  wa_comwrite-typ = 'S'.
  wa_comwrite-key = 'Date: '.
  DATA(lv_year) = sy-datum+0(4).
  DATA(lv_month) = sy-datum+4(2).
  DATA(lv_day) = sy-datum+6(2).

****Concatination the date values as per the human readable.
  CONCATENATE lv_day lv_month lv_year INTO wa_comwrite-info SEPARATED BY '/'.
  APPEND wa_comwrite TO lt_comwrite.
  CLEAR:wa_comwrite,lv_year,lv_month,lv_day.

****Logo Part and Header data for report.
  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_comwrite
      i_logo             = 'MMLOGO'.
  CLEAR: lt_comwrite.

ENDFORM.
