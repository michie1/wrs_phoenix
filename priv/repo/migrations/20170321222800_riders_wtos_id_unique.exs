defmodule WrsPhoenix.Repo.Migrations.RidersWtosIdUnique_ do
  use Ecto.Migration

  def change do
    create unique_index(:riders, [:wtos_id])
  end
end
