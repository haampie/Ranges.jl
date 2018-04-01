import Base: show

show(io::IO, r::HalfOpen) = print(io, '[', r.lo, " → ", r.hi, ')')
show(io::IO, r::Reverse{<:HalfOpen}) = print(io, '[', r.it.lo, " ← ", r.it.hi, ')')