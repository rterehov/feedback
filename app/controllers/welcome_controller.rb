#encoding: utf-8
class WelcomeController < ApplicationController
  def index
    if current_user
      return redirect profile_path
    end
  end
end
