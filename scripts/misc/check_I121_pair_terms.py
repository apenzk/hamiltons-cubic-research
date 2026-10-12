"""The pair part of E = P - (3/2) tr W^3, read off basis and random evaluations with the record's Q at n = 7: the polarised E on a triangle of pair blocks, on two disjoint pair blocks with their four-set, and on a pair block with two four-sets sharing three indices. A check that fits a candidate (reviews/2026-09-28d-I121-smallmass-direct.md), not a derivation. Run from the repository root: sage -python scripts/misc/check_I121_pair_terms.py"""
import runpy, sys, itertools, numpy as np
sys.argv=['x','7']
g=runpy.run_path('scripts/misc/check_I121_rectangle_cubic.py')
Qb=g['Qb']; idx=g['idx']; N=g['N']; setent=g['setent']; n=g['n']
def E3(A,B,C):
    # polarised E = P - 3/2 tr W^3 on three operators (symmetric trilinear, P = <Q(W),W>, tr W^3)
    def T(X,Y,Z): return np.sum(Qb(X,Y)*Z)
    def tr(X,Y,Z): return (np.trace(X@Y@Z)+np.trace(X@Z@Y))/2
    return T(A,B,C)-1.5*tr(A,B,C)
def pairblock(j,k,x):
    # nu in V_jk: W(e_ja, e_ka) = x_a for a not in {j,k}
    W=np.zeros((N,N))
    for a,v in x.items():
        if v: setent(W,j,a,k,a,v)
    return W
def fourset(Q,A2,A3):
    i,j,k,l=Q; W=np.zeros((N,N)); A1=A2-A3
    setent(W,i,j,k,l,A1); setent(W,i,k,j,l,A2); setent(W,i,l,j,k,A3); return W
# (T2) triangle of pair blocks on {0,1,2}: V_01 (x at a), V_12, V_02, with x supported off the triangle, sum zero
others=[3,4,5,6]
def vec(a,b): return {a:1.0,b:-1.0}
print("T2: pair triangle 01,12,02 with unit dipoles x=(e_a - e_b)")
for (a1,b1),(a2,b2),(a3,b3) in [((3,4),(3,4),(3,4)),((3,4),(3,4),(5,6)),((3,4),(5,6),(3,4)),((3,5),(3,4),(3,6))]:
    v=E3(pairblock(0,1,vec(a1,b1)),pairblock(1,2,vec(a2,b2)),pairblock(0,2,vec(a3,b3)))
    print(f"   x01=e{a1}-e{b1}, x12=e{a2}-e{b2}, x02=e{a3}-e{b3}: E-trilinear = {v:.6f}")
# note: x for V_jk must be supported off {j,k}; the triangle index is allowed for the others
print("T2 with the third index: x01 at 2, x12 at 0, x02 at 1")
for combo in [((2,3),(0,3),(1,3)),((2,3),(0,4),(1,5))]:
    (a1,b1),(a2,b2),(a3,b3)=combo
    v=E3(pairblock(0,1,vec(a1,b1)),pairblock(1,2,vec(a2,b2)),pairblock(0,2,vec(a3,b3)))
    print(f"   x01=e{a1}-e{b1}, x12=e{a2}-e{b2}, x02=e{a3}-e{b3}: E-trilinear = {v:.6f}")
# (T3) pair blocks V_01, V_23 and the four-set {0,1,2,3}
print("T3: V_01, V_23 and fourset {0,1,2,3} (J,X relative to pairing (01|23))")
for (a1,b1),(a2,b2) in [((2,3),(0,1)),((2,4),(0,4)),((4,5),(4,5)),((2,4),(1,4))]:
    for (J,X) in [(1,0),(0,1)]:
        A2=X+J/2; A3=X-J/2
        v=E3(pairblock(0,1,vec(a1,b1)),pairblock(2,3,vec(a2,b2)),fourset((0,1,2,3),A2,A3))
        print(f"   x01=e{a1}-e{b1}, x23=e{a2}-e{b2}, (J,X)=({J},{X}): {v:.6f}")
# (T4) V_01 with foursets {0,2,3,4} and {1,2,3,4}
print("T4: V_01 with foursets {0,2,3,4},{1,2,3,4}")
for (a1,b1) in [((2,3)),((2,5)),((5,6))]:
    for c1 in [(1,0),(0,1)]:
        for c2 in [(1,0),(0,1)]:
            Q1=fourset((0,2,3,4),c1[1]+c1[0]/2,c1[1]-c1[0]/2); Q2=fourset((1,2,3,4),c2[1]+c2[0]/2,c2[1]-c2[0]/2)
            v=E3(pairblock(0,1,vec(a1,b1)),Q1,Q2)
            print(f"   x01=e{a1}-e{b1}, Q1(J,X)={c1}, Q2(J,X)={c2}: {v:.6f}")
rng=np.random.default_rng(4)
def randvec(excl):
    v={a:rng.standard_normal() for a in range(n) if a not in excl}; m=np.mean(list(v.values()))
    return {a:x-m for a,x in v.items()}
for trial in range(3):
    x=randvec((0,1)); y=randvec((1,2)); z=randvec((0,2))
    v=E3(pairblock(0,1,x),pairblock(1,2,y),pairblock(0,2,z))
    out=[a for a in range(3,n)]
    ip=lambda u,w: sum(u[a]*w[a] for a in out)
    pred=-0.5*x[2]*y[0]*z[1]-(x[2]*ip(y,z)+y[0]*ip(x,z)+z[1]*ip(x,y))-0.5*sum(x[a]*y[a]*z[a] for a in out)
    print(f"T2 random {trial}: E-trilinear {v:.6f}  candidate {pred:.6f}")
def fourJX(Q,J,X): return fourset(Q,X+J/2,X-J/2)
for trial in range(3):
    # T3: x in V_01, y in V_23, fourset {0,1,2,3} with (J,X) at pairing (01|23)
    x=randvec((0,1)); y=randvec((2,3)); J,X=rng.standard_normal(2)
    v=E3(pairblock(0,1,x),pairblock(2,3,y),fourJX((0,1,2,3),J,X))
    out=range(4,n); ip=sum(x[a]*y[a] for a in out)
    pred=2*ip*X-0.5*(x[2]+x[3])*(y[0]+y[1])*X-0.75*(x[2]-x[3])*(y[0]-y[1])*J
    print(f"T3 random {trial}: E-trilinear {v:.6f}  candidate {pred:.6f}")
for trial in range(3):
    # T4: x in V_01, foursets {0,2,3,4} at (02|34) and {1,2,3,4} at (12|34)
    x=randvec((0,1)); J1,X1,J2,X2=rng.standard_normal(4)
    v=E3(pairblock(0,1,x),fourJX((0,2,3,4),J1,X1),fourJX((1,2,3,4),J2,X2))
    pred=-2*x[2]*X1*X2-0.5*(x[3]+x[4])*X1*X2-9/8*(x[3]+x[4])*J1*J2+0.75*(x[3]-x[4])*(J1*X2+X1*J2)
    print(f"T4 random {trial}: E-trilinear {v:.6f}  candidate {pred:.6f}")
