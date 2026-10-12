"""r212, claims 4 and 5, EXACTLY over Q.

Claim 4: exhibit a rational y with S = A^T y positive definite in the true block
layout.  Then <S, x> = <y, A x> = 0 for every x in ker A, while a positive
definite form pairs strictly positively with every nonzero psd matrix.  So ker A
meets the psd cone only at 0, the psd part of the affine family is compact, and
the least eigenvalue over the family is bounded.  That refutes reading the
solver's "unbounded" as feasibility plus a psd kernel direction.

Claim 5: a RATIONAL point of the affine family, verified psd by run_n5_sdp.py's
own ldl_psd, with no floating point in the verification.
"""
import os, sys, pickle, importlib.util
from fractions import Fraction as Fr
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
RUNS = os.path.abspath(os.path.join(HERE, "..", "..", "runs"))
_sp = importlib.util.spec_from_file_location("n5sdp", os.path.join(RUNS, "run_n5_sdp.py"))
_m = importlib.util.module_from_spec(_sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w")
try: _sp.loader.exec_module(_m)
finally: sys.stdout = _o
ldl_psd = _m.ldl_psd

D = pickle.load(open(os.path.join(HERE, "exact_rows.pkl"), "rb"))
A, B = D["A"], D["B"]
NR, NC = len(A), len(A[0])
ADAPTED = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
Mm = {l: len(c) for l, c in ADAPTED.items()}
live = dict(zip(D["blocks"], D["shape"]))
TRUE = [l for l in sorted(ADAPTED, key=lambda l: (-Mm[l], l)) if l in live]
USED = list(D["blocks"])
SH = {"true": [live[l] for l in TRUE], "used": [live[l] for l in USED]}

# ---- the real symmetric 2k x 2k basis matrix each coordinate contributes ----
def basis(SHAPE):
    """E[c] = (block index, 2k x 2k real symmetric matrix), for c = 0..46"""
    out, c = [], 0
    for bi, k in enumerate(SHAPE):
        def M():
            return np.zeros((2*k, 2*k))
        for i in range(k):
            E = M(); E[i, i] = 1.0; E[k+i, k+i] = 1.0
            out.append((bi, E)); c += 1
            for j in range(i+1, k):
                E = M()                             # real part of H_ij
                E[i, j] = E[j, i] = 1.0; E[k+i, k+j] = E[k+j, k+i] = 1.0
                out.append((bi, E)); c += 1
                E = M()                             # imaginary part of H_ij
                E[i, k+j] = E[k+j, i] = -1.0
                E[j, k+i] = E[k+i, j] = 1.0
                out.append((bi, E)); c += 1
    assert c == NC, c
    return out

def unpack_exact(v, SHAPE):
    """47 rationals -> the 2k x 2k realified rational blocks"""
    out, c = [], 0
    for k in SHAPE:
        Mx = [[Fr(0)]*(2*k) for _ in range(2*k)]
        for i in range(k):
            Mx[i][i] = Fr(v[c]); Mx[k+i][k+i] = Fr(v[c]); c += 1
            for j in range(i+1, k):
                r = Fr(v[c]); c += 1
                Mx[i][j] = Mx[j][i] = r; Mx[k+i][k+j] = Mx[k+j][k+i] = r
                im = Fr(v[c]); c += 1
                Mx[i][k+j] = Mx[k+j][i] = -im
                Mx[j][k+i] = Mx[k+i][j] = im
        out.append(Mx)
    assert c == len(v)
    return out

def check_psd(v, SHAPE, label):
    ok_all, strict_all, worst = True, True, None
    for Mx, k in zip(unpack_exact(v, SHAPE), SHAPE):
        good, Dg = ldl_psd(Mx)
        if not good: ok_all = False
        if not (good and len(Dg) == 2*k and all(x > 0 for x in Dg)):
            strict_all = False
        if Dg:
            mn = min(Dg)
            worst = mn if worst is None else min(worst, mn)
    print(f"    {label}: psd on every block = {ok_all}, positive DEFINITE = "
          f"{strict_all}, smallest LDL pivot = "
          f"{float(worst) if worst is not None else None:.4e}")
    return ok_all, strict_all

Af = np.array([[float(x) for x in r] for r in A])
Bf = np.array([float(x) for x in B])
rn = np.linalg.norm(Af, axis=1)

# =============== claim 4 ===============
import cvxpy as cp
def claim4(mode):
    SHAPE = SH[mode]; E = basis(SHAPE)
    y = cp.Variable(NR)
    v = (Af / rn[:, None]).T @ y            # row scaling: same row space
    t = cp.Variable()
    nb = len(SHAPE)
    exprs = [0]*nb
    for c, (bi, Em) in enumerate(E):
        exprs[bi] = exprs[bi] + v[c]*Em
    cons = [exprs[bi] - t*np.eye(2*SHAPE[bi]) >> 0 for bi in range(nb)]
    cons += [cp.norm(y, "inf") <= 1]
    p = cp.Problem(cp.Maximize(t), cons)
    try: p.solve(solver=cp.CLARABEL)
    except Exception: p.solve(solver=cp.SCS, eps=1e-10, max_iters=200000)
    print(f"  [{mode}] best margin of a row-space element: {p.status}, t = {p.value}")
    if p.value is None or p.value <= 1e-9: return None
    yv = y.value / rn                        # undo the row scaling
    for den in (10**3, 10**5, 10**7, 10**9, 10**12):
        yq = [Fr(int(round(z*den)), den) for z in yv]
        vx = [sum(yq[i]*A[i][j] for i in range(NR)) for j in range(NC)]
        ok, strict = check_psd(vx, SHAPE, f"y rounded at denominator {den}")
        if strict: return yq, vx
    return None

print("="*72); print("CLAIM 4 -- is there a psd direction in the kernel?")
r4t = claim4("true")
r4u = claim4("used")
print()
if r4t: print("  TRUE layout: row(A) contains a positive definite element, EXACTLY"
              " verified.\n  Hence ker(A) meets the psd cone only at 0: no psd kernel"
              " direction exists,\n  and the least eigenvalue over the family is bounded.")
else:   print("  TRUE layout: no positive definite row-space element found.")
if r4u: print("  DUMP layout: one exists there too.")
else:   print("  DUMP layout: none exists -- consistent with the kernel there"
              " containing a\n  positive definite direction, which is what made"
              " that solve unbounded.")
if r4t:
    with open(os.path.join(HERE, "claim4_y.pkl"), "wb") as f: pickle.dump(r4t, f)

# =============== cross-check ldl_psd against numpy on the certificate ========
if r4t:
    yq, vx = r4t
    print("\n  cross-check of ldl_psd against numpy eigenvalues on S = A^T y:")
    for l, Mx, k in zip(TRUE, unpack_exact(vx, SH["true"]), SH["true"]):
        w = np.linalg.eigvalsh(np.array([[float(z) for z in r] for r in Mx]))
        print(f"    {l} k={k}: min eig {w.min():.4e}  (must be > 0)")
    print(f"    S is nonzero: {any(z != 0 for z in vx)}")
    print(f"    <y, B> = {float(sum(yq[i]*B[i] for i in range(NR))):.6e}"
          "   (the value <S, x> takes on the whole affine family)")

# =============== claim 5: an exact rational point of the family =============
print("\n" + "="*72)
print("CLAIM 5 -- a RATIONAL point of the affine family, psd by exact ldl_psd")

def rref(Mrows, rhs):
    m, n = len(Mrows), len(Mrows[0])
    M = [[Fr(x) for x in r] for r in Mrows]; b = [Fr(x) for x in rhs]
    piv, r = [], 0
    for c in range(n):
        p = next((k for k in range(r, m) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]; b[r], b[p] = b[p], b[r]
        iv = Fr(1)/M[r][c]
        M[r] = [x*iv for x in M[r]]; b[r] *= iv
        for k in range(m):
            if k != r and M[k][c]:
                f = M[k][c]
                M[k] = [x - f*y for x, y in zip(M[k], M[r])]; b[k] -= f*b[r]
        piv.append(c); r += 1
        if r == m: break
    return piv, [c for c in range(n) if c not in piv], M, b

PIV, FREE, R, rb = rref(A, B)
print(f"  exact rank of A over Q: {len(PIV)}   free coordinates: {len(FREE)}")
for k in range(len(PIV), NR):
    assert not (rb[k] and not any(R[k])), "the affine system is INCONSISTENT over Q"
print("  the system is consistent over Q (no zero row with a nonzero rhs)")

SHAPE = SH["true"]
xstar = np.load(os.path.join(HERE, "point_true.npy"))
print(f"  float SDP point: |x|_inf = {np.abs(xstar).max():.4e}, "
      f"|x|_2 = {np.linalg.norm(xstar):.4e}")

def build(den):
    """round the FREE coordinates of x* at 1/den, solve the pivots exactly"""
    x = [None]*NC
    for c in FREE: x[c] = Fr(int(round(xstar[c]*den)), den)
    for i, c in enumerate(PIV):
        x[c] = rb[i] - sum(R[i][f]*x[f] for f in FREE if R[i][f])
    return x

for den in (10**2, 10**3, 10**4, 10**6, 10**9):
    x = build(den)
    bad = sum(1 for i in range(NR)
              if sum(A[i][j]*x[j] for j in range(NC) if x[j]) != B[i])
    ok, strict = check_psd(x, SHAPE, f"denominator {den}: affine violations {bad}")
    if bad == 0 and strict:
        print(f"\n  *** EXACT RATIONAL CERTIFICATE at denominator {den} ***")
        print("  every one of the 40 affine equations holds as an identity over Q,")
        print("  and every block is positive DEFINITE by ldl_psd, no square roots.")
        with open(os.path.join(HERE, "claim5_point.pkl"), "wb") as f:
            pickle.dump({"x": x, "shape": SHAPE, "blocks": TRUE, "den": den}, f)
        hts = [max(abs(z.numerator), z.denominator) for z in x]
        print(f"  point height: max {max(hts):.4e}")
        break
