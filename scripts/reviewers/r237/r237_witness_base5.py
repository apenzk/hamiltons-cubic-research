"""r237, claim 1: an EXACT relation valid at n_0 = 5 and violated at n = 6.

The reduction under review needs relations at the base to persist UPWARD
(ker eps_{n_0} inside ker eps_n).  Fact (ii) of the file gives the DOWNWARD
containment.  This script exhibits, in exact integer arithmetic, that the
upward containment genuinely fails at a base below threshold: a linear
combination of the two cubic diagram classes that vanishes identically on
W_5 and is nonzero on W_6.

Everything is exact.  The Weyl projector has denominators n, n-2, 2n(n-1);
clearing them scales W by a constant, and both diagrams are cubic, so the
RATIO of the two diagram values is untouched by the scaling.

Both cubic complete contractions are traces of a cube after a flattening:
   q1 = W_{ijkl} W_{klmn} W_{mnij} = tr(M1^3),  M1[(ij),(kl)] = W[i,j,k,l]
   q2 = W_{ikjl} W_{kmln} W_{minj} = tr(M2^3),  M2[(ij),(kl)] = W[i,k,j,l]
so the whole computation is 36x36 integer matrix multiplication.
"""
from fractions import Fraction
import random

def weyl_project(R, n):
    """R: dict-free nested list n^4 of Fractions -> algebraic Weyl tensor."""
    def T(f):
        return [[[[f(i, j, k, l) for l in range(n)] for k in range(n)]
                 for j in range(n)] for i in range(n)]
    A = R
    A = T(lambda i, j, k, l: Fraction(1, 4) * (A[i][j][k][l] - A[j][i][k][l]
                                               - A[i][j][l][k] + A[j][i][l][k]))
    B = A
    A = T(lambda i, j, k, l: Fraction(1, 2) * (B[i][j][k][l] + B[k][l][i][j]))
    C = A
    A = T(lambda i, j, k, l: C[i][j][k][l] - Fraction(1, 3) * (
        C[i][j][k][l] + C[i][k][l][j] + C[i][l][j][k]))
    D = A
    Ric = [[sum(D[i][k][j][k] for k in range(n)) for j in range(n)]
           for i in range(n)]
    s = sum(Ric[i][i] for i in range(n))
    g = lambda a, b: Fraction(1) if a == b else Fraction(0)
    E = lambda a, b: Ric[a][b] - Fraction(s, n) * g(a, b)
    def KN(X, i, j, k, l):
        return X(i, k) * g(j, l) + X(j, l) * g(i, k) - X(i, l) * g(j, k) - X(j, k) * g(i, l)
    W = T(lambda i, j, k, l: D[i][j][k][l]
          - Fraction(1, n - 2) * KN(E, i, j, k, l)
          - Fraction(s, 2 * n * (n - 1)) * KN(lambda a, b: g(a, b), i, j, k, l))
    return W

def checks(W, n):
    """curvature symmetries + first Bianchi + trace-free, exactly."""
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    assert W[i][j][k][l] == -W[j][i][k][l]
                    assert W[i][j][k][l] == W[k][l][i][j]
                    assert W[i][j][k][l] + W[i][k][l][j] + W[i][l][j][k] == 0
    for i in range(n):
        for j in range(n):
            assert sum(W[i][k][j][k] for k in range(n)) == 0

def to_int(W, n):
    """clear denominators; returns an integer tensor proportional to W."""
    from math import lcm
    d = 1
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    d = lcm(d, W[i][j][k][l].denominator)
    return [[[[int(W[i][j][k][l] * d) for l in range(n)] for k in range(n)]
             for j in range(n)] for i in range(n)]

def flat(Wi, n, kind):
    N = n * n
    M = [[0] * N for _ in range(N)]
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    if kind == 1:
                        M[i * n + j][k * n + l] = Wi[i][j][k][l]
                    else:
                        M[i * n + j][k * n + l] = Wi[i][k][j][l]
    return M

def mm(A, B, N):
    return [[sum(A[i][t] * B[t][j] for t in range(N)) for j in range(N)]
            for i in range(N)]

def tr3(M, N):
    M2 = mm(M, M, N)
    return sum(sum(M2[i][t] * M[t][i] for t in range(N)) for i in range(N))

def diagrams(Wi, n):
    N = n * n
    return (tr3(flat(Wi, n, 1), N), tr3(flat(Wi, n, 2), N))

def sample(n, rng):
    R = [[[[Fraction(rng.randint(-9, 9)) for _ in range(n)] for _ in range(n)]
          for _ in range(n)] for _ in range(n)]
    W = weyl_project(R, n)
    checks(W, n)
    return to_int(W, n)

rng = random.Random(237)
print("=== degree-3 miniature, exact integer arithmetic ===")
pairs = {}
for n in (4, 5, 6, 7):
    vals = [diagrams(sample(n, rng), n) for _ in range(6)]
    pairs[n] = vals
    ratios = set()
    for q1, q2 in vals:
        ratios.add(Fraction(q2, q1) if q1 else None)
    rank = 1 if len(ratios) == 1 and None not in ratios else 2
    print(f"  n={n}: ratios q2/q1 over 6 random Weyl tensors = "
          f"{sorted(str(r) for r in ratios)}  -> rank {rank}")

# the exact relation at the base
r5 = Fraction(pairs[5][0][1], pairs[5][0][0])
c1, c2 = r5.numerator, -r5.denominator          # c1*q1 + c2*q2 with q2/q1 = r5
print(f"\n  RELATION AT n_0 = 5:  {c1}*q1 + ({c2})*q2 = 0")
for q1, q2 in pairs[5]:
    assert c1 * q1 + c2 * q2 == 0, "the relation failed at n=5"
print(f"    holds exactly on all 6 sampled W in W_5 (and on W_4 too: "
      f"{all(c1*a+c2*b==0 for a,b in pairs[4])})")
viol = [c1 * q1 + c2 * q2 for q1, q2 in pairs[6]]
print(f"    VIOLATED on W_6: values {viol[:3]} ... (all nonzero: "
      f"{all(v != 0 for v in viol)})")
assert all(v != 0 for v in viol), "no violation at n=6 -- witness fails"

# fact (ii): the DOWNWARD direction, on the same objects
print("\n=== fact (ii): padding, exactly ===")
W5 = sample(5, rng)
W6 = [[[[ (W5[i][j][k][l] if max(i,j,k,l) < 5 else 0)
          for l in range(6)] for k in range(6)] for j in range(6)] for i in range(6)]
a5 = diagrams(W5, 5); a6 = diagrams(W6, 6)
print(f"  q(pad W) at n=6: {a6}")
print(f"  q(W)     at n=5: {a5}")
assert a5 == a6, "padding does not preserve the diagram values"
print("  equal -- so every relation valid at n=6 restricts to n=5: "
      "ker eps_6 subset ker eps_5, exactly as (ii) states.")
print("\n  CONCLUSION: ker eps_6 is strictly inside ker eps_5.  The containment")
print("  the lift needs (ker eps_{n_0} inside ker eps_n) FAILS at n_0 = 5,")
print("  while the containment the file states holds.  The two are different")
print("  statements and only the dimension count separates them.")
