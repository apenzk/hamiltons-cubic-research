"""Reviewer 187, claim 1 part 2.  The rewritten Vandermonde elimination on
multi-index shapes with r >= 3 distinct tensors -- the regime the shipped tests
never enter (they use r = 1 and r = 2 only).

Three independent oracles per shape:
  (a) coeff_sym  -- the sum over the 6!/beta! distinct vertex placements of the
      object-dtype eval_polarised (a completely different code path);
  (b) permutation covariance -- relabelling the tensors and the multi-index
      together must leave the coefficient fixed.  This is what an index bug in
      the peeling loop breaks, and it is invisible at r <= 2 for symmetric shapes;
  (c) the partition identity -- sum over ALL beta with |beta| = 6 of the
      coefficients equals J(A_0 + ... + A_{r-1}).
"""
import sys, os, random, itertools, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, coeff, coeff_sym

P, K, N = 10007, 6, 5

SHAPES = {
    3: [(4,1,1), (3,2,1), (2,2,2), (1,2,3), (4,2,0), (0,3,3), (6,0,0), (1,1,4)],
    4: [(3,1,1,1), (2,2,1,1), (1,1,1,3), (2,1,2,1), (3,3,0,0), (0,2,2,2)],
    5: [(2,1,1,1,1), (1,1,1,1,2), (1,2,1,1,1)],
    6: [(1,1,1,1,1,1)],
}

def main():
    rng = np.random.default_rng(187); pyrng = random.Random(187)
    E = [WI.random_weyl(N, P, rng) for _ in range(6)]
    mats = [WI.random_matching(K, pyrng) for _ in range(3)]

    print("=" * 78)
    print("A. coeff vs the S6 symmetrisation, r = 3..6 distinct tensors")
    print("=" * 78)
    print(f"{'r':>2} {'beta':>16} {'matching':>8} {'coeff':>7} {'sym':>7} {'verdict':>8} {'placements':>11}")
    agree = total = 0
    for r, shapes in SHAPES.items():
        for beta in shapes:
            for mi, m in enumerate(mats):
                a = coeff(E[:r], list(beta), m, K, P)
                b = coeff_sym(E[:r], beta, m, K, P)
                nplace = 1
                num = 720
                den = 1
                for x in beta:
                    for y in range(2, x+1): den *= y
                nplace = num // den
                agree += (a == b); total += 1
                print(f"{r:>2} {str(beta):>16} {mi:>8} {a:>7} {b:>7} "
                      f"{'AGREE' if a==b else 'DISAGREE':>8} {nplace:>11}")
    print(f"\n  agreement: {agree}/{total}")

    print()
    print("=" * 78)
    print("B. permutation covariance -- the test that catches a peeling-index bug")
    print("=" * 78)
    ok = tot = 0
    bad = []
    for r, shapes in SHAPES.items():
        for beta in shapes:
            m = mats[0]
            base = coeff(E[:r], list(beta), m, K, P)
            for sigma in itertools.permutations(range(r)):
                permT = [E[sigma[i]] for i in range(r)]
                permB = [beta[sigma[i]] for i in range(r)]
                v = coeff(permT, permB, m, K, P)
                ok += (v == base); tot += 1
                if v != base: bad.append((r, beta, sigma, base, v))
    print(f"  invariant under all simultaneous relabellings: {ok}/{tot}")
    for b in bad[:10]: print("   MISMATCH", b)

    print()
    print("=" * 78)
    print("C. the full partition identity, r = 3 and r = 4 (all beta, not a slice)")
    print("=" * 78)
    for r in (3, 4):
        S = np.zeros_like(E[0])
        for i in range(r): S = (S + E[i]) % P
        for mi, m in enumerate(mats):
            tot_c = 0
            for beta in itertools.product(*[range(7)]*r):
                if sum(beta) != 6: continue
                tot_c = (tot_c + coeff(E[:r], list(beta), m, K, P)) % P
            tgt = WI.eval_diagram(S, m, K, P) % P
            print(f"  r={r} matching {mi}: sum over all beta = {tot_c:5d}, "
                  f"J(sum E) = {tgt:5d}  -> {'MATCH' if tot_c == tgt else 'MISMATCH'}")

if __name__ == "__main__":
    main()
