#encoding: utf-8
class SitesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :preload, :only => [:show, :edit, :update, :destroy, :form_post, :for_page]

  def index
    @sites = Site.where(:user_id => current_user.id).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  def edit
  end

  def create
    @site = Site.new(params[:site])
    @site.user_id = current_user.id

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: "Сайт '#{@site.domain}' добавлен" }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to site_path(@site), notice: 'Данные сайта успешно обновлены' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
  end

protected

  def preload
    @site = Site.find(params[:id])
    if @site.user != current_user
      flash[:notice] = "Сайт не зарегистрирован"
      return redirect_to sites_path
    end
  end

end
