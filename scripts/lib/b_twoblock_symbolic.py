"""Symbolic proof that the dangerous family eigenvalue is mu=(n-2)/(2(p-1)(q-1)).

The eigenvector X lives in Lambda^2(P) tensor Lambda^2(Q) and is supported on four
concrete indices, so

    <X, e o X> = sum_ab (eps(a)+eps(b))/2 X_ab^2  -  (1/2) sum_n eps(n) tr(A_n X A_n X),

and only planes n meeting those four contribute.  Each tr(A_n X A_n X) is a rational
number independent of p and q; all the p,q dependence sits in eps(n) and in the
multiplicities 1, p-2, q-2.  So the sum is finite and exact.
"""
import itertools, sympy as sp

p, q = sp.symbols('p q', positive=True)
n = p + q
eps_PP = q/((p-1)*(n-1)); eps_QQ = p/((q-1)*(n-1)); eps_PQ = sp.Integer(-1)/(n-1)

def run(extra):
    """extra: None, 'P' or 'Q' -- the block of the one generic index, if present."""
    blk = {'a':'P','b':'P','u':'Q','v':'Q'}
    idx = ['a','b','u','v']
    if extra: idx = idx + ['g']; blk['g'] = extra
    pr = [tuple(sorted(c)) for c in itertools.combinations(idx,2)]
    pi = {x:i for i,x in enumerate(pr)}; N = len(pr)
    def eps(pl):
        s = blk[pl[0]]+blk[pl[1]]
        return eps_PP if s=='PP' else eps_QQ if s=='QQ' else eps_PQ
    # structure constants c[a,b,g] = <[phi_a,phi_b],phi_g>
    def bracket(A,B):
        """[phi_ij, phi_kl] = d_jk phi_il - d_ik phi_jl - d_jl phi_ik + d_il phi_jk,
        with phi_ij = E_ij - E_ji antisymmetric in (i,j)."""
        i,j = A; k,l = B
        out = {}
        def add(x,y,co):
            if x == y: return
            t = tuple(sorted((x,y)))
            out[t] = out.get(t,0) + (co if t == (x,y) else -co)
        if j==k: add(i,l, 1)
        if i==k: add(j,l,-1)
        if j==l: add(i,k,-1)
        if i==l: add(j,k, 1)
        return {t:c for t,c in out.items() if c}

    c = [[[0]*N for _ in range(N)] for _ in range(N)]
    for A in pr:
        for B in pr:
            for T,co in bracket(A,B).items(): c[pi[A]][pi[B]][pi[T]] = co
    A_ = [sp.Matrix(N,N, lambda m,k: c[g][m][k]) for g in range(N)]

    # X: symmetric operator, phi_ab <-> phi_uv, minus its Lambda^4 (Bianchi) part
    X = sp.zeros(N,N)
    X[pi[('a','b')], pi[('u','v')]] = 1; X[pi[('u','v')], pi[('a','b')]] = 1
    def R(W,i,j,k,l):
        if i==j or k==l: return 0
        s = 1
        if i>j: i,j,s = j,i,-s
        if k>l: k,l,s = l,k,-s
        return s*W[pi[(i,j)], pi[(k,l)]]
    Alt = sp.zeros(N,N)
    for A in pr:
        for B in pr:
            i,j = A; k,l = B
            if len({i,j,k,l}) < 4: continue
            Alt[pi[A],pi[B]] = sp.Rational(1,3)*(R(X,i,j,k,l)+R(X,i,k,l,j)+R(X,i,l,j,k))
    X = X - Alt
    return pr, pi, eps, A_, X

# --- assemble the three cases ---
pr0, pi0, eps0, A0, X0 = run(None)
norm2 = sum(X0[i,j]**2 for i in range(len(pr0)) for j in range(len(pr0)))
diag  = sum(sp.Rational(1,2)*(eps0(pr0[i])+eps0(pr0[j]))*X0[i,j]**2
            for i in range(len(pr0)) for j in range(len(pr0)))

def sharp_sum(extra, planes, mult):
    pr_, pi_, eps_, A_, X_ = run(extra)
    tot = 0
    for pl in planes:
        g = pi_[tuple(sorted(pl))]
        t = (A_[g]*X_*A_[g]*X_).trace()
        tot += mult*eps_(tuple(sorted(pl)))*t
    return sp.simplify(tot)

core = ['a','b','u','v']
S  = sharp_sum(None, list(itertools.combinations(core,2)), 1)          # both indices inside
S += sharp_sum('P', [(x,'g') for x in core], p-2)                      # one generic P index
S += sharp_sum('Q', [(x,'g') for x in core], q-2)                      # one generic Q index

