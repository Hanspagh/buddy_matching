defmodule LolBuddy.PlayerServer.Supervisor do
  use Supervisor
  alias LolBuddy.PlayerServer

  @doc """
  Default constructor for PlayerServer, in which case
  we name the PlayerServer based on the module
    """
  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @doc """
  Starts a PlayerServer with potential options.
    """
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Define all the child specs for the various regions
  and start them all with one_for_one strategy.
    """
  def init(:ok) do
    children = [
      Supervisor.child_spec({PlayerServer, name: :br}, id: :worker_br),
      Supervisor.child_spec({PlayerServer, name: :eune}, id: :worker_eune),
      Supervisor.child_spec({PlayerServer, name: :euw}, id: :worker_euw),
      Supervisor.child_spec({PlayerServer, name: :jp}, id: :worker_jp),
      Supervisor.child_spec({PlayerServer, name: :kr}, id: :worker_kr),
      Supervisor.child_spec({PlayerServer, name: :lan}, id: :worker_lan),
      Supervisor.child_spec({PlayerServer, name: :las}, id: :worker_las),
      Supervisor.child_spec({PlayerServer, name: :na}, id: :worker_na),
      Supervisor.child_spec({PlayerServer, name: :oce}, id: :worker_oce),
      Supervisor.child_spec({PlayerServer, name: :tr}, id: :worker_tr),
      Supervisor.child_spec({PlayerServer, name: :ru}, id: :worker_ru),
      Supervisor.child_spec({PlayerServer, name: :pbe}, id: :worker_pbe)
    ]

    # only restart the the single broken processor
    Supervisor.init(children, strategy: :one_for_one)
  end
end