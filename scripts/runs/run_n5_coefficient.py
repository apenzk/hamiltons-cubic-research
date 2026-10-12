"""J_b's coefficient on a monomial, by interpolation -- the apolarity pairing's
real core, replacing the vertex-ordered map whose coefficient claim was false.

A monomial names an UNORDERED multiset of six basis tensors, so the coefficient
is the S6-symmetrisation.  Reviewer 185's route gets it far cheaper than
symmetrising: the coefficient of prod x_k^{beta_k} in J(sum_k x_k A_k) needs
prod(beta_k + 1) <= 64 evaluations of the CHEAP eval_diagram, against
6!/beta! <= 720 calls to an object-dtype polarised map.  It also reuses
machinery three reviewers have already audited.

Held to this record's standard: every check below is accompanied by a case that
makes it fail, because six reviewers found that a check which cannot fail is
the failure mode this programme actually suffers from.
"""
import sys, os, itertools, numpy as np, random
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "reviewers", "r179"))
import weyl_invariants as WI

def coeff(tensors, betas, matching, k, p):
    """coefficient of prod x_i^{betas[i]} in J(sum_i x_i * tensors[i]), over F_p.

    Solved as a product Vandermonde system on the grid x_i in 0..betas[i].

    INVARIANT, and it is load-bearing: the grid must be SQUARE, exactly
    betas[i] + 1 nodes in coordinate i.  The elimination is a divided
    difference -- pass i multiplies the wanted term by 1 and leaves pollution
    whose surviving variables carry strictly lower degree -- and the argument
    needs sum(d_i) = 6 = sum(betas) with d_i >= betas[i] to force d = beta.
    Widening any grid breaks r >= 3 silently while passing every shipped check
    (reviewer 187, mutant M5: 18/18 wrong, both checks PASS).  The node VALUES
    are irrelevant; the count is not.
    """
    r = len(tensors)
    grids = [list(range(b+1)) for b in betas]
    pts = list(itertools.product(*grids))
    vals = {}
    for x in pts:
        T = np.zeros_like(tensors[0])
        for i, xi in enumerate(x):
            if xi: T = (T + xi*tensors[i]) % p
        vals[x] = WI.eval_diagram(T % p, matching, k, p) % p
    # invert one variable at a time
    # Always eliminate position 0 of the CURRENT keys: each pass drops one
    # coordinate, so indexing by the original i goes out of range.
    cur = dict(vals)
    for i in range(r):
        nxt = {}
        for o in {x[1:] for x in cur}:
            rows, rhs = [], []
            for x in cur:
                if x[1:] == o:
                    rows.append([pow(x[0], d, p) for d in range(betas[i]+1)])
                    rhs.append(cur[x])
            # solve rows * c = rhs over F_p, take c[betas[i]]
            m = len(rows); n = betas[i]+1
            M = [rows[t][:] + [rhs[t]] for t in range(m)]
            piv, rr = [], 0
            for c in range(n):
                s = next((t for t in range(rr, m) if M[t][c] % p), None)
                if s is None: continue
                M[rr], M[s] = M[s], M[rr]
                inv = pow(M[rr][c] % p, p-2, p)
                M[rr] = [(z*inv) % p for z in M[rr]]
                for t in range(m):
                    if t != rr and M[t][c] % p:
                        f = M[t][c]
                        M[t] = [(z - f*w) % p for z, w in zip(M[t], M[rr])]
                piv.append(c); rr += 1
            sol = [0]*n
            for t, c in enumerate(piv): sol[c] = M[t][n] % p
            nxt[o] = sol[betas[i]]
        cur = nxt
    return list(cur.values())[0] % p

