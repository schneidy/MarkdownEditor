class PapersController < ApplicationController
  #before_action :set_paper, only: [:show, :edit, :update, :destroy]
  require 'rdiscount'

  # New Paper
  def new
    @paper = Paper.new(title: params[:title], markdown: params[:markdown])
    @user = current_user
  end

  # Saves paper
  def create
    @paper = Paper.new(paper_params)

    if params[:submit] == 'Save'
      current_user.papers << @paper
      if @paper.save
        respond_to do |format|
          format.html { redirect_to edit_paper_path(@paper), notice: 'Paper was successfully created.' }
        end
      else
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @paper.errors, status: :unprocessable_entity }
        end
      end
    # Else will equal Render  
    else
      render 'new'
    end
  end

  def edit
    @paper = current_user.papers.find(params[:id])
  end

  def update
    @paper = current_user.papers.find(params[:id])
    if params[:submit] == 'Save'
      if @paper.update(paper_params)
        redirect_to root_path, notice: 'Paper was successfully created.'
      else
        respond_to do |format|
          format.html { render action: 'edit' }
          format.json { render json: @paper.errors, status: :unprocessable_entity }
        end
      end
    # Else will equal Render  
    else
      if @paper.update(paper_params)
        redirect_to edit_paper_path(@paper)
      else
        respond_to do |format|
          format.html { render action: 'edit' }
          format.json { render json: @paper.errors, status: :unprocessable_entity }
        
        end
      end
    end
  end

  def destroy
    paper = current_user.papers.find(params[:id])
    paper.destroy
    redirect_to root_path, notice: 'Paper was successfully deleted.'
  end

  def markdown
    @paper = current_user.papers.find(params[:id])
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :markdown)
  end

end
