"""r259 -- steps (ii) and (iii) run in miniature, ON BOTH SIDES OF RUI'S THRESHOLD.

THE QUESTION.  The theorem derives "one seed per block generates the block" from
semisimplicity of B_f(n).  The derivation this file tests instead is that the
conclusion needs NO threshold: in characteristic zero V^{tensor f} is a semisimple
O(n)-module, so V^{tensor f} = sum_lambda V_lambda tensor M_lambda and

    End_{O(n)}(V^{tensor f}) = sum_lambda End(M_lambda),

which by the SURJECTIVITY half of the SFT is exactly nu(B_f(n)).  Each M_lambda is
then automatically an IRREDUCIBLE module over the image, so any nonzero c_0 in
M_lambda has span{ nu(D) c_0 } = M_lambda -- with no inequality between n and f
anywhere in the argument.

THE TEST.  Take lambda = the trivial label, where M_lambda is the invariant subspace
of V^{tensor f} and everything is computable.  Run it at (f, n) = (4, 2), which is
BELOW Rui's threshold -- B_4(2) is not semisimple and the reviewed script's own
cell-module identity fails there, 35 against 82 -- and at (4,3), (4,4) above it.

STEP (iii) TOO.  e = A_{12} A_{34}, the antisymmetriser on legs 1,2 times the one on
legs 3,4, is a GL(n)- hence O(n)-equivariant idempotent of V^{tensor 4}: a stand-in
for the Sym^3(Weyl) projector with the same standing.  The seed chosen is
c_0 = delta_{12} delta_{34}, which e ANNIHILATES -- so the seed is as far outside the
covariant space as a nonzero vector can be -- and the test is whether
{ e nu(D) c_0 } still spans e . M_triv.
"""
import numpy as np


def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield ((a, b),) + m


