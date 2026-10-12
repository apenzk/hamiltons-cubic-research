"""Reviewer 25, subalgebras as stabilisers of random/structured tensors."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np
import review_r25_core as R, review_r25_tests as T, review_r25_fix as F

def stab_sym_tensor(n, Tn, rank):
    gens = []
    for a in range(n):
        for b in range(a+1, n):
            X = np.zeros((n,n)); X[a,b]=1; X[b,a]=-1; gens.append(X)
    rows = []
    letters = 'ijkl'[:rank]
    for X in gens:
        D = np.zeros_like(Tn)
        for pos in range(rank):
            src = letters[:pos] + 'a' + letters[pos+1:]
            D = D + np.einsum(f'a{letters[pos]},{src}->{letters}', X, Tn)
        rows.append(D.flatten())
    A = np.array(rows)
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    rk = int((s > 1e-8*max(s[0],1e-30)).sum())
    return [sum(ci*Xi for ci, Xi in zip(c, gens)) for c in U[:, rk:].T]

def sym_random(n, rank, rng, traceless=True):
    Tn = rng.normal(size=(n,)*rank)
    # symmetrise
    import itertools
    S = np.zeros_like(Tn)
    for p in itertools.permutations(range(rank)):
        S += np.transpose(Tn, p)
    S /= __import__("math").factorial(rank)
    if traceless and rank == 3:
        tr = np.einsum('iaa->i', S) / (n + 2)
        for i in range(n):
            for j in range(n):
                for k in range(n):
                    S[i,j,k] -= (tr[i]*(j==k) + tr[j]*(i==k) + tr[k]*(i==j))
    return S

if __name__ == "__main__":
    rng = np.random.default_rng(7)
    print("stabilisers of random traceless cubics / quartics")
    for n in range(5, 11):
        cap = n*(n-2)/4; N = n*(n-1)//2
        seen = set()
        for rank in (3, 4):
            for trial in range(25):
                Tn = sym_random(n, rank, rng)
                g = stab_sym_tensor(n, Tn, rank)
                r = len(g)
                if r == 0 or r >= N or r in seen: continue
                seen.add(r)
                ex = []
                d = T.analyse(f"stab-n{n}-rk{rank}-r{r}", n, g, ex)
                ok = (d['F1h']==1 and d['F1m']==1 and d['F2']==1 and d['F3']==0)
                print(f"  n={n} rank={rank} r={r:3d} cap={cap:6.2f} F1h={d['F1h']} F1m={d['F1m']} "
                      f"F2={d['F2']} F3={d['F3']} MEMBER={ok} th={d['theta']:.6f} pred={d['theta_pred']:.6f} "
                      f"resid={d['crit_resid']:.1e} VIOLATES={r>cap}", flush=True)
        print(f" n={n} dims seen {sorted(seen)}", flush=True)
