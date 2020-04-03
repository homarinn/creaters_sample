class SeriesDecorator < WorkDecorator
  delegate_all

  def form_path(controller, action)
    path = "/#{controller.gsub("series/", "")}"
    action ==  "new" ? path : "#{path}/#{object.id}"
  end

  def outline_name
    object.is_illustration_series? ? "概要" : "あらすじ"
  end

  def operation_item_text_post_next_episode
    object.is_illustration_series? ? "次の絵を投稿" : "次の話を投稿"
  end

  def operation_item_text_change_status
    object.public_posted? ? "非公開にする" : "公開する"
  end
end