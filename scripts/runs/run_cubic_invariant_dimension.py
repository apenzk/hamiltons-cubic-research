"""Dimension of the space of cubic (and quartic) O(n)-invariant polynomials on W_n.

Theorem proved/verified here:

    dim { cubic O(n)-invariants on W_n } = 2   for n >= 6, spanned by tr(W^3) and <W^#,W>
                                         = 1   for n = 4, 5   (there <W^#,W> = 2 tr(W^3))
                                         = 0   for n <= 3     (W_n = 0)

Three independent computations:

  (A) enumerate ALL loop-free complete contractions of W (x) W (x) W (1728 of them,
      5 orbits under S_3 x D_4^3) and take the numerical rank of their values;
  (B) an exact integer certificate: the full symmetric polarization of
      s(W) = W_ijkl W_klpq W_pqij  and  t(W) = W_ipkq W_jplq W_ijkl
      on an integer basis of W_n, showing s - 2t == 0 for n = 4,5 and rank 2 for n = 6;
  (C) the stable-range representation theory: W_n is the O(n)-irreducible V_[2,2],
      and the Newell-Littlewood number N_{(2,2),(2,2),(2,2)} = 2 counts the trilinear
      O(n)-invariants for n large.

Bonus (same enumeration, four copies): dim{quartic invariants} = 7 for n >= 8, 6 for n = 6,7.

Usage:  python3 run_cubic_invariant_dimension.py [--exact]     (--exact runs (B), ~9 min)
"""
import itertools, sys
import numpy as np

# ---------------------------------------------------------------- Weyl tensors
def kn(A, B):
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))

def project_weyl(T, n):
    """Orthogonal projection of an arbitrary 4-tensor onto W_n."""
    T = T - np.transpose(T, (1, 0, 2, 3))
    T = T - np.transpose(T, (0, 1, 3, 2))
    T = T + np.transpose(T, (2, 3, 0, 1))
    A = np.zeros_like(T)                       # kill the Lambda^4 part -> first Bianchi
    for p in itertools.permutations(range(4)):
        seen, par, pl = [0]*4, 0, list(p)
        for i in range(4):
            if seen[i]:
                continue
            j, c = i, 0
            while not seen[j]:
                seen[j] = 1; j = pl[j]; c += 1
            par += c - 1
        A = A + (-1 if par % 2 else 1) * np.transpose(T, p)
    T = T - A / 24.0
    g = np.eye(n)                              # Weyl projection (remove all traces)
    Ric = np.einsum('ikjk->ij', T)
    P = (Ric - g * np.trace(Ric) / (2*(n-1))) / (n-2)
    return T - kn(P, g)

def rand_weyl(rng, n):
    W = project_weyl(rng.standard_normal((n, n, n, n)), n)
    return W / np.linalg.norm(W)

# --------------------------------------- (A) exhaustive contraction enumeration
def loop_free_matchings(nc):
    ns, out = 4*nc, []
    def rec(free, partner):
        if not free:
            out.append(tuple(partner)); return
        a = free[0]
        for b in free[1:]:
            if b // 4 == a // 4:               # self-contraction: vanishes, W is trace free
                continue
            partner[a] = b; partner[b] = a
            rec([x for x in free[1:] if x != b], partner)
            partner[a] = partner[b] = -1
    rec(list(range(ns)), [-1]*ns)
    return out

def orbit_reps(nc):
    """Representatives of the diagrams modulo S_nc on copies and D_4 on each copy's slots."""
    ns = 4*nc
    D4 = [p for p in itertools.permutations(range(4))
          if {frozenset((p[0], p[1])), frozenset((p[2], p[3]))} == {frozenset((0, 1)), frozenset((2, 3))}]
    gens = []
    for p in D4[1:]:
        perm = list(range(ns))
        for i in range(4):
            perm[i] = p[i]
        gens.append(tuple(perm))
    for c in range(nc-1):
        perm = list(range(ns))
        for i in range(4):
            perm[4*c+i] = 4*(c+1)+i; perm[4*(c+1)+i] = 4*c+i
        gens.append(tuple(perm))
    def act(perm, pa):
        new = [0]*ns
        for a in range(ns):
            new[perm[a]] = perm[pa[a]]
        return tuple(new)
    rem, reps = set(loop_free_matchings(nc)), []
    while rem:
        start = next(iter(rem)); orb, stack = {start}, [start]
        while stack:
            cur = stack.pop()
            for g in gens:
                nxt = act(g, cur)
                if nxt not in orb:
                    orb.add(nxt); stack.append(nxt)
        rem -= orb; reps.append(start)
    return reps

