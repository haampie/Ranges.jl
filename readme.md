Some ideas about ranges in Julia. The package provides

```julia
HalfOpen(a, b)
```

which is the non-inclusive range `[a, b)`; and

```julia
Reverse(HalfOpen(a, b))
```

which iterates over the range `[a, b)` from `b-1` back to `a` inclusive. For example:

```julia
> using Ranges
> for i = HalfOpen(0, 5)
>     println(i)
> end
0
1
2
3
4
> for i = Reverse(HalfOpen(0, 5))
>     println(i)
> end
4
3
2
1
0
```

It solves a couple problems in the native range `a:b-1` of Julia:

- No overflow of `length(HalfOpen(a, b))` by using `UInt`s.
- Iterate over unsigned integers in reverse order. Julia's step range currently cannot construct `UInt(10):-1:UInt(1)`.
- Ability to construct an empty range `HalfOpen(UInt(0), UInt(0))`.

At the moment one cannot iterate all the way from `typemin(IntT)` to `typemax(IntT)` inclusive; but this issue is best fixed with the new iterator protocol in Julia 1.0 combined with an `ClosedRange` type.