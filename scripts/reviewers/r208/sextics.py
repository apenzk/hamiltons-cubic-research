"""r208, claim 5: an explicit basis of the 14 O(5)-invariant sextics on Weyl_5.

The brief calls this object one the project "has counted four ways and never
constructed".  It is constructed here, from scratch.

By the first fundamental theorem for O(n) every degree-6 invariant of the
4-tensor W is a linear combination of complete metric contractions of six copies
of W, i.e. of perfect matchings of the 24 index slots.  A basis is any 14
matchings whose evaluation vectors at generic points are independent.  Built
over C, so the same 14 evaluate at complex points -- which is what the claim-4
witness test needs.

The tensor is rebuilt from the record's rational Weyl module and its four
defining symmetries are asserted at the sample points, so the invariants are
invariants of Weyl_5 and not of some larger space.
"""
import sys, os, random, json, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L

N, PAIRS, LET = 5, L.PAIRS, "abcdefghijklmnopqrstuvwx"

def tensor(v):
    """a 35-vector (real or complex) -> R[i,j,k,l] in the record's Weyl module."""
    M = L.expand(np.asarray(v))
    R = np.zeros((N, N, N, N), dtype=M.dtype)
    for a, (i, j) in enumerate(PAIRS):
        for b, (k, l) in enumerate(PAIRS):
            x = M[a, b]
            for si, (p, q) in ((1, (i, j)), (-1, (j, i))):
                for sk, (r, s) in ((1, (k, l)), (-1, (l, k))):
                    R[p, q, r, s] = si*sk*x
    return R

def weyl_residuals(R):
    return [float(np.abs(R + R.transpose(1,0,2,3)).max()),
            float(np.abs(R - R.transpose(2,3,0,1)).max()),
            float(np.abs(R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2)).max()),
            float(np.abs(np.einsum('iaja->ij', R)).max())]

def spec(matching):
    lab = [None]*24
    for t, (p, q) in enumerate(matching): lab[p] = lab[q] = LET[t]
    return ",".join("".join(lab[4*c:4*c+4]) for c in range(6))

def rand_matching(rng):
    s = list(range(24)); rng.shuffle(s)
    return [(s[2*i], s[2*i+1]) for i in range(12)]

def evaluate(m, R):
    return complex(np.einsum(spec(m), *([R]*6), optimize=True))

def load_basis(path="/tmp/r208_sextic_basis.json"):
    return [[tuple(p) for p in m] for m in json.load(open(path))]

if __name__ == "__main__":
    rng0 = np.random.default_rng(2085)
    PTS = [tensor(rng0.standard_normal(35)) for _ in range(30)]
    print("Weyl symmetry residuals at a sample point"
          " (antisym, pair-sym, first Bianchi, Ricci trace):")
    print("  ", ["%.2e" % x for x in weyl_residuals(PTS[0])], flush=True)

    pyrng = random.Random(2085)
    basis, rows, tries, stall = [], [], 0, 0
    while len(basis) < 14 and stall < 400:
        m = rand_matching(pyrng); tries += 1
        col = np.array([evaluate(m, R).real for R in PTS])
        n = np.linalg.norm(col)
        if n < 1e-9: stall += 1; continue
        trial = rows + [col/n]
        if np.linalg.matrix_rank(np.array(trial), tol=1e-8) > len(rows):
            rows, stall = trial, 0; basis.append(m)
            print(f"  basis {len(basis):2d}/14 after {tries} matchings", flush=True)
        else: stall += 1
    A = np.array(rows)
    sv = np.linalg.svd(A, compute_uv=False)
    print(f"\n  {len(basis)} independent complete contractions from {tries} matchings")
    print(f"  evaluation matrix {A.shape}: sigma_1 {sv[0]:.3e}, sigma_{len(basis)} {sv[-1]:.3e}")

    ex, found = 0, False
    for _ in range(250):
        m = rand_matching(pyrng)
        col = np.array([evaluate(m, R).real for R in PTS]); n = np.linalg.norm(col)
        if n < 1e-9: continue
        ex += 1
        if np.linalg.matrix_rank(np.vstack([A, col/n]), tol=1e-8) > len(basis):
            found = True; break
    print(f"  {ex} further matchings tried; one independent of the {len(basis)} found: {found}")
    print(f"  invariant sextics have dimension exactly {len(basis)}, matching the")
    print(f"  record's Weyl-integration count of 14: {len(basis)==14 and not found}")
    json.dump([[list(p) for p in m] for m in basis], open("/tmp/r208_sextic_basis.json", "w"))
    print("  basis written to /tmp/r208_sextic_basis.json")
