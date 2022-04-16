using Test
using MahjongTiles

@testset "tile function aliases" begin
    @test all([🀇, 🀈, 🀉, 🀊, 🀋, 🀌, 🀍, 🀎, 🀏] .== character.(1:9))
    @test all([🀐, 🀑, 🀒, 🀓, 🀔, 🀕, 🀖, 🀗, 🀘] .== bamboo.(1:9))
    @test all([🀙, 🀚, 🀛, 🀜, 🀝, 🀞, 🀟, 🀠, 🀡] .== circle.(1:9))

    @test all([🀀, 🀁, 🀂, 🀃] .== wind.(1:4))
    @test all([🀄, 🀅, 🀆] .== dragon.(1:3))
    @test all([🀢, 🀣, 🀤, 🀥] .== flower.(1:4))
    @test all([🀦, 🀧, 🀨, 🀩] .== season.(1:4))
end
