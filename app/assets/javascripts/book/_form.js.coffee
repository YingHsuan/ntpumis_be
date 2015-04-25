$(document).on 'ready', ->
  $('#thesis_name').on 'focus', ->
    $(@).blur()
  $('#thesisBtn').on 'click', ->
    $('#thesisModal').modal()

  $('.thesisConfirmBtn').on 'click', ->
    thesisArr = $(@).val().split("///")
    $('#book_thesis_id').val(thesisArr[0])
    $('#thesis_name').val(thesisArr[1])
    $('#thesisModal').modal('hide')

  $('.magazine').addClass 'hide'
                .attr 'required',false
  $('.thesis').addClass 'hide'
              .attr 'required',false
  $('.book').removeClass 'hide'
            .attr 'required',true
  $('input.thesis').attr 'disabled',true

  $('#book_book_type').change ->
    book_type = $(@).val()
    switch book_type
      when ''
        break
      when 'book'
        $('.magazine').addClass 'hide'
                      .attr 'required',false
        $('.thesis').addClass 'hide'
                    .attr 'required',false
        $('.book').removeClass 'hide'
                  .attr 'required',true
        $('input.thesis').attr 'disabled',true
      when 'magazine'
        $('.thesis').addClass 'hide'
                    .attr 'required',false
        $('.book').addClass 'hide'
                  .attr 'required',false
        $('.magazine').removeClass 'hide'
                      .attr 'required',true
        $('input.thesis').attr 'disabled',true
      when 'thesis'
        $('.magazine').addClass 'hide'
                      .attr 'required',false
        $('.book').addClass 'hide'
                  .attr 'required',false
        $('.thesis').removeClass 'hide'
                    .attr 'required',true
        $('input.thesis').attr 'disabled',false
  $('table').dataTable()
  $('select').addClass('form-control')
  $('#loading').hide()
