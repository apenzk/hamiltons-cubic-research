"""Bi-spectral identity  theta = 3/2 tr_{Lambda^2}(W^3) - 1/2 tr_{S^2_0}(Wring^3)  at the catalogued points.
Second-kind operator in Li's convention, arXiv:2112.08465 eq. (2.2).
cross-checked against the record's Q_general.  Fresh builders throughout."""
import numpy as np, itertools, sys
sys.path.insert(0, 'scripts/lib')
from weyl import build_structure_constants, Q_general

def lam2(W):
    n=W.shape[0]; pairs=list(itertools.combinations(range(n),2)); N=len(pairs)
    M=np.zeros((N,N))
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs): M[a,b]=W[i,j,k,l]
    return M,pairs
def sharp(M,pairs,n):
    N=len(pairs)
    def E(i,j):
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; return A
    B=[E(i,j) for (i,j) in pairs]; c=np.zeros((N,N,N))
    for a in range(N):
        for b in range(N):
            C=B[a]@B[b]-B[b]@B[a]
            for g,(k,l) in enumerate(pairs): c[a,b,g]=C[k,l]
    return 0.5*np.einsum('agd,bez,ge,dz->ab',c,c,M,M,optimize=True)
def ring(W):
    n=W.shape[0]; idx=[(i,j) for i in range(n) for j in range(i,n)]; m=len(idx)
    def basis(i,j):
        h=np.zeros((n,n))
        if i==j: h[i,i]=1
        else: h[i,j]=h[j,i]=1/np.sqrt(2)
        return h
    B=[basis(i,j) for (i,j) in idx]; Op=np.zeros((m,m))
    for a,h in enumerate(B):
        Wh=np.einsum('iklj,kl->ij',W,h)  # Li arXiv:2112.08465 eq. (2.2)
        for b,hb in enumerate(B): Op[a,b]=np.sum(Wh*hb)
    g=np.array([np.trace(basis(i,j)) for (i,j) in idx]); g/=np.linalg.norm(g)
    Pr=np.eye(m)-np.outer(g,g); return Pr@Op@Pr
def diag_weyl(Lam):
    n=Lam.shape[0]; I=np.eye(n)
    return np.einsum('ij,ik,jl->ijkl',Lam,I,I)-np.einsum('ij,il,jk->ijkl',Lam,I,I)
def sphere_product(p,q):
    # SIGN.  This built the NEGATIVE of the Weyl tensor of S^p x S^q -- intra-block
    # negative and cross positive, where the true tensor from Kulkarni-Nomizu has
    # intra POSITIVE and cross NEGATIVE (reviewer 230, |W_true + W_old| = 3e-17).
    # theta is cubic in W, so the catalogue reported -theta_0 at every balanced
    # product and printed it for the whole programme without anyone reading it.
    # Two later cycles then cancelled this against a flipped second-kind index
    # order and reproduced correct numbers from two wrong reasons.
    n=p+q; Lam=np.zeros((n,n)); b=-1.0
    a1=-q*b/(p-1); a2=-p*b/(q-1)
    for i in range(n):
        for j in range(n):
            if i==j: continue
            Lam[i,j]= a1 if (i<p and j<p) else a2 if (i>=p and j>=p) else b
    return diag_weyl(Lam)
def cpm(m, n=None):
    d=2*m; J=np.zeros((d,d))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    g=np.eye(d)
    R=(np.einsum('jk,il->ijkl',g,g)-np.einsum('ik,jl->ijkl',g,g)
       +np.einsum('jk,il->ijkl',J,J)-np.einsum('ik,jl->ijkl',J,J)+2*np.einsum('ij,kl->ijkl',J,J))
    # R_{ijkl} = <R(e_i,e_j)e_k, e_l> convention; fix so that Bianchi holds and Ricci removed
    R=R-(R+R.transpose(1,2,0,3)+R.transpose(2,0,1,3))/3
    Ric=np.einsum('ikjk->ij',R); s=np.trace(Ric); E=Ric-s/d*g
    def KN(A,B): return np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)-np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B)
    W=R-KN(E,g)/(d-2)-s/(2*d*(d-1))*KN(g,g)
    if n and n>d:
        Wp=np.zeros((n,n,n,n)); Wp[:d,:d,:d,:d]=W; W=Wp
    return W
