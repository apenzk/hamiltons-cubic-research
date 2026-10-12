# I73 (c), n = 12, window 8 <= p <= 13 (generalised from screen_I73c_p15_mu36.py): estimate min over p-dim E_0 in so(12) WITH A_0 <= 11/2 I of max over unit
# x in E_0 of mu_m(x), m = 66 - 2p, against 2(7 - theta_0 sqrt(2p)), the L249 threshold. A_0 = -sum psi_a^2 over an orthonormal basis.
# Bounded screen: MINUTES minutes (argv 3), ten restarts. A SCREEN: an upper estimate of the min, a
# lower estimate of each inner max; neither is a proof. Usage: /usr/bin/python3 <this> log p minutes
import sys, time, itertools, numpy as np
LOG = open(sys.argv[1] if len(sys.argv) > 1 else '/dev/stdout', 'a', buffering=1)
def log(*a): LOG.write(time.strftime('%H:%M:%S ') + ' '.join(str(x) for x in a) + '\n')
n = 12; p = int(sys.argv[2]); m = 66 - 2 * p
CAP = 5.5; TARGET = 2 * (7 - np.sqrt(220 / 144) * np.sqrt(2 * p))
MINUTES = float(sys.argv[3])
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
def A0max(Q):
    A = np.zeros((n, n))
    for a in range(p):
        X = sum(Q[k, a] * B[k] for k in range(N)); A -= X @ X
    return np.linalg.eigvalsh(A)[-1]
def star_start(k):
    # a star piece e1 ^ span(e2..e_{k+1}) completed INSIDE so(11) on e2..e12 (no mass on e1),
    # so A_0 carries exactly k on e1 (r1196); k <= 5 meets the cap.
    U = [B[pairs.index((0, j))] for j in range(1, k + 1)]
    S = np.array([[ip(B[r], u) for r in range(N)] for u in U]).T
    inner = [r for r, (i, j) in enumerate(pairs) if i >= 1]      # so(11) on indices 1..11
    for _ in range(50):
        R = np.zeros((N, p - k)); R[inner, :] = rng.normal(size=(len(inner), p - k))
        Q, _ = np.linalg.qr(np.hstack([S, R]))
        if A0max(Q) <= CAP: return Q
    return None
T_END = time.time() + MINUTES * 60
results = []
log(f'START pid {__import__("os").getpid()} plan: 10 restarts x <=200 outer steps, {MINUTES} min cap, constraint lambda_max(A_0) <= {CAP}, target {TARGET}')
for rs in range(10):
    if time.time() > T_END: break
    kind = ['random', 'star5', 'star4', 'random', 'star5'][rs % 5]
    if kind == 'random':
        Q = np.linalg.qr(rng.normal(size=(N, p)))[0]
        while A0max(Q) > CAP: Q = np.linalg.qr(rng.normal(size=(N, p)))[0]
    else:
        Q = star_start(5 if kind == 'star5' else 4)
        if Q is None: log(f'restart {rs} ({kind}) no feasible start'); continue
    log(f'restart {rs} ({kind}) start lambda_max(A_0) = {A0max(Q):.3f}')
    F, y = inner_max(Q); lr = 0.05; hist = [F]
    for it in range(200):
        if time.time() > T_END: break
        mu, g = mu_and_grad(Q @ y)
        G = np.outer(g, y); G -= Q @ (Q.T @ G)          # Riemannian gradient on the Grassmannian
        Q2, _ = np.linalg.qr(Q - lr * G)
        if A0max(Q2) > CAP: lr *= 0.5; hist.append(F); continue
        F2, y2 = inner_max(Q2, y0=Q2.T @ (Q @ y), starts=6, steps=30)
        if F2 <= F: Q, F, y = Q2, F2, y2; lr *= 1.1
        else: lr *= 0.5
        hist.append(F)
        if it % 20 == 0: log(f'restart {rs} ({kind}) step {it} F={F:.5f} lr={lr:.3g}')
        if lr < 1e-4: break
    Ff, _ = inner_max(Q, y0=y, starts=40, steps=60)   # final, more thorough inner max
    results.append((Ff, kind)); log(f'restart {rs} ({kind}) DONE final max_x mu_m = {Ff:.5f}, lambda_max(A_0) = {A0max(Q):.3f}')
best = min(results)
log(f'DONE min over restarts of max_x mu_m = {best[0]:.5f} ({best[1]}); target {TARGET}; all = ' + ', '.join(f'{f:.4f}' for f, _ in results))
