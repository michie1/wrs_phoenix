defmodule WrsPhoenix.RiderControllerTest do
  use WrsPhoenix.ConnCase

  alias WrsPhoenix.Rider
  @valid_attrs %{licence: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, rider_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing riders"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, rider_path(conn, :new)
    assert html_response(conn, 200) =~ "New rider"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, rider_path(conn, :create), rider: @valid_attrs
    assert redirected_to(conn) == rider_path(conn, :index)
    assert Repo.get_by(Rider, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, rider_path(conn, :create), rider: @invalid_attrs
    assert html_response(conn, 200) =~ "New rider"
  end

  test "shows chosen resource", %{conn: conn} do
    rider = Repo.insert! %Rider{}
    conn = get conn, rider_path(conn, :show, rider)
    assert html_response(conn, 200) =~ "Show rider"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, rider_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    rider = Repo.insert! %Rider{}
    conn = get conn, rider_path(conn, :edit, rider)
    assert html_response(conn, 200) =~ "Edit rider"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    rider = Repo.insert! %Rider{}
    conn = put conn, rider_path(conn, :update, rider), rider: @valid_attrs
    assert redirected_to(conn) == rider_path(conn, :show, rider)
    assert Repo.get_by(Rider, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    rider = Repo.insert! %Rider{}
    conn = put conn, rider_path(conn, :update, rider), rider: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit rider"
  end

  test "deletes chosen resource", %{conn: conn} do
    rider = Repo.insert! %Rider{}
    conn = delete conn, rider_path(conn, :delete, rider)
    assert redirected_to(conn) == rider_path(conn, :index)
    refute Repo.get(Rider, rider.id)
  end
end
