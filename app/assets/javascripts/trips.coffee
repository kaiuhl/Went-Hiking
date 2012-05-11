$ ->
  $(".precision_mileage_toggle").click ->
    $("#rough_mileage").slideUp ->
      $("#exact_mileage").slideDown()
