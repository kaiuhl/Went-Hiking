$ ->
  $badge = $("#notifications_badge")
  $badge.addClass("new") if parseInt($badge.text(), 10) > 0

  $("div.notification")
