export default function workDetailToggleButton() {
  if ($(".work-detail-toggle-button-box__toggle-button").length) {
    const icon = $(".work-detail-toggle-button-box__toggle-button--icon");
    $(".work-detail-toggle-button-box__toggle-button").click(function () {
      icon.toggleClass("fa-caret-up");
      icon.toggleClass("fa-caret-down");
      $(".work-detail-group").slideToggle(200);
    });
  }
}