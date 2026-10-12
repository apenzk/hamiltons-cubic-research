"""(reviews/2026-09-28d-I121-smallmass-direct.md; run: sage -python scripts/misc/derive_I121_pair_terms_symbolic.py) Exact E-trilinear of the pair couplings by symbolic index sums: E3 = (mixed I3 - mixed trW3)/12,
I3 = sum R_ijkl R_ipkq R_jplq, trW3 = sum over bivectors (1/8 sum R_abcd R_cdef R_efab), with R built from pair and four-set blocks."""
import sympy as sp, itertools
n=7
def blank(): return {}
def put(R,a,b,c,d,v):
    # set R_abcd = v with the curvature symmetries
    for (p,q,r,s,sg) in [(a,b,c,d,1),(b,a,c,d,-1),(a,b,d,c,-1),(b,a,d,c,1),(c,d,a,b,1),(d,c,a,b,-1),(c,d,b,a,-1),(d,c,b,a,1)]:
        R[(p,q,r,s)]=R.get((p,q,r,s),0)+sg*v
def pairblock(j,k,xs):
    R={}
    for a,v in xs.items(): put(R,j,a,k,a,v)
    return R
def fourset(Q,J,X):
    i,j,k,l=Q; R={}; A2=X+J/2; A3=X-J/2; A1=A2-A3
    put(R,i,j,k,l,A1); put(R,i,k,j,l,A2); put(R,i,l,j,k,A3); return R
def get(R,t): return R.get(t,0)
def I3(Rs):
    # mixed part over assignments of the three blocks to the three factors
    tot=0
    for R1,R2,R3 in itertools.permutations(Rs):
        for (i,j,k,l),v1 in R1.items():
            for p in range(n):
                for q in range(n):
                    v2=get(R2,(i,p,k,q))
                    if v2==0: continue
                    v3=get(R3,(j,p,l,q))
                    if v3!=0: tot+=v1*v2*v3
    return sp.expand(tot)
def trW3(Rs):
    tot=0
    for R1,R2,R3 in itertools.permutations(Rs):
        for (a,b,c,d),v1 in R1.items():
            for e in range(n):
                for f in range(n):
                    v2=get(R2,(c,d,e,f))
                    if v2==0: continue
                    v3=get(R3,(e,f,a,b))
                    if v3!=0: tot+=v1*v2*v3
    return sp.expand(sp.Rational(1,8)*tot)
def E3(Rs): return sp.expand((I3(Rs)-trW3(Rs))/12)
# T2: pair triangle 01, 12, 02
x=sp.symbols('x2:7'); y=sp.symbols('y0 y3:7'); z=sp.symbols('z1 z3:7')
X={2+i:x[i] for i in range(5)}; Y={0:y[0],**{3+i:y[1+i] for i in range(4)}}; Z={1:z[0],**{3+i:z[1+i] for i in range(4)}}
print("T2:",sp.factor_terms(E3([pairblock(0,1,X),pairblock(1,2,Y),pairblock(0,2,Z)])))
# T3: x in V_01 (support 2..6), y in V_23 (support 0,1,4,5,6), fourset {0,1,2,3} with (J,X) at (01|23)
xs=sp.symbols('u2 u3 u4 u5 u6'); ys=sp.symbols('v0 v1 v4 v5 v6'); J,Xs=sp.symbols('J X')
Xd={2:xs[0],3:xs[1],4:xs[2],5:xs[3],6:xs[4]}; Yd={0:ys[0],1:ys[1],4:ys[2],5:ys[3],6:ys[4]}
print("T3:",sp.factor_terms(E3([pairblock(0,1,Xd),pairblock(2,3,Yd),fourset((0,1,2,3),J,Xs)])))
# T4: x in V_01 (support 2..6), foursets {0,2,3,4} at (02|34) and {1,2,3,4} at (12|34)
J1,X1,J2,X2=sp.symbols('J1 X1 J2 X2')
print("T4:",sp.factor_terms(E3([pairblock(0,1,Xd),fourset((0,2,3,4),J1,X1),fourset((1,2,3,4),J2,X2)])))
