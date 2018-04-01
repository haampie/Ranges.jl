Some ideas about ranges of integers in Julia. The package provides half-open ranges:

```julia
RightOpen(a, b)          # [a → b)
Reverse(RightOpen(a, b)) # [a ← b)
LeftOpen(a, b)           # (a → b]
Reverse(LeftOpen(a, b))  # (a ← b]
```

and some helper functions `to` and `rev`.

For example:

```julia
> using Ranges
> for i = to(0, 5)
    print(i, ' ')
  end
0 1 2 3 4
> for i = LeftOpen(0, 5)
    print(i, ' ')
  end
1 2 3 4 5
```

```julia
> for i = rev(to(0, 5))
    print(i, ' ')
  end
4 3 2 1 0
> for i = rev(LeftOpen(0, 5)
    print(i, ' ')
  end
5 4 3 2 1
```

It solves a couple problems in the native range `a:b-1` of Julia:

1. No overflow of `length(to(a, b))` by using `UInt`s.
    ```julia
    > length(-10:typemax(Int))
    ERROR: OverflowError()
    ```
    vs
    ```julia
    > length(to(-10, typemax(Int)))
    0x8000000000000009
    ```
2. Iterate over unsigned integers in reverse order.
    ```julia
    > for i = 0x03:-1:0x00
        print(i, ' ')
      end
    ERROR: InexactError()
    ```
    vs
    ```julia
    > for i = rev(to(0x00, 0x04))
        print(i, ' ')
      end
    3 2 1 0
    ```
3. Ability to construct an empty range `to(0x00, 0x00)`.

At the moment one cannot iterate all the way from `typemin(IntT)` to `typemax(IntT)` inclusive; but this issue is best fixed with the new iterator protocol in Julia 1.0 combined which makes implementing a `ClosedRange` type a breeze.