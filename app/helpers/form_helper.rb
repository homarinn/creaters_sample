module FormHelper
  def work_submit_button_value
    return "新規作成" if is_current_action?("new")
    return "更新" if is_current_action?("edit")
  end
end