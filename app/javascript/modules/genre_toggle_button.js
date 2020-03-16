$(document).on("turbolinks:load", function() {
  $("body.series.new").ready(function() {
    let genreToggleButton = () => {
      let icon = $(".genre-toggle-button-box__toggle-button--icon");
      $(".genre-toggle-button-box__toggle-button").click(function() {
        icon.toggleClass("fa-caret-up");
        icon.toggleClass("fa-caret-down");
        $(".radio-button-group").slideToggle(200);
      });
    };
    let showCheckedGenre = () => {
      $(".radio-button-box__genre-radio").change(function(){
        let genre = $(this).next().text();
        $(".genre-toggle-button-box__toggle-button--text").text(genre);
      });
    };

    genreToggleButton();
    showCheckedGenre();
  });
});