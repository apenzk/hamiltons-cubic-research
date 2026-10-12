"""r195: the checks run_n5_assemble.py declares but does not run, plus the
negative controls the record's own standard demands.

  C1  cross-weight entries of Q -- the ones the shipped loop never computes,
      because it iterates weight by weight (the same pattern reviewer 191 had
      already made falsifiable in run_n5_evaluate.py and which was not carried
      across).  Also: are the adapted vectors PURE weight vectors at all?
  C1b the same entries with the conjugate dropped from the Sym^3 COEFFICIENTS
      only.  This is a misdesigned control -- it keeps the Hermitian Gram H, and
      H is what carries the weight filter, so it returns 0 and shows nothing.
      The correct contrast is in bilinear_gram.py, which rebuilds the invariant
      BILINEAR Gram from the same tensors and finds it supported exactly on the
      pairs (mu, -mu).
  C2  widths against Freudenthal.
  C3  Schur across many probes (t,s), against the shipped single probe (0,0).
  C4  negative controls: random garbage, and 192's per-copy word list.
"""
import sys, os, time, random
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import common195 as K
from freudenthal_b2 import mults

t0 = time.time()
print(f"H: {len(K.HFULL)} nonzero of 1225; pairing distinct weights: "
      f"{sum(1 for (a,b) in K.HFULL if K.WT[a]!=K.WT[b])}", flush=True)

def shipped_h(copies):
    m = len(copies)
    q00 = K.ip3(copies[0][0], copies[0][0])
    row = [[K.cdiv(K.ip3(copies[i][0], copies[j][0]), q00) for j in range(m)]
           for i in range(m)]
    herm = all(row[i][j] == K.cconj(row[j][i]) for i in range(m) for j in range(m))
    ident = all(row[i][j] == (Fr(1 if i == j else 0), Fr(0))
                for i in range(m) for j in range(m))
    return row, herm, ident

def fmt(h):
    return "\n".join("      " + "  ".join(
        (f"{x[0]}" if x[1] == 0 else f"{x[0]}{'+' if x[1]>0 else '-'}{abs(x[1])}i")
        for x in r) for r in h)

def det(M):
    n = len(M)
    M = [r[:] for r in M]; d = (Fr(1), Fr(0))
    for c in range(n):
        p = next((r for r in range(c, n) if M[r][c] != K.ZC), None)
        if p is None: return K.ZC
        if p != c: M[c], M[p] = M[p], M[c]; d = (-d[0], -d[1])
        d = K.cmul(d, M[c][c])
        inv = K.cdiv((Fr(1), Fr(0)), M[c][c])
        for r in range(c+1, n):
            f = K.cmul(M[r][c], inv)
            for k in range(c, n): M[r][k] = K.csub(M[r][k], K.cmul(f, M[c][k]))
    return d

