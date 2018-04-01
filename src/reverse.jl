struct Reverse{T}
    it::T
end

rev(it) = Reverse(it)
start(r::Reverse) = start(r.it)
next(r::Reverse, state) = next_back(r.it, state)
done(r::Reverse, state) = done(r.it, state)
length(r::Reverse) = length(r.it)
