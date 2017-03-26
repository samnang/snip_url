defmodule SnipUrl.Repo.Migrations.CreateSnipUrl.Shortner.Url do
  use Ecto.Migration

  def change do
    create table(:shortner_urls) do
      add :original_url, :text
      add :snip_url, :string

      timestamps()
    end

  end
end
