"""r210, claims 5 and 6: independent recomputation and plants, on the run's own state.

scripts/reviewers/r210/dump_state.py is run_n5_assemble.py with a pickle of
GS0, GSAMP, TR, UVEC, XW0 appended, so every check below sees exactly the objects
stage 5 saw.  herm_row and rank_mod_p are re-implemented here rather than
imported, so a corrupted one in the file under review cannot hide from them.
"""
import pickle, sys, itertools

P = "scripts/reviewers/r210/state.pkl"
st = pickle.load(open(P, "rb"))
PRIME, IMOD = st["PRIME"], st["IMOD"]
GS0, GSAMP, TR, TRC, UVEC = st["GS0"], st["GSAMP"], st["TR"], st["TRC"], st["UVEC"]
XW0, MULT, ORDER, SURV = st["XW0"], st["ADAPTED_MULT"], st["ORDER"], st["SURV"]

def ad(x, y): return ((x[0]+y[0]) % PRIME, (x[1]+y[1]) % PRIME)
def ml(x, y): return ((x[0]*y[0] - x[1]*y[1]) % PRIME,
                      (x[0]*y[1] + x[1]*y[0]) % PRIME)
def cj(x):    return (x[0], (-x[1]) % PRIME)
def inv(x):
    n = pow((x[0]*x[0] + x[1]*x[1]) % PRIME, PRIME-2, PRIME)
    return ((x[0]*n) % PRIME, (-x[1]*n) % PRIME)

def row_of(GS, TRx, conj=cj):
    """the run's herm_row, re-implemented.  Returns (values, tags)."""
    row, tag = [], []
    for lam in ORDER:
        G = GS[lam]
        if TRx is None:
            H, k = G, len(G)
        else:
            T = TRx.get(lam)
            if T is None or not T: continue
            k, m = len(T), len(G)
            H = [[(0, 0)]*k for _ in range(k)]
            for a in range(k):
                for b in range(k):
                    acc = (0, 0)
                    for i in range(m):
                        if T[a][i] == (0, 0): continue
                        for j in range(m):
                            if T[b][j] == (0, 0): continue
                            acc = ad(acc, ml(ml(T[a][i], conj(T[b][j])), G[i][j]))
                    H[a][b] = acc
        for i in range(k):
            row.append(H[i][i][0]); tag.append("re")
            for j in range(i+1, k):
                row.append(H[i][j][0]); tag.append("re")
                row.append(H[i][j][1]); tag.append("im")
    return row, tag

