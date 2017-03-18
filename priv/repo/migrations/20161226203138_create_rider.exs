defmodule WrsPhoenix.Repo.Migrations.CreateRider do
  use Ecto.Migration

  def change do
    create table(:riders) do
      add :name, :string
      add :licence, :string

      timestamps()
    end

  end
end
