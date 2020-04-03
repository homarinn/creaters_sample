import genreSelect from '../../../function/genre_select';
import { preventDefaultWindowOnDropEvent, previewThumbnail } from '../../../function/preview_images';

$(function () {
  preventDefaultWindowOnDropEvent();
  previewThumbnail();
  genreSelect();
});