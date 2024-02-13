defmodule CurrencyTraderWeb.ErrorJSONTest do
  use CurrencyTraderWeb.ConnCase, async: true

  test "renders 404" do
    assert CurrencyTraderWeb.ErrorJSON.render("404.json", %{}) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "renders 500" do
    assert CurrencyTraderWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
