defmodule SnipUrl.Shortner.Url do
  use Ecto.Schema

  schema "shortner_urls" do
    field :original_url, :string
    field :snip_url, :string

    timestamps()
  end
end
