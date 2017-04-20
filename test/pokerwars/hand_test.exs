defmodule Pokerwars.HandTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates royal flush of hearts" do
    cards = [
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 11, suit: :hearts},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 13, suit: :hearts},
      %Card{rank: 14, suit: :hearts}
    ]

    assert Hand.score(cards) == :royal_flush
  end

  test "evaluates royal flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 12, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 14, suit: :spades}
    ]

    assert Hand.score(cards) == :royal_flush
  end

  test "does not evaluate royal flush for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 14, suit: :clubs}
    ]

    assert Hand.score(cards) != :royal_flush
  end

  test "evaluates straight flush 2-6 hearts" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 6, suit: :hearts}
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "evaluates four of a kind of 4s" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 4, suit: :diamonds},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 4, suit: :clubs},
      %Card{rank: 4, suit: :spades}
    ]

    assert Hand.score(cards) == :four_of_a_kind
  end

  test "evaluates full house 2s and 3s" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 2, suit: :diamonds},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 3, suit: :clubs},
      %Card{rank: 3, suit: :spades}
    ]

    assert Hand.score(cards) == :full_house
  end

  test "evaluates flush hearts" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 7, suit: :hearts}
    ]

    assert Hand.score(cards) == :flush
  end

  test "evaluates straight 2-6" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 5, suit: :spades},
      %Card{rank: 6, suit: :clubs}
    ]

    assert Hand.score(cards) == :straight
  end

  test "evaluates 3 of a kind of 2s" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 2, suit: :diamonds},
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 4, suit: :clubs}
    ]

    assert Hand.score(cards) == :three_of_a_kind
  end

  test "evaluates 2 pairs of 2s and 3s" do
    cards = [
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 2, suit: :clubs}
    ]

    assert Hand.score(cards) == :two_pair
  end

  test "evaluates pair of 2s" do
    cards = [
      %Card{rank: 2, suit: :clubs},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 2, suit: :clubs}
    ]

    assert Hand.score(cards) == :pair
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades}
    ]

    assert Hand.score(cards) == :high_card
  end
end
