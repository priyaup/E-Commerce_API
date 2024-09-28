class ApplicationController < ActionController::Base
  def favicon
    send_file Rails.root.join('app', 'assets', 'images', 'favicon.ico')
  end

  
end
