$(document).ready(function () {
  toggle_form();
  pagination();
});

let toggle_form = function () {
  $("#toggle-form-btn").click(function () {
    $('#Main').toggleClass('hide');
  });
};

let pagination = function () {
  $('.pagination-link').click( function(e) {
    e.preventDefault();
    let form_id = e.target.dataset.form
    let page = e.target.dataset.param_page
    $('#param_page').val(page)
    $('#'+form_id).submit()
    return false;
  });
};
