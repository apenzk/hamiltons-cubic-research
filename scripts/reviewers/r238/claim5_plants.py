"""r238, claim 5 -- planted violations of the screen's three asserts, plus one
planted family that PASSES all three while violating the fact the screen claims
to exhibit.

The screen in run_a1_canonical_lift.py is not modified; its logic is reproduced
here and driven with mutated inputs.
"""
import numpy as np

rng = np.random.default_rng(3)

def weyl_project(R, n):
    R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2)
                + R.transpose(1, 0, 3, 2))
    R = 0.5 * (R + R.transpose(2, 3, 0, 1))
    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
    E = Ric - s / n * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
    return 0.5 * (W + W.transpose(2, 3, 0, 1))

Q1 = lambda W, n: np.einsum('ijkl,klmn,mnij->', W, W, W)
Q2 = lambda W, n: np.einsum('ikjl,kmln,minj->', W, W, W)
BASE = [Q1, Q2]

def ranks_over(diags, ns, samples=8, seed=3):
    global rng
    rng = np.random.default_rng(seed)
    out = []
    for n in ns:
        M = np.zeros((samples, len(diags)))
        for s in range(samples):
            W = weyl_project(rng.standard_normal((n, n, n, n)), n)
            for d, q in enumerate(diags):
                M[s, d] = q(W, n)
        sv = np.linalg.svd(M, compute_uv=False)
        out.append(int((sv > max(sv[0], 1.0) * 1e-9).sum()))
    return out

def run_screen(vals):
    """the three asserts of run_a1_canonical_lift.py, verbatim in structure"""
    fired = []
    if not all(vals[i] <= vals[i + 1] for i in range(len(vals) - 1)):
        fired.append("monotone")
    if not vals[0] < vals[-1]:
        fired.append("climb")
    if not vals[-1] == vals[-2]:
        fired.append("freeze")
    return fired

NS = (4, 5, 6, 7, 8, 10, 12)
print("baseline           ns=%s  ranks=%s  asserts fired: %s"
      % (NS, ranks_over(BASE, NS), run_screen(ranks_over(BASE, NS)) or "none (passes)"))
print()
print("PLANTED VIOLATIONS")
print("-" * 70)

# P1 -- monotonicity.  Visit the dimensions in the reverse order.
ns = tuple(reversed(NS))
v = ranks_over(BASE, ns)
print("P1 dimensions visited in reverse order")
print("     ranks=%s  fired: %s" % (v, run_screen(v)))
assert "monotone" in run_screen(v), "P1 failed to trip the monotonicity assert"

# P2 -- the climb.  Start above the threshold, so no relation ever dies.
ns = (6, 7, 8, 10, 12)
v = ranks_over(BASE, ns)
print("P2 dimension list starts at n=6, above the collapse")
print("     ranks=%s  fired: %s" % (v, run_screen(v)))
assert "climb" in run_screen(v), "P2 failed to trip the climb assert"

# P2' -- the climb, by a degenerate diagram set (the second diagram duplicated).
v = ranks_over([Q1, lambda W, n: 2.0 * Q1(W, n)], NS)
print("P2' second diagram replaced by a multiple of the first")
print("     ranks=%s  fired: %s" % (v, run_screen(v)))
assert "climb" in run_screen(v), "P2' failed to trip the climb assert"

# P3 -- the freeze.  Stop at n=6, one dimension after the climb.
ns = (4, 5, 6)
v = ranks_over(BASE, ns)
print("P3 dimension list truncated at n=6, right at the climb")
print("     ranks=%s  fired: %s" % (v, run_screen(v)))
assert "freeze" in run_screen(v), "P3 failed to trip the freeze assert"

print()
print("THE PLANT THE SCREEN DOES NOT CATCH")
print("-" * 70)
# P4 -- a diagram family whose kernels DO NOT NEST: fact (ii) is false for it,
# and every one of the three asserts passes.  Q2n is Q2 plus an explicitly
# n-dependent multiple of Q1 -- exactly what a diagram carrying a detached
# delta-loop would contribute (r232's own control had value 46416*n).
Q2n = lambda W, n: Q2(W, n) + n * Q1(W, n)
v = ranks_over([Q1, Q2n], NS)
print("P4 diagram 2 replaced by  q2 + n*q1  (a detached delta-loop, r232's control)")
print("     ranks=%s  fired: %s" % (v, run_screen(v) or "NONE -- the screen PASSES"))
assert run_screen(v) == [], "P4 was supposed to pass the screen"

# and now show fact (ii) is false for it: the kernel line moves with n
print()
print("     but the kernel of this family is a DIFFERENT line at n=4 and n=5:")
for n in (4, 5):
    rng2 = np.random.default_rng(500 + n)
    M = np.zeros((300, 2))
    for s in range(300):
        W = weyl_project(rng2.standard_normal((n, n, n, n)), n)
        M[s, 0] = Q1(W, n); M[s, 1] = Q2n(W, n)
    _, sv, vt = np.linalg.svd(M, full_matrices=False)
    k = vt[1] / vt[1][1]
    print("        n=%d  rank %d  kernel  q1 : q2  =  %+.6f : 1"
          % (n, int((sv > max(sv[0], 1.0) * 1e-9).sum()), k[0]))
print("     ker eps_5 is NOT contained in ker eps_4 -- fact (ii) fails outright --")
print("     and the screen reports the mechanism 'visible'.")
print()
print("ALL PLANTS BEHAVED AS PREDICTED.")
