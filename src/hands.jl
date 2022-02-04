
struct Hand
    tiles::Vector{SuitedTile}

    function Hand(initial_tiles::AbstractVector{<: Tile} = [])
        hand = new(initial_tiles)
        sort!(hand.tiles)

        return hand
    end
end

function Base.push!(h::Hand, item)
    push!(h.tiles, item)
    sort!(h.tiles, alg=InsertionSort())
end

function Base.show(io::IO, mime::MIME"text/plain", hand::Hand)
    for tile in hand.tiles
        show(io, mime, tile)
    end
end

