defmodule WrsPhoenix.Race do
  use WrsPhoenix.Web, :model

  schema "races" do
    field :name, :string
    field :date, Ecto.DateTime
    field :category, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :date, :category])
    |> validate_required([:name, :date, :category])
  end
end
