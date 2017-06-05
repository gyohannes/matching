class ProgramQuotaController < ApplicationController
  before_action :set_program_quotum, only: [:show, :edit, :update, :destroy]

  # GET /program_quota
  # GET /program_quota.json
  def index
    @program_quota = ProgramQuotum.all
  end

  # GET /program_quota/1
  # GET /program_quota/1.json
  def show
  end

  # GET /program_quota/new
  def new
    @program_quotum = ProgramQuotum.new
  end

  # GET /program_quota/1/edit
  def edit
  end

  # POST /program_quota
  # POST /program_quota.json
  def create
    @program_quotum = ProgramQuotum.new(program_quotum_params)

    respond_to do |format|
      if @program_quotum.save
        format.html { redirect_to @program_quotum, notice: 'Program quotum was successfully created.' }
        format.json { render :show, status: :created, location: @program_quotum }
      else
        format.html { render :new }
        format.json { render json: @program_quotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_quota/1
  # PATCH/PUT /program_quota/1.json
  def update
    respond_to do |format|
      if @program_quotum.update(program_quotum_params)
        format.html { redirect_to @program_quotum, notice: 'Program quotum was successfully updated.' }
        format.json { render :show, status: :ok, location: @program_quotum }
      else
        format.html { render :edit }
        format.json { render json: @program_quotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_quota/1
  # DELETE /program_quota/1.json
  def destroy
    @program_quotum.destroy
    respond_to do |format|
      format.html { redirect_to program_quota_url, notice: 'Program quotum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_quotum
      @program_quotum = ProgramQuotum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_quotum_params
      params.require(:program_quotum).permit(:program_id, :university_id, :quota_number)
    end
end
