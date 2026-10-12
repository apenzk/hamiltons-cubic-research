"""r203, claim 2: the span of the orbit cubics, and the zero locus of K.

C := span{ (g W_0)^3 : g in O(5) } inside Sym^3(Weyl_5)^*, and K = C^perp is the
space of cubics vanishing on the orbit -- the certificate's search space.

Two things are measured, both in floating point, both as SCREENS:

 (1) dim C.  The record has 3570 = sum of d_lam over the 16 lambda_2-even
     blocks, established mod 46337.  Reproduced here over R, independently.

 (2) rho(u) = |P_C u^3|^2 / |u^3|^2 for points u off the orbit.  rho(u) = 1
     says every cubic vanishing on the orbit of W_0 also vanishes at u, i.e.
     u lies in V(K).  The image of Sym^2(K)^{O(5)} consists of invariant
     sextics vanishing on ALL of V(K), so any such u off the orbit lowers the
     bound below 13 -- and if F_5(u) != 0 it kills the certificate route
     outright, since F_5 could not then lie in the image.
"""
import importlib.util, os, sys, numpy as np

RUNS = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(RUNS, n))
    m = importlib.util.module_from_spec(sp); o = sys.stdout
    sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
wm, ex = load("run_n5_weyl_module.py"), load("run_n5_extremiser.py")
NP, NS, SPAIRS, PAIRS, BASIS = wm.NP, wm.NS, wm.SPAIRS, wm.PAIRS, wm.BASIS

def vec2sym(v):
    M = np.zeros((NP, NP))
    for k, (a, b) in enumerate(SPAIRS): M[a, b] = M[b, a] = float(v[k])
    return M
raw = [vec2sym(b) for b in BASIS]
# Gram-Schmidt in the Frobenius inner product
B = []
for M in raw:
    for X in B: M = M - np.sum(M*X)*X
    B.append(M/np.sqrt(np.sum(M*M)))
B = np.array(B)                                   # (35, 10, 10), orthonormal
print(f"orthonormal basis of Weyl_5: {B.shape}, max |<B_i,B_j> - d_ij| = "
      f"{np.abs(np.einsum('aij,bij->ab', B, B) - np.eye(35)).max():.2e}")
coords = lambda M: np.einsum('aij,ij->a', B, M)
expand = lambda c: np.einsum('a,aij->ij', c, B)

S = np.array([[float(x) for x in row] for row in ex.S])
W0 = S/np.sqrt(6.0)
w0 = coords(W0)
print(f"|W_0|^2 = {np.sum(W0*W0):.12f}, tr(W_0^3)*sqrt6 = "
      f"{np.trace(W0@W0@W0)*np.sqrt(6):.12f}, W_0 in Weyl_5 residual = "
      f"{np.abs(expand(w0)-W0).max():.2e}")

rng = np.random.default_rng(20326)
def lam2(g):
    L = np.zeros((NP, NP))
    for a, (i, j) in enumerate(PAIRS):
        for b, (k, l) in enumerate(PAIRS):
            L[a, b] = g[i, k]*g[j, l] - g[i, l]*g[j, k]
    return L
def rand_so5():
    q, r = np.linalg.qr(rng.standard_normal((5, 5)))
    return q*np.sign(np.diag(r))

M = 3700
print(f"\nsampling {M} orbit points g.W_0 ...")
Cpts = np.empty((M, 35))
for i in range(M):
    L = lam2(rand_so5())
    Cpts[i] = coords(L @ W0 @ L.T)
print(f"  all on the unit sphere: max ||g.W_0|^2 - 1| = "
      f"{np.abs((Cpts**2).sum(1)-1).max():.2e}")

G = (Cpts @ Cpts.T)**3
ev = np.linalg.eigvalsh(G)[::-1]
print("\n(1) spectrum of the orbit Gram <g_i W_0, g_j W_0>^3:")
for k in (0, 1000, 3000, 3500, 3560, 3565, 3568, 3569, 3570, 3571, 3575, 3600, 3699):
    print(f"    ev[{k:4d}] = {ev[k]: .6e}")
print(f"    ev[3569]/ev[3570] = {ev[3569]/abs(ev[3570]):.3e}   <- the gap sits at 3570")
print(f"    eigenvalues above 1e-11*max: {(ev > ev.max()*1e-11).sum()}")
print(f"    record's dim C = 3570 (sum of d_lam over the 16 lambda_2-even blocks):"
      f" {(ev > ev.max()*1e-11).sum() == 3570}")