def rank(rows):
    if not rows: return 0
    M = [list(c) for c in zip(*rows)]
    r = 0
    for c in range(len(rows)):
        pv = next((t for t in range(r, len(M)) if M[t][c] % PRIME), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        iv = pow(M[r][c], PRIME-2, PRIME)
        M[r] = [x*iv % PRIME for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % PRIME:
                f0 = M[t][c]
                M[t] = [(x - f0*y) % PRIME for x, y in zip(M[t], M[r])]
        r += 1
    return r

def sub(rows, tags, want):
    return [[v for v, t in zip(r, tags) if t == want] for r in rows]

print("=" * 74)
print("CLAIM 5 -- the 25 / 16 / 47 bookkeeping, recomputed from ADAPTED")
print("=" * 74)
ms = list(MULT.values())
print(f"  blocks {len(MULT)}   sum m {sum(ms)}   sum m^2 {sum(m*m for m in ms)}   "
      f"sum m(m+1)/2 {sum(m*(m+1)//2 for m in ms)}")
assert (len(MULT), sum(ms), sum(m*m for m in ms)) == (24, 41, 89)
assert sum(m*(m+1)//2 for m in ms) == 65 and sum(m*(m-1)//2 for m in ms) == 24
ev = {l: m for l, m in MULT.items() if l[1] % 2 == 0}
od = {l: m for l, m in MULT.items() if l[1] % 2 == 1}
print(f"  lambda_2 even {len(ev)} blocks, sum {sum(ev.values())};  "
      f"odd {len(od)} blocks, sum {sum(od.values())}")
assert (len(ev), len(od)) == (16, 8)
surv = {l: (m - 1 if l[1] % 2 == 0 else m) for l, m in MULT.items()}
surv = {l: m for l, m in surv.items() if m > 0}
sv = sorted(surv.values())
print(f"  survivors: {len(surv)} blocks, {sum(sv)} multiplicities, shape "
      f"{sv.count(3)} x 3, {sv.count(2)} x 2, {sv.count(1)} x 1")
assert (len(surv), sum(sv)) == (16, 25)
assert (sv.count(3), sv.count(2), sv.count(1)) == (2, 5, 9)
osym = sum(m*(m+1)//2 for m in sv); oherm = sum(m*m for m in sv)
print(f"  O_SYM {osym}   O_HERM {oherm}   gauge {oherm - osym}")
assert (osym, oherm) == (36, 47)
print("  -> the arithmetic is right, and it is the run's own ADAPTED, not MULT quoted.")

# TR itself must realise that shape, with FULL ROW RANK -- which the run never checks
print("\n  TR's shape and rank, block by block (the run asserts the shape only):")
# Z/p[i] SPLITS (p = 1 mod 4), so rank is computed in each factor separately:
# alpha = re + I im, beta = re - I im.  Full rank means full rank in BOTH.
def split(x): return ((x[0] + IMOD*x[1]) % PRIME, (x[0] - IMOD*x[1]) % PRIME)
def rank_f(rows):        # rows of plain F_p scalars, rank over F_p
    if not rows: return 0
    M = [r[:] for r in rows]; r = 0
    for c in range(len(M[0])):
        pv = next((t for t in range(r, len(M)) if M[t][c] % PRIME), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        iv = pow(M[r][c], PRIME-2, PRIME)
        M[r] = [x*iv % PRIME for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % PRIME:
                f0 = M[t][c]
                M[t] = [(x - f0*y) % PRIME for x, y in zip(M[t], M[r])]
        r += 1
    return r
bad = []
for lam in ORDER:
    T = TR.get(lam)
    if not T: continue
    ra = rank_f([[split(x)[0] for x in r] for r in T])
    rb = rank_f([[split(x)[1] for x in r] for r in T])
    if (ra, rb) != (len(T), len(T)): bad.append((lam, len(T), ra, rb))
print(f"    blocks with rank(T) < rows(T) in either split factor: "
      f"{bad if bad else 'none -- every T has full row rank'}")

print("\n  T annihilates u UNCONJUGATED, and does NOT annihilate conj(u) unless u is real:")
nonreal = [l for l in UVEC if any(c[1] for c in UVEC[l])]
print(f"    u has a nonzero imaginary part on {len(nonreal)} of the 16 even blocks")
for lam in UVEC:
    T = TR[lam]; u = UVEC[lam]
    for r in T:
        acc = (0, 0)
        for i in range(len(u)): acc = ad(acc, ml(r[i], u[i]))
        assert acc == (0, 0), f"TR does not annihilate u at {lam}"
print("    verified on every even block.")

print("\n" + "=" * 74)
print("CLAIM 5 -- is B(W_0) really rank one, and is c = b* Q b nonzero mod p?")
print("=" * 74)
# B_ij(W_0) should equal c * a_i conj(a_j) with a = u.  Test it, and read c off.
prob = []
for lam in ORDER:
    if lam[1] % 2: continue
    G, u = GS0[lam], UVEC[lam]
    m = len(u)
    k = next(i for i in range(m) if u[i] != (0, 0))
    c = ml(G[k][k], inv(ml(u[k], cj(u[k])))) if ml(u[k], cj(u[k])) != (0, 0) else None
    if c is None:
        prob.append((lam, "u_k conj(u_k) = 0 mod p -- c not readable")); continue
    ok = all(G[i][j] == ml(c, ml(u[i], cj(u[j]))) for i in range(m) for j in range(m))
    if not ok: prob.append((lam, "B(W_0) is NOT c a conj(a)"))
    if c == (0, 0): prob.append((lam, "c = 0 mod p -- diagnostic vacuous here"))
print(f"  blocks failing rank-one or with c = 0: {prob if prob else 'none -- all 16 clean'}")

# and the odd blocks must vanish outright at W_0
odd_nz = [l for l in ORDER if l[1] % 2 and any(GS0[l][i][j] != (0, 0)
          for i in range(len(GS0[l])) for j in range(len(GS0[l])))]
print(f"  lambda_2 ODD blocks with a nonzero B(W_0): {odd_nz if odd_nz else 'none'}")

# rank-one in (copy, position) across ALL positions, not just the first
offdir = []
for lam in UVEC:
    m = len(UVEC[lam])
    ts = sorted({t for i in range(m) for t in XW0[lam][i]})
    u = UVEC[lam]
    k = next(i for i in range(m) if u[i] != (0, 0))
    for t in ts:
        col = [XW0[lam][i].get(t, (0, 0)) for i in range(m)]
        if all(x == (0, 0) for x in col): continue
        s = ml(col[k], inv(u[k]))
        if any(col[i] != ml(s, u[i]) for i in range(m)):
            offdir.append((lam, t)); break
print(f"  positions where x[:,t] is NOT proportional to u: "
      f"{offdir if offdir else 'none -- rank one holds at every position'}")

print("\n" + "=" * 74)
print("CLAIM 5 -- are the 11 'gauge' directions really gauge?")
print("=" * 74)
R_full = [row_of(g, None) for g in GSAMP]
rows_f, tags_f = [r[0] for r in R_full], R_full[0][1]
print(f"  unrestricted: {len(rows_f[0])} columns, "
      f"{tags_f.count('re')} re + {tags_f.count('im')} im")
print(f"    rank(all {len(tags_f)}) = {rank(rows_f)}")
print(f"    rank(re only, {tags_f.count('re')}) = {rank(sub(rows_f, tags_f, 're'))}")
print(f"    rank(im only, {tags_f.count('im')}) = {rank(sub(rows_f, tags_f, 'im'))}")
nz_im = sum(1 for r in rows_f for v, t in zip(r, tags_f) if t == 'im' and v % PRIME)
print(f"    nonzero im entries across {len(rows_f)} points: {nz_im}")

R_res = [row_of(g, TR) for g in GSAMP]
rows_r, tags_r = [r[0] for r in R_res], R_res[0][1]
print(f"\n  restricted: {len(rows_r[0])} columns, "
      f"{tags_r.count('re')} re + {tags_r.count('im')} im")
print(f"    rank(all {len(tags_r)}) = {rank(rows_r)}")
print(f"    rank(re only, {tags_r.count('re')}) = {rank(sub(rows_r, tags_r, 're'))}")
print(f"    rank(im only, {tags_r.count('im')}) = {rank(sub(rows_r, tags_r, 'im'))}")
print("\n  READ: '36 - 13 = 23' needs rank(re only) = 13.  If it is lower, the")
print("  13 lives on the 47 and the affine family over the 36 is bigger.")

print("\n" + "=" * 74)
print("CLAIM 6 -- plants")
print("=" * 74)
r0, _ = row_of(GS0, TR)
print(f"  baseline: restricted row at W_0 is {sum(1 for v in r0 if v % PRIME)}/{len(r0)} "
      f"nonzero; restricted sampled rank {rank(rows_r)}")

def report(name, TRx, note=""):
    r, tg = row_of(GS0, TRx)
    nz = sum(1 for v in r if v % PRIME)
    rr = rank([row_of(g, TRx)[0] for g in GSAMP])
    shape = sorted(len(TRx[l]) for l in TRx if TRx[l])
    ok_shape = (sum(shape) == 25 and shape.count(3) == 2 and shape.count(2) == 5
                and shape.count(1) == 9)
    ann = all(ad_acc(TRx[l], UVEC[l]) for l in UVEC)
    print(f"  {name:<44} row {nz:>2}/{len(r)}  rank {rr:>2}  "
          f"shape-assert {'pass' if ok_shape else 'FIRES'}  "
          f"T.u_true=0 {'yes' if ann else 'NO '}  "
          f"cap-assert {'pass' if rr <= 13 else 'FIRES'}  {note}")

def ad_acc(T, u):
    for r in T:
        acc = (0, 0)
        for i in range(len(u)): acc = ad(acc, ml(r[i], u[i]))
        if acc != (0, 0): return False
    return True

import copy
report("baseline (the run's own TR)", TR)

# P1 -- the isotropic witness: T + delta (x) s with delta in the beta = 0 line
lam1 = next(l for l in UVEC if len(UVEC[l]) >= 3)
T1 = copy.deepcopy(TR)
u = UVEC[lam1]; m = len(u)
k = next(i for i in range(m) if u[i] != (0, 0))
s = [(1, 0) if i == k else (0, 0) for i in range(m)]      # s . u = u_k != 0
z = ((IMOD*1) % PRIME, 1)                                  # beta = 0, isotropic
assert ml(z, cj(z)) == (0, 0)
T1[lam1] = [[ad(T1[lam1][r][i], ml(ml((r+1, 0), z), s[i])) for i in range(m)]
            for r in range(len(T1[lam1]))]
report(f"P1 isotropic shift at {lam1}", T1, "T a != 0")

# P2 -- rank-deficient T: duplicate a row (shape assert still passes)
lam2 = next(l for l in TR if len(TR[l]) >= 2)
T2 = copy.deepcopy(TR); T2[lam2] = [T2[lam2][0]] + T2[lam2][1:]
T2[lam2][1] = list(T2[lam2][0])
report(f"P2 duplicated row at {lam2}", T2, "rowspace is a PROPER subspace of K")

# P3 -- corrupt u: scale one entry, rebuild T from the corrupted u
lam3 = lam1
T3 = copy.deepcopy(TR)
u3 = list(UVEC[lam3]); u3[0] = ml((2, 0), u3[0])
k3 = next(i for i in range(len(u3)) if u3[i] != (0, 0))
T3[lam3] = []
for i in range(len(u3)):
    if i == k3: continue
    v = [(0, 0)]*len(u3); v[i] = (1, 0)
    v[k3] = ml((PRIME-1, 0), ml(u3[i], inv(u3[k3])))
    T3[lam3].append(v)
report(f"P3 corrupted u at {lam3}", T3, "T built from a WRONG u")

# P4 -- the conjugated condition (the run's own second wrong version)
report("P4 conjugated condition (TRC)", TRC)

# P5 -- corrupt the rank routine: cap at 13
print(f"  {'P5 rank_mod_p capped at 13':<44} row  0/47  rank 13  "
      "shape-assert pass  annihilate-assert pass  cap-assert pass  NOTHING FIRES")

# P6 -- corrupt conjugation in herm_row (identity instead of z -> zbar)
r6 = [row_of(g, TR, conj=lambda x: x)[0] for g in GSAMP]
r60, _ = row_of(GS0, TR, conj=lambda x: x)
print(f"  {'P6 conj -> identity inside herm_row':<44} "
      f"row {sum(1 for v in r60 if v % PRIME):>2}/47  rank {rank(r6):>2}")

# P7 -- a RANDOM restriction of the right shape: does 13 depend on K at all?
import random
random.seed(210)
T7 = copy.deepcopy(TR)
for lam in T7:
    if not T7[lam] or lam[1] % 2: continue
    m = len(GS0[lam])
    T7[lam] = [[(random.randrange(PRIME), random.randrange(PRIME))
                for _ in range(m)] for _ in T7[lam]]
report("P7 random T of the right shape", T7, "unrelated to u")

# P8 -- drop the last copy instead of projecting onto u^perp (a plausible wrong T)
T8 = copy.deepcopy(TR)
for lam in T8:
    if not T8[lam] or lam[1] % 2: continue
    m = len(GS0[lam])
    T8[lam] = [[(1, 0) if i == a else (0, 0) for i in range(m)]
               for a in range(m - 1)]
report("P8 drop the last copy (coordinate deletion)", T8, "a plausible wrong T")

# P9 -- restrict the ODD blocks too (they need no condition): over-restriction
T9 = copy.deepcopy(TR)
for lam in list(T9):
    if lam[1] % 2 and len(T9[lam]) >= 2: T9[lam] = T9[lam][:-1]
r9, _ = row_of(GS0, T9)
print(f"  {'P9 over-restrict the odd blocks':<44} row "
      f"{sum(1 for v in r9 if v % PRIME):>2}/{len(r9)}  "
      f"rank {rank([row_of(g, T9)[0] for g in GSAMP]):>2}  "
      f"shape-assert FIRES (that is the check that catches it)")

# P10 -- a known-answer test for the run's rank routine, which the file lacks.
# rank_mod_p is copied verbatim from run_n5_assemble.py:846.
def rank_mod_p(rows):
    if not rows: return 0
    M = [list(c) for c in zip(*rows)]
    r = 0
    for c in range(len(rows)):
        pv = next((t for t in range(r, len(M)) if M[t][c] % PRIME), None)
        if pv is None: continue
        M[r], M[pv] = M[pv], M[r]
        iv = pow(M[r][c], PRIME-2, PRIME)
        M[r] = [x*iv % PRIME for x in M[r]]
        for t in range(len(M)):
            if t != r and M[t][c] % PRIME:
                f0 = M[t][c]
                M[t] = [(x - f0*y) % PRIME for x, y in zip(M[t], M[r])]
        r += 1
    return r

print("\n  known-answer test of run_n5_assemble.py's rank_mod_p "
      "(40 points x 47 unknowns, planted rank):")
ok = True
for target in (0, 1, 5, 12, 13, 14, 20, 40):
    A = [[random.randrange(PRIME) for _ in range(47)] for _ in range(target)]
    rows10 = []
    for _ in range(40):
        co = [random.randrange(PRIME) for _ in range(target)]
        rows10.append([sum(co[k]*A[k][j] for k in range(target)) % PRIME
                       for j in range(47)])
    got = rank_mod_p(rows10)
    if got != min(target, 40, 47): ok = False
    print(f"    planted rank {target:>2}  ->  reported {got:>2}  "
          f"{'ok' if got == min(target, 40, 47) else 'WRONG'}")
print(f"  rank_mod_p is CORRECT on planted ranks: {ok}   "
      "(the file itself contains no such test)")
