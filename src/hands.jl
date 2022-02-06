
"""
Represents the tiles in a single player's hand.
"""
struct Hand
    tiles::Vector{SuitedTile}

    @doc """
        Hand()
        Hand(tiles)
    
    Create an empty hand, or one that starts off with the `tiles` given.

    ## Example
    
    ```jldoctest
    julia> using MahjongTiles: character, wind, bamboo, Hand
    
    julia> Hand([character(1), character(2), wind(:north), bamboo(5)])
    🀃🀇🀈🀔
    ```
    """
    function Hand(initial_tiles::AbstractVector{<: Tile} = [])
        hand = new(initial_tiles)
        sort!(hand.tiles)

        return hand
    end
end

function Base.push!(h::Hand, item...)
    push!(h.tiles, item...)
    sort!(h.tiles, alg=InsertionSort())
end

Base.first(hand::Hand) = first(hand.tiles)
Base.first(hand::Hand, num::Integer) = first(hand.tiles, num)

Base.iterate(hand::Hand) = iterate(hand.tiles)
Base.iterate(hand::Hand, state) = iterate(hand.tiles, state)

function Base.show(io::IO, mime::MIME"text/plain", hand::Hand)
    for tile in hand.tiles
        show(io, mime, tile)
    end
end

@doc """
    is_pure(hand)

Determine whether the hand is pure (清).
A hand is considered pure if there are no winds or dragons.

## Example

```jldoctest
julia> using MahjongTiles: wind, character, dragon, bamboo, circle, Hand, is_pure

julia> is_pure(Hand([wind(:east), character(3)]))
false

julia> is_pure(Hand([character(3), dragon(:green)]))
false

julia> is_pure(Hand([bamboo(8), character(3), circle(1)]))
true
```
"""
function is_pure(hand::Hand)
    return all(!is_suit(tile, Wind) && !is_suit(tile, Dragon) for tile in hand)
end

@doc """
    is_single_suit(hand)

Determine whether the hand consists of a single suit
(can include non-suits like winds or flowers).
To determine if the hand is only exactly a single suit,
excluding winds, dragons, and flowers/seasons,
combine this function with `is_pure`.

## Example

```jldoctest
julia> using MahjongTiles: wind, flower, character, circle, bamboo, Hand, is_single_suit

julia> is_single_suit(Hand([character(1), character(4), character(8), flower(3)]))
true

julia> is_single_suit(Hand([character(5), circle(5), bamboo(5)]))
false

julia> is_single_suit(Hand([circle(1), circle(7), wind(:north), wind(:east)]))
true
```
"""
function is_single_suit(hand::Hand)
    only_suit = suit(first(hand))
    return all(suit(tile) == only_suit || suit(tile) in (Wind, Dragon, Flower, Season) for tile in hand)
end
