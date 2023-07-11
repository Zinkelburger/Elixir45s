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

  def is_ace_of_hearts?({1, :hearts}), do: true
  def is_ace_of_hearts?(_), do: false

end
