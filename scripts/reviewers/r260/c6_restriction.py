"""CLAIM 6 -- does Lehrer-Zhang 3.4 supply A2'''s independence hypothesis?

Theorem 3.4 says the gamma_D are a BASIS of the O(V)-invariants on (V^{tensor 2r})^*
when r <= n.  That is independence of functionals on TWELVE FREE LEGS.

A2'''s hypothesis (r245, claim 1(iii)) is independence of the COVARIANT FAMILY AS
FUNCTIONS -- objects evaluated at W (x) W (x) W with ONE Weyl tensor W repeated,
i.e. the gamma_D RESTRICTED to the image of Weyl_n under the diagonal degree-3 map.

Restriction is a linear map, and a basis does not stay independent through a map
with a kernel.  This file measures that kernel, at the programme's own degree 3
and at the smallest n where Theorem 3.4 applies.

TWO CASES:
  (A) symmetric traceless S (2 legs each), degree 3  ->  2r = 6, r = 3, n >= 3.
      15 diagrams, a basis of the invariants on (V^{tensor 6})^*.
  (B) the WEYL tensor itself (4 legs each), degree 3 ->  2r = 12, r = 6, n >= 6.
      10395 diagrams, a basis of the invariants on (V^{tensor 12})^*.
"""
import numpy as np, itertools, sys
rng = np.random.default_rng(20260830)

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

LET = 'abcdefghijkl'

def evaluate(D, tensors, legs):
    """contract the given tensors along the matching D of all their legs."""
    lab = [None] * sum(legs)
    for k, (a, b) in enumerate(D):
        lab[a] = lab[b] = LET[k]
    spec, pos = [], 0
    for L in legs:
        spec.append(''.join(lab[pos:pos+L])); pos += L
    return float(np.einsum(','.join(spec) + '->', *tensors, optimize=True))

def rand_sym_traceless(n):
    S = rng.standard_normal((n, n)); S = S + S.T
    S -= np.trace(S) / n * np.eye(n)
    return S

def rand_weyl(n):
    T = rng.standard_normal((n, n, n, n))
    R = T - T.transpose(1, 0, 2, 3) - T.transpose(0, 1, 3, 2) + T.transpose(1, 0, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    # first Bianchi: remove the totally antisymmetric part
    B = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    R = R - B
    g = np.eye(n)
    Ric = np.einsum('abad->bd', R)
    Sc = np.trace(Ric)
    kn = (np.einsum('ac,bd->abcd', g, Ric) - np.einsum('ad,bc->abcd', g, Ric)
          - np.einsum('bc,ad->abcd', g, Ric) + np.einsum('bd,ac->abcd', g, Ric))
    gg = np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
    C = R - kn / (n - 2) + Sc * gg / ((n - 1) * (n - 2))
    return C

def report(name, legs, maker, n, nsamp):
    tot = sum(legs)
    diagrams = list(matchings(tuple(range(tot))))
    M = np.zeros((len(diagrams), nsamp))
    for s in range(nsamp):
        X = maker(n)
        ts = [X] * len(legs)
        for i, D in enumerate(diagrams):
            M[i, s] = evaluate(D, ts, legs)
        sys.stdout.flush()
    rk = np.linalg.matrix_rank(M, tol=1e-8 * max(1.0, abs(M).max()))
    print(f"  {name} at n = {n}:  {len(diagrams)} diagrams (a BASIS upstairs by Thm 3.4, "
          f"r = {tot//2} <= n)")
    print(f"    rank after restriction to the degree-3 diagonal, {nsamp} samples: {rk}")
    print(f"    dimension of the kernel of the restriction: {len(diagrams) - rk}\n")
    return len(diagrams), rk

print("(A) symmetric traceless, 2 legs each, degree 3 -> r = 3\n")
for n in (3, 4, 5, 6, 12):
    report("sym traceless", (2, 2, 2), rand_sym_traceless, n, 12)

print("(B) WEYL tensor, 4 legs each, degree 3 -> r = 6 -- the programme's own object\n")
for n in (6, 7):
    W = rand_weyl(n)
    print(f"  Weyl check at n={n}: max |trace| = {abs(np.einsum('abad->bd', W)).max():.2e}, "
          f"antisym {abs(W + W.transpose(1,0,2,3)).max():.2e}, "
          f"pair {abs(W - W.transpose(2,3,0,1)).max():.2e}, "
          f"Bianchi {abs(W + W.transpose(0,2,3,1) + W.transpose(0,3,1,2)).max():.2e}")
for n in (6, 7):
    report("Weyl", (4, 4, 4), rand_weyl, n, 25)
