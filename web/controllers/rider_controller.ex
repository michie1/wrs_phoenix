defmodule WrsPhoenix.RiderController do
  use WrsPhoenix.Web, :controller

  alias WrsPhoenix.Rider

  def index(conn, _params) do
    riders = Repo.all(Rider)
    render(conn, "index.html", riders: riders)
  end

  def new(conn, _params) do
    changeset = Rider.changeset(%Rider{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rider" => rider_params}) do
    changeset = Rider.changeset(%Rider{}, rider_params)

    case Repo.insert(changeset) do
      {:ok, _rider} ->
        conn
        |> put_flash(:info, "Rider created successfully.")
        |> redirect(to: rider_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rider = Repo.get!(Rider, id)
    render(conn, "show.html", rider: rider)
  end

  def edit(conn, %{"id" => id}) do
    rider = Repo.get!(Rider, id)
    changeset = Rider.changeset(rider)
    render(conn, "edit.html", rider: rider, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rider" => rider_params}) do
    rider = Repo.get!(Rider, id)
    changeset = Rider.changeset(rider, rider_params)

    case Repo.update(changeset) do
      {:ok, rider} ->
        conn
        |> put_flash(:info, "Rider updated successfully.")
        |> redirect(to: rider_path(conn, :show, rider))
      {:error, changeset} ->
        render(conn, "edit.html", rider: rider, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rider = Repo.get!(Rider, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(rider)

    conn
    |> put_flash(:info, "Rider deleted successfully.")
    |> redirect(to: rider_path(conn, :index))
  end
end
