module ApplicationHelper

  def javascript_path
    "#{params[:controller]}/#{params[:action]}.js"
  end

  def datetime_for_display(datetime)
    datetime.strftime("%Y/%m/%d %H:%M")
  end

  def current_contents
    if current_is_read_contents?
      return "read_contents"
    else
      return "main_contents"
    end
  end

  def is_current_controller_and_action?(controller: nil, action: nil, severe: false)
    severe ? is_current_controller?(controller) && is_current_action?(action) : is_current_controller?(controller) || is_current_action?(action)
  end

  def is_current_controller?(controller)
    controller == params[:controller]
  end

  def is_current_action?(action)
    action == params[:action]
  end

  private

    # read用ページを表示するcontrollerとactionのペア
    # レイアウトを切り替えるために思いついた案だがベストプラクティスが他に絶対ある
    def read_contents_pairs
      {
        "series/novel_series" => "show",
        "series/illustration_series" => "show",
        "series/comic_series" => "show",
        "novels" => "show",
        "series" => "show",
        "comic" => "show",
      }
    end

    def current_is_read_contents?
      read_contents_pairs.any? do |controller, action|
        is_current_controller_and_action?(controller: controller, action: action, severe: true)
      end
    end
end
