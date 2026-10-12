# Positive control: S^5 x S^7 (Einstein, n=12) is a genuine three-value critical point at theta^2 = 264/175.
# Its class data, computed exactly from coordinate bivectors, must satisfy every constraint of the class system.
import sys, itertools, numpy as np, sympy as sp
sys.argv=['x']
src=open('scripts/misc/verify_I73c_offray_witness.py').read().split("n = 12\nm = ")[0]
exec(src)
n=12; R_=sp.Rational
pairs=[(i,j) for i in range(n) for j in range(i+1,n)]
cls_of=lambda i,j: 0 if (i<5)!=(j<5) else (1 if i>=5 else 2)      # 0 mixed (35), 1 Lambda^2 R^7 (21), 2 Lambda^2 R^5 (10)
lam={0:R_(-1,11),1:R_(5,66),2:R_(7,44)}
m=[0,0,0]
for (i,j) in pairs: m[cls_of(i,j)]+=1
print('multiplicities',m)
N2=sum(m[a]*lam[a]**2 for a in range(3)); th2=R_(264,175)
# e = lambda / (|lambda| theta): e_a^2 = lam_a^2 / (N2 th2)
scale=sp.sqrt(N2*th2)
eps=[lam[a]/scale for a in range(3)]
print('sum m e^2 =', sp.nsimplify(sum(m[a]*eps[a]**2 for a in range(3))), ' 1/theta^2 =', 1/th2)
# structure constants of coordinate bivectors: [E_ij, E_kl] nonzero iff they share exactly one index, norm^2 1
E={}
tau=np.zeros((3,3,3))
for p in pairs:
    for q in pairs:
        s=set(p)&set(q)
        if len(s)==1:
            r=tuple(sorted(set(p)^set(q)))
            tau[cls_of(*p),cls_of(*q),cls_of(*r)]+=1
A=[np.zeros((n,n)) for _ in range(3)]
for (i,j) in pairs:
    A[cls_of(i,j)][i,i]+=1; A[cls_of(i,j)][j,j]+=1
G=np.array([[np.trace(A[a]@A[b]) for b in range(3)] for a in range(3)])
print('tau', {(a,b,c):int(tau[a,b,c]) for a in range(3) for b in range(a,3) for c in range(b,3)}); print('G',G.tolist())
# evaluate the full constraint list at this point, with the section 5 cap at this theta and T7 = L240's
Th12=sp.sqrt(220)/12; mu=12*Th12/(11*sp.sqrt(th2))
X, ineq, names, rows, nt = exprs(n, m, [sp.nsimplify(e) for e in eps], R_(54064,1000), mu)
sub={}
for v in X[:-1]:
    a,b,c=[int(ch) for ch in str(v)[1:]]; sub[v]=int(tau[a,b,c])
sub[X[-1]]=int(G[0,1])
print('rows', [float(r.subs(sub)) for r in rows])
vals=[float(e.subs(sub)) for e in ineq]
bad=[(nm,v) for nm,v in zip(names,vals) if v>1e-9]
print('violated', len(bad), 'of', len(vals)); print(bad[:10])
