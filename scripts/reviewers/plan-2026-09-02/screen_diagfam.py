import sys, itertools, numpy as np
sys.path.insert(0, 'scripts/lib')
from adversarial_check1 import structure_constants, Q_full, B_full, P_value
np.set_printoptions(precision=6, suppress=True, linewidth=150)

def E(pos, N, a, b):
    X = np.zeros((N, N)); X[pos[a], pos[b]] += 1.0; X[pos[b], pos[a]] += 1.0
    return X / (2.0 if a == b else np.sqrt(2.0))

# ---------- screen 1: padded CP^2 at n=6, frame-M lift of Lemma 57 ----------
n = 6
pairs, pos, N, c = structure_constants(n)
def vec(*terms):
    v = np.zeros(N)
    for (a, coef) in terms: v[pos[a]] = coef
    return v / np.linalg.norm(v)
om = vec(((0,1),1),((2,3),1)); e1 = vec(((0,2),1),((1,3),-1)); e2 = vec(((0,3),1),((1,2),1))
W = (2*np.outer(om,om) - np.outer(e1,e1) - np.outer(e2,e2)) / np.sqrt(6)
theta = P_value(W, c); res = np.linalg.norm(Q_full(W, c) - theta*W)
print("CP2 padded n=6: theta=%.6f sqrt(3/2)=%.6f crit-residual=%.1e norm=%.6f" % (theta, np.sqrt(1.5), res, np.linalg.norm(W)))
M = np.zeros((n, n))
for (i, j) in pairs: M[i, j] = M[j, i] = W[pos[(i,j)], pos[(i,j)]]
print("row sums of M_F:", M.sum(1))
ev, U = np.linalg.eigh(M); mu = ev[-1]; v = U[:, -1]
Sig = sum(M[i,j]**2 * (v[i]-v[j])**2 for i,j in pairs)
eps = theta*mu - mu**2 + Sig
print("mu=%.6f (2/sqrt6=%.6f) Sigma=%.6f (1/6=%.6f) eps=%.6f  (n-1)/n*mu=%.6f  eps/mu=%.6f  Theta_n-(n-1)mu/n=%.6f" % (mu, 2/np.sqrt(6), Sig, 1/6, eps, (n-1)/n*mu, eps/mu, np.sqrt(2*(n-1)*(n-2))/n-(n-1)/n*mu))
# the Cauchy-Schwarz side: mu^2 <= n*Sigma ?
print("CS check: mu^2=%.6f  n*Sigma=%.6f  ->  theta <= (n-1)mu/n + eps/mu : %.6f <= %.6f" % (mu**2, n*Sig, theta, (n-1)/n*mu + eps/mu))

# ---------- screen 2: Gamma-character blocks of L_e at S^3 x S^3 ----------
p = q = 3
cval = 1/np.sqrt(22.5); aval = -1.5*cval
Md = np.zeros((n, n))
for i, j in pairs:
    Md[i,j] = Md[j,i] = aval if (i<p) == (j<p) else cval
Wd = np.diag([Md[i,j] for (i,j) in pairs])
th = P_value(Wd, c); print("S3xS3: theta=%.6f theta0(6)=%.6f residual=%.1e" % (th, np.sqrt(2*5*4)/6, np.linalg.norm(Q_full(Wd,c)-th*Wd)))
e = Wd/th
def Le(X): return B_full(e, X, c)
def char(a, b):
    s = [0]*n
    for i in a+b: s[i] ^= 1
    return tuple(s)
# block support test on random symmetric X of a fixed character
rng = np.random.default_rng(0)
basis = [(a,b) for a in pairs for b in pairs if pos[a] <= pos[b]]
chars = {}
for (a,b) in basis: chars.setdefault(char(a,b), []).append((a,b))
mults = sorted(set(len(v) for v in chars.values()))
print("character multiplicities in Sym^2(Lambda^2) (before Bianchi/Ricci):", {m: sum(1 for v in chars.values() if len(v)==m) for m in mults})
maxleak = 0.0
for ch, elems in list(chars.items())[:40]:
    X = sum(rng.standard_normal()*E(pos,N,a,b) for (a,b) in elems)
    Y = Le(X)
    for (a,b) in basis:
        if char(a,b) != ch: maxleak = max(maxleak, abs(Y[pos[a],pos[b]]))
print("max leak of L_e X outside X's character block: %.1e" % maxleak)
# 4-set block {0,1,2,3}: Weyl directions alpha E(01,23)+beta E(02,13)+gamma E(03,12), alpha+beta+gamma=0
fs = [((0,1),(2,3)), ((0,2),(1,3)), ((0,3),(1,2))]
Bm = np.zeros((3,3))
for r,(a,b) in enumerate(fs):
    Y = Le(E(pos,N,a,b))
    for s,(a2,b2) in enumerate(fs): Bm[r,s] = np.sum(Y*E(pos,N,a2,b2))
print("4-set {0,1,2,3} raw 3x3 L_e block:\n", Bm)
Pb = np.eye(3) - np.ones((3,3))/3
sub = Pb @ Bm @ Pb
print("  eigenvalues on the Bianchi plane alpha+beta+gamma=0:", np.linalg.eigvalsh(sub)[1:])
fs2 = [((0,1),(3,4)), ((0,3),(1,4)), ((0,4),(1,3))]  # 4-set {0,1,3,4}: two from block p, two from block q
Bm2 = np.zeros((3,3))
for r,(a,b) in enumerate(fs2):
    Y = Le(E(pos,N,a,b))
    for s,(a2,b2) in enumerate(fs2): Bm2[r,s] = np.sum(Y*E(pos,N,a2,b2))
print("4-set {0,1,3,4} eigenvalues on Bianchi plane:", np.linalg.eigvalsh(Pb@Bm2@Pb)[1:])
# pair block {j,k}={0,1}: X = sum_i x_i E((0,i),(1,i)), sum x_i = 0 (Ricci)
idx = [i for i in range(n) if i not in (0,1)]
def pe(i0,i): return E(pos,N,tuple(sorted((i0,i))),tuple(sorted((1,i)))) if i0==0 else None
Pm = np.zeros((len(idx),len(idx)))
for r,i in enumerate(idx):
    Y = Le(E(pos,N,tuple(sorted((0,i))),tuple(sorted((1,i)))))
    for s,k in enumerate(idx): Pm[r,s] = np.sum(Y*E(pos,N,tuple(sorted((0,k))),tuple(sorted((1,k)))))
m = len(idx); Pr = np.eye(m) - np.ones((m,m))/m
print("pair block {0,1} (same block) raw:\n", Pm, "\n  eigenvalues on the Ricci hyperplane:", np.linalg.eigvalsh(Pr@Pm@Pr))
idx = [i for i in range(n) if i not in (0,3)]
Pm = np.zeros((len(idx),len(idx)))
for r,i in enumerate(idx):
    Y = Le(E(pos,N,tuple(sorted((0,i))),tuple(sorted((3,i)))))
    for s,k in enumerate(idx): Pm[r,s] = np.sum(Y*E(pos,N,tuple(sorted((0,k))),tuple(sorted((3,k)))))
print("pair block {0,3} (cross) eigenvalues on the Ricci hyperplane:", np.linalg.eigvalsh(Pr@Pm@Pr))
# orbit direction in the cross pair block: x_i = M_{0i} - M_{3i}
x = np.array([Md[0,i]-Md[3,i] for i in idx]); x/=np.linalg.norm(x)
print("  orbit vector x_i=M_0i-M_3i: Rayleigh quotient = %.6f (expect 1/2)" % (x@Pm@x))
