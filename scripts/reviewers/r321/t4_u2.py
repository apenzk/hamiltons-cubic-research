import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r321')
from core import *
np.set_printoptions(suppress=True, linewidth=150)

def analyse(name, W, AD, C, n, tol=1e-9, vchoice=None, verbose=True):
    Nl = W.shape[0]
    lam, Phi = np.linalg.eigh(W)
    mi = np.where(lam < -tol)[0]; pi = np.where(lam > tol)[0]; ki = np.where(abs(lam) <= tol)[0]
    Ce = np.einsum('abc,aA,bB,cC->ABC', C, Phi, Phi, Phi, optimize=True)
    # S invariants (basis independent)
    Smmm = float((Ce[np.ix_(mi,mi,mi)]**2).sum())
    Smpp = float((Ce[np.ix_(mi,pi,pi)]**2).sum())
    th = P_func(W, AD)
    # choose v in the lam_min eigenspace
    E = np.where(abs(lam-lam[0]) < 1e-8)[0]
    if vchoice is None:
        vc = np.zeros(len(E)); vc[0]=1.0
    else:
        vc = vchoice
    vvec = Phi[:, E] @ (vc/np.linalg.norm(vc))
    # c_{vab} = <[v,phi_a],phi_b> in the eigenbasis
    cv = np.einsum('a,abc->bc', Phi[:,E]@ (vc/np.linalg.norm(vc)) @ np.eye(1) if False else np.zeros(0), Ce) if False else None
    # coefficients of v in the eigenbasis:
    vcoef = Phi.T @ vvec
    cv = np.einsum('a,abc->bc', vcoef, Ce)          # cv[a,b] = <[v,phi_a],phi_b>
    L = np.outer(lam, lam)
    Bmm = float((L*cv**2)[np.ix_(mi,mi)].sum())
    Bmp = float((L*cv**2)[np.ix_(mi,pi)].sum())
    Bpp = float((L*cv**2)[np.ix_(pi,pi)].sum())
    Amm = float((cv**2)[np.ix_(mi,mi)].sum()); App = float((cv**2)[np.ix_(pi,pi)].sum())
    Amp = float((cv**2)[np.ix_(mi,pi)].sum())
    lhs = float(vvec @ sharp(W,AD) @ vvec)
    tot = 0.5*Bmm + Bmp + 0.5*Bpp
    if verbose:
        print(f"--- {name}: n={n} theta={th:.9f} critres={np.linalg.norm(Q(W,AD)-th*W):.1e}"
              f" dim(m,p,ker)=({len(mi)},{len(pi)},{len(ki)}) mult(lam_min)={len(E)}")
        print(f"    S_mmm={Smmm:.6e}  S_mpp={Smpp:.6f}")
        print(f"    blocks: (1/2)mm={0.5*Bmm:+.6f}  mp={Bmp:+.6f}  (1/2)pp={0.5*Bpp:+.6f}"
              f"  sum={tot:+.9f}  <v,W#v>={lhs:+.9f}  diff={abs(tot-lhs):.1e}")
        print(f"    raw masses: mm={Amm:.6f} 2*mp={2*Amp:.6f} pp={App:.6f} total={Amm+2*Amp+App:.6f} (2(n-2)={2*(n-2)})")
    return dict(lam=lam,Phi=Phi,Ce=Ce,mi=mi,pi=pi,ki=ki,E=E,Smmm=Smmm,Smpp=Smpp,th=th,
                Bmm=Bmm,Bmp=Bmp,Bpp=Bpp,Amm=Amm,App=App)

def block_forms(d):
    """quadratic forms v -> Bmm(v), Bpp(v) on the lam_min eigenspace, as matrices."""
    lam,Ce,mi,pi,E = d['lam'],d['Ce'],d['mi'],d['pi'],d['E']
    L = np.outer(lam,lam)
    # Bmm(v) = sum_{a,b in m} lam_a lam_b (sum_c v_c Ce[c,a,b])^2 ; v expressed in eigenbasis coords
    Cm = Ce[:, np.ix_(mi,mi)[0][:,None], np.ix_(mi,mi)[1][None,:]] if False else Ce[np.ix_(range(len(lam)),mi,mi)]
    Cp = Ce[np.ix_(range(len(lam)),pi,pi)]
    Wm = L[np.ix_(mi,mi)]; Wp = L[np.ix_(pi,pi)]
    Kmm = np.einsum('cab,dab,ab->cd', Cm, Cm, Wm, optimize=True)
    Kpp = np.einsum('cab,dab,ab->cd', Cp, Cp, Wp, optimize=True)
    return Kmm[np.ix_(E,E)], Kpp[np.ix_(E,E)]

pts = []
for (n,p) in [(6,3),(8,4),(8,3),(10,5)]:
    WB,_=weyl_basis(n); C,_=struct(n); AD=ad_mats(C)
    pts.append((f"S^{p}xS^{n-p}", sphere_product(n,p,WB), AD, C, n))
n=6; WB,_=weyl_basis(6); C,_=struct(6); AD=ad_mats(C)
pts.append(("CP^3", cpm_weyl(3,WB), AD, C, 6))
n=8; WB8,_=weyl_basis(8); C8,_=struct(8); AD8=ad_mats(C8)
pts.append(("CP^4", cpm_weyl(4,WB8), AD8, C8, 8))
Wwit = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
pts.append(("n=8 witness", Wwit, AD8, C8, 8))
n=10; C10,_=struct(10); AD10=ad_mats(C10)
Wc5 = np.load('/tmp/r321_c5.npy')
pts.append(("C5 blow-up", Wc5, AD10, C10, 10))
rng=np.random.default_rng(11)
g,_ = np.linalg.qr(rng.standard_normal((10,10)));
if np.linalg.det(g)<0: g[:,0]*=-1
# Lambda^2(g) in the E_ij basis
Bso,Pso = so_basis(10)
Lg = np.array([[ -0.5*np.trace((g@Bso[a]@g.T)@Bso[b]) for a in range(45)] for b in range(45)])
print("Lambda^2(g) orthogonal:", np.abs(Lg@Lg.T-np.eye(45)).max())
pts.append(("C5 conj SO(10)", Lg@Wc5@Lg.T, AD10, C10, 10))

res={}
for (nm,W,AD,C,n) in pts:
    res[nm]=analyse(nm,W,AD,C,n)
    res[nm]['AD']=AD; res[nm]['C']=C; res[nm]['n']=n; res[nm]['W']=W
np.save('/tmp/r321_done.npy', np.array([1]))
import pickle; pickle.dump({k:{kk:vv for kk,vv in v.items() if kk not in('AD','C')} for k,v in res.items()}, open('/tmp/r321_res.pkl','wb'))

print("\n=== dependence of the blocks on the choice of v inside the lam_min eigenspace ===")
for nm in res:
    d=res[nm]
    if len(d['E'])<2: print(f"{nm}: lam_min simple"); continue
    Kmm,Kpp = block_forms(d)
    emm=np.linalg.eigvalsh(Kmm); epp=np.linalg.eigvalsh(Kpp)
    print(f"{nm}: mult={len(d['E'])}  Bmm(v) range over unit v in E: [{emm[0]:.6f},{emm[-1]:.6f}]"
          f"   Bpp(v) range: [{epp[0]:.6f},{epp[-1]:.6f}]   (S_mmm={d['Smmm']:.3e}, S_mpp={d['Smpp']:.4f})")
