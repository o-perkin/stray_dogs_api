// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import 'bootstrap';
import 'cocoon-js'

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()

  $(function () {
  'use strict'

    $('[data-toggle="offcanvas"]').on('click', function () {
      $('.offcanvas-collapse').toggleClass('open')
    })
  })

  $(function() {
    // limits the number of categories
    $('#categories').on('cocoon:after-insert', function() {
      console.log('after-insert: ' + $('#categories .nested-fields:visible').length);
      check_to_hide_or_show_add_link();
    });

    $('#categories').on('cocoon:after-remove', function() {
      console.log('after-remove: ' + $('#categories .nested-fields:visible').length);
      check_to_hide_or_show_add_link();
    });

    $('#submited-fields .nested-fields:first-child a.remove_fields').hide()

    check_to_hide_or_show_add_link();

    function check_to_hide_or_show_add_link() {
      if ($('#categories .nested-fields:visible').length == 3) {
        $('#add-category a').hide();
      } else {
        $('#add-category a').show();
      }
    }
  })

  $(function() {

    $('#subscription-table-body th:first-child').each(function (index) {
      $(this).html('Dog ' + (index + 1));
    })
  })
})

