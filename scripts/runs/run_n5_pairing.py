"""<P_i conj(P_j), J_b> without per-monomial coefficient extraction.

The naive route -- expand the product into ~86000 weight-coordinate monomials
and extract each J_b coefficient -- costs about 36 million eval_diagram calls.
It is unnecessary.

THE DESIGN BELOW IS WRONG, and reviewer 187 refuted it with a measurement.

D_b, the polarisation of the diagram, is a SYMMETRIC multilinear form, and
P_i conj(P_j) corresponds to U_i (x) conj(U_j) symmetrised, where U_i is the
highest-weight vector itself, an element of Sym^3.  By symmetry of D_b every one
of the C(6,3) = 20 slot-splittings gives the same value, so

    <P_i conj(P_j), J_b>  =  20 * D_b(U_i in slots 1-3 ; conj(U_j) in slots 4-6)

up to one uniform constant, and U_i is a sum of at most 195 triples of
weight-basis tensors.  That is |supp(U_i)| * |supp(U_j)| evaluations of the
VERTEX-ORDERED multilinear form -- which is exactly what eval_polarised is.

THE ERROR, and it is the same one twice.  eval_polarised is VERTEX-ORDERED, not
symmetric -- 185 and 186 both established that, and 187 measured the 20 slot-
splittings taking 12 to 16 DISTINCT values rather than agreeing.  So the "times
20" is false and the vertex-ordered value is again being used where the
symmetrisation is needed.  The 40-minute projection below is short by a factor
of about 20.

What is actually wanted is the symmetric polarisation, which is the SUM over
splittings.  coeff([A, B], [3, 3], ...) returns exactly that for single tensors,
at 4^2 = 16 eval_diagram calls; for the triples that make up U_i it is the
beta = (1,1,1,1,1,1) coefficient, 2^6 = 64 calls, against 720 for a full S6
average.  The assembly needs recosting on that basis before it is run.
"""
import sys, os, time, numpy as np, random
d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(d, "..", "reviewers", "r179"))
import importlib.util
import weyl_invariants as WI
spec = importlib.util.spec_from_file_location("pol", os.path.join(d, "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)

P, K, N = 65537, 6, 5          # p = 1 mod 4, so i = 256 exists (256^2 = -1)
assert pow(256, 2, P) == P - 1

rng = np.random.default_rng(2); pyrng = random.Random(2)
T = [WI.random_weyl(N, P, rng) for _ in range(6)]
m = WI.random_matching(K, pyrng)

t0 = time.time(); R = 40
for _ in range(R): pol.eval_polarised(T, m, P)
per = (time.time()-t0)/R
print(f"  one vertex-ordered evaluation: {per*1e3:.1f} ms")

supp = 49          # measured mean support of the highest-weight vectors
pairs, ndiag = 36, 14
calls = supp*supp*pairs*ndiag
print(f"  calls for the whole 36 x 14 system: {supp}^2 x {pairs} x {ndiag} = {calls:,}")
print(f"  projected wall time: {calls*per/3600:.1f} h  <- decides whether this route runs")
print(f"\n  against the naive per-monomial route at ~36,300,000 eval_diagram calls.")
