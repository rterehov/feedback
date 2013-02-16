#encoding: utf-8
class WelcomeController < ApplicationController
  before_filter :init

  def index
  end

  def about
  end

  def contacts
  end

private

  def init
    @index = true
  end
end
