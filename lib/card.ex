defmodule Card do
  @type t :: {integer(), Suit.t()}

  defstruct value: -1000, suit: :invalid

  def new(value \\ -1000, suit \\ :invalid) do
    %__MODULE__{value: value, suit: suit}
  end

  def to_string(card) do
    value_string =
      case card.value do
        13 -> "King"
        12 -> "Queen"
        11 -> "Jack"
        1 -> "Ace"
        _ -> Integer.to_string(card.value)
      end

    suit_string = Suit.to_string(card.suit)

    "#{value_string} of #{suit_string}"
  end

  @doc """
  whether or not the card is the ace of hearts
  """
  @spec is_ace_of_hearts?(Card.t()) :: boolean()
  def is_ace_of_hearts?({1, :hearts}), do: true
  def is_ace_of_hearts?(_), do: false

  def eval_trump({suit, value}, trump) do
    case {suit, value} do
      {^trump, 5} -> 17
      {^trump, 11} -> 16
      {:hearts, 1} -> 15
      {^trump, 1} -> 14
      {^trump, 13} -> 13
      {^trump, 12} -> 12
      {suit, n} when suit in [:spades, :clubs] and n in [2,3,4,6,7,8,9,10] -> 11 - n
      _ -> value
    end
  end

  def eval_offsuite({suit, value}) do
    case {suit, value} do
      {suit, n} when suit in [:spades, :clubs] and n in [1,2,3,4,5,6,7,8,9,10] -> 11 - n
      _ -> value
    end
  end

  @doc """
  returns card1 < card2, requires suit_led and trump
  """
  @spec less_than(Card.t(), Card.t(), Suit.t(), Suit.t()) :: boolean()
  def less_than({suit1, value1}, {suit2, value2}, suit_led, trump) do
    cond do
      # ace of hearts
      Card.is_ace_of_hearts?({suit1, value1}) and suit2 == trump -> eval_trump({suit1, value1}, trump) < eval_trump({suit2, value2}, trump)
      Card.is_ace_of_hearts?({suit1, value1}) and suit2 != trump -> false
      suit1 == trump and Card.is_ace_of_hearts?({suit2, value2}) -> eval_trump({suit1, value1}, trump) < eval_trump({suit2, value2}, trump)
      suit1 != trump and Card.is_ace_of_hearts?({suit2, value2}) -> true
      # trump
      suit1 == trump and suit2 != trump -> false
      suit1 != trump and suit2 == trump -> true
      suit1 == trump and suit2 == trump -> eval_trump({suit1, value1}, trump) < eval_trump({suit2, value2}, trump)
      # offsuit
      suit1 == suit_led and suit2 != suit_led -> false
      suit1 != suit_led and suit2 == suit_led -> true
      suit1 == suit_led and suit2 == suit_led -> eval_offsuite({suit1, value1}) < eval_offsuite({suit2, value2})
      true -> :error
    end
  end
end
