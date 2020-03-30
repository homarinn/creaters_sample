// ファイルドロップにページが切り替わってしまうので無効化
export function preventDefaultWindowOnDropEvent() {
  window.ondrop = function (e) { e.preventDefault(); };
  window.ondragover = function (e) { e.preventDefault(); };
}

export function previewThumbnail() {
  const thumbnailField = $(".m-thumbnail-group__thumbnail-field");
  document.querySelector(".m-thumbnail-group__thumbnail-label").ondrop = function (e) {
    thumbnailField.files = e.dataTransfer.files;
    previewImage(thumbnailField.files[0]);
  };

  thumbnailField.change(function () {
    previewImage($(this).prop("files")[0]);
  });

  let previewImage = (file) => {
    var file = file;
    var reader = new FileReader();
    var image = new Image();
    reader.readAsDataURL(file);
    reader.onload = function () {
      image.src = reader.result;
      image.onload = function () {
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
          class: ".m-thumbnail-preview-box__preview"
        });
        $(".m-thumbnail-preview-box").empty().append(preview);
      };
    };
  };
}