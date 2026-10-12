"""r267 claim 1 -- WHERE THE COLLAPSE HAPPENS, measured arrow by arrow.

a5f8c0d says its argument is not the one bc593d4 retracted, because "the space is
Sym^3(Weyl_n) FROM THE START".  That is a claim about a FACTORISATION.  The map
r260 measured is

    (V^{tensor 12})^*  --A-->  (Weyl_n^{tensor 3})^*  --B-->  (Sym^3 Weyl_n)^*  --C--> {functions of W}

and the retracted argument asserted the whole kernel sits in B, while a5f8c0d
asserts C is INJECTIVE and says nothing about A or B.  Both are testable.  This
file measures the rank after every arrow, at degree 3 and at degree 2, for the
REAL Weyl_n and for a second linearly-cut subspace, exactly over F_p.

METHOD, sharing no line with the reviewed scripts or with r260/r265/r266.
Integer Weyl tensors are built from the Kulkarni-Nomizu product and the Schouten
tensor with the denominators cleared:  W = 2(n-1)(n-2) R - (2(n-1)Ric - Scal g) (x) g
with R = h (kn) h for integer symmetric h.  Every symmetry is then verified as an
INTEGER identity before anything is measured.  Diagram values are single einsums
whose subscript string IS the matching, evaluated in F_p on integer tensors, and
every rank is a mod-p Gaussian elimination.  No float, no tolerance.
"""
import numpy as np
from itertools import permutations

P = 1009

# ------------------------------------------------------------------ mod p rank
def rank_p(M, p=P):
    A = (np.array(M, dtype=np.int64) % p).copy()
    rows, cols = A.shape
    r = 0
    for c in range(cols):
        piv = None
        for i in range(r, rows):
            if A[i, c] % p:
                piv = i; break
        if piv is None:
            continue
        A[[r, piv]] = A[[piv, r]]
        inv = pow(int(A[r, c]), p - 2, p)
        A[r] = (A[r] * inv) % p
        nz = np.nonzero(A[r + 1:, c])[0]
        if nz.size:
            A[r + 1 + nz] = (A[r + 1 + nz] - np.outer(A[r + 1 + nz, c], A[r])) % p
        r += 1
        if r == rows:
            break
    return r

# --------------------------------------------------------------- matchings
def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield ((a, b),) + m

LET = "abcdefghijklmnopqrstuvwxyz"

def einsum_spec(D, slots, width):
    """subscript string for the diagram D on `slots` tensors of `width` legs each."""
    lab = [None] * (slots * width)
    for k, (a, b) in enumerate(D):
        lab[a] = lab[b] = LET[k]
    return ",".join("z" + "".join(lab[s * width:(s + 1) * width]) for s in range(slots)) + "->z"

# ------------------------------------------------- integer Weyl tensors
def kn(h, k):
    """Kulkarni-Nomizu:  h_ac k_bd + h_bd k_ac - h_ad k_bc - h_bc k_ad."""
    return (np.einsum('ac,bd->abcd', h, k) + np.einsum('bd,ac->abcd', h, k)
            - np.einsum('ad,bc->abcd', h, k) - np.einsum('bc,ad->abcd', h, k))

def weyl_from(h, n):
    """an INTEGER Weyl tensor: the Weyl part of h (kn) h, denominators cleared."""
    g = np.eye(n, dtype=np.int64)
    R = kn(h, h)
    Ric = np.einsum('abad->bd', R)
    Scal = int(np.trace(Ric))
    return 2 * (n - 1) * (n - 2) * R - kn(2 * (n - 1) * Ric - Scal * g, g)

def check_weyl(W, n):
    """every defining condition, as an exact integer identity."""
    ok = (np.array_equal(W, -W.transpose(1, 0, 2, 3))
          and np.array_equal(W, -W.transpose(0, 1, 3, 2))
          and np.array_equal(W, W.transpose(2, 3, 0, 1))
          and np.array_equal(W + W.transpose(0, 2, 3, 1) + W.transpose(0, 3, 1, 2),
                             np.zeros_like(W))
          and np.array_equal(np.einsum('abad->bd', W), np.zeros((n, n), dtype=W.dtype)))
    return ok

def weyl_samples(n, count, seed=0):
    rng = np.random.default_rng(seed)
    out = []
    while len(out) < count:
        h = rng.integers(-3, 4, (n, n)).astype(np.int64)
        h = h + h.T
        W = weyl_from(h, n)
        assert check_weyl(W, n), "the integer construction did not land in Weyl_n"
        if np.abs(W).max() > 0:
            out.append(W % P)
    return out

