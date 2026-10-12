"""r230 claim 1: pin the second-kind convention from Li's DEFINITION and
EXTERNAL published spectra, with a fresh implementation that touches no repo code.

Li, arXiv:2112.08465:
  (2.2)  Rring(e_i (.) e_j) = sum_{k,l} R_{iklj} e_k (.) e_l
  Example 2.4 states the quadratic form explicitly:
         Rring(phi,phi) = sum_{ijkl} R_{ijkl} phi_{il} phi_{jk}
  and fixes the curvature sign convention: on the UNIT SPHERE
         R_{ijkl} = g_ik g_jl - g_il g_jk    (so R_{ijij} = +1 = sectional curvature)

External published spectra used as the arbiter (all ASYMMETRIC in sign, so a
global sign flip is detectable):
  Ex 2.4  S^n           : Rring|_{S^2_0} = identity, all eigenvalues +1
  Ex 2.5  CP^m (BK 1978): -2 with multiplicity m^2-1, +4 with multiplicity m(m+1)
  Ex 2.6  S^{n-1} x R   : -(n-2)/n (x1), 0 (x n-1), +1 (x (n-2)(n+1)/2)
  Ex 2.7  S^2 x S^2     : -1 (x1), 0 (x4), +1 (x4)
"""
import numpy as np, collections, itertools

# ---- fresh implementation of Li (2.2), via the Example-2.4 quadratic form ----
def s20_basis(n):
    """orthonormal basis of traceless symmetric 2-tensors."""
    B = []
    for i in range(n):
        for j in range(i + 1, n):
            h = np.zeros((n, n)); h[i, j] = h[j, i] = 1 / np.sqrt(2); B.append(h)
    # traceless diagonal part: Gram-Schmidt the diagonal matrices against g
    D = [np.diag(np.eye(n)[i]) for i in range(n)]
    g = np.eye(n) / np.sqrt(n)
    V = []
    for d in D:
        v = d - np.sum(d * g) * g
        for w in V: v = v - np.sum(v * w) * w
        nv = np.linalg.norm(v)
        if nv > 1e-9: V.append(v / nv)
    assert len(V) == n - 1
    return B + V

def ring_li(R):
    """matrix of Li's Rring restricted to S^2_0, from Rring(phi,psi)=sum R_ijkl phi_il psi_jk."""
    n = R.shape[0]; B = s20_basis(n); N = len(B)
    assert N == (n - 1) * (n + 2) // 2
    Op = np.zeros((N, N))
    for a in range(N):
        for b in range(N):
            Op[a, b] = np.einsum('ijkl,il,jk->', R, B[a], B[b])
    assert np.max(np.abs(Op - Op.T)) < 1e-10
    return Op

# ---- curvature tensors, built in Li's sign convention (R_{ijij}=sectional K) ----
def diag_curv(Lam):
    """R_ijkl = Lam_ij (g_ik g_jl - g_il g_jk); Lam_ij = sectional curvature of span(e_i,e_j)."""
    n = Lam.shape[0]; I = np.eye(n)
    return (np.einsum('ij,ik,jl->ijkl', Lam, I, I) - np.einsum('ij,il,jk->ijkl', Lam, I, I))

def sphere(n):
    return diag_curv(np.ones((n, n)) - np.eye(n))

def sphere_times_R(n):
    Lam = np.zeros((n, n))
    Lam[:n - 1, :n - 1] = 1 - np.eye(n - 1)
    return diag_curv(Lam)

def s2xs2():
    Lam = np.zeros((4, 4)); Lam[0, 1] = Lam[1, 0] = 1; Lam[2, 3] = Lam[3, 2] = 1
    return diag_curv(Lam)

