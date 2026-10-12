"""Triple-check the across-block / C_5-edge subspace finding."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C
from fractions import Fraction
rng=np.random.default_rng(99)

W,n=C.c5_blowup(); W=W/np.linalg.norm(W)
th=float(np.tensordot(W,C.Q(n,W))); e=W/th
B=C.weyl_basis(n); D=len(B); M,_=C.Le_matrix(n,e)
w=C.to_coords(n,W); w/=np.linalg.norm(w)
lab=np.array(sum([[b]*2 for b in range(5)],[]))
def adjacent(i,j): return lab[i]!=lab[j] and (abs(int(lab[i])-int(lab[j]))%5 in (1,4))

def build(pred, extra_rot=False):
    S0=C.sym0_basis(n)
    As=[A for A in S0 if all(abs(A[i,j])<1e-12 for i in range(n) for j in range(n) if not pred(i,j))]
    if extra_rot:                      # random change of basis inside the A-space
        G=rng.standard_normal((len(As),len(As)))
        As=[sum(G[k,l]*As[l] for l in range(len(As))) for k in range(len(As))]
    HA=np.array([C.D_A(n,A)@W+W@C.D_A(n,A) for A in As])
    co=np.einsum('kij,mij->km',HA,B)-np.outer(np.einsum('kij,mij->km',HA,B)@w,w)
    Ub,_=C.orth_rows(co)
    return HA, Ub

for nm,pred in (("across blocks", lambda i,j: lab[i]!=lab[j]),
                ("C_5 EDGES only", adjacent)):
    for rot in (False,True):
        HA,Ub=build(pred,rot)
        Mv=Ub@M@Ub.T; Mv=0.5*(Mv+Mv.T); ev=np.linalg.eigvalsh(Mv)
        tr=float(np.trace(Mv))/len(Ub)
        # independent recomputation: Rayleigh quotients on the Weyl-space vectors themselves
        vecs=[np.einsum('k,kij->ij',u,B) for u in Ub]
        ray=[float(np.tensordot(v, C.circ(n,e,v)))/float(np.tensordot(v,v)) for v in vecs]
        # sanity: subspace inside Weyl and inside e-perp
        dW=max(np.linalg.norm(v-C.proj_weyl(n,v))/np.linalg.norm(v) for v in vecs)
        dE=max(abs(float(np.tensordot(v,W)))/np.linalg.norm(v) for v in vecs)
        # orbit overlap
        O=C.orbit_tangent(n,W); Oc=np.einsum('kij,mij->km',O,B); Uo,_=C.orth_rows(Oc)
        cs=np.linalg.svd(Ub@Uo.T,compute_uv=False)
        print(f"{nm:16s} rot={rot!s:5s} dim={len(Ub):3d} tr/dim={tr:.9f} (mean Rayleigh {np.mean(ray):.9f})"
              f" spec=[{ev[0]:.6f},{ev[-1]:.6f}] inWeyl={dW:.1e} perp_e={dE:.1e} max|cos to orbit|={cs.max():.3f}")
        if not rot:
            print(f"    Fraction(tr/dim) approx = {Fraction(tr).limit_denominator(500)};  eigenvalues rounded: {sorted(set(np.round(ev,9)))}")
print()
print(f"lambda_max(L_e|e-perp) full = {np.linalg.eigvalsh((np.eye(D)-np.outer(w,w))@M@(np.eye(D)-np.outer(w,w)))[-1]:.9f}")
print("chain: lambda_max >= tr(L_e|V_edge)/dim = 2/3 > 1/2  ==>  the C_5 blow-up is not a local maximum, by AVERAGING alone.")
