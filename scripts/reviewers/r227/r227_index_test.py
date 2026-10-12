"""r227, claim 3/4 witness.

Levin-Chandrasekaran, Section 1.3 (paper.pdf, extracted txt.txt line 795-797):

    "the induced representation of G from V is Ind^G_H(V) = R[G] (x)_{R[H]} V.
     We have dim Ind^G_H(V) = |G/H| dim V, and we apply this notion only when
     H has finite index in G."

Definition 2.6 builds algebraically free V-modules out of Ind^{G_n}_{G_d H_{n,d}} W.
Definition 2.7 defines the presentation degree only via such a free module.
So a finite presentation degree EXISTS only when [G_n : G_d H_{n,d}] < infinity.

This script computes that index for the four group sequences the paper names in
Example 2.8 as carrying the consistent sequence V_0 = {R^n} with zero-padding:
S_n, B_n, D_n and O_n.  H_{n,d} = elements fixing the first d coordinates.

Discriminator check (the "planted violation"): the test must PASS for S_n/B_n/D_n
-- for which the paper does state presentation degrees -- and FAIL for O_n.
"""

from math import comb, factorial


def index_Sn(n, d):
    # H_{n,d} = S_{n-d}; G_d H_{n,d} = S_d x S_{n-d}
    return factorial(n) // (factorial(d) * factorial(n - d))


def index_Bn(n, d):
    # |B_n| = 2^n n!; G_d H_{n,d} = B_d x B_{n-d}
    return (2**n * factorial(n)) // (2**d * factorial(d) * 2**(n - d) * factorial(n - d))


def index_Dn(n, d):
    # |D_n| = 2^(n-1) n!.  G_d H_{n,d} = (B_d x B_{n-d}) cap D_n, order
    # 2^(d-1+n-d-1)*2 * d!(n-d)! = 2^(n-1) d!(n-d)!  for 0<d<n.
    return (2**(n - 1) * factorial(n)) // (2**(n - 1) * factorial(d) * factorial(n - d))


def index_On(n, d):
    # H_{n,d} = O(n-d) acting on the last n-d coordinates; G_d H_{n,d} = O(d) x O(n-d).
    # O(n)/(O(d) x O(n-d)) is the real Grassmannian Gr(d, n), a compact manifold of
    # dimension d(n-d) > 0 for 0 < d < n, hence of infinite cardinality.
    if 0 < d < n:
        return float("inf")
    return 1


def dim_grassmannian(n, d):
    return d * (n - d)


if __name__ == "__main__":
    print(f"{'n':>3} {'d':>3} | {'[Sn:.]':>10} {'[Bn:.]':>12} {'[Dn:.]':>10} "
          f"{'[On:.]':>8}  dim Gr(d,n)")
    ok_finite, ok_infinite = True, True
    for n in (4, 6, 8, 12):
        for d in (1, 2, 4):
            if d >= n:
                continue
            iS, iB, iD, iO = index_Sn(n, d), index_Bn(n, d), index_Dn(n, d), index_On(n, d)
            print(f"{n:>3} {d:>3} | {iS:>10} {iB:>12} {iD:>10} {str(iO):>8}"
                  f"  {dim_grassmannian(n, d):>11}")
            ok_finite &= all(x < float("inf") for x in (iS, iB, iD))
            ok_infinite &= (iO == float("inf"))

    print()
    print("finite index for S_n, B_n, D_n (paper states presentation degrees):",
          "PASS" if ok_finite else "FAIL")
    print("infinite index for O_n (paper states NO presentation degree):",
          "PASS" if ok_infinite else "FAIL")
    print()
    print("CONSEQUENCE: for {G_n} = {O_n} with V_0 = {R^n}, Definition 2.6 admits no")
    print("nonzero finite-dimensional algebraically free V_0-module, so Definition 2.7")
    print("assigns NO finite presentation degree k to ANY nonzero V_0-module.")
    print("Theorem 3.4 and Theorem 3.5 both open with 'fix n_0 >= k'.  That hypothesis")
    print("is therefore unsatisfiable for O(n) as the paper is literally written.")
