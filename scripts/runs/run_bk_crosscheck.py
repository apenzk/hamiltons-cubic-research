"""Cross-check the second-kind implementation against Bourguignon-Karcher 1978.

BK section 5.3, page 84, on (CP^m, g_FS) normalised to sectional curvature in [1,4]:
    2(m+1) on R.g,   -4 with multiplicity m(m+1),   2 with multiplicity m^2 - 1 on S^2_0.
Those signs belong to BK's own index order, section 2.2 page 74, which contracts slots 1
and 3 and leaves 2 and 4 free -- the order this script calls 'ikjl'.  Li's 'iklj' order
leaves slots 1 and 4 free, is the negation of BK's, and accordingly gives Li Example 2.5's
    -2 with multiplicity m^2 - 1,   and   4 with multiplicity m(m+1).
Each order reproduces its own paper's table; the check is that both come out, in the right
order, from one implementation.  Corrected 2026-09-02: this file previously carried Li's
pair alone, labelled as BK's, so its MATCH line compared Li's order against Li's pair."""
import numpy as np, collections
def cpm_full(m, lam=1.0):
    """Fubini-Study curvature tensor, R_{ijkl} = lam*(g_ik g_jl - g_il g_jk + J_ik J_jl - J_il J_jk + 2 J_ij J_kl)."""
    d=2*m; g=np.eye(d); J=np.zeros((d,d))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    R=(np.einsum('ik,jl->ijkl',g,g)-np.einsum('il,jk->ijkl',g,g)
       +np.einsum('ik,jl->ijkl',J,J)-np.einsum('il,jk->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    return lam*R
def ring(R, order='iklj'):
    n=R.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]
    def bs(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[bs(i,j) for (i,j) in idx]; m_=len(idx); Op=np.zeros((m_,m_))
    for a,h in enumerate(B):
        Rh=np.einsum(order+',kl->ij',R,h)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Rh*hb)
    gv=np.array([np.trace(b) for b in B]); gv/=np.linalg.norm(gv)
    P=np.eye(m_)-np.outer(gv,gv)
    # restrict to the orthogonal complement of g, i.e. genuinely to S^2_0
    Q,_=np.linalg.qr(np.eye(m_)-np.outer(gv,gv))
    keep=[k for k in range(m_) if np.linalg.norm((np.eye(m_)-np.outer(gv,gv))@Q[:,k])>1e-9]
    Bas=np.linalg.svd(P)[0][:, :m_-1]
    return Bas.T@Op@Bas
def exact_check(m):
    """BK's own order satisfies BK 5.1 p.83, Rring(h) = -h + trace(h) g - 3 J h J, exactly.
    Integer arithmetic throughout -- no floating point, so this settles the sign."""
    d = 2*m; R = cpm_full(m).astype(object)
    g = np.eye(d, dtype=object); J = np.zeros((d,d), dtype=object)
    for k in range(m): J[2*k,2*k+1] = 1; J[2*k+1,2*k] = -1
    ok_bk = ok_li = True
    for a in range(d):
        for b in range(a, d):
            h = np.zeros((d,d), dtype=object); h[a,b] = 1; h[b,a] = 1
            bk = np.einsum('ipjq,ij->pq', R, h)          # BK 2.2: contract slots 1 and 3
            ok_bk &= np.array_equal(bk, -h + np.trace(h)*g - 3*(J@h@J))
            ok_bk &= np.array_equal(np.einsum('ikjl,kl->ij', R, h), bk)
            ok_li &= np.array_equal(np.einsum('iklj,kl->ij', R, h), -bk)
    return ok_bk, ok_li

TARGET = {  # (smallest eigenvalue, its multiplicity, printed source)
    'ikjl': lambda m: (-4, m*(m+1), f"BK 1978 s.5.3 p.84: -4 x {m*(m+1)}, 2 x {m*m-1}"),
    'iklj': lambda m: (-2, m*m-1,   f"Li Example 2.5:    -2 x {m*m-1}, 4 x {m*(m+1)}"),
}

for m in [2,3,4]:
    R = cpm_full(m)
    ok_bk, ok_li = exact_check(m)
    print(f"CP^{m} exact (integer) check: BK-order contraction == -h+tr(h)g-3JhJ (p.83): {ok_bk}; "
          f"'iklj' == -(BK order): {ok_li}")
    for order, label in [('iklj', "Li iklj"), ('ikjl', "BK ikjl")]:
        ev = np.linalg.eigvalsh(ring(R, order))          # floating point, integers to ~1e-14
        c = collections.Counter(np.round(ev, 6))
        lo, mult, pred = TARGET[order](m)
        ok = abs(lo - min(c)) < 1e-6 and c[min(c)] == mult
        print(f"CP^{m} ({label:8s}): spectrum {sorted(c.items())}   {pred}   {'MATCH' if ok else 'FAIL'}")
    print()
