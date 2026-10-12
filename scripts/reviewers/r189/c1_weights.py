"""C1 (corrected): the P_i are torus weight vectors of exactly the stated weight,
verified end-to-end through the evaluation chain -- and the check fails if the
monomial coefficients are re-read with multinomial multiplicity factors."""
import sys, os, numpy as np, itertools
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,d); sys.path.insert(0,os.path.join(d,"..","r179"))
import core, weyl_invariants as WI
p=core.P

def gpow(z,k):
    out=(1,0)
    for _ in range(k): out=core.gmul(out,z)
    return out

def char_elt(zeta):
    """the Gaussian element c - i s of the rotation with eigenvalue zeta."""
    zi=pow(zeta,p-2,p); half=pow(2,p-2,p)
    c=(zeta+zi)*half%p; s=(-core.I_*(zeta-zi)*half)%p
    return (c,(-s)%p)

def run(Pfun,tag):
    tot=ok=0
    for (plane,comp) in (((0,1),0),((2,3),1)):
        for zeta in (5,7):
            g=core.plane_rot(zeta,*plane); z=char_elt(zeta)
            for seed in (7,11):
                W=WI.random_weyl(5,p,np.random.default_rng(seed))
                A=Pfun(W); B=Pfun(core.act(g,W))
                for idx,(lam,k) in enumerate(core.COV):
                    tot+=1
                    ok+= (B[idx]==core.gmul(gpow(z,lam[comp]),A[idx]))
    print(f"  {tag}: P_i(gW) = (c-is)^lambda_c P_i(W) holds in {ok}/{tot} cases")
    return ok==tot

run(core.allP,"as evaluated by run_n5_certificate.py")

# --- the same covariants, but with multinomial multiplicity factors applied ---
MULT=[]
for t in core.MONO:
    a,b,c=t
    MULT.append(1 if a==b==c else (3 if (a==b or b==c or a==c) else 6))
def allP_mult(W):
    om=core.omegas(W); out=[]
    for (lam,k) in core.COV:
        u=core.HW2[lam][k]
        u2={idx:( (v[0]*MULT[idx])%p, (v[1]*MULT[idx])%p ) for idx,v in u.items()}
        out.append(core.Pval(u2,om))
    return out
run(allP_mult,"with multinomial factors 1/3/6 applied")
