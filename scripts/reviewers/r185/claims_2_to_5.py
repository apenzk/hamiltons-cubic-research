"""Reviewer 185, claims 2-5, exact over Q throughout."""
from fractions import Fraction as F
import importlib.util, sys, os, json, itertools, random
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs")
d = os.path.abspath(d)
def load(name):
    spec = importlib.util.spec_from_file_location(name[:-3], os.path.join(d, name))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    spec.loader.exec_module(m); sys.stdout = o
    return m
wm = load("run_n5_weyl_module.py")
N, NP, PAIRS, SPAIRS, BASIS = wm.N, wm.NP, wm.PAIRS, wm.SPAIRS, wm.BASIS

print("="*72); print("CLAIM 2  the cache round-trip and the support sizes"); print("="*72)
C = json.load(open(os.path.join(d, "n5_hw_cache.json")))
def fromjson(p): return (F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))
sizes = []
bad = 0
for key, v in C["hw"].items():
    for vec in v["vecs"]:
        s = 0
        for x in vec:
            re, im = fromjson(x)
            # round-trip fidelity: the JSON literally carries numerator/denominator
            # pairs, so the only way to lose a Gaussian rational is a float in there
            if not (isinstance(x[0][0], int) and isinstance(x[0][1], int)
                    and isinstance(x[1][0], int) and isinstance(x[1][1], int)):
                bad += 1
            if re or im: s += 1
        sizes.append(s)
print(f"  vectors {len(sizes)}, support min {min(sizes)}, max {max(sizes)}, "
      f"mean {sum(sizes)/len(sizes):.1f}")
print(f"  all <= 234: {max(sizes) <= 234}")
print(f"  entries stored as float rather than int num/den pairs: {bad}")
lens = {len(v['cols']) for v in C['hw'].values()}
print(f"  weight-space (column-block) sizes present: {sorted(lens)}; largest {max(lens)}")
print(f"  every vector's length equals its block's column count: "
      f"{all(len(x)==len(v['cols']) for v in C['hw'].values() for x in v['vecs'])}")
print(f"  denominators all nonzero: "
      f"{all(x[0][1]!=0 and x[1][1]!=0 for v in C['hw'].values() for vec in v['vecs'] for x in vec)}")
# does the SUPPORT SIZE claim survive an exact recount from the cache?  yes above.
# and is 'support 1' plausible?  the smallest weight spaces have 1 column.
one = [(k, len(v['cols'])) for k, v in C["hw"].items()
       for vec in v["vecs"] if sum(1 for x in vec if fromjson(x)[0] or fromjson(x)[1]) == 1]
print(f"  the support-1 vectors sit in blocks with column counts {sorted({c for _,c in one})}")

print(); print("="*72)
print("CLAIM 3  the extremiser: is the UNDOUBLED vector the same W_0?"); print("="*72)
ext = load("run_n5_extremiser.py")
S = ext.S
vec = [S[a][b] for (a, b) in SPAIRS]
# (i) the convention: sym2_to_R must reproduce a rank-4 tensor whose Lambda^2
#     operator matrix is exactly S.
R = wm.sym2_to_R({(a, b): S[a][b] for (a, b) in SPAIRS if S[a][b]})
back = [[F(0)]*NP for _ in range(NP)]
for a, (i, j) in enumerate(PAIRS):
    for b, (k, l) in enumerate(PAIRS):
        back[a][b] = R[i][j][k][l]
print(f"  sym2_to_R(vec) read back on Lambda^2 equals S entrywise: {back == S}")
print(f"    -> the undoubled coordinates ARE W_0, not 2S-diag(S)")
# the doubled vector, for contrast
dbl = [S[a][b]*(2 if a != b else 1) for (a, b) in SPAIRS]
Rd = wm.sym2_to_R({(a, b): dbl[k] for k, (a, b) in enumerate(SPAIRS) if dbl[k]})
backd = [[Rd[PAIRS[a][0]][PAIRS[a][1]][PAIRS[b][0]][PAIRS[b][1]]
          for b in range(NP)] for a in range(NP)]
print(f"  the doubled vector reads back as S: {backd == S} (it is 2S - diag(S))")
# (ii) membership: exactly in span(BASIS), not merely killed by the rows
rows = wm.bianchi_rows() + wm.ricci_rows()
resid = [sum(r[i]*vec[i] for i in range(len(vec))) for r in rows]
print(f"  Bianchi + Ric residual on the undoubled vector: {'all zero' if not any(resid) else 'NONZERO'}")
print(f"  Bianchi + Ric residual on the DOUBLED vector:   "
      f"{'all zero' if not any(sum(r[i]*dbl[i] for i in range(len(dbl))) for r in rows) else 'NONZERO'}"
      f"   <- if this is also zero the old test could not have failed")
# (iii) the spectrum/traces are computed from S itself
tr2 = sum(S[i][k]*S[k][i] for i in range(NP) for k in range(NP))
tr3 = sum(S[i][k]*S[k][l]*S[l][i] for i in range(NP) for k in range(NP) for l in range(NP))
print(f"  tr(S^2)={tr2}, tr(S^3)={tr3}: computed from the SAME S the vector is read from")

