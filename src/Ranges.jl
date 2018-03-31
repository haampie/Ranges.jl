module Ranges

import Base: start, next, done, length

export HalfOpen, Reverse

const SupportedInts = Union{Int8,Int16,Int32,Int64,UInt8,UInt16,UInt32,UInt64}

include("reverse.jl")
include("half_open.jl")


end