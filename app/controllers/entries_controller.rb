# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  # GET /entries
  # GET /entries.json
  def index
#    @entries = Entry.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @entries }
#    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit

  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.build(params[:entry])
    if @entry.save
      flash[:success] = "!!! ぶろぐ投稿できたね !!!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to root_path, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    redirect_to root_path
  end

  private

  def correct_user
    @entry = current_user.entries.find_by_id(params[:id])
    redirect_to root_path if @entry.nil?
  end
end
