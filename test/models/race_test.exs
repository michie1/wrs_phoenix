defmodule WrsPhoenix.RaceTest do
  use WrsPhoenix.ModelCase

  alias WrsPhoenix.Race

  @valid_attrs %{category: "some content", date: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Race.changeset(%Race{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Race.changeset(%Race{}, @invalid_attrs)
    refute changeset.valid?
  end
end
