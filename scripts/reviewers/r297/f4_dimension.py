"""F4: Delta = 0 => p subset k(W) => dim O(W) <= dim m + dim ker W, and the dimension count."""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C

def kdim(n, W, tol=1e-9):
    """dim k(W) = dim ker of x |-> [ad(x), W] on so(n)."""
    P = C.phi(n); N = P.shape[0]
    rows = []
    for a in range(N):
        A = C.ad(n, P[a]); rows.append((A @ W - W @ A).reshape(-1))
    M = np.array(rows)
    s = np.linalg.svd(M, compute_uv=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return N - r, r

def isotropy_closed(n, W, tol=1e-9):
    """Is k(W) a Lie subalgebra?  (sanity check on the F4 argument.)"""
    P = C.phi(n); N = P.shape[0]
    rows = np.array([(C.ad(n, P[a]) @ W - W @ C.ad(n, P[a])).reshape(-1) for a in range(N)])
    u, s, vt = np.linalg.svd(rows.T, full_matrices=True)
    # kernel of the map in coefficient space
    r = int((s > tol * max(1.0, s[0])).sum())
    K = vt[r:]                       # (k, N) coefficient vectors
    if K.shape[0] == 0: return True, 0.0
    kmats = np.einsum('ka,aij->kij', K, P)
    worst = 0.0
    for i in range(K.shape[0]):
        for j in range(K.shape[0]):
            br = kmats[i] @ kmats[j] - kmats[j] @ kmats[i]
            A = C.ad(n, br); worst = max(worst, np.linalg.norm(A @ W - W @ A))
    return worst < 1e-8, worst

rows = []
for blocks in ([3,3],[3,5],[4,4],[2,4]):
    W, n = C.sphere_product(blocks)
    rows.append((f"S^" + "xS^".join(map(str, blocks)), n, W,
                 sum(b*(b-1)//2 for b in blocks)))
for m in (2, 3, 4):
    W, n = C.cpm(m); rows.append((f"CP^{m}", n, W, m*m))
rows.append(("C_5 blow-up", 10, C.c5_blowup()[0], None))

print("F4 -- Delta=0 => p subset k(W).  Testing dim p <= dim k and the orbit bound.")
print(f"  {'point':14s}{'n':>3s}{'N':>4s}{'dim p':>7s}{'dim m':>7s}{'#0':>4s}{'Delta':>9s}"
      f"{'dim k':>7s}{'iso':>5s}{'orbit':>7s}{'m+#0':>6s}  p<=k?  orbit<=m+#0?  k algebra?")
for lbl, n, W, iso in rows:
    W = W/np.linalg.norm(W)
    D, tot, lam = C.Delta(n, W)
    N = n*(n-1)//2
    dm = int((lam < -1e-9).sum()); nz = int((np.abs(lam) <= 1e-9).sum()); dp = N - dm - nz
    dk, orb = kdim(n, W)
    ok, worst = isotropy_closed(n, W)
    print(f"  {lbl:14s}{n:>3d}{N:>4d}{dp:>7d}{dm:>7d}{nz:>4d}{D:>9.4f}{dk:>7d}"
          f"{(iso if iso is not None else -1):>5d}{orb:>7d}{dm+nz:>6d}"
          f"   {'Y' if (D<1e-8)<=(dp<=dk) else 'N'}"
          f"      {'Y' if orb <= dm+nz else 'N'}"
          f"          {'Y' if ok else 'N'} ({worst:.1e})")

print("\nThe stated consequence, checked verbatim: 'orbit larger than the negative eigenspace => Delta>0'")
for lbl, n, W, iso in rows:
    W = W/np.linalg.norm(W)
    D, tot, lam = C.Delta(n, W); N = n*(n-1)//2
    dm = int((lam < -1e-9).sum()); nz = int((np.abs(lam) <= 1e-9).sum())
    dk, orb = kdim(n, W)
    if orb > dm and D < 1e-8:
        print(f"  COUNTEREXAMPLE to the ker-free form: {lbl}: orbit={orb} > dim m={dm} yet Delta={D:.2e}"
              f"  (dim ker = {nz}; the correct bound m+#0 = {dm+nz} is respected)")

print("\nn=12 arithmetic in the claim: dim m = 20, trivial kernel")
n = 12; N = n*(n-1)//2
print(f"  N = dim so(12) = {N};  dim p = N - dim m - dim ker = {N} - 20 - 0 = {N-20}")
print(f"  Delta = 0 needs k(W) ⊇ p, so dim k >= {N-20} of {N}.   Claim says 46 of 66:",
      "MATCHES" if N-20 == 46 and N == 66 else "MISMATCH")
print("  with a kernel of dimension z the requirement weakens to dim k >= 46 - z.")
print("\n  subalgebras of so(12) of dimension >= 46 (the ones that could host such a k):")
import itertools
cands = {"so(12)": 66, "so(11)": 55, "so(10)+so(2)": 45+1, "u(6)": 36, "so(9)+so(3)": 36+3,
         "sp(3)+sp(1)": 21+3, "so(6)+so(6)": 15+15}
for k, v in sorted(cands.items(), key=lambda kv: -kv[1]):
    print(f"    {k:14s} dim {v:3d}   {'admissible' if v >= 46 else '-- too small'}")
