defmodule MyAppWeb.TodoController do
  use MyAppWeb, :controller

  alias MyApp.Todos
  alias MyApp.Todos.Todo
  alias MyApp.Identity.Guardian

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    todos = Todos.list_todos(Guardian.Plug.current_resource(conn))
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    account = Guardian.Plug.current_resource(conn)
    with {:ok, %Todo{} = todo} <- Todos.create_todo(account, todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Guardian.Plug.current_resource(conn)
    todo = Todos.get_todo!(account, id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    account = Guardian.Plug.current_resource(conn)
    todo = Todos.get_todo!(account, id)

    with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Guardian.Plug.current_resource(conn)
    todo = Todos.get_todo!(account, id)

    with {:ok, %Todo{}} <- Todos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