mu = sp.simplify((diag - sp.Rational(1,2)*S)/norm2)
target = (n-2)/(2*(p-1)*(q-1))
print("||X||^2 =", sp.simplify(norm2))
print("diagonal part =", sp.simplify(diag/norm2))
print("mu  =", sp.factor(mu))
print("target =", sp.factor(sp.simplify(target)))
print("mu - target =", sp.simplify(mu - target))


# ---------------------------------------------------------------------------
# Part 2: X is an eigenvector, not merely a Rayleigh direction.
#
# (e o X)_ab = 1/2(eps(a)+eps(b)) X_ab - 1/4 (T_ab + T_ba),  T_ab = sum_{m,r,t}
# c_amr eps(r) c_brt X_tm.  Here m,t range over X's support (inside the core
# four indices) and r is DETERMINED by a and m -- the third side of the triangle
# -- so no sum over the ambient index set survives.  The universe therefore only
# needs core u a u b, at most eight indices, and the check is finite.
# ---------------------------------------------------------------------------

def circ_entry(a_lbl, b_lbl, blocks):
    """(e o X)_{a,b} for planes given as label pairs; blocks maps label -> 'P'/'Q'."""
    idxs = sorted(set(['a','b','u','v']) | set(a_lbl) | set(b_lbl))
    blk = {'a':'P','b':'P','u':'Q','v':'Q'}; blk.update(blocks)
    pr = [tuple(sorted(c)) for c in itertools.combinations(idxs,2)]
    pi = {x:i for i,x in enumerate(pr)}; N=len(pr)
    def eps(pl):
        s = blk[pl[0]]+blk[pl[1]]
        return eps_PP if s=='PP' else eps_QQ if s=='QQ' else eps_PQ
    def brk(A,B):
        i,j=A; k,l=B; out={}
        def add(x,y,co):
            if x==y: return
            t=tuple(sorted((x,y))); out[t]=out.get(t,0)+(co if t==(x,y) else -co)
        if j==k: add(i,l, 1)
        if i==k: add(j,l,-1)
        if j==l: add(i,k,-1)
        if i==l: add(j,k, 1)
        return {t:c for t,c in out.items() if c}
    def c(A,B,T): return brk(A,B).get(T,0)
    # X on this universe
    Xd = {}
    core=('a','b','u','v')
    raw = {(('a','b'),('u','v')):1, (('u','v'),('a','b')):1}
    def R(i,j,k,l):
        if i==j or k==l: return 0
        s=1
        if i>j: i,j,s=j,i,-s
        if k>l: k,l,s=l,k,-s
        return s*raw.get((tuple(sorted((i,j))),tuple(sorted((k,l)))),0)
    for A in pr:
        for B in pr:
            val = raw.get((A,B),0)
            i,j=A; k,l=B
            if len({i,j,k,l})==4:
                val -= sp.Rational(1,3)*(R(i,j,k,l)+R(i,k,l,j)+R(i,l,j,k))
            if val: Xd[(A,B)] = sp.nsimplify(val)
    def T(A,B):
        tot=0
        for (t_,m_),xv in Xd.items():
            for r in pr:
                c1=c(A,m_,r)
                if not c1: continue
                c2=c(B,r,t_)
                if not c2: continue
                tot += c1*eps(r)*c2*xv
        return tot
    diag = sp.Rational(1,2)*(eps(a_lbl)+eps(b_lbl))*Xd.get((a_lbl,b_lbl),0)
    return sp.simplify(diag - sp.Rational(1,4)*(T(a_lbl,b_lbl)+T(b_lbl,a_lbl)))

mu_t = (n-2)/(2*(p-1)*(q-1))
print("\n--- Part 2: (e o X)_ab against mu * X_ab, by plane type ---")
cases = [
    ("on-core PP x QQ", ('a','b'), ('u','v'), {}, sp.Rational(2,3)),
    ("on-core PQ x PQ", ('a','u'), ('b','v'), {}, sp.Rational(1,3)),
    ("on-core PQ x PQ'",('a','v'), ('b','u'), {}, sp.Rational(-1,3)),
    ("off: one generic P", ('a','g'), ('u','v'), {'g':'P'}, 0),
    ("off: one generic Q", ('a','h'), ('u','v'), {'h':'Q'}, 0),
    ("off: generic on both",('a','g'), ('u','h'), {'g':'P','h':'Q'}, 0),
    ("off: two generic",  ('g','h'), ('a','b'), {'g':'P','h':'Q'}, 0),
    ("off: both generic P",('g','h'),('u','v'), {'g':'P','h':'P'}, 0),
]
ok=True
for name,A,B,bl,xval in cases:
    got = circ_entry(A,B,bl)
    want = sp.simplify(mu_t*xval)
    d = sp.simplify(got-want)
    ok &= (d==0)
    print(f"  {name:22s} got-want = {d}")
print("\nALL ENTRIES MATCH mu*X:" , ok)
