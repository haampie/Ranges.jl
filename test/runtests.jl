using Ranges
using Base: Test

@testset "Length" begin
    # Conversion of length UInt
    @test length(RightOpen(0x00, 0xff)) === UInt(255)
    @test length(LeftOpen(0x00, 0xff)) === UInt(255)

    # No overflows
    @test length(RightOpen(typemin(Int), typemax(Int))) === typemax(UInt)
    @test length(LeftOpen(typemin(Int), typemax(Int))) === typemax(UInt)

    # Reverse should be as long
    @test length(Reverse(RightOpen(0, 10))) == length(RightOpen(0, 10))
    @test length(Reverse(LeftOpen(0, 10))) == length(LeftOpen(0, 10))
end

@testset "Iteration" begin
    for IntT in Ranges.AllInts
        begin
            counter = IntT(0)
            for i = RightOpen(IntT(0), IntT(10))
                @test counter === i
                counter += IntT(1)
            end
        end

        begin
            counter = IntT(1)
            for i = LeftOpen(IntT(0), IntT(10))
                @test counter === i
                counter += IntT(1)
            end
        end
    end
end

@testset "Reverse iteration" begin
    for IntT in Ranges.AllInts
        begin
            counter = IntT(9)
            for i = Reverse(RightOpen(IntT(0), IntT(10)))
                @test counter === i
                counter -= IntT(1)
            end
        end

        begin
            counter = IntT(10)
            for i = Reverse(LeftOpen(IntT(0), IntT(10)))
                @test counter === i
                counter -= IntT(1)
            end
        end
    end
end
