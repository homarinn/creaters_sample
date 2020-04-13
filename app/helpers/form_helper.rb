module FormHelper
  def work_submit_button_value
    return "新規作成" if is_current_action?("new")
    return "更新" if is_current_action?("edit")
  end

  def user_form_heading
    return "新規登録" if is_current_action?("new")
    return "登録情報更新" if is_current_action?("edit")
  end

  def user_submit_button_value
    return "登録する" if is_current_action?("new")
    return "更新する" if is_current_action?("edit")
  end
end