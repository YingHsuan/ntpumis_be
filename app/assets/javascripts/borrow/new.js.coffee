$(document).on 'ready', ->
  $('#borrower_name').on 'focus', ->
    $(@).blur()
  $('#book_name').on 'focus', ->
    $(@).blur()
  $('#borrowerBtn').on 'click', ->
    console.log 'borrowerModal show'
    $('#borrowerModal').modal 'show'
  $('.borrowerConfirmBtn').on 'click', ->
    console.log $(@).val()
    borrowerArr = $(@).val().split(" ")
    $('#borrower_id').val(borrowerArr[0])
    $('#borrower_name').val(borrowerArr[1])
    $('#borrower_type').val(borrowerArr[2])
    $('#borrowerModal').modal('hide')

  $('#bookBtn').on 'click', ->
    $('#bookModal').modal 'show'
  $('.bookConfirmBtn').on 'click', ->
    bookArr = $(@).val().split("///")
    $('#book_serial_no').val(bookArr[0])
    $('#book_name').val(bookArr[1])
    $('#bookModal').modal('hide')

  $('table').dataTable()
  $('select').addClass('form-control')
