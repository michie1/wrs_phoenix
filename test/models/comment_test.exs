defmodule WrsPhoenix.CommentTest do
  use WrsPhoenix.ModelCase

  alias WrsPhoenix.Comment

  @valid_attrs %{date: "some content", raceId: 42, riderId: 42, text: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Comment.changeset(%Comment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comment.changeset(%Comment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