def einsum_spec(partner, nc):
    letters, lab, k = 'abcdefghijklmnop', [None]*(4*nc), 0
    for a in range(4*nc):
        if lab[a] is None:
            lab[a] = letters[k]; lab[partner[a]] = letters[k]; k += 1
    return ','.join(''.join(lab[4*c:4*c+4]) for c in range(nc)) + '->'

def span_dimension(nc, ns_list):
    reps = orbit_reps(nc)
    subs = [einsum_spec(p, nc) for p in reps]
    print(f"  degree {nc}: {len(loop_free_matchings(nc))} loop-free complete contractions, "
          f"{len(reps)} orbits under S_{nc} x D_4^{nc}")
    rng = np.random.default_rng(7)
    for n in ns_list:
        Ws = [rand_weyl(rng, n) for _ in range(len(reps)+8)]
        M = np.zeros((len(subs), len(Ws)))
        for j, W in enumerate(Ws):
            for i, s in enumerate(subs):
                M[i, j] = np.einsum(s, *([W]*nc), optimize=True)
        sv = np.linalg.svd(M, compute_uv=False)
        r = int((sv > sv[0]*1e-9).sum())
        print(f"    n={n:>2}: dim = {r}   (relative singular values at the cut: "
              f"{sv[r-1]/sv[0]:.2e} -> {sv[r]/sv[0]:.2e})")

# --------------------------------------------------- (B) exact integer certificate
def exact_certificate(n, dimW):
    from fractions import Fraction as F
    def int_weyl(h):
        R = kn(h, h)
        g = np.zeros((n, n), dtype=object)
        for i in range(n):
            g[i, i] = 1
        Ric = np.einsum('ikjk->ij', R)
        scal = np.einsum('ii->', Ric)
        # 2(n-1)(n-2) * Weyl(R), cleared of denominators
        return 2*(n-1)*(n-2)*R - kn(2*(n-1)*Ric - scal*g, g)
    def rank(rows):
        M = [r[:] for r in rows]; r = 0
        for c in range(len(M[0])):
            piv = next((i for i in range(r, len(M)) if M[i][c] != 0), None)
            if piv is None:
                continue
            M[r], M[piv] = M[piv], M[r]; pv = M[r][c]
            for i in range(r+1, len(M)):
                if M[i][c] != 0:
                    f = M[i][c]/pv
                    M[i] = [a - f*b for a, b in zip(M[i], M[r])]
            r += 1
            if r == len(M):
                break
        return r
    rng, rows, tens = np.random.default_rng(5), [], []
    while len(tens) < dimW:
        h = np.zeros((n, n), dtype=object)
        for i in range(n):
            for j in range(i, n):
                v = int(rng.integers(-2, 3)); h[i, j] = v; h[j, i] = v
        W = int_weyl(h)
        cand = rows + [[F(x) for x in W.reshape(-1)]]
        if rank(cand) == len(cand):
            rows = cand; tens.append(W)
    A = np.array([np.array(W, dtype=np.int64) for W in tens])
    S = np.einsum('aijkl,bklpq,cpqij->abc', A, A, A, optimize=True)
    T = np.einsum('aipkq,bjplq,cijkl->abc', A, A, A, optimize=True)
    sym = lambda X: (X + X.transpose(0, 2, 1) + X.transpose(1, 0, 2)
                     + X.transpose(1, 2, 0) + X.transpose(2, 0, 1) + X.transpose(2, 1, 0))
    Ss, Ts = sym(S), sym(T)
    D = np.abs(Ss - 2*Ts).max()
    flat = np.stack([Ss.reshape(-1).astype(float), Ts.reshape(-1).astype(float)])
    sv = np.linalg.svd(flat, compute_uv=False)
    print(f"    n={n} (dim W_n = {dimW}): max |polarization of s - 2t| = {D}"
          f"   -> dim span(s,t) = {int((sv > sv[0]*1e-12).sum())}")

if __name__ == '__main__':
    print("(A) rank of the span of all complete contractions:")
    span_dimension(3, [4, 5, 6, 7, 8, 9, 10])
    span_dimension(4, [6, 7, 8, 9, 10, 12])
    if '--exact' in sys.argv:
        print("(B) exact integer polarization certificate:")
        for n, d in [(4, 10), (5, 35), (6, 84)]:
            exact_certificate(n, d)
