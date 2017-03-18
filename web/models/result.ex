defmodule WrsPhoenix.Result do
  use WrsPhoenix.Web, :model

  schema "results" do
    field :riderId, :integer
    field :raceId, :integer
    field :result, :string
    field :category, :string
    field :strava, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:riderId, :raceId, :result, :category, :strava])
    |> validate_required([:riderId, :raceId, :result, :category])
  end
end
