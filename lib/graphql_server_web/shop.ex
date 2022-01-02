defmodule GraphqlServerWeb.Shop do
  @shops [
    %{
      id: 1,
      name: "Cloths Shop",
      category: :CLOTHING
    },
    %{
      id: 2,
      name: "Custom Cloths Shop",
      category: :CLOTHING
    },
    %{
      id: 3,
      name: "Tool Shop",
      category: :HARDWARE
    },
    %{
      id: 4,
      name: "Custom Tool Shop",
      category: :HARDWARE
    }
  ]

  def all(%{category: category}) do
    case Enum.filter(@shops, &(&1.category === category)) do
      [] -> {:error, %{message: "not found", details: %{category: category}}}
      shops -> {:ok, shops}
    end
  end

  def all(_) do
    {:ok, @shops}
  end

  def find(%{id: id}) do
    case Enum.find(@shops, &(&1.id === id)) do
      nil -> {:error, %{message: "not found", details: %{id: id}}}
      shop -> {:ok, shop}
    end
  end
end
