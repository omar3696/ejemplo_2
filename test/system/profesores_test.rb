require "application_system_test_case"

class ProfesoresTest < ApplicationSystemTestCase
  setup do
    @profesor = profesores(:one)
  end

  test "visiting the index" do
    visit profesores_url
    assert_selector "h1", text: "Profesores"
  end

  test "should create profesor" do
    visit profesores_url
    click_on "New profesor"

    fill_in "Colegio", with: @profesor.colegio_id
    fill_in "Nombre", with: @profesor.nombre
    click_on "Create Profesor"

    assert_text "Profesor was successfully created"
    click_on "Back"
  end

  test "should update Profesor" do
    visit profesor_url(@profesor)
    click_on "Edit this profesor", match: :first

    fill_in "Colegio", with: @profesor.colegio_id
    fill_in "Nombre", with: @profesor.nombre
    click_on "Update Profesor"

    assert_text "Profesor was successfully updated"
    click_on "Back"
  end

  test "should destroy Profesor" do
    visit profesor_url(@profesor)
    click_on "Destroy this profesor", match: :first

    assert_text "Profesor was successfully destroyed"
  end
end
