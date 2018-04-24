defmodule BuddyMatching.Players.Criteria.FortniteCriteria do
  @moduledoc """
  Struct definining the possible criterias with which Fortnite
  Players can filter their matches.
  """
  alias BuddyMatching.Players.Info.FortniteInfo
  alias BuddyMatching.Players.Criteria
  @behaviour Criteria

  defstruct positions: [], voice: [], age_groups: [], ignore_language: false

  @doc """
  Parses the checkbox format the frontend uses for criteria
  into the criteria struct used in the backend.
  """
  def from_json(data) do
    {:ok, %BuddyMatching.Players.Criteria.FortniteCriteria{}}
  end
end