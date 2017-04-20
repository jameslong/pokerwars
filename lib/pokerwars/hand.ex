defmodule Pokerwars.Hand do
  alias Pokerwars.Card

  def score(cards) do
    cards
    |> Enum.sort()
    |> evaluate()
  end

  defp evaluate(hand) do
    cond do
      royal_flush?(hand) -> :royal_flush
      straight_flush?(hand) -> :straight_flush
      four_of_a_kind?(hand) -> :four_of_a_kind
      full_house?(hand) -> :full_house
      flush?(hand) -> :flush
      straight?(hand) -> :straight
      three_of_a_kind?(hand) -> :three_of_a_kind
      two_pair?(hand) -> :two_pair
      pair?(hand) -> :pair
      true -> :high_card
    end
  end

  defp royal_flush?(
    [%Card{rank: 10, suit: suit},
     %Card{rank: 11, suit: suit},
     %Card{rank: 12, suit: suit},
     %Card{rank: 13, suit: suit},
     %Card{rank: 14, suit: suit}]
  ), do: true
  defp royal_flush?(_), do: false

  defp straight_flush?(hand) do
    straight?(hand) and flush?(hand)
  end

  defp four_of_a_kind?(hand) do
    ranks = extract_ranks(hand)
    case ranks do
      [a, a, a, a, _b] -> true
      [_a, b, b, b, b] -> true
      _ -> false
    end
  end

  defp full_house?(hand) do
    ranks = extract_ranks(hand)
    case ranks do
      [a, a, b, b, b] -> true
      [a, a, a, b, b] -> true
      _ -> false
    end
  end

  defp flush?(hand), do: matching_suit?(hand)

  defp straight?(hand) do
    hand
    |> extract_ranks()
    |> consecutive?()
  end

  defp three_of_a_kind?(hand) do
    ranks = extract_ranks(hand)
    case ranks do
      [a, a, a, _b, _c] -> true
      [_a, b, b, b, _c] -> true
      [_a, _b, c, c, c] -> true
      _ -> false
    end
  end

  defp two_pair?(hand) do
    ranks = extract_ranks(hand)
    case ranks do
      [a, a, b, b, _d] -> true
      [a, a, _b, c, c] -> true
      [_a, b, b, c, c] -> true
      _ -> false
    end
  end

  defp pair?(hand) do
    ranks = extract_ranks(hand)
    case ranks do
      [a, a, _b, _c, _d] -> true
      [_a, b, b, _c, _d] -> true
      [_a, _b, c, c, _d] -> true
      [_a, _b, _c, d, d] -> true
      _ -> false
    end
  end

  defp extract_ranks(hand) do
    Enum.map(hand, &(&1.rank))
  end

  defp consecutive?([_a]), do: true
  defp consecutive?([a | [b | t]]) do
   a + 1 == b and consecutive?([b | t])
  end

  defp matching_suit?(
    [%Card{rank: _, suit: suit},
     %Card{rank: _, suit: suit},
     %Card{rank: _, suit: suit},
     %Card{rank: _, suit: suit},
     %Card{rank: _, suit: suit}]
  ), do: true
  defp matching_suit?(_), do: false
end
