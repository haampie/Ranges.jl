using Ranges
using Base: Test

@testset "Length" begin
    # Conversion of length UInt
    @test length(HalfOpen(0x00, 0xff)) === UInt(255)

    # No overflows
    @test length(HalfOpen(typemin(Int), typemax(Int))) === typemax(UInt)

    # Reverse should be as long
    @test length(Reverse(HalfOpen(0, 10))) == length(HalfOpen(0, 10))
end

@testset "Iteration" begin
    for IntT in (UInt8, Int8, Int16, UInt16, Int, UInt)
        counter = IntT(0)
        for i = HalfOpen(IntT(0), IntT(10))
            @test counter === i
            counter += IntT(1)
        end
    end
end

@testset "Reverse iteration" begin
    for IntT in (UInt8, Int8, Int16, UInt16, Int, UInt)
        counter = IntT(9)
        for i = Reverse(HalfOpen(IntT(0), IntT(10)))
            @test counter === i
            counter -= IntT(1)
        end
    end
end
