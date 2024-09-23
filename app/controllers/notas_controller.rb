class NotasController < ApplicationController
  before_action :set_nota, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /notas or /notas.json
  def index
    if current_usuario.alumno?
      @notas_aprobadas = Nota.aprobados.where(alumno_id: current_usuario.alumno_id)
      @notas_reprobadas = Nota.reprobados.where(alumno_id: current_usuario.alumno_id)
    elsif
      @materias = current_usuario.profesor.materias
      @notas_aprobadas = Nota.aprobados.where(materia_id: @materias.pluck(:id))
      @notas_reprobadas = Nota.reprobados.where(materia_id: @materias.pluck(:id))
    else
      @notas_aprobadas = Nota.aprobados
      @notas_reprobadas = Nota.reprobados
    end
  end

  # GET /notas/1 or /notas/1.json
  def show
    @nota = Nota.find(params[:id])
    @alumno = @nota.alumno # Asegúrate de cargar el alumno relacionado
    @materia = @nota.materia

    
  end

  # GET /notas/new
  def new 
    @nota = Nota.new
    @alumnos = Alumno.all
    @materias = Materia.all
    @colegios = Colegio.all
  end

  # GET /notas/1/edit
  def edit
    @alumnos = Alumno.all
    @materias = Materia.all
    @colegios = Colegio.all
  end

  # POST /notas or /notas.json
  def create
    @nota = Nota.new(nota_params)

    respond_to do |format|
      if @nota.save
        format.html { redirect_to nota_url(@nota), notice: "Nota was successfully created." }
        format.json { render :show, status: :created, location: @nota }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notas/1 or /notas/1.json
  def update
    respond_to do |format|
      if @nota.update(nota_params)
        format.html { redirect_to nota_url(@nota), notice: "Nota was successfully updated." }
        format.json { render :show, status: :ok, location: @nota }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @nota.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notas/1 or /notas/1.json
  def destroy
    @nota.destroy!

    respond_to do |format|
      format.html { redirect_to notas_url, notice: "Nota was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nota
      @nota = Nota.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def nota_params
      params.require(:nota).permit(
        :alumno_id, 
        :materia_id, 
        :colegio_id, 
        :enero, 
        :febrero, 
        :marzo, 
        :abril, 
        :mayo, 
        :junio, 
        :julio, 
        :agosto, 
        :septiembre, 
        :octubre, 
        :noviembre, 
        :diciembre, 
        :promedio
      )
    end
end
