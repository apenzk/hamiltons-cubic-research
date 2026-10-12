"""r253 side check: the 'projector-free GRAM' printed at lines 104-109 is
hard-coded, and its entries do not match the Gram of the three carriers.

Carrier c is the quadratic form X -> X_{abcd} X_{sigma(abcd)} on the ambient
4-index space.  The Frobenius pairing of two such forms is n^{cycles(s^-1 t)}.
"""
import numpy as np, itertools
perms = {"abcd": (0,1,2,3), "acbd": (0,2,1,3), "cdab": (2,3,0,1)}
def cycles(p):
    seen, c = set(), 0
    for i in range(4):
        if i in seen: continue
        c += 1; j = i
        while j not in seen: seen.add(j); j = p[j]
    return c
def comp(a, b): return tuple(a[b[i]] for i in range(4))
def inv(a):
    r = [0]*4
    for i, v in enumerate(a): r[v] = i
    return tuple(r)
names = list(perms)
print("exact ambient Gram exponents, G_ij = n^cycles(s_i^-1 s_j):")
E = [[cycles(comp(inv(perms[a]), perms[b])) for b in names] for a in names]
for a, row in zip(names, E): print(f"   {a}: {row}")
print("\nthe file's hard-coded exponents (lines 105-107):")
print("   abcd: [4, 3, 4]\n   acbd: [3, 4, 3]\n   cdab: [4, 3, 4]")
for n in (5, 12):
    G = np.array([[float(n)**e for e in row] for row in E])
    F = np.array([[float(n)**e for e in r] for r in ([4,3,4],[3,4,3],[4,3,4])])
    print(f"\n   n={n:>3}: true Gram rank {np.linalg.matrix_rank(G)}, "
          f"file's matrix rank {np.linalg.matrix_rank(F)}")
# numerical confirmation of the exponents
n = 5; rng = np.random.default_rng(3)
def form_matrix(p, n):
    N = n**4; M = np.zeros((N, N))
    for idx in itertools.product(range(n), repeat=4):
        i = np.ravel_multi_index(idx, (n,)*4)
        j = np.ravel_multi_index(tuple(idx[p[k]] for k in range(4)), (n,)*4)
        M[i, j] += 1.0
    return 0.5*(M + M.T)
Ms = [form_matrix(perms[a], n) for a in names]
print("\n   numerical Frobenius Gram at n=5 (symmetrised forms), for confirmation:")
for a, Ma in zip(names, Ms):
    print("   ", a, [f"{float(np.sum(Ma*Mb)):.0f}" for Mb in Ms])
print(f"    n^1={n}, n^2={n**2}, n^3={n**3}, n^4={n**4}")
