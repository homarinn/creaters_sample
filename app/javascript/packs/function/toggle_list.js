export default function toggleList() {
  $('.m-toggle-series-list-button:not(.is-current)').click(function(){
    $('.m-toggle-single-list').addClass('m-hidden');
    $('.m-toggle-series-list').removeClass('m-hidden');
  });

  $('.m-toggle-single-list-button:not(.is-current)').click(function(){
    $('.m-toggle-series-list').addClass('m-hidden');
    $('.m-toggle-single-list').removeClass('m-hidden');
  });
}