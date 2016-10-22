$(document).ready(function () {
  pagination();
});

let pagination = function () {
  $('.pagination-link').click( function(e) {
    e.preventDefault();

    let page = e.target.dataset.param_page
    page_input = document.getElementById('param_page')
    page_input.value = page
    page_input.form.submit()

    return false;
  });
};