def weyl_dim_check(n, seed=1):
    """the constructed tensors SPAN Weyl_n: mod-p rank against the formula."""
    S = weyl_samples(n, 3 * (n * (n + 1) * (n + 2) * (n - 3) // 12) + 30, seed=seed)
    M = np.array([W.reshape(-1) for W in S], dtype=np.int64)
    return rank_p(M), n * (n + 1) * (n + 2) * (n - 3) // 12

# ------------------------------------------------- a second linearly-cut space
def traceless_sym_samples(n, count, seed=0):
    rng = np.random.default_rng(seed)
    out = []
    for _ in range(count):
        h = rng.integers(-4, 5, (n, n)).astype(np.int64)
        h = h + h.T
        h = n * h - int(np.trace(h)) * np.eye(n, dtype=np.int64)   # traceless, integer
        out.append(h % P)
    return out

# ------------------------------------------------- the four ranks
def four_ranks(samples_fn, n, width, slots, nsamp, seed=0):
    """rank of the diagram functionals after each arrow of the factorisation."""
    Ds = list(matchings(tuple(range(slots * width))))
    # generic ambient tensors of the same shape (the domain before arrow A)
    rng = np.random.default_rng(seed + 500)
    gen = [rng.integers(0, P, (n,) * width).astype(np.int64) for _ in range(slots * nsamp)]
    sub = samples_fn(n, slots * nsamp, seed)

    def stack(tensors, k):
        return np.stack(tensors[k * nsamp:(k + 1) * nsamp]).astype(np.int64)

    def values(tensors, sym, diag):
        cols = []
        if diag:
            ops = [stack(tensors, 0)] * slots
        else:
            ops = [stack(tensors, k) for k in range(slots)]
        for D in Ds:
            spec = einsum_spec(D, slots, width)
            if sym and not diag:
                v = np.zeros(nsamp, dtype=np.int64)
                for perm in permutations(range(slots)):
                    v = (v + np.einsum(spec, *[ops[i] % P for i in perm],
                                       optimize=True)) % P
            else:
                v = np.einsum(spec, *[o % P for o in ops], optimize=True) % P
            cols.append(v)
        return np.array(cols, dtype=np.int64)

    r_full = rank_p(values(gen, False, False))
    r_sub  = rank_p(values(sub, False, False))
    r_sym  = rank_p(values(sub, True,  False))
    r_diag = rank_p(values(sub, False, True))
    return len(Ds), r_full, r_sub, r_sym, r_diag

if __name__ == "__main__":
    print("The integer Weyl construction, verified before use")
    print(f"  {'n':>3} {'rank of span':>13} {'n(n+1)(n+2)(n-3)/12':>21}")
    for n in (4, 5, 6, 7):
        got, want = weyl_dim_check(n)
        print(f"  {n:>3} {got:>13} {want:>21}")
        assert got == want, "the Kulkarni-Nomizu family does not span Weyl_n"

    print("\nDEGREE 2, U = Weyl_n, 8 legs.  Ranks after each arrow, over F_%d." % P)
    print(f"  {'n':>3} {'diagrams':>9} {'on V^(x)8':>10} {'on W^(x)2':>10} {'on Sym^2 W':>11} {'at W(x)W':>9}")
    for n in (4, 5, 6, 7):
        tot, rf, rs, ry, rd = four_ranks(weyl_samples, n, 4, 2, 140, seed=n)
        print(f"  {n:>3} {tot:>9} {rf:>10} {rs:>10} {ry:>11} {rd:>9}"
              + ("" if ry == rd else "   <-- C IS NOT INJECTIVE"))

    print("\nDEGREE 3, U = Weyl_n, 12 legs -- THE PROGRAMME'S OWN CASE.")
    print("  (r_full is r260's 10,395-at-n>=12; not resampled here.  40 samples cap")
    print("   each measured rank at 40, so a rank of 2 is a rank of 2.)")
    print(f"  {'n':>3} {'diagrams':>9} {'on W^(x)3':>10} {'on Sym^3 W':>11} {'at W(x)W(x)W':>13}")
    for n in (4, 5, 6):
        Ds = list(matchings(tuple(range(12))))
        sub = weyl_samples(n, 3 * 40, seed=n)
        ops = [np.stack(sub[k * 40:(k + 1) * 40]).astype(np.int64) % P for k in range(3)]
        cs, cy, cd = [], [], []
        for D in Ds:
            spec = einsum_spec(D, 3, 4)
            cs.append(np.einsum(spec, *ops, optimize=True) % P)
            v = np.zeros(40, dtype=np.int64)
            for perm in permutations(range(3)):
                v = (v + np.einsum(spec, *[ops[i] for i in perm], optimize=True)) % P
            cy.append(v)
            cd.append(np.einsum(spec, ops[0], ops[0], ops[0], optimize=True) % P)
        rs, ry, rd = rank_p(np.array(cs)), rank_p(np.array(cy)), rank_p(np.array(cd))
        print(f"  {n:>3} {len(Ds):>9} {rs:>10} {ry:>11} {rd:>13}"
              + ("" if ry == rd else "   <-- C IS NOT INJECTIVE"))

    print("\nDEGREE 3, U = traceless symmetric 2-tensors, 6 legs.")
    print(f"  {'n':>3} {'diagrams':>9} {'on V^(x)6':>10} {'on U^(x)3':>10} {'on Sym^3 U':>11} {'at u^(x)3':>9}")
    for n in (3, 4, 5, 6):
        tot, rf, rs, ry, rd = four_ranks(traceless_sym_samples, n, 2, 3, 90, seed=n)
        print(f"  {n:>3} {tot:>9} {rf:>10} {rs:>10} {ry:>11} {rd:>9}"
              + ("" if ry == rd else "   <-- C IS NOT INJECTIVE"))
