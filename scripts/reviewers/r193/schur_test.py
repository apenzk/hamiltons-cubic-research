"""Reviewer 193.  The Schur factorisation the abstract-vs-ambient reading rests on.

The reading in run_n5_evaluate.py step 4 and run_n5_assemble.py says: with
R_i[t] = phi_i(b_t), the ambient Gram of the replayed vectors factorises as

    < R_i[t], R_j[s] >_{Sym^3}  =  h_ij * Q_ts ,          (*)

h the multiplicity Gram, Q the abstract Gram of the word basis.  From (*) the
whole claim follows: reading Q off copy 1 costs the scalar h_11, and the ambient
Gram of the components y_i carries h as a HADAMARD factor, not a congruence.

(*) is a theorem (Schur), so this script tests the CODE against it.  Concretely:
for each pair of word positions (t,s) the m x m matrix < R_i[t], R_j[s] > must be
a fixed scalar multiple of the one at the highest weight.  A per-copy word list --
the failure this pipeline exists to prevent -- breaks it, and that is run as the
negative control.

Lowering operators are built here as the ADJOINTS of the cached raising operators
for the ambient Hermitian form, independent of the pipeline's own construction;
any scalar mis-normalisation cancels out of the proportionality test.
"""
import json, os, itertools, time, sys
from fractions import Fraction as F
from math import factorial

d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
WT = [tuple(w) for w in C["weights"]]
MONO = list(itertools.combinations_with_replacement(range(35), 3))
MIDX = {t: i for i, t in enumerate(MONO)}
T = C["wbasis_tensors"]
def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def csub(x, y): return (x[0] - y[0], x[1] - y[1])
def cconj(x):   return (x[0], -x[1])
def cdiv(x, y):
    den = y[0]*y[0] + y[1]*y[1]
    return ((x[0]*y[0] + x[1]*y[1])/den, (x[1]*y[0] - x[0]*y[1])/den)
ZC = (F(0), F(0)); ONEC = (F(1), F(0))
def q(p): return (F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))

t0 = time.time()
SP = []
for a in range(35):
    e = {}
    for i in range(5):
        for j in range(5):
            for k in range(5):
                for l in range(5):
                    v = q(T[a][i][j][k][l])
                    if v != ZC: e[(i, j, k, l)] = v
    SP.append(e)
H = {}
for a in range(35):
    for b in range(35):
        if WT[a] != WT[b]: continue
        re = im = F(0)
        for key, x in SP[a].items():
            y = SP[b].get(key)
            if y is None: continue
            re += x[0]*y[0] + x[1]*y[1]; im += x[1]*y[0] - x[0]*y[1]
        if (re, im) != ZC: H[(a, b)] = (re, im)
BYW = {}
for a in range(35): BYW.setdefault(WT[a], []).append(a)
print(f"H rebuilt, {len(H)} entries  [{time.time()-t0:.0f}s]", flush=True)

def sym3_ip(t, s):
    tot = ZC
    for perm in itertools.permutations(range(3)):
        term = ONEC; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

MW = {t: (WT[t[0]][0]+WT[t[1]][0]+WT[t[2]][0], WT[t[0]][1]+WT[t[1]][1]+WT[t[2]][1])
      for t in MONO}

def vip(u, v):
    """<u, v> for two Sym^3 vectors given as {monomial index: (re,im)}."""
    bw = {}
    for j, c in v.items(): bw.setdefault(MW[MONO[j]], []).append((j, c))
    tot = ZC
    for i, ci in u.items():
        for j, cj in bw.get(MW[MONO[i]], ()):
            ip = sym3_ip(MONO[i], MONO[j])
            if ip != ZC: tot = cadd(tot, cmul(cmul(ci, cconj(cj)), ip))
    return tot

# ---- lowering operators as adjoints of the cached raising operators -------
def adjoint(EC):
    """EC[x][t] = coeff of f_t in (e . f_x).  Return FC with the same layout for
    the adjoint operator e^dagger, which is the matching lowering operator up to
    a positive scalar."""
    ECq = [[q(EC[x][t]) for t in range(35)] for x in range(35)]
    FC = [[ZC]*35 for _ in range(35)]
    for y in range(35):
        # solve  sum_s H[x,s] u_s = (E H)[x,y]  over the weight block of x
        rhs = {}
        for x in range(35):
            acc = ZC
            for t in range(35):
                if ECq[x][t] != ZC and (t, y) in H:
                    acc = cadd(acc, cmul(ECq[x][t], H[(t, y)]))
            rhs[x] = acc
        for mu, idxs in BYW.items():
            n = len(idxs)
            M = [[H.get((idxs[r], idxs[c]), ZC) for c in range(n)] + [rhs[idxs[r]]]
                 for r in range(n)]
            for c in range(n):
                p = next((r for r in range(c, n) if M[r][c] != ZC), None)
                M[c], M[p] = M[p], M[c]
                inv = cdiv(ONEC, M[c][c]); M[c] = [cmul(inv, z) for z in M[c]]
                for r in range(n):
                    if r != c and M[r][c] != ZC:
                        f = M[r][c]
                        M[r] = [csub(z, cmul(f, yv)) for z, yv in zip(M[r], M[c])]
            for r, s in enumerate(idxs): FC[y][s] = cconj(M[r][n])
    return FC

