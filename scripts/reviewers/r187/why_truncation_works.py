"""Reviewer 187.  WHY the truncated grid is legitimate -- and what invariant it
silently depends on.

The shipped coeff samples x_i only on 0..beta_i, yet J(sum x_k A_k) has degree 6
in every x_i.  Interpolating a degree-6 polynomial through beta_i+1 points does
NOT recover its degree-beta_i coefficient, so the extraction is wrong at every
pass but the last.  The claim is that the errors are harmless.  Proof, then two
falsifiable predictions of the proof, tested.

PROOF.  Write J(sum_k x_k A_k) = sum_{|gamma|=6} c_gamma x^gamma.  For a node set
S of size b+1 the map "leading coefficient of the interpolant through S" is the
divided difference [S], and for g of any degree
        [S] g = sum_{e >= b} h_{e-b}(S) * [x^e] g,
h_j the complete homogeneous symmetric polynomial in the nodes (h_0 = 1).
So pass i multiplies the wanted term by 1 and adds terms whose surviving
variables carry STRICTLY SMALLER total degree.  After passes 0..r-2 the running
value is
        c_beta * o_{r-1}^{beta_{r-1}}  +  (terms of degree < beta_{r-1}),
and the last pass has beta_{r-1}+1 nodes against a polynomial of degree exactly
beta_{r-1}, so it is an EXACT interpolation and returns c_beta.  QED.

PREDICTION 1: the answer does not depend on WHICH nodes are used, only on how
many.  Shifting every grid to 1..beta_i+1 must change nothing.
PREDICTION 2: correctness depends on the system being SQUARE (rows == columns).
Widening the grid while keeping beta_i+1 columns breaks the argument, because
the functional applied then varies from group to group.
"""
import sys, os, random, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, coeff, coeff_sym

P, K, N = 10007, 6, 5

def coeff_nodes(tensors, betas, matching, k, p, nodes_of, ncols_of=None, order=sorted):
    r = len(tensors)
    grids = [nodes_of(b) for b in betas]
    vals = {}
    for x in itertools.product(*grids):
        T = np.zeros_like(tensors[0])
        for i, xi in enumerate(x):
            if xi: T = (T + xi*tensors[i]) % p
        vals[x] = WI.eval_diagram(T % p, matching, k, p) % p
    cur = dict(vals)
    for i in range(r):
        n = (ncols_of(betas[i]) if ncols_of else betas[i]+1)
        nxt = {}
        for o in order({x[1:] for x in cur}):
            rows, rhs = [], []
            for x in cur:
                if x[1:] == o:
                    rows.append([pow(x[0], d, p) for d in range(n)]); rhs.append(cur[x])
            m_ = len(rows)
            M = [rows[t][:] + [rhs[t]] for t in range(m_)]
            piv, rr = [], 0
            for c in range(n):
                s = next((t for t in range(rr, m_) if M[t][c] % p), None)
                if s is None: continue
                M[rr], M[s] = M[s], M[rr]
                iv = pow(M[rr][c] % p, p-2, p)
                M[rr] = [(z*iv) % p for z in M[rr]]
                for t in range(m_):
                    if t != rr and M[t][c] % p:
                        f = M[t][c]; M[t] = [(z-f*w) % p for z, w in zip(M[t], M[rr])]
                piv.append(c); rr += 1
            sol = [0]*n
            for t, c in enumerate(piv): sol[c] = M[t][n] % p
            nxt[o] = sol[betas[i]]
        cur = nxt
    return list(cur.values())[0] % p

SHAPES = [(3,(4,1,1)), (3,(3,2,1)), (3,(2,2,2)), (3,(1,2,3)), (3,(1,1,4)),
          (4,(3,1,1,1)), (4,(2,2,1,1)), (4,(0,2,2,2)), (5,(2,1,1,1,1))]

def main():
    rng = np.random.default_rng(187); pyrng = random.Random(187)
    E = [WI.random_weyl(N, P, rng) for _ in range(6)]
    mats = [WI.random_matching(K, pyrng) for _ in range(2)]

    print("PREDICTION 1 -- node set is irrelevant, only its size")
    variants = {
        "0..b        (shipped)": lambda b: list(range(b+1)),
        "1..b+1      (shifted)": lambda b: list(range(1, b+2)),
        "b..0        (reversed)": lambda b: list(range(b, -1, -1)),
        "3,17,29,... (scattered)": lambda b: [3+13*j for j in range(b+1)],
    }
    for name, f in variants.items():
        ok = tot = 0
        for r, beta in SHAPES:
            for m in mats:
                ok += (coeff_nodes(E[:r], list(beta), m, K, P, f)
                       == coeff_sym(E[:r], beta, m, K, P)); tot += 1
        print(f"  {name:<24}: {ok}/{tot} agree with the S6 symmetrisation")

    print("\nPREDICTION 2 -- squareness is load-bearing, and it is UNDOCUMENTED")
    print("  widen every grid to 0..6 while keeping beta_i+1 columns.  The systems")
    print("  become over-determined and inconsistent; the answer then depends on")
    print("  which rows the elimination pivots on, i.e. on dict/set iteration order.")
    wide = lambda b: list(range(7))
    for oname, order in (("sorted group order", sorted), ("the shipped set order", list)):
        for label, shapes in (("r >= 3", SHAPES),
                              ("r <= 2", [(1,(6,)), (2,(2,4)), (2,(4,2)), (2,(3,3)),
                                          (2,(1,5)), (2,(5,1))])):
            ok = tot = 0
            for r, beta in shapes:
                for m in mats:
                    v = coeff_nodes(E[:r], list(beta), m, K, P, wide, lambda b: b+1, order)
                    ok += (v == coeff_sym(E[:r], beta, m, K, P)); tot += 1
            print(f"    {oname:<22} {label}: {ok}/{tot} agree")
    print("  => the widened variant passes at r <= 2 under EITHER ordering, so the")
    print("     shipped suite cannot see it, and breaks at r >= 3 under the ordering")
    print("     the shipped code actually uses.")

if __name__ == "__main__":
    main()