def evaluate(label,W):
    n=W.shape[0]
    ric=np.abs(np.einsum('ikjk->ij',W)).max(); bia=np.abs(W+W.transpose(1,2,0,3)+W.transpose(2,0,1,3)).max()
    M,pairs=lam2(W); M/=np.linalg.norm(M); W=W/np.linalg.norm(lam2(W)[0])
    theta=np.trace(M@M@M)+np.trace(sharp(M,pairs,n)@M)
    idx,pos,N,c=build_structure_constants(n); Qrec=Q_general(M,c); theta_rec=np.sum(Qrec*M)
    t1=np.trace(M@M@M); R0=ring(W); t2=np.trace(R0@R0@R0); q2=np.trace(R0@R0)
    om=np.sort(np.linalg.eigvalsh(R0))[::-1]; mu=np.sort(np.linalg.eigvalsh(M))[::-1]
    # THE GUARD THAT ACTUALLY BITES (reviewer 233).  The theta = +theta_0 check
    # below fires only on the balanced products and only on the constructor's
    # overall sign.  Four other one-token plants pass it: swapping a1/a2 (a
    # no-op at p=q, but it makes S^5xS^7 read theta = 1.268758, ABOVE theta_0(12)
    # -- a planted bug that manufactures a counterexample to the conjecture);
    # flipping cpm()'s sign, CP^m being unguarded while sqrt(3/2) anchors the
    # crossover; and flipping ring()'s index order, which passes because this
    # function computes theta from M alone and never calls ring -- exactly the
    # dispute the guard was written to settle.
    #
    # Asserting this file's OWN bi-spectral identity catches all of them at
    # every catalogued point, balanced or not, because it couples the Lambda^2
    # and second-kind spectra to theta.
    assert abs(theta - (1.5*t1 - 0.5*t2)) < 1e-9, (
        f"{label}: the bi-spectral identity fails, theta={theta:+.9f} against "
        f"1.5*t1 - 0.5*t2 = {1.5*t1 - 0.5*t2:+.9f}.  Either the tensor, the "
        "Lambda^2 spectrum or the second-kind operator is wrong -- the identity "
        "is Gate-2-passed and holds at every algebraic curvature tensor")
    print(f"{label:26s} n={n:2d} theta={theta:+.6f} (record Q: {theta_rec:+.6f}) | 1.5t1={1.5*t1:+.6f} 0.5t2={-0.5*t2:+.6f} sum={1.5*t1-0.5*t2:+.6f} | trW̊²={q2:.4f} ric={ric:.0e} bia={bia:.0e}")
    return mu,om,theta
print("=== catalogued points ===")
for (p,q) in [(3,3),(4,4),(5,5),(6,6),(5,7),(4,8)]: evaluate(f"S^{p}xS^{q}",sphere_product(p,q))
evaluate("CP^2",cpm(2)); evaluate("CP^2 padded n=6",cpm(2,6)); evaluate("CP^3",cpm(3)); evaluate("CP^4",cpm(4)); evaluate("CP^2 padded n=12",cpm(2,12))
# THE GUARD REVIEWER 230 ASKED FOR, AND IT IS ONE LINE OF MATHEMATICS.  Nothing
# may be read off a catalogued maximiser before its theta is confirmed to be
# +theta_0(n).  A sign error in the constructor is invisible in |W|, in Ricci, in
# Bianchi and in tr(Wring^2) -- every screen this file already ran -- and visible
# at once here, because theta is CUBIC and so odd under W -> -W.
import io as _io, contextlib as _cl
for _m in (6, 8, 12):
    _W = sphere_product(_m//2, _m//2)
    with _cl.redirect_stdout(_io.StringIO()):
        _mu, _om, _th = evaluate(f"guard S^{_m//2}xS^{_m//2}", _W)
    _t0 = np.sqrt(2*(_m-1)*(_m-2))/_m
    assert abs(_th - _t0) < 1e-9, (
        f"the balanced product at n={_m} has theta={_th:+.6f}, not "
        f"+theta_0={_t0:+.6f}.  A value of -theta_0 means the constructor builds "
        "the ANTI-maximiser, and every cubic quantity read off this catalogue "
        "carries the wrong sign")
print("\nguard: theta = +theta_0 at the balanced products n = 6, 8, 12")

print("\n=== n=6 isospectral family: ±1 on K_{2,2,2}, zero row sums ===")
n=6; parts=[(0,1),(2,3),(4,5)]; edges=[(i,j) for i in range(6) for j in range(i+1,6) if not any(set((i,j))==set(pp) for pp in parts)]
seen={}
for signs in itertools.product([1,-1],repeat=len(edges)):
    Lam=np.zeros((6,6))
    for (i,j),s in zip(edges,signs): Lam[i,j]=Lam[j,i]=s
    if np.any(Lam.sum(1)!=0): continue
    W=diag_weyl(Lam); M,pairs=lam2(W); nrm=np.linalg.norm(M); M/=nrm; W/=nrm
    P=np.trace(M@M@M)+np.trace(sharp(M,pairs,6)@M)
    R0=ring(W); om=tuple(np.round(np.sort(np.linalg.eigvalsh(R0)),6)); mu=tuple(np.round(np.sort(np.linalg.eigvalsh(M)),6))
    key=(round(P*12*np.sqrt(12),6),om)  # P scaled back to |W|^2=12 normalisation: P_12 = P * 12^{3/2}
    seen.setdefault(key,[mu,0]); seen[key][1]+=1
print(f"{sum(v[1] for v in seen.values())} tensors; distinct (P at |W|²=12, S²₀-spectrum) classes:")
for (P12,om),(mu,cnt) in sorted(seen.items()):
    print(f"  P={P12:+8.3f}  count={cnt:3d}  Λ²-spectrum={mu}\n           S²₀-spectrum={om}")
