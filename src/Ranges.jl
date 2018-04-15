module Ranges

import Base: start, next, done, length, (:)

export LeftOpen, RightOpen, Reverse, rev

const SmallInts = (Int8,Int16,Int32,UInt8,UInt16,UInt32)
const AllInts = Int == Int64 ? (SmallInts...,Int64,UInt64) : SmallInts
const SupportedInts = Union{AllInts...}

include("reverse.jl")
include("half_open.jl")
include("helper_functions.jl")
include("show.jl")

end