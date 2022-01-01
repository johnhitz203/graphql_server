defmodule GraphqlServerWeb.Router do
  use GraphqlServerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/api", GraphqlServerWeb do
  #   pipe_through :api
  # end

  scope "/" do
    pipe_through :api

    if Mix.env() === :dev do
      forward "/graphql", Absinthe.Plug,
        schema: GraphqlServerWeb.Schema

        forward "/graphiql", Absinthe.Plug.GraphiQL,
          schema: GraphqlServerWeb.Schema,
          interface: :playground
    end
  end
end
