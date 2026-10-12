import numpy as np
from itertools import combinations
from scipy.optimize import linprog

def theta_lp(lam, n, label, cap=None):
    N = len(lam)
    triples = list(combinations(range(N), 3))
    nv = len(triples)
    Aeq = np.zeros((3*N, nv+1)); beq = np.zeros(3*N)
    for i, t in enumerate(triples):
        for pos in range(3):
            k = t[pos]; o = [t[j] for j in range(3) if j != pos]
            lb, lc = lam[o[0]], lam[o[1]]
            Aeq[3*k, i] += 1.0; Aeq[3*k+1, i] += lb+lc; Aeq[3*k+2, i] += lb*lc
    for k in range(N):
        beq[3*k] = n-2; beq[3*k+1] = -2*lam[k]
        Aeq[3*k+2, nv] = -lam[k]; beq[3*k+2] = -lam[k]**2
    ob = np.zeros(nv+1); ob[nv] = 1.0
    bounds = [(0, None)]*nv + [(None, None)]
    hi = linprog(-ob, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    print(f"[{label}] max theta over full system:",
          -hi.fun if hi.status == 0 else hi.message)

# maximal torus n=6: values (4,-1)/sqrt60, mults (3,12); true scaled theta = 5
theta_lp(np.array([4.0]*3 + [-1.0]*12), 6, "torus n=6 scaled (true theta=5, post-41 LP gave 3x)")
# padded CP2 n=6: values (2,-1,0)/sqrt6, mults (1,2,12); true scaled theta = 3
theta_lp(np.array([2.0] + [-1.0]*2 + [0.0]*12), 6, "padded CP2 n=6 scaled (true theta=3)")
# torus n=8: h=so(2)^4 dim 4, N=28: eigs (1-4/28, -4/28) -> (6,-1)/? : 4*36+24*1=168
# true theta = 0.540062*sqrt(168) = 7.0?
print("torus n=8 check: 0.540061725*sqrt(168) =", 0.540061725*np.sqrt(168))
theta_lp(np.array([6.0]*4 + [-1.0]*24), 8, "torus n=8 scaled (true theta=7)")

# CP3 rebuild: try FS sign conventions until Bianchi+criticality hold
def weyl_normalize(R, n):
    g = np.eye(n)
    Ric = np.einsum('ijkj->ik', R); s = np.trace(Ric)
    Wt = R.copy()
    Wt -= (np.einsum('ik,jl->ijkl', Ric, g) - np.einsum('il,jk->ijkl', Ric, g)
           + np.einsum('jl,ik->ijkl', Ric, g) - np.einsum('jk,il->ijkl', Ric, g))/(n-2)
    Wt += s*(np.einsum('ik,jl->ijkl', g, g)-np.einsum('il,jk->ijkl', g, g))/((n-1)*(n-2))
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    N = len(pairs)
    Wm = np.zeros((N, N))
    for P, (i, j) in enumerate(pairs):
        for Q_, (k, l) in enumerate(pairs):
            Wm[P, Q_] = Wt[i, j, k, l]
    return Wm/np.sqrt(np.trace(Wm @ Wm))

def so_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = -1
            B.append(E)
    return B
def inner(X, Y): return 0.5*np.trace(X.T @ Y)
def theta_of(Wm, n):
    N = Wm.shape[0]; B = so_basis(n)
    lam, U = np.linalg.eigh(Wm)
    Phi = [sum(U[k, a]*B[k] for k in range(N)) for a in range(N)]
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(a+1, N):
            Cm = Phi[a] @ Phi[b] - Phi[b] @ Phi[a]
            for d2 in range(N):
                v = inner(Phi[d2], Cm); c[a, b, d2] = v; c[b, a, d2] = -v
    adm = np.transpose(c, (0, 2, 1)); Wd = np.diag(lam)
    Sharp = np.zeros((N, N))
    for k in range(N):
        for l in range(k, N):
            Sharp[k, l] = Sharp[l, k] = -0.5*np.trace(adm[k] @ Wd @ adm[l] @ Wd)
    Qm = Wd @ Wd + Sharp
    th = np.trace(Qm @ Wd)/np.trace(Wd @ Wd)
    return lam, th, np.abs(Qm - th*Wd).max()

n = 6
J = np.zeros((n, n))
for a in range(3):
    J[2*a, 2*a+1] = 1; J[2*a+1, 2*a] = -1
d = np.eye(n)
for s3 in (+1, -1):
    R = 0.25*(np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
              + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
              + 2*s3*np.einsum('ij,kl->ijkl', J, J))
    Wc = weyl_normalize(R, 6)
    lam6, th6, res6 = theta_of(Wc, 6)
    print("CP3 s3=", s3, " theta:", th6, " residual:", res6,
          " spectrum:", sorted(set(np.round(lam6, 6))))
