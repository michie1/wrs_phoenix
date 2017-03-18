defmodule WrsPhoenix.Repo.Migrations.CreateResult do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :riderId, :integer
      add :raceId, :integer
      add :result, :string
      add :category, :string
      add :strava, :string

      timestamps()
    end

  end
end
