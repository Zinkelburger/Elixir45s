defmodule Player do
  defstruct number: nil

  @callback discard(player_leading :: integer(), bid_amount :: integer(), trump :: any()) ::
              :ok

  @doc """
  Returns {bid_amount, suit}. Parameters are bid_amount, player_number
  """
  @callback get_bid(bid_history :: [{integer(), integer()}]) ::
              {integer(), Suit.t()}

  @callback bagged() ::
              Suit.t()

  @callback play_card(
              cards_played_this_hand :: [Card.t()],
              suit_led :: Suit.t(),
              trump :: Suit.t(),
              legal_cards :: [Card.t()]
            ) ::
              Card.t()
end