print(); print("="*72)
print("CLAIM 5  G_tensor = 4 G_operator, and CLAIM 4 the 2^k grading"); print("="*72)
TEN = [wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c}) for b in BASIS]
def op_of(b):
    R = wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(b) if c})
    return [[R[PAIRS[a][0]][PAIRS[a][1]][PAIRS[c][0]][PAIRS[c][1]] for c in range(NP)]
            for a in range(NP)]
OPS = [op_of(b) for b in BASIS]
def tdot(A, B):
    return sum(A[i][j][k][l]*B[i][j][k][l] for i in range(N) for j in range(N)
               for k in range(N) for l in range(N))
def odot(A, B):
    return sum(A[i][j]*B[i][j] for i in range(NP) for j in range(NP))
idx = [0, 1, 7, 17, 34]
ok = all(tdot(TEN[i], TEN[j]) == 4*odot(OPS[i], OPS[j]) for i in idx for j in idx)
print(f"  G_tensor(i,j) == 4 * G_operator(i,j) on a 5x5 sample of basis vectors: {ok}")
full = all(tdot(TEN[i], TEN[j]) == 4*odot(OPS[i], OPS[j])
           for i in range(0, 35, 3) for j in range(0, 35, 3))
print(f"  ... and on every 3rd index pair (144 pairs): {full}")
print("  PROOF: sym2_to_R sends the Sym^2 element S to R = sum_{a,b} S_ab f_a (x) f_b")
print("  with f_a = e_i (x) e_j - e_j (x) e_i, and <f_a, f_b>_tensor = 2 delta_ab,")
print("  so <R_A, R_B>_tensor = 4 tr(A B) = 4 <A, B>_operator.  Exact, all n.")

# the 2^k grading, on random Weyl tensors over Q
rng = random.Random(7)
def rand_weyl():
    c = [F(rng.randint(-4, 4)) for _ in range(35)]
    v = [sum(c[t]*BASIS[t][k] for t in range(35)) for k in range(len(SPAIRS))]
    return v
def flat_of(R):
    return [[R[i][j][k][l] for k in range(N) for l in range(N)]
            for i in range(N) for j in range(N)]
def mtr(M, k):
    n = len(M); X = [r[:] for r in M]
    for _ in range(k-1):
        X = [[sum(X[i][t]*M[t][j] for t in range(n) if X[i][t]) for j in range(n)]
             for i in range(n)]
    return sum(X[i][i] for i in range(n))
print()
for trial in range(3):
    v = rand_weyl()
    R = wm.sym2_to_R({SPAIRS[k]: c for k, c in enumerate(v) if c})
    A = [[R[PAIRS[a][0]][PAIRS[a][1]][PAIRS[c][0]][PAIRS[c][1]] for c in range(NP)]
         for a in range(NP)]
    M = flat_of(R)
    res = [(k, mtr(M, k) == 2**k * mtr(A, k)) for k in range(2, 7)]
    print(f"  random Weyl {trial}: tr(M^k) == 2^k tr(A^k) for k=2..6: "
          f"{[f'k={k}:{o}' for k, o in res]}")

print(); print("="*72)
print("CLAIM 3 addendum: what the DOUBLED object actually is, and why the"); 
print("Bianchi/Ric test could not have failed on either")
print("="*72)
diagS = [[S[i][j] if i == j else F(0) for j in range(NP)] for i in range(NP)]
twoSmd = [[2*S[i][j] - diagS[i][j] for j in range(NP)] for i in range(NP)]
print(f"  the doubled vector's Lambda^2 operator == 2S - diag(S): {backd == twoSmd}")
rd = [sum(r[i]*dbl[i] for i in range(len(dbl))) for r in rows]
rdg = [sum(r[i]*(S[a][b] if a == b else F(0)) for i, (a, b) in enumerate(SPAIRS))
       for r in rows]
print(f"  diag(S) alone is a Weyl tensor: {not any(rdg)}")
print(f"  hence 2S - diag(S) = S + (S - diag(S)) is one too, by linearity --")
print(f"  so the membership test passes for BOTH and cannot separate them.")
t2d = sum(twoSmd[i][k]*twoSmd[k][i] for i in range(NP) for k in range(NP))
t3d = sum(twoSmd[i][k]*twoSmd[k][l]*twoSmd[l][i]
          for i in range(NP) for k in range(NP) for l in range(NP))
print(f"  BUT the numbers differ: tr((2S-diag S)^2) = {t2d} vs tr(S^2) = {tr2};"
      f" tr(^3) = {t3d} vs {tr3}")
print(f"  so |W|^2 would read {F(t2d,6)} instead of 1 and tr(W^3) {F(t3d,6)}/sqrt6"
      f" instead of 1/sqrt6")
print("  DISCRIMINATING CHECK (absent from the script): read sym2_to_R(vec) back")
print("  on Lambda^2 and demand it equal S -- true for the undoubled vector,")
print("  false for the doubled one.")
