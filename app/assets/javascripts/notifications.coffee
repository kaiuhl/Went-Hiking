$ ->
  $badge = $("#notifications_badge")
  $badge.addClass("new") if parseInt($badge.text(), 10) > 0

  $("div.notification").hover ->
    $(this).find(".read-notification-link").click() if $(this).attr('data-read-at') == undefined

  $("div.notification").click ->
    location.href = $(this).find("a")[1].href
