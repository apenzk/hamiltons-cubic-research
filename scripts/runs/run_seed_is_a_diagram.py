"""THE SEED IS EXPLICIT -- the search for a SEED goes, the search for an
EXPANSION stays, and obligation (ii) is NOT closed.

WHERE THIS SITS.  The realisation theorem (findings/brauer-pairing.md) says one
nonzero seed per block generates that block's covariant space under the diagram
action, at every n.  It does NOT say where a seed comes from, and that gap is
what kept obligation (ii) open: "one seed and the diagrams do the rest" is a
structure theorem over a 316,234,143,225-element spanning set, not an algorithm.

  IF THE SEED MUST BE FOUND BY SEARCH, the theorem buys nothing -- finding a
  nonzero element of Hom(V_lambda, V^{tensor 12}) is the same construction
  problem the item started with, once per block.

THE ARGUMENT, and it needs no search.  Take the block lambda, with |lambda| <= 12
and |lambda| = 12 mod 2.  Write k = (12 - |lambda|)/2.

  Let iota_lambda : V_lambda -> V^{tensor |lambda|} be the inclusion, and let
  cup in V tensor V be the invariant metric element sum_a e_a tensor e_a.  Then

      c_0 := iota_lambda tensor cup^{tensor k} : V_lambda -> V^{tensor 12}

  is O(n)-equivariant, being a tensor product of equivariant maps.  IT IS NONZERO
  FOR EVERY POSITIVE n: pairing the k cups against k caps returns n^k times
  iota_lambda, and n^k > 0.

  So c_0 is a nonzero element of M_lambda, exhibited in closed form, and the
  realisation theorem applies to it.  EVERY BLOCK HAS AN EXPLICIT SEED rather
  than something searched for.

THE HYPOTHESIS THE FIRST STATEMENT OMITTED (r263).  "Nonzero for every positive
n" is FALSE unless lambda is O(n)-admissible, lambda'_1 + lambda'_2 <= n: below
that V_lambda = 0 and iota_lambda does not exist, witnessed at lambda = (2,2) for
n = 2,3 and lambda = (2,1,1) for n = 3.  At n = 12 it holds for all 71 blocks and
is TIGHT -- lambda = (2,2,2,2,2,2) sits at 6 + 6 = 12 = n, zero slack.

AND "PADDING" IS THE WRONG WORD AT 16 OF THE 71 BLOCKS.  Where |lambda| = 12 the
count k is zero, there is no cup anywhere, and c_0 is iota_lambda itself.

WHAT THIS DOES NOT DO, and the header of this file first claimed otherwise.  It
does NOT close obligation (ii).  The chain is seed -> spanning set of
23!! = 316,234,143,225 elements -> EXISTENCE of a combination, while the
deliverable asks for EXHIBITION: dim e M_lambda independent members located among
3.16e11, then a change of basis against the constructed weight-space vectors.
None of that is done or priced.  THE LEMMA REMOVES THE SEARCH FOR A SEED AND
LEAVES THE SEARCH FOR AN EXPANSION.

  Obligation (i), independence on the diagonal, is untouched -- restriction to
  W tensor W tensor W has a kernel (r260: 10,395 -> rank 2).

WHAT IS CHECKED HERE, AND WHAT IS NOT.  The two facts the argument turns on, at
sizes where they can be computed directly: that the padded map is equivariant and
nonzero, and that a seed built this way generates the whole multiplicity space --
including at a sub-threshold (f, n), where the abstract algebra is not semisimple
and only the image argument is available.

  THE CELLS BELOW USE ONLY lambda = () AND lambda = (1), the two smallest labels,
  for a lemma quantified over |lambda| up to 12; and the odd-f rows seed with
  e_0 in V, a WEIGHT VECTOR rather than iota_{(1)}, so they measure a vector
  orbit and not a map orbit.  The numbers coincide because a nonzero equivariant
  V -> V^{tensor f} is injective, which this file did not state.  r263 closed the
  gap properly, building iota_lambda for (2), (1,1), (2,1), (2,2), (3,1) and
  testing c_0 AS A MAP at ten cells -- equivariant for the FULL O(n), reflection
  included, to 3e-15, and generating exactly m_lambda(n) every time.
"""
import numpy as np
from itertools import product

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def diagram_ops(f, n):
    dim = n ** f
    idx = [tuple((k // n**(f-1-p)) % n for p in range(f)) for k in range(dim)]
    ops = []
    for D in matchings(tuple(range(2*f))):
        M = np.zeros((dim, dim))
        for r, j in enumerate(idx):
            for c, i in enumerate(idx):
                lab = j + i
                if all(lab[a] == lab[b] for a, b in D):
                    M[r, c] = 1.0
        ops.append(M)
    return ops

def cup(n):
    """the invariant metric element, as a vector in V tensor V."""
    v = np.zeros(n * n)
    for a in range(n):
        v[a * n + a] = 1.0
    return v

def padded_seed(f, n, base, m=None):
    """base (a vector in V^{tensor m}) padded with cups up to f legs.

    m IS PASSED, NOT INFERRED (r263).  The first version read it back off the
    length as round(log(len(base))/log(n)), which divides by zero at n = 1 -- the
    row both reviewers of the sibling script added -- and which silently floored
    the wrong parity: k = (f - m)//2 with f - m odd returned a vector of the wrong
    length for the slot, so a later cell would have compared its rank against
    m_lambda(n) meaninglessly.  No tested cell tripped it, which is the point.
    """
    if m is None:
        m = 0 if len(base) == 1 else int(round(np.log(len(base)) / np.log(n)))
    assert (f - m) % 2 == 0 and f >= m, (
        f"cannot pad {m} legs up to {f}: the difference must be even and non-negative, "
        "since padding adds cups two legs at a time")
    out = base
    for _ in range((f - m) // 2):
        out = np.kron(out, cup(n))
    assert len(out) == n ** f, f"padded seed has {len(out)} entries, not n^f = {n**f}"
    return out

print("  (1) the padded seed is nonzero at every positive n -- pairing k cups")
print("      against k caps returns n^k times the base.\n")
for n in (3, 4, 5, 6):
    for k in (1, 2, 3):
        v = padded_seed(2 * k, n, np.array([1.0]), m=0)
        got = float(v @ v)
        assert got == n ** k, f"cup^{k} paired with itself gave {got}, not {n}^{k}"
    print(f"    n = {n}:  cup^k . cup^k = n^k for k = 1,2,3   OK")

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def restricted_updown(f, n):
    """m_lambda(n): up-down tableaux of length f, every intermediate shape admissible."""
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

print("\n  (2) a padded seed generates THE WHOLE multiplicity space -- compared")
print("      against m_lambda(n), which is computed from the up-down recursion and")
print("      knows nothing about seeds or diagrams.  INCLUDING below the threshold,")
print("      where the abstract algebra is not semisimple and only the image")
print("      argument survives.\n")
print(f"    {'f':>2} {'n':>2} {'lambda':>7} {'semisimple':>10} {'A.seed':>7} {'m_lambda(n)':>12}")
for f, n in ((2, 3), (3, 3), (3, 2), (4, 3), (4, 2), (5, 2), (4, 4), (5, 3)):
    ops = diagram_ops(f, n)
    lam = () if f % 2 == 0 else (1,)
    base = np.array([1.0]) if f % 2 == 0 else np.eye(n)[0]
    seed = padded_seed(f, n, base, m=0 if f % 2 == 0 else 1)
    got = np.linalg.matrix_rank(np.array([M @ seed for M in ops]), tol=1e-9)
    want = restricted_updown(f, n).get(lam, 0)
    ss = n >= f - 1
    print(f"    {f:>2} {n:>2} {str(lam):>7} {str(ss):>10} {got:>7} {want:>12}")
    assert got == want, (
        f"at (f,n) = ({f},{n}) the padded seed generated {got} dimensions against "
        f"m_{lam}({n}) = {want}; the realisation theorem says ANY nonzero seed "
        "generates the whole multiplicity space, so a shortfall means either the "
        "padded map is not a seed or the theorem is false here")

print("\n  So every block has an explicit seed, with no search.  It is a PADDING")
print("  diagram only where k > 0: at the 16 blocks with |lambda| = 12 there is no")
print("  cup at all and the content is that an inclusion is nonzero.")
print("  OBLIGATION (ii) IS NOT CLOSED BY THIS -- the chain is seed -> spanning set")
print("  of 23!! = 316,234,143,225 -> EXISTENCE of a combination, while the")
print("  deliverable asks for EXHIBITION.  What is removed is the search for a")
print("  seed; what remains is the search for an expansion, unpriced.")
print("  Also open and untouched: independence on the degree-3 diagonal.")
