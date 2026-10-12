"""r273 Claim 2: redo the concentration screen on GENUINE Weyl tensors and then
search, by optimisation, for a Weyl tensor with large (tr M^3 + ||M#||)/theta_0.

Objective  g(M) = tr(M^3) + ||M#||_F   on  {M in Weyl_n : ||M||_F = 1}.
Gradient   grad g = 3 M^2 + 2 (M # M^#)/||M^#||_F,  projected onto Weyl and then
onto the sphere's tangent space.  (<A#B,C> is fully symmetric, checked in core.)
"""
import sys, os, time
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, r273_core as K

SCRATCH = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"

def setup(n):
    idx, N, c = K.struct(n)
    B, triu = K.weyl_basis(n, cache=os.path.join(SCRATCH, f"r273_weyl_{n}.npz"))
    A = np.transpose(c, (0, 2, 1))   # ad matrices
    return idx, N, c, A, B, triu

def sharp(R, A):
    S = np.einsum('amn,np->amp', A, R, optimize=True)
    return -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)

def sharpbil(X, Y, A):
    return 0.5 * (sharp(X + Y, A) - sharp(X, A) - sharp(Y, A))

def proj_weyl(R, B, triu, N):
    v = K.to_vec(R, triu)
    return K.from_vec(B @ (B.T @ v), triu, N)

def obj(M, A):
    Ms = sharp(M, A)
    return float(np.trace(M @ M @ M)) + float(np.linalg.norm(Ms)), Ms

def ascend(M0, A, B, triu, N, steps=4000, lr=0.2):
    M = M0 / np.linalg.norm(M0)
    best = -1e9
    for t in range(steps):
        g, Ms = obj(M, A)
        if g > best: best, Mbest = g, M.copy()
        G = 3.0 * (M @ M) + 2.0 * sharpbil(M, Ms, A) / max(np.linalg.norm(Ms), 1e-14)
        G = proj_weyl(0.5 * (G + G.T), B, triu, N)
        G = G - np.sum(G * M) * M
        ng = np.linalg.norm(G)
        if ng < 1e-11: break
        M = M + lr * G / ng
        M = proj_weyl(M, B, triu, N)
        M = M / np.linalg.norm(M)
        if t % 400 == 0: lr *= 0.75
    g, _ = obj(M, A)
    if g > best: best, Mbest = g, M.copy()
    return best, Mbest

def main(n, nstart, seed0=0):
    idx, N, c, A, B, triu = setup(n)
    dimW = B.shape[1]
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"n={n}  N={N}  dim Weyl={dimW}  theta_0={th0:.6f}")

    # ---- (a) the concentration screen, on genuine WEYL tensors ----
    rs = np.random.RandomState(1234)
    vals = []
    for k in range(200):
        v = rs.randn(dimW); v /= np.linalg.norm(v)
        M = K.from_vec(B @ v, triu, N); M /= np.linalg.norm(M)
        g, Ms = obj(M, A)
        vals.append((g / th0, (np.trace(M@M@M) + np.sum(Ms*M)) / th0))
    vals = np.array(vals)
    print(f"random unit WEYL tensors, 200 samples:")
    print(f"  (tr M^3 + ||M#||)/theta_0 : mean {vals[:,0].mean():.4f}  min {vals[:,0].min():.4f}  max {vals[:,0].max():.4f}")
    print(f"  theta/theta_0             : mean {vals[:,1].mean():.4f}  min {vals[:,1].min():.4f}  max {vals[:,1].max():.4f}")

    # ---- (b) the sphere product, as the reference point ----
    if n % 2 == 0:
        _, _, _, Msp = K.sphere_product_M(n // 2)
        g, Ms = obj(Msp, A)
        print(f"balanced sphere product   : ratio {g/th0:.6f}   theta/theta_0 {(np.trace(Msp@Msp@Msp)+np.sum(Ms*Msp))/th0:.9f}")
        # is it a critical point of g?
        G = 3.0*(Msp@Msp) + 2.0*sharpbil(Msp, Ms, A)/np.linalg.norm(Ms)
        G = proj_weyl(0.5*(G+G.T), B, triu, N); G = G - np.sum(G*Msp)*Msp
        print(f"  |proj grad| there       : {np.linalg.norm(G):.3e}")

    # ---- (c) optimisation ----
    best = -1e9
    t0 = time.time()
    for s in range(nstart):
        rs2 = np.random.RandomState(seed0 + s)
        if s == 0 and n % 2 == 0:
            M0 = Msp + 0.05 * K.from_vec(B @ rs2.randn(dimW), triu, N)
        else:
            M0 = K.from_vec(B @ rs2.randn(dimW), triu, N)
        M0 = proj_weyl(M0, B, triu, N)
        g, M = ascend(M0, A, B, triu, N)
        if g > best:
            best, Mb = g, M
        print(f"  start {s:>2}: g={g:.8f}  ratio={g/th0:.8f}   (best {best/th0:.8f})  [{time.time()-t0:.0f}s]", flush=True)
    Ms = sharp(Mb, A)
    tr3 = float(np.trace(Mb@Mb@Mb)); ipv = float(np.sum(Ms*Mb)); nm = float(np.linalg.norm(Ms))
    print(f"BEST  ratio (tr+||M#||)/theta_0 = {best/th0:.8f}")
    print(f"   tr(M^3)={tr3:.6f}  ||M#||={nm:.6f}  <M#,M>={ipv:.6f}  cos phi={ipv/nm:.6f}")
    print(f"   theta = {tr3+ipv:.6f}   theta/theta_0 = {(tr3+ipv)/th0:.8f}")
    np.save(os.path.join(SCRATCH, f"r273_best_{n}.npy"), Mb)

if __name__ == "__main__":
    main(int(sys.argv[1]), int(sys.argv[2]))
