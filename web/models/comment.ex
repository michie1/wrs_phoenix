defmodule WrsPhoenix.Comment do
  use WrsPhoenix.Web, :model

  schema "comments" do
    field :raceId, :integer
    field :riderId, :integer
    field :text, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:raceId, :riderId, :text])
    |> validate_required([:raceId, :riderId, :text])
  end
end
