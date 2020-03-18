$(document).on("turbolinks:load", function() {
  $(function() {
    if ($("body").hasClass("new")){
      // ファイルドロップにページが切り替わってしまうので無効化
      let preventDefaultWindowOnDropEvent = () => {
        window.ondrop = function(e) {e.preventDefault();};
        window.ondragover = function(e) {e.preventDefault();};
      };

      let previewThumbnail = () => {
        const thumbnailField = $(".file-field-group__thumbnail-field");
        document.querySelector(".file-field-group__thumbnail-label").ondrop = function(e) {
          thumbnailField.files = e.dataTransfer.files;
          previewImage(thumbnailField.files[0]);
        };

        thumbnailField.change(function (){
          previewImage($(this).prop("files")[0]);
        });
      };

      let previewImage = (file) => {
        var file = file;
        var reader = new FileReader();
        var image = new Image();
        reader.readAsDataURL(file);
        reader.onload = function() {
          image.src = reader.result;
          image.onload = function() {
            if (image.naturalWidth > image.naturalHeight) {
              var width = 160;
              var height = (image.naturalHeight * 160) / image.naturalWidth;
            } else {
              var height = 200;
              var width = (image.naturalWidth * 200) / image.naturalheight;
            }
            var preview = $("<img>").attr({
              src: reader.result,
              width: width,
              height: height,
              class: ".thumbnail-preview-box__preview"
            });
            $(".thumbnail-preview-box").empty().append(preview);
          };
        };
      };

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

      preventDefaultWindowOnDropEvent();
      previewThumbnail();
      genreToggleButton();
      showCheckedGenre();
    }
  });
});