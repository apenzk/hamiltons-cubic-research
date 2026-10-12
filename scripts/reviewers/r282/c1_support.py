"""r282 claim 1: support dimension, padding, and the bound theta <= M(s)."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import weyl as W


def cp2_weyl(n=4):
    J = np.zeros((n, n)); J[1, 0] = 1; J[0, 1] = -1; J[3, 2] = 1; J[2, 3] = -1
    Jm = J.T.copy(); d = np.eye(n)
    R = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
         + np.einsum('ik,jl->ijkl', Jm, Jm) - np.einsum('il,jk->ijkl', Jm, Jm)
         + 2 * np.einsum('ij,kl->ijkl', Jm, Jm))
    M = W.tensor_to_op(W.project_weyl(R, n), n)
    return M / W.norm(M)


def sphere_product(a, b):
    n = a + b
    R = np.zeros((n, n, n, n)); d = np.eye(n)
    for blk in (range(a), range(a, n)):
        s = list(blk)
        e = np.zeros(n); e[s] = 1.0
        g = np.diag(e)
        R += np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)
    M = W.tensor_to_op(W.project_weyl(R, n), n)
    return M / W.norm(M)


rng = np.random.default_rng(282)
print("=== the reference points ===")
c4 = cp2_weyl(4)
print("W_CP2 (n=4): P =", W.P(c4, 4), " sqrt(3/2)=", np.sqrt(1.5),
      " Lambda^2 spectrum*sqrt6 =", np.round(np.linalg.eigvalsh(c4) * np.sqrt(6), 9))
for N2 in (5, 6, 8, 12):
    cp = W.pad(c4, 4, N2)
    print(f"  padded to n={N2}: |W|={W.norm(cp):.12f}  P={W.P(cp,N2):.14f}  s={W.support_dim(cp,N2)}")
s66 = sphere_product(6, 6)
print("S^6xS^6 (n=12): P =", W.P(s66, 12), " theta_0(12)=", W.theta0(12),
      " s =", W.support_dim(s66, 12))
print("S^3xS^3 (n=6):  P =", W.P(sphere_product(3, 3), 6), " theta_0(6)=", W.theta0(6))

print("\n=== (b) support dim: random points, frame covariance ===")
for n in (5, 6, 8, 12):
    M = W.random_weyl(n, rng)
    print(f"  n={n}: s(random)={W.support_dim(M,n)}")
# frame covariance: rotate a padded CP2 by a random O(12) element
from scipy.stats import special_ortho_group
g = special_ortho_group.rvs(12, random_state=7)
R = W.op_to_tensor(W.pad(c4, 4, 12), 12)
Rg = np.einsum('ai,bj,ck,dl,ijkl->abcd', g, g, g, g, R)
Mg = W.tensor_to_op(Rg, 12)
print("  rotated padded CP2: s =", W.support_dim(Mg, 12), " P =", W.P(Mg, 12),
      " (non-padded coordinates: max |M| off the first 6 rows =",
      f"{np.abs(Mg[6:]).max():.3f})")

print("\n=== (a) THE CRUX: does support s force a padding? ===")
# random Weyl_12 tensors, look at the kernel of T and test iota_v W = 0
worst = 0.0
for _ in range(200):
    M = W.random_weyl(12, rng)
    T = W.support_matrix(M, 12)
    ev, evec = np.linalg.eigh(T)
    R = W.op_to_tensor(M, 12)
    for k in range(12):
        if ev[k] < 1e-9 * ev.max():
            worst = max(worst, np.abs(np.einsum('i,ijkl->jkl', evec[:, k], R)).max())
print("  random n=12: max |iota_v W| over ker(T) directions =", worst, "(no kernel directions => 0)")

# now on a *contrived* low-support point: is the restriction a Weyl tensor of R^s?
for s in (4, 5, 6, 7):
    Ms = W.random_weyl(s, rng)
    Mp = W.pad(Ms, s, 12)
    T = W.support_matrix(Mp, 12)
    ev, evec = np.linalg.eigh(T)
    ker = evec[:, ev < 1e-9 * max(ev.max(), 1e-30)]
    Rp = W.op_to_tensor(Mp, 12)
    iota = max((np.abs(np.einsum('i,ijkl->jkl', ker[:, k], Rp)).max() for k in range(ker.shape[1])), default=0.0)
    # restriction to V = (ker T)^perp
    V = evec[:, ev >= 1e-9 * ev.max()]
    Rres = np.einsum('ia,jb,kc,ld,ijkl->abcd', V, V, V, V, Rp)
    ric = np.einsum('ijkj->ik', Rres)
    bia = Rres + np.transpose(Rres, (0, 2, 3, 1)) + np.transpose(Rres, (0, 3, 1, 2))
    print(f"  s={s}: rank T={V.shape[1]}, |iota_v W|={iota:.1e}, "
          f"|Ric(W|_V)|={np.abs(ric).max():.1e}, |Bianchi(W|_V)|={np.abs(bia).max():.1e}, "
          f"P_n={W.P(Mp,12):.12f} vs P_s={W.P(Ms,s):.12f}")

print("\n=== (c) sqrt(3/2) vs theta_0(n) ===")
for n in (4, 6, 8, 10, 11, 12, 14, 20, 100):
    print(f"  n={n:3d}: theta_0={W.theta0(n):.6f}  {'<' if W.theta0(n)<np.sqrt(1.5) else '>'} sqrt(3/2)={np.sqrt(1.5):.6f}")

print("\n=== the residual stratum: is it really only FULL support? ===")
for (a, b, N2) in ((6, 6, 14), (6, 6, 16), (7, 7, 16), (6, 5, 14)):
    Ms = sphere_product(a, b); n = a + b
    Mp = W.pad(Ms, n, N2)
    print(f"  padded S^{a}xS^{b} (support {n}) inside n={N2}: s={W.support_dim(Mp,N2)}, "
          f"P={W.P(Mp,N2):.9f}  vs sqrt(3/2)={np.sqrt(1.5):.9f}  theta_0({N2})={W.theta0(N2):.9f}")
