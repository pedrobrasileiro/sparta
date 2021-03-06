class CommonPagesController < ApplicationController
  def show
    method_name = params[:id]
    begin
      send "collect_#{method_name}"
    rescue NoMethodError
      nil
    end
    render :template => "common_pages/#{method_name}"
  end

private
end
