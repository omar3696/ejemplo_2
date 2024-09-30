class AlumnosController < ApplicationController
  before_action :set_alumno, only: %i[ show edit update destroy ] 
  load_and_authorize_resource

  def generar_pdf
    @alumno = Alumno.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        pdf = generar_pdf_alumno(@alumno)
        send_data pdf.render, filename: "notas_#{@alumno.nombre}.pdf",type: 'application/pdf', disposition: 'inline'
      end
    end
  end

  def generar_pdf_alumno(alumno)

    Prawn::Document.new do |pdf|
      #ODOS LOS ENCABEZADOS
      headers_nota = %w[Materia Enero Febrero Marzo Abril Mayo Junio Julio Agosto Septiembre Octubre Noviembre Diciembre].map {|header| "<font size='9'><b>#{header}</b></font>"}

      headers_promedio = %w[Materia Promedio Estado].map {|header| "<font size='12'><b>#{header}</b></font>"}

      data_nota = []
      data_promedio = []
  
      alumno.materias.each do |materia|
        materia.notas.where(alumno_id: alumno.id).each do |nota|
          data_nota << [materia.nombre, nota.enero, nota.febrero, nota.marzo, nota.abril, nota.mayo, nota.junio, nota.julio, nota.agosto, nota.septiembre, nota.octubre, nota.noviembre, nota.diciembre]
          data_promedio << [materia.nombre, nota.promedio, nota.estado]
        end
      end 

      #TITULO 
      pdf.text "Notas Generales", style: :bold, align: :center, size: 18
      pdf.move_down 40

      #TABLA DATOS ALUMNOS
      box_width = pdf.bounds.width / 2 - 15
      box_height = 40


      pdf.float do
          pdf.bounding_box([0, pdf.cursor], width: box_width, height: box_height) do
              pdf.stroke_bounds 
              pdf.text " Carnet: #{alumno.carnet}", align: :left, valign: :center, size: 12
          end
      end

      pdf.bounding_box([box_width + 10, pdf.cursor], width: box_width, height: box_height) do
        pdf.stroke_bounds 
        pdf.text " Nombre: #{alumno.nombre}", align: :left, valign: :center, size: 12
      end
      pdf.move_down 35

      pdf.stroke_horizontal_rule
      pdf.move_down 20

      #TABLA NOTAS ALUMNOS
      pdf.text "Notas", size: 18, style: :italic, align: :left
      pdf.move_down 20

      pdf.table([headers_nota, *data_nota], width: pdf.bounds.width, header: true,
                cell_style: {
                  borders: %i[top bottom left right], padding: 5,
                  size: 10,
                  inline_format: true
                })
      pdf.move_down 35

      pdf.stroke_horizontal_rule
      pdf.move_down 100

      #TABLA PROMEDIOS ALUMNOS
      pdf.bounding_box([0, 80], :width => pdf.bounds.width, :height => 250) do
          pdf.text "Promedio", size: 18, style: :italic, align: :left
          pdf.move_down 20

          limite_filas = 10
          data_promedio.each_slice(limite_filas) do |slice|
            pdf.table([headers_promedio, *slice], width: pdf.bounds.width, header: true,
                      cell_style: {
                        borders: %i[top bottom left right], padding: 2,
                        size: 10,
                        inline_format: true
                      })
            pdf.move_down 20 # Espacio entre tablas
          end
      end

      pdf.render
    end
  end

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
