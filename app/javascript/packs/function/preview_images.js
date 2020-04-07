// ファイルドロップにページが切り替わってしまうので無効化
export function preventDefaultWindowOnDropEvent() {
  window.ondrop = function (e) { e.preventDefault(); };
  window.ondragover = function (e) { e.preventDefault(); };
}

export function previewThumbnail() {
  const thumbnailField = $(".m-thumbnail-group__thumbnail-field");
  document.querySelector(".m-thumbnail-group__thumbnail-label").ondrop = function (e) {
    thumbnailField.prop("files", e.dataTransfer.files);
    previewImage(e.dataTransfer.files[0]);
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
        var preview = $("<img>", {
          src: reader.result,
          width: width,
          height: height,
          class: "m-thumbnail-preview-box__preview"
        });
        $(".m-thumbnail-preview-box").empty().append(preview);
      };
    };
  };
}

export function previewIllustration() {
  const illustrationField = $(".m-illustration-group__illustration-field");
  document.querySelector(".m-illustration-group__illustration-label").ondrop = function (e) {
    illustrationField.prop("files", e.dataTransfer.files);
    previewImage(e.dataTransfer.files[0]);
  };

  illustrationField.change(function () {
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
          var width = 360;
          var height = (image.naturalHeight * 360) / image.naturalWidth;
        } else {
          var height = 450;
          var width = (image.naturalWidth * 450) / image.naturalheight;
        }
        var preview = $("<img>", {
          src: reader.result,
          width: width,
          height: height,
          class: "m-illustration-preview-box__preview"
        });
        $(".m-illustration-preview-box").empty().append(preview);
      };
    };
  };
}








export function previewComics() {
  const comicField = document.querySelector('.m-comic-group__comic-field');
  const previewBox = $(".m-comic-preview-box");
  var dataBox = new DataTransfer();

  previewBox.on("click", ".m-comic-preview-image-bottom-box__delete", function(e){
    const targetIndex = Number($(this).parent().data('id'));
    const previewImageGroups = $('m-comic-preview-image-group');
    dataBox.items.remove(targetIndex);
    previewImageGroups.each(function(i, e){
      const dataId = Number(e.data('id'));
      if (dataId > targetIndex) {
        e.attr('data-id', dataId-1)
      }
    });
    const files = dataBox.files;
    comicField.files = files;
    if (files.length == 0) {$('.m-image-add-button').remove();}
    $(this).parent().remove();
    // const targetImageName = $(this).prev().data('name');
    // const files = dataBox.files;
    // for (var i = 0; i < files.length; i++) {
    //   if (files[i].name == targetImageName) {
    //     dataBox.items.remove(i);
    //     break;
    //   }
    // }
    // comicField.files = dataBox.files;
    // if (dataBox.files.length == 0) {$('.m-image-add-button').remove();}
    // $(this).parent().remove();
  });

  document.querySelector(".m-dropzone").ondrop = function (e) {
    const file = e.dataTransfer.files[0];
    addFileComicFieldFiles(file);
    filePreview(file);
  };

  $('.m-comic-group__comic-field').change(function () {
    $.each($(this).prop("files"), function (i, file) {
      filePreview(file)
      addFileComicFieldFiles(file);
    })
  });


  let previewImage = (file) => {
    const dataID = dataBox.files.length+1;
    const reader = new FileReader();
    const image = new Image();
    reader.readAsDataURL(file);
    reader.onload = function () {
      image.src = reader.result;
      image.onload = function () {
        if (image.naturalWidth >= image.naturalHeight) {
          var width = 160;
          var height = Math.round(image.naturalHeight / image.naturalWidth * 160 );
        } else {
          var height = 200;
          var width = Math.round(image.naturalWidth / image.naturalheight * 200);
        }

        let previewImageGroup = $("<div></div>", { class: "m-comic-preview-image-group" }).attr('data-id', dataID);

        let preview = $("<img>", {
          src: reader.result,
          width: width,
          height: height,
          class: "m-comic-preview-image-group__preview"
        }).attr('data-name', file.name);

        let imageDelete = $("<div></div>", {class: "m-comic-preview-image-bottom-box__delete",});
        $("<i></i>", {class: "material-icons", text: "clear",}).appendTo(imageDelete);

        previewImageGroup.append(preview).append(imageDelete);
        previewBox.append(previewImageGroup);
      };
    };
  };

  function addFileComicFieldFiles(file) {
    dataBox.items.add(file);
    comicField.files = dataBox.files;
  };

  function filePreview(file) {
    previewImage(file);
    appendFileAddButton();
  }

  function appendFileAddButton() {
    if ($('.m-image-add-button').length==0) {
      let fileAddButton = $('<div></div>', {
        class: "m-image-add-button"
      }).attr("onclick", "$('.m-comic-group__comic-field').click();");
      $("<i></i>", { class: "material-icons", text: "add", }).appendTo(fileAddButton);

      previewBox.append(fileAddButton);
    }
  }
}