# I73 (c), per-vector rows (reviews/2026-09-25-I73c-per-vector-rows.md): at a unit x in eigenspace E_c of a
# three-value critical W (unit norm, eigenvalues L, multiplicities m), b_ab(x) = <B_ab x, x> >= 0 satisfy
#   sum_ab b = n-2,  sum_ab b L_b = -L_c,  sum_ab b L_a L_b = L_c(theta - L_c),
# with source caps 2 sum_b b_ab <= kappa_{m_a - [a==c]}(x), kappa_r = sum of the top r eigenvalues of -ad_x^2.
# theta_max(x) is the largest theta that system allows. Screen only.
import sys, os, numpy as np
UNION = os.environ.get('UNION','0') == '1'
from scipy.optimize import linprog
def spec(s, n):
    s = np.asarray(s, float); s = s/np.linalg.norm(s); h = len(s); ev = []
    for i in range(h):
        for j in range(i+1, h): ev += [(s[i]+s[j])**2]*2 + [(s[i]-s[j])**2]*2
    if n % 2: ev += [si**2 for si in s for _ in range(2)]
    ev += [0.0]*(n*(n-1)//2 - len(ev))
    return np.sort(ev)[::-1]
def theta_max(s, n, L, m, c):
    ev = spec(s, n); kap = lambda r: ev[:max(r, 0)].sum()
    pairs = [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]
    def bvec(f):
        v = np.zeros(6)
        for x in range(3):
            for y in range(3): v[pairs.index((min(x,y),max(x,y)))] += f(x,y)
        return v
    Aeq = [bvec(lambda x,y:1), bvec(lambda x,y:L[y]), bvec(lambda x,y:L[x]*L[y])]
    # single-class caps, and the union caps 2(R_b + R_d) <= kappa_{m_b + m_d} (Ky Fan on the union of two eigenspaces)
    Aub = [bvec(lambda x,y:2*(x==a_)) for a_ in range(3)]
    bub = [kap(m[a_]-(a_==c)) for a_ in range(3)]
    if UNION:
        for b_,d_ in ((0,1),(0,2),(1,2)):
            Aub.append(bvec(lambda x,y:2*(x in (b_,d_)))); bub.append(kap(m[b_]+m[d_]-(c in (b_,d_))))
    # theta enters row C linearly: sum b L_a L_b - L_c theta = -L_c^2; maximise theta over (b, theta)
    Aeq2 = np.array([np.r_[Aeq[0],0], np.r_[Aeq[1],0], np.r_[Aeq[2],-L[c]]])
    Aub2 = np.array([np.r_[v,0] for v in Aub])
    r = linprog(np.r_[np.zeros(6),-1], A_ub=Aub2, b_ub=bub, A_eq=Aeq2, b_eq=[n-2, -L[c], -L[c]**2], bounds=[(0,None)]*6+[(None,None)], method='highs')
    return -r.fun if r.status == 0 else (np.inf if r.status == 3 else -np.inf)
if __name__ == '__main__':
    n = 12; p = 12; a = 1/np.sqrt(2*p); L = [-a, 0.0, a]; m = [p, n*(n-1)//2-2*p, p]
    for name, s in (('equal angles', [1]*6), ('decomposable', [1,0,0,0,0,0]), ('rank 4 equal', [1,1,0,0,0,0]),
                    ('rank 6 equal', [1,1,1,0,0,0]), ('rank 8 equal', [1,1,1,1,0,0]), ('rank 10 equal', [1,1,1,1,1,0]),
                    ('star (3,1,1,1)', [3,1,1,1,0,0]), ('geometric', [1,.8,.6,.4,.2,.1])):
        print(f'{name:16s} theta_max in E_0: {theta_max(s,n,L,m,0):.4f}   in E_2: {theta_max(s,n,L,m,2):.4f}')
    print('theta_0(12) =', np.sqrt(220)/12)
