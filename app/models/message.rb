#encoding: utf-8
class Message < ActiveRecord::Base
  belongs_to :site

  attr_accessible :email, :message, :name, :phone, :site_id, :status

  validate :presense => :name
  validate :presense => :message
  validate :phone_or_email

private

  def phone_or_email
    return true if phone or email
    errors[:base] << "Одно из полей 'Телефон' или 'Email' должно быть заполнено"
  end

end
