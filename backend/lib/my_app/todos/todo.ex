defmodule MyApp.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyApp.Identity.Account

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todos" do
    field :title, :string
    field :description, :string
    field :is_complete, :boolean, default: false
    # field :account, :binary_id
    belongs_to :account, Account

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :description, :is_complete])
    |> validate_required([:title])
    |> validate_length(:title, max: 32)
    |> validate_length(:description, max: 200)
  end
end
