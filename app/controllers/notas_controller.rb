class NotasController < ApplicationController
  before_action :set_nota, only: %i[ show edit update destroy ] 
  load_and_authorize_resource

  def exportar_excel_aprobados
    #authorize! :export, Nota

    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    headers = ["Carnet", "Nombre", "Colegio", "Materia", "Notas", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", "Promedio", "Estado" ]

    worksheet.add_cell(1, 0, headers[0])
    worksheet.add_cell(1, 1, headers[1])
    worksheet.add_cell(1, 2, headers[2])
    worksheet.add_cell(1, 3, headers[3])
    worksheet.add_cell(0, 4, headers[4])
    worksheet.add_cell(1, 4, headers[5])
    worksheet.add_cell(1, 5, headers[6])
    worksheet.add_cell(1, 6, headers[7])
    worksheet.add_cell(1, 7, headers[8])
    worksheet.add_cell(1, 8, headers[9])
    worksheet.add_cell(1, 9, headers[10])
    worksheet.add_cell(1, 10, headers[11])
    worksheet.add_cell(1, 11, headers[12])
    worksheet.add_cell(1, 12, headers[13])
    worksheet.add_cell(1, 13, headers[14])
    worksheet.add_cell(1, 14, headers[15])
    worksheet.add_cell(1, 15, headers[16])
    worksheet.add_cell(1, 16, headers[17])
    worksheet.add_cell(1, 17, headers[18])

    notas = Nota.aprobados

    notas.each_with_index do |notas, index|
      worksheet.add_cell(index + 2, 0, notas.alumno.carnet)
      worksheet.add_cell(index + 2, 1, notas.alumno.nombre)
      worksheet.add_cell(index + 2, 2, notas.alumno.colegio.nombre)
      worksheet.add_cell(index + 2, 3, notas.materia.nombre)
      worksheet.add_cell(index + 2, 4, notas.enero)
      worksheet.add_cell(index + 2, 5, notas.febrero)
      worksheet.add_cell(index + 2, 6, notas.marzo)
      worksheet.add_cell(index + 2, 7, notas.abril)
      worksheet.add_cell(index + 2, 8, notas.mayo)
      worksheet.add_cell(index + 2, 9, notas.junio)
      worksheet.add_cell(index + 2, 10, notas.julio)
      worksheet.add_cell(index + 2, 11, notas.agosto)
      worksheet.add_cell(index + 2, 12, notas.septiembre)
      worksheet.add_cell(index + 2, 13, notas.octubre)
      worksheet.add_cell(index + 2, 14, notas.noviembre)
      worksheet.add_cell(index + 2, 15, notas.diciembre)
      worksheet.add_cell(index + 2, 16, notas.promedio)
      worksheet.add_cell(index + 2, 17, notas.estado)
    end

    file_path = Rails.root.join('tmp', 'alumnos_aprobados.xlsx')
    workbook.write(file_path)

    send_file file_path, filename: "alumnos_aprobados_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

  end

  def exportar_excel_reprobados
    #authorize! :export, Nota

    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    headers = ["Carnet", "Nombre", "Colegio", "Materia", "Notas", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", "Promedio", "Estado" ]

    worksheet.add_cell(1, 0, headers[0])
    worksheet.add_cell(1, 1, headers[1])
    worksheet.add_cell(1, 2, headers[2])
    worksheet.add_cell(1, 3, headers[3])
    worksheet.add_cell(0, 4, headers[4])
    worksheet.add_cell(1, 4, headers[5])
    worksheet.add_cell(1, 5, headers[6])
    worksheet.add_cell(1, 6, headers[7])
    worksheet.add_cell(1, 7, headers[8])
    worksheet.add_cell(1, 8, headers[9])
    worksheet.add_cell(1, 9, headers[10])
    worksheet.add_cell(1, 10, headers[11])
    worksheet.add_cell(1, 11, headers[12])
    worksheet.add_cell(1, 12, headers[13])
    worksheet.add_cell(1, 13, headers[14])
    worksheet.add_cell(1, 14, headers[15])
    worksheet.add_cell(1, 15, headers[16])
    worksheet.add_cell(1, 16, headers[17])
    worksheet.add_cell(1, 17, headers[18])

    notas = Nota.reprobados

    notas.each_with_index do |notas, index|
      worksheet.add_cell(index + 2, 0, notas.alumno.carnet)
      worksheet.add_cell(index + 2, 1, notas.alumno.nombre)
      worksheet.add_cell(index + 2, 2, notas.alumno.colegio.nombre)
      worksheet.add_cell(index + 2, 3, notas.materia.nombre)
      worksheet.add_cell(index + 2, 4, notas.enero)
      worksheet.add_cell(index + 2, 5, notas.febrero)
      worksheet.add_cell(index + 2, 6, notas.marzo)
      worksheet.add_cell(index + 2, 7, notas.abril)
      worksheet.add_cell(index + 2, 8, notas.mayo)
      worksheet.add_cell(index + 2, 9, notas.junio)
      worksheet.add_cell(index + 2, 10, notas.julio)
      worksheet.add_cell(index + 2, 11, notas.agosto)
      worksheet.add_cell(index + 2, 12, notas.septiembre)
      worksheet.add_cell(index + 2, 13, notas.octubre)
      worksheet.add_cell(index + 2, 14, notas.noviembre)
      worksheet.add_cell(index + 2, 15, notas.diciembre)
      worksheet.add_cell(index + 2, 16, notas.promedio)
      worksheet.add_cell(index + 2, 17, notas.estado)
    end

    file_path = Rails.root.join('tmp', 'alumnos_reprobados.xlsx')
    workbook.write(file_path)

    send_file file_path, filename: "alumnos_reprobados_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

  end

  def exportar_excel_todos
    #authorize! :export, Nota

    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    headers = ["Carnet", "Nombre", "Colegio", "Materia", "Notas", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", "Promedio", "Estado" ]

    worksheet.add_cell(1, 0, headers[0])
    worksheet.add_cell(1, 1, headers[1])
    worksheet.add_cell(1, 2, headers[2])
    worksheet.add_cell(1, 3, headers[3])
    worksheet.add_cell(0, 4, headers[4])
    worksheet.add_cell(1, 4, headers[5])
    worksheet.add_cell(1, 5, headers[6])
    worksheet.add_cell(1, 6, headers[7])
    worksheet.add_cell(1, 7, headers[8])
    worksheet.add_cell(1, 8, headers[9])
    worksheet.add_cell(1, 9, headers[10])
    worksheet.add_cell(1, 10, headers[11])
    worksheet.add_cell(1, 11, headers[12])
    worksheet.add_cell(1, 12, headers[13])
    worksheet.add_cell(1, 13, headers[14])
    worksheet.add_cell(1, 14, headers[15])
    worksheet.add_cell(1, 15, headers[16])
    worksheet.add_cell(1, 16, headers[17])
    worksheet.add_cell(1, 17, headers[18])

    notas = Nota.all

    notas.each_with_index do |notas, index|
      worksheet.add_cell(index + 2, 0, notas.alumno.carnet)
      worksheet.add_cell(index + 2, 1, notas.alumno.nombre)
      worksheet.add_cell(index + 2, 2, notas.alumno.colegio.nombre)
      worksheet.add_cell(index + 2, 3, notas.materia.nombre)
      worksheet.add_cell(index + 2, 4, notas.enero)
      worksheet.add_cell(index + 2, 5, notas.febrero)
      worksheet.add_cell(index + 2, 6, notas.marzo)
      worksheet.add_cell(index + 2, 7, notas.abril)
      worksheet.add_cell(index + 2, 8, notas.mayo)
      worksheet.add_cell(index + 2, 9, notas.junio)
      worksheet.add_cell(index + 2, 10, notas.julio)
      worksheet.add_cell(index + 2, 11, notas.agosto)
      worksheet.add_cell(index + 2, 12, notas.septiembre)
      worksheet.add_cell(index + 2, 13, notas.octubre)
      worksheet.add_cell(index + 2, 14, notas.noviembre)
      worksheet.add_cell(index + 2, 15, notas.diciembre)
      worksheet.add_cell(index + 2, 16, notas.promedio)
      worksheet.add_cell(index + 2, 17, notas.estado)
    end

    file_path = Rails.root.join('tmp', 'alumnos.xlsx')
    workbook.write(file_path)

    send_file file_path, filename: "alumnos_#{Time.now.strftime('%Y%m%d_%H%M%S')}.xlsx", type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

  end

  # GET /notas or /notas.json
  def index
    if current_usuario.alumno?
      @notas_aprobadas = Nota.aprobados.where(alumno_id: current_usuario.alumno_id)
      @notas_reprobadas = Nota.reprobados.where(alumno_id: current_usuario.alumno_id)
    else
      @notas_aprobadas = Nota.aprobados
      @notas_reprobadas = Nota.reprobados
    end

    if current_usuario.profesor?
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
