$(document).on("turbolinks:load", function() {
  $(function() {
    if ($("body").hasClasses("series show")){
      let seriesDetailToggleButton = () => {
        let icon = $(".series-detail-toggle-button-box__toggle-button--icon");
        $(".series-detail-toggle-button-box__toggle-button").click(function() {
          icon.toggleClass("fa-caret-up");
          icon.toggleClass("fa-caret-down");
          $(".series-detail-group").slideToggle(200);
        });
      };
      seriesDetailToggleButton();
    }
  });
});