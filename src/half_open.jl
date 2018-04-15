struct RightOpen{T<:SupportedInts}
    lo::T
    hi::T
end

struct RightOpenStep{T<:SupportedInts}
    lo::T
    hi::T
    step::T
end

struct LeftOpen{T<:SupportedInts}
    lo::T
    hi::T
end

const HalfOpen{T} = Union{LeftOpen{T},RightOpen{T},RightOpenStep{T}}

# Just for clarity make this its own type
struct RangeState{T<:SupportedInts}
    lo::T
    hi::T
end

# Will never overflow in the case of half-open ranges :)
length(r::HalfOpen) = (unsigned(r.hi) - unsigned(r.lo)) % UInt

## Iteration
start(r::HalfOpen) = RangeState(r.lo, r.hi)
done(r::HalfOpen, s::RangeState) = s.lo >= s.hi

# Forward iteration
next(r::RightOpen{T}, s::RangeState) where {T} =
    (s.lo, RangeState(s.lo + T(1), s.hi))

next(r::LeftOpen{T}, s::RangeState) where {T} =
    (s.lo + T(1), RangeState(s.lo + T(1), s.hi))

# Backward iteration
next_back(::RightOpen{T}, s::RangeState) where {T} =
    (s.hi - T(1), RangeState(s.lo, s.hi - T(1)))

next_back(r::LeftOpen{T}, s::RangeState) where {T} =
    (s.hi, RangeState(s.lo, s.hi - T(1)))

## step ranges

next(r::RightOpenStep{T}, s::RangeState) where {T} =
    (s.lo, RangeState(s.lo + r.step, s.hi))

next_back(r::RightOpenStep{T}, s::RangeState) where {T} =
    (s.hi - r.step, RangeState(s.lo, s.hi - r.step))