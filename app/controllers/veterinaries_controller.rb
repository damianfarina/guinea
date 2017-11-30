class VeterinariesController < ApplicationController
  before_action :set_veterinary, only: [:show, :edit, :update, :destroy]

  def index
    @veterinaries = Veterinary.all
  end

  def show
  end

  def new
    @veterinary = Veterinary.new
  end

  def edit
  end

  def create
    @veterinary = Veterinary.new(veterinary_params)

    respond_to do |format|
      if @veterinary.save
        format.html { redirect_to @veterinary, notice: 'Veterinary was successfully created.' }
        format.json { render :show, status: :created, location: @veterinary }
      else
        format.html { render :new }
        format.json { render json: @veterinary.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @veterinary.update(veterinary_params)
        format.html { redirect_to @veterinary, notice: 'Veterinary was successfully updated.' }
        format.json { render :show, status: :ok, location: @veterinary }
      else
        format.html { render :edit }
        format.json { render json: @veterinary.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @veterinary.destroy
    respond_to do |format|
      format.html { redirect_to veterinaries_url, notice: 'Veterinary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_veterinary
      @veterinary = Veterinary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def veterinary_params
      params.require(:veterinary).permit(:name, :phone, :email)
    end
end
