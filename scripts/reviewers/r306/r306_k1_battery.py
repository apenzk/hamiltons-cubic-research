"""K1 battery: scaled direct sums, 2-4 summands, unequal sizes, non-sphere summands."""
import sys, os, pickle, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R

pool = pickle.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pool.pkl'), 'rb'))


def direct_sum(Ms, mode='scaled'):
    ths = [R.theta_diag(M) for M in Ms]
    if mode == 'scaled':
        th = (sum(t ** -2 for t in ths)) ** -0.5
        cs = [th / t for t in ths]
    elif mode == 'equal':
        cs = [1.0 / np.sqrt(len(Ms))] * len(Ms)
        th = None
    N = sum(m.shape[0] for m in Ms)
    out = np.zeros((N, N)); o = 0
    for c, M in zip(cs, Ms):
        m = M.shape[0]; out[o:o + m, o:o + m] = c * M; o += m
    return out, ths, cs


def comp_labels(M, tol=1e-10):
    n = M.shape[0]; adj = np.abs(M) > tol; seen = -np.ones(n, int); c = 0
    for i in range(n):
        if seen[i] >= 0: continue
        st = [i]; seen[i] = c
        while st:
            v = st.pop()
            for w in range(n):
                if adj[v, w] and seen[w] < 0: seen[w] = c; st.append(w)
        c += 1
    return c, seen


def indicator_N(M, a_comp):
    """N_ij = 2 M_ij (a_i + a_j) with a constant on components."""
    c, lab = comp_labels(M)
    a = np.array([a_comp[lab[i]] for i in range(M.shape[0])])
    return 2 * M * (a[:, None] + a[None, :])


if __name__ == '__main__':
    names = list(pool)
    rows = []
    combos = []
    # every unordered pair, plus selected triples/quadruples
    for i, j in itertools.combinations(range(len(names)), 2):
        combos.append((names[i], names[j]))
    combos = [c for c in combos if sum(pool[k].shape[0] for k in c) <= 16]
    trip = [('S2xS2', 'S2xS3', 'S3xS3'), ('S2xS2', 'S2xS2', 'S2xS2'),
            ('sol_n6_th0.30861', 'S2xS3', 'S3xS4'), ('C5blowup2', 'S2xS2', 'S2xS3'),
            ('sol_n7_th0.09460', 'sol_n8_th0.16289', 'S2xS2'),
            ('S2xS2', 'S2xS3', 'S3xS3', 'S2xS4'),
            ('sol_n6_th0.64550', 'sol_n7_th0.46291', 'sol_n8_th0.55568', 'S2xS2')]
    combos += trip
    worst_crit = 0.0; worst_th = 0.0; worst_eig = 0.0; worst_adm = 0.0
    bad = []
    print(f'{"summands":54s} {"n":>3s} {"theta":>11s} {"pred":>11s} {"crit":>9s} {"eqcrit":>9s} {"L N/theta":>10s} {"<N,M>":>10s} {"lam_max":>9s}')
    for combo in combos:
        Ms = [pool[k] for k in combo]
        M, ths, cs = direct_sum(Ms, 'scaled')
        n = M.shape[0]
        th = R.theta_diag(M)
        pred = (sum(t ** -2 for t in ths)) ** -0.5
        crit = np.abs(R.crit_residual(M)).max()
        Meq, _, _ = direct_sum(Ms, 'equal')
        eqcrit = np.abs(R.crit_residual(Meq)).max()
        k, lab = comp_labels(M)
        # component-indicator with the record's stated normalisation sum a = 0
        a = np.zeros(k); a[0] = 1.0; a[1] = -1.0
        N = indicator_N(M, a)
        rowsum = np.abs(N.sum(1)).max()
        ratio = np.sum(N * R.Lcal(M, N)) / (th * np.sum(N * N))
        eigerr = np.abs(R.Lcal(M, N) - th * N).max() / max(np.abs(N).max(), 1e-30)
        inner = np.sum(N * M) / (np.linalg.norm(N) * np.linalg.norm(M))
        lam, _ = R.diag_lam_max(M, th)
        worst_crit = max(worst_crit, crit); worst_th = max(worst_th, abs(th - pred))
        worst_eig = max(worst_eig, eigerr); worst_adm = max(worst_adm, rowsum)
        if lam < 1 - 1e-9: bad.append((combo, lam))
        print(f'{"+".join(combo):54s} {n:3d} {th:11.9f} {pred:11.9f} {crit:9.1e} {eqcrit:9.1e} {ratio:10.7f} {inner:10.2e} {lam:9.6f}')
    print()
    print(f'worst criticality residual (scaled)   : {worst_crit:.2e}')
    print(f'worst |theta - (sum th^-2)^-1/2|      : {worst_th:.2e}')
    print(f'worst |L N - theta N| / max|N|        : {worst_eig:.2e}')
    print(f'worst row sum of the indicator N      : {worst_adm:.2e}')
    print(f'cases with diagonal lam_max < 1       : {len(bad)}')
    for b in bad: print('   ', b)
