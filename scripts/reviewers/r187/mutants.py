"""Reviewer 187.  Could the r >= 3 checks have failed?  Six mutants of the
rewritten elimination -- each a bug someone would plausibly write -- run through
the same three oracles.  A check that no mutant defeats is a check with teeth;
a mutant that every oracle passes is a hole in the record.
"""
import sys, os, random, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, coeff, coeff_sym

P, K, N = 10007, 6, 5

def make_coeff(pick_beta, pick_axis, pick_sol, grid_cap=None):
    """Parametrised re-implementation of the shipped elimination.
    pick_beta(i, betas, depth) -> which beta indexes the Vandermonde at pass i
    pick_axis -> 'front' (shipped) or 'back'
    pick_sol(n, b) -> which solution component is taken as 'the' coefficient
    """
    def f(tensors, betas, matching, k, p):
        r = len(tensors)
        grids = [list(range(b+1 if grid_cap is None else grid_cap)) for b in betas]
        pts = list(itertools.product(*grids))
        vals = {}
        for x in pts:
            T = np.zeros_like(tensors[0])
            for i, xi in enumerate(x):
                if xi: T = (T + xi*tensors[i]) % p
            vals[x] = WI.eval_diagram(T % p, matching, k, p) % p
        cur = dict(vals)
        for i in range(r):
            b = pick_beta(i, betas, r)
            nxt = {}
            keys = {x[1:] if pick_axis == 'front' else x[:-1] for x in cur}
            for o in keys:
                rows, rhs = [], []
                for x in cur:
                    tail = x[1:] if pick_axis == 'front' else x[:-1]
                    head = x[0] if pick_axis == 'front' else x[-1]
                    if tail == o:
                        rows.append([pow(head, d, p) for d in range(b+1)])
                        rhs.append(cur[x])
                m_, n_ = len(rows), b+1
                M = [rows[t][:] + [rhs[t]] for t in range(m_)]
                piv, rr = [], 0
                for c in range(n_):
                    s = next((t for t in range(rr, m_) if M[t][c] % p), None)
                    if s is None: continue
                    M[rr], M[s] = M[s], M[rr]
                    iv = pow(M[rr][c] % p, p-2, p)
                    M[rr] = [(z*iv) % p for z in M[rr]]
                    for t in range(m_):
                        if t != rr and M[t][c] % p:
                            fct = M[t][c]
                            M[t] = [(z - fct*w) % p for z, w in zip(M[t], M[rr])]
                    piv.append(c); rr += 1
                sol = [0]*n_
                for t, c in enumerate(piv): sol[c] = M[t][n_] % p
                nxt[o] = sol[pick_sol(n_, b)]
            cur = nxt
        return list(cur.values())[0] % p
    return f

MUTANTS = {
    "M0 shipped (control)":  make_coeff(lambda i, b, r: b[i], 'front', lambda n, b: b),
    "M1 always betas[0]":    make_coeff(lambda i, b, r: b[0], 'front', lambda n, b: b),
    "M2 peel from the back, index betas[i]":
                             make_coeff(lambda i, b, r: b[i], 'back',  lambda n, b: b),
    "M3 reversed beta order":make_coeff(lambda i, b, r: b[r-1-i], 'front', lambda n, b: b),
    "M4 take sol[0]":        make_coeff(lambda i, b, r: b[i], 'front', lambda n, b: 0),
    "M5 grid always 0..6":   make_coeff(lambda i, b, r: b[i], 'front', lambda n, b: b, grid_cap=7),
    "M6 grid always 0..6, always betas[0]":
                             make_coeff(lambda i, b, r: b[0], 'front', lambda n, b: b, grid_cap=7),
}

SHAPES = [(3,(4,1,1)), (3,(3,2,1)), (3,(2,2,2)), (3,(1,2,3)), (3,(1,1,4)),
          (4,(3,1,1,1)), (4,(2,2,1,1)), (4,(1,1,1,3)), (4,(0,2,2,2))]
SHAPES2 = [(2,(2,4)), (2,(4,2)), (2,(3,3)), (1,(6,))]

