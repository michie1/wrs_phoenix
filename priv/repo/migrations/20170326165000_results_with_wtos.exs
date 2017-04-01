defmodule WrsPhoenix.Repo.Migrations.AddWtosIdToRiders do
  use Ecto.Migration

  def change do
    alter table(:results) do
      add :wtos_result_id, :integer
      add :wtos_race_id, :integer
      add :wtos_rider_id, :integer
    end

    create unique_index(:results, [:wtos_result_id])
    create unique_index(:results, [:wtos_race_id, :wtos_rider_id])
    create unique_index(:results, [:raceId, :riderId])
  end
end
