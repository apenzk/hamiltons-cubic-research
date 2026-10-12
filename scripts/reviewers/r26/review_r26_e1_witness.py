"""E1 (a),(c),(e): build the claimed witness as a FULL EXPLICIT ORDERED TENSOR and check
feasibility + objective by brute force, no formulas."""
import numpy as np, itertools, math, sys

def theta0(n): return math.sqrt(2*(n-1)*(n-2))/n

def witness(n, p, Cpair=2.0, repeat_free=False):
    N = n*(n-1)//2
    kappa = 2.0*(n-2)
    q = N - p
    S = list(range(p)); Sc = list(range(p, N))
    T = np.zeros((N,N,N))
    if repeat_free:
        tS = kappa/((p-1)*(p-2)); tQ = kappa/((q-1)*(q-2))
        for a,b,c in itertools.product(S,S,S):
            if len({a,b,c})==3: T[a,b,c] = tS
        for a,b,c in itertools.product(Sc,Sc,Sc):
            if len({a,b,c})==3: T[a,b,c] = tQ
    else:
        for a,b,c in itertools.product(S,S,S):   T[a,b,c] = kappa/p**2
        for a,b,c in itertools.product(Sc,Sc,Sc): T[a,b,c] = kappa/q**2
    # w
    s = math.sqrt(p*q/N)
    x = s/p; y = s/q
    w = np.array([x]*p + [-y]*q)
    return T, w, kappa

def audit(n, p, repeat_free=False, verbose=True):
    T, w, kappa = witness(n, p, repeat_free=repeat_free)
    N = T.shape[0]
    nonneg = T.min()
    sym = max(np.abs(T-np.transpose(T,pm)).max() for pm in
              [(0,2,1),(1,0,2),(1,2,0),(2,0,1),(2,1,0)])
    row = T.sum(axis=(1,2)); pair = T.sum(axis=2)
    rep = max(max(abs(T[a,a,b]) for a in range(N) for b in range(N)),
              max(abs(T[a,b,b]) for a in range(N) for b in range(N)),
              max(abs(T[a,b,a]) for a in range(N) for b in range(N)))
    obj_raw = 0.0
    for a in range(N):
        for b in range(N):
            for c in range(N):
                obj_raw += w[a]*w[b]*w[c]*T[a,b,c]
    obj = (w**3).sum() + 0.5*obj_raw
    trsharp = 0.5*np.einsum('abc,b,c->', T, w, w)
    if verbose:
        print(f"n={n:3d} p={p:3d} N={N:4d} kappa={kappa:.0f} repeat_free={repeat_free}")
        print(f"   nonneg min       = {nonneg:.6f}   (need >= 0)")
        print(f"   total symmetry   = {sym:.2e}")
        print(f"   row marginals    = [{row.min():.10f}, {row.max():.10f}]  need {kappa}")
        print(f"   pair marginals   = [{pair.min():.10f}, {pair.max():.10f}]  need <= 2")
        print(f"   |T| on repeats   = {rep:.6f}   (TRUE tensors have 0 here)")
        print(f"   trace-free sum w = {w.sum():.2e}   |w|^2 = {(w*w).sum():.12f}")
        print(f"   OBJECTIVE (raw)  = {obj:.6f}      theta0(n) = {theta0(n):.6f}   ratio {obj/theta0(n):.4f}")
        print(f"   implied tr(W^#)  = {trsharp:.6f}   TRUE VALUE for unit Weyl W = -1.0")
    return obj, trsharp, row, pair, rep

print("="*100)
print("PART (a)/(c): full explicit ordered tensor audit of the claimed witness")
print("="*100)
for n,p in [(6,4),(8,6),(10,8)]:
    audit(n,p); print()
print("="*100)
print("PART (c)/(e): the claimed numbers, from the raw ordered triple sum")
print("="*100)
def best_p(n, repeat_free=False):
    N=n*(n-1)//2; kappa=2.0*(n-2); best=(-1e9,None)
    lo = (int(math.ceil(kappa/2))+1) if repeat_free else int(math.ceil(kappa/2))
    for p in range(max(3,lo), N-max(3,lo)+1):
        q=N-p
        if repeat_free and (q-1)*(q-2)==0: continue
        # closed form of the value, cross-checked against raw sums above
        s=math.sqrt(p*q/N)
        v=(n-1)*s**3*(1/p**2 - 1/q**2)
        if v>best[0]: best=(v,p)
    return best
print(f"{'n':>4} {'N':>6} {'p*':>5} {'value':>12} {'theta0':>10} {'ratio':>8} {'value/sqrt(n-2)':>16}")
for n in [6,8,10,12,16,20,50,100,200]:
    v,p = best_p(n)
    print(f"{n:>4} {n*(n-1)//2:>6} {p:>5} {v:>12.6f} {theta0(n):>10.6f} {v/theta0(n):>8.4f} {v/math.sqrt(n-2):>16.6f}")
print()
print("Same, with the (valid) repeat-free constraint T_abc = 0 on repeated indices imposed:")
print(f"{'n':>4} {'p*':>5} {'value':>12} {'theta0':>10} {'ratio':>8}")
for n in [6,8,10,12,16,20,50,100,200]:
    N=n*(n-1)//2; kappa=2.0*(n-2); best=(-1e9,None)
    for p in range(int(math.ceil(kappa/2))+1, N-3):
        q=N-p; s=math.sqrt(p*q/N)
        v=(n-1)*s**3*(1/p**2-1/q**2)
        if v>best[0]: best=(v,p)
    print(f"{n:>4} {best[1]:>5} {best[0]:>12.6f} {theta0(n):>10.6f} {best[0]/theta0(n):>8.4f}")
print()
print("repeat-free explicit tensor audits (n=6,8,10):")
for n,p in [(6,5),(8,7),(10,9)]:
    audit(n,p,repeat_free=True); print()
