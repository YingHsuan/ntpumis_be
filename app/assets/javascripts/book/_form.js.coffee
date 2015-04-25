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
        $('#book_thesis_id').val(null)
      when 'magazine'
        $('.thesis').addClass 'hide'
                    .attr 'required',false
        $('.book').addClass 'hide'
                  .attr 'required',false
        $('.magazine').removeClass 'hide'
                      .attr 'required',true
        $('input.thesis').attr 'disabled',true
        $('#book_thesis_id').val(null)
      when 'thesis'
        $('.magazine').addClass 'hide'
                      .attr 'required',false
        $('.book').addClass 'hide'
                  .attr 'required',false
        $('.thesis').removeClass 'hide'
                    .attr 'required',true
                    .val('')
        $('input.thesis').attr 'disabled',false
  if $('#book_book_type').val() isnt ''
    title = $('#book_title').val()
    $('#book_book_type').trigger 'change'
    if $('#book_book_type').val() is 'thesis'
      $('input.thesis').val(title)
  else
    $('.magazine').addClass 'hide'
                  .attr 'required',false
    $('.thesis').addClass 'hide'
                .attr 'required',false
    $('.book').removeClass 'hide'
              .attr 'required',true
    $('input.thesis').attr 'disabled',true

  $('table').dataTable()
  $('select').addClass('form-control')
  $('#loading').hide()
