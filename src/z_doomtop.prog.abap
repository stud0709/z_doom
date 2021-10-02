*&---------------------------------------------------------------------*
*& Include Z_DOOMTOP                                - Module Pool      Z_DOOM
*&---------------------------------------------------------------------*
PROGRAM z_doom MESSAGE-ID z_doom.
TYPES:
  t_chartbl TYPE TABLE OF char1025 WITH EMPTY KEY
.

DATA: lr_html_viewer   TYPE REF TO cl_gui_html_viewer,
      lr_container     TYPE REF TO cl_gui_custom_container,
      lr_container_txt TYPE REF TO cl_gui_custom_container,
      lr_textedit      TYPE REF TO cl_gui_textedit,
      ok_code          TYPE sy-ucomm
      .
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '001'.
  SET TITLEBAR '001'.

  IF lr_container IS NOT BOUND.
    lr_container = NEW cl_gui_custom_container( container_name = 'HTML' ).
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

  IF lr_container_txt IS NOT BOUND.
    lr_container_txt = NEW cl_gui_custom_container( container_name = 'TXT_FIELD' ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

  IF lr_html_viewer IS NOT BOUND.
    lr_html_viewer = NEW cl_gui_html_viewer( parent = lr_container uiflag = cl_gui_html_viewer=>uiflag_noiemenu ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    DATA(ls_url) = cl_http_server=>get_location( ).

    IF sy-host EQ 'vhcala4hci'. "Docker image AS ABAP 1909
      ls_url = 'http://localhost:50000'.
    ENDIF.

    lr_html_viewer->show_url( url = |{ ls_url }/z_doom/doom.html| ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDIF.

  IF lr_textedit IS NOT BOUND.
    lr_textedit = NEW cl_gui_textedit( parent = lr_container_txt ).

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    lr_textedit->set_readonly_mode( ).
    lr_textedit->set_toolbar_mode( toolbar_mode = 0 ).
    lr_textedit->set_statusbar_mode( statusbar_mode = 0 ).
    lr_textedit->set_font_fixed( mode = 1 ).
    DATA(lt_credit) = VALUE t_chartbl( ( 'Yes, you can run DOOM in SAP GUI 7.70+' )
     ( '' )
     ( '*************** CREDITS **************' )
     ( '   _               _ ' )
     ( '  (_)___        __| | ___  ___ ' )
     ( '  | / __|_____ / _` |/ _ \/ __|' )
     ( '  | \__ \_____| (_| | (_) \__ \' )
     ( ' _/ |___/      \__,_|\___/|___/' )
     ( '|__/' )
     ( ' ' )
     ( '(https://github.com/caiiiycuk/js-dos)' )
     ( ' ' )
     ( 'SAP integration by' )
     ( ' ' )
     ( '                     __ _____ __   __ ' )
     ( '                 |  /  \    //  \ /  |' )
     ( ' , _|_         __| |    |  /|    |\_/|' )
     ( '/ \_|  |   |  /  | |    | / |    |   |' )
     ( ' \/ |_/ \_/|_/\_/|_/\__/ /   \__/    |' )
     ( ' ' )
     ( '(https://github.com/stud0709)' )
     ( ' ' )
     ( '************** Have fun! *************' )
    ).

    lr_textedit->set_text_as_r3table( lt_credit ).
  ENDIF.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CLEAR ok_code.
  ok_code = sy-ucomm.

  CASE ok_code.
    WHEN 'BYE'.
      MESSAGE s000.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