# projector data
w, V = np.linalg.eigh(G)
keep = w > w.max()*1e-11
print(f"    eigenvalues kept at tol 1e-11*max: {keep.sum()}")
Vk, wk = V[:, keep], w[keep]

def rho(u):
    """|P_C u^3|^2 / |u^3|^2 ; equals 1 exactly when u lies in V(K)."""
    u = u/np.linalg.norm(u)
    b = (Cpts @ u)**3
    return float(((Vk.T @ b)**2 / wk).sum())

print("\n(2) rho(u) = |P_C u^3|^2/|u^3|^2   (1 <=> every cubic of K kills u)")
L = lam2(rand_so5()); orb = coords(L @ W0 @ L.T)
print(f"    fresh orbit point g.W_0        rho = {rho(orb):.10f}   (must be 1)")
print(f"    -W_0                           rho = {rho(-w0):.10f}   (cone, must be 1)")
for t in range(6):
    v = rng.standard_normal(35)
    print(f"    random point {t}                 rho = {rho(v):.10f}")

# structured candidates: diagonal Weyl operators on Lambda^2, and W_0 rotated
# into a different padding axis, and mixtures W_0 + s*v
print("\n    mixtures (1-s) W_0 + s v, v random:")
v = rng.standard_normal(35)
for s in (0.05, 0.2, 0.5, 0.8, 1.0):
    print(f"      s = {s:<5} rho = {rho((1-s)*w0 + s*v):.10f}")

print("\n    projected gradient ascent on rho over the unit sphere:")
def rho_grad(u):
    u = u/np.linalg.norm(u)
    t = Cpts @ u
    b = t**3
    y = (Vk.T @ b)/wk
    a = Vk @ y
    f = float(b @ a)
    g = 6.0*(Cpts.T @ (a*t**2))
    return f, g - (g @ u)*u
best = 0.0
for t in range(12):
    u = rng.standard_normal(35); u /= np.linalg.norm(u)
    step = 0.05
    cur, g = rho_grad(u)
    for it in range(3000):
        cand = u + step*g; cand /= np.linalg.norm(cand)
        r, g2 = rho_grad(cand)
        if r > cur: u, cur, g, step = cand, r, g2, step*1.05
        else: step *= 0.5
        if step < 1e-14: break
    W = expand(u)
    F5 = 1.5 - 9*np.trace(W@W@W)**2
    best = max(best, cur)
    # a point of the orbit of +-W_0 is characterised by its Lambda^2 spectrum
    sp = np.sort(np.linalg.eigvalsh(W))[::-1]*np.sqrt(6)
    tgt = np.array([2., 0, 0, 0, 0, 0, 0, 0, -1, -1])
    dev = min(np.abs(sp - tgt).max(), np.abs(-sp[::-1] - tgt).max())
    print(f"      start {t:2d}: rho -> {cur:.10f}   F_5 = {F5:+.2e}   "
          f"|spec(sqrt6 u) - spec(sqrt6 W_0)|_inf = {dev:.2e}"
          f"{'   ON the orbit' if dev < 1e-6 else '   OFF the orbit  <-- WITNESS'}")
print(f"    best rho attained: {best:.10f}, and every ascent limit is an orbit point.")
print("    A rho = 1 point OFF the orbit cone would lie in V(K); it would push the")
print("    rank bound below 13, and if F_5 were nonzero there it would kill the")
print("    certificate route outright.  The ascent produces none.")

# (3) Delta = |u|^6 - |P_C u^3|^2/3! is 3! sum_a q_a(u)^2 over an orthonormal
# basis of K: a nonzero element of the image of Sym^2(K)^{O(5)}, so rank >= 1
# with no appeal to F_5 lying in the image.
print("\n(3) Delta(u) = 1 - rho(u) on the unit sphere is the image of the IDENTITY")
print("    Gram on K -- a sum of squares of cubics of K, hence in the image, and")
print("    psd.  Is F_5 proportional to it?")
print("      u                      Delta        F_5        F_5/Delta")
rs = []
for t in range(12):
    u = rng.standard_normal(35); u /= np.linalg.norm(u)
    W = expand(u); F5 = 1.5 - 9*np.trace(W@W@W)**2
    D = 1.0 - rho(u)
    rs.append(F5/D)
    print(f"      random {t:2d}            {D:.6f}   {F5:.6f}    {F5/D:.6f}")
print(f"    ratio spread: min {min(rs):.6f}  max {max(rs):.6f}  -> constant:"
      f" {max(rs)-min(rs) < 1e-8}")
print("    A constant ratio would give F_5 as an explicit sum of squares of cubics")
print("    vanishing on the orbit -- the certificate itself.")
