#encoding: utf-8
class Message < ActiveRecord::Base
  belongs_to :site

  attr_accessible :email, :message, :name, :phone, :site_id, :status

  validates_presence_of :name
  validates_presence_of :message

  validate :phone_or_email
  validate :phone_length
  validate :email_check

protected

  def phone_or_email
    return true if not phone.empty? or not email.empty?
    errors[:base] << "Одно из полей 'Телефон' или 'Email' должно быть заполнено"
  end

  def phone_length
    return if phone.blank?
    return if Regexp.new(/^\d\d\d\d\d\d\d\d\d\d$/).match(phone)
    errors[:base] << "Телефон должен быть представлен в виде 10-ти цифр"
  end

  def email_check
    return if email.blank?
    return if Regexp.new(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i).match(email)
    errors[:base] << "Указан невалидный email"
  end

end
