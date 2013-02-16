#encoding: utf-8
class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy]
  
  def index
    ids = current_user.sites.all(:select => 'id').map(&:id)
    if ids.empty?
      @messages = []
    else
      @messages = Message.where("site_id in (#{ids.join(',')})")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.find(params[:id])

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
    @message = Message.find(params[:id])
  end

  def create
    @debug = params[:debug]
    @message = Message.new(params[:message])
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
    @message = Message.find(params[:id])
    @message.status = params[:message][:status].to_i

    respond_to do |format|
      if @message.save!
        format.html { redirect_to site_message_path(@message), notice: 'Сообщение обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end
end
