defmodule MyApp.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :description, :text
      add :is_complete, :boolean, default: false, null: false
      add :account_id, references(:identity_accounts, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create index(:todos, [:account_id])
  end
end
