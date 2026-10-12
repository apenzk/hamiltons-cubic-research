# Screen of the I106 derivation's batch 6, seconds: the fluctuation form of the cubic and the Klein-four split.
import sys, itertools, numpy as np
import os; HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(HERE, '..', 'lib'))
import importlib.util
spec = importlib.util.spec_from_file_location("s", os.path.join(HERE, 'screen_I106.py'))
src = open(spec.origin).read().split('print("== screen 1')[0]
ns = {'HERE': HERE, '__file__': os.path.join(HERE, 'screen_I106.py')}; exec(src.replace("sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'lib'))", "sys.path.insert(0, os.path.join(HERE, '..', 'lib'))"), ns)
rng = np.random.default_rng(5)
def sym(k): A = rng.normal(size=(k, k)); return (A + A.T) / 2
for m in (3, 4, 5):
    Xs = [sym(3) for _ in range(m)]; Xs = [X - np.trace(X) / 3 * np.eye(3) for X in Xs]
    C = lambda a, b, c: np.trace(Xs[a] @ Xs[b] @ Xs[c])
    lhs = 6 * sum(C(a, a, a) for a in range(m)) + 9 * sum(C(a, a, b) for a in range(m) for b in range(m) if a != b) + 12 * sum(C(*t) for t in itertools.combinations(range(m), 3))
    X = sum(Xs); Ys = [Xa - X / m for Xa in Xs]; T = sum(Y @ Y for Y in Ys)
    rhs = (2 * m + 1) * (m + 1) / m ** 2 * np.trace(X @ X @ X) + (3 + 3 / m) * np.trace(X @ T) + sum(np.trace(Y @ Y @ Y) for Y in Ys)
    n2l = sum(np.trace(Xs[a] @ Xs[b]) for a in range(m) for b in range(m) if a != b) + 2 * sum(np.trace(Xa @ Xa) for Xa in Xs)
    n2r = (1 + 1 / m) * np.trace(X @ X) + sum(np.trace(Y @ Y) for Y in Ys)
    print(f"m={m}: cubic lhs {lhs:.10f} fluctuation rhs {rhs:.10f} | frame part of norm lhs {n2l:.10f} rhs {n2r:.10f}")
# Klein-four: P(W) = P(D) + 3 sum_ij T(D,O_ij,O_ij) + 6 t(x12, x13, x23), with P on blocks from the formula
for n in (5, 6, 7):
    m = n - 3; K = sym(m); np.fill_diagonal(K, 0); S, Ms = ns['weyl_from']([sym(3) for _ in range(m)], K)
    P = ns['P_formula'](S, Ms, K)
    def part(keep):
        S2 = S.copy(); M2 = [M.copy() for M in Ms]
        for (i, j) in [(0, 1), (0, 2), (1, 2)]:
            if (i, j) not in keep:
                S2[i, j] = S2[j, i] = 0
                for M in M2: M[i, j] = M[j, i] = 0
        return ns['P_formula'](S2, M2, K)
    PD = part([]); pairs = [(0, 1), (0, 2), (1, 2)]
    quad = sum(part([p]) - PD for p in pairs)
    x = {p: np.array([M[p] for M in Ms]) for p in pairs}
    X12, X13, X23 = x[(0, 1)], x[(0, 2)], x[(1, 2)]
    b = lambda v: v.sum()
    t = np.sum(X12 * X13 * X23) + np.sum(b(X12) * X13 * X23 + b(X13) * X12 * X23 + b(X23) * X12 * X13) + 2 * b(X12) * b(X13) * b(X23)
    hat = lambda v: v + b(v)
    t2 = np.sum(hat(X12) * hat(X13) * hat(X23)) - (m + 1) * b(X12) * b(X13) * b(X23)
    print(f"n={n}: P - P(D) - quadratic parts {P - PD - quad:.10f} | 6t {6 * t:.10f} | 6t (hat form) {6 * t2:.10f}")
