module ApplicationHelper
  def body_id
    (%w[common_pages].include?(params[:controller]) ? 'page' : 'ui')
  end
end
