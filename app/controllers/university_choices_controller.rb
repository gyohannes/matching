class UniversityChoicesController < ApplicationController
  before_action :set_university_choice, only: [:show, :edit, :update, :destroy]

  # GET /university_choices
  # GET /university_choices.json
  def index
    @university_choices = UniversityChoice.all
  end

  # GET /university_choices/1
  # GET /university_choices/1.json
  def show
  end

  # GET /university_choices/new
  def new
    @university_choice = UniversityChoice.new
  end

  # GET /university_choices/1/edit
  def edit
  end

  # POST /university_choices
  # POST /university_choices.json
  def create
    @university_choice = UniversityChoice.new(university_choice_params)

    respond_to do |format|
      if @university_choice.save
        format.html { redirect_to @university_choice, notice: 'University choice was successfully created.' }
        format.json { render :show, status: :created, location: @university_choice }
      else
        format.html { render :new }
        format.json { render json: @university_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /university_choices/1
  # PATCH/PUT /university_choices/1.json
  def update
    respond_to do |format|
      if @university_choice.update(university_choice_params)
        format.html { redirect_to @university_choice, notice: 'University choice was successfully updated.' }
        format.json { render :show, status: :ok, location: @university_choice }
      else
        format.html { render :edit }
        format.json { render json: @university_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /university_choices/1
  # DELETE /university_choices/1.json
  def destroy
    @university_choice.destroy
    respond_to do |format|
      format.html { redirect_to university_choices_url, notice: 'University choice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_university_choice
      @university_choice = UniversityChoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def university_choice_params
      params.require(:university_choice).permit(:program_choice_id, :university_id, :choice_number)
    end
end
