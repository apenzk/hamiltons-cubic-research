import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, itertools, lib320 as L, cat320 as C

def S_triple(Vb,Wb,Ub,n):
    """sum over a in Vb, b in Wb, c in Ub of <[phi_a,phi_b],phi_c>^2, orthonormal frames."""
    c=L.struct(n)
    T=np.einsum('ia,jb,kc,abc->ijk',np.array(Vb),np.array(Wb),np.array(Ub),c,optimize=True)
    return float((T**2).sum())

def eigframes(W,tol=1e-9):
    ev,V=np.linalg.eigh(W)
    return V[:,ev>tol].T, V[:,ev<-tol].T, V[:,np.abs(ev)<=tol].T

def bracket_closure(Vb,n):
    """||Pi_perp [V,V]||^2 / ||[V,V]||^2 : is V a subalgebra?"""
    c=L.struct(n); V=np.array(Vb)
    T=np.einsum('ia,jb,abc->ijc',V,V,c,optimize=True)   # [v_i,v_j] in Lambda^2 coords
    tot=(T**2).sum()
    inside=np.einsum('ijc,kc->ijk',T,V,optimize=True)
    return float(tot-(inside**2).sum()), float(tot)

print("=== P1a: Lemma 23 closed forms on genuine subalgebra members ===")
print(f"{'h':28}{'n':>3}{'r':>4}{'theta_meas':>12}{'theta_form':>12}{'res':>10}{'|Ric|':>10}{'S_mmm_meas':>13}{'S_mmm_form':>13}{'cap':>7}")
cases=[]
for n,blocks,lab in [(4,[2,2],'so(2)+so(2)'),(6,[3,3],'so(3)+so(3)'),(8,[4,4],'so(4)+so(4)'),
                     (10,[5,5],'so(5)+so(5)'),(12,[6,6],'so(6)+so(6)'),
                     (8,[3,5],'so(3)+so(5)'),(10,[4,6],'so(4)+so(6)'),(8,[2,6],'so(2)+so(6)'),
                     (9,[3,3,3],'so(3)^3'),(12,[4,4,4],'so(4)^3'),(6,[2,2,2],'so(2)^3'),
                     (6,[3],'so(3) c so(6)'),(5,[3],'so(3) c so(5)')]:
    hb=C.so_block_subalg(blocks,n)
    W,r=C.casimir(hb,n); N=L.struct(n).shape[0]
    q=L.Q(W,n); th=L.frob(W,q); res=np.linalg.norm(q-th*W)
    hf,mf,kf=eigframes(W)
    Sm=S_triple(mf,mf,mf,n)
    thf=(2/n)*np.sqrt(r*N/(N-r)); Sf=(N-r)*(2*(n-2)-4*(n-1)*r/N)
    ric=float(np.abs(L.ricci(W,n)).max())
    cases.append((lab,n,r,th,thf,res,ric,Sm,Sf,n*(n-2)/4))
    print(f"{lab:28}{n:>3}{r:>4}{th:>12.6f}{thf:>12.6f}{res:>10.1e}{ric:>10.1e}{Sm:>13.4f}{Sf:>13.4f}{n*(n-2)/4:>7.2f}")

print()
print("=== P1b: is every SYMMETRIC subalgebra of so(n) at or above the cap? ===")
print("so(p)+so(q): r-cap = (p-q)^2/4 ;  u(m) c so(2m): r-cap = m")
for n in range(4,21,2):
    rows=[]
    for p in range(1,n//2+1):
        q=n-p; r=p*(p-1)//2+q*(q-1)//2
        rows.append((f"so({p})+so({q})",r,r-n*(n-2)/4))
    m=n//2; rows.append((f"u({m})",m*m,m*m-n*(n-2)/4))
    print(n, "cap=%.2f"%(n*(n-2)/4), " ".join(f"{a}:r={b},r-cap={c:+.2f}" for a,b,c in rows))
