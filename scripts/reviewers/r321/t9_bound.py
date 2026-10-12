import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r321')
from core import *
from t5_hunt_lib import find_crit
np.set_printoptions(suppress=True,linewidth=180)

def row(name,W,AD,C,n,tol=1e-9):
    lam,Phi=np.linalg.eigh(W)
    mi=np.where(lam<-tol)[0]; pi=np.where(lam>tol)[0]
    Ce=np.einsum('abc,aA,bB,cC->ABC',C,Phi,Phi,Phi,optimize=True)
    Smmm=float((Ce[np.ix_(mi,mi,mi)]**2).sum())
    th=P_func(W,AD); th0=np.sqrt(2*(n-1)*(n-2))/n
    B=lam[0]+(n-2)*lam[-1]
    E=np.where(abs(lam-lam[0])<1e-8)[0]; v=Phi[:,E[0]]
    cv=np.einsum('a,abc->bc',Phi.T@v,Ce); L=np.outer(lam,lam)
    Bmp=float((L*cv**2)[np.ix_(mi,pi)].sum()); Bpp=float((L*cv**2)[np.ix_(pi,pi)].sum())
    Bmm=float((L*cv**2)[np.ix_(mi,mi)].sum())
    Amp=float((cv**2)[np.ix_(mi,pi)].sum())
    print(f"{name:22s} n={n:2d} theta={th:9.6f}  bound lam_min+(n-2)lam_max={B:9.6f}  slack={B-th:9.6f}"
          f"  theta_0={th0:.6f}  S_mmm={Smmm:.2e}  mp-mass={Amp:.4f}/{n-2}  Bmm={Bmm:.3e} Bmp={Bmp:+.5f} Bpp={Bpp:+.5f}")
    return th,B,th0

pts=[]
for (n,p) in [(6,3),(8,4),(8,3),(10,5),(10,4)]:
    WB,_=weyl_basis(n); C,_=struct(n); AD=ad_mats(C)
    pts.append((f"S^{p}xS^{n-p}",sphere_product(n,p,WB),AD,C,n))
WB6,_=weyl_basis(6); C6,_=struct(6); AD6=ad_mats(C6)
pts.append(("CP^3",cpm_weyl(3,WB6),AD6,C6,6))
WB8,_=weyl_basis(8); C8,_=struct(8); AD8=ad_mats(C8)
pts.append(("CP^4",cpm_weyl(4,WB8),AD8,C8,8))
pts.append(("n=8 witness",np.load('scripts/data/w_n8_nondiagonal_witness.npy'),AD8,C8,8))
C10,_=struct(10); AD10=ad_mats(C10)
pts.append(("C5 blow-up",np.load('/tmp/r321_c5.npy'),AD10,C10,10))
for (nm,W,AD,C,n) in pts: row(nm,W,AD,C,n)

print("\n--- CP^3 spectrum vs S^3xS^3 spectrum (n=6) ---")
print(" S3xS3:", np.round(np.linalg.eigvalsh(sphere_product(6,3,WB6)),6))
print(" CP^3 :", np.round(np.linalg.eigvalsh(cpm_weyl(3,WB6)),6))

print("\n--- the bound lam_min + (n-2)lam_max >= theta on 300 random DIAGONAL critical points ---")
rng=np.random.default_rng(99)
bad=0; tot=0; worst=1e9; ratios=[]
for n in [6,7,8]:
    C,_=struct(n); AD=ad_mats(C)
    for M in find_crit(n,rng,100):
        W=diag_weyl(M,n); W=W/np.linalg.norm(W)
        lam=np.linalg.eigvalsh(W); th=P_func(W,AD)
        B=lam[0]+(n-2)*lam[-1]; tot+=1
        if B<th-1e-9: bad+=1
        worst=min(worst,B-th); ratios.append(B/max(th,1e-12))
print(f"  {tot} points, violations={bad}, min slack={worst:.3e}")

print("\n--- sign convention check: what a flipped sharp would give at S^3xS^3 ---")
W=sphere_product(6,3,WB6)
Qm = W@W - sharp(W,AD6)
thm = float(np.sum(W*Qm))
print(f"  with Q = W^2 - W#: P = {thm:.9f}, ||Q - P W|| = {np.linalg.norm(Qm-thm*W):.3e}  (criticality DESTROYED)")
