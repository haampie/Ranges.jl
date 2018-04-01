# Constructor that ensures lo ≤ hi
to(lo::T, hi::T) where {T<:SupportedInts} = RightOpen(lo, max(lo, hi))
to(lo, hi) = →(promote(lo, hi)...)

