"""B1: is Q additive over orthogonal index blocks?  Cross term = circ(W_A,W_B)."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r48_core import *

def circ(n, X, Y):
    return 0.5 * (X @ Y + Y @ X) + sharp_pol(n, X, Y)

def supported(n, coords, M0, n0):
    """embed an n0-dim operator onto the listed coordinate set."""
    P0, i0 = pairs_of(n0); P, idx = pairs_of(n)
    out = np.zeros((len(P), len(P)))
    for a, (i, j) in enumerate(P0):
        for b, (k, l) in enumerate(P0):
            ii, jj = sorted((coords[i], coords[j])); kk, ll = sorted((coords[k], coords[l]))
            out[idx[(ii, jj)], idx[(kk, ll)]] = M0[a, b]
    return out

rng = np.random.default_rng(48)
print("=== (a) disjoint coordinate blocks, ARBITRARY symmetric operators (no Weyl) ===", flush=True)
for (nA, nB, n) in [(3, 3, 6), (4, 4, 8), (3, 4, 7), (4, 4, 10), (3, 3, 9), (2, 3, 5), (4, 5, 12)]:
    NA = nA * (nA - 1) // 2; NB = nB * (nB - 1) // 2
    XA = rng.standard_normal((NA, NA)); XA = XA + XA.T
    XB = rng.standard_normal((NB, NB)); XB = XB + XB.T
    A = supported(n, list(range(nA)), XA, nA)
    B = supported(n, list(range(nA, nA + nB)), XB, nB)
    cr = circ(n, A, B)
    # where does any residue live?
    print(f"  nA={nA} nB={nB} n={n}: |circ(A,B)|_max={abs(cr).max():.2e}  "
          f"|AB|={abs(A@B).max():.1e} |A#B|={abs(sharp_pol(n,A,B)).max():.2e}", flush=True)

print("\n=== (b) disjoint blocks, genuine Weyl operators on each block ===", flush=True)
for (nA, nB, n) in [(4, 4, 8), (5, 5, 10), (4, 6, 12), (6, 6, 12), (4, 4, 12), (5, 6, 14)]:
    A0 = rand_weyl(nA, rng); B0 = rand_weyl(nB, rng)
    A = supported(n, list(range(nA)), A0, nA)
    B = supported(n, list(range(nA, nA + nB)), B0, nB)
    cr = circ(n, A, B)
    tot = Q(n, A + B) - Q(n, A) - Q(n, B)
    print(f"  nA={nA} nB={nB} n={n}: |Q(A+B)-Q(A)-Q(B)|={abs(tot).max():.2e} "
          f"weyl(A+B)={is_weyl(n,A+B)} <A,B>={np.sum(A*B):.1e}", flush=True)

print("\n=== (c) blocks orthogonal as OPERATORS but sharing coordinates ===", flush=True)
n = 6
Wa = sphere_product((3, 3)); Wb = fox_point(6)
print(f"  <S^3xS^3, Fox_pad6> = {np.sum(Wa*Wb):.2e}", flush=True)
# force exact orthogonality
Wb2 = Wb - np.sum(Wa * Wb) * Wa; Wb2 /= nrm(Wb2)
print(f"  after Gram-Schmidt: <A,B> = {np.sum(Wa*Wb2):.1e},  "
      f"|Q(A+B)-Q(A)-Q(B)|_max = {abs(Q(n,Wa+Wb2)-Q(n,Wa)-Q(n,Wb2)).max():.4f}", flush=True)
for trial in range(3):
    X = rand_weyl(6, rng); Y = rand_weyl(6, rng)
    Y = Y - np.sum(X * Y) / np.sum(X * X) * X
    X /= nrm(X); Y /= nrm(Y)
    print(f"  random orthogonal Weyl pair n=6 #{trial}: <X,Y>={np.sum(X*Y):.1e} "
          f"|cross|={abs(Q(6,X+Y)-Q(6,X)-Q(6,Y)).max():.4f}", flush=True)

print("\n=== (d) blocks sharing exactly ONE coordinate ===", flush=True)
for (nA, nB, n, share) in [(4, 4, 7, 1), (4, 4, 6, 2), (3, 3, 5, 1)]:
    A0 = rand_weyl(nA, rng); B0 = rand_weyl(nB, rng)
    A = supported(n, list(range(nA)), A0, nA)
    B = supported(n, list(range(nA - share, nA - share + nB)), B0, nB)
    cr = circ(n, A, B)
    print(f"  nA={nA} nB={nB} n={n} shared coords={share}: |cross|={abs(cr).max():.4f} "
          f"<A,B>={np.sum(A*B):.2e}", flush=True)

print("\n=== (e) does the cross term vanish termwise, or only in sum? ===", flush=True)
nA=nB=4; n=8
A0 = rand_weyl(4, rng); B0 = rand_weyl(4, rng)
A = supported(n, list(range(4)), A0, 4); B = supported(n, list(range(4,8)), B0, 4)
print(f"  |1/2(AB+BA)|_max = {abs(0.5*(A@B+B@A)).max():.2e}", flush=True)
print(f"  |A#B (polarized)|_max = {abs(sharp_pol(n,A,B)).max():.2e}", flush=True)
sp = sharp_pol(n, A, B)
Pp, idx = pairs_of(n)
mixed = [a for a,(i,j) in enumerate(Pp) if (i<4)!=(j<4)]
print(f"  restricted to mixed planes: {abs(sp[np.ix_(mixed,mixed)]).max():.2e}", flush=True)
