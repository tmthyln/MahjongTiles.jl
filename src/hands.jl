using DataStructures

"""
Represents the tiles in a single player's hand.
"""
struct Hand
    tiles::Vector{SuitedTile}
    hidden::Vector{SuitedTile}
    exposed::Vector{SuitedTile}

    @doc """
        Hand()
        Hand(tiles)
    
    Create an empty hand, or one that starts off with the `tiles` given (all hidden).

    ## Example
    
    ```jldoctest
    julia> using MahjongTiles: character, wind, bamboo, Hand
    
    julia> Hand([character(1), character(2), wind(:north), bamboo(5)])
    🀃🀇🀈🀔
    ```
    """
    function Hand(initial_tiles::AbstractVector{<: Tile} = [])
        hidden_tiles = sort!(initial_tiles)
        return new(hidden_tiles, hidden_tiles, SuitedTile[])
    end
end

@doc """
    push_hidden!(hand, tiles...)
    Base.push!(hand, tiles...)

Add a tile or `tiles` to the hidden part of the hand.
"""
function push_hidden!(hand::Hand, tile...)
    push!(hand.hidden, tile...)
    push!(hand.tiles, tile...)
    sort!(hand.hidden, alg=InsertionSort())
    sort!(hand.tiles, alg=InsertionSort())

    return hand
end
Base.push!(hand::Hand, tile...) = push_hidden!(hand, tile)

@doc """
    push_exposed!(hand, tiles...)

Add a tile or `tiles` to the open/exposed part of the hand.
"""
function push_exposed!(hand::Hand, tile...)
    push!(hand.exposed, tile...)
    push!(hand.tiles, tile...)
    sort!(hand.exposed, alg=InsertionSort())
    sort!(hand.tiles, alg=InsertionSort())

    return hand
end

@doc """
    expose!(hand, tiles...)

Expose/make open the tiles from the hand.
"""
function expose!(hand::Hand, tiles...)
    

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

Determine whether the hand consists of a single suit (一色),
which can include non-suits like winds or flowers.
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

@doc """
    has_dragon_triple(hand)

Determine whether the hand has a triple of any one of the three dragon tiles.

## Example

```jldoctest
julia> using MahjongTiles: dragon, wind, bamboo, Hand, has_dragon_triple

julia> has_dragon_triple(Hand([dragon(:red), dragon(:red), dragon(:red), bamboo(2), wind(:east)]))
true

julia> has_dragon_triple(Hand([dragon(:red), dragon(:red), dragon(:green), dragon(:white)]))
false
```
"""
function has_dragon_triple(hand::Hand)
    counts = counter(hand.tiles)
    return counts[dragon(:red)] >= 3 || counts[dragon(:green)] >= 3 || counts[dragon(:white)] >= 3
end
