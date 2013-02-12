#encoding: utf-8
class Site < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  attr_accessible :domain, :email

  validates :domain, :presence => true

#  def iframe
#    "<iframe frameborder=\"0\" width=\"640\" height=\"480\" src=\"#{form_url(id)}\"></iframe>"
#  end

  def form_code(url)
    html = "
<form url='#{url}' method=post>
  <input placeholder='Email'>
  <input placeholder='Телефон'>
  <text placeholder='Введите ваше сообщение'>
  <input type=submit>
</form>"
    return html
  end

end
