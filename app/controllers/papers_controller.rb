class PapersController < ApplicationController
  #before_action :set_paper, only: [:show, :edit, :update, :destroy]

  # New Paper
  def new
    @paper = Paper.new
    @user = current_user
  end

  # Saves paper
  def create
    @paper = Paper.new(paper_params)

    respond_to do |format|
      if params[:submit] == 'Save'
        current_user.papers << @paper
        if @paper.save
          format.html { redirect_to edit_paper_path(@paper), notice: 'Paper was successfully created.' }
        else
          format.html { render action: 'new' }
          format.json { render json: @paper.errors, status: :unprocessable_entity }
        end
      # Else will equal Render  
      else
        #Something
      end
    end
  end

  def edit
    @paper = current_user.papers.find(params[:id])
  end

  def update
    @paper = current_user.papers.find(params[:id])
    if params[:submit] == 'Save'
      if @paper.update(paper_params)
        redirect_to edit_paper_path(@paper), notice: 'Paper was successfully created.'
      else
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    # Else will equal Render  
    else
      #Something
      redirect_to root_path
    end
  end

  def destroy
    paper = current_user.papers.find(params[:id])
    paper.destroy
    redirect_to root_path, notice: 'Paper was successfully deleted.'
  end

  private

  def paper_params
    params.require(:paper).permit(:title, :markdown)
  end

end
