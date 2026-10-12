"""r265 claims 1 and 2 -- where the rank actually collapses, and what the 2 is.

Independent of scripts/reviewers/r260/: the Weyl tensors are built by an explicit
Bianchi projector plus a CLOSED-FORM trace removal (solved from Ricci(KN(S,g)) =
tr(S) g + (n-2) S), verified on all four symmetries and on the dimension of their
span; every diagram is evaluated by ONE batched einsum over all samples at once.

Three ranks are separated that the record runs together:

  (A) rank of the diagram family restituted to a GENERIC 4-tensor T -- this is what
      Weyl's restitution theorem controls: it is the dimension of the S_3-SYMMETRIC
      part of the span of the diagrams, and nothing more is lost.
  (B) rank of the same family restituted to a WEYL tensor W -- what r260 measured.
  (C) the orbit count, i.e. dim of the symmetric part, computed combinatorially.

If restitution were the only kernel, (A) = (B) = (C).
"""
import sys
import numpy as np
from itertools import permutations

rng = np.random.default_rng(20265)
LET = "abcdefghijklmnopqrstuvwxyz"


def matchings(pts):
    pts = tuple(pts)
    if not pts:
        return [()]
    a = pts[0]
    out = []
    for i in range(1, len(pts)):
        b = pts[i]
        rest = pts[1:i] + pts[i + 1:]
        for m in matchings(rest):
            out.append(((a, b),) + m)
    return out


def weyl_batch(n, S):
    """S random Weyl tensors, shape (S,n,n,n,n)."""
    R = rng.standard_normal((S, n, n, n, n))
    R = R - R.transpose(0, 2, 1, 3, 4)
    R = R - R.transpose(0, 1, 2, 4, 3)
    R = R + R.transpose(0, 3, 4, 1, 2)
    R = (2 * R - R.transpose(0, 1, 3, 4, 2) - R.transpose(0, 1, 4, 2, 3)) / 3.0
    Ric = np.einsum('sabad->sbd', R)
    sc = np.einsum('sbb->s', Ric)
    g = np.eye(n)
    Smat = (Ric - (sc / (2 * n - 2))[:, None, None] * g) / (n - 2)
    KN = (np.einsum('sac,bd->sabcd', Smat, g) + np.einsum('sbd,ac->sabcd', Smat, g)
          - np.einsum('sad,bc->sabcd', Smat, g) - np.einsum('sbc,ad->sabcd', Smat, g))
    return R - KN


def check_weyl(W, n):
    t = lambda p: W.transpose(0, *[1 + i for i in p])
    errs = {
        "antisym ab": np.abs(W + t((1, 0, 2, 3))).max(),
        "antisym cd": np.abs(W + t((0, 1, 3, 2))).max(),
        "pair swap": np.abs(W - t((2, 3, 0, 1))).max(),
        "first Bianchi": np.abs(W + t((0, 2, 3, 1)) + t((0, 3, 1, 2))).max(),
        "traceless": np.abs(np.einsum('sabad->sbd', W)).max(),
    }
    scale = np.abs(W).max()
    dim = np.linalg.matrix_rank(W.reshape(W.shape[0], -1), tol=1e-8 * scale)
    return errs, scale, dim


def diagram_ranks(n, nblocks, samples, tensors, tol=1e-8):
    """rank of {gamma_D(T,...,T)} over the given batch of tensors."""
    legs = 4 * nblocks
    ms = matchings(tuple(range(legs)))
    subs = []
    for m in ms:
        lab = [None] * legs
        for k, (x, y) in enumerate(m):
            lab[x] = lab[y] = LET[k]
        blocks = ["s" + "".join(lab[4 * b:4 * b + 4]) for b in range(nblocks)]
        subs.append(",".join(blocks) + "->s")
    vals = np.empty((samples, len(ms)))
    for j, s in enumerate(subs):
        vals[:, j] = np.einsum(s, *([tensors] * nblocks), optimize=True)
    sc = max(1.0, np.abs(vals).max())
    return np.linalg.matrix_rank(vals, tol=tol * sc), len(ms)


def orbits(nblocks):
    legs = 4 * nblocks
    ms = [frozenset(frozenset(e) for e in m) for m in matchings(tuple(range(legs)))]
    seen, count = set(), 0
    for m in ms:
        if m in seen:
            continue
        count += 1
        for sig in permutations(range(nblocks)):
            p = {b * 4 + j: sig[b] * 4 + j for b in range(nblocks) for j in range(4)}
            seen.add(frozenset(frozenset((p[x], p[y])) for (x, y) in
                               (tuple(e) for e in m)))
    return count, len(ms)


print("STEP 0 -- the Weyl tensors are what they claim to be\n")
for n in (6, 7, 12):
    W = weyl_batch(n, 200)
    errs, sc, dim = check_weyl(W, n)
    want = n * (n + 1) * (n + 2) * (n - 3) // 12
    print(f"  n={n:>2}  max|W|={sc:8.3f}  residuals: "
          + ", ".join(f"{k} {v:.2e}" for k, v in errs.items()))
    print(f"        dim span of 200 samples = {dim}, formula n(n+1)(n+2)(n-3)/12 = {want}"
          + ("  MATCH" if dim == want else "  MISMATCH"))
print()

print("STEP 1 -- DEGREE 2, where every one of the three numbers is computable\n")
orb2, tot2 = orbits(2)
print(f"  matchings of 8 legs (a basis of the invariants for n >= 4): {tot2}")
print(f"  (C) orbits under the block S_2 = dim of the symmetric part: {orb2}")
for n in (6, 7, 12):
    T = rng.standard_normal((60, n, n, n, n))
    rA, _ = diagram_ranks(n, 2, 60, T)
    W = weyl_batch(n, 60)
    rB, _ = diagram_ranks(n, 2, 60, W)
    print(f"  n={n:>2}:  (A) rank on a GENERIC 4-tensor = {rA:>3}"
          f"   (B) rank on a WEYL tensor = {rB:>3}")
print()

print("STEP 2 -- DEGREE 3, the record's own case\n")
orb3, tot3 = orbits(3)
print(f"  matchings of 12 legs (a basis for n >= 12): {tot3}")
print(f"  (C) orbits under the block S_3 = dim of the symmetric part: {orb3}")
sys.stdout.flush()
NS = int(sys.argv[1]) if len(sys.argv) > 1 else 130
for n in (4, 5, 6, 7, 8, 12):
    W = weyl_batch(n, 40)
    rB, _ = diagram_ranks(n, 3, 40, W)
    print(f"  n={n:>2}:  (B) rank on a WEYL tensor, 40 samples = {rB}")
    sys.stdout.flush()
for n in (6, 12):
    T = rng.standard_normal((NS, n, n, n, n))
    rA, _ = diagram_ranks(n, 3, NS, T)
    print(f"  n={n:>2}:  (A) rank on a GENERIC 4-tensor, {NS} samples = {rA}"
          f"{'  (= #samples, so this is a LOWER bound)' if rA == NS else ''}")
    sys.stdout.flush()
