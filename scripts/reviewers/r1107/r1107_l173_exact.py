import sympy as sp
src=open('scripts/misc/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0]
src=src.replace("return I1, rows, list(tv.values()), g12", "return I1, rows, list(tv.values()), g12, S, p, q, E, G")
exec(src)
R=sp.Rational
for n,m in ((12,[4,59,3]),(8,[4,21,3])):
    eps=[R(-1,7),R(0),R(4,21)]
    I1,rows,tv,g12,S,p,q,E,G=build(n,m,eps)
    Nabc=lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
    t={(0,0,2):R(2,3),(2,2,2):R(2),(0,1,1):R(4,1711),(1,1,2):R(4,1711),(1,1,1):R(178,32509)}
    if n!=12:  # L173's closed form is at n=12; at n=8 solve rows for t333 etc. is not given: skip exact
        pass
    sub={}
    for x in tv:
        k=tuple(int(ch) for ch in str(x)[1:]); sub[x]=t.get(k,0)*Nabc(*k)
    if n==12:
        print("rows:",[sp.simplify(r.subs(sub)) for r in rows])
        caps=[sp.nsimplify(sum(sub[tv[[str(y) for y in tv].index('t%d%d%d'%tuple(sorted((a,b,c))))]] for c in range(3))/(m[a]*(m[b]-(a==b)))) for a in range(3) for b in range(3) if a<=b]
        print("caps (<=2):",caps)
        tau_ab=lambda a,b: sum(sub[tv[[str(y) for y in tv].index('t%d%d%d'%tuple(sorted((a,b,c))))]] for c in range(3))
        cons=[]
        for a in range(3):
            for b in range(3):
                if a<b: cons+=[G[a,b]-tau_ab(a,b)/2, m[a]*m[b]-G[a,b], G[a,b], sp.expand(G[a,a]*G[b,b]-G[a,b]**2)]
            cons.append(G[a,a]-R(4*m[a]**2,n))
        sols=sp.reduce_inequalities([c>=0 for c in cons],[g12])
        print("G12 feasible set:",sols)
        Gam=R(n+4,12)*((n-1)*E(3)-(n-3)*E(2))
        I1v=sp.expand(I1.subs(sub)); print("I1 =",I1v," window [",Gam/p,",0]")
n=12; m=[4,59,3]; eps=[R(-1,7),R(0),R(4,21)]
I1,rows,tv,g12,S,p,q,E,G=build(n,m,eps)
names=[str(y) for y in tv]
Nabc=lambda a,b,c: m[a]*(m[b]-(a==b))*(m[c]-(a==c)-(b==c))
t={(0,0,2):R(2,3),(2,2,2):R(2),(0,1,1):R(4,1711),(1,1,2):R(4,1711),(1,1,1):R(178,32509)}
sub={x:t.get(tuple(int(ch) for ch in str(x)[1:]),0)*Nabc(*tuple(int(ch) for ch in str(x)[1:])) for x in tv}; sub[g12]=60
tau=lambda a,b,c: sub[tv[names.index('t%d%d%d'%tuple(sorted((a,b,c))))]]
th=sp.sqrt(21)/2; mu=n*sp.sqrt(220)/12/((n-1)*th); emax=eps[2]
print("G at G12=60:",G.subs(g12,60).tolist())
for a,b in ((0,1),(0,2),(1,2)):
    tab=sum(tau(a,b,c) for c in range(3)); Gab=G[a,b].subs(g12,60)
    lhs=R(1,4)*m[a]*m[b]*(eps[a]+eps[b]-1)-R(1,4)*sum(eps[c]*tau(a,b,c) for c in range(3))
    rhs=(mu-1)/(2*(n-2))*(Gab-tab/2)+(3*emax-R(1,2))*(m[a]*m[b]-Gab)/6
    print((a,b),"sec5 lhs",float(lhs),"rhs",float(rhs),"holds" if lhs<=rhs else "VIOLATED")
