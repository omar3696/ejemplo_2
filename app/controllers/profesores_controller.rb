class ProfesoresController < ApplicationController
  before_action :set_profesor, only: %i[ show edit update destroy ]
  load_and_authorize_resource


  # GET /profesores or /profesores.json
  def index
    @profesores = Profesor.all
  end

  # GET /profesores/1 or /profesores/1.json
  def show
    @profesor = Profesor.find(params[:id])
    @profesores = Profesor.includes(:colegio, :materias, :alumnos).all
  end

  # GET /profesores/new
  def new
    @profesor = Profesor.new
    @colegios = Colegio.all
  end

  # GET /profesores/1/edit
  def edit
    @colegios = Colegio.all
  end

  # POST /profesores or /profesores.json
  def create
    @profesor = Profesor.new(profesor_params)

    respond_to do |format|
      if @profesor.save
        format.html { redirect_to profesor_url(@profesor), notice: "Profesor was successfully created." }
        format.json { render :show, status: :created, location: @profesor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @profesor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profesores/1 or /profesores/1.json
  def update
    respond_to do |format|
      if @profesor.update(profesor_params)
        format.html { redirect_to profesor_url(@profesor), notice: "Profesor was successfully updated." }
        format.json { render :show, status: :ok, location: @profesor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @profesor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profesores/1 or /profesores/1.json
  def destroy
    @profesor = Profesor.find(params[:id])

    begin
      @profesor.destroy
      redirect_to profesor_path, notice: "Profesor eliminado exitosamente."
    rescue ActiveRecord::InvalidForeignKey => e
      # Manejar el error de clave foránea
      flash[:alert] = "No se puede eliminar el profesor porque está asociado a alumnos o materias."
      redirect_to profesor_path(@profesor)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profesor
      @profesor = Profesor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profesor_params
      params.require(:profesor).permit(:nombre, :colegio_id)
    end
end
