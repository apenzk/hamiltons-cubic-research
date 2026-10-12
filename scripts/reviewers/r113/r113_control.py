"""Control: is S^3 x S^3 -- the one graded point known to live in Weyl_6^sigma with
this exact sigma -- inside the hunt's reach, and does the solver recover it?"""
import sys, os, json
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, weyl_basis, make_sharp, theta_of, grading_data

n = 6; pr = pairs(n); N = len(pr)
c, _ = struct_consts(n); sharp = make_sharp(c)
BW = weyl_basis(n)
sig = np.array([1,1,1,-1,-1,-1])
P = np.diag([float(sig[i]*sig[j]) for (i,j) in pr])
X = np.array([((b + P @ b @ P)/2).ravel() for b in BW]).T
U, s, _ = np.linalg.svd(X, full_matrices=False)
d = int(np.sum(s > 1e-9)); BS = np.array([U[:, k] for k in range(d)])

h33 = [a for a,(i,j) in enumerate(pr) if (i<3 and j<3) or (i>=3 and j>=3)]
Pi = np.zeros((N,N))
for a in h33: Pi[a,a]=1.0
W33 = Pi - (len(h33)/N)*np.eye(N); W33 /= np.linalg.norm(W33)
off = W33.ravel() - BS.T @ (BS @ W33.ravel())
print(f"W_{{S^3xS^3}} lies in Weyl_6^sigma: off-subspace norm {np.linalg.norm(off):.2e}")
g = grading_data(W33, c)
print(f"  theta={theta_of(W33,sharp)[0]:.9f} gap={g['gap']:.9f} S_mmm={g['S_mmm']:.1e} "
      f"S_hhm={g['S_hhm']:.1e} dim m={g['n_neg']} GRADED={g['graded']}")

# is it in the hunt's output?
here = os.path.dirname(os.path.abspath(__file__))
sols = []
for f in sorted(os.listdir(here)):
    if f.startswith('sols_') and f.endswith('.json'): sols += json.load(open(os.path.join(here, f)))
ths = sorted(set(round(abs(s['theta']),6) for s in sols))
print(f"\n{len(sols)} solutions; distinct |theta| values: {len(ths)}")
print(f"max |theta| found by the hunt: {max(ths):.6f}   (S^3xS^3 sits at 1.054093)")
print(f"any |theta| within 1e-4 of 1.054093? {[t for t in ths if abs(t-1.054093)<1e-4]}")
print(f"|theta| >= 0.9 : {[t for t in ths if t>=0.9]}")

# control: does the solver converge to it when started nearby?
BSarr = BS
def Mof(v): return (v @ BSarr).reshape(N,N)
def resid(v):
    M = Mof(v); nm2=float(np.sum(M*M)); Q=M@M+sharp(M); th=float(np.sum(Q*M)/nm2)
    return np.concatenate([BSarr @ (Q-th*M).ravel(), [nm2-1.0]])
rng = np.random.default_rng(5)
v33 = BSarr @ W33.ravel()
ok = 0
for eps in (1e-3, 1e-2, 5e-2, 0.1, 0.2):
    v0 = v33 + eps*rng.standard_normal(d)
    r = least_squares(resid, v0, method='lm', xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=20000)
    M = Mof(r.x); M /= np.linalg.norm(M); th,_ = theta_of(M, sharp)
    gg = grading_data(M if th>0 else -M, c)
    print(f"  start at eps={eps:<5}: resid={np.linalg.norm(r.fun):.1e} |theta|={abs(th):.6f} "
          f"graded={gg['graded']} gap={gg['gap']:.6f}")
