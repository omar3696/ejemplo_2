require "application_system_test_case"

class ColegiosTest < ApplicationSystemTestCase
  setup do
    @colegio = colegios(:one)
  end

  test "visiting the index" do
    visit colegios_url
    assert_selector "h1", text: "Colegios"
  end

  test "should create colegio" do
    visit colegios_url
    click_on "New colegio"

    fill_in "Direccion", with: @colegio.direccion
    fill_in "Nombre", with: @colegio.nombre
    click_on "Create Colegio"

    assert_text "Colegio was successfully created"
    click_on "Back"
  end

  test "should update Colegio" do
    visit colegio_url(@colegio)
    click_on "Edit this colegio", match: :first

    fill_in "Direccion", with: @colegio.direccion
    fill_in "Nombre", with: @colegio.nombre
    click_on "Update Colegio"

    assert_text "Colegio was successfully updated"
    click_on "Back"
  end

  test "should destroy Colegio" do
    visit colegio_url(@colegio)
    click_on "Destroy this colegio", match: :first

    assert_text "Colegio was successfully destroyed"
  end
end