if __name__ == "__main__":
    N, P, K = 5, 10007, 6
    rng = np.random.default_rng(11); pyrng = random.Random(11)
    A = WI.random_weyl(N, P, rng); B = WI.random_weyl(N, P, rng)

    print("=== the diagonal must reproduce eval_diagram ===")
    ok = 0
    for _ in range(6):
        m = WI.random_matching(K, pyrng)
        c = coeff([A], [6], m, K, P)
        if c == WI.eval_diagram(A, m, K, P) % P: ok += 1
    print(f"  beta = (6): {ok}/6")

    print("\n=== mixed multi-indices against the binomial expansion ===")
    # J(A+B) = sum_d C(6,d)-weighted terms; sum over d of coeff must reproduce it
    ok = 0
    for _ in range(6):
        m = WI.random_matching(K, pyrng)
        tot = sum(coeff([A, B], [d, 6-d], m, K, P) for d in range(7)) % P
        if tot == WI.eval_diagram((A+B) % P, m, K, P) % P: ok += 1
    print(f"  sum_d coeff(d, 6-d) = J(A+B): {ok}/6   <- but this tests only the SUM")

    # Reviewer 188: two witnesses pass the plain sum -- reversing the multi-index,
    # and moving mass between coeff(2,4) and coeff(4,2).  The WEIGHTED identity
    # kills both and extends to r > 2, because it pins each beta separately.
    # ONE weighted identity is ONE linear condition on the seven coefficients,
    # so a redistribution orthogonal to that single weight vector passes it --
    # reviewer 187 built such a witness against the (3,5) version of this test.
    # Seven independent weight pairs give a full-rank Vandermonde and pin every
    # coefficient, which is the only version that means anything.
    SPTS = [(1, 1), (1, 2), (2, 1), (3, 5), (5, 3), (7, 2), (2, 7), (11, 4)]
    okw = 0
    for _ in range(6):
        m = WI.random_matching(K, pyrng)
        c = [coeff([A, B], [d, 6-d], m, K, P) for d in range(7)]
        good = all(sum(c[d]*pow(s1, d, P)*pow(s2, 6-d, P) for d in range(7)) % P
                   == WI.eval_diagram((s1*A + s2*B) % P, m, K, P) % P
                   for s1, s2 in SPTS)
        if good: okw += 1
    print(f"  WEIGHTED at {len(SPTS)} points: {okw}/6   <- full-rank Vandermonde")

    print("\n=== teeth for the weighted test: a redistribution must fail it ===")
    bad = 0
    for _ in range(6):
        m = WI.random_matching(K, pyrng)
        c = [coeff([A, B], [d, 6-d], m, K, P) for d in range(7)]
        c2 = c[:]; c2[2] = (c2[2] + 1234) % P; c2[4] = (c2[4] - 1234) % P
        fails = any(sum(c2[d]*pow(s1, d, P)*pow(s2, 6-d, P) for d in range(7)) % P
                    != WI.eval_diagram((s1*A + s2*B) % P, m, K, P) % P
                    for s1, s2 in SPTS)
        if fails: bad += 1
    print(f"  moving 1234 between c_2 and c_4 fails it: {bad}/6"
          f"   <- the witness shape that beat the single-point version")

    # Reviewer 187's actual witness, which passes BOTH earlier versions of this
    # test.  Kept verbatim: a check is worth what it rejects, and this is the
    # published attack against it.
    DELTA = [2002, 8004, 1, 0, 0, 0, 0]
    bp = bo = be = 0
    for _ in range(5):
        m = WI.random_matching(K, pyrng)
        c = [coeff([A, B], [d, 6-d], m, K, P) for d in range(7)]
        c2 = [(c[d] + DELTA[d]) % P for d in range(7)]
        truth = lambda s1, s2: WI.eval_diagram((s1*A + s2*B) % P, m, K, P) % P
        if sum(c2) % P == truth(1, 1): bp += 1
        if sum(c2[d]*pow(3, d, P)*pow(5, 6-d, P) for d in range(7)) % P == truth(3, 5):
            bo += 1
        if all(sum(c2[d]*pow(s1, d, P)*pow(s2, 6-d, P) for d in range(7)) % P
               == truth(s1, s2) for s1, s2 in SPTS): be += 1
    print(f"\n  reviewer 187's witness {DELTA}:")
    print(f"    passes the plain sum:        {bp}/5")
    print(f"    passes the single point:     {bo}/5")
    print(f"    passes the eight-point test: {be}/5   <- must be 0")

    print("\n=== teeth: a WRONG coefficient rule must break the same identity ===")
    bad = 0
    for _ in range(6):
        m = WI.random_matching(K, pyrng)
        # the refuted rule: one vertex ordering, no symmetrisation
        import importlib.util
        spec = importlib.util.spec_from_file_location(
            "pol", os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "run_n5_polarised_diagram.py"))
        pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)
        tot = sum(pol.eval_polarised([A]*d + [B]*(6-d), m, P) for d in range(7)) % P
        if tot != WI.eval_diagram((A+B) % P, m, K, P) % P: bad += 1
    print(f"  the vertex-ordered map fails it: {bad}/6   <- the check has teeth")
