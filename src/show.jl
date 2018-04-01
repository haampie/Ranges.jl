import Base: show

show(io::IO, r::RightOpen) = print(io, '[', r.lo, " → ", r.hi, ')')
show(io::IO, r::Reverse{<:RightOpen}) = print(io, '[', r.it.lo, " ← ", r.it.hi, ')')
show(io::IO, r::LeftOpen) = print(io, '(', r.lo, " → ", r.hi, ']')
show(io::IO, r::Reverse{<:LeftOpen}) = print(io, '(', r.it.lo, " ← ", r.it.hi, ']')