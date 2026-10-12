import sys, itertools, numpy as np
sys.path.insert(0,'scripts/lib'); sys.path.insert(0,'scripts/reviewers/r291')
from r291_core import *
from r291_c4_c5 import structure_ok, components, cliques_and_twins
from b_symmetry_defect import defect as record_defect
from review_r30_core import sphere_product_W
from b_c5_blowup import c5_operator

rng=np.random.default_rng(291)

def int_locus(n, rng, k=6, amp=3):
    """integer points of the locus: sums of the 4-index generators M_ij=M_kl=1, M_ik=M_jl=-1."""
    M=np.zeros((n,n))
    for _ in range(k):
        i,j,kk,l = rng.choice(n, size=4, replace=False)
        c=rng.integers(-amp, amp+1)
        for (u,v,s) in ((i,j,1),(kk,l,1),(i,kk,-1),(j,l,-1)):
            M[u,v]+=c*s; M[v,u]+=c*s
    return M

print("=== C4 both directions on random INTEGER locus points, n=6..9 ===")
bad=0; tot=0; zero_delta=0
for n in (6,7,8,9):
    for t in range(400):
        M=int_locus(n,rng)
        if not np.any(M): continue
        tot+=1
        D,_,S,_,_=defect_diag(n, M)
        d0 = D<1e-9; s0=structure_ok(M,n); sub,_=cliques_and_twins(M,n)
        if d0: zero_delta+=1
        if d0!=s0 or d0!=sub: bad+=1; print("  MISMATCH", n, M.tolist(), D, s0, sub)
print(f"  {tot} points, {zero_delta} with Delta=0, mismatches={bad}")

print("\n=== C4 'if' on constructed block-constant points (row sums 0, inter<=0) ===")
def block_point(n, sizes, rng):
    k=len(sizes); lab=[]
    for b,s in enumerate(sizes): lab+=[b]*s
    lab=np.array(lab)
    # choose inter-block constants <= 0 at random, then solve for within-block constants
    C=np.zeros((k,k))
    for A in range(k):
        for B in range(A+1,k):
            C[A,B]=C[B,A]=-abs(rng.integers(1,4))
    M=np.zeros((n,n)); cin=np.zeros(k)
    for A in range(k):
        if sizes[A]==1: continue
        s=sum(sizes[B]*C[A,B] for B in range(k) if B!=A)
        cin[A] = -s/(sizes[A]-1)
    ok=True
    for A in range(k):
        if sizes[A]==1:
            if abs(sum(sizes[B]*C[A,B] for B in range(k) if B!=A))>1e-12: ok=False
    for i in range(n):
        for j in range(i+1,n):
            M[i,j]=M[j,i]= cin[lab[i]] if lab[i]==lab[j] else C[lab[i],lab[j]]
    return M, ok

for n,sizes in [(6,[3,3]),(6,[2,2,2]),(6,[4,2]),(8,[4,4]),(8,[3,3,2]),(9,[3,3,3]),(8,[5,3]),(7,[4,3])]:
    M,ok=block_point(n,sizes,rng)
    rs=np.abs(M@np.ones(n)).max()
    D,tot_,S,_,_=defect_diag(n,M)
    print(f"  n={n} sizes={sizes} rowsum_res={rs:.1e} Delta={D:.3e} structure_ok={structure_ok(M,n)} "
          f"withinblock_positive={all(M[i,j]>0 for i in range(n) for j in range(i+1,n) if 0)or''}")

print("\n=== controls: catalogued diagonal points, my Delta vs the record's ===")
rows=[]
for blocks in ([6,6],[5,7],[4,8],[3,3],[2,4]):
    W,lab=sphere_product_W(blocks); n=sum(blocks)
    M0=np.zeros((n,n))
    for a,(i,j) in enumerate(pairs_of(n)): M0[i,j]=M0[j,i]=W[a,a]
    D,tt,S,_,_=defect_diag(n,M0)
    th,isw,d,Drec,totrec,Smmm,Smpp,z=record_defect(n,W)
    M=np.zeros((n,n))
    for a,(i,j) in enumerate(pairs_of(n)): M[i,j]=M[j,i]=W[a,a]
    print(f"  S^{blocks[0]}xS^{blocks[1]} n={n}: mine Delta={D:.3e} S={S:.1f}  rec Delta={Drec:.3e} S={Smmm:.1f}"
          f"  theta={th:.6f} weyl={isw} struct={structure_ok(M,n)} tri(G-)={tri_count(M<0)}")
Wc,labc=c5_operator([2]*5); n=10
Mc=np.zeros((n,n))
for a,(i,j) in enumerate(pairs_of(n)): Mc[i,j]=Mc[j,i]=Wc[a,a]
D,tt,S,_,_=defect_diag(n,Mc)
th,isw,d,Drec,tr,Smmm,Smpp,z=record_defect(n,Wc)
print(f"  C5 blow-up n=10: mine Delta={D:.6f} rec={Drec:.6f}  S mine={S:.1f} rec={Smmm:.1f} 6*tri(G-)={6*tri_count(Mc<0)}"
      f"  theta={th:.6f} struct={structure_ok(Mc,n)} diagonal={np.abs(Wc-np.diag(np.diag(Wc))).max():.1e}")
