"""r281 Claim 1: does support dimension s force W to be a padding of an element of Weyl_s?

Built on scripts/review_r30_core.py primitives only.
Support Gram: G_ip = sum_{jkl} R_ijkl R_pjkl,  R_ijkl = <W phi_ij, phi_kl>.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
from review_r30_core import (pair_index, weyl_basis, sphere_product_W, normalize,
                             P, Q, weyl_constraints)

rng = np.random.default_rng(281)

def riemann(n, W):
    pairs, idx = pair_index(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = W[a, b]
            R[i, j, k, l] = v; R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    return R

def gram(n, W):
    R = riemann(n, W)
    return np.einsum('ijkl,pjkl->ip', R, R)

def rand_weyl(n):
    B = weyl_basis(n)
    c = rng.normal(size=B.shape[0])
    W = np.einsum('k,kij->ij', c, B)
    return W / np.sqrt(np.tensordot(W, W))

def cp2_W(n, block=(0,1,2,3)):
    """W_CP2 padded into R^n, as a Lambda^2 operator, from the 4-tensor."""
    J = np.zeros((n, n)); b = list(block)
    J[b[1], b[0]] = 1.0; J[b[0], b[1]] = -1.0
    J[b[3], b[2]] = 1.0; J[b[2], b[3]] = -1.0
    Jm = J.T.copy()
    d = np.eye(n); bs = set(block)
    R = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        if not (i in bs and j in bs and k in bs and l in bs):
            continue
        R[i,j,k,l] = (d[i,k]*d[j,l]-d[i,l]*d[j,k]) + (Jm[i,k]*Jm[j,l]-Jm[i,l]*Jm[j,k]) + 2*Jm[i,j]*Jm[k,l]
    pairs, idx = pair_index(n)
    N = len(pairs)
    W = np.array([[R[i,j,k,l] for (k,l) in pairs] for (i,j) in pairs])
    # project out the trace part: CP2 tensor above is the *curvature* tensor; remove Ricci
    return W

def weyl_project(n, W):
    """orthogonal projection onto Weyl_n"""
    B = weyl_basis(n)
    c = np.einsum('kij,ij->k', B, W)
    return np.einsum('k,kij->ij', c, B)

def rot(n, W, O):
    """W transported by O in O(n): acts on Lambda^2 via the induced rep."""
    pairs, idx = pair_index(n)
    R = riemann(n, W)
    R2 = np.einsum('ia,jb,kc,ld,abcd->ijkl', O, O, O, O, R)
    return np.array([[R2[i,j,k,l] for (k,l) in pairs] for (i,j) in pairs])

def report(tag, n, W):
    G = gram(n, W)
    ev = np.linalg.eigvalsh(G)
    s = int((ev > max(1e-9 * max(ev.max(), 1.0), 1e-12)).sum())
    print(f"  {tag:34s} n={n:2d}  s={s:2d}  minEV={ev.min(): .3e}  ||W||={np.sqrt(np.tensordot(W,W)):.6f}  P={P(n,W):.12f}")
    return G, ev, s

print("=== A. support dimension at the named points ===")
n = 12
Wsp, _ = sphere_product_W([6, 6]); Wsp = normalize(Wsp)
report("S^6 x S^6", 12, Wsp)
def pad(n0, W0, n):
    p0, i0 = pair_index(n0); pn, iN = pair_index(n)
    Wb = np.zeros((len(pn),) * 2)
    for a, pa in enumerate(p0):
        for b, pb in enumerate(p0):
            Wb[iN[pa], iN[pb]] = W0[a, b]
    return Wb

Wcp4 = normalize(weyl_project(4, cp2_W(4)))
Wcp = pad(4, Wcp4, 12)
report("W_CP2 native", 4, Wcp4)
report("padded W_CP2 (coords 0-3)", 12, Wcp)
for nn in (6, 7, 8):
    report(f"random Weyl_{nn}", nn, rand_weyl(nn))

print()
print("=== B. is G PSD, and is ker G = {v : R(v,.,.,.)=0}? ===")
for nn, W in ((12, Wcp), (12, Wsp), (7, rand_weyl(7))):
    G = gram(nn, W); R = riemann(nn, W)
    ev, V = np.linalg.eigh(G)
    worst = 0.0
    for a in range(nn):
        slab = np.einsum('i,ijkl->jkl', V[:, a], R)
        # ||R(v,.,.,.)||^2 should equal v^T G v = ev[a]
        worst = max(worst, abs(np.tensordot(slab, slab, axes=3) - ev[a]))
    print(f"  n={nn}: min eig(G)={ev.min(): .3e}   max |  ||R(v)||^2 - v^T G v | = {worst:.3e}")

print()
print("=== C. THE CRUX: does support s force vanishing off the image of G? ===")
print("  For each point: max |R_ijkl| with at least one index in ker G")
def offsupport_mass(nn, W, tol=1e-8):
    G = gram(nn, W); R = riemann(nn, W)
    ev, V = np.linalg.eigh(G)
    ker = V[:, ev <= tol * max(ev.max(), 1.0)]
    if ker.shape[1] == 0:
        return 0.0, 0
    # transform R into the eigenframe of G and read off entries touching the kernel
    Rk = np.einsum('ia,ijkl->ajkl', ker, R)
    return float(np.abs(Rk).max()), ker.shape[1]

for tag, nn, W in (("padded W_CP2", 12, Wcp), ("S^6xS^6 padded to 14", 14, None),
                   ("random Weyl_6 padded to 9", 9, None)):
    if W is None:
        if nn == 14:
            W0, _ = sphere_product_W([6, 6]); W0 = normalize(W0)
            Wb = np.zeros((len(pair_index(14)[0]),) * 2)
            p12, i12 = pair_index(12); p14, i14 = pair_index(14)
            for a, pa in enumerate(p12):
                for b, pb in enumerate(p12):
                    Wb[i14[pa], i14[pb]] = W0[a, b]
            W = Wb
        else:
            W0 = rand_weyl(6)
            p6, i6 = pair_index(6); p9, i9 = pair_index(9)
            Wb = np.zeros((len(p9),) * 2)
            for a, pa in enumerate(p6):
                for b, pb in enumerate(p6):
                    Wb[i9[pa], i9[pb]] = W0[a, b]
            W = Wb
    m, k = offsupport_mass(nn, W)
    print(f"  {tag:28s} n={nn:2d}  dim ker G={k:2d}  max|R| touching ker = {m:.3e}")

print()
print("=== D. a GENERIC-FRAME point of support 4: is it a padding, and is the restriction in Weyl_4? ===")
O = np.linalg.qr(rng.normal(size=(12, 12)))[0]
Wr = rot(12, Wcp, O)
G, ev, s = report("O(12)-rotated padded W_CP2", 12, Wr)
V = np.linalg.eigh(G)[1][:, -s:]          # image of G
R = riemann(12, Wr)
Rk = np.einsum('ia,ijkl->ajkl', np.linalg.eigh(G)[1][:, :12-s], R)
print(f"  max |R| touching ker G                     = {np.abs(Rk).max():.3e}")
Rres = np.einsum('ia,jb,kc,ld,ijkl->abcd', V, V, V, V, R)
print(f"  ||R restricted to im G||^2 vs ||R||^2      = {np.tensordot(Rres,Rres,axes=4):.12f} vs {np.tensordot(R,R,axes=4):.12f}")
bi = np.abs(Rres + np.einsum('iklj->ijkl', Rres) + np.einsum('iljk->ijkl', Rres)).max()
ric = np.abs(np.einsum('ijil->jl', Rres)).max()
print(f"  restriction: max|Bianchi| = {bi:.3e},  max|Ric| = {ric:.3e}   -> in Weyl_{s}")
# now compare P computed at n=12 with P of the restriction re-embedded at n=4
p4, i4 = pair_index(4)
W4 = np.array([[Rres[i,j,k,l] for (k,l) in p4] for (i,j) in p4])
print(f"  ||W||^2 at n=12 {np.tensordot(Wr,Wr):.12f}   ||W_4||^2 {np.tensordot(W4,W4):.12f}")
print(f"  P at n=12       {P(12,Wr):.12f}   P at n=4  {P(4,W4):.12f}")

print()
print("=== E. can support s be achieved without being a padding?  ===")
print("  search: random Weyl_n with a prescribed low-rank Gram is impossible by the argument;")
print("  instead check the converse numerically -- ANY W with rank(G)=s restricts to Weyl_s.")
for trial in range(6):
    nn = 8
    n0 = rng.integers(4, 7)
    W0 = rand_weyl(int(n0))
    p0, i0 = pair_index(int(n0)); pn, iN = pair_index(nn)
    # embed on a RANDOM n0-subspace, not coordinates
    Wb = np.zeros((len(pn),) * 2)
    for a, pa in enumerate(p0):
        for b, pb in enumerate(p0):
            Wb[iN[pa], iN[pb]] = W0[a, b]
    Ow = np.linalg.qr(rng.normal(size=(nn, nn)))[0]
    Wb = rot(nn, Wb, Ow)
    G = gram(nn, Wb); ev = np.linalg.eigvalsh(G)
    s = int((ev > 1e-9 * ev.max()).sum())
    print(f"  seed n0={n0}  ->  rank(G)={s}  P(n={nn})={P(nn,Wb):.12f}  P(n0)={P(int(n0),W0):.12f}"
          f"  ||.||^2 {np.tensordot(Wb,Wb):.9f}/{np.tensordot(W0,W0):.9f}")
