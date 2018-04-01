struct RightOpen{T<:SupportedInts}
    lo::T
    hi::T
end

struct LeftOpen{T<:SupportedInts}
    lo::T
    hi::T
end

const HalfOpen{T} = Union{LeftOpen{T},RightOpen{T}}

# Just for clarity make this its own type
struct RangeState{T<:SupportedInts}
    lo::T
    hi::T
end

# Will never overflow in the case of half-open ranges :)
length(r::HalfOpen) = (unsigned(r.hi) - unsigned(r.lo)) % UInt

## Iteration
start(r::HalfOpen) = RangeState(r.lo, r.hi)
done(r::HalfOpen, s::RangeState) = s.lo == s.hi

# Forward iteration
function next(r::RightOpen{T}, s::RangeState) where {T}
    return (s.lo, RangeState(s.lo + T(1), s.hi))
end

function next(r::LeftOpen{T}, s::RangeState) where {T}
    return (s.lo + T(1), RangeState(s.lo + T(1), s.hi))
end

# Backward iteration
function next_back(::RightOpen{T}, s::RangeState) where {T}
    return (s.hi - T(1), RangeState(s.lo, s.hi - T(1)))
end

function next_back(r::LeftOpen{T}, s::RangeState) where {T}
    return (s.hi, RangeState(s.lo, s.hi - T(1)))
end
