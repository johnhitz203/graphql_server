defmodule GraphqlServerWeb.Schema do
  use Absinthe.Schema

  @desc "The type shop has a category 'shop_category' that categorizes it by type of goods sold"
  enum :shop_category do
    value :HARDWARE
    value :CLOTHING
  end


  @desc "A shop is a type that has a category"
  object :shop do
    field :id, :id
    field :name, :string
    field :category, :shop_category
  end

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

  query do
    field :shop, :shop do
      arg :id, non_null(:id)

      resolve fn(%{id: id}, _) ->
        id = String.to_integer(id)

        case Enum.find(@shops, &(&1.id === id)) do
          nil -> {:error, %{message: "not found", details: %{id: id}}}
          shop -> {:ok, shop}
        end
      end
    end

    field :shops, list_of(:shop) do
      arg :category, :shop_category

      resolve fn
        %{category: category}, _ ->
          case Enum.filter(@shops, &(&1.category === category)) do
            [] -> {:error, %{message: "not found", details: %{category: category}}}
            shops -> {:ok, shops}
          end
        _, _ -> {:ok, @shops}
      end
    end

  end

end
