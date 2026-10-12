"""r243 / claim 1 -- does the target really vanish at the balanced product?

A2' asserts: "At even n the target vanishes at the balanced product, so ANY psd
certificate has the evaluation covector in its kernel."

The target (fence-posts.md:314) is  G = Theta_n^2 A - B + mu(C - B)  with
A = |W|^6, B = <Q(W),W>^2, C = |W|^2 |Q(W)|^2.  Two independent facts are
needed and neither is stated in the file:

  (i)  the balanced product is CRITICAL, Q(W*) = theta W*, so C - B = 0 there
       (Cauchy-Schwarz equality) -- this kills the mu term for EVERY mu;
  (ii) P(W*) = Theta_n at even n, so Theta_n^2 A - B = 0 there.

This script derives both in closed form in n and checks them numerically.
Everything is done on the UNNORMALISED sphere-product operator, which is where
the rationality question of claim 2 is decided.
"""
import sympy as sp
from itertools import combinations
import numpy as np

n, m = sp.symbols('n m', positive=True)

# ---------------------------------------------------------------- closed form
# Weyl operator of S^p x S^q is diagonal on Lambda^2 in the coordinate basis
# (run_sphere.py's hand_formula, re-derived): vertex matrix K with
#   K_ab = w11 (a,b both in block 1), w22 (both in block 2), w12 (mixed).
def w_of(p, q):
    t, u = p - 1, q - 1
    S = t*t + t + u*u + u
    d1 = t + u                    # n - 2
    d2 = (t + u + 1)*(t + u)      # (n-1)(n-2)
    sig = sp.together(S/d2)
    return (sp.simplify(1 - 2*t/d1 + sig),
            sp.simplify(1 - 2*u/d1 + sig),
            sp.simplify(-1 + sig))

w11, w22, w12 = w_of(n/2, n/2)
print(f"  balanced split, unnormalised entries:")
print(f"    w11 = w22 = {sp.simplify(w11)}      w12 = {sp.simplify(w12)}")
assert sp.simplify(w11 - n/(2*(n-1))) == 0
assert sp.simplify(w12 + (n-2)/(2*(n-1))) == 0
print("    -- both RATIONAL in n; after clearing 2(n-1) they are n and -(n-2).")

# Hamilton's Q on a diagonal operator: Q_ab = K_ab^2 + sum_c K_ac K_cb.
M = n/2
# same-block pair (a,b in block 1):  (M-2) w11^2 from block 1, M w12^2 from block 2
Q11 = sp.simplify(w11**2 + (M-2)*w11**2 + M*w12**2)
# mixed pair (a in 1, b in 2): (M-1) w11 w12 twice
Q12 = sp.simplify(w12**2 + 2*(M-1)*w11*w12)
r11, r12 = sp.simplify(Q11/w11), sp.simplify(Q12/w12)
print(f"\n  Q(W*)_same / W*_same  = {r11}")
print(f"  Q(W*)_mixed/ W*_mixed = {r12}")
assert sp.simplify(r11 - r12) == 0, "the balanced product is NOT critical"
lam = sp.simplify(r11)
print(f"  => Q(W*) = ({lam}) W*  EXACTLY: the balanced product is critical,")
print("     so C - B = 0 there and the mu term drops for EVERY mu.  (fact (i))")

normsq = sp.simplify(2*sp.binomial(M, 2)*w11**2 + M**2*w12**2)
print(f"\n  ||W*||^2 = {sp.simplify(normsq)}")
theta = sp.simplify(lam/sp.sqrt(normsq))
Theta = sp.sqrt(2*(n-1)*(n-2))/n
print(f"  theta = lam/||W*|| = {theta}")
print(f"  Theta_n                = {Theta}")
assert sp.simplify(sp.expand(theta**2 - Theta**2)) == 0, "P(W*) != Theta_n"
print("  => P(W*) = Theta_n at even n.  (fact (ii))  Hence G(W*) = 0.")

# --------------------------------------------------- the odd-n side of claim 1
print("\n  ODD n: the near-balanced product S^{(n-1)/2} x S^{(n+1)/2}")
for N in (13, 15, 17):
    p, q = (N-1)//2, (N+1)//2
    a11, a22, a12 = w_of(p, q)
    MM = sp.Matrix(N, N, lambda i, j: 0 if i == j else
                   (a11 if i < p and j < p else a22 if i >= p and j >= p else a12))
    qq = sp.Matrix(N, N, lambda i, j: 0 if i == j else
                   MM[i, j]**2 + sum(MM[i, c]*MM[c, j] for c in range(N)))
    rr = {sp.nsimplify(qq[i, j]/MM[i, j]) for i in range(N) for j in range(N) if i != j}
    crit = len(rr) == 1
    ns = sum(MM[i, j]**2 for i in range(N) for j in range(i+1, N))
    P = sp.simplify(list(rr)[0]/sp.sqrt(ns)) if crit else None
    Th_even = sp.sqrt(2*(N-1)*(N-2))/N
    gap = sp.nsimplify(sp.simplify(Th_even**2 - P**2)) if crit else None
    print(f"    n={N}: critical={crit}  P={sp.N(P,10)}  Theta_n(even formula)={sp.N(Th_even,10)}"
          f"  Theta^2-P^2 = {sp.N(gap,8)}")
    assert crit and gap > 0, "odd n unexpectedly saturates the even-formula target"
print("    => at odd n the target is STRICTLY POSITIVE at the product: nothing is")
print("       forced there.  The forcing is an even-n phenomenon only.")

# --------------------------------------------------------- numerical crosscheck
print("\n  numerical crosscheck of Q(W*) = lam W* on the full Lambda^2 operator")
for N in (8, 10, 12):
    pairs = list(combinations(range(N), 2))
    idx = {p: k for k, p in enumerate(pairs)}
    P2 = N//2
    a11 = float(w11.subs(n, N)); a12 = float(w12.subs(n, N))
    K = np.zeros((N, N))
    for i in range(N):
        for j in range(N):
            if i != j:
                K[i, j] = a11 if (i < P2) == (j < P2) else a12
    W = np.diag([K[i, j] for (i, j) in pairs])
    # R^# by structure constants, basis-free, on the full operator
    c = np.zeros((len(pairs),)*3)
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            for coef, (p_, q_) in ([(1., (i, l))] if j == k else []) + \
                                  ([(-1., (j, l))] if i == k else []) + \
                                  ([(-1., (i, k))] if j == l else []) + \
                                  ([(1., (j, k))] if i == l else []):
                if p_ == q_: continue
                s = 1.
                if p_ > q_: p_, q_, s = q_, p_, -1.
                c[a, b, idx[(p_, q_)]] += coef*s
    Rs = 0.5*np.einsum('abg,bd,ge,ade->a', c, W, W, c, optimize=True)
    Qm = W @ W + np.diag(Rs)
    lamN = float(lam.subs(n, N))
    res = np.max(np.abs(Qm - lamN*W))
    print(f"    n={N}: max|Q(W*) - {lamN}*W*| = {res:.3e}")
    assert res < 1e-10

print("\n  CLAIM 1's vanishing: CONFIRMED, and it needs criticality, which the")
print("  file never states.  Note ||W*|| is IRRATIONAL in n -- see c2 script.")
