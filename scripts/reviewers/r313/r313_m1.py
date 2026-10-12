"""M1: Lemma 69.  Arithmetic re-derived, and the assembly attacked directly through
the classification of Z2-gradings of so(n) rather than through symmetric spaces."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r313')
import r313_lib as R
from fractions import Fraction as F

def sphere_pair_diag(n, k):
    """the unique so(k)+so(n-k)-invariant Weyl tensor, as a hollow symmetric M (diagonal locus)."""
    l = n - k
    # rows: (k-1)a + l g = 0 ; (l-1)b + k g = 0 ; set g = 1
    if k >= 2 and l >= 2 and k != 1 and l != 1:
        g = F(1)
        a = F(-l, k - 1) if k > 1 else F(0)
        b = F(-k, l - 1) if l > 1 else F(0)
    else:
        return None
    M = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            if i == j: continue
            if i < k and j < k: M[i, j] = float(a)
            elif i >= k and j >= k: M[i, j] = float(b)
            else: M[i, j] = float(g)
    return M

def W_from_diag(n, M):
    P = R.pairs(n); N = len(P)
    W = np.zeros((N, N))
    for t, (i, j) in enumerate(P):
        W[t, t] = M[i, j]
    return W

print("=== M1(a) theta at S^p x S^q, from my own Q, against the f(m) arithmetic ===")
print(f"{'n':>3} {'p':>3} {'q':>3} {'theta':>14} {'res':>10} {'X=1/(p-1)+1/(q-1)-1/(n-1)':>26} {'X<=1/3':>7} {'th>=sq(3/2)':>12}")
bad = []
for n in list(range(8, 19)) + [24]:
    for k in range(2, n // 2 + 1):
        M = sphere_pair_diag(n, k)
        if M is None: continue
        W = W_from_diag(n, M)
        W = W / np.sqrt(np.tensordot(W, W, axes=2))
        res, th = R.crit_residual(n, W)
        if th < 0:
            W = -W; res, th = R.crit_residual(n, W)
        X = 1.0/(k-1) + 1.0/(n-k-1) - 1.0/(n-1)
        agree = (X <= 1/3 + 1e-12) == (th >= np.sqrt(1.5) - 1e-12)
        if not agree: bad.append((n, k, th, X))
        if n in (12, 13, 14, 24) or k <= 5:
            print(f"{n:3d} {k:3d} {n-k:3d} {th:14.9f} {res:10.1e} {X:26.9f} {str(X<=1/3+1e-12):>7} {str(th>=np.sqrt(1.5)-1e-12):>12}")
print("disagreements between the arithmetic and the computed theta:", bad)
