"""How big are the weight spaces the n=5 route would need at n=12?  Measured.

Step 3 of the build is the 184 covariants.  At n=5 they came from HIGHEST-WEIGHT
VECTORS: work in the lambda weight space of Sym^3, intersect the kernels of the
simple raising operators, and read off the multiplicity space.  That took 86
seconds for 41 vectors, the largest weight space being 234.

Whether it transfers is a question about sizes, and the sizes are known now that
run_n12_sym3.py has the character.  This file reports them, and the answer
decides the route rather than colouring it.
"""
import os, pickle

d = os.path.dirname(os.path.abspath(__file__))
S3 = pickle.load(open(os.path.join(d, "n12_sym3_char.pkl"), "rb"))
B = pickle.load(open(os.path.join(d, "n12_sym3_blocks.pkl"), "rb"))
dims = sorted(((S3[l], l, B[l]) for l in B), reverse=True)

print("dim of the Sym^3(Weyl_12) weight space at each constituent's highest weight")
print(f"  constituents      : {len(dims)}")
print(f"  largest           : {dims[0][0]:,} at {dims[0][1]}")
print(f"  median            : {dims[len(dims)//2][0]:,}")
print(f"  smallest          : {dims[-1][0]:,} at {dims[-1][1]}")
print(f"  above 10,000      : {sum(1 for x in dims if x[0] > 10000)}")
print(f"  total over all {len(dims)}  : {sum(x[0] for x in dims):,}")
print(f"  n=5 comparison    : largest 234, and the whole basis was 7,770")
print()
for d0, l, m in dims[:6]:
    print(f"    {l}  dim {d0:>8,}  multiplicity {m}")

print()
print("THE ROUTE IS OPEN.  An earlier version of this file read these numbers")
print("as closing the highest-weight construction at n=12.  Reviewer 216")
print("refuted that, and the inference was wrong in four separate ways:")
print()
print("  1. THE COST PREMISE WAS FALSE.  The commit said '66 generators of size")
print("     1638x1638, 177 million entries'.  A highest-weight computation needs")
print("     the SIX SIMPLE raising operators, not all 66.  216 built Weyl_12")
print("     weight space by weight space in 2 seconds; the six operators carry")
print("     6,714 nonzeros between them, density 4.2e-4.")
print()
print("  2. THE ROUTE WAS RUN.  216 performed the n=5 construction at n=12 on")
print("     61 of 77 blocks and 131 of 191 multiplicities, 0 mismatches, at two")
print("     primes.  The largest completed weight space was 13,444, in 104 s.")
print("     The kernel dimension is certified rather than sampled: nullity over")
print("     Q is at least m_lambda, rank mod p is at most rank over Q, so")
print("     nullity_p = m_lambda pins it.")
print()
print("  3. THE BLOCK THAT CLOSED THE ROUTE NEVER NEEDED IT.  The trivial block")
print("     has multiplicity 2, and its multiplicity space is the cubic")
print("     O(12)-invariants -- spanned by contraction diagrams by the first")
print("     fundamental theorem, a theorem rather than an obligation.  The one")
print("     measurement that closed the route is taken at the one weight where")
print("     the alternative is free.")
print()
print("  4. THE COMPARISON WAS ABSOLUTE WHERE THE QUANTITY IS RELATIVE.  As a")
print("     fraction of Sym^3, the trivial weight space is 1/33 at n=5 and")
print("     1/1155 at n=12.  By its own metric the route improves 35-fold.")
print()
print("So the two constructions are BOTH available, and the diagram route is a")
print("choice rather than a necessity.  It still carries the span obligation the")
print("highest-weight route does not; what 216 adds is that the obligation is")
print("free exactly where it looked binding.")
