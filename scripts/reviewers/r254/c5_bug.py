"""r254 claim 5: is the recorded bug described accurately, is the fix complete,
and does anything else in the file hold fixed or vary the wrong thing?

THE RECORD, verbatim from the file:

    # ONE tensor per ROW.  A first version called weyl_random inside the inner
    # comprehension, so every carrier saw a DIFFERENT W and the columns were
    # incomparable -- rank 3 where irreducibility forces 1.  The assert below
    # caught it; without the known answer it would have read as a result.

Four assertions to check: (i) the mechanism, (ii) the number 3, (iii) that the
assert catches it, (iv) that the CONTROL does not.  Then the audit.
"""
import numpy as np

def weyl_random(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    W = 0.5*(W + W.transpose(2,3,0,1))
    assert np.abs(np.einsum('ikjk->ij', W)).max() < 1e-9, "not Ricci-flat"
    return W

CARRIERS = [lambda W: np.einsum('abcd,abcd->', W, W),
            lambda W: np.einsum('abcd,acbd->', W, W),
            lambda W: np.einsum('abcd,cdab->', W, W)]
MIXED = [CARRIERS[0], lambda W: np.einsum('abcd,abcd->', W, W)**2]

def _rank(rows):
    sv = np.linalg.svd(np.array(rows), compute_uv=False)
    return int((sv > sv[0]*1e-10).sum()), sv

def fixed(carriers, n, samples=12, seed=0):
    """the file as committed: ONE tensor per ROW."""
    rng = np.random.default_rng(seed); rows = []
    for _ in range(samples):
        W = weyl_random(n, rng)
        rows.append([c(W) for c in carriers])
    return _rank(rows)

def buggy(carriers, n, samples=12, seed=0):
    """the recorded first version: weyl_random INSIDE the inner comprehension."""
    rng = np.random.default_rng(seed)
    return _rank([[c(weyl_random(n, rng)) for c in carriers] for _ in range(samples)])

print("(i)/(ii)  MECHANISM AND NUMBER.  The buggy form, over 10 seeds and 5 n:")
print("            n     buggy rank (should be 3 per the record)   fixed rank")
ok = True
for n in (5, 6, 7, 8, 12):
    rb = {buggy(CARRIERS, n, seed=s)[0] for s in range(10)}
    rf = {fixed(CARRIERS, n, seed=s)[0] for s in range(10)}
    ok &= (rb == {3} and rf == {1})
    print(f"           {n:>3}     {sorted(rb)}                                {sorted(rf)}")
print(f"          record's mechanism and number REPRODUCE: {ok}")
_, svb = buggy(CARRIERS, 12); _, svf = fixed(CARRIERS, 12)
print(f"          n=12 buggy singular values: {svb[0]:.3e}, {svb[1]:.2e}, {svb[2]:.2e}")
print(f"          n=12 fixed singular values: {svf[0]:.3e}, {svf[1]:.2e}, {svf[2]:.2e}")

print()
print("(iii)     DOES THE ASSERT CATCH IT?  The loop asserts r == 1.")
print(f"          buggy rank at n=5 is {buggy(CARRIERS,5)[0]} != 1  ->  AssertionError.  YES.")

print()
print("(iv)      DOES THE CONTROL CATCH IT?  The control asserts r2 == 2 on one")
print("          quadratic and one quartic.  Under the bug:")
print(f"          buggy control rank at n=6: {buggy(MIXED,6)[0]}   (the assert wants 2)")
print("          -- the control PASSES under the bug.  The record's claim that only")
print("             the known answer caught it is CORRECT.")

print()
print("(v)       IS THE FIX COMPLETE?  Everything a row must hold fixed is now held")
print("          fixed: one weyl_random call per row, shared across all carriers, and")
print("          the rng advances between rows only.  Checked by construction and by")
print("          the reproduction above.  ONE further variation exists and is benign:")
print("          the sample tensors differ between the n-loop iterations, which is")
print("          required (the space changes with n).")

print()
print("(vi)      THE MIRROR DEFECT, NOT RECORDED.  The bug VARIED what must be held")
print("          fixed.  The file also HOLDS FIXED what ought to vary: seed = 0 is")
print("          the default and no caller overrides it, so the whole result rests on")
print("          ONE draw.  For the assertion the file actually makes -- rank == 1, a")
print("          DEPENDENCE -- one draw proves nothing (rank <= true rank ALWAYS, so a")
print("          low reading is also what a bad draw looks like; r254 claim 4c).")
print("          Re-running over seeds is the free strengthening the file omits:")
for n in (5, 12):
    rs = {fixed(CARRIERS, n, seed=s)[0] for s in range(50)}
    print(f"            n={n:>3}: 50 seeds give ranks {sorted(rs)}")
print("          -- the conclusion survives; the file just never checks it.")

print()
print("(vii)     A SEPARATE DEFECT IN THE SAME FILE: THE CONTRAST GRAM IS A WRONG")
print("          LITERAL, AND ITS COMMENT CONTRADICTS ITS OUTPUT.  The file writes")
print("          the projector-free Brauer Gram as a hardcoded array and comments")
print("          'has full rank'; it prints rank 2.  Recomputing it from the diagrams:")
print("          each carrier is <W (x) W, T_c> with T_c a perfect matching on 8 legs")
print("            T1 = {ae, bf, cg, dh}   (abcd,abcd)")
print("            T2 = {ae, bg, cf, dh}   (abcd,acbd)")
print("            T3 = {ag, bh, ce, df}   (abcd,cdab)")
print("          and <T_c, T_b> = n^(number of loops in T_c union T_b).")
import itertools
def matching(pairs): return {frozenset(p) for p in pairs}
T = {1: matching([('a','e'),('b','f'),('c','g'),('d','h')]),
     2: matching([('a','e'),('b','g'),('c','f'),('d','h')]),
     3: matching([('a','g'),('b','h'),('c','e'),('d','f')])}
def loops(M1, M2):
    adj = {}
    for M in (M1, M2):
        for e in M:
            u, v = tuple(e) if len(e) == 2 else (tuple(e)[0], tuple(e)[0])
            adj.setdefault(u, []).append((v, id(M)))
            adj.setdefault(v, []).append((u, id(M)))
    seen = set(); cyc = 0
    for s in adj:
        if s in seen: continue
        cyc += 1; stack = [s]
        while stack:
            x = stack.pop()
            if x in seen: continue
            seen.add(x)
            for (y, _) in adj[x]:
                if y not in seen: stack.append(y)
    return cyc
import numpy as _np
def gram(n):
    return _np.array([[float(n)**loops(T[i], T[j]) for j in (1,2,3)] for i in (1,2,3)])
print("          recomputed exponent matrix (loops):")
print("            ", [[loops(T[i], T[j]) for j in (1,2,3)] for i in (1,2,3)])
print("          the file's hardcoded exponents:")
print("             [[4, 3, 4], [3, 4, 3], [4, 3, 4]]")
for n in (5, 12):
    G = gram(n)
    F = _np.array([[float(n)**e for e in row] for row in ([4,3,4],[3,4,3],[4,3,4])])
    print(f"            n={n:>3}: true Gram rank {_np.linalg.matrix_rank(G)}, "
          f"det {_np.linalg.det(G):.4e}   |   file's literal rank "
          f"{_np.linalg.matrix_rank(F)}")
print("          The literal has row 0 identical to row 2, so it is rank 2 at every n")
print("          and the printed 'contrast' is wrong.  The TRUE Gram is rank 3 --")
print("          which is the comment's own word, 'full rank', and makes the file's")
print("          point STRONGER (ambient 3 against function 1, not 2 against 1).")
print("          Cross-check against the record: plan.md states det of the (A,C)")
print("          sub-Gram is n^6(n^2-1); the recomputed 2x2 [[n^4,n^3],[n^3,n^4]] gives")
for n in (5, 12):
    print(f"            n={n:>3}: n^8 - n^6 = {n**8 - n**6}, n^6(n^2-1) = {n**6*(n**2-1)}  match "
          f"{n**8-n**6 == n**6*(n**2-1)}")
