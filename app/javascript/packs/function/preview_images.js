// ファイルドロップにページが切り替わってしまうので無効化
export function preventDefaultWindowOnDropEvent() {
  window.ondrop = function (e) { e.preventDefault(); };
  window.ondragover = function (e) { e.preventDefault(); };
}

export function previewThumbnail() {
  const thumbnailField = $(".m-thumbnail-group__thumbnail-field");
  document.querySelector(".m-thumbnail-group__thumbnail-label").ondrop = function (e) {
    thumbnailField.prop("files", e.dataTransfer.files);
    previewImage(e.dataTransfer.files[0], 160, 200);
  };

  thumbnailField.change(function () {
    previewImage($(this).prop("files")[0], 160, 200);
  });
}

export function previewIcon() {
  const userIconField = $(".m-user-icon-group__user-icon-field");
  const previewBox = $(".m-user-icon-preview-box");

  previewBox.on('click', ".preview", function(){
    userIconField.click();
  });

  $('.m-user-icon-upload-button').click(function () {
    userIconField.click();
  });

  userIconField.change(function () {
    previewImage($(this).prop("files")[0], 100, 100);
  });
}

export function previewIllustration() {
  const illustrationField = $(".m-illustration-group__illustration-field");
  document.querySelector(".m-illustration-group__illustration-label").ondrop = function (e) {
    previewImage(e.dataTransfer.files[0], 360, 450);
  };

  illustrationField.change(function () {
    previewImage($(this).prop("files")[0], 360, 450);
  });
}

const previewImage = (file, maxWidth, maxHeight, empty = true) => {
  if (!file) {
    return false;
  }
  if (empty) {
    $(".m-preview-box").empty();
  }
  const blob_url = window.URL.createObjectURL(file);
  const xhr = new XMLHttpRequest();
  xhr.responseType = 'blob';
  xhr.open('GET', blob_url, true);
  xhr.onload = function (e) {
    if (this.status == 200) {
      const reader = new FileReader();
      reader.readAsDataURL(this.response);
      reader.onload = function () {
        const image = new Image();
        image.src = reader.result;
        image.onload = function () {
          makePreview(image, file.name, maxWidth, maxHeight)
        };
      };
    }
  };
  xhr.send();
};

const makePreview = (image, name, maxWidth, maxHeight) => {
  const naturalWidth = image.naturalWidth
  const naturalHeight = image.naturalHeight;
  if (naturalWidth >= naturalHeight) {
    image.width = maxWidth;
    image.height = (naturalHeight * maxWidth) / naturalWidth;
  } else {
    image.width = (naturalWidth * maxHeight) / naturalHeight;
    image.height = maxHeight;
  }
  image.className = 'preview';
  image.dataset.name = name;
  $(".m-preview-box").append(image);
};

export const submitFiles = () => {
  const dataBox = new DataTransfer();
  const fileField = document.querySelector('input[type="file"]');

  $('input[type="submit"]').click(function (e) {
    e.preventDefault();
    let myPromise = Promise.resolve();
    const previews = $('.preview');
    previews.each(function (i, preview) {
      myPromise = myPromise.then(() => { return addFile(preview) });
      if (i == previews.length - 1) {
        myPromise.then(() => e.target.form.submit());
      }
    });
  });

  const addFile = (preview) => {
    return new Promise((resolve, reject) => {
      const blob_url = preview.src;
      const xhr = new XMLHttpRequest();
      xhr.responseType = 'blob';
      xhr.open('GET', blob_url, true);
      xhr.onload = function (e) {
        if (this.status == 200) {
          const file = new File([this.response], preview.dataset.name);
          dataBox.items.add(file);
          fileField.files = dataBox.files;
          resolve();
        }
      };
      xhr.send();
    });
  };
}




export function previewComics() {
  const comicField = document.querySelector('.m-comic-group__comic-field');
  const $ComicField = $('.m-comic-group__comic-field');
  const previewBox = $(".m-comic-preview-box");
  const addButtonBox = $('.m-comic-add-button-box');
  const addFirstButton = $('.m-comic-add-button-box__first-button');
  const previewPlaceholder = $('.m-comic-preview-box__placeholder');
  var dataBox = new DataTransfer();

  previewBox.on("click", ".m-comic-preview-image-group__delete", function(){
    const targetElement = $(this).parent();
    const targetIndex = Number(targetElement.data('id'));

    targetElement.remove();
    dataBox.items.remove(targetIndex);
    comicField.files = dataBox.files;

    if (dataBox.files.length == 0) {
      $('.m-comic-add-button-box__button').remove();
      addFirstButton.show();
      previewPlaceholder.show();
      return false;
    }

    const previewImageGroups = $('.m-comic-preview-image-group');

    previewImageGroups.each(function(i, element){
      const dataId = Number(element.dataset.id);
      if (dataId > targetIndex) {element.dataset.id = dataId-1}
    })
  });

  addButtonBox.on("click", ".m-comic-add-button-box__button", function(){
    $('.m-comic-group__comic-field').click();
  });

  addButtonBox.on("click", ".m-comic-add-button-box__first-button", function(){
    $('.m-comic-group__comic-field').click();
  });

  document.querySelector(".m-dropzone").ondrop = function (e) {
    previewPlaceholder.hide();
    previewImage(e.dataTransfer.files[0]);
    appendFileAddButton();
  };

  $ComicField.change(function () {
    var myPromise = Promise.resolve();
    previewPlaceholder.hide();
    $.each($(this).prop("files"), function (i, file) {
      myPromise = myPromise.then(awaitPreviewAndFileComicFieldFiles.bind(null, file))
    });
    appendFileAddButton();
  });

  function awaitPreviewAndFileComicFieldFiles(file) {
    return new Promise(function (resolve, reject) {
      setTimeout(function () {
        previewImage(file);
        resolve();
      }, 10);
    });
  }


  const previewImage = (file) => {
    const reader = new FileReader();
    const image = new Image();
    reader.readAsDataURL(file);
    reader.onload = function () {
      image.src = reader.result;
      image.onload = function () {
        addFileComicFieldFiles(file);
        makePreview(image);
      };
    };
  };

  const addFileComicFieldFiles = (file) => {
    dataBox.items.add(file);
    comicField.files = dataBox.files;
  };

  const appendFileAddButton = () => {
    if ($('.m-comic-add-button-box__button').length==0) {
      let fileAddButton = $('<div></div>', {class: "m-comic-add-button-box__button"});
      $("<i></i>", { class: "material-icons", text: "add", }).appendTo(fileAddButton);

      addFirstButton.hide();
      addButtonBox.append(fileAddButton);
    }
  }

  const makePreview = (image) => {
    const dataID = dataBox.files.length-1;

    if (image.naturalWidth >= image.naturalHeight) {
      var width = 160;
      var height = Math.round(image.naturalHeight / image.naturalWidth * 160);
    } else {
      var height = 200;
      var width = Math.round(image.naturalWidth / image.naturalheight * 200);
    }

    let previewImageGroup = $("<div></div>", { class: "m-comic-preview-image-group" }).attr('data-id', dataID);

    let preview = $("<img>", {
      src: image.src,
      width: width,
      height: height,
      class: "m-comic-preview-image-group__preview"
    });

    let imageDelete = $("<div></div>", { class: "m-comic-preview-image-group__delete", });
    $("<i></i>", { class: "material-icons", text: "clear", }).appendTo(imageDelete);

    previewImageGroup.append(preview).append(imageDelete);
    previewBox.append(previewImageGroup);
  }
}