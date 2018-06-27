defmodule HierarchTest do
  use Hierarch.TestCase, async: true

  doctest Hierarch

  setup_all do
    catelogs = create_catelogs()
    {:ok, catelogs}
  end

  describe "parent/1" do
    test "returns its parent", catelogs do
      science = Map.get(catelogs, "Top.Science")
      top     = Map.get(catelogs, "Top")

      parent = science
               |> Catelog.parent
               |> Repo.one
      assert parent == top
    end

    test "returns nil if it is the root", catelogs do
      top = Map.get(catelogs, "Top")

      parent = top
               |> Catelog.parent
               |> Repo.one
      assert is_nil(parent)
    end
  end

  describe "ancestors/1" do
    test "returns its ancestors", catelogs do
      top       = Map.get(catelogs, "Top")
      science   = Map.get(catelogs, "Top.Science")
      astronomy = Map.get(catelogs, "Top.Science.Astronomy")

      ancestors = astronomy
                  |> Catelog.ancestors
                  |> Repo.all
      assert ancestors == [top, science]
    end

    test "returns blank array if it is the root", catelogs do
      top = Map.get(catelogs, "Top")

      ancestors = top
                  |> Catelog.ancestors
                  |> Repo.all
      assert ancestors == []
    end
  end
end
