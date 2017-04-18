defmodule Rna.Web.SwitchController do
  use Rna.Web, :controller

  def show(conn, %{"ip" => ip}) do
    switch_info = Rna.Snmp.get_switch_info(ip)
    json conn, switch_info
  end
end
