"""Reviewer 185, claim 1.  Does eval_polarised compute the polarisation of the
diagram functional, i.e. the thing the apolarity coefficient extraction needs?

Three independent probes, none of which the two shipped validations can see:
  P1  symmetry:      is J(T_sigma(0),...,T_sigma(5)) independent of sigma?
  P2  polarisation:  compare with the true symmetric polarisation recovered from
                     the UNPOLARISED eval_diagram by finite differences.
  P3  coefficient:   expand J(xA + yB) as a binary sextic by exact interpolation
                     over F_p and compare its coefficients with what the shipped
                     map claims they are.
  P4  self-pair:     drive the `while ia:` trace branch, which random_matching
                     can never reach.
All arithmetic exact over F_p (p = 10007) or over Z.
"""
import sys, os, itertools, random
import numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..", "..", "..")
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
sys.path.insert(0, os.path.join(ROOT, "scripts", "runs"))
import weyl_invariants as WI
import importlib.util
spec = importlib.util.spec_from_file_location(
    "pol", os.path.join(ROOT, "scripts", "runs", "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)
ep = pol.eval_polarised

N, P, K = 5, 10007, 6
rng = np.random.default_rng(11); pyrng = random.Random(11)
inv = lambda x: pow(int(x) % P, P-2, P)

Ts = [WI.random_weyl(N, P, rng) for _ in range(K)]
mats = [WI.random_matching(K, pyrng) for _ in range(6)]

print("=" * 72)
print("P1  SYMMETRY of eval_polarised under permuting the six tensors")
print("=" * 72)
for mi, m in enumerate(mats):
    base = ep(Ts, m, P)
    vals = {}
    for sg in itertools.permutations(range(K)):
        v = ep([Ts[s] for s in sg], m, P)
        vals.setdefault(v, []).append(sg)
    print(f"  matching {mi}: J(T0..T5) = {base:5d} ; distinct values over the "
          f"720 permutations = {len(vals)}")
    if len(vals) > 1:
        ks = sorted(vals)
        print(f"      e.g. sigma=id -> {base}, sigma={vals[ks[0]][0]} -> {ks[0]}"
              f"   (a permutation CHANGES the value)")
    if mi == 1: break

print()
print("=" * 72)
print("P2  TRUE POLARISATION by finite differences from the UNPOLARISED map")
print("=" * 72)
print("   Jsym(T1..T6) = (1/6!) sum_{S nonempty} (-1)^(6-|S|) J(sum_{i in S} T_i)")
f6 = 720
for mi, m in enumerate(mats):
    fd = 0
    for r in range(1, K+1):
        for S in itertools.combinations(range(K), r):
            X = np.zeros_like(Ts[0])
            for i in S: X = (X + Ts[i]) % P
            fd = (fd + (-1)**(K-r) * WI.eval_diagram(X, m, K, P)) % P
    fd_sym = fd * inv(f6) % P
    shipped = ep(Ts, m, P)
    avg = sum(ep([Ts[s] for s in sg], m, P)
              for sg in itertools.permutations(range(K))) % P * inv(f6) % P
    tag = "MATCH" if fd_sym == shipped else "MISMATCH"
    tag2 = "MATCH" if fd_sym == avg else "MISMATCH"
    print(f"  matching {mi}:  Jsym(FD) = {fd_sym:5d}   shipped ep = {shipped:5d}"
          f"  -> {tag}")
    print(f"              S6-average of ep = {avg:5d}  -> {tag2}")
    if mi == 2: break

print()
print("=" * 72)
print("P3  THE COEFFICIENT CLAIM.  J(xA + yB) expanded exactly by interpolation")
print("=" * 72)
A, B = Ts[0], Ts[1]
for mi, m in enumerate(mats[:3]):
    # J(xA+B) is a degree-6 polynomial in x; interpolate at x=0..6 over F_p
    xs = list(range(7))
    ys = [WI.eval_diagram((x*A + B) % P, m, K, P) for x in xs]
    # solve Vandermonde exactly mod p
    M = [[pow(x, j, P) for j in range(7)] + [ys[i]] for i, x in enumerate(xs)]
    r = 0
    for c in range(7):
        piv = next(i for i in range(r, 7) if M[i][c] % P)
        M[r], M[piv] = M[piv], M[r]
        iv = inv(M[r][c]); M[r] = [v*iv % P for v in M[r]]
        for i in range(7):
            if i != r and M[i][c]:
                f = M[i][c]; M[i] = [(M[i][j] - f*M[r][j]) % P for j in range(8)]
        r += 1
    coef = [M[j][7] for j in range(7)]     # coef[d] = coefficient of x^d
    print(f"  matching {mi}: true coefficients of x^d in J(xA+B), d=0..6:")
    print(f"     {coef}")
    claim = [ep([A]*d + [B]*(K-d), m, P) for d in range(7)]
    print(f"   shipped ep([A]*d+[B]*(6-d)) (the 'coefficient is the diagram "
          f"contracted with the six tensors'):")
    print(f"     {claim}")
    binom = [(coef[d] * inv(1) - claim[d]) % P for d in range(7)]
    ratio = []
    for d in range(7):
        ratio.append("n/a" if claim[d] % P == 0 else str(coef[d]*inv(claim[d]) % P))
    print(f"   ratio true/claim per d: {ratio}")
    print(f"   binomial C(6,d):        {[1,6,15,20,15,6,1]}")
    # the honest identity: coef[d] = sum over the C(6,d) placements of A
    placed = []
    for d in range(7):
        s = 0
        for S in itertools.combinations(range(K), d):
            s = (s + ep([A if v in S else B for v in range(K)], m, P)) % P
        placed.append(s)
    print(f"   sum over the C(6,d) PLACEMENTS of A: {placed}"
          f"   -> {'MATCH' if placed == coef else 'MISMATCH'}")
    print()

print("=" * 72)
print("P4  THE SELF-PAIR BRANCH -- reachability and correctness")
print("=" * 72)
# random_matching forbids intra-vertex pairs, so the branch is dead for every
# matching the script (or r179's pipeline) ever produces.  Force one by hand.
def has_selfpair(m): return any(a//4 == b//4 for a, b in m)
found = 0
for _ in range(20000):
    if has_selfpair(WI.random_matching(K, pyrng)): found += 1
print(f"  matchings from WI.random_matching with an intra-vertex pair: "
      f"{found}/20000  (the generator excludes them by construction)")

# hand-built matching WITH self pairs, on k=2 so the answer is checkable by hand
m_self = [(0,1), (2,3), (4,5), (6,7)]      # both vertices fully self-paired
T0 = np.arange(N**4, dtype=np.int64).reshape(N,N,N,N) % P
T1 = (np.arange(N**4, dtype=np.int64).reshape(N,N,N,N)*7 + 3) % P
got = ep([T0, T1], m_self, P)
want = (int(np.einsum('iijj->', T0.astype(object))) *
        int(np.einsum('iijj->', T1.astype(object)))) % P
print(f"  k=2, matching [(0,1),(2,3),(4,5),(6,7)]  (each vertex traces itself)")
print(f"     eval_polarised = {got}, hand value = {want} -> "
      f"{'MATCH' if got == want else 'MISMATCH'}")

# self-pair on the SECOND operand of a merge: vertex 1 self-paired, 0-2 joined
m_mix = [(0,4),(1,5),(2,6),(3,7),(8,9),(10,11)]
# vertices 0,1 fully joined; vertex 2 self-paired -> disconnected, ep must give
# tr-of-0,1 contraction times tr(T2)
try:
    got = ep([T0, T1, T1], m_mix, P)
    want = (int(np.einsum('abcd,abcd->', T0.astype(object), T1.astype(object))) *
            int(np.einsum('iijj->', T1.astype(object)))) % P
    print(f"  k=3, vertex 2 self-paired, 0-1 fully joined: ep = {got}, hand = "
          f"{want} -> {'MATCH' if got == want else 'MISMATCH'}")
except Exception as e:
    print(f"  k=3, vertex 2 self-paired: RAISED {type(e).__name__}: {e}")

# self-pair that lands in the SECOND operand of an einsum merge
m_bad = [(0,4),(1,5),(2,3),(6,7)]   # vertex 0: slots 2,3 self-paired; v1: 6,7
try:
    got = ep([T0, T1], m_bad, P)
    want = (int(np.einsum('abcc,abdd->', T0.astype(object), T1.astype(object)))) % P
    print(f"  k=2, BOTH vertices carry a self-pair and share two legs: "
          f"ep = {got}, hand = {want} -> {'MATCH' if got == want else 'MISMATCH'}")
except Exception as e:
    print(f"  k=2, both vertices carry a self-pair: RAISED "
          f"{type(e).__name__}: {e}")
