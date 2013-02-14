#encoding: utf-8
class MessagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :edit, :update, :destroy]
  
  def index
    @messages = Message.all

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

  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def embed
    @site = Site.find(params[:site_id])
    @domain = request.env["REMOTE_HOST"]
    
    layout = 'embed'
    unless @site.domain == @domain
      layout = 'forbidden'
    end

    @message = Message.new
    render :layout => layout
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    site_id = params[:site_id]
    @message_site_id = site_id
    respond_to do |format|
      if @message.save
        format.html { redirect_to embed_path(site_id), notice: 'Сообщение отправлено.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
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
