"""r240, claim 5 -- can the kernel-nesting check's tolerances misreport nesting?

The check under review (762593e, run_a1_canonical_lift.py):

    kernel_at: SVD of the samples x diagrams matrix, numerical rank from
               tol = max(sv[0], 1.0) * 1e-9, kernel = the TRAILING right-singular
               rows Vt[r:]
    nested:    P = K_small.T @ pinv(K_small.T); rows of K_big are inside the span
               iff max|K_big - (P K_big^T)^T| < 1e-6

Fact (ii) -- ker eps_n contained in ker eps_{n_0} -- is a statement about
SUBSPACES of the free span V of diagram symbols, so it is invariant under any
invertible change of basis of V: rescaling a diagram symbol, or replacing one
symbol by a combination, cannot change whether the kernels nest.  That is the
lever this script uses.  Every plant below is such a change of basis, or a
perturbation of known exact size, and the question is whether the reported
verdict tracks the mathematics.

The functions are COPIED, not imported: the file under review runs its asserts at
import time and hygiene forbids touching it.
"""
import numpy as np

rng = np.random.default_rng(3)


def weyl_project(R, n):
    R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2)
                + R.transpose(1, 0, 3, 2))
    R = 0.5 * (R + R.transpose(2, 3, 0, 1))
    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R)
    s = np.trace(Ric)
    E = Ric - s / n * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
    return 0.5 * (W + W.transpose(2, 3, 0, 1))


DIAGS = [
    lambda W: np.einsum('ijkl,klmn,mnij->', W, W, W),
    lambda W: np.einsum('ikjl,kmln,minj->', W, W, W),
]


def samples_matrix(diags, n, samples=8, seed=None):
    r = rng if seed is None else np.random.default_rng(seed)
    M = np.zeros((samples, len(diags)))
    for s_ in range(samples):
        W = weyl_project(r.standard_normal((n, n, n, n)), n)
        for d, q in enumerate(diags):
            M[s_, d] = q(W)
    return M


def kernel_at(diags, n, samples=8, seed=None, rtol=1e-9):
    """verbatim in structure: trailing right-singular rows at a relative tol."""
    M = samples_matrix(diags, n, samples, seed)
    U, sv, Vt = np.linalg.svd(M)
    tol = max(sv[0], 1.0) * rtol
    r = int((sv > tol).sum())
    return Vt[r:], sv


def nested(K_big, K_small, tol=1e-6):
    if K_big.shape[0] == 0:
        return True
    if K_small.shape[0] == 0:
        return False
    P = K_small.T @ np.linalg.pinv(K_small.T)
    return bool(np.max(np.abs(K_big - (P @ K_big.T).T)) < tol)


DIMS = [4, 5, 6, 7, 8, 10, 12]
SEED = 7

print("=" * 78)
print("A.  WHAT THE CHECK ACTUALLY TESTS -- the kernel dimensions it sees")
print("=" * 78)
dims_seen = {}
for n in DIMS:
    K, sv = kernel_at(DIAGS, n, seed=SEED + n)
    dims_seen[n] = K.shape[0]
    print(f"    n={n:>3}: sv = [{sv[0]:.3e}, {sv[1]:.3e}]  ratio {sv[1]/sv[0]:.2e}"
          f"   kernel dim {K.shape[0]}")
nontrivial = [(a, b) for a, b in zip(DIMS, DIMS[1:]) if dims_seen[b] > 0]
print(f"\n    comparisons the loop makes: {len(DIMS) - 1}")
print(f"    comparisons with a NON-EMPTY K_big (nested() returns True on an empty")
print(f"    K_big before looking at K_small): {len(nontrivial)}  -> {nontrivial}")
print("    So exactly one containment in the whole screen has content, and every")
print("    n >= 6 comparison is 'True' by the empty-kernel early return.")

