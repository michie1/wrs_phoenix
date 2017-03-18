defmodule WrsPhoenix.Rider do
  use WrsPhoenix.Web, :model

  schema "riders" do
    field :name, :string
    field :licence, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :licence])
    |> validate_required([:name])
  end
end
