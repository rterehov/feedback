#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  attr_accessible :domain, :email

  validates :domain, :presence => true
  validate :domain_check
  validates_uniqueness_of :domain, :case_sensitive => false

  before_save :before_save_handler

  
  def iframe
    "<iframe frameborder=\"0\" width=\"300\" height=\"480\" src=\"#{form_url}\"></iframe>"
  end

  def form_url
    File.join("http://#{APP_CONFIG[:host]}:#{APP_CONFIG[:port]}", 
        Rails.application.routes.url_helpers.embed_url({:site_id => id, :only_path => true}))
  end

private

  def domain_check
    return if domain == 'localhost'
    errors[:base] << "Неверно указан домен" unless domain.include?(".")
    if Regexp.new(/^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$/).match(domain)
      errors[:base] << "Укажите домен, а не IP"
    end
  end

  # Оставляем от домена только корневой домен и домен первого уровня
  def before_save_handler
    return if domain == 'localhost'
    scheme = URI.parse(domain).scheme
    domain2 = domain
    unless scheme
      domain2 = "http://#{domain}"
    end
    parts = URI.parse(domain2).host.split(".")
    self.domain = "#{parts[-2]}.#{parts[-1]}"
  end

end