F1C, F2C = adjoint(C["E1C"]), adjoint(C["E2C"])
def shift(FC):
    sh = set()
    for y in range(35):
        for s in range(35):
            if FC[y][s] != ZC: sh.add((WT[s][0]-WT[y][0], WT[s][1]-WT[y][1]))
    return sh
print(f"lowering ops built; weight shifts {shift(F1C)} and {shift(F2C)} "
      f"(each must be a single negative root)  [{time.time()-t0:.0f}s]", flush=True)
LOW = [F1C, F2C]

def lower(vec, EC):
    out = {}
    for idx, co in vec.items():
        a, b, c = MONO[idx]
        for pos, x in enumerate((a, b, c)):
            rest = [y for jj, y in enumerate((a, b, c)) if jj != pos]
            for t in range(35):
                if EC[x][t] != ZC:
                    j = MIDX[tuple(sorted(rest + [t]))]
                    out[j] = cadd(out.get(j, ZC), cmul(co, EC[x][t]))
    return {k: v for k, v in out.items() if v != ZC}

def replay(u, word):
    v = u
    for oi in word: v = lower(v, LOW[oi])
    return v

def gram(vs):
    n = len(vs)
    return [[vip(vs[i], vs[j]) for j in range(n)] for i in range(n)]

def proportional(A, B):
    """A == c * B for one scalar c?  return c or None."""
    c = None
    for i in range(len(A)):
        for j in range(len(A)):
            if B[i][j] == ZC:
                if A[i][j] != ZC: return None
                continue
            r = cdiv(A[i][j], B[i][j])
            if c is None: c = r
            elif r != c: return None
    return c

WORDS = [[], [0], [1], [1, 1], [1, 0], [0, 1]]
for name in ["2,2", "2,1", "3,2"]:
    blk = C["hw"][name]
    cols, vecs = blk["cols"], blk["vecs"]
    m = len(vecs)
    print(f"\n=== block lambda={name}, multiplicity {m}, weight space {len(cols)} ===", flush=True)
    U = [{cols[j]: q(v[j]) for j in range(len(cols)) if q(v[j]) != ZC} for v in vecs]
    R = {tuple(w): [replay(u, w) for u in U] for w in WORDS}
    N = gram(R[()])
    print(f"  N_ij = <u_i,u_j> (the multiplicity Gram, times |v|^2):", flush=True)
    for row in N: print("     ", [f"{x[0]}{'+' if x[1]>=0 else '-'}{abs(x[1])}i" for x in row])
    offdiag = any(N[i][j] != ZC for i in range(m) for j in range(m) if i != j)
    print(f"  h is NON-diagonal: {offdiag}   [{time.time()-t0:.0f}s]", flush=True)
    for w1 in WORDS:
        for w2 in WORDS:
            if w1 == [] and w2 == []: continue
            A = [[vip(R[tuple(w1)][i], R[tuple(w2)][j]) for j in range(m)] for i in range(m)]
            if all(x == ZC for r in A for x in r):
                print(f"  words {w1} x {w2}: vacuous -- the pairing is identically zero", flush=True)
                continue
            c = proportional(A, N)
            ok = f"PROPORTIONAL, factor {c[0]}{'+' if c[1]>=0 else '-'}{abs(c[1])}i" if c is not None else "*** BREAKS ***"
            nz = sum(1 for r in A for x in r if x != ZC)
            print(f"  words {w1} x {w2}: {ok}   ({nz} of {m*m} entries nonzero)"
                  f"   [{time.time()-t0:.0f}s]", flush=True)
    # negative control: give copy 2 its own word, as a per-copy list would
    if m >= 2:
        mixed = [R[(1,)][i] if i != 1 else R[(1, 1)][i] for i in range(m)]
        A = gram(mixed)
        c = proportional(A, N)
        print(f"  NEGATIVE CONTROL (copy 2 replayed with a different word): "
              f"{'proportional -- test is blind' if c is not None else 'BREAKS, as it must'}",
              flush=True)

# ---- the two readings are different cones, for the h measured above --------
print("\n=== Hadamard by h is not a congruence: an explicit witness ===", flush=True)
import fractions
blk = C["hw"]["2,2"]; cols, vecs = blk["cols"], blk["vecs"]
U = [{cols[j]: q(v[j]) for j in range(len(cols)) if q(v[j]) != ZC} for v in vecs]
N = gram(U); m = len(U)
def to_c(x): return complex(float(x[0]), float(x[1]))
import numpy as np
Nc = np.array([[to_c(N[i][j]) for j in range(m)] for i in range(m)])
print(f"  eigenvalues of h            : {np.round(np.linalg.eigvalsh(Nc), 3)}")
Rinv = 1.0 / Nc                                  # entrywise reciprocal of h
Rinv = (Rinv + Rinv.conj().T) / 2
ev = np.linalg.eigvalsh(Rinv)
print(f"  eigenvalues of h^(o-1)      : {np.round(ev/abs(ev).max(), 4)}")
print(f"  G = J (all ones) is PSD; its ambient-reading image G o h^(o-1) is "
      f"{'PSD' if ev.min() > -1e-12*abs(ev).max() else 'INDEFINITE -- the witness'}")
print("  so a certificate legal in the abstract reading is rejected by the h-inserted one;")
print("  the other direction is safe by the Schur product theorem, G o h PSD for G PSD.")
print(f"\n[{time.time()-t0:.0f}s]")
