class VeterinariansController < ApplicationController
  before_action :set_veterinarian, only: [:show, :edit, :update, :destroy]

  def index
    @veterinarians = Veterinarian.all
  end

  def show
  end

  def new
    @veterinarian = Veterinarian.new
  end

  def edit
  end

  def create
    @veterinarian = Veterinarian.new(veterinarian_params)
    set_veterinaries

    respond_to do |format|
      if @veterinarian.save
        @veterinarian.veterinaries = @veterinaries
        format.html { redirect_to @veterinarian, notice: t(:resource_created, scope: [:common], resource: Veterinarian.model_name.human) }
        format.json { render :show, status: :created, location: @veterinarian }
      else
        format.html { render :new }
        format.json { render json: @veterinarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    set_veterinaries
    respond_to do |format|
      if @veterinarian.update(veterinarian_params)
        @veterinarian.veterinaries = @veterinaries
        format.html { redirect_to @veterinarian, notice: t(:resource_updated, scope: [:common], resource: Veterinarian.model_name.human) }
        format.json { render :show, status: :ok, location: @veterinarian }
      else
        format.html { render :edit }
        format.json { render json: @veterinarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @veterinarian.destroy
    respond_to do |format|
      format.html { redirect_to veterinarians_url, notice: t(:resource_destroyed, scope: [:common], resource: Veterinarian.model_name.human) }
      format.json { head :no_content }
    end
  end

private

  def set_veterinaries
    @veterinaries = @veterinarian.veterinaries
    return unless veterinaries_params.present?
    @veterinaries = veterinaries_params['veterinary_ids']
      .delete_if(&:empty?)
      .map { |veterinary_id| Veterinary.find(veterinary_id) }
  end

  def set_veterinarian
    @veterinarian = Veterinarian.find(params[:id])
  end

  def veterinaries_params
    params.fetch(:veterinaries, {}).permit(veterinary_ids: [])
  end

  def veterinarian_params
    params.require(:veterinarian).permit(:full_name, :phone, :email)
  end
end
