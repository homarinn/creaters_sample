export default function genreSelect() {
  let genreToggleButton = () => {
    let icon = $(".m-genre-toggle-button-box__toggle-button--icon");
    $(".m-genre-toggle-button-box__toggle-button").click(function () {
      icon.toggleClass("fa-caret-up");
      icon.toggleClass("fa-caret-down");
      $(".m-genre-radio-button-group").slideToggle(200);
    });
  };

  let showCheckedGenre = () => {
    $(".m-genre-radio-button-box__genre-radio").change(function () {
      let genre = $(this).next().text();
      $(".m-genre-toggle-button-box__toggle-button--text").text(genre);
    });
  };

  genreToggleButton();
  showCheckedGenre();
}