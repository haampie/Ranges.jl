struct HalfOpen{T<:SupportedInts}
    lo::T
    hi::T
end

# Just for clarity make this its own type
struct HalfOpenState{T<:SupportedInts}
    lo::T
    hi::T
end

# Constructor that ensures lo ≤ hi
to(lo::T, hi::T) where {T<:SupportedInts} = HalfOpen(lo, max(lo, hi))
to(lo, hi) = →(promote(lo, hi)...)

# Will never overflow in the case of half-open ranges :)
length(r::HalfOpen) = (unsigned(r.hi) - unsigned(r.lo)) % UInt

## Iteration
start(r::HalfOpen) = HalfOpenState(r.lo, r.hi)
done(r::HalfOpen, s::HalfOpenState) = s.lo == s.hi

# Forward iteration
function next(r::HalfOpen{T}, s::HalfOpenState) where {T}
    return (s.lo, HalfOpenState(s.lo + T(1), s.hi))
end

# Backward
function next_back(::HalfOpen{T}, s::HalfOpenState) where {T}
    return (s.hi - T(1), HalfOpenState(s.lo, s.hi - T(1)))
end

