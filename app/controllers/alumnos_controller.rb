class AlumnosController < ApplicationController
  before_action :set_alumno, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /alumnos or /alumnos.json
  def index
    @alumnos = Alumno.all
  end

  # GET /alumnos/1 or /alumnos/1.json
  def show
    @alumno = Alumno.find(params[:id])
    @profesores = @alumno.materias.map(&:profesor).uniq
  end

  # GET /alumnos/new
  def new
    @alumno = Alumno.new
    @colegios = Colegio.all
  end

  # GET /alumnos/1/edit
  def edit
    @colegios = Colegio.all
  end

  # POST /alumnos or /alumnos.json
  def create
    @alumno = Alumno.new(alumno_params)

    respond_to do |format|
      if @alumno.save
        format.html { redirect_to alumno_url(@alumno), notice: "Alumno was successfully created." }
        format.json { render :show, status: :created, location: @alumno }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alumnos/1 or /alumnos/1.json
  def update
    respond_to do |format|
      if @alumno.update(alumno_params)
        format.html { redirect_to alumno_url(@alumno), notice: "Alumno was successfully updated." }
        format.json { render :show, status: :ok, location: @alumno }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @alumno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alumnos/1 or /alumnos/1.json
  def destroy
    @alumno = Alumno.find(params[:id])

    begin
      @alumno.destroy
      redirect_to alumno_path, notice: "Colegio eliminado exitosamente."
    rescue ActiveRecord::InvalidForeignKey => e
      # Manejar el error de clave foránea
      flash[:alert] = "No se puede eliminar el alumno porque está asociado a profesores o materias."
      redirect_to alumno_path(@alumno)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alumno
      @alumno = Alumno.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def alumno_params
      params.require(:alumno).permit(:nombre, :colegio_id)
    end
end
