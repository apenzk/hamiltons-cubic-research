"""The B_n extension of an O(n_0)-invariant IS O(n)-invariant.  A theorem.

THE QUESTION (reviewer 227's residue).  Levin-Chandrasekaran's machinery works
over {B_n}, the signed permutations, where every presentation degree is
computable -- and fails over {O_n}, where Definition 2.7 never applies.  Running
Theorem 3.5 over B_n yields, for n_0 at or above the B_n-presentation degree
k_B, a UNIQUE B_n-invariant extension u_n of any u_{n_0}.  The open question was
whether that extension is O(n)-invariant when u_{n_0} is O(n_0)-invariant.

IT IS, AND THE PROOF IS TWO STEPS.  Each step uses the side that is good for it:
uniqueness comes from the FINITE group, where presentation degrees exist;
existence of an invariant lift comes from the CONTINUOUS group, where the first
fundamental theorem lives.

  Theorem.  Let U_n = Sym^d(W_n^*) with the padding embeddings and their adjoint
  restrictions.  (An earlier version said "or any polynomial-functor module of
  the standard representation".  That is WRONG GENERALITY, reviewer 232: W_n is
  NOT a polynomial functor of R^n, trace-freeness being metric-dependent --
  g = diag(1,1,1,2) gives max|Ric| = 864.  The statement was true and excluded
  the one case it is invoked for.  What carries it is the trace-free padding
  lemma, verified exactly.)  Let k_B be the presentation degree of {U_n} over the {B_n}
  consistent sequence (finite: B_n is one of Levin-Chandrasekaran's classical
  Weyl-group sequences, Theorem 2.11).  Fix n_0 >= k_B and u_{n_0} in
  U_{n_0}^{O(n_0)}.  Then for every n >= n_0 the unique B_n-invariant element
  u_n with P u_n = u_{n_0} is O(n)-invariant.

  Proof.
  (1) RESTRICTION OF O-INVARIANTS IS SURJECTIVE, AT EVERY n >= n_0, WITH NO
      STABILITY HYPOTHESIS.  By the first fundamental theorem for O(m) --
      spanning holds at every m, only independence needs the stable range --
      u_{n_0} = sum_D c_D q_D^{(n_0)} over complete-contraction diagrams D.
      Each D defines the invariant q_D^{(n)} at every n.  Evaluating q_D^{(n)}
      on a PADDED tensor collapses every contraction sum to the n_0 range,
      because each index is attached to a W-factor that vanishes there and the
      perfect matching leaves no free delta-loop to contribute a factor of n.
      So q_D^{(n)} restricts to q_D^{(n_0)}, and w_n := sum_D c_D q_D^{(n)} is
      an O(n)-invariant with P w_n = u_{n_0}.
  (2) UNIQUENESS ON THE B-SIDE FORCES u_n = w_n.  w_n is O(n)-invariant, hence
      B_n-invariant.  By Proposition 2.9 the projection U_n^{B_n} ->
      U_{n_0}^{B_{n_0}} is an isomorphism for n >= n_0 >= k_B, so at most one
      B_n-invariant restricts to u_{n_0}.  Hence u_n = w_n, which is
      O(n)-invariant.  QED

WHAT THIS CLOSES AND WHAT IT DOES NOT.

  PROVED, BUT NOT APPLICABLE AT n_0 = 12.  The invariance statement holds for
  every n once n_0 >= k_B.  THE HYPOTHESIS IS UNMET AT TWELVE (reviewer 232):

    k_B >= 24 > 12.

  {W_n} is generated in degree exactly 4 over B_n, and a coordinate-support
  argument gives generation degree exactly 4*ell for Sym^ell(W_n), with
  presentation degree at least generation degree.  For the degree-6 certificate,
  ell = 6 and 4*ell = 24.  Worse, Theorem 2.11's calculus delivers no k_B here at
  all: its kernel clause needs the adjoint to be a morphism, equivalent to Ric
  commuting with TRUNCATION, which it does not; and its sums clause needs the
  Ricci part padding-closed, which holds only for h proportional to I -- and the
  round sphere is exactly that exception, so testing with S^{n_0} shows the
  opposite of the truth.

  The generation lemma (run_bn_generates_on.py) is NOT superseded, since this
  theorem does not apply in the range the programme needs.  Both stand as
  conditional results.

  NOT CLOSED, and now the WHOLE remaining obstruction: the target mismatch.
  The theorem applies to the sharp target G_{mu,n_0} and returns its extension
  -- which is Theta_{n_0}^2 A_n - B_n + mu(C_n - B_n), O(n)-invariant and NOT
  the sharp target at level n.  Consistent with the free-description fence post
  (run_theta_free_description.py): the extension exists, is invariant, and
  certifies the WRONG constant above n_0.  Equivariance was never the
  obstruction; the moving constant is.

  CONSEQUENCE FOR THE ROUTE.  A B_n-freely-described certificate built at n_0
  is automatically O(n)-equivariant at every level, so the transfer problem
  reduces to its arithmetic core: exhibit a certificate FAMILY B(n), entries
  rational in n, PSD for all n >= 12, matching the moving target -- the
  Blekherman-Riener shape, for O(n) in place of S_n.  The stability theorem
  says the SDP has constant shape there; the pairing data varies polynomially
  in n through Brauer loop factors.  That reformulation is the next item.

  THE OWED CHECK IS ANSWERED, AND NEGATIVELY.  k_B for Sym^6(W_n^*) is at least
  24, so a transfer certificate would have to be built at n_0 = 24 rather than
  12.  By the stability theorem the SDP there has the SAME shape -- 71 blocks,
  184 multiplicities, 477 unknowns -- so only the covariant construction grows.
  That is a cost, and it is now a derived one rather than the struck guess this
  file's predecessor carried.

THE SCREEN.  The theorem's mechanism runs in miniature on degree-4 polynomials
on R^m, where every space is computable exactly: B_m-invariants are
span{f1 = sum x_i^4, f2 = (sum x_i^2)^2}, O(m)-invariants are span{f2}.
  * the B-side projection is injective at n_0 = 3 (uniqueness holds), and
    FAILS at n_0 = 1 where f1 = f2 -- exhibiting k_B > 1, the hypothesis doing
    real work;
  * the unique B-extension of the O-invariant f2^(3) is f2^(5): O-invariant,
    as the theorem says;
  * THE CONTROL: the B-extension of f1^(3) -- B-invariant but NOT O-invariant
    -- is f1^(5), and a random rotation moves it by O(1).  So the conclusion
    genuinely depends on the O-invariance of the seed, and the screen can fail.
"""
import numpy as np

