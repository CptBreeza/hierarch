defmodule Hierarch.MixProject do
  use Mix.Project

  @project_url "https://github.com/GreenNerd-Labs/hierarch"
  @version "0.1.2"

  def project do
    [
      app: :hierarch,
      version: @version,
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      source_url: @project_url,
      homepage_url: @project_url,
      description: description(),
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [extra_applications: application(Mix.env)]
  end
  defp application(:test), do: [:postgrex, :ecto, :logger]
  defp application(_), do: [:logger]

  defp elixirc_paths(:test), do: elixirc_paths() ++ ["test/support"]
  defp elixirc_paths(_),     do: elixirc_paths()
  defp elixirc_paths,        do: ["lib"]

  defp deps do
    [
      {:ecto, ">= 2.0.0"},
      {:postgrex, ">= 0.13.0"},
      {:junit_formatter, ">= 0.0.0", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description() do
    "Hierarchy structure for ecto models with PostgreSQL LTree."
  end

  defp package() do
    [
      name: :hierarch,
      files: ["lib", "mix.exs", "README*", "MIT-LICENSE"],
      maintainers: ["Phil Chen"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url}
    ]
  end

  defp aliases do
    [
      "test": ["ecto.drop --quite", "ecto.create --quite", "ecto.migrate --quite", "test"]
    ]
  end
end
