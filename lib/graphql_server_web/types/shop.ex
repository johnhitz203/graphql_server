defmodule GraphqlServerWeb.Type.Shop do
  use Absinthe.Schema.Notation

  @desc "The type shop has a category 'shop_category' that categorizes it by type of goods sold"
  enum :shop_category do
    value :HARDWARE
    value :CLOTHING
  end

  object :shop_address do
    field :country, :string
    field :city, :string
  end


  @desc "A shop is a type that has a category"
  object :shop do
    field :id, :id
    field :name, :string
    field :category, :shop_category

    field :address, :shop_address
  end
end
