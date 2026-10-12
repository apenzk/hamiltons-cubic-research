"""r208, claim 5: dim ANN = 14 - rank, where rank = dim (K.K)^{O(5)}.

THE IDENTITY THIS RESTS ON.  For x in K and any v,

    integral_{O(5)} x(hv)^2 dh  =  A(x^2)(v),

so sampling the group at a point v EVALUATES the invariant sextic A(x^2) there.
The A(x^2) span the image of the certificate map restricted to K, so

    rank = dim span{A(x_a^2)}  =  rank of the coefficient matrix of the
           A(x_a^2) in ANY basis of the 14 invariant sextics.

Rather than read the rank off the raw evaluation matrix -- whose columns carry
independent Monte Carlo noise and so come out full rank -- each A(x_a^2) is
LEAST-SQUARES FITTED to the 14 explicit sextics of sextics.py evaluated at the
same points.  That enforces the cap rank <= 14 exactly and discards the noise
orthogonal to the invariant space; the rank is then read off the 14 fitted
coefficients.

x_a = P_K u_a^3 is exact: it vanishes on the whole orbit to 3e-13 at fresh orbit
points, and v_1 = W_0 is carried as a column, where A(x^2)(W_0) = 0 identically.
"""
import sys, os, time, numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib208 as L, sextics as SX

t0 = time.time()
NX, NV = 30, 25
NSAMP = int(sys.argv[1]) if len(sys.argv) > 1 else 200_000
SEED = int(sys.argv[2]) if len(sys.argv) > 2 else 2086
CH = 20_000

U = np.load("/tmp/r208_U.npy")
G = (U @ U.T)**3
w, Vg = np.linalg.eigh(G); keep = w > 1e-9*w.max()
Gp = (Vg[:, keep]/w[keep]) @ Vg[:, keep].T
print(f"dim C = {keep.sum()};  setup {time.time()-t0:.1f}s", flush=True)

rng = np.random.default_rng(SEED)
Ua = rng.standard_normal((NX, 35)); Ua /= np.linalg.norm(Ua, axis=1, keepdims=True)
Cm = ((Ua @ U.T)**3) @ Gp.T
AUG = np.vstack([Ua, U])
chk = L.orbit(40, seed=555); sch = (chk @ AUG.T)**3
rnd = rng.standard_normal((40, 35)); rnd /= np.linalg.norm(rnd, axis=1, keepdims=True)
srd = (rnd @ AUG.T)**3
print(f"x_a in K: max |x_a| at 40 FRESH orbit points "
      f"{np.abs(sch[:, :NX] - sch[:, NX:] @ Cm.T).max():.2e}, at 40 random unit points "
      f"{np.abs(srd[:, :NX] - srd[:, NX:] @ Cm.T).max():.2e}", flush=True)

V = rng.standard_normal((NV, 35)); V /= np.linalg.norm(V, axis=1, keepdims=True)
V[0] = L.w0

BAS = SX.load_basis()
PHI = np.array([[SX.evaluate(m, SX.tensor(V[p])).real for m in BAS] for p in range(NV)])
print(f"Phi evaluated at the {NV} points; condition number of the {PHI.shape} matrix"
      f" {np.linalg.cond(PHI):.3e}", flush=True)

I = np.array([p[0] for p in L.PAIRS]); J = np.array([p[1] for p in L.PAIRS])
def lam2_batch(g):
    a = g[:, I, :]; b = g[:, J, :]
    return a[:, :, I]*b[:, :, J] - a[:, :, J]*b[:, :, I]
def rand_o5_batch(n):
    q, r = np.linalg.qr(rng.standard_normal((n, 5, 5)))
    return q*np.sign(np.einsum('nii->ni', r))[:, None, :]

E = np.zeros((NX, NV))
for r in range(NV):
    Mv = L.expand(V[r]); acc = np.zeros(NX); tot = 0
    for _ in range(NSAMP//CH):
        Lb = lam2_batch(rand_o5_batch(CH))
        Y = np.einsum('aij,nik,kl,njl->na', L.B, Lb, Mv, Lb, optimize=True)
        s = (Y @ AUG.T)**3
        X = s[:, :NX] - s[:, NX:] @ Cm.T
        acc += (X*X).sum(axis=0); tot += CH
    E[:, r] = acc/tot
    print(f"  v_{r:<2d}  [{time.time()-t0:.0f}s]", flush=True)
np.save(f"/tmp/r208_E_{NSAMP}_{SEED}.npy", E)

print(f"\nZERO CONTROL  v_0 = W_0: mean |E[:,0]| = {np.abs(E[:,0]).mean():.3e}"
      f"  vs mean |E[:,r>0]| = {np.abs(E[:,1:]).mean():.3e}")

# least-squares fit of each A(x_a^2) to the 14 invariant sextics
AL, res, _, _ = np.linalg.lstsq(PHI, E.T, rcond=None)      # (14, NX)
fit = PHI @ AL
rel = np.linalg.norm(fit - E.T)/np.linalg.norm(E)
print(f"fit residual, relative: {rel:.3e}   (a large residual means the Monte Carlo")
print(f"  noise, not the invariant-sextic span, is the limitation)")

AL = AL.T                                                   # (NX, 14)
AL = AL/np.linalg.norm(AL, axis=1, keepdims=True)
sv = np.linalg.svd(AL, compute_uv=False)
print(f"\ncoefficient matrix {AL.shape}; singular values / sigma_1:")
print("  ", np.array2string(sv/sv[0], precision=4, max_line_width=110))
for tol in (1e-1, 1e-2, 1e-3, 1e-4):
    k = int((sv > tol*sv[0]).sum())
    print(f"   rank at {tol:g} relative: {k:2d}   => dim ANN = {14-k}")
print(f"\ntotal {time.time()-t0:.0f}s   (N = {NSAMP} per column, seed {SEED})")
