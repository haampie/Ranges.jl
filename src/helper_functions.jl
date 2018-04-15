struct Until end
struct DownUntil end

export until, downuntil

const until = Until()
const downuntil = DownUntil()

(:)(lo::T, ::Until, hi::T) where {T<:SupportedInts} = RightOpen(lo, max(lo, hi))
(:)(hi::T, ::DownUntil, lo::T) where {T<:SupportedInts} = Reverse(LeftOpen(min(lo, hi), hi))
