"""r264 / claim 5(a),(b): is the FFT surjection UNCONDITIONAL in n, and is
dim nu = sum_lambda m_lambda(n)^2 an independent identity or a restatement?

Three numbers per cell, by three routes that share no code:
  A  dim End_{O(n)}(V^{(x)f}), as the nullity of the commutator system for three
     random elements of O(n) (two in SO(n), one with det = -1).  Uses the GROUP
     only -- no diagrams, no tableaux.
  B  dim nu(B_f(n)) = rank of span{nu(D)}, built from the matchings.
  C  sum_lambda m_lambda(n)^2 over restricted up-down tableaux.
A == B is Weyl's FFT for O(n) (surjectivity).  A == C is the double centraliser
plus the branching count.  Both are tested BELOW n = f, where nu is not injective.
"""
import numpy as np, itertools

def matchings(pts):
    if not pts:
        yield (); return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def diagram_span_dim(f, n):
    dim = n ** f
    idx = [tuple((k // n**(f-1-p)) % n for p in range(f)) for k in range(dim)]
    rows = []
    for D in matchings(tuple(range(2*f))):
        M = np.zeros((dim, dim))
        for r, j in enumerate(idx):
            for c, i in enumerate(idx):
                lab = j + i
                if all(lab[a] == lab[b] for a, b in D):
                    M[r, c] = 1.0
        rows.append(M.reshape(-1))
    return np.linalg.matrix_rank(np.array(rows), tol=1e-8)

def rand_O(n, rng, det=+1):
    if n == 1:
        return np.array([[float(det)]])
    q, r = np.linalg.qr(rng.standard_normal((n, n)))
    q = q * np.sign(np.diag(r))
    if np.sign(np.linalg.det(q)) != det:
        q[:, 0] *= -1
    return q

def commutant_dim(f, n, rng):
    D = n ** f
    blocks = []
    for det in (+1, +1, -1):
        g = rand_O(n, rng, det)
        R = g
        for _ in range(f - 1):
            R = np.kron(R, g)
        blocks.append(np.kron(np.eye(D), R) - np.kron(R.T, np.eye(D)))
    A = np.vstack(blocks)
    return D * D - np.linalg.matrix_rank(A, tol=1e-8)

def conj(l): return tuple(sum(1 for p in l if p > k) for k in range(l[0])) if l else ()
def admissible(l, n):
    c = conj(l)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def restricted_updown(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

rng = np.random.default_rng(2640)
CELLS = [(2, n) for n in range(1, 8)] + [(3, n) for n in range(1, 5)] \
      + [(4, n) for n in range(1, 4)] + [(5, 2), (6, 2)]
print(f"{'f':>2} {'n':>2} {'n<f?':>5} {'(2f-1)!!':>9} "
      f"{'A dim End_O(n)':>15} {'B dim nu(B)':>12} {'C sum m^2':>10}  A=B (FFT)  A=C")
bad = 0
for f, n in CELLS:
    A = commutant_dim(f, n, rng)
    B = diagram_span_dim(f, n)
    C = sum(v * v for v in restricted_updown(f, n).values())
    dd = 1
    for i in range(1, 2*f, 2): dd *= i
    ok1, ok2 = ("YES" if A == B else "NO"), ("YES" if A == C else "NO")
    bad += (A != B) + (A != C)
    print(f"{f:>2} {n:>2} {str(n<f):>5} {dd:>9} {A:>15} {B:>12} {C:>10}  {ok1:>9}  {ok2:>3}")
print(f"\n{bad} disagreements over {len(CELLS)} cells "
      f"({sum(1 for f,n in CELLS if n<f)} of them with n < f, where nu is NOT injective)")
