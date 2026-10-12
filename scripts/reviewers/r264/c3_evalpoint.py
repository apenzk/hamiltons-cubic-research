"""r264 / claim 3: does evaluating c_0 at ONE weight vector test the same thing
as the map c_0 itself?  Three ranks per cell:
  (a) span{nu(D) c_0(e_0)}      -- what run_seed_is_a_diagram.py computes
  (b) span{nu(D) c_0(v)}, v a RANDOM nonzero vector of V_lambda
  (c) span{nu(D) o c_0} as maps, i.e. rank of the stacked full matrices
All three must equal m_lambda(n): image(c_0) lies in V_lambda (x) M_lambda and the
diagram algebra acts on the M_lambda factor alone.
"""
import numpy as np
exec(open('scripts/reviewers/r264/c3_nontrivial_lambda.py').read().split('CASES = []')[0])

def basis_Vlam(lam, n):
    """a spanning set of V_lambda inside V^{(x)m}, from Young symmetrisers on
    all distinct-index tensors."""
    import itertools
    m = sum(lam)
    rows = []
    T0 = young_vector(lam, n)
    for perm in itertools.permutations(range(n), m):
        # relabel 0..m-1 -> perm
        idx = np.zeros((n,)*m)
        it = np.nditer(T0, flags=['multi_index'])
        for x in it:
            if x != 0:
                idx[tuple(perm[i] for i in it.multi_index)] += float(x)
        rows.append(idx.reshape(-1))
    B = np.array(rows)
    u, s, vt = np.linalg.svd(B, full_matrices=False)
    return vt[s > 1e-8]

print(f"{'lambda':>10} {'f':>2} {'n':>2} {'(a) e_0':>8} {'(b) rand':>9} {'(c) map':>8} {'m_lam(n)':>9}")
for lam, f, n in [((1,), 3, 3), ((1,), 5, 3), ((1,), 5, 2), ((2,), 4, 3), ((2,), 4, 4),
                  ((1,1), 4, 3), ((1,1), 6, 3), ((2,2), 4, 4), ((3,1), 4, 4)]:
    m = sum(lam); k = (f - m)//2
    Vb = basis_Vlam(lam, n)
    cupv = np.eye(n).reshape(-1)
    def pad(vec):
        out = vec
        for _ in range(k): out = np.kron(out, cupv)
        return out.reshape((n,)*f)
    Ds = list(matchings(tuple(range(2*f))))
    ra = np.linalg.matrix_rank(np.array(
        [apply_diagram(D, f, n, pad(Vb[0])).reshape(-1) for D in Ds]), tol=1e-8)
    rng = np.random.default_rng(7)
    w = rng.standard_normal(Vb.shape[0]) @ Vb
    rb = np.linalg.matrix_rank(np.array(
        [apply_diagram(D, f, n, pad(w)).reshape(-1) for D in Ds]), tol=1e-8)
    rows = []
    for D in Ds:
        rows.append(np.concatenate([apply_diagram(D, f, n, pad(v)).reshape(-1) for v in Vb]))
    rc = np.linalg.matrix_rank(np.array(rows), tol=1e-8)
    want = restricted_updown(f, n).get(lam, 0)
    print(f"{str(lam):>10} {f:>2} {n:>2} {ra:>8} {rb:>9} {rc:>8} {want:>9}"
          + ("" if ra == rb == rc == want else "   <-- DISAGREE"))
