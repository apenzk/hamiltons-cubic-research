# r178: dim of the SO(5)-span of the cubic Veronese image of the padded W_{CP^2}.
# Upper bound from theory = sum of dim V_lam over the 16 blocks with lam_2 even = 3570.
# rank over F_p is a LOWER bound for the char-0 span, so rank = 3570 proves every one
# of the 16 evaluation maps ev_lam is nonzero, i.e. every even block really loses one
# multiplicity.  (Gram/kernel trick: <x^3, y^3> = <x,y>^3.)
import itertools, time
p = 46337
F = GF(p)
pairs = [(i,j) for i in range(5) for j in range(i+1,5)]
pidx = {q:k for k,q in enumerate(pairs)}
def wedge2(g):
    M = matrix(F,10,10)
    for a,(i,j) in enumerate(pairs):
        for b,(k,l) in enumerate(pairs):
            M[a,b] = g[i,k]*g[j,l] - g[i,l]*g[j,k]
    return M
def vec(*terms):
    v = vector(F,10)
    for (i,j),c in terms: v[pidx[(i,j)]] += F(c)
    return v
w1 = vec(((0,1),1), ((2,3),1))
w2 = vec(((0,2),1), ((1,3),-1))
w3 = vec(((0,3),1), ((1,2),1))
W0 = 2*matrix(w1).transpose()*matrix(w1) - matrix(w2).transpose()*matrix(w2) - matrix(w3).transpose()*matrix(w3)
print("W0 symmetric:", W0 == W0.transpose(), " trace:", W0.trace())
print("W0 eigen-check: W0*w1 =", (W0*w1)[pidx[(0,1)]], "* w1 ; W0*w2 =", (W0*w2)[pidx[(0,2)]], "* w2")
set_random_seed(178)
N = 3700
rows = []
t0=time.time()
while len(rows) < N:
    A = matrix(F,5,5)
    for i in range(5):
        for j in range(i+1,5):
            a = F.random_element(); A[i,j]=a; A[j,i]=-a
    B = identity_matrix(F,5)+A
    if B.determinant()==0: continue
    g = (identity_matrix(F,5)-A)*B.inverse()
    if g*g.transpose() != identity_matrix(F,5): continue
    L = wedge2(g)
    Wg = L*W0*L.transpose()
    rows.append([Wg[i,j] for i in range(10) for j in range(10)])
M = matrix(F, rows)
print("orbit points:", M.nrows(), " time", time.time()-t0)
t0=time.time()
K = M*M.transpose()
K = matrix(F, N, N, [x^3 for x in K.list()])
r = K.rank()
print("rank of Gram(<W_a,W_b>^3) =", r, "   theoretical cap = 3570   time", time.time()-t0)