def main():
    rng = np.random.default_rng(187); pyrng = random.Random(187)
    E = [WI.random_weyl(N, P, rng) for _ in range(6)]
    mats = [WI.random_matching(K, pyrng) for _ in range(2)]

    print("Detection rates.  'sym' = disagrees with the S6 symmetrisation;")
    print("'perm' = not invariant under simultaneous relabelling; 'r<=2' = the")
    print("shapes the SHIPPED tests actually reach.\n")
    print(f"{'mutant':<40} {'sym(r>=3)':>10} {'perm(r>=3)':>11} {'sym(r<=2)':>10}")
    print("-"*75)
    for name, f in MUTANTS.items():
        d_sym = n_sym = d_perm = n_perm = d_lo = n_lo = 0
        for r, beta in SHAPES:
            for m in mats:
                v = f(E[:r], list(beta), m, K, P)
                t = coeff_sym(E[:r], beta, m, K, P)
                d_sym += (v != t); n_sym += 1
            m = mats[0]
            base = f(E[:r], list(beta), m, K, P)
            for sg in itertools.permutations(range(r)):
                w = f([E[sg[i]] for i in range(r)], [beta[sg[i]] for i in range(r)], m, K, P)
                d_perm += (w != base); n_perm += 1
        for r, beta in SHAPES2:
            for m in mats:
                v = f(E[:r], list(beta), m, K, P)
                t = coeff_sym(E[:r], beta, m, K, P)
                d_lo += (v != t); n_lo += 1
        print(f"{name:<40} {d_sym:>4}/{n_sym:<5} {d_perm:>5}/{n_perm:<5} {d_lo:>4}/{n_lo:<5}")

if __name__ == "__main__":
    main()

# ---------------------------------------------------------------------------
def shipped_checks(f, E, mats):
    """Exactly the two validations run_n5_coefficient.py ships, applied to a
    mutant: (i) beta=(6) reproduces eval_diagram, (ii) sum_d coeff(d,6-d)=J(A+B).
    Returns (diag_pass, sum_pass) out of len(mats) each."""
    A, B = E[0], E[1]
    d_ok = s_ok = 0
    for m in mats:
        if f([A], [6], m, K, P) == WI.eval_diagram(A, m, K, P) % P: d_ok += 1
        tot = sum(f([A, B], [d, 6-d], m, K, P) for d in range(7)) % P
        if tot == WI.eval_diagram((A+B) % P, m, K, P) % P: s_ok += 1
    return d_ok, s_ok

def main2():
    rng = np.random.default_rng(187); pyrng = random.Random(187)
    E = [WI.random_weyl(N, P, rng) for _ in range(6)]
    mats = [WI.random_matching(K, pyrng) for _ in range(6)]
    print("\n\nWhat the SHIPPED validations do to the same mutants")
    print(f"{'mutant':<40} {'diag beta=(6)':>14} {'sum_d identity':>15}")
    print("-"*72)
    for name, f in MUTANTS.items():
        d, s = shipped_checks(f, E, mats)
        print(f"{name:<40} {d}/6 {'PASS' if d==6 else 'FAIL':>9} {s}/6 {'PASS' if s==6 else 'FAIL':>9}")
    # and the redistribution witness, which is not an implementation mutant
    A, B = E[0], E[1]
    d_ok = s_ok = 0
    for m in mats:
        c = [coeff([A, B], [dd, 6-dd], m, K, P) for dd in range(7)]
        c[2], c[4] = c[4], c[2]; c[1], c[5] = c[5], c[1]
        if sum(c) % P == WI.eval_diagram((A+B) % P, m, K, P) % P: s_ok += 1
        if coeff([A], [6], m, K, P) == WI.eval_diagram(A, m, K, P) % P: d_ok += 1
    print(f"{'W1 redistribution (swap 2<->4, 1<->5)':<40} {d_ok}/6 {'PASS':>9} {s_ok}/6 {'PASS' if s_ok==6 else 'FAIL':>9}")

if __name__ == "__main__":
    main2()
