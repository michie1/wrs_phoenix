defmodule WrsPhoenix.Repo.Migrations.AddWtosIdToRiders do
  use Ecto.Migration

  def change do
    alter table(:riders) do
      add :wtos_id, :integer
    end
  end
end
