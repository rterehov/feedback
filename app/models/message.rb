class Message < ActiveRecord::Base
  belongs_to :site

  attr_accessible :email, :message, :name, :phone, :site_id, :status
end
