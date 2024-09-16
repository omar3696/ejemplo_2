require "test_helper"

class ProfesoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profesor = profesores(:one)
  end

  test "should get index" do
    get profesores_url
    assert_response :success
  end

  test "should get new" do
    get new_profesor_url
    assert_response :success
  end

  test "should create profesor" do
    assert_difference("Profesor.count") do
      post profesores_url, params: { profesor: { colegio_id: @profesor.colegio_id, nombre: @profesor.nombre } }
    end

    assert_redirected_to profesor_url(Profesor.last)
  end

  test "should show profesor" do
    get profesor_url(@profesor)
    assert_response :success
  end

  test "should get edit" do
    get edit_profesor_url(@profesor)
    assert_response :success
  end

  test "should update profesor" do
    patch profesor_url(@profesor), params: { profesor: { colegio_id: @profesor.colegio_id, nombre: @profesor.nombre } }
    assert_redirected_to profesor_url(@profesor)
  end

  test "should destroy profesor" do
    assert_difference("Profesor.count", -1) do
      delete profesor_url(@profesor)
    end

    assert_redirected_to profesores_url
  end
end
