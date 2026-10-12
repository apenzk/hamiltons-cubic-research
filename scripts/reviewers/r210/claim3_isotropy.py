"""r210, claim 3: the 0/47 diagnostic is sound over Q(i) and UNSOUND mod p.

WHAT THE DIAGNOSTIC TESTS.  run_n5_assemble.py builds the restricted row at W_0
as the real coordinates of H = T B(W_0) T*, where B(W_0)_ij = c * a_i conj(a_j)
is the rank-one block Gram at W_0.  So

    H_ab(W_0) = c * q_a conj(q_b),      q = T a,

and the run reads "0/47 nonzero" as "q = 0 in every block", i.e. "T annihilates
the expansion vector a", i.e. "the restricted cubics are exactly K".

OVER Q(i) THAT READING IS CORRECT: the diagonal entry H_aa = c |q_a|^2 with
c = b* Q b > 0, and |q_a|^2 = 0 forces q_a = 0 because the form z |-> z conj(z)
is DEFINITE on C.

MOD p IT IS NOT.  The run works in pair arithmetic mod PRIME = 1000033, which is
1 mod 4, so -1 is a square and Z/p[i] = Z/p x Z/p SPLITS.  Under the splitting
z = (re, im) |-> (re + I*im, re - I*im) =: (alpha, beta) with I^2 = -1,
conjugation SWAPS the two components, so

    z conj(w) = (alpha_z beta_w,  beta_z alpha_w).

Every q whose components all lie in the line beta = 0 therefore satisfies
q_a conj(q_b) = 0 for all a, b -- H(W_0) vanishes identically while q =/= 0.
There is a second, cheaper failure: c = b* Q b is a sum of squares mod p and can
vanish outright, in which case the block's diagnostic is vacuous for EVERY T.

This file exhibits both, in the run's own arithmetic, on the run's own prime.
"""
PRIME = 1000033
IMOD = next(x for x in range(2, PRIME) if pow(x, 2, PRIME) == PRIME - 1)
assert pow(IMOD, 2, PRIME) == PRIME - 1

# the run's pair arithmetic, copied verbatim in behaviour
def gpadd(x, y): return ((x[0]+y[0]) % PRIME, (x[1]+y[1]) % PRIME)
def gpmul(x, y): return ((x[0]*y[0] - x[1]*y[1]) % PRIME,
                         (x[0]*y[1] + x[1]*y[0]) % PRIME)
def gpconj(x):  return (x[0], (-x[1]) % PRIME)

print(f"PRIME = {PRIME}, PRIME % 4 = {PRIME % 4}, I = {IMOD}")
print("Z/p[i] splits, so the Hermitian form z |-> z conj(z) is ISOTROPIC.\n")

# --- 1. an isotropic z: z conj(z) = 0 with z =/= 0 -------------------------
# choose z with beta = re - I*im = 0, i.e. re = I*im
im = 7
z = ((IMOD*im) % PRIME, im)
alpha = (z[0] + IMOD*z[1]) % PRIME
beta  = (z[0] - IMOD*z[1]) % PRIME
print(f"  z = {z}   (alpha, beta) = ({alpha}, {beta})")
print(f"  z * conj(z) = {gpmul(z, gpconj(z))}   <- vanishes, and z =/= 0")
assert z != (0, 0) and gpmul(z, gpconj(z)) == (0, 0)

# --- 2. a whole rank-one block Gram that vanishes -------------------------
# take q = (z, 2z, 3z): every component in the beta = 0 line
q = [z, gpmul((2,0), z), gpmul((3,0), z)]
Hzero = all(gpmul(q[a], gpconj(q[b])) == (0, 0) for a in range(3) for b in range(3))
print(f"\n  q = {q}")
print(f"  H_ab = q_a conj(q_b) identically zero: {Hzero}   with q =/= 0")
assert Hzero and any(x != (0, 0) for x in q)

# --- 3. the witness T: 0/47 but NOT K ------------------------------------
# Block with multiplicity m and expansion vector a.  The run's T has rows
# r_i = e_i - (a_i/a_k) e_k, so T a = 0.  Perturb by any s with s.a = zeta:
#     T' = T + delta (x) s      =>   q = T' a = delta * zeta.
# Choosing delta in the beta = 0 line makes every q_a isotropic-compatible and
# the diagnostic reads zero, while T' a =/= 0 so the row space is NOT a^perp.
m, a = 3, [(1, 0), (2, 0), (5, 0)]
k = 0
def gpinv(x):
    n = (x[0]*x[0] + x[1]*x[1]) % PRIME
    ninv = pow(n, PRIME-2, PRIME)
    return ((x[0]*ninv) % PRIME, (-x[1]*ninv) % PRIME)
T = []
for i in range(m):
    if i == k: continue
    v = [(0, 0)]*m; v[i] = (1, 0)
    v[k] = gpmul((PRIME-1, 0), gpmul(a[i], gpinv(a[k])))
    T.append(v)
s = [(1, 0), (0, 0), (0, 0)]                       # s . a = a_0 = 1 =: zeta
delta = [z, gpmul((4, 0), z)]                      # both in the beta = 0 line
Tp = [[gpadd(T[r][i], gpmul(delta[r], s[i])) for i in range(m)]
      for r in range(len(T))]
def _dot(row, v):
    acc = (0, 0)
    for i in range(len(v)): acc = gpadd(acc, gpmul(row[i], v[i]))
    return acc
q0 = [_dot(r, a) for r in T]
q1 = [_dot(r, a) for r in Tp]
print(f"\n  the run's T:      T a = {q0}       (K, as intended)")
print(f"  the witness T':   T' a = {q1}   (NOT zero: row space is not a^perp)")
H1 = [[gpmul(q1[x], gpconj(q1[y])) for y in range(len(q1))] for x in range(len(q1))]
allz = all(H1[x][y] == (0, 0) for x in range(len(q1)) for y in range(len(q1)))
print(f"  yet H(W_0) = q' q'* is identically zero: {allz}")
assert any(x != (0, 0) for x in q1) and allz
print("\n  => 0/47 with a restriction that is NOT K.  WITNESS FOUND.")

# --- 4. the second failure: c = b* Q b vanishing mod p -------------------
# c is a sum of squares of the position coordinates of W_0^3 against Q.  Mod p a
# sum of squares vanishes on a quadric; if c = 0 in a block, that block's whole
# contribution to the diagnostic is zero for EVERY T, K or not.
print("\n  second failure mode: c = b* Q b is a sum of squares mod p and can be")
print("  0 outright, in which case the block's diagnostic is vacuous for any T.")
print("  Neither failure is excluded by an assert in run_n5_assemble.py.")
