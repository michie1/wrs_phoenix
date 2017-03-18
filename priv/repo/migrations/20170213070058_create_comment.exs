defmodule WrsPhoenix.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :raceId, :integer
      add :riderId, :integer
      add :date, :string
      add :text, :string

      timestamps()
    end

  end
end
