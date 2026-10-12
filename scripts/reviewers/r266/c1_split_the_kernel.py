"""CLAIM 1 -- is the 10,393 kernel "exactly the non-symmetric complement"?

THE RECORD'S INFERENCE.  Remark I.2.2 (verified verbatim in the stored PDF) says
P_d o R_d is a projection onto the symmetric multilinear forms, hence
ker(R_d) = the non-symmetric complement, R_d injective on the symmetric part.
The record applies this to r260's measurement and concludes the 10,393 "was never
the difficulty".

THE STEP THAT IS MISSING.  r260 did not apply R_3 to the multilinear forms on
U^3, U = Weyl_n.  It applied the composite

    (V^{tensor 12})^*  --rho-->  (U (x) U (x) U)^*  --R_3-->  R[U]_3

where rho is RESTRICTION OF THE DOMAIN to the subspace U^{x3} of V^{tensor 12}.
Remark I.2.2 governs R_3 alone.  rho is a different map with a different kernel:
functionals that vanish identically on Weyl (x) Weyl (x) Weyl -- three INDEPENDENT
Weyl tensors, not one repeated -- and nothing about symmetry is involved in it.

So the true split is
    10393  =  (10395 - c)   +   (c - 2)
              ^^^^^^^^^^^       ^^^^^
              killed by rho     the non-symmetric complement
where c = rank of the gamma_D on THREE INDEPENDENT slots
        = dim of the O(n)-invariant multilinear forms on Weyl_n^3.

This file measures c, at the record's own cells.  If 10395 - c is large, the
record has attributed to Remark I.2.2 a kernel that Remark I.2.2 does not describe.
"""
import numpy as np, itertools, sys, time
rng = np.random.default_rng(266266)

def matchings(pts):
    if not pts:
        yield (); return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

LET = 'abcdefghijkl'

def rand_sym_traceless(n):
    S = rng.standard_normal((n, n)); S = S + S.T
    S -= np.trace(S) / n * np.eye(n)
    return S

def rand_weyl(n):
    """same construction as r260/c6_restriction.py -- Riemann symmetries, Bianchi, traceless."""
    T = rng.standard_normal((n, n, n, n))
    R = T - T.transpose(1,0,2,3) - T.transpose(0,1,3,2) + T.transpose(1,0,3,2)
    R = R + R.transpose(2,3,0,1)
    B = (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2)) / 3.0
    R = R - B
    g = np.eye(n)
    Ric = np.einsum('abad->bd', R); Sc = np.trace(Ric)
    kn = (np.einsum('ac,bd->abcd', g, Ric) - np.einsum('ad,bc->abcd', g, Ric)
          - np.einsum('bc,ad->abcd', g, Ric) + np.einsum('bd,ac->abcd', g, Ric))
    gg = np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
    return R - kn/(n-2) + Sc*gg/((n-1)*(n-2))

def ranks(legs, maker, n, nsamp):
    """returns (#diagrams, rank on 3 INDEPENDENT slots, rank on the DIAGONAL)."""
    tot = sum(legs)
    D = list(matchings(tuple(range(tot))))
    # batch the samples into the einsum: one einsum per diagram, all samples at once
    def build(diagonal):
        Ts = []
        for s in range(nsamp):
            X = maker(n)
            Ts.append([X]*len(legs) if diagonal else [maker(n) if i else X for i in range(len(legs))])
        stacks = [np.stack([Ts[s][j] for s in range(nsamp)]) for j in range(len(legs))]
        M = np.empty((len(D), nsamp))
        for i, m in enumerate(D):
            lab = [None]*tot
            for k, (a, b) in enumerate(m): lab[a] = lab[b] = LET[k]
            spec, pos = [], 0
            for L in legs:
                spec.append('s' + ''.join(lab[pos:pos+L])); pos += L
            M[i] = np.einsum(','.join(spec) + '->s', *stacks, optimize=True)
        return M
    Mi, Md = build(False), build(True)
    sc = lambda M: 1e-9 * max(1.0, abs(M).max())
    return len(D), np.linalg.matrix_rank(Mi, tol=sc(Mi)), np.linalg.matrix_rank(Md, tol=sc(Md))

def row(name, legs, maker, n, nsamp):
    t0 = time.time()
    tot, c, r = ranks(legs, maker, n, nsamp)
    print(f"  {name:>16} n={n:<3} diagrams {tot:<6} c=rank on 3 INDEP slots {c:<5} "
          f"rank on DIAGONAL {r:<4} [{time.time()-t0:.1f}s, {nsamp} samples]")
    print(f"       kernel {tot-r} splits as  ({tot} - {c}) = {tot-c} killed by RESTRICTION TO THE "
          f"SUBSPACE  +  ({c} - {r}) = {c-r} non-symmetric complement")
    print(f"       Remark I.2.2 accounts for {c-r} of {tot-r}"
          f"  =  {100.0*(c-r)/max(1,tot-r):.3f}%\n")
    sys.stdout.flush()
    return tot, c, r

print("(A) SYMMETRIC TRACELESS, 2 legs each, degree 3 -- r260's own warm-up cell\n")
for n in (3, 4, 5, 6, 12):
    row("sym traceless", (2,2,2), rand_sym_traceless, n, 40)

print("(B) WEYL, 4 legs each, degree 3 -- the cells the record actually cites\n")
for n in (6, 7):
    row("Weyl", (4,4,4), rand_weyl, n, 200)
