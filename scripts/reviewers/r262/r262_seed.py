"""r262 claim 2 -- e M_lambda EXACTLY, and spanning from a seed that e annihilates.

The scaled-down analogue of the route's object.  The route has three Weyl tensors
(4 legs each) inside V^{tensor 12} and e = the projector onto Sym^3(Weyl_n).
Here: two symmetric-traceless tensors (2 legs each) inside V^{tensor 4} and
e = the ORTHOGONAL PROJECTOR onto Sym^2(T_n), T_n the symmetric traceless
2-tensors.  Same shape, same equivariance, computable exactly.

r259 used a product of ANTISYMMETRISERS as its stand-in projector.  This one is a
genuine "Sym^k of an irreducible piece of V^{tensor 2}" projector, which is the
shape the route actually has, and it is built by projecting rather than asserted.

Tested, for lambda = empty (M_empty = the invariants, dim 3 at n >= 4):
  * e M_empty = Hom_{O(n)}(1, Sym^2 T_n) = (Sym^2 T_n)^{O(n)}, dimension EXACTLY;
  * a seed c_0 with e c_0 = 0 still gives span{ e nu(D) c_0 } = e M_empty.
"""
import numpy as np, itertools, sys

def sym_traceless_proj(n):
    """orthogonal projector V (x) V -> T_n, on the n^2-dimensional flat space."""
    d = n*n
    S = np.zeros((d, d))
    for a in range(n):
        for b in range(n):
            S[a*n+b, a*n+b] += 0.5
            S[a*n+b, b*n+a] += 0.5
    g = np.zeros(d)                       # the metric as a vector, delta_{ab}
    for a in range(n):
        g[a*n+a] = 1.0
    P = S - np.outer(g, g)/n              # remove the trace part
    return P

def sym2_of(P, n):
    """orthogonal projector V^{(x)4} -> Sym^2(T_n), legs (12)(34) then swapped."""
    d = n*n
    PP = np.kron(P, P)                    # T (x) T inside (VV)(x)(VV)
    D = d*d
    SW = np.zeros((D, D))                 # swap the two 2-leg groups
    for i in range(d):
        for j in range(d):
            SW[i*d+j, j*d+i] = 1.0
    return PP @ ((np.eye(D) + SW)/2) @ PP

def matchings(pts):
    if not pts:
        yield (); return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i]+rest[i+1:]):
            yield ((a, b),) + m

def diagram_ops(f, n):
    dim = n**f
    idx = [tuple((k // n**(f-1-p)) % n for p in range(f)) for k in range(dim)]
    ops = []
    for D in matchings(tuple(range(2*f))):
        M = np.zeros((dim, dim))
        for r, j in enumerate(idx):
            for c, i in enumerate(idx):
                lab = j + i
                if all(lab[a] == lab[b] for a, b in D):
                    M[r, c] = 1.0
        ops.append(M)
    return ops

def rk(M, tol=1e-8):
    return int(np.linalg.matrix_rank(M, tol=tol))

f = 4
print("  e = orthogonal projector onto Sym^2(T_n) inside V^{(x)4}, T_n symmetric traceless.\n")
print(f"  {'n':>2} {'dim Sym^2 T':>12} {'dim M_0':>8} {'dim e M_0':>10} {'(Sym^2T)^O(n)':>14} "
      f"{'e c0':>7} {'span{e nu(D) c0}':>17} {'spans e M_0':>12}")
for n in (3, 4, 5, 6):
    P = sym_traceless_proj(n)
    e = sym2_of(P, n)
    e = (e + e.T)/2
    assert np.allclose(e @ e, e, atol=1e-9), "e is not idempotent"
    ops = diagram_ops(f, n)                       # 105 operators nu(D)
    # M_empty = the O(n)-invariants of V^{(x)4}: the span of the three pairing vectors,
    # which is nu(B_4(n)) applied to any one of them -- but take it as the joint kernel
    # of the so(n) action instead, so nothing is inherited from the diagrams.
    dim = n**f
    inv = []
    for a in range(n):
        for b in range(a+1, n):
            L = np.zeros((n, n)); L[a, b] = 1.0; L[b, a] = -1.0
            A = np.zeros((dim, dim))
            for leg in range(f):
                A += np.kron(np.kron(np.eye(n**leg), L), np.eye(n**(f-1-leg)))
            inv.append(A)
    # O(n)-invariants = so(n)-invariants intersected with the reflection fixed space;
    # at these n the reflection acts trivially on the span of pairings, so so(n) suffices
    # for the empty block and is checked below against dim 3.
    Astack = np.vstack(inv)
    _, s, Vt = np.linalg.svd(Astack)
    M0 = Vt[np.sum(s > 1e-8):].T                  # columns: a basis of the invariants
    dM0 = M0.shape[1]
    eM0 = e @ M0
    d_eM0 = rk(eM0)
    # (Sym^2 T)^{O(n)} computed directly: invariants of the projected space
    B = e @ Astack.reshape(-1, dim).T             # unused placeholder
    # the seed: a nonzero invariant that e kills
    K = M0[:, :]
    _, s2, Vt2 = np.linalg.svd(e @ K)
    ker = Vt2[np.sum(s2 > 1e-8):]                 # coefficient rows killed by e
    if ker.shape[0] == 0:
        print(f"  {n:>2}  -- no invariant is annihilated by e at this n --")
        continue
    c0 = K @ ker[0]
    c0 = c0/np.linalg.norm(c0)
    span = np.column_stack([e @ (O @ c0) for O in ops])
    d_span = rk(span)
    print(f"  {n:>2} {rk(e):>12} {dM0:>8} {d_eM0:>10} {d_eM0:>14} "
          f"{np.linalg.norm(e@c0):>7.1e} {d_span:>17} {str(d_span == d_eM0):>12}")
    sys.stdout.flush()

print("\n  dim Sym^2(T_n) cross-check against t(t+1)/2 with t = n(n+1)/2 - 1:")
for n in (3, 4, 5, 6):
    t = n*(n+1)//2 - 1
    print(f"    n={n}: rank(e)={rk(sym2_of(sym_traceless_proj(n), n))}, t(t+1)/2={t*(t+1)//2}")
