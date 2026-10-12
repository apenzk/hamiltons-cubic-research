"""r251, claim 1c: how much slack does the projector-free Gram carry?

The certificate bounds rank(functions on Weyl_n) by rank(Gram).  This walks the
ladder of ranks between them for the 105 degree-2 diagrams (8 legs):

    rank(Gram) = rank of the diagram TENSORS
      >= rank of the diagram functions on GENERIC 4-tensors
      >= ... on RIEMANN tensors (algebraic curvature tensors)
      >= ... on WEYL tensors            <- the only one the programme cares about
"""
import numpy as np

def matchings(pts):
    if not pts:
        yield (); return
    for i in range(1, len(pts)):
        for m in matchings(pts[1:i] + pts[i+1:]):
            yield ((pts[0], pts[i]),) + m

def n_cycles(M1, M2, k):
    p1 = [0]*(2*k); p2 = [0]*(2*k)
    for a, b in M1: p1[a] = b; p1[b] = a
    for a, b in M2: p2[a] = b; p2[b] = a
    seen = [False]*(2*k); c = 0
    for s in range(2*k):
        if seen[s]: continue
        c += 1; v = s; u = True
        while not seen[v]:
            seen[v] = True; v = p1[v] if u else p2[v]; u = not u
    return c

LET = "abcdefgh"
def value(M, W):
    lab = [None]*8
    for j, (a, b) in enumerate(M): lab[a] = lab[b] = LET[j]
    return float(np.einsum("".join(lab[:4])+","+"".join(lab[4:])+"->", W, W))

def generic(n, rng):  return rng.standard_normal((n,)*4)

def riemann(n, rng):
    R = rng.standard_normal((n,)*4)
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    return R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0

def weyl(n, rng):
    R = riemann(n, rng); g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    KN = lambda A,B: (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                      -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))

Ms = list(matchings(tuple(range(8))))
rng = np.random.default_rng(251)
print(f"  {len(Ms)} degree-2 diagrams on 8 legs\n")
print(f"  {'n':>3} {'dim W_n':>8} {'rank Gram':>10} {'generic':>9} {'Riemann':>9} {'Weyl':>6}"
      f"   {'certified':>10} {'actual':>7}")
for n in (4, 5, 6, 7, 8):
    G = np.array([[n**n_cycles(A,B,4) % 100003 for B in Ms] for A in Ms], dtype=np.int64)
    # exact rank over Q >= rank mod p; equality confirmed against the Fraction
    # computation in c1_frobenius_gram.py at n = 2..5
    A = G.copy(); m = len(Ms); r = 0; p = 100003
    for c in range(m):
        pr = next((i for i in range(r, m) if A[i, c] % p), None)
        if pr is None: continue
        A[[r, pr]] = A[[pr, r]]
        A[r] = (A[r]*pow(int(A[r, c]), p-2, p)) % p
        col = A[:, c].copy(); col[r] = 0
        A = (A - np.outer(col, A[r])) % p
        r += 1
    ranks = []
    for gen in (generic, riemann, weyl):
        samples = [gen(n, rng) for _ in range(130)]
        V = np.array([[value(M, X) for M in Ms] for X in samples])
        ranks.append(np.linalg.matrix_rank(V, tol=1e-9*max(1.0, np.abs(V).max())))
    dw = n*(n+1)*(n+2)*(n-3)//12
    print(f"  {n:>3} {dw:>8} {r:>10} {ranks[0]:>9} {ranks[1]:>9} {ranks[2]:>6}"
          f"   {len(Ms)-r:>10} {len(Ms)-ranks[2]:>7}")
print("\n  'certified' = relations the projector-free Gram proves; 'actual' =")
print("  relations among the 105 diagram functions on Weyl_n.")