def index_tuples(m, n):
    return [tuple((k // n ** (m - 1 - p)) % n for p in range(m)) for k in range(n ** m)]


def diagram_ops(m, n):
    idx = index_tuples(m, n)
    ops = []
    for D in matchings(tuple(range(2 * m))):
        M = np.zeros((n ** m, n ** m))
        for r, j in enumerate(idx):
            for c, i in enumerate(idx):
                lab = j + i
                if all(lab[a] == lab[b] for a, b in D):
                    M[r, c] = 1.0
        ops.append(M)
    return ops


def invariant_vectors(m, n):
    """gamma_D as VECTORS in V^{tensor m}: the matchings of the m legs."""
    idx = index_tuples(m, n)
    out = []
    for D in matchings(tuple(range(m))):
        v = np.zeros(n ** m)
        for k, lab in enumerate(idx):
            if all(lab[a] == lab[b] for a, b in D):
                v[k] = 1.0
        out.append((D, v))
    return out


def antisym_pair(m, n, a, b):
    """(1 - swap(a,b))/2 on V^{tensor m}."""
    idx = index_tuples(m, n)
    pos = {t: k for k, t in enumerate(idx)}
    M = np.zeros((n ** m, n ** m))
    for k, t in enumerate(idx):
        M[k, k] += 0.5
        s = list(t)
        s[a], s[b] = s[b], s[a]
        M[pos[tuple(s)], k] -= 0.5
    return M


def rank(vs, tol=1e-8):
    if not len(vs):
        return 0
    return int(np.linalg.matrix_rank(np.array(vs), tol=tol))


def run(m=4):
    print("=" * 84)
    print(f"steps (ii) and (iii) in miniature at f = {m}, trivial label")
    print("=" * 84)
    for n in (2, 3, 4, 5):
        ops = diagram_ops(m, n)
        inv = invariant_vectors(m, n)
        Minv = np.array([v for _, v in inv])
        dim_inv = rank(Minv)
        e = antisym_pair(m, n, 0, 1) @ antisym_pair(m, n, 2, 3)
        eM = np.array([e @ v for _, v in inv])
        dim_eM = rank(eM)

        # the seed: delta_12 delta_34, the matching ((0,1),(2,3)); e kills it
        seed = dict(inv)[((0, 1), (2, 3))]
        assert np.allclose(e @ seed, 0), "the chosen seed was supposed to be killed by e"

        gen = rank([D @ seed for D in ops])
        gen_e = rank([e @ (D @ seed) for D in ops])
        print(f"  n={n}   dim M_triv = {dim_inv}   dim e.M_triv = {dim_eM}"
              f"   span{{nu(D) c_0}} = {gen}   span{{e nu(D) c_0}} = {gen_e}"
              f"   e.c_0 = 0: True   semisimple B_{m}({n}): {n >= m - 1}")
        assert gen == dim_inv, (
            f"at (f,n)=({m},{n}) a single nonzero seed failed to generate the whole "
            "multiplicity space, which would break step (ii) as an unconditional "
            "statement")
        assert gen_e == dim_eM, (
            f"at (f,n)=({m},{n}) the composite e nu(D) c_0 failed to span e.M_triv, "
            "which would break step (iii)")
    print("\n  Every row: one seed generates the whole multiplicity space, and the")
    print("  projected seeds span the whole projected space -- INCLUDING at n = 2,")
    print(f"  where n < f-1 = {m-1}, B_{m}(2) is NOT semisimple, and the reviewed")
    print("  script's own cell-module identity fails (35 against 82).")
    print("  And the seed is annihilated by e at every row, so it lies OUTSIDE the")
    print("  covariant space it generates.")


if __name__ == "__main__":
    run(4)


# ---------------------------------------------------------------------------
# A LARGER TARGET.  f = 4 leaves e.M_triv one-dimensional, where "spans" is
# trivially satisfied.  f = 6 with e = A_12 A_34 A_56 -- three antisymmetrised
# pairs, the same shape as three Weyl tensors -- gives a target of dimension > 1,
# and n = 2, 3 are both BELOW Rui's threshold n >= f-1 = 5.

def apply_diagram(D, v, idxj, m, n):
    """nu(D) v without forming the n^m by n^m matrix as a float array."""
    top = [(a, b) for a, b in D if a < m and b < m]
    bot = [(a - m, b - m) for a, b in D if a >= m and b >= m]
    cross = [(a, b - m) if a < m else (b, a - m) for a, b in D
             if (a < m) != (b < m)]
    ok_j = np.ones(len(idxj), dtype=bool)
    for a, b in top:
        ok_j &= idxj[:, a] == idxj[:, b]
    ok_i = np.ones(len(idxj), dtype=bool)
    for a, b in bot:
        ok_i &= idxj[:, a] == idxj[:, b]
    M = ok_j[:, None] & ok_i[None, :]
    for a, b in cross:
        M &= idxj[:, a][:, None] == idxj[:, b][None, :]
    return M @ v


def run_f6(n_list=(2, 3)):
    m = 6
    print("\n" + "=" * 84)
    print("f = 6, e = A_12 A_34 A_56 -- a target of dimension > 1, both n below "
          "the threshold n >= f-1 = 5")
    print("=" * 84)
    for n in n_list:
        idxj = np.array(index_tuples(m, n))
        inv = invariant_vectors(m, n)
        e = (antisym_pair(m, n, 0, 1) @ antisym_pair(m, n, 2, 3)
             @ antisym_pair(m, n, 4, 5))
        dim_inv = rank([v for _, v in inv])
        eM = [e @ v for _, v in inv]
        dim_eM = rank(eM)
        seed = dict(inv)[((0, 1), (2, 3), (4, 5))]
        killed = bool(np.allclose(e @ seed, 0))
        gen, gen_e = [], []
        for D in matchings(tuple(range(2 * m))):
            w = apply_diagram(D, seed, idxj, m, n)
            gen.append(w)
            gen_e.append(e @ w)
        print(f"  n={n}   dim M_triv = {dim_inv}   dim e.M_triv = {dim_eM}"
              f"   span{{nu(D) c_0}} = {rank(gen)}"
              f"   span{{e nu(D) c_0}} = {rank(gen_e)}"
              f"   e.c_0 = 0: {killed}   semisimple B_6({n}): {n >= m - 1}")
        assert rank(gen) == dim_inv
        assert rank(gen_e) == dim_eM
