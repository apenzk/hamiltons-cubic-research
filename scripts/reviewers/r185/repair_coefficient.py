"""Reviewer 185.  The repair for claim 1: the monomial coefficient the apolarity
pairing needs, computed from the ALREADY-VALIDATED unpolarised eval_diagram by
multivariate finite differences, and cross-checked against the symmetrisation of
the shipped eval_polarised.

Identity being verified, for J(W) = D_m(W) of degree 6 and W = sum_a x_a E_a:

    [x^beta] J  =  (6!/beta!) * Jsym(E_{beta})      (Jsym = symmetric polarisation)
                =  sum over the 6!/beta! DISTINCT vertex placements of the multiset
                     of eval_polarised

and, since the apolarity pairing is <q,J> = q(d/dx) J = sum_beta q_beta beta! [x^beta]J,
the quantity the 14 x 36 system needs is 6! * Jsym -- the SYMMETRIC polarisation,
never the vertex-ordered value that eval_polarised returns.

Cost: the finite-difference route costs prod(beta_a + 1) <= 64 calls to the cheap
int64 eval_diagram; the symmetrisation route costs 6!/beta! <= 720 calls to the
object-dtype eval_polarised.
"""
import sys, os, random, itertools, time
import numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..", "..", "..")
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI
import importlib.util
spec = importlib.util.spec_from_file_location(
    "pol", os.path.join(ROOT, "scripts", "runs", "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)
ep = pol.eval_polarised

P = 10007
inv = lambda x: pow(int(x) % P, P-2, P)

def coeff_fd(basis, beta, matching, k, p):
    """[prod x_a^{beta_a}] of J(sum_a x_a E_a), exactly over F_p, by a grid of
    prod(beta_a+1) evaluations of the UNPOLARISED eval_diagram + Lagrange."""
    s = len(basis)
    grid = [list(range(b+1)) for b in beta]
    # tabulate J on the grid
    tab = {}
    for pt in itertools.product(*grid):
        X = None
        for a, t in enumerate(pt):
            if t == 0: continue
            Y = (t * basis[a]) % p
            X = Y if X is None else (X + Y) % p
        if X is None: X = np.zeros_like(basis[0])
        tab[pt] = WI.eval_diagram(X, matching, k, p) % p
    # iterated univariate Lagrange: peel one axis at a time, keeping the top coeff
    cur = tab
    for a in range(s):
        xs = list(range(beta[a]+1)); n = len(xs)
        rest = [list(range(b+1)) for b in beta[a+1:]]
        nxt = {}
        for tail in itertools.product(*rest):
            ys = [cur[(x,) + tail] for x in xs]
            M = [[pow(x, j, p) for j in range(n)] + [ys[i]] for i, x in enumerate(xs)]
            r = 0
            for c in range(n):
                piv = next(i for i in range(r, n) if M[i][c] % p)
                M[r], M[piv] = M[piv], M[r]
                iv = inv(M[r][c]); M[r] = [v*iv % p for v in M[r]]
                for i in range(n):
                    if i != r and M[i][c]:
                        f = M[i][c]; M[i] = [(M[i][j]-f*M[r][j]) % p for j in range(n+1)]
                r += 1
            nxt[tail] = M[beta[a]][n]
        cur = nxt
    return cur[()] % p

def coeff_sym(basis, beta, matching, k, p):
    """same coefficient as the sum over the 6!/beta! distinct placements of ep."""
    seq = [a for a, b in enumerate(beta) for _ in range(b)]
    seen = set(); tot = 0
    for sg in itertools.permutations(seq):
        if sg in seen: continue
        seen.add(sg)
        tot = (tot + ep([basis[a] for a in sg], matching, p)) % p
    return tot % p, len(seen)

if __name__ == "__main__":
    N, K = 5, 6
    rng = np.random.default_rng(31); pyrng = random.Random(31)
    E = [WI.random_weyl(N, P, rng) for _ in range(3)]
    print("basis stand-ins: 3 random Weyl tensors E0,E1,E2 over F_p")
    for m_i in range(3):
        m = WI.random_matching(K, pyrng)
        print(f"\nmatching {m_i}")
        for beta in [(6,0,0), (5,1,0), (4,2,0), (3,3,0), (2,2,2), (1,2,3), (4,1,1)]:
            t0 = time.time(); cfd = coeff_fd(E, beta, m, K, P); tfd = time.time()-t0
            t0 = time.time(); csym, nplace = coeff_sym(E, beta, m, K, P); tsym = time.time()-t0
            naive = ep([E[a] for a, b in enumerate(beta) for _ in range(b)], m, P)
            ncalls = 1
            for b in beta: ncalls *= b+1
            print(f"  beta={beta}: FD={cfd:5d} ({ncalls:2d} eval_diagram calls, {tfd*1e3:6.1f} ms)"
                  f"  Sym={csym:5d} ({nplace:3d} ep calls, {tsym*1e3:7.1f} ms)"
                  f"  -> {'AGREE' if cfd==csym else 'DISAGREE'}"
                  f" | shipped-ep-as-coefficient = {naive:5d}"
                  f" ({'right' if naive==cfd else 'WRONG'})")
