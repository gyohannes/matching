class ProgramChoicesController < ApplicationController
  before_action :set_program_choice, only: [:show, :edit, :update, :destroy]

  # GET /program_choices
  # GET /program_choices.json
  def index
    @program_choices = ProgramChoice.all
  end

  # GET /program_choices/1
  # GET /program_choices/1.json
  def show
  end

  # GET /program_choices/new
  def new
    @program_choice = ProgramChoice.new
  end

  # GET /program_choices/1/edit
  def edit
  end

  # POST /program_choices
  # POST /program_choices.json
  def create
    @program_choice = ProgramChoice.new(program_choice_params)

    respond_to do |format|
      if @program_choice.save
        format.html { redirect_to @program_choice, notice: 'Program choice was successfully created.' }
        format.json { render :show, status: :created, location: @program_choice }
      else
        format.html { render :new }
        format.json { render json: @program_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_choices/1
  # PATCH/PUT /program_choices/1.json
  def update
    respond_to do |format|
      if @program_choice.update(program_choice_params)
        format.html { redirect_to @program_choice, notice: 'Program choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @program_choice }
      else
        format.html { render :edit }
        format.json { render json: @program_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_choices/1
  # DELETE /program_choices/1.json
  def destroy
    @program_choice.destroy
    respond_to do |format|
      format.html { redirect_to program_choices_url, notice: 'Program choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_choice
      @program_choice = ProgramChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_choice_params
      params.require(:program_choice).permit(:applicant_id, :program_id, :choice_number)
    end
end