rng = np.random.default_rng(7)

def f1(x): return (x ** 4).sum()
def f2(x): return (x ** 2).sum() ** 2

def coeffs_from_values(m, g, k=40):
    """express g on R^m in the basis {f1, f2}, by least squares on samples;
    residual reported so a g OUTSIDE the span is caught, not absorbed."""
    X = rng.standard_normal((k, m))
    A = np.column_stack([[f1(x) for x in X], [f2(x) for x in X]])
    y = np.array([g(x) for x in X])
    c, res, *_ = np.linalg.lstsq(A, y, rcond=None)
    r = np.linalg.norm(A @ c - y) / max(1.0, np.linalg.norm(y))
    return c, r

# --- uniqueness: the restriction matrix on span{f1,f2}, level n=5 -> n_0 ---
def restriction_matrix(n, n0):
    """columns: restrictions of f1^(n), f2^(n) to R^{n0}, in the n_0 basis."""
    cols = []
    for f in (f1, f2):
        g = lambda x, f=f: f(np.concatenate([x, np.zeros(n - n0)]))
        c, r = coeffs_from_values(n0, g)
        assert r < 1e-9, f"restriction left the span (residual {r:.2e})"
        cols.append(c)
    return np.column_stack(cols)

M3 = restriction_matrix(5, 3)
s3 = np.linalg.svd(M3, compute_uv=False)
print(f"  restriction matrix at n_0=3: singular values {s3.round(6)}")
assert s3.min() > 1e-9, (
    "the B-side projection is singular at n_0=3, so the 'unique extension' the "
    "theorem quantifies over does not exist and step (2) is vacuous")

M1 = restriction_matrix(5, 1)
s1 = np.linalg.svd(M1, compute_uv=False)
print(f"  restriction matrix at n_0=1: singular values {s1.round(6)}")
assert s1.min() < 1e-9, (
    "at n_0=1 the two invariants coincide (x^4 = (x^2)^2), so the projection "
    "MUST be singular; nonsingularity here means the basis evaluation is wrong, "
    "and the exhibit that k_B > 1 -- the hypothesis doing work -- is lost")

# --- the theorem's instance, and the control ---
def b_extension(target_c, n, n0):
    """solve for the B_n-invariant a*f1 + b*f2 restricting to the target."""
    M = restriction_matrix(n, n0)
    return np.linalg.solve(M, target_c)

def o_invariance_defect(c, n, trials=6):
    d = 0.0
    for _ in range(trials):
        A = rng.standard_normal((n, n))
        Q, _ = np.linalg.qr(A)
        x = rng.standard_normal(n)
        g  = c[0] * f1(x) + c[1] * f2(x)
        gR = c[0] * f1(Q @ x) + c[1] * f2(Q @ x)
        d = max(d, abs(g - gR) / max(1.0, abs(g)))
    return d

ext = b_extension(np.array([0.0, 1.0]), 5, 3)      # seed: f2, O(3)-invariant
print(f"\n  B-extension of the O-invariant f2: coefficients {ext.round(9)}")
assert abs(ext[0]) < 1e-8 and abs(ext[1] - 1) < 1e-8, (
    f"the extension of f2 came out {ext}, not (0, 1): the unique B-extension "
    "of an O-invariant failed to be the diagram lift, refuting step (2)")
d = o_invariance_defect(ext, 5)
print(f"  O(5)-invariance defect: {d:.2e}")
assert d < 1e-9, "the extension of an O-invariant seed is not O(n)-invariant"

ctl = b_extension(np.array([1.0, 0.0]), 5, 3)      # control: f1, NOT O-invariant
dc = o_invariance_defect(ctl, 5)
print(f"\n  CONTROL -- B-extension of f1 (not O-invariant): defect {dc:.2e}")
assert dc > 1e-3, (
    "the control failed to fail: the extension of a non-O-invariant seed came "
    "out O(n)-invariant, so this screen cannot distinguish the theorem from "
    "'every B-extension is O-invariant', which is false")

print("\n  THEOREM SCREENED.  Uniqueness needs n_0 >= k_B (k_B > 1 exhibited);")
print("  the extension of an O-invariant is O-invariant; the control fails as")
print("  it must.  The Weyl-level statement rests on the FFT, which is classical.")
