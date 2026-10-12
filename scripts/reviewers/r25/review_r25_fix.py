import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys; sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
import numpy as np, itertools
import review_r25_core as R, review_r25_tests as T, review_r25_subalgebras as S

def normalizes(gens, g, tol=1e-8):
    """does conjugation by g preserve span(gens)?"""
    V = np.array([X.flatten() for X in gens]).T
    Uq, s, _ = np.linalg.svd(V, full_matrices=False)
    k = int((s > 1e-9*s[0]).sum()); Uq = Uq[:, :k]
    worst = 0.0
    for X in gens:
        Y = (g @ X @ g.T).flatten()
        worst = max(worst, np.linalg.norm(Y - Uq @ (Uq.T @ Y)))
    return worst

# ---------------- u(m) with the correct complex conjugation
def u_m_fixed(m):
    name, n, g, _ = S.u_m(m)
    conj = np.diag([1.0, -1.0] * m)
    return name, n, g, [conj]

def su_m_fixed(m):
    name, n, g, _ = S.su_m(m)
    conj = np.diag([1.0, -1.0] * m)
    return name, n, g, [conj]

# ---------------- so(p)+so(q) with the full normaliser (O(p) x O(q)) (x) Z2
def so_p_so_q_full(p, q):
    n = p + q
    g = S.so_gens(n, range(p)) + S.so_gens(n, range(p, n))
    r1 = np.eye(n); r1[0, 0] = -1
    r2 = np.eye(n); r2[p, p] = -1
    extra = [r1, r2]
    if p == q:
        perm = list(range(p, n)) + list(range(p))
        extra.append(S.block_diag_perm(n, perm))
    return f"so({p})+so({q})*", n, g, extra

def so_blocks_full(parts):
    name, n, g, extra = S.so_blocks(parts)
    offs, s = [], 0
    for pp in parts:
        offs.append(s); s += pp
    for o in offs:
        r = np.eye(n); r[o, o] = -1; extra.append(r)
    return name + "*", n, g, extra

# ---------------- g2 from the cyclic Fano plane
def g2_fixed():
    n = 7
    lines = [((i) % 7, (i+1) % 7, (i+3) % 7) for i in range(7)]
    phi = np.zeros((7,7,7))
    for (a,b,c) in lines:
        for perm, s in ((( a,b,c),1),((b,c,a),1),((c,a,b),1),((b,a,c),-1),((a,c,b),-1),((c,b,a),-1)):
            phi[perm] = s
    return phi

def stab_of_form(n, F, rank):
    gens = []
    for a in range(n):
        for b in range(a+1, n):
            X = np.zeros((n,n)); X[a,b]=1; X[b,a]=-1; gens.append(X)
    rows = []
    for X in gens:
        D = np.zeros_like(F)
        for pos in range(rank):
            letters = 'ijkl'[:rank]
            src = letters[:pos] + 'a' + letters[pos+1:]
            D = D + np.einsum(f'a{letters[pos]},{src}->{letters}', X, F)
        rows.append(D.flatten())
    A = np.array(rows)
    Uu, ss, Vv = np.linalg.svd(A, full_matrices=True)
    rk = int((ss > 1e-8*ss[0]).sum())
    lnull = Uu[:, rk:]
    return [sum(ci*Xi for ci, Xi in zip(c, gens)) for c in lnull.T]

def g2_in_so7():
    phi = g2_fixed()
    return "g2", 7, stab_of_form(7, phi, 3), []

def spin7_in_so8():
    phi = g2_fixed()
    # Hodge dual of phi in R^7
    eps = np.zeros((7,)*7)
    for perm in itertools.permutations(range(7)):
        pl = list(perm); visited=[False]*7; par=0
        for i in range(7):
            if not visited[i]:
                j=i; c=0
                while not visited[j]:
                    visited[j]=True; j=pl[j]; c+=1
                par += c-1
        eps[perm] = (-1)**par
    star = np.einsum('ijklabc,abc->ijkl', eps, phi) / 6.0
    Phi = np.zeros((8,8,8,8))
    Phi[:7,:7,:7,:7] = star
    # add phi ^ e_7  (index 7 is the extra direction)
    for i in range(7):
        for j in range(7):
            for k in range(7):
                v = phi[i,j,k]
                if v == 0: continue
                for perm, s in (((i,j,k,7),1),((i,j,7,k),-1),((i,7,j,k),1),((7,i,j,k),-1)):
                    Phi[perm] += s*v
    return "spin(7)", 8, stab_of_form(8, Phi, 4), []

if __name__ == "__main__":
    for f in [g2_in_so7(), spin7_in_so8()]:
        print(f[0], "dim h =", len(f[2]) and np.linalg.matrix_rank(np.array([X.flatten() for X in f[2]])))
    for m in [3,4,5]:
        nm,n,g,ex = u_m_fixed(m); print(nm, "normalizer defect", normalizes(g, ex[0]))
    for (p,q) in [(4,4),(3,3),(5,5)]:
        nm,n,g,ex = so_p_so_q_full(p,q)
        print(nm, "normalizer defects", [round(normalizes(g,e),12) for e in ex])
