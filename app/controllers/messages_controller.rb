#encoding: utf-8
class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy]
  before_filter :preload, :only => [:show, :edit, :destroy, :update]

  def index
    @site = nil
    site_id = 0
    @status = 0
    if params[:message]
      site_id = params[:message][:site_id].to_i
      @status = params[:message][:status].to_i
    end
    ids = Array.new
    @messages = Array.new
    if site_id
      @site = Site.find(site_id) rescue nil
    end
    @sites = current_user.sites
    if @site and @site.user == current_user
      ids = [@site.id]
    end
    if site_id == 0
      ids = @sites.map(&:id)
    end
    unless ids.empty?
      @messages = Message.where("site_id in (#{ids.join(',')})")
      if @status > 0
        @messages = @messages.where("status = #{@status}")
      end
      @messages = @messages.paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
    end
    @statuses = []
    APP_CONFIG[:status].keys.each {|key| @statuses << [APP_CONFIG[:status][key], key]}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  def embed
    @site = Site.find(params[:site_id])
    @domain = request.env["REMOTE_HOST"]
    @debug = params[:debug]

    layout = 'embed'
    if not @site.domain == @domain and not @debug
      layout = 'forbidden'
    end

    @message = Message.new
    render :layout => layout
  end

  def edit
  end

  def create
    @message = Message.new(params[:message])
    @debug = params[:debug]
    @site = Site.find(params[:site_id])
    unless @site
      raise
    end
    @domain = request.env["REMOTE_HOST"]

    @message.site_id = @site.id
    respond_to do |format|
      if not @site.domain == @domain and not @debug
        format.html { render action: "embed", :layout => "forbidden" }
      end
      if @message.save
        if @message.site.email
          FeedbackMailer.notification(@message).deliver
        end
        format.html { redirect_to embed_path(@site.id, :debug => @debug), notice: 'Сообщение отправлено.' }
      else
        format.html { render action: "embed", :layout => "embed", :debug => @debug }
      end
    end
  end

  def update
    @message.status = params[:message][:status].to_i

    respond_to do |format|
      if @message.save!
        format.html { redirect_to message_path(@message), notice: 'Сообщение обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end


private

  def preload
    @message = Message.find(params[:id])
    @sites = current_user.sites
    unless @sites.include?(@message.site)
      flash[:alert] = "Такого сообщения не существует"
      return redirect_to messages_path
    end
  end

end
