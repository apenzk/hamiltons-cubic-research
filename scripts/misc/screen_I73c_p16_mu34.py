# I73 (c), n = 12, p = 16: estimate min over 16-dim E_0 in so(12) of max over unit x in E_0 of
# mu_34(x) (sum of the 34 smallest eigenvalues of -ad_x^2), against 1/60 (p16_below_theta0).
# Approved open-ended screen, bounded at 45 minutes. A SCREEN: an upper estimate of the min, a
# lower estimate of each inner max; neither is a proof. Usage: /usr/bin/python3 <this> [log]
import sys, time, itertools, numpy as np
LOG = open(sys.argv[1] if len(sys.argv) > 1 else '/dev/stdout', 'a', buffering=1)
def log(*a): LOG.write(time.strftime('%H:%M:%S ') + ' '.join(str(x) for x in a) + '\n')
n, p, m = 12, 16, 34
pairs = list(itertools.combinations(range(n), 2)); N = len(pairs)
def phi(i, j):
    M = np.zeros((n, n)); M[j, i] = 1; M[i, j] = -1; return M
B = [phi(i, j) for i, j in pairs]
ip = lambda X, Y: 0.5 * np.sum(X * Y)
C = np.zeros((N, N, N))  # C[r,s,t] = <phi_r, [phi_t, phi_s]>
for t in range(N):
    for s in range(N):
        Z = B[t] @ B[s] - B[s] @ B[t]
        for r in range(N):
            C[r, s, t] = ip(B[r], Z)
def mu_and_grad(x):
    A = np.einsum('rst,t->rs', C, x)
    w, V = np.linalg.eigh(A.T @ A)
    Vs = V[:, :m]
    mu = w[:m].sum()
    AV = A @ Vs  # N x m
    g = 2 * np.einsum('rk,rst,sk->t', AV, C, Vs)
    return mu, g
rng = np.random.default_rng(int(time.time()) % 10**6)
def inner_max(Q, y0=None, starts=12, steps=40):
    best = (-1, None)
    inits = [rng.normal(size=p) for _ in range(starts)] + ([y0] if y0 is not None else [])
    for y in inits:
        y = y / np.linalg.norm(y); lr = 0.2
        mu, g = mu_and_grad(Q @ y)
        for _ in range(steps):
            gy = Q.T @ g; gy -= (gy @ y) * y
            y2 = y + lr * gy; y2 /= np.linalg.norm(y2)
            mu2, g2 = mu_and_grad(Q @ y2)
            if mu2 >= mu: y, mu, g = y2, mu2, g2; lr *= 1.2
            else: lr *= 0.5
            if lr < 1e-5: break
        if mu > best[0]: best = (mu, y)
    return best
def star_start():
    e = 0; U = [B[pairs.index((0, j))] for j in range(1, n)]
    S = np.array([[ip(B[r], u) for r in range(N)] for u in U]).T  # N x 11
    R = rng.normal(size=(N, p - 11))
    Q, _ = np.linalg.qr(np.hstack([S, R])); return Q
T_END = time.time() + 45 * 60
results = []
log(f'START pid {__import__("os").getpid()} plan: 10 restarts x <=200 outer steps, 45 min cap, target 1/60 = {1/60:.5f}')
for rs in range(10):
    if time.time() > T_END: break
    kind = 'star11+5' if rs % 5 in (3, 4) else 'random'
    Q = star_start() if kind != 'random' else np.linalg.qr(rng.normal(size=(N, p)))[0]
    F, y = inner_max(Q); lr = 0.05; hist = [F]
    for it in range(200):
        if time.time() > T_END: break
        mu, g = mu_and_grad(Q @ y)
        G = np.outer(g, y); G -= Q @ (Q.T @ G)          # Riemannian gradient on the Grassmannian
        Q2, _ = np.linalg.qr(Q - lr * G)
        F2, y2 = inner_max(Q2, y0=Q2.T @ (Q @ y), starts=6, steps=30)
        if F2 <= F: Q, F, y = Q2, F2, y2; lr *= 1.1
        else: lr *= 0.5
        hist.append(F)
        if it % 20 == 0: log(f'restart {rs} ({kind}) step {it} F={F:.5f} lr={lr:.3g}')
        if lr < 1e-4: break
    Ff, _ = inner_max(Q, y0=y, starts=40, steps=60)   # final, more thorough inner max
    results.append((Ff, kind)); log(f'restart {rs} ({kind}) DONE final max_x mu34 = {Ff:.5f}')
best = min(results)
log(f'DONE min over restarts of max_x mu34 = {best[0]:.5f} ({best[1]}); target 1/60 = {1/60:.5f}; all = ' + ', '.join(f'{f:.4f}' for f, _ in results))
