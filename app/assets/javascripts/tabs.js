$(document).ready(function() {
  $('a[data-bs-toggle="tab"]').on("shown.bs.tab", function (e) {
    var activeTab = $(e.target).attr("aria-controls");
    localStorage.setItem("activeTab", activeTab);
  });

  var activeTab = localStorage.getItem("activeTab");
  if (activeTab) {
    $('#myTab a[href="#' + activeTab + '"]').tab("show");
  }
});
