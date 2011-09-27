$(function() {
  $('#search').submit(function() {
    $.post("/entities?t=" + (new Date().getTime()) , {text: $("textarea").val()}, function(data) {
      document.getElementById('results').innerHTML = "<h3>Here's the entities</h3><ul></ul>"
      $.each(data.entities, function(i, entity) {
        $("#results ul").append("<li>" + entity.text + " (" + entity.type + ")</li>")
      })
    });
    return false
  });
})