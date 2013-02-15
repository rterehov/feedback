#encoding: utf-8
class WelcomeController < ApplicationController
  def index
    @index = true
  end

  def about
    @index = true
  end

  def contacts
    @index = true
  end
end
