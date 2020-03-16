import { DirectUpload } from "@rails/activestorage";

$(document).on("turbolinks:load", function() {
  $("body.new").ready(function() {
    // ファイルドロップにページが切り替わってしまうので無効化
    window.ondrop = function(e) {e.preventDefault();};
    window.ondragover = function(e) {e.preventDefault();};

    const input = document.querySelector(".file-field-group__thumbnail-field");

    document.querySelector(".file-field-group__thumbnail-label").ondrop = function(e){
      e.preventDefault();
      const files = e.dataTransfer.files;
      Array.from(files).forEach(file => uploadFile(file));
    };

    // 通常のファイル選択へのバインド
    input.addEventListener("change", e => {
      Array.from(input.files).forEach(file => uploadFile(file));
      // 選択されたファイルを入力からクリアしておく
      input.value = null;
    });

    const uploadFile = file => {
      // フォームではfile_field direct_upload: trueが必要
      // （これでdata-direct-upload-urlを提供する）
      const url = input.dataset.directUploadUrl;
      const upload = new DirectUpload(file, url);

      upload.create((error, blob) => {
        if (error) {
          // エラーハンドリングをここに書く
          console.log("error");
        } else {
          // 名前が似ているhidden inputをblob.signed_idの値とともにフォームに追加する
          // これによりblob idが通常のアップロードフローで転送される
          const hiddenField = $("<input>").attr({
            type: "hidden",
            value: blob.signed_id,
            name: input.name
          });
          $("#has-dropzone").append(hiddenField);
          console.log("success");
        }
      });
    };
  });
});