print()
print("=" * 78)
print("B.  MISREPORT IN THE 'NESTED' DIRECTION -- a real violation of fact (ii)")
print("    that the 1e-6 projector tolerance calls nesting")
print("=" * 78)
print("    plant P4(eps): second diagram -> q2 + eps*n*q1.  Fact (ii) is FALSE for")
print("    every eps != 0 (the kernel line is -(eps*n + 1/2) : 1, so it MOVES with")
print("    n).  eps = 1 is the committed regression case.  Where does the verdict")
print("    flip?\n")
print(f"    {'eps':>10}  {'kernel line n=4':>20}  {'kernel line n=5':>20}  "
      f"{'residual':>10}  verdict")
flip = None
for e in (1.0, 1e-2, 1e-4, 1e-5, 1e-6, 3e-7, 1e-7, 1e-8, 1e-10):
    P4 = [DIAGS[0], (lambda ee: (lambda W: DIAGS[1](W) + ee * W.shape[0] * DIAGS[0](W)))(e)]
    K4, _ = kernel_at(P4, 4, seed=SEED + 4)
    K5, _ = kernel_at(P4, 5, seed=SEED + 5)
    def line(K):
        v = K[0] / K[0][np.argmax(np.abs(K[0]))]
        return f"{v[0]:+.6f} : {v[1]:+.6f}"
    P = K4.T @ np.linalg.pinv(K4.T)
    res = float(np.max(np.abs(K5 - (P @ K5.T).T)))
    ok = nested(K5, K4)
    if ok and flip is None:
        flip = e
    print(f"    {e:>10.0e}  {line(K4):>20}  {line(K5):>20}  {res:>10.2e}  "
          f"{'NESTED (missed)' if ok else 'fails, correctly'}")
print(f"\n    The check stops seeing the violation at eps ~ {flip:.0e}: the residual")
print("    is linear in eps, so the screen certifies nesting only to 1e-6 in angle.")
print("    A violation of fact (ii) whose coefficient is below that is invisible.")

print()
print("=" * 78)
print("C.  MISREPORT IN THE 'NOT NESTED' DIRECTION -- the fatal one, because it")
print("    is an assert that kills the run.  A pure CHANGE OF BASIS of V, which")
print("    cannot change fact (ii), is turned into a failure by the 1e-9 rank")
print("    tolerance")
print("=" * 78)
print("    Basis change T_b:  q1' = q1,  q2' = b * (q2 - 0.5*q1).")
print("    Invertible for every b != 0, and q2 - 0.5*q1 is the relation itself, so")
print("    at n = 4, 5 the second column is PURE ROUNDOFF, of size ~1e-15*|q1|.")
print("    Multiplying it by b lifts that roundoff through the 1e-9 rank tolerance")
print("    at a rate that differs between n = 4 and n = 5, because the roundoff")
print("    does.  ker eps_n is unchanged as a subspace in every row.\n")
print("    Two steps.  First, how far apart the two roundoff floors sit -- they are")
print("    independent samples of the same 1e-15-scale noise, so which of n = 4 and")
print("    n = 5 is larger is a coin toss over the sampling seed, and the screen")
print("    draws from an unseeded global rng:\n")
base = [DIAGS[0], lambda W: (DIAGS[1](W) - 0.5 * DIAGS[0](W))]
hits = []
NSEED = 120
for sd in range(NSEED):
    _, s4 = kernel_at(base, 4, seed=1000 + sd)
    _, s5 = kernel_at(base, 5, seed=2000 + sd)
    r4, r5 = s4[1] / s4[0], s5[1] / s5[0]
    if r4 > r5:
        hits.append((sd, r4, r5))
print(f"    over {NSEED} seeds, the n=4 floor exceeds the n=5 floor in {len(hits)}")
print(f"    of them ({100*len(hits)//NSEED}%).  For any such seed there is a window of b")
print("    with rank 2 read at n = 4 (kernel EMPTY) and rank 1 at n = 5 (kernel a")
print("    line), and nested() returns False on an empty K_small by construction.\n")
print(f"    {'seed':>6}  {'floor n=4':>11}  {'floor n=5':>11}  {'b':>10}  "
      f"{'ker dims 4,5':>13}   ker5 in ker4")
