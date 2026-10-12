"""Cross-cutting checks: Delta vs equivariance on graded points, and whether the witness's
positive eigenspace closes under bracket."""
import sys, numpy as np, itertools
sys.path.insert(0,'scripts/reviewers/r313')
import r313_lib as R
from r313_m3 import gauss_newton, defect
from r313_grading import lam2_of
from r313_m4 import blocks, Sblocks
import r313_m56 as M
from r313_m1b import ad_matrix, gens_so_kl

def equivariance_defect(n, W, gens):
    tot=0.0
    for X in gens:
        a=ad_matrix(n,X)
        tot += np.linalg.norm(a@W - W@a)**2 / max(np.linalg.norm(X)**2,1e-30)
    return tot

# --- Delta = 0 vs equivariant, on padded W_CP2 and on HP^2 / S^3xS^5
print("=== Delta and equivariance at graded points ===")
def padded_cp2(nn):
    P4=R.pairs(4); D4=R.pidx(4)
    def bv(ps):
        v=np.zeros(len(P4))
        for (i,j),sg in ps:
            a,sa=D4[(i,j)]; v[a]+=sg*sa
        return v/np.linalg.norm(v)
    u1=bv([((0,1),1),((2,3),1)]); u2=bv([((0,2),1),((3,1),1)]); u3=bv([((0,3),1),((1,2),1)])
    W4=(1/np.sqrt(6))*(2*np.outer(u1,u1)-np.outer(u2,u2)-np.outer(u3,u3))
    Pn=R.pairs(nn); Wp=np.zeros((len(Pn),len(Pn)))
    for a,(i,j) in enumerate(P4):
        for b,(k,l) in enumerate(P4): Wp[Pn.index((i,j)),Pn.index((k,l))]=W4[a,b]
    return Wp

for nn in (8,12):
    Wp=padded_cp2(nn)
    D,tot,ev,V,gs=defect(nn,Wp)
    eq=equivariance_defect(nn,Wp,gens_so_kl(nn,4))
    lam,evec,evs,Cp,Lm=R.lam_max_perp(nn,Wp,R.theta_of(nn,Wp))
    print(f"  padded W_CP2 n={nn}: theta={R.theta_of(nn,Wp):.9f} Delta={D:.9e} sum g={tot:.6f}"
          f"  ad(so(4)+so(n-4))-equivariance defect={eq:.6f}  lambda_max(L_e|W-perp)={lam:.9f}")

n=8
S35=M.sphere_W(8,3)
D,tot,ev,V,gs=defect(n,S35)
print(f"  S^3xS^5 n=8: Delta={D:.3e}  equivariance defect (so(3)+so(5))={equivariance_defect(8,S35,gens_so_kl(8,3)):.3e}")

# --- HP^2 = triality image; build it as the unique so(3)+so(5)-invariant?  Instead:
# --- the witness's positive eigenspace: does it close under bracket?
def load(f):
    W=np.load(f"scripts/reviewers/r305/out/{f}.npy")
    W=gauss_newton(8,W); return W if R.theta_of(8,W)>0 else -W
Wt=load("r305_n8_seed9015")
H,Mm,ev=blocks(8,Wt)
sb=Sblocks(8,H,Mm)
print("\n=== the n=8 witness: spectral splitting ===")
print(f"  dim h(lambda>=0) = {H.shape[1]}, dim m = {Mm.shape[1]}; block masses {dict((k,round(v,9)) for k,v in sb.items())}")
print(f"  identity check S_mmm+3S_hmm+3S_hhm+S_hhh = {sb['mmm']+3*sb['hmm']+3*sb['hhm']+sb['hhh']:.6f}  vs 2*N*(n-2) = {2*28*6}")
# is p (from the dim-3 gradings) equal to E_+ ?
from r313_m56b import all_dim3_frames
P=R.pairs(8)
idxp=[t for t,(i,j) in enumerate(P) if (i<3 and j<3) or (i>=3 and j>=3)]
Ph = H@H.T
for k,(evv,Rot) in enumerate(all_dim3_frames(Wt)):
    L=lam2_of(8,Rot); Wr=L.T@Wt@L
    Pi=np.zeros((28,28))
    for t in idxp: Pi[t,t]=1.0
    Pi = L@Pi@L.T   # p-projector back in the original frame
    print(f"  grading #{k}: ||Pi_p - Pi_E+|| = {np.linalg.norm(Pi-Ph):.6f}   tr Pi_p = {np.trace(Pi):.3f} tr Pi_E+ = {np.trace(Ph):.3f}"
          f"   ||W|_p||^2 = {np.trace(Pi@Wt@Pi@Wt):.6f}")
print(f"  spectral split sum_{{lambda>0}} lambda^2 = {sum(l*l for l in ev if l>0):.6f}")
