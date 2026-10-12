"""Structure behind the zero block: reduce L_e to the single object sharp_bilin(I_p, .).

e = A P_0 + eta P_1 + B P_2 with P_0 = I_p, P_2 = I_q, P_1 = I_n - I_p - I_q, so
  sharp_bilin(e,V) = eta*sharp_bilin(I_n,V) + (A-eta) sharp_bilin(I_p,V) + (B-eta) sharp_bilin(I_q,V).
Lemma A (classical):  sharp_bilin(I_n, V) = -V for every Ricci-flat V in Weyl_n.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import struct, weyl_basis, idempotent, sharp_bilin, ip
from review_r34_summands import support_subspace2, kinds

def Iblock(p, q, which):
    n = p+q; k = kinds(p, q); N = len(k)
    d = np.zeros(N)
    if which == 'p': d[k == 0] = 1.0
    elif which == 'q': d[k == 2] = 1.0
    else: d[:] = 1.0
    return np.diag(d)

print("Lemma A:  sharp_bilin(I_n, V) = -V  for V in Weyl_n?")
for n in (6, 7, 8, 9, 10):
    B = weyl_basis(n); rng = np.random.default_rng(11)
    V = np.einsum('d,dij->ij', rng.normal(size=B.shape[0]), B)
    S = sharp_bilin(np.eye(B.shape[1]), V, n)
    print(f"   n={n:2d}: |sharp_bilin(I,V) + V| / |V| = {np.linalg.norm(S+V)/np.linalg.norm(V):.2e}")

print()
print("Lemma B:  sharp_bilin(I_p, V) on each support class  (coefficient c s.t. S = c V)")
for (p, q) in [(4,4),(4,6),(5,5),(3,5),(5,3),(4,5),(6,4),(3,7)]:
    n = p+q
    B = weyl_basis(n)
    Ip = Iblock(p, q, 'p'); Iq = Iblock(p, q, 'q')
    rng = np.random.default_rng(13)
    row = []
    for name, pat in (("Weyl_p (pp,pp)", [(0,0)]), ("Weyl_q (qq,qq)", [(2,2)]),
                      ("X_p(x)R^q (pp,mix)", [(0,1)]), ("X_q(x)R^p (qq,mix)", [(2,1)])):
        Vb = support_subspace2(p, q, pat, B)
        if Vb.shape[1] == 0:
            row.append((name, None, None)); continue
        V = np.einsum('d,dij->ij', rng.normal(size=Vb.shape[1]) @ Vb.T, B)
        Sp = sharp_bilin(Ip, V, n); Sq = sharp_bilin(Iq, V, n)
        cp = ip(Sp, V)/ip(V, V); cq = ip(Sq, V)/ip(V, V)
        rp = np.linalg.norm(Sp - cp*V)/np.linalg.norm(V)
        rq = np.linalg.norm(Sq - cq*V)/np.linalg.norm(V)
        row.append((name, (cp, rp), (cq, rq)))
    print(f"  ({p},{q}):")
    for name, a, b in row:
        if a is None:
            print(f"     {name:22s} (empty)")
        else:
            print(f"     {name:22s} I_p: c={a[0]:+.6f} resid {a[1]:.1e}   "
                  f"I_q: c={b[0]:+.6f} resid {b[1]:.1e}")
