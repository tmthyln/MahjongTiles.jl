using Test
using MahjongTiles
using MahjongTiles: TilePile

@testset "equality" begin
    @test TilePile(:standard) !== TilePile(:standard)
    @test TilePile(:standard) == TilePile(:standard)
end

@testset "circular shifting" begin
    create_tilepile() = TilePile([character(4), wind(2), circle(7), bamboo(9), dragon(2), flower(1)])

    # test non-mutating circshift
    @test circshift(create_tilepile(), 0) == create_tilepile()

    @test circshift(create_tilepile(), 1) == TilePile([flower(1), character(4), wind(2), circle(7), bamboo(9), dragon(2)])
    @test circshift(create_tilepile(), -1) == TilePile([wind(2), circle(7), bamboo(9), dragon(2), flower(1), character(4)])

    @test circshift(create_tilepile(), 7) == TilePile([flower(1), character(4), wind(2), circle(7), bamboo(9), dragon(2)])
    @test circshift(create_tilepile(), -7) == TilePile([wind(2), circle(7), bamboo(9), dragon(2), flower(1), character(4)])

    @test circshift(create_tilepile(), 2) == TilePile([dragon(2), flower(1), character(4), wind(2), circle(7), bamboo(9)])
    @test circshift(create_tilepile(), -2) == TilePile([circle(7), bamboo(9), dragon(2), flower(1), character(4), wind(2)])

    @test circshift(create_tilepile(), 8) == TilePile([dragon(2), flower(1), character(4), wind(2), circle(7), bamboo(9)])
    @test circshift(create_tilepile(), -8) == TilePile([circle(7), bamboo(9), dragon(2), flower(1), character(4), wind(2)])

    # test mutating circshift
    @test circshift!(create_tilepile(), 0) == create_tilepile()

    @test circshift!(create_tilepile(), 1) == TilePile([flower(1), character(4), wind(2), circle(7), bamboo(9), dragon(2)])
    @test circshift!(create_tilepile(), -1) == TilePile([wind(2), circle(7), bamboo(9), dragon(2), flower(1), character(4)])

    @test circshift!(create_tilepile(), 7) == TilePile([flower(1), character(4), wind(2), circle(7), bamboo(9), dragon(2)])
    @test circshift!(create_tilepile(), -7) == TilePile([wind(2), circle(7), bamboo(9), dragon(2), flower(1), character(4)])

    @test circshift!(create_tilepile(), 2) == TilePile([dragon(2), flower(1), character(4), wind(2), circle(7), bamboo(9)])
    @test circshift!(create_tilepile(), -2) == TilePile([circle(7), bamboo(9), dragon(2), flower(1), character(4), wind(2)])

    @test circshift!(create_tilepile(), 8) == TilePile([dragon(2), flower(1), character(4), wind(2), circle(7), bamboo(9)])
    @test circshift!(create_tilepile(), -8) == TilePile([circle(7), bamboo(9), dragon(2), flower(1), character(4), wind(2)])

    # test that the tilepile itself is returned as the modified tilepile
    tilepile = create_tilepile()
    @test circshift!(tilepile, 3) == tilepile
end
