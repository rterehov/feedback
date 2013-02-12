#encoding: utf-8
class WelcomeController < ApplicationController
  def index
    if current_user
      return redirect_to sites_path
    end
  end
end
