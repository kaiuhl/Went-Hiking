$ ->
  $(".precision_mileage_toggle").click ->
    $("#rough_mileage").attr("disabled", true).slideUp ->
      $("#exact_mileage").slideDown()
