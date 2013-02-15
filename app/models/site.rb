#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  attr_accessible :domain, :email

  validates :domain, :presence => true

  def iframe
    "<iframe frameborder=\"0\" width=\"300\" height=\"340\" src=\"#{form_url}\"></iframe>"
  end

  def form_url
    File.join("http://#{APP_CONFIG[:host]}:#{APP_CONFIG[:port]}", 
        Rails.application.routes.url_helpers.embed_url({:site_id => id, :only_path => true}))
  end

end
