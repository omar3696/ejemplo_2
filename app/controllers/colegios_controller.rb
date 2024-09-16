class ColegiosController < ApplicationController
  before_action :set_colegio, only: %i[ show edit update destroy ]

  # GET /colegios or /colegios.json
  def index
    @colegios = Colegio.all
  end

  # GET /colegios/1 or /colegios/1.json
  def show
  end

  # GET /colegios/new
  def new
    @colegio = Colegio.new
  end

  # GET /colegios/1/edit
  def edit
  end

  # POST /colegios or /colegios.json
  def create
    @colegio = Colegio.new(colegio_params)

    respond_to do |format|
      if @colegio.save
        format.html { redirect_to colegio_url(@colegio), notice: "Colegio was successfully created." }
        format.json { render :show, status: :created, location: @colegio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @colegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colegios/1 or /colegios/1.json
  def update
    respond_to do |format|
      if @colegio.update(colegio_params)
        format.html { redirect_to colegio_url(@colegio), notice: "Colegio was successfully updated." }
        format.json { render :show, status: :ok, location: @colegio }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @colegio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colegios/1 or /colegios/1.json
  def destroy
    @colegio.destroy!

    respond_to do |format|
      format.html { redirect_to colegios_url, notice: "Colegio was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colegio
      @colegio = Colegio.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def colegio_params
      params.require(:colegio).permit(:nombre, :direccion)
    end
end
