defmodule Rna.Web.SwitchController do
  use Rna.Web, :controller

  def show(conn, %{"ip" => ip}) do
    switch_info = Rna.Snmp.get_switch_info(ip) |> Poison.encode!
    json conn, switch_info
  end
end
