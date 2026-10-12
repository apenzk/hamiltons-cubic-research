"""T1/T2: the CP^m family, the padded spectrum, dim[m,m], and slack magnitudes."""
import numpy as np, itertools
from review_r47_core import *

np.set_printoptions(precision=6, suppress=True)

def u_m_algebra(g, m):
    """basis of u(m) inside so(2m): J-commuting antisymmetric matrices.
    complex structure J: e_{2a} <-> e_{2a+1}."""
    n = 2*m
    J = np.zeros((n,n))
    for a in range(m):
        J[2*a,2*a+1] = 1.0; J[2*a+1,2*a] = -1.0
    A = g.so_basis()
    # X in u(m)  <=>  XJ = JX
    rows = np.array([ (X@J - J@X).ravel() for X in A ]).T
    _,sv,Vt = np.linalg.svd(rows)
    rk = int((sv > 1e-10*sv[0]).sum())
    ns = Vt[rk:]
    return J, np.einsum('ka,aij->kij', ns, A)

def invariant_weyl_line(g, algebra, Bas):
    """Weyl operators commuting with ad_X for every X in the given algebra"""
    rows = []
    for X in algebra:
        adX = g.ad(X)
        rows.append(np.array([ (adX@V - V@adX).ravel() for V in Bas ]).T)
    Mrows = np.concatenate(rows, axis=0)
    _,sv,Vt = np.linalg.svd(Mrows)
    rk = int((sv > 1e-9*sv[0]).sum())
    ns = Vt[rk:]
    return np.einsum('ka,aij->kij', ns, Bas)

def orbit_dim(g, W):
    A = g.so_basis()
    rows = []
    for X in A:
        adX = g.ad(X)
        rows.append((adX@W - W@adX).ravel())
    s = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((s > 1e-9*max(1.0,s[0])).sum())

print("### T1: build W_CP2 as the u(2)-invariant line in Weyl_4")
g4 = Geom(4); B4 = g4.weyl_basis()
J, um = u_m_algebra(g4, 2)
print(f" dim u(2) found = {um.shape[0]} (theory 4)")
inv = invariant_weyl_line(g4, um, B4)
print(f" dim of U(2)-invariant Weyl_4 = {inv.shape[0]} (expect 1)")
W4 = inv[0]/np.linalg.norm(inv[0])
th4,res4 = crit_residual(g4, W4)
if th4 < 0: W4 = -W4; th4,res4 = crit_residual(g4,W4)
ev4 = np.linalg.eigvalsh(W4)
print(f" theta = {th4:.12f}   sqrt(3/2) = {np.sqrt(1.5):.12f}   crit res = {res4:.2e}")
print(f" spectrum*sqrt(6) = {np.round(ev4*np.sqrt(6),9)}")
print(f" |Ric| = {np.abs(g4.ricci(W4)).max():.2e}  |Bianchi| = {np.abs(g4.bianchi(W4)).max():.2e}")

print("\n### T1: padded spectrum and eigenspace dimensions")
for n in (8,10,12):
    gb = Geom(n); Wp = pad(g4, gb, W4)
    th,res = crit_residual(gb, Wp)
    ev = np.linalg.eigvalsh(Wp)
    tol = 1e-10
    npos = int((ev> tol).sum()); nneg = int((ev<-tol).sum()); nzer = int((np.abs(ev)<=tol).sum())
    st = struct_sums(gb, Wp)
    print(f" n={n}: N={gb.N} theta={th:.12f} res={res:.2e} | pos={npos} neg={nneg} zero={nzer}"
          f" | dim m={st['dim_m']} dim[m,m]={st['dim_mm']} S={st['S']:.3e} leak T1={st['leak']:.6f}"
          f" | orbit={orbit_dim(gb,Wp)}")

print("\n### T2: dim m, dim[m,m], S at the balanced sphere products")
for n in (8,12):
    g = Geom(n); W = sphere_product(g, n//2, n//2)
    st = struct_sums(g, W)
    th,_ = crit_residual(g,W)
    print(f" S^{n//2}xS^{n//2} n={n}: theta={th:.9f} dim m={st['dim_m']} dim[m,m]={st['dim_mm']}"
          f" S={st['S']:.3e} T1(leak)={st['leak']:.3e} T0={st['T0']:.1f} T2={st['T2']:.1f}")

print("\n### T2 attack: is S=0 automatic when dim m <= 2?  (total antisymmetry of c_abc)")
for n in (6,8):
    g = Geom(n); A = g.so_basis()
    rng = np.random.default_rng(7)
    worst = 0.0
    for trial in range(200):
        # random 2-dim subspace of so(n)
        V = rng.normal(size=(g.N,2)); V,_ = np.linalg.qr(V)
        X = np.einsum('an,aij->nij', V, A)
        br = np.einsum('aik,bkj->abij', X, X) - np.einsum('bik,akj->abij', X, X)
        C = 0.5*np.einsum('abij,cij->abc', br, X)
        worst = max(worst, np.abs(C).max())
    print(f" n={n}: max |c_abc| over 200 random 2-planes m = {worst:.3e}   (S = sum c^2)")
print(" => for ANY 2-dimensional m, S vanishes identically: c_abc is totally antisymmetric,")
print("    so it needs three distinct indices. Codim of {S=0} in the Grassmannian = 0.")

print("\n### T2 attack: are the reported 1e-46 / 1e-28 magnitudes structural or eigenvector artefacts?")
g8 = Geom(8); Wp = pad(g4, g8, W4)
Ws = sphere_product(g8,4,4)
for name,W in (("padded W_CP2",Wp),("S^4xS^4",Ws)):
    for tag,tol in (("eig-tol 1e-9",1e-9),):
        st = struct_sums(g8,W)
        print(f" {name}: S={st['S']:.6e}")
    # rebuild m from a deliberately noisy eigenbasis
    rng = np.random.default_rng(3)
    Wn = W + 1e-13*np.diag(rng.normal(size=g8.N))
    Wn = (Wn+Wn.T)/2
    st2 = struct_sums(g8,Wn)
    print(f"   with 1e-13 symmetric noise on W: S={st2['S']:.6e}  dim m={st2['dim_m']}")
