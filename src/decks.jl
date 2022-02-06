using Random

"""
A pile of tiles. 
An abstraction for a collection of Mahjong tiles, similar to a deque.

Some properties:
- ordered and unsorted
- size only strictly decreases once created
"""
struct TilePile
    tiles::Vector{SuitedTile}
end

@doc """
    TilePile(tiles)
    TilePile(name)

Create a particular predefined/standard `TilePile` given the `name`, or
create the `TilePile` from a specific list of tiles.

## Supported Names

### `:standard`

4 of each numbered tile from the 3 suits, plus 4 of each wind, 4 of each dragon, and the 8 flowers/seasons

"""
function TilePile(type::Symbol)
    if type == :standard
        tiles = [
            SuitedTile(suit, i)
            for suit in all_suits
            for i in 1:max_number(suit)
            for _ in 1:typical_duplication(suit)
        ]
    else
        @warn "Not a recognized type of Mahjong game (don't know how to create a pile for it)"
        tiles = []
    end

    return TilePile(tiles)
end

Base.length(tp::TilePile) = length(tp.tiles)
Base.first(tp::TilePile) = first(tp.tiles)
Base.first(tp::TilePile, n::Integer) = first(tp.tiles, n)
Base.last(tp::TilePile) = last(tp.tiles)
Base.last(tp::TilePile, n::Integer) = last(tp.tiles, n)

"""
    popfirst!(tilepile)

Remove the "first" tile from the tile pile.
Removing from this end is intended to be used for flower/four-of-a-kind replacement
(this is to improve average performance).
"""
Base.popfirst!(tp::TilePile) = popfirst!(tp.tiles)

"""
    popfirst!(tilepile, num_tiles)

Remove the "first" `num_tiles` tiles from the tile pile as an array.
Removing from this end is intended to be used for flower/four-of-a-kind replacement
(this is to improve average performance).
"""
function Base.popfirst!(tp::TilePile, n::Integer)
    n < 0 && throw("cannot pop fewer than 0 tiles")

    return splice!(tp.tiles, 1:min(n, lastindex(tp.tiles)))
end

"""
    pop!(tilepile)

Remove a tile from the end of the tile pile.
Removing from this end is used for the usual pickup of tiles from the deck
(not for flower/four-of-a-kind replacement).
"""
Base.pop!(tp::TilePile) = pop!(tp.tiles)

"""
    pop!(tilepile, num_tiles)

Remove `num_tiles` tiles from the end of the tile pile as an array.
Removing from this end is used for the usual pickup of tiles from the deck
(not for flower/four-of-a-kind replacement).
"""
function Base.pop!(tp::TilePile, n::Integer)
    n < 0 && throw("cannot pop fewer than 0 tiles")

    return splice!(tp.tiles, max(1, lastindex(tp.tiles) - n + 1):lastindex(tp.tiles))
end
Random.shuffle!(tp::TilePile) = shuffle!(tp.tiles)
Random.shuffle!(rng, tp::TilePile) = shuffle!(rng, tp.tiles)

Base.circshift(tp::TilePile, shift) = TilePile(circshift(tp.tiles, shift))


function deal_tiles(tp::TilePile; quadruple_rounds=3, single_rounds=1)
    player_hands = [SuitedTile[] for _ in 1:4]
    for _ in 1:quadruple_rounds, player in 1:4
        append!(player_hands[player], pop!(tp, 4))
    end
    for _ in 1:single_rounds, player in 1:4
        push!(player_hands[player], pop!(tp))
    end
    push!(first(player_hands), pop!(tp))

    return Hand.(player_hands)
end
