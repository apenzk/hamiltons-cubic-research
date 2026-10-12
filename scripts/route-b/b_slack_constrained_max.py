"""max theta subject to S = 0, over curvature operators -- route B's residual, tested.

THE SLACK HAS A ONE-LINE FORM IN THE EIGENBASIS.  S is the part of [m, m] landing
back in m, for m the negative eigenspace of W.  In an eigenbasis of W the bracket's
components are the structure constants themselves, so

    S(W)  =  sum over alpha, beta, gamma with lam < 0  of  c'^2_{alpha beta gamma},

the structure mass carried by the negative eigenspace.  For a diagonal W this is
the triangle count of the negative graph, matching the recorded
S_struct = 3 x (triangles), and it needs no block-constancy to state.

S = 0 IS AUTOMATIC WHEN THE NEGATIVE EIGENSPACE IS SMALL.  c' is antisymmetric in
three indices, so it vanishes identically on a subspace of dimension <= 2.  Hence

    dim m <= 2  =>  S = 0,

and {S = 0} contains that whole stratum -- including padded W_CP2, whose spectrum
is (2,-1,-1)/sqrt(6) with exactly two negative eigenvalues.  The sharp case of
route B's residual therefore sits where the S = 0 hypothesis says nothing at all.

AND THAT STRATUM'S MAXIMUM IS EXACTLY sqrt(3/2).  Maximising theta over Weyl_n with
the third-most-negative eigenvalue pushed to zero, seven starts out of seven at
n = 6 and n = 8 converge to 1.224745 -- padded W_CP2's value.  (The penalty leaves
that eigenvalue at about 1e-5, so this is the limit of a sequence approaching the
stratum, not a point exactly in it.)

BIANCHI ALONE IS AN UNSAFE RELAXATION FOR THETA, THOUGH IT WAS SAFE FOR THE BOUND.
Run over the curvature-operator subspace instead of Weyl_n, the same maximisation
returns sqrt(2(n-1)/n) -- 1.290994 at n = 6 and 1.322876 at n = 8 -- with S = 0
exactly.  That is the ROUND SPHERE, W = I/sqrt(N), for which Q(I) = (n-1)I; it has
no negative eigenvalues at all and is not Ricci-flat.  Since sqrt(2(n-1)/n) exceeds
theta_0(n), dropping Ricci-flatness here would have manufactured a refutation of
Conjecture A out of a tensor that is not a Weyl tensor.

A SPARSE REWRITE WAS TRIED AND DISCARDED.  c has only 6 C(n,3) nonzeros -- 1320 at
n = 12 -- so S = <c, c(P,P,P)> can be contracted over a 1320 x 1320 outer product
instead of an N^4 einsum.  Both were implemented and run against each other: they
agree to 1e-14 at n = 6, 8, 10, and the sparse one is 20x SLOWER (18.9 ms against
0.9 ms at n = 12), because the einsum below is BLAS-backed while fancy indexing is
not.  Only the einsum is kept.  The measurement also corrected a wrong assumption:
S costs about 1 ms at n = 12, so a FULL gradient over Weyl_12 is affordable and the
subspace gradient that failed there was never necessary.

THE GUARD.  m jumps when an eigenvalue crosses zero, so S is only locally
continuous and a penalty can sit on a discontinuity.  Every reported optimum is
re-measured for S at the returned point, and any run whose S exceeds 1e-6 is
reported as a failure rather than a value.  The S = 0 ascent below is ALSO blind:
at n = 6 it reaches 1.0605 while padded W_CP2 sits at 1.2247 with S = 0 exactly, so
its numbers are a lower bound on the supremum and nothing more.

FALSIFIER.  An S = 0 Weyl tensor with theta > sqrt(3/2) at n >= 12, or a
non-diagonal one at any n above the values already catalogued.
"""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, weyl_basis, normalize, Q
from b_bianchi_constraint import curvature_basis
from b_diagonality_split import off_diagonal_mass


def slack(n, W, c=None, tol=1e-9):
    c = adj(n) if c is None else c
    lam, V = np.linalg.eigh(W)
    Vm = V[:, lam < -tol]
    if Vm.shape[1] < 3:
        return 0.0
    T = np.einsum('abg,ap,bq,gr->pqr', c, Vm, Vm, Vm, optimize=True)
    return float((T ** 2).sum())


def theta(n, W):
    return float(np.tensordot(W, Q(n, W)))


def ascend(n, B, c, seed, rho, iters=90, step=0.2, warm=None):
    D = B.shape[0]
    W_of = lambda z: normalize(np.einsum('d,dij->ij', z, B))
    rng = np.random.default_rng(seed)
    x = warm.copy() if warm is not None else rng.normal(size=D)
    x /= np.linalg.norm(x)
    f = lambda z: theta(n, W_of(z)) - rho * slack(n, W_of(z), c)
    v = f(x); h = 1e-5
    for _ in range(iters):
        g = np.empty(D)
        for d in range(D):
            e = np.zeros(D); e[d] = h
            g[d] = (f(x + e) - v) / h
        g -= (g @ x) * x; gn = np.linalg.norm(g)
        if gn < 1e-10:
            break
        g /= gn
        for t in (step, step / 2, step / 4, step / 8):
            xn = x + t * g; xn /= np.linalg.norm(xn)
            if f(xn) > v + 1e-13:
                x, v = xn, f(xn); break
        else:
            step /= 2
            if step < 1e-7:
                break
    return x, W_of(x)


if __name__ == "__main__":
    print(f"target: sqrt(3/2) = {np.sqrt(1.5):.6f}")
    for n in (6, 8):
        c = adj(n); B = curvature_basis(n); Bw = np.asarray(weyl_basis(n))
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        print(f"\n=== n = {n}: Bianchi subspace dim {B.shape[0]}, "
              f"theta_0 = {th0:.6f} ===")
        t0 = time.time()
        best = None
        for s in range(5 if n == 6 else 3):
            x = None
            for rho in (1.0, 10.0, 100.0, 1e3, 1e4):
                x, W = ascend(n, B, c, 40 + s, rho, warm=x)
            S = slack(n, W, c)
            th = theta(n, W)
            Wp = np.einsum('d,dij->ij', np.einsum('dij,ij->d', Bw, W), Bw)
            dw = float(np.linalg.norm(W - Wp) / np.linalg.norm(W))
            ok = S < 1e-6
            tag = "" if ok else "   FAILED -- S did not reach 0, not a value"
            print(f"  start {s}: theta = {th:.6f}  S = {S:.2e}  "
                  f"dist to Weyl = {dw:.4f}{tag}")
            if ok and (best is None or th > best[0]):
                best = (th, W)
        if best is not None:
            th, W = best
            print(f"  best S=0 theta = {th:.6f}   vs sqrt(3/2) = {np.sqrt(1.5):.6f}, "
                  f"theta_0({n}) = {th0:.6f}")
            print(f"  off-diagonal mass at it = {off_diagonal_mass(W):.4f}  "
                  f"[{time.time()-t0:.0f}s]")
