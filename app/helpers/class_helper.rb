# =======================================
# クラス名調整のためのメソッドはここに書いていく
# =======================================

module ClassHelper
  def current(controller: nil, action: nil, severe: false)
    return "current" if is_current_controller_and_action?(controller: controller, action: action, severe: severe)
  end

  def body_class
    "#{params[:controller]&.gsub('/', ' ')} #{params[:action]}"
  end

  def flash_class
    return "none" if flash.blank?
    return flash.keys.first.to_s
  end

  def manage_works_list_class
    params[:action].match?(/draft/) ? 'draft-index-list' : 'posted-index-list'
  end
end