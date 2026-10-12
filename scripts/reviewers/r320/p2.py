import sys; sys.path.insert(0,'scripts/reviewers/r320')
import numpy as np, lib320 as L, cat320 as C

def row(name,W,n):
    N=L.struct(n).shape[0]
    q=L.Q(W,n); th=L.frob(W,q); res=np.linalg.norm(q-th*W)
    if th<0: W=-W; th=-th; q=L.Q(W,n)
    ev=np.linalg.eigvalsh(W); tol=1e-9
    rp=int((ev>tol).sum()); rm=int((ev<-tol).sum()); k=len(ev)-rp-rm
    s=rp+rm
    b_r  = (2/n)*np.sqrt(rp*N/(N-rp)) if rp<N else np.inf
    b_rk = (2/n)*np.sqrt(rp*s/(s-rp)) if rp<s else np.inf
    b_lm = (n-1)*abs(ev.min())
    b_dual=(2/n)*np.sqrt((N-rm)*N/rm) if rm>0 else np.inf
    return (name,n,th,rp,rm,k,b_r,th<=b_r+1e-9,b_rk,th<=b_rk+1e-9,b_lm,th<=b_lm+1e-9,b_dual,th<=b_dual+1e-9,res)

rows=[]
for (p,q) in [(2,2),(3,3),(2,4),(2,6),(3,5),(4,4),(5,7),(4,8),(6,6),(3,7),(5,5)]:
    rows.append(row(f"S^{p}xS^{q}",C.sphere_product(p,q),p+q))
for (p,q,n) in [(2,2,6),(2,2,8),(3,3,8),(3,3,10),(4,4,12)]:
    rows.append(row(f"S^{p}xS^{q} pad{n}",C.sphere_product(p,q,n),n))
for n in [4,8,10,12]: rows.append(row(f"CP^2 pad{n}",C.cp2(n),n))
for m in [3,4,5]: rows.append(row(f"CP^{m}",C.cpm(m),2*m))
for (n,blocks) in [(6,[3,3]),(8,[4,4]),(10,[5,5]),(12,[6,6]),(9,[3,3,3]),(12,[4,4,4]),(6,[2,2,2])]:
    W,r=C.casimir(C.so_block_subalg(blocks,n),n)
    rows.append(row("Cas "+"+".join(f"so({b})" for b in blocks),W,n))

hdr=f"{'point':22}{'n':>3}{'theta':>10}{'r+':>4}{'r-':>4}{'ker':>4}| {'b_r':>9}{'ok':>3} {'b_rank':>9}{'ok':>3} {'(n-1)|lmin|':>12}{'ok':>3} {'b_dual':>9}{'ok':>3}"
print(hdr); print("-"*len(hdr))
for r in rows:
    print(f"{r[0]:22}{r[1]:>3}{r[2]:>10.6f}{r[3]:>4}{r[4]:>4}{r[5]:>4}| {r[6]:>9.6f}{'Y' if r[7] else 'NO':>3} {r[8]:>9.6f}{'Y' if r[9] else 'NO':>3} {r[10]:>12.6f}{'Y' if r[11] else 'NO':>3} {r[12]:>9.6f}{'Y' if r[13] else 'NO':>3}")
print()
print("saturation of (n-1)|lmin|  (theta/bound):")
for r in rows:
    print(f"  {r[0]:22}n={r[1]:<3} theta/((n-1)|lmin|) = {r[2]/r[10]:.9f}")
