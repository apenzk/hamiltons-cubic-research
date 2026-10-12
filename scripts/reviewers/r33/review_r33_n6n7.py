import sys, itertools, numpy as np, sympy as sp
sys.path.insert(0, 'scripts/lib')
import review_r33_core as R

print("=== N6: symbolic theta_raw for W_{p,q} via the diagonal Q-formula ===")
p, q = sp.symbols('p q', positive=True, integer=True)
n = p + q
a = 1/(p*(p-1)); b = 1/(q*(q-1)); c = -1/(p*q)
# Q(W)_{ij,ij} = w_ij^2 + sum_{k != i,j} w_ik w_jk
QPP = sp.simplify(a**2 + (p-2)*a*a + q*c*c)
QQQ = sp.simplify(b**2 + (q-2)*b*b + p*c*c)
QPQ = sp.simplify(c**2 + (p-1)*a*c + (q-1)*c*b)
th = sp.simplify((n-1)/(p*q))
print("  Q_PP/a   =", sp.simplify(QPP/a), " target", th, " ->", sp.simplify(QPP/a - th) == 0)
print("  Q_QQ/b   =", sp.simplify(QQQ/b), " ->", sp.simplify(QQQ/b - th) == 0)
print("  Q_PQ/c   =", sp.simplify(QPQ/c), " ->", sp.simplify(QPQ/c - th) == 0)
print("  eps_PP =", sp.simplify(a/th), "target", sp.simplify(q/((p-1)*(n-1))), "->", sp.simplify(a/th - q/((p-1)*(n-1)))==0)
print("  eps_QQ =", sp.simplify(b/th), "->", sp.simplify(b/th - p/((q-1)*(n-1)))==0)
print("  eps_PQ =", sp.simplify(c/th), "->", sp.simplify(c/th + 1/(n-1))==0)

print("\n=== N6 numeric cross-check in the full so(n) machinery ===")
for (P_, Q_) in [(2,2),(2,3),(2,4),(3,3),(2,6),(3,5),(4,4),(3,7),(4,6),(5,5)]:
    nn = P_+Q_
    if nn < 4: continue
    A = R.A_tensor(nn); W = R.W_pq(P_,Q_); QW = R.Q_of(A, W)
    ratio = QW[0,0]/W[0,0]
    resid = np.max(np.abs(QW - ratio*W))
    tgt = (nn-1)/(P_*Q_)
    print(f"  (p,q)=({P_},{Q_}) theta_raw={ratio:.12f} target={tgt:.12f} resid={resid:.2e}")

print("\n=== N7: build X and inspect ===")
def build_X(P_, Q_):
    nn = P_+Q_; idx = R.pair_index(nn); D = nn*(nn-1)//2
    pi = (0,1); rho = (P_, P_+1)
    E = np.zeros((D,D))
    E[idx[pi], idx[rho]] = 1.0; E[idx[rho], idx[pi]] = 1.0
    B = R.weyl_basis(nn); Bf = B.reshape(B.shape[0],-1); Pi = Bf.T@Bf
    Xp = (Pi @ E.reshape(-1)).reshape(D,D)
    return E, Xp, idx, B

for (P_,Q_) in [(2,2),(3,3),(4,4),(2,5),(5,3)]:
    nn=P_+Q_
    E, X, idx, B = build_X(P_,Q_)
    nrm2 = np.sum(X*X)
    # support
    sup = [(k,l,X[k,l]) for k in range(X.shape[0]) for l in range(k, X.shape[0]) if abs(X[k,l])>1e-12]
    inv = {v:k for k,v in idx.items()}
    supstr = "; ".join(f"{inv[k]}|{inv[l]}:{v:+.4f}" for k,l,v in sup)
    # is it Weyl?  (projection is by construction; check E-X is pure Lambda^4 and X ricci flat)
    print(f"  (p,q)=({P_},{Q_}) n={nn}  ||X||^2={nrm2:.6f}  #support pairs={len(sup)}")
    print(f"      {supstr}")
