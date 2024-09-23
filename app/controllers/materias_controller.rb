class MateriasController < ApplicationController
  before_action :set_materia, only: %i[ show edit update destroy ]
  load_and_authorize_resource


  # GET /materias or /materias.json
  def index
    if current_usuario.profesor?
      @materias = Materia.where(profesor_id: current_usuario.profesor_id)
      @alumnos = Alumno.where(profesor_id: current_usuario.profesor_id)
    else
      @materias = Materia.all
      @alumnos = Alumno.all
    end
  end

  # GET /materias/1 or /materias/1.json
  def show
    @materia = Materia.find(params[:id])
    @materias = Materia.includes(:notas).all
  end

  # GET /materias/new
  def new
    @materia = Materia.new
    @colegios = Colegio.all
    @profesores = Profesor.all
  end

  # GET /materias/1/edit
  def edit
    @profesores = Profesor.all
    @colegios = Colegio.all
  end

  # POST /materias or /materias.json
  def create
    @materia = Materia.new(materia_params)

    respond_to do |format|
      if @materia.save
        format.html { redirect_to materia_url(@materia), notice: "Materia was successfully created." }
        format.json { render :show, status: :created, location: @materia }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /materias/1 or /materias/1.json
  def update
    respond_to do |format|
      if @materia.update(materia_params)
        format.html { redirect_to materia_url(@materia), notice: "Materia was successfully updated." }
        format.json { render :show, status: :ok, location: @materia }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @materia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /materias/1 or /materias/1.json
  def destroy
    @materia = Materia.find(params[:id])

    begin
      @materia.destroy
      redirect_to materia_path, notice: "Materia eliminado exitosamente."
    rescue ActiveRecord::InvalidForeignKey => e
      # Manejar el error de clave foránea
      flash[:alert] = "No se puede eliminar el materia porque está asociado a notas."
      redirect_to materia_path(@materia)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materia
      @materia = Materia.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def materia_params
      params.require(:materia).permit(:nombre, :profesor_id, :colegio_id)
    end
end
