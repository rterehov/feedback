class Users::PasswordsController < Devise::PasswordsController
  after_filter :flash_errors

  def flash_errors
    unless resource.errors.empty?
      flash[:alert] = resource.errors.full_messages.join(", ")
    end
  end
end
