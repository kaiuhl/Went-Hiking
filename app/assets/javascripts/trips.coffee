$ ->

  # Hides the rough mileage field to precise mileage
  $(".precision_mileage_toggle").click ->
    $("#rough_mileage").slideUp ->
      $("#rough_mileage input").attr("disabled", "disabled")
      $("#exact_mileage").slideDown()
      $("#exact_mileage input").removeAttr("disabled")
