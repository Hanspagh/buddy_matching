defmodule LolBuddyWeb.PlayersChannel do
  use LolBuddyWeb, :channel
  alias LolBuddy.Players.Player
  alias LolBuddy.Players


  @doc """
  Each clients joins their own player channel players:cookie_id 
  """
  #TODO auth users
  def join("players:" <> cookie_id, _, socket) do
      socket = assign(socket, :user, %Player{id: cookie_id})
      send(self(), {:on_join, {}})
      {:ok, socket}
  end

  @doc """
  On join we find players mathing the newly joined player,
  return the list of mathing players to the newly joined player
  and notifies each of the mathing players about the newly joined players aswell
  """
  def handle_info({:on_join, _msg}, socket) do
    #TODO ask the genserver for joined players
    matching_players = Players.find_matches(socket.assigns[:user], [])
    #TODO store the the newly joined player in the genserver

    #Send all macthin players
    push socket, "new_players", %{players: matching_players}
    
    #Send the newly joined user to all matching players
    Enum.each(matching_players, fn player ->
      LolBuddyWeb.Endpoint.broadcast! "player:"<> player.id, "new_player", socket.assigns[:user,]
    end)

    
    {:noreply, socket}
  end

end
