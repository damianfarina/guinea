class AdmissionsController < ApplicationController
  before_action :set_admission, only: [:show, :edit, :update, :destroy]

  def index
    @admissions = Admission.all
  end

  def show; end

  def new
    @admission = Admission.new
  end

  def edit; end

  def create
    @admission = Admission.new(admission_params)
    unless admission_params['veterinarian_id'].present?
      veterinarian = Veterinarian.new(
        full_name: admission_params[:petitioner_name],
        phone: admission_params[:petitioner_phone],
        email: admission_params[:petitioner_email]
      )
      @admission.veterinarian = veterinarian if veterinarian.valid?
    end
    @admission.build_veterinarian unless @admission.veterinarian.present?

    respond_to do |format|
      if @admission.save && @admission.veterinarian.save
        format.html { redirect_to @admission, notice: t(:resource_created, scope: [:common], resource: Admission.model_name.human) }
        format.json { render :show, status: :created, location: @admission }
      else
        format.html { render :new }
        format.json { render json: @admission.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless admission_params['veterinarian_id'].present?
      veterinarian = Veterinarian.new(
        full_name: admission_params[:petitioner_name],
        phone: admission_params[:petitioner_phone],
        email: admission_params[:petitioner_email]
      )
      @admission.veterinarian = veterinarian if veterinarian.valid?
    end
    @admission.build_veterinarian unless @admission.veterinarian.present?

    respond_to do |format|
      if @admission.update(admission_params) && @admission.veterinarian.save
        format.html { redirect_to @admission, notice: t(:resource_updated, scope: [:common], resource: Admission.model_name.human) }
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
      format.html { redirect_to admissions_url, notice: t(:resource_destroyed, scope: [:common], resource: Admission.model_name.human) }
      format.json { head :no_content }
    end
  end

private

  def set_admission
    @admission = Admission.find(params[:id])
  end

  def admission_params
    params.require(:admission).permit(
      :veterinarian_id,
      :veterinary_id,
      :petitioner_name,
      :petitioner_phone,
      :petitioner_email,
      :patient_name,
      :species,
      :sex,
      :breed,
      :age,
      :owner_name,
      :comments
    )
  end
end
