*&---------------------------------------------------------------------*
*& Include          ZDD_INTALV
*&---------------------------------------------------------------------*

TABLES: vbpa,vbak,vbap,kna1,t005t,mara,marc.

TYPES: BEGIN OF st_screen1,
         vbeln  TYPE vbpa-vbeln,
         kunnr  TYPE vbpa-kunnr,
         lifnr  TYPE vbpa-lifnr,
         pernr  TYPE vbpa-pernr,
         vbeln2 TYPE vbak-vbeln,
         erdat  TYPE vbak-erdat,
         ernam  TYPE vbak-ernam,
         audat  TYPE vbak-audat,
         auart  TYPE vbak-auart,
         vgbel  TYPE vbak-vgbel,
         vbeln3 TYPE vbap-vbeln,
         posnr  TYPE vbap-posnr,
         matnr  TYPE vbap-matnr,
         matkl  TYPE vbap-matkl,
         arktx  TYPE vbap-arktx,
         netwr  TYPE vbap-netwr,
       END OF st_screen1.

TYPES: BEGIN OF st_screen2,
         kunnr1 TYPE kna1-kunnr,
         land1  TYPE kna1-land1,
         name1  TYPE kna1-name1,
         ort01  TYPE kna1-ort01,
         pstlz  TYPE kna1-pstlz,
         regio  TYPE kna1-regio,
         telf1  TYPE kna1-telf1,
         adrnr  TYPE kna1-adrnr,
         spras  TYPE t005t-spras,
         landx  TYPE t005t-landx,
         natio  TYPE t005t-natio,
       END OF st_screen2.

TYPES: BEGIN OF st_screen3,
         matnr  TYPE mara-matnr,
         mtart  TYPE mara-mtart,
         herkl  TYPE land1,
         ersda  TYPE mara-ersda,
         matkl  TYPE mara-matkl,
         bstme  TYPE mara-bstme,
         matnr1 TYPE marc-matnr,
         werks  TYPE marc-werks,
         pstat  TYPE marc-pstat,
         perkz  TYPE marc-perkz,
       END OF st_screen3.


*  DATA: p1 TYPE i.

DATA: it_screen1 TYPE STANDARD TABLE OF st_screen1,
      wa_screen1 TYPE st_screen1,
      it_screen2 TYPE STANDARD TABLE OF st_screen2,
      wa_screen2 TYPE st_screen2,
      it_screen3 TYPE STANDARD TABLE OF st_screen3,
      wa_screen3 TYPE st_screen3,
      it_fcat1   TYPE slis_t_fieldcat_alv,
      wa_fcat1   TYPE slis_fieldcat_alv,
      it_fcat2   TYPE TABLE OF slis_fieldcat_alv,
      wa_fcat2   TYPE slis_fieldcat_alv,
      it_fcat3   TYPE TABLE OF slis_fieldcat_alv,
      wa_fcat3   TYPE slis_fieldcat_alv,
      lv_pos1    TYPE i VALUE 0,
      lv_pos2    TYPE i VALUE 0,
      lv_pos3    TYPE i VALUE 0,
      lt_final2  TYPE TABLE OF st_screen2,
      lt_final3  TYPE TABLE OF st_screen3.
