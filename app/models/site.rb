class Site < ActiveRecord::Base
  belongs_to :user
  has_many :messages

  attr_accessible :domain, :email
end
