defmodule Suit do
  @type t :: :invalid | :hearts | :diamonds | :clubs | :spades

  def to_string(suit) do
    case suit do
      :invalid -> "Invalid"
      :hearts -> "Hearts"
      :diamonds -> "Diamonds"
      :clubs -> "Clubs"
      :spades -> "Spades"
    end
  end
end
