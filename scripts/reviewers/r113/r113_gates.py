"""Reviewer 113 -- validation gates for the independent implementation."""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

np.set_printoptions(precision=6, suppress=True)

for n in (4, 5, 6, 7):
    BW = weyl_basis(n)
    d_exp = n*(n+1)*(n+2)*(n-3)//12
    print(f"n={n}: dim Weyl = {len(BW)}  (expected {d_exp})")

n = 6
pr = pairs(n); N = len(pr)
c, B = struct_consts(n)
sharp = make_sharp(c)
BW = weyl_basis(n)

# gate: Q preserves the Weyl space
G = np.array([bw.ravel() for bw in BW])          # d x N^2, orthonormal rows
rng = np.random.default_rng(11113)
v = rng.standard_normal(len(BW)); M = sum(v[i]*BW[i] for i in range(len(BW)))
Q = M @ M + sharp(M)
qv = Q.ravel(); res = qv - G.T @ (G @ qv)
print(f"Q preserves Weyl_6: off-space residual {np.linalg.norm(res)/np.linalg.norm(qv):.2e}")
print(f"Q(Id) = (n-1) Id?  {np.max(np.abs((np.eye(N)@np.eye(N)+sharp(np.eye(N))) - (n-1)*np.eye(N))):.2e}")

# ---- known graded point: Casimir of h = so(3)+so(3) in so(6)  (= W_{S^3 x S^3})
def casimir(n, hidx):
    prr = pairs(n); NN = len(prr)
    P = np.zeros((NN, NN))
    for a in hidx: P[a, a] = 1.0
    r = len(hidx)
    Wc = P - (r/NN)*np.eye(NN)
    return Wc/np.linalg.norm(Wc)

h33 = [a for a,(i,j) in enumerate(pr) if (i<3 and j<3) or (i>=3 and j>=3)]
W33 = casimir(6, h33)
th, _ = theta_of(W33, sharp)
r33 = np.linalg.norm(W33@W33 + sharp(W33) - th*W33)
g = grading_data(W33, c)
print(f"\nS^3xS^3 (Casimir so(3)+so(3)): theta={th:.9f}  theta0(6)={np.sqrt(2*5*4)/6:.9f} "
      f"resid={r33:.1e}  S_mmm={g['S_mmm']:.3e} S_hhm={g['S_hhm']:.3e} graded={g['graded']} gap={g['gap']:.9f}")

# ---- padded W_{CP^2}: the n=4 self-dual operator, padded to n=8  (record: ungraded, S=0, leak 16)
def cp2_at_n4():
    prr = pairs(4); NN = len(prr); idx = {p:k for k,p in enumerate(prr)}
    def bivec(a,b,cc,dd,s):
        v = np.zeros(NN); v[idx[(a,b)]] += 1.0; v[idx[(cc,dd)]] += s; return v/np.linalg.norm(v)
    sd = [bivec(0,1,2,3,+1), bivec(0,2,1,3,-1), bivec(0,3,1,2,+1)]
    lam = np.array([2.0,-1.0,-1.0])
    W = sum(lam[k]*np.outer(sd[k],sd[k]) for k in range(3))
    return W/np.linalg.norm(W)

W4 = cp2_at_n4()
BW4 = weyl_basis(4); G4 = np.array([b.ravel() for b in BW4])
off = W4.ravel() - G4.T @ (G4 @ W4.ravel())
print(f"W_CP2 at n=4 lies in Weyl_4: off-space {np.linalg.norm(off):.2e}")
c4,_ = struct_consts(4); sh4 = make_sharp(c4)
th4,_ = theta_of(W4, sh4); print(f"  theta(CP2,n=4)={th4:.9f} resid={np.linalg.norm(W4@W4+sh4(W4)-th4*W4):.1e}")
g4 = grading_data(W4, c4)
print(f"  n=4: S_mmm={g4['S_mmm']:.3e} S_hhm={g4['S_hhm']:.3e} graded={g4['graded']} (record: graded in its native dim)")

def pad(W, n0, n1):
    p0 = pairs(n0); p1 = pairs(n1); i1 = {p:k for k,p in enumerate(p1)}
    out = np.zeros((len(p1), len(p1)))
    for a,pa in enumerate(p0):
        for b,pb in enumerate(p0):
            out[i1[pa], i1[pb]] = W[a,b]
    return out

for n1 in (6,8,10):
    Wp = pad(W4,4,n1); cn,_ = struct_consts(n1); shn = make_sharp(cn)
    thp,_ = theta_of(Wp, shn)
    gp = grading_data(Wp, cn)
    print(f"  padded to n={n1}: theta={thp:.9f} resid={np.linalg.norm(Wp@Wp+shn(Wp)-thp*Wp):.1e} "
          f"S_mmm={gp['S_mmm']:.3e} S_hhm={gp['S_hhm']:.4f} S_hhm_nokernel={gp['S_hhm_nokernel']:.3e} "
          f"zeros={gp['n_zero']} graded={gp['graded']}")
