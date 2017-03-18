defmodule WrsPhoenix.Repo.Migrations.CreateRace do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :name, :string
      add :date, :datetime
      add :category, :string

      timestamps()
    end

  end
end