firing = 0
for sd, r4, r5 in hits[:6]:
    bb = 1e-9 / r4 * 1.05
    B = [DIAGS[0],
         (lambda q: (lambda W: q * (DIAGS[1](W) - 0.5 * DIAGS[0](W))))(bb)]
    K4, _ = kernel_at(B, 4, seed=1000 + sd)
    K5, _ = kernel_at(B, 5, seed=2000 + sd)
    ok = nested(K5, K4)
    firing += (not ok)
    print(f"    {sd:>6}  {r4:>11.2e}  {r5:>11.2e}  {bb:>10.2e}  "
          f"{str([K4.shape[0], K5.shape[0]]):>13}   {ok}"
          f"{'   <-- ASSERTION FIRES' if not ok else ''}")
print(f"\n    FALSE ALARM WITNESS: {firing} of those 6 abort with 'ker eps_5 is NOT")
print("    contained in ker eps_4 -- fact (ii) is the padding step the whole")
print("    reduction rests on', on a RELABELLING of the diagram basis that moves no")
print("    kernel anywhere.  The tolerance, not the mathematics, decided it.")
print("    b ~ 4e5 is not exotic: it is the ratio between the largest and smallest")
print("    entry of a Brauer Gram whose entries carry n^0 ... n^6 at n = 12, which")
print("    is 12^6 = 3.0e6 before any coefficient is counted.")

print()
print("=" * 78)
print("D.  THE max(sv[0], 1.0) CLAMP -- an absolute floor inside a relative test")
print("=" * 78)
print("    Scaling BOTH diagram symbols by c (the most innocuous basis change")
print("    there is -- a choice of normalisation for the diagram symbols) with")
print("    c small enough that sv[0] < 1 turns the relative tolerance into the")
print("    absolute 1e-9, and the whole matrix reads as rank 0.\n")
print(f"    {'c':>10}  {'sv[0] at n=6':>14}  {'rank':>5}  {'kernel dim':>10}   nesting reported")
for c in (1.0, 1e-6, 1e-9, 1e-12, 1e-14, 1e-16):
    B = [(lambda cc: (lambda W: cc * DIAGS[0](W)))(c),
         (lambda cc: (lambda W: cc * DIAGS[1](W)))(c)]
    K6, sv6 = kernel_at(B, 6, seed=SEED + 6)
    K5, _ = kernel_at(B, 5, seed=SEED + 5)
    print(f"    {c:>10.0e}  {sv6[0]:>14.3e}  {2 - K6.shape[0]:>5}  {K6.shape[0]:>10}"
          f"   ker6 in ker5: {nested(K6, K5)}")
print("\n    At c = 1e-16 every kernel is the whole of R^2, every containment holds,")
print("    and the check reports fact (ii) verified while measuring nothing.")

print()
print("=" * 78)
print("E.  THE PROJECTOR ITSELF IS FINE")
print("=" * 78)
print("    K_small's rows come out of an SVD, so they are orthonormal; pinv(K^T)")
print("    is then K itself and P = K^T K is an exact orthogonal projector.")
for n in (4, 5):
    K, _ = kernel_at(DIAGS, n, seed=SEED + n)
    P = K.T @ np.linalg.pinv(K.T)
    print(f"    n={n}: ||K K^T - I|| = {np.linalg.norm(K @ K.T - np.eye(K.shape[0])):.2e}"
          f"   ||P^2 - P|| = {np.linalg.norm(P @ P - P):.2e}"
          f"   ||P - P^T|| = {np.linalg.norm(P - P.T):.2e}")
print("    So the 1e-6 is a pure angle tolerance, not a conditioning artefact of")
print("    pinv: the rcond default never bites here.  The failure modes are B, C, D.")