random.seed(195)
for LAM in [(2, 0), (2, 2), (3, 2), (4, 2)]:
    want = K.dimB2(LAM)
    copies, words = K.build(LAM, shared=True)
    m = len(copies)
    print(f"\n===== lambda={LAM}  dim {want}  copies {m}   [{time.time()-t0:.0f}s]",
          flush=True)

    # ---- C1a: pure weight vectors? ----
    impure = zeros = 0
    for c in copies:
        for v in c:
            if not v: zeros += 1; continue
            if len({K.mwt(i) for i in v}) != 1: impure += 1
    print(f"  C1a  zero vectors {zeros}; vectors carrying more than one weight "
          f"{impure}   (mwt(max(v)) is well defined iff both are 0)")

    c0 = copies[0]
    byw = {}
    for t, v in enumerate(c0): byw.setdefault(K.mwt(max(v)), []).append(t)
    ws = sorted(byw)

    # ---- C1b: the cross-weight entries the shipped Q loop never computes ----
    hb = bb = tested = 0
    negw = 0
    for wa in ws:
        for wb in ws:
            if wa == wb: continue
            a, b = byw[wa][0], byw[wb][0]
            tested += 1
            if K.ip3(c0[a], c0[b], conj=True) != K.ZC: hb += 1
    for wa in ws:
        nb = (-wa[0], -wa[1])
        if nb == wa or nb not in byw: continue
        negw += 1
        if K.ip3(c0[byw[wa][0]], c0[byw[nb][0]], conj=False) != K.ZC: bb += 1
    print(f"  C1b  HERMITIAN: cross-weight Q entries computed {tested}, nonzero {hb}"
          f"   (claim 1 needs 0)")
    print(f"       coefficient-conjugate dropped, H kept: (mu,-mu) entries {negw}, "
          f"nonzero {bb}  -- misdesigned, see bilinear_gram.py for the real contrast")

    # ---- C2: widths against Freudenthal ----
    fr = mults(LAM)
    agree = all(len(byw.get(w, [])) == fr.get(w, 0) for w in set(byw) | set(fr))
    print(f"  C2   weight widths match Freudenthal: {agree}; widest Q block "
          f"{max(len(v) for v in byw.values())} (Freudenthal max {max(fr.values())})")

    if m == 1: continue
    # ---- C3: Schur across probes ----
    h0, herm, ident = shipped_h(copies)
    print(f"  C3   h from the shipped probe (0,0):")
    print(fmt(h0))
    print(f"       shipped checks: Hermitian {herm}; not the identity {not ident}")
    mn = [det([r[:k] for r in h0[:k]]) for k in range(1, m+1)]
    print(f"       leading principal minors {[str(x[0]) if x[1]==0 else str(x) for x in mn]}"
          f"  -> positive definite {all(x[0] > 0 and x[1] == 0 for x in mn)}"
          f"   (never checked by the shipped code)")
    probes = list(range(min(want, 14)))
    bad = tot = 0; first = None
    for t in probes:
        for s in probes:
            if K.mwt(max(c0[t])) != K.mwt(max(c0[s])): continue
            qts = K.ip3(c0[t], c0[s])
            if qts == K.ZC: continue
            for i in range(m):
                for j in range(m):
                    tot += 1
                    got = K.cdiv(K.ip3(copies[i][t], copies[j][s]), qts)
                    if got != h0[i][j]:
                        bad += 1
                        if first is None: first = (t, s, i, j, got, h0[i][j])
    print(f"       Schur <R_i[t],R_j[s]> = h_ij Q_ts over t,s < {len(probes)}: "
          f"{tot} entries, DISAGREEING {bad}")
    if first: print(f"         first mismatch {first}")

    # ---- C4a: negative control, random vectors ----
    rv = []
    while len(rv) < m:
        v = {}
        for _ in range(5):
            v[random.randrange(len(K.MONO))] = (Fr(random.randint(-5, 5)),
                                                Fr(random.randint(-4, 4)))
        v = {k: c for k, c in v.items() if c != K.ZC}
        if v and K.ip3(v, v) != K.ZC: rv.append(v)
    q = K.ip3(rv[0], rv[0])
    hr = [[K.cdiv(K.ip3(rv[i], rv[j]), q) for j in range(m)] for i in range(m)]
    hh = all(hr[i][j] == K.cconj(hr[j][i]) for i in range(m) for j in range(m))
    ii = all(hr[i][j] == (Fr(1 if i == j else 0), Fr(0))
             for i in range(m) for j in range(m))
    print(f"  C4a  NEGATIVE CONTROL, random garbage vectors: 'h Hermitian' {hh}, "
          f"'h not the identity' {not ii}  -> shipped pair passes on garbage: {hh and not ii}")

    # ---- C4b: negative control, 192's per-copy word list ----
    if want <= 120:
        bcopies, blists = K.build(LAM, shared=False)
        same = sum(1 for L in blists if L == words)
        hb0, bherm, bident = shipped_h(bcopies)
        agreeh = (hb0 == h0)
        bb2 = bt2 = 0
        for t in probes:
            qtt = K.ip3(bcopies[0][t], bcopies[0][t])
            if qtt == K.ZC: continue
            for i in range(m):
                for j in range(m):
                    bt2 += 1
                    if K.cdiv(K.ip3(bcopies[i][t], bcopies[j][t]), qtt) != hb0[i][j]:
                        bb2 += 1
        print(f"  C4b  NEGATIVE CONTROL, 192's PER-COPY word lists "
              f"({len(blists)-same} of {len(blists)} differ from copy 1's):")
        print(f"       shipped (0,0) probe: Hermitian {bherm}, not identity {not bident}, "
              f"h IDENTICAL to the correct one: {agreeh}")
        print(f"       multi-probe Schur on the broken object: {bt2} entries, "
              f"DISAGREEING {bb2}")
print(f"\ndone [{time.time()-t0:.0f}s]")
