import { preventDefaultWindowOnDropEvent, previewIllustration, submitFiles } from '../../function/preview_images';

$(function () {
  preventDefaultWindowOnDropEvent();
  previewIllustration();
  submitFiles();
});