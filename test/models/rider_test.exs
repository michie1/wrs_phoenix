defmodule WrsPhoenix.RiderTest do
  use WrsPhoenix.ModelCase

  alias WrsPhoenix.Rider

  @valid_attrs %{licence: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Rider.changeset(%Rider{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Rider.changeset(%Rider{}, @invalid_attrs)
    refute changeset.valid?
  end
end
