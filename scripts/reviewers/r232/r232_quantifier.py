"""r232 / claim 1c-1d.  THE QUANTIFIER, and the hypothesis n_0 >= k_B.

run_bn_transfer_theorem.py states the theorem for

    "U_n = Sym^d(W_n^*) -- or any polynomial-functor module of the standard
     representation"

and asserts k_B is finite, "B_n being one of Levin-Chandrasekaran's classical
Weyl-group sequences, Theorem 2.11".  Both are checked here.

(A) W_n IS NOT A POLYNOMIAL FUNCTOR OF THE STANDARD REPRESENTATION.  A
    polynomial functor of R^n is a GL(n)-subrepresentation of a tensor power
    (Schur functors, and sums/tensors of them).  W_n is cut out by the
    TRACE-FREE condition, which uses the metric and is not GL-equivariant.
    Witness: a Weyl tensor pushed forward by a non-orthogonal g has nonzero
    Ricci.  So the application is OUTSIDE the theorem's stated generality.

    What step (1) actually needs, and gets, is weaker: padding W_{n_0} -> W_n
    is zero-padding inside (R^n)^{ox 4} (r232_weyl_padding.py part A).  The
    theorem is TRUE for {W_n}; the stated hypothesis just fails to cover it.

(C) THE COMPLEMENT IS NOT A SUBSEQUENCE.  C_n = W_n + {h (x) g_n} orthogonally
    over O(n), but the Ricci part is not closed under padding: pad(h (x) g_{n_0})
    lands in the Ricci part at level n only when h is a multiple of the
    identity.  (The round sphere IS that exceptional case, which is why it is a
    misleading test.)  So Theorem 2.11's (Sums) clause cannot reach {W_n}.

(D) NOR CAN ITS (Images and kernels) CLAUSE.  That clause requires the ADJOINTS
    A* to form a morphism.  Pairing against T in C_{n+1} turns the requirement
    into "Ric commutes with TRUNCATION".  Ric commutes with padding but not
    with truncation: it loses the terms T_{i,n+1,j,n+1}.  So the cited calculus
    delivers no finite k_B for {W_n}, hence none for Sym^d(W_n^*).

(E) AND n_0 >= k_B FAILS AT n_0 = 12 ANYWAY, by a bound needing no calculus.
    {W_n} is generated in degree exactly 4.  R[B_n] Sym^l(W_d) consists of sums
    of tensors each of whose MONOMIALS has coordinate support inside a set of
    size d.  A product of l Weyl tensors on DISJOINT 4-subsets has a monomial of
    support 4l, so Sym^l(W_n) is generated in degree exactly 4l -- and the
    presentation degree is at least the generation degree (Levin-Chandrasekaran,
    note after Definition 2.7).  Hence

        k_B(Sym^3 W) >= 12   and   k_B(Sym^6 W) >= 24 > 12 = n_0.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r232_lin as L

I = lambda n: np.eye(n, dtype=np.int64)
def kn2(a, b):
    """Kulkarni-Nomizu product a (x) b of two symmetric 2-tensors."""
    return (np.einsum('ik,jl->ijkl', a, b) + np.einsum('jl,ik->ijkl', a, b)
            - np.einsum('il,jk->ijkl', a, b) - np.einsum('jk,il->ijkl', a, b))
def kn(h, n):
    return kn2(h, I(n))
def sphere(n):
    d = I(n)
    return np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
def ric(R):
    return np.einsum('ikjk->ij', R)
def weyl_part(T, n):
    """n(n-1)(n-2) times the Weyl part of an algebraic curvature tensor T."""
    Rc = ric(T); t = int(np.trace(Rc))
    A = Rc * n - t * I(n)
    return n * (n - 1) * (n - 2) * T - (n - 1) * kn(A, n) - (n - 2) * t * sphere(n)
def pad4(T, n0, n):
    out = np.zeros((n, n, n, n), dtype=np.int64); out[:n0, :n0, :n0, :n0] = T
    return out
def curv_constraints(n):
    ix = lambda i, j, k, l: ((i * n + j) * n + k) * n + l
    rows = []
    for i, j, k, l in itertools.product(range(n), repeat=4):
        for spec in ([(ix(i,j,k,l),1),(ix(j,i,k,l),1)],
                     [(ix(i,j,k,l),1),(ix(i,j,l,k),1)],
                     [(ix(i,j,k,l),1),(ix(k,l,i,j),-1)],
                     [(ix(i,j,k,l),1),(ix(i,k,l,j),1),(ix(i,l,j,k),1)]):
            r = np.zeros(n ** 4, dtype=np.int64)
            for c, v in spec: r[c] += v
            rows.append(r)
    return np.array(rows, dtype=np.int64)
def ricci_constraints(n):
    ix = lambda i, j, k, l: ((i * n + j) * n + k) * n + l
    rows = []
    for i, j in itertools.product(range(n), repeat=2):
        r = np.zeros(n ** 4, dtype=np.int64)
        for k in range(n): r[ix(i, k, j, k)] += 1
        rows.append(r)
    return np.array(rows, dtype=np.int64)

print("=" * 74)
print("(A) is W_n a GL(n)-subrepresentation, i.e. a polynomial functor of R^n?")
h1 = np.array([[2,1,0,0],[1,-1,3,0],[0,3,1,1],[0,0,1,-2]], dtype=np.int64)
h2 = np.array([[0,0,1,2],[0,1,0,1],[1,0,-1,0],[2,1,0,0]], dtype=np.int64)
R4 = kn2(h1, h1) + kn2(h2, h2) + 3 * kn2(h1, h2)   # h (x) g is PURE Ricci; h (x) k is not
W4 = weyl_part(R4, 4)
assert not ric(W4).any()
g = np.diag([1, 1, 1, 2]).astype(np.int64)
Wg = np.einsum('abcd,ai,bj,ck,dl->ijkl', W4, g, g, g, g)
print(f"    max |W| = {np.abs(W4).max()}")
print(f"    Ric(W) = 0: {not ric(W4).any()}      Ric(g.W) = 0: {not ric(Wg).any()}"
      f"   (max |Ric(g.W)| = {np.abs(ric(Wg)).max()})")
assert ric(Wg).any(), "trace-freeness would be GL-invariant, contradicting (A)"
print("    => trace-freeness is metric-dependent.  {W_n} is an O(n)-subrep of a")
print("       tensor power, NOT a polynomial functor; the quantifier misses it.")

print()
print("=" * 74)
print("(C) is the Ricci part {h (x) g_n} of C_n closed under zero-padding?")
for n0, n in [(4, 5), (5, 6), (6, 7)]:
    for name, h in [("h = I  (the round sphere)", I(n0)),
                    ("h = diag(1,0,...,0)", np.diag([1] + [0]*(n0-1)).astype(np.int64)),
                    ("h generic", np.diag(list(range(1, n0+1))).astype(np.int64))]:
        T = pad4(kn(h, n0), n0, n)
        wp = int(np.abs(weyl_part(T, n)).max())
        print(f"    {n0} -> {n}  {name:<26} Weyl part of the padding is zero: "
              f"{str(wp == 0):>5}")
print("    => only the h proportional to I survive; the Ricci part is NOT a")
print("       consistent subsequence, so (Sums) cannot decompose {C_n}.")

print()
print("=" * 74)
print("(D) Theorem 2.11 (Images and kernels) needs A* to be a morphism, i.e.")
print("    Ric to commute with TRUNCATION.  Does it?")
for n0, n in [(4, 5), (5, 6)]:
    Cb = L.nullspace(curv_constraints(n))
    bad = 0
    for row in Cb[:80]:
        T = np.array(row, dtype=np.int64).reshape(n, n, n, n)
        if ((ric(T)[:n0, :n0] - ric(T[:n0, :n0, :n0, :n0])) % L.P).any():
            bad += 1
    print(f"    n = {n} -> {n0}:  basis curvature tensors on which they disagree: "
          f"{bad} of {min(80, Cb.shape[0])}   (dim C_{n} = {Cb.shape[0]})")
    assert bad, "Ric would commute with truncation, contradicting (D)"
print("    => the kernel clause does not apply.  Theorem 2.11 yields NO k_B for")
print("       {W_n}; the transfer theorem's parenthetical 'finite' is unsupported.")

print()
print("=" * 74)
print("(E) generation degree of Sym^l(W_n) over B_n, hence a lower bound on k_B")
B4 = L.nullspace(np.vstack([curv_constraints(4), ricci_constraints(4)]))
print(f"    dim W_4 = {B4.shape[0]} (expected 10)")
col = ((0 * 4 + 1) * 4 + 2) * 4 + 3
print(f"    some W in W_4 has W_1234 != 0 :  {bool((B4[:, col] % L.P).any())}")
assert (B4[:, col] % L.P).any()
print("    => l Weyl tensors on disjoint 4-subsets give a monomial of support 4l,")
print("       unreachable from Sym^l(W_d) for d < 4l.")
for l in (3, 6):
    verdict = "n_0 = 12 needs k_B = 12 EXACTLY" if l == 3 else "> 12 = n_0 -- HYPOTHESIS FAILS"
    print(f"    gen deg Sym^{l}(W) = {4*l:2d}   =>   k_B >= {4*l:2d}   {verdict}")
