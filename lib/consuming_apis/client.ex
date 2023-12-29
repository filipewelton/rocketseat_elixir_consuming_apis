defmodule ConsumingApis.Client do
  use Tesla

  alias Tesla.Env

  @base_url "https://api.github.com/users"

  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def get_repositories(url \\ @base_url, username) do
    url = "#{url}/#{username}/repos"

    get(url)
    |> handle()
  end

  defp handle({:ok, %Env{body: body}}) do
    response = Enum.map(body, &filter/1)
    {:ok, response}
  end

  defp filter(repo) do
    id = Map.get(repo, "id")
    name = Map.get(repo, "name")
    description = Map.get(repo, "description")
    html_url = Map.get(repo, "html_url")
    stargazers_count = Map.get(repo, "stargazers_count")

    %{
      "id" => id,
      "name" => name,
      "description" => description,
      "html_url" => html_url,
      "stargazers_count" => stargazers_count
    }
  end
end
