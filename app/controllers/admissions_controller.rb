class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show, :edit, :update, :destroy]

  def index
    @admissions = Admission.all
  end

  def show
  end

  def new
    @admission = Admission.new
  end

  def edit
  end

  def create
    @admission = Admission.new(admission_params)
    unless @admission.petitioner_id.present?
      petitioner = Veterinarian.new(
        full_name: admission_params[:petitioner_name],
        phone: admission_params[:petitioner_phone],
        email: admission_params[:petitioner_email]
      )
      @admission.petitioner = petitioner if petitioner.valid?
    end

    respond_to do |format|
      if @admission.save && @admission.petitioner.save
        format.html { redirect_to @admission, notice: 'Admission was successfully created.' }
        format.json { render :show, status: :created, location: @admission }
      else
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admission.update(admission_params)
        format.html { redirect_to @admission, notice: 'Admission was successfully updated.' }
        format.json { render :show, status: :ok, location: @admission }
      else
        format.html { render :edit }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admission.destroy
    respond_to do |format|
      format.html { redirect_to admissions_url, notice: 'Admission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admission
      @admission = Admission.find(params[:id])
    end

    def admission_params
      params.require(:admission).permit(
        :petitioner_id,
        :petitioner_name,
        :petitioner_type,
        :petitioner_phone,
        :petitioner_email,
        :patient_name,
        :species,
        :sex,
        :breed,
        :months,
        :owner_name,
        :comments
      )
    end
end
