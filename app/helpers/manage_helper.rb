module ManageHelper
  def no_works_message
    abstract_work_type = case params[:controller]
    when /novels/ then '小説'
    when /illustrations/ then 'イラスト'
    when /comics/ then '漫画'
    end

    work_status = case params[:action]
    when /draft/ then '下書き'
    when /posted/ then '投稿済み'
    end

    return "#{work_status}の#{abstract_work_type}はありません。"
  end

  def operations
    params[:action].match?(/draft/) ? '編集/投稿/削除' : '編集/削除'
  end
end