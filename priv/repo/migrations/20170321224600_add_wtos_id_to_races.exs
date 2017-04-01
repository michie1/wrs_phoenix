defmodule WrsPhoenix.Repo.Migrations.AddWtosIdToRiders do
  use Ecto.Migration

  def change do
    alter table(:races) do
      add :wtos_id, :integer
    end

    create unique_index(:races, [:wtos_id])
  end
end
