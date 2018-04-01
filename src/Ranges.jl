module Ranges

import Base: start, next, done, length

export HalfOpen, Reverse, rev, to

const SmallInts = Union{Int8,Int16,Int32,UInt8,UInt16,UInt32}
const SupportedInts = Int == Int64 ? Union{SmallInts,Int64,UInt64} : SmallInts

include("reverse.jl")
include("half_open.jl")
include("show.jl")

end