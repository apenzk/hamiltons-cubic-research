"""r258 claim 5 -- two witnesses against sentences in plan.md section 2 item 1.

W1  "pairing with e_I of DISTINCT entries needs no projector, e_I being
     traceless hence already in V_lambda."   -- the inference is invalid.
W2  "read the highest-weight coordinate inside V_lambda, WHICH EQUIVARIANCE PLUS
     POLARISATION MAKES TWO-SIDED"           -- true of all W, false of a sample.

Exact over Fraction throughout.  Weyl tensors come from r256's common.py, which
copies the carrier of the file the reviews were written against.
"""
import sys, os, itertools
from fractions import Fraction as F
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "r256"))
from common import weyl_exact, rank_exact, mat_WW
import random, pickle

# ===================== W1 =====================================================
print("W1  is a distinct-entry basis tensor e_I inside V_lambda?")
S4 = list(itertools.permutations(range(4)))
def sgn(p):
    s = 1
    for i in range(4):
        for j in range(i+1, 4):
            if p[i] > p[j]: s = -s
    return s
def cyc_type(p):
    seen, t = set(), []
    for i in range(4):
        if i in seen: continue
        l, j = 0, i
        while j not in seen:
            seen.add(j); j = p[j]; l += 1
        t.append(l)
    return tuple(sorted(t, reverse=True))
CHI = {                                   # S_4 character table, by cycle type
    (2, 2):        {(1,1,1,1): 2, (2,1,1): 0, (2,2): 2, (3,1): -1, (4,): 0},
    (1, 1, 1, 1):  {(1,1,1,1): 1, (2,1,1): -1, (2,2): 1, (3,1): 1, (4,): -1},
    (4,):          {(1,1,1,1): 1, (2,1,1): 1, (2,2): 1, (3,1): 1, (4,): 1},
}
DIMLAM = {(2, 2): 2, (1, 1, 1, 1): 1, (4,): 1}

n = 5
def zeros4(): return {}
def apply_perm(T, p):
    """(p.T)_{i0 i1 i2 i3} = T_{i_{p(0)} ...} -- index permutation."""
    out = {}
    for I, v in T.items():
        J = tuple(I[p[k]] for k in range(4))
        out[J] = out.get(J, F(0)) + v
    return out
def proj(T, lam):
    """central idempotent of S_4 acting on tensor slots: (dim/4!) sum chi(g) g.T"""
    c = F(DIMLAM[lam], 24)
    out = {}
    for p in S4:
        ch = CHI[lam][cyc_type(p)]
        if ch == 0: continue
        for J, v in apply_perm(T, p).items():
            out[J] = out.get(J, F(0)) + c*ch*v
    return {k: v for k, v in out.items() if v}

eI = {(0, 1, 2, 3): F(1)}
p22 = proj(eI, (2, 2))
print(f"  e_I = e_0 (x) e_1 (x) e_2 (x) e_3, distinct entries, traceless "
      f"(every g-contraction is 0 since the entries differ)")
print(f"  P_(2,2) e_I == e_I ?  {p22 == eI}   (support size {len(p22)})")
print("  => 'traceless hence already in V_lambda' is invalid: e_I is traceless")
print("     and is NOT fixed by the projector onto the (2,2) isotypic.")

# the consequence: a tensor the projector kills but the read sees
anti = {}
for p in S4:
    anti[tuple(p)] = F(sgn(p))
p22_anti = proj(anti, (2, 2))
val = anti[(0, 1, 2, 3)]
print(f"\n  T = the fully antisymmetric tensor on slots 0..3:")
print(f"     T_{{0123}} = {val} (a distinct-entry component, so the read sees it)")
print(f"     every trace of T vanishes, so T is traceless")
print(f"     P_(2,2) T = 0 ?  {p22_anti == {}}")
print("  So <T, e_I> = 1 while <P_(2,2) T, e_I> = 0: the distinct-entry read is")
print("  NOT a read of the projected object.  The read reports rank 1 for a pair")
print("  {0, T} whose images in V_(2,2) are equal -- r256's degree-3 hazard.")

M12 = pickle.load(open("scripts/runs/n12_sym3_blocks.pkl", "rb"))
size4 = {k: v for k, v in M12.items() if sum(abs(x) for x in k) == 4}
size2 = {k: v for k, v in M12.items() if sum(abs(x) for x in k) == 2}
print(f"\n  liveness at n=12.  blocks with |lambda| = 2: {size2}")
print(f"                     blocks with |lambda| = 4: {size4}")
print("  At |lambda| = 2 only (2) occurs, so a genuine covariant has no")
print("  antisymmetric part and the plan's sentence is accidentally harmless --")
print("  at exactly the size every refuted attempt used.  At |lambda| = 4 five")
print("  inequivalent shapes occur at once, so a raw covariant carries all five")
print("  and a distinct-entry read reads their sum.")