def cpm(m):
    """Fubini-Study, holomorphic sectional curvature 4:
       R_ijkl = g_ik g_jl - g_il g_jk + J_ik J_jl - J_il J_jk + 2 J_ij J_kl."""
    d = 2 * m; g = np.eye(d); J = np.zeros((d, d))
    for k in range(m): J[2 * k, 2 * k + 1] = 1; J[2 * k + 1, 2 * k] = -1
    return (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
            + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
            + 2 * np.einsum('ij,kl->ijkl', J, J))

def spec(R):
    e = np.linalg.eigvalsh(ring_li(R))
    return sorted(collections.Counter(np.round(e, 6)).items())

def check(label, R, predicted):
    got = spec(R)
    ok = got == sorted(predicted)
    flip = sorted((-v, m) for v, m in got) == sorted(predicted)
    print(f"  {label:16s} got {got}")
    print(f"  {'':16s} Li/BK {sorted(predicted)}   -> {'MATCH' if ok else ('MATCHES ONLY AFTER GLOBAL SIGN FLIP' if flip else 'NEITHER')}")
    return ok

print("=== A. sanity on Li's own normalisation footnote 5: tr(Rring on S^2)=S/2, Rring(g,g)=-S ===")
for n in (4, 5, 6):
    R = sphere(n)
    # full S^2 operator via the same quadratic form, on an orthonormal basis of S^2
    Bfull = s20_basis(n) + [np.eye(n) / np.sqrt(n)]
    Opf = np.array([[np.einsum('ijkl,il,jk->', R, a, b) for b in Bfull] for a in Bfull])
    S = np.einsum('ijij->', R)          # scalar curvature in this convention
    gg = np.einsum('ijkl,il,jk->', R, np.eye(n), np.eye(n))
    print(f"  n={n}: S={S:.1f}  tr(Rring_S2)={np.trace(Opf):+.6f}  S/2={S/2:.1f}   "
          f"Rring(g,g)={gg:+.1f}  -S={-S:.1f}   {'OK' if abs(np.trace(Opf)-S/2)<1e-9 and abs(gg+S)<1e-9 else 'FAIL'}")

print("\n=== B. external published spectra (Li Examples 2.4-2.7, BK 1978) ===")
res = []
for n in (4, 5, 6):
    res.append(check(f"S^{n} (Ex 2.4)", sphere(n), [(1.0, (n - 1) * (n + 2) // 2)]))
for n in (4, 5, 6):
    res.append(check(f"S^{n-1}xR (Ex2.6)", sphere_times_R(n),
                     [(round(-(n - 2) / n, 6), 1), (0.0, n - 1), (1.0, (n - 2) * (n + 1) // 2)]))
res.append(check("S^2xS^2 (Ex2.7)", s2xs2(), [(-1.0, 1), (0.0, 4), (1.0, 4)]))
for m in (2, 3, 4):
    res.append(check(f"CP^{m} (Ex 2.5)", cpm(m), [(-2.0, m * m - 1), (4.0, m * (m + 1))]))
print(f"\n  ALL MATCH IN LI'S ORDER: {all(res)}")

print("\n=== C. does the repo's einsum order 'iklj' reproduce this fresh operator? ===")
def ring_repo_order(R, order):
    """the repo's construction: (Rring h)_ij = einsum(order, R, h); matrix on the same S^2_0 basis."""
    n = R.shape[0]; B = s20_basis(n)
    return np.array([[np.sum(np.einsum(order + ',kl->ij', R, a) * b) for b in B] for a in B])
for name, R in [("S^6", sphere(6)), ("S^2xS^2", s2xs2()), ("CP^3", cpm(3))]:
    A = ring_li(R)
    for order in ('iklj', 'ikjl'):
        Bm = ring_repo_order(R, order)
        same = np.max(np.abs(A - Bm)) < 1e-9; neg = np.max(np.abs(A + Bm)) < 1e-9
        print(f"  {name:9s} order {order}: {'IDENTICAL to Li (2.2)' if same else ('NEGATIVE of Li (2.2)' if neg else 'unrelated')}")
