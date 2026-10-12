"""Reviewer 63 -- C1 (eigenframe form) and C2 (exact weighted row sum) tests."""
import itertools, sys, numpy as np
sys.path.insert(0, 'scripts/lib')[0])
from review_r63_core import *

def c1_check(m, ndraw, rng):
    c,_,_ = structure_constants(m); wb = weyl_basis(m); worst=0.0
    for _ in range(ndraw):
        W = random_weyl(m, rng, wb); th = theta(W,c); lam,T,cp = eigen_T(W,c); n=len(lam)
        rhs = np.sum(lam**3) + 3*sum(T[a,b,g]*lam[a]*lam[b]*lam[g]
              for a,b,g in itertools.combinations(range(n),3))
        worst = max(worst, abs(th-rhs))
        # structural properties of T
        assert abs(T - T.transpose(1,0,2)).max() < 1e-10
        assert abs(T - T.transpose(0,2,1)).max() < 1e-10
        assert T.min() > -1e-14
        assert max(abs(T[a,a,b]) for a in range(n) for b in range(n)) < 1e-18
        R = T.sum(axis=2)
        assert abs(R.sum(axis=1) - 2*(m-2)).max() < 1e-8, R.sum(axis=1)
        assert R.max() < 2 + 1e-8
        assert abs(R@lam + 2*lam).max() < 1e-8
    return worst

def c2_check(m, ndraw, rng, tol_neg=1e-9):
    """On Weyl operators with EXACTLY two negative eigenvalues, check the exact
    weighted-row-sum identity and the derived inequality."""
    c,_,_ = structure_constants(m); wb = weyl_basis(m)
    got = []
    for _ in range(ndraw):
        W = random_weyl(m, rng, wb); lam,T,cp = eigen_T(W,c)
        neg = np.where(lam < -tol_neg)[0]
        if len(neg) != 2: continue
        R = T.sum(axis=2); n = len(lam)
        # sorted descending: index N = most negative = -b, N-1 = -c
        order = np.argsort(-lam); lam_s = lam[order]; Rs = R[np.ix_(order,order)]
        b = -lam_s[-1]; cc = -lam_s[-2]; Rn = Rs[-2,-1]
        P = [a for a in range(n) if lam_s[a] > tol_neg]
        u = sum(lam_s[a]**2 for a in P); s = sum(lam_s[a] for a in P)
        rowNm1 = sum(lam_s[a]*Rs[a,n-2] for a in P)
        rowN   = sum(lam_s[a]*Rs[a,n-1] for a in P)
        quad = sum(Rs[a,bb]*lam_s[a]*lam_s[bb] for a in P for bb in P)
        got.append(dict(b=b,c=cc,R=Rn,s=s,u=u,
            e1=abs(rowNm1-(2*cc+b*Rn)), e2=abs(rowN-(2*b+cc*Rn)),
            e3=abs(quad-(2*b*b+2*cc*cc+2*b*cc*Rn-2*u)),
            ineq=(s*s+b*b+cc*cc-1), k=len(P)))
    return got

if __name__ == '__main__':
    rng = np.random.default_rng(12345)
    print('=== C1 ===')
    for m in (4,5,6,7):
        print('  m=%d  max |theta - eigenframe form| = %.3e   (T properties OK)'%(m, c1_check(m,4,rng)))
    print('=== C2 ===  (Weyl draws restricted to exactly two negative eigenvalues)')
    for m in (4,5,6):
        g = c2_check(m, 400, rng)
        if not g: print('  m=%d  no two-negative draws'%m); continue
        print('  m=%d  n=%d hits  max err row(N-1)=%.2e row(N)=%.2e quad=%.2e   min (s^2+b^2+c^2-1)=%.3e  k range %d..%d'
              %(m,len(g),max(x['e1'] for x in g),max(x['e2'] for x in g),max(x['e3'] for x in g),
                min(x['ineq'] for x in g), min(x['k'] for x in g), max(x['k'] for x in g)))
    # base-case family W4(q,r) on Lambda^2 R^4
    print('=== C2 on the base-case family W4(q,r) ===')
    _,B4 = basis(4)
    w = [(B4[0]+B4[5])/np.sqrt(2), (B4[1]-B4[4])/np.sqrt(2), (B4[2]+B4[3])/np.sqrt(2)]
    w = [x/np.sqrt(ip(x,x)) for x in w]
    c4,_,_ = structure_constants(4)
    for (q,r) in [(1,1),(1,2),(0.3,2.7),(1,0.001),(2,5)]:
        # signature (1,2): +(q+r) on w1, -q on w2, -r on w3
        vecs = np.array([[ip(wi, B4[a]) for a in range(6)] for wi in w])
        W = (q+r)*np.outer(vecs[0],vecs[0]) - q*np.outer(vecs[1],vecs[1]) - r*np.outer(vecs[2],vecs[2])
        W = W/np.sqrt(ip_mat(W,W))
        lam = np.sort(np.linalg.eigvalsh(W))[::-1]
        bb=-lam[-1]; cc=-lam[-2]; s=sum(x for x in lam if x>1e-12)
        wb4 = weyl_basis(4); Pw = np.array([X.ravel() for X in wb4])
        inweyl = np.linalg.norm(Pw.T@(Pw@W.ravel()) - W.ravel())
        lam_e, T_e, _ = eigen_T(W, c4)
        c1err = abs(theta(W,c4) - (np.sum(lam_e**3)+3*sum(T_e[a,b,g]*lam_e[a]*lam_e[b]*lam_e[g]
                                                          for a,b,g in itertools.combinations(range(6),3))))
        print('  q=%.3f r=%.3f  spec=%s  #pos=%d #neg=%d  s^2+b^2+c^2-1 = %+.3e  in Weyl_4: %.1e  C1 err %.1e  theta=%.6f'
              %(q,r,np.round(lam,4), int(np.sum(lam>1e-9)), int(np.sum(lam<-1e-9)),
                s*s+bb*bb+cc*cc-1, inweyl, c1err, theta(W,c4)))
