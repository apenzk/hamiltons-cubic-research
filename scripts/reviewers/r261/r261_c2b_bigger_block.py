"""r261 claim 2, part b -- the same test where the covariant space is BIGGER
than one dimension, so that "spans" has something to span.

V = R^4, f = 6, U = Lambda^2 V (dim 6), e = projector onto Sym^3(U) inside
V^{tensor 6}.  B_6(4) is not semisimple (4 < 5) and nu is not injective (4 < 6).
lambda runs over the labels realisable in two legs: varnothing, (2), (1,1).
Every seed used is one that e ANNIHILATES.
"""
import numpy as np
from itertools import permutations

N = 4

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def matching_vector(D, m):
    v = np.zeros((N,) * m)
    for t in np.ndindex(*([N] * m)):
        if all(t[a] == t[b] for a, b in D):
            v[t] = 1.0
    return v.reshape(-1)

def swap(v, m, i, j):
    return np.swapaxes(v.reshape((N,) * m), i, j).reshape(-1)

def contract(v, m, i, j):
    a = v.reshape((N,) * m)
    tr = np.trace(a, axis1=i, axis2=j)
    out = np.zeros((N,) * m)
    idx = [slice(None)] * m
    for b in range(N):
        idx[i], idx[j] = b, b
        out[tuple(idx)] = tr
        idx[i], idx[j] = slice(None), slice(None)
    return out.reshape(-1)

def block_perm(v, m, legs, perm):
    a = v.reshape((N,) * m)
    order = list(range(m))
    blocks = [legs[0:2], legs[2:4], legs[4:6]]
    flat_src = [x for k in range(3) for x in blocks[perm[k]]]
    for pos, src in zip(legs, flat_src):
        order[pos] = src
    return np.transpose(a, order).reshape(-1)

def e_apply(v, m, legs):
    for (i, j) in (legs[0:2], legs[2:4], legs[4:6]):
        v = 0.5 * (v - swap(v, m, i, j))
    s = np.zeros_like(v)
    for p in permutations(range(3)):
        s = s + block_perm(v, m, legs, p)
    return s / 6.0

def e_cols(V, m, legs):
    return np.column_stack([e_apply(V[:, k].copy(), m, legs) for k in range(V.shape[1])])

def rank(M, tol=1e-8):
    return 0 if M.size == 0 else int(np.linalg.matrix_rank(M, tol=tol))

def closure(seed, m, legs):
    basis = (seed / np.linalg.norm(seed)).reshape(-1, 1)
    frontier = [seed]
    while frontier:
        nxt = []
        for v in frontier:
            for k in range(len(legs) - 1):
                i, j = legs[k], legs[k+1]
                for w in (swap(v, m, i, j), contract(v, m, i, j)):
                    nw = np.linalg.norm(w)
                    if nw < 1e-12:
                        continue
                    w = w / nw
                    resid = w - basis @ (basis.T @ w)
                    if np.linalg.norm(resid) > 1e-7:
                        basis = np.column_stack([basis, resid / np.linalg.norm(resid)])
                        nxt.append(w)
        frontier = nxt
    return basis

m, legs = 8, list(range(2, 8))
Inv = np.column_stack([matching_vector(D, m) for D in matchings(tuple(range(m)))])
print(f"V = R^4, V^(tensor 8) has dim {N**m}; {Inv.shape[1]} matchings, "
      f"dim Inv = {rank(Inv)}")

def slot(kind):
    """projector on legs 0,1 onto the copy of V_lambda inside V tensor V."""
    cols = []
    for k in range(Inv.shape[1]):
        v = Inv[:, k]
        if kind == "antisym":
            cols.append(0.5 * (v - swap(v, m, 0, 1)))
        elif kind == "sym0":
            s = 0.5 * (v + swap(v, m, 0, 1))
            t = contract(s, m, 0, 1) / N          # the trace part
            cols.append(s - t)
        else:                                     # the trace slot: lambda = ()
            cols.append(contract(v, m, 0, 1) / N)
    return np.column_stack(cols)

for name, kind in (("varnothing", "trace"), ("(1,1)", "antisym"), ("(2)", "sym0")):
    M = slot(kind)
    dM = rank(M)
    eM = e_cols(M, m, legs)
    d_eM = rank(eM)
    print(f"\nlambda = {name}: dim M_lambda = {dM}, dim e M_lambda = {d_eM}, "
          f"e M inside M: {rank(np.column_stack([M, eM])) == dM}")
    if d_eM == 0:
        print("   nothing to span here")
        continue
    killed = [M[:, k] for k in range(M.shape[1])
              if np.linalg.norm(M[:, k]) > 1e-9
              and np.linalg.norm(e_apply(M[:, k].copy(), m, legs)) < 1e-9]
    print(f"   seeds e ANNIHILATES: {len(killed)}")
    for k, c0 in enumerate(killed[:3]):
        sp = closure(c0, m, legs)
        esp = e_cols(sp, m, legs)
        print(f"     seed {k}: span{{nu(D)c_0}} = {sp.shape[1]} of {dM}, "
              f"span{{e nu(D)c_0}} = {rank(esp)} of {d_eM}")
        assert sp.shape[1] == dM and rank(esp) == d_eM
