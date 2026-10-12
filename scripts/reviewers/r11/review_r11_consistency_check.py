"""
Closing the hole in Step 5: apply (R1) as a CHECK against each pair's true
Casimirs, instead of solving for them.

For a single-Casimir graded pair the two relations must BOTH hold:

    (R1)  c_k = [ C (2q - p) - 2 (p + q) ] / q        (criticality, m-block)

with C and c_k the pair's actual Casimirs in the so(n)-induced normalisation.
Step 5 solved (R1) for c_k, which cannot fail and therefore checks nothing.
Here the true values are supplied per family and (R1) is tested.

True Casimirs, derived from the trace identity sum_a tr_V(e_a^2) = -2 dim g,
which pins the induced normalisation, together with the intrinsic ratio
C2(adj)/C2(V):

  so(j) standard in so(N):     c = 2(j-2),      C (on R^j (x) R^{N-j}) = j-1
  so(m) inside su(m) c so(2m): c = m-2,         C (on Sym^2_0)         = m
  sp(j) inside sp(m) c so(4m): c = 2(j+1),      C (on H^j (x) H^{m-j}) = (2j+1)/2

The so(m)-in-su(m) row is verified against the built operators: c = m-2 gives
1, 2, 4 at m = 3, 4, 6, matching the brackets measured in
review_r11_graded_casimir.py exactly, and C = m gives 3, 4, 6, likewise.
"""
import numpy as np

SQ32 = np.sqrt(1.5)


def R1(C, p, q):
    return (C * (2 * q - p) - 2.0 * (p + q)) / q


def theta(ck, p, q):
    if 2 * q - p <= 0:
        return None
    return (ck * q * q + 2 * q * q + p * p) / ((2 * q - p) * np.sqrt(p * q * (p + q)))


rows = []

# --- A, balanced blocks: (so(2m), so(m)+so(m)) -- ideals swapped, single Casimir
for m in range(3, 21):
    p, q = m * (m - 1), m * m
    rows.append((f"(so({2*m}), so({m})+so({m}))  [balanced sphere]", p, q, 2 * (m - 1), 2 * (m - 2)))

# --- A, j = 1: k = so(N-1), simple
for N in range(5, 41):
    p, q = (N - 1) * (N - 2) // 2, N - 1
    rows.append((f"(so({N}), so({N-1}))", p, q, N - 2, 2 * (N - 3)))

# --- B: (su(m), so(m)), k simple for m >= 3
for m in range(3, 21):
    p, q = m * (m - 1) // 2, (m - 1) * (m + 2) // 2
    rows.append((f"(su({m}), so({m}))", p, q, float(m), float(m - 2)))

# --- C, balanced quaternionic: (sp(2j), sp(j)+sp(j))
for j in range(1, 11):
    p, q = 2 * (j * (2 * j + 1)), 4 * j * j
    rows.append((f"(sp({2*j}), sp({j})+sp({j}))", p, q, (2 * j + 1) / 2, 2.0 * (j + 1)))

print(f"{'pair':<40} {'p':>5} {'q':>5} {'c_k true':>9} {'(R1)':>9} {'ok':>4} {'theta':>13}")
print("-" * 92)
genuine, rejected = [], 0
for label, p, q, C, ck in rows:
    r1 = R1(C, p, q)
    ok = abs(r1 - ck) < 1e-9
    th = theta(ck, p, q)
    ths = f"{th:.9f}" if th is not None else "   (2q<=p)"
    if ok and th is not None:
        genuine.append((th, label))
    else:
        rejected += 1
    print(f"{label:<40} {p:>5} {q:>5} {ck:>9.3f} {r1:>9.3f} {str(ok):>5} {ths:>13}")

print("-" * 92)
print(f"genuine (R1 satisfied with true Casimirs): {len(genuine)}   rejected: {rejected}")
genuine.sort(key=lambda t: -t[0])
above = [g for g in genuine if g[0] > SQ32 + 1e-12]
print(f"\nof the genuine ones, above sqrt(3/2) = {SQ32:.9f}:  {len(above)}")
for th, label in above:
    print(f"   {th:.9f}   {label}")
nonsphere = [g for g in above if "balanced sphere" not in g[1]]
print(f"\nabove sqrt(3/2) and NOT a sphere product: {len(nonsphere)}")
if not nonsphere:
    print("   none")
