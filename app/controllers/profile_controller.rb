#encoding: utf-8
class ProfileController < ApplicationController
  before_filter :authenticate_user!

  # GET /profile
  def show
  end

  # GET /profile/edit
  def edit
    @user = current_user
  end

  # PUT /profile
  def update
    respond_to do |format|
      if current_user.update_attributes(params[:user])
        format.html { redirect_to profile_path, notice: 'Учетные данные обновлены' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
      end
    end
  end

end
