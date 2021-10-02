class ZCL_DOOM_HTTP_HANDLER definition
  public
  final
  create public .

public section.

  interfaces IF_HTTP_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_DOOM_HTTP_HANDLER IMPLEMENTATION.


  METHOD if_http_extension~handle_request.
    DATA:
      query     TYPE TABLE OF w3query,
      mime_data TYPE TABLE OF w3mime,
      html_data TYPE TABLE OF w3html,
      params    TYPE w3param,
      keytab    TYPE wwwdatatab,
      response  TYPE xstring
      .


    APPEND INITIAL LINE TO query ASSIGNING FIELD-SYMBOL(<fs>).
    <fs>-name = '_OBJECT_ID'.
    <fs>-value = |z_doom{ server->request->get_header_field( name = '~path_info' ) }|.
    TRANSLATE <fs>-value TO UPPER CASE.


    CALL FUNCTION 'WWW_GET_MIME_OBJECT'
      TABLES
        query_string        = query               " Parameter table
        html                = html_data                 " HTML Page
        mime                = mime_data
      CHANGING
        return_code         = params-ret_code                " Return code for ITS
        content_type        = params-cont_type                 " Type of contents
        content_length      = params-cont_len                " Length of contents (required for binary objects)
      EXCEPTIONS
        object_not_found    = 1
        parameter_not_found = 2
        OTHERS              = 3.

    IF sy-subrc <> 0.
      server->response->set_status( code = 404 reason = 'File not found' ).
      RETURN.
    ENDIF.

    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = params-cont_len
*       first_line   = 0
*       last_line    = 0
      IMPORTING
        buffer       = response
      TABLES
        binary_tab   = mime_data
      EXCEPTIONS
        failed       = 1
        OTHERS       = 2.
    IF sy-subrc <> 0.
      server->response->set_status( code = 404 reason = 'Retrieval failed' ).
      RETURN.
    ENDIF.

    IF <fs>-value CP |*.html| OR <fs>-value CP |*.js| OR <fs>-value CP |*.css|.
      server->response->set_content_type( content_type = |{ params-cont_type };charset=utf-8| ).
    ELSE.
      server->response->set_content_type( content_type = |{ params-cont_type }| ).
    ENDIF.
    server->response->set_data( data = response ).

  ENDMETHOD.
ENDCLASS.
