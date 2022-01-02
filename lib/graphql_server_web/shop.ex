defmodule GraphqlServerWeb.Shop do
  @shops [
    %{
      id: 1,
      name: "Cloths Shop",
      category: :CLOTHING,
      address: %{
        country: "USA",
        city: "New York"
      }
    },
    %{
      id: 2,
      name: "Custom Cloths Shop",
      category: :CLOTHING,
      address: %{
        country: "USA",
        city: "Chicago"
      }
    },
    %{
      id: 3,
      name: "Tool Shop",
      category: :HARDWARE,
      address: %{
        country: "USA",
        city: "Denver"
      }
    },
    %{
      id: 4,
      name: "Custom Tool Shop",
      category: :HARDWARE,
      address: %{
        country: "USA",
        city: "New York"
      }
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

  def update(id, params) do
    with {:ok, shop} <- find(%{id: id}) do
      {:ok, Map.merge(shop, params)}
    end
  end
end
