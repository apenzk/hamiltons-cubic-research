# I117, R48: the reflection-invariant subsystem of g2's torus idempotent system (x = w0, z = w1 = w4,
# u = w2 = w3, y = w5), solved exactly over the real algebraic numbers. Run: sage scripts/misc/solve_I117_g2_torus_reflection.sage (seconds)
R.<x,z,u,y> = PolynomialRing(QQ, order='degrevlex')
w=[x,z,u,u,z,y]
Mq = [[4,1,1,1,1,0],[1,4,1,0,1,1],[1,1,4/9,1/9,0,1/9],[1,0,1/9,4/9,1,1/9],[1,1,0,1,4,1],[0,1,1/9,1/9,1,4/9]]
X = [sum(w[a]^2*Mq[a][g] for a in range(6)) for g in range(6)]
f=4/3
RHS = [w[1]*w[4]+w[2]*w[3], w[0]*w[4]+w[2]*w[5], w[0]*w[3]+w[1]*w[5]+f*w[3]*w[5],
       w[0]*w[2]+w[4]*w[5]+f*w[2]*w[5], w[0]*w[1]+w[3]*w[5], w[1]*w[2]+w[3]*w[4]+f*w[2]*w[3]]
E=[w[g]*(1-X[g])-RHS[g] for g in range(6)]
assert E[1]==E[4] and E[2]==E[3], 'the reflection must fix the system'
I=R.ideal([E[0],E[1],E[2],E[5]])
print('dimension', I.dimension(), 'solutions', I.vector_space_dimension()); sys.stdout.flush()
V=I.variety(AA)
pos=[v for v in V if all(v[t]>0 for t in (x,z,u,y))]
print('real', len(V), 'positive', len(pos))
for v in pos:
    ww=[v[x],v[z],v[u],v[u],v[z],v[y]]
    print([RR(t) for t in (v[x],v[z],v[u],v[y])], 'minpoly deg of x:', v[x].minpoly().degree())
