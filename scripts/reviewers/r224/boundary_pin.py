"""r224: pin the O(n) labelling condition at its boundary, using the Weyl tensor
itself as the test object.  lambda = (2,2) has lambda'_1 + lambda'_2 = 4.

  dim Weyl_n = n(n+1)(n+2)(n-3)/12

  n = 3: 4 = n+1  ->  the condition says NOT a label   ->  dim must be 0
  n = 4: 4 = n    ->  boundary, condition is <= so it IS a label -> dim must be > 0
  n = 5: 4 < n    ->  a label                          ->  dim must be > 0

A strict inequality (lambda'_1+lambda'_2 < n) would kill the 4-dimensional Weyl
tensor; an inequality one step looser would resurrect a 3-dimensional one.
"""
for n in range(3, 8):
    d = n*(n+1)*(n+2)*(n-3)//12
    print("n=%d  lambda'_1+lambda'_2 = 4 vs n = %d   dim Weyl_n = %3d   %s"
          % (n, n, d, "label" if 4 <= n else "NOT a label"))
assert 3*4*5*0//12 == 0, "Weyl_3 must vanish"
assert 4*5*6*1//12 == 10 > 0, "Weyl_4 must not vanish"
print()
print("boundary is INCLUSIVE (n=4 survives) and one step further is ZERO (n=3),")
print("so lambda'_1 + lambda'_2 <= n is pinned exactly, with no room for an off-by-one.")