# ===================== W2 =====================================================
print("\n\nW2  is the highest-weight-coordinate read two-sided at a finite sample?")
n = 5
SAMPLES = [weyl_exact(n, random.Random(s)) for s in range(4)]

def matmul(A, B):
    return [[sum(A[i][k]*B[k][j] for k in range(n)) for j in range(n)] for i in range(n)]
def traceless(A):
    t = sum(A[i][i] for i in range(n))
    return [[A[i][j] - (F(t, n) if i == j else F(0)) for j in range(n)] for i in range(n)]
def scal(c, A): return [[c*A[i][j] for j in range(n)] for i in range(n)]
def addm(A, B): return [[A[i][j]+B[i][j] for j in range(n)] for i in range(n)]

FAM = []                      # s^a * traceless(X^k),  a = 0..2, k = 1..4
for W in SAMPLES:
    X = mat_WW(W, n)
    s = sum(W[a][b][c][d]**2 for a in range(n) for b in range(n)
            for c in range(n) for d in range(n))
    row = []
    P = [[F(1) if i == j else F(0) for j in range(n)] for i in range(n)]
    Xk = P
    powers = []
    for k in range(1, 5):
        Xk = matmul(Xk, X); powers.append(traceless(Xk))
    for a in range(3):
        for Y in powers:
            row.append(scal(s**a, Y))
    FAM.append(row)
D = len(FAM[0])
print(f"  family: s^a * traceless((W.W)^k), a=0..2, k=1..4  -- {D} covariants into V_(2)")

# independence as functions: all n^2 components of all samples
rows = []
for si in range(len(SAMPLES)):
    for i in range(n):
        for j in range(n):
            rows.append([FAM[si][c][i][j] for c in range(D)])
print(f"  rank over every component of every sample: {rank_exact(rows)} of {D}")

# the highest-weight coordinate of V_(2) for so(5): <F, u (x) u> with u = e_0 + i e_1
def hw_reads(Mt):
    """the two rational functionals making up the complex hw coordinate."""
    return [Mt[0][0] - Mt[1][1], 2*Mt[0][1]]
hw_rows = []
for si in range(len(SAMPLES)):
    for which in (0, 1):
        hw_rows.append([hw_reads(FAM[si][c])[which] for c in range(D)])
print(f"  the hw coordinate gives {len(hw_rows)} rational conditions "
      f"({len(SAMPLES)} samples x 2)")

# nullspace of the hw-read matrix
def nullspace(rows, ncol):
    M = [r[:] for r in rows]; piv = []; r = 0
    for c in range(ncol):
        pr = next((t for t in range(r, len(M)) if M[t][c] != 0), None)
        if pr is None: continue
        M[r], M[pr] = M[pr], M[r]; iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        piv.append(c); r += 1
    free = [c for c in range(ncol) if c not in piv]
    basis = []
    for fc in free:
        v = [F(0)]*ncol; v[fc] = F(1)
        for i, pc in enumerate(piv): v[pc] = -M[i][fc]
        basis.append(v)
    return basis
NS = nullspace(hw_rows, D)
print(f"  nullspace of the hw-read matrix: dimension {len(NS)}")
d = NS[0]
def combo(si, coeffs):
    out = [[F(0)]*n for _ in range(n)]
    for c in range(D):
        if coeffs[c]:
            out = addm(out, scal(coeffs[c], FAM[si][c]))
    return out
Dm = [combo(si, d) for si in range(len(SAMPLES))]
nzc = sum(1 for si in range(len(SAMPLES)) for i in range(n) for j in range(n) if Dm[si][i][j])
print(f"  D = the corresponding covariant: nonzero at {nzc} (sample, component) pairs")
print(f"  D's hw reads: {[hw_reads(Dm[si]) for si in range(len(SAMPLES))]}")

Y1 = [FAM[si][0] for si in range(len(SAMPLES))]            # traceless(W.W)
Y2 = [addm(Y1[si], Dm[si]) for si in range(len(SAMPLES))]
pair_hw = []
for si in range(len(SAMPLES)):
    for which in (0, 1):
        pair_hw.append([hw_reads(Y1[si])[which], hw_reads(Y2[si])[which]])
pair_all = []
for si in range(len(SAMPLES)):
    for i in range(n):
        for j in range(n):
            pair_all.append([Y1[si][i][j], Y2[si][i][j]])
print(f"\n  the pair (Y, Y+D), both nonzero covariants into V_(2):")
print(f"    rank at the HIGHEST-WEIGHT COORDINATE over the 4 samples: "
      f"{rank_exact(pair_hw)}")
print(f"    rank over every component of the same 4 samples:          "
      f"{rank_exact(pair_all)}")
print("  A two-sided read cannot return 1 for an independent pair.  The")
print("  two-sidedness r255 derived is 'vanishing on ALL W forces F = 0'; at a")
print("  finite sample the hw read is exactly as one-sided as a component read.")
