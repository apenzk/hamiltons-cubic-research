"""r247 claim 4: the criterion screen, given the cases it was built to exclude.

The screen in run_n12_diagram_independence.py is

    INDEP = [[1,0,0],[0,1,0],[0,0,1]]
    DEP   = INDEP + [[2,-1,0]]

with gram_rank_exact computing  G_ij = sum_k u_k v_k  -- the EUCLIDEAN dot
product, hardcoded.  It then asserts rank 3 in both cases and concludes "the
criterion is insensitive to redundancy".

Two objections, and the second is fatal.

(i)  THE MINIATURE IS ORTHONORMAL.  Its vectors are the standard basis.  Under a
     positive definite form the criterion is a theorem needing no validation at
     all; the screen therefore tests nothing that could have failed.

(ii) THE SCREEN CANNOT EXPRESS THE FAILURE MODE.  The pairing is not a free
     parameter of gram_rank_exact -- it is `sum(a*b for a,b in zip(u,v))`,
     literally the positive definite form.  So no input can make the screen see
     a singular Gram of independent vectors, which is exactly claim 1's failure
     mode.  Below, three plants that any honest screen must catch, all invisible
     to this one.
"""
from fractions import Fraction as F

# --- verbatim from the file under review (NOT edited; copied to be run on new
#     inputs), scripts/runs/run_n12_diagram_independence.py -------------------
def gram_rank_exact(vectors):
    k = len(vectors)
    G = [[sum(a*b for a, b in zip(u, v)) for v in vectors] for u in vectors]
    M = [row[:] for row in G]
    r = 0
    for c in range(k):
        pr = next((t for t in range(r, k) if M[t][c] != 0), None)
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]
        M[r] = [x / iv for x in M[r]]
        for t in range(k):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]
                M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        r += 1
    return r
# ---------------------------------------------------------------------------

def rank_plain(vectors, mod=None):
    """rank of the vectors themselves, by elimination -- the honest answer."""
    M = [list(v) for v in vectors]
    if not M:
        return 0
    cols = len(M[0]); r = 0
    for c in range(cols):
        pr = None
        for t in range(r, len(M)):
            nz = (M[t][c] % mod != 0) if mod else (M[t][c] != 0)
            if nz:
                pr = t; break
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        if mod:
            iv = pow(M[r][c], mod - 2, mod)
            M[r] = [(x * iv) % mod for x in M[r]]
            for t in range(len(M)):
                if t != r and M[t][c] % mod:
                    f0 = M[t][c]
                    M[t] = [(x - f0 * y) % mod for x, y in zip(M[t], M[r])]
        else:
            iv = M[r][c]
            M[r] = [x / iv for x in M[r]]
            for t in range(len(M)):
                if t != r and M[t][c] != 0:
                    f0 = M[t][c]
                    M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        r += 1
    return r

def gram_with_form(vectors, B):
    return [[sum(B[i][j]*u[i]*v[j] for i in range(len(u)) for j in range(len(v)))
             for v in vectors] for u in vectors]

def det_rank(G):
    k = len(G); M = [row[:] for row in G]; r = 0
    for c in range(k):
        pr = next((t for t in range(r, k) if M[t][c] != 0), None)
        if pr is None:
            continue
        M[r], M[pr] = M[pr], M[r]
        iv = M[r][c]; M[r] = [x/iv for x in M[r]]
        for t in range(k):
            if t != r and M[t][c] != 0:
                f0 = M[t][c]; M[t] = [x - f0*y for x, y in zip(M[t], M[r])]
        r += 1
    return r

print(__doc__)
print("=" * 72)

# --- PLANT 1: nondegenerate but INDEFINITE form, a totally isotropic plane ---
print("PLANT 1.  nondegenerate indefinite form, signature (2,2) on Q^4.")
B = [[F(1),F(0),F(0),F(0)],[F(0),F(1),F(0),F(0)],
     [F(0),F(0),F(-1),F(0)],[F(0),F(0),F(0),F(-1)]]
V = [[F(1),F(0),F(1),F(0)], [F(0),F(1),F(0),F(1)]]
G = gram_with_form(V, B)
print(f"   vectors: {[[str(x) for x in v] for v in V]}")
print(f"   true rank of the vectors           : {rank_plain(V)}")
print(f"   rank of the Gram in the REAL form  : {det_rank(G)}   (Gram = {[[str(x) for x in r] for r in G]})")
print(f"   what the screen's gram_rank_exact reports: {gram_rank_exact(V)}")
assert rank_plain(V) == 2 and det_rank(G) == 0, "plant 1 is not the case it claims"
assert gram_rank_exact(V) == 2, "the screen changed behaviour"
print("   => the vectors are INDEPENDENT and the Gram is the ZERO matrix, on a")
print("      form that is NONDEGENERATE.  So nondegeneracy is not the hypothesis;")
print("      ANISOTROPY is.  The screen reports 2 because it silently replaced")
print("      the form with the Euclidean one -- it cannot be shown this case.")
print()

# --- PLANT 2: the actual claim-1 failure mode, in miniature ------------------
print("PLANT 2.  a pairing on the AMBIENT space, functions living in a quotient.")
print("   This is the Bianchi witness of c1 in two dimensions: the ambient is")
print("   Q^2 with the Euclidean form, the covariants are the images under the")
print("   projection onto span(e1), and two ambient-independent vectors have")
print("   EQUAL images.")
Vamb = [[F(1),F(0)], [F(1),F(1)]]
Vfun = [[F(1)], [F(1)]]
print(f"   ambient vectors {[[str(x) for x in v] for v in Vamb]}, images {[[str(x) for x in v] for v in Vfun]}")
print(f"   ambient Gram rank (what the diagram gluing computes): {gram_rank_exact(Vamb)}")
print(f"   rank of the FUNCTIONS (what independence means)     : {rank_plain(Vfun)}")
assert gram_rank_exact(Vamb) == 2 and rank_plain(Vfun) == 1, "plant 2 mis-set"
print("   => nonsingular ambient Gram, DEPENDENT functions.  The screen reports")
print("      2 and the reduction reads that as independence.  This is exactly")
print("      c1_bianchi_witness.py, and the screen is structurally blind to it:")
print("      it is handed coordinate vectors, never the projection.")
print()

# --- PLANT 3: the same criterion mod p, which is how the repo computes -------
print("PLANT 3.  mod p = 10007, the modulus run_n5_diagram_gram.py uses.")
p = 10007
sol = None
for a in range(1, p):
    r = (-1 - a*a) % p
    for b in range(1, 200):
        if (b*b) % p == r:
            sol = (a, b); break
    if sol:
        break
a, b = sol
v = [1, a, b]
print(f"   isotropic vector mod {p}: v = {v},  v.v = {(1 + a*a + b*b) % p}")
Gp = [[(sum(x*y for x, y in zip(v, v))) % p]]
print(f"   1x1 Gram mod p = {Gp}  -> singular")
print(f"   rank of the single nonzero vector = {rank_plain([v], mod=p)}")
assert (1 + a*a + b*b) % p == 0 and rank_plain([v], mod=p) == 1
print("   => over F_p a single nonzero vector has a singular Gram.  Positive")
print("      definiteness -- the one hypothesis that makes the criterion true --")
print("      does not survive reduction mod p, and the repo's diagram machinery")
print("      is written mod 10007.")
print()
print("=" * 72)
print("VERDICT ON THE SCREEN.  It validates the criterion in the one regime")
print("where the criterion is a triviality (a positive definite form on an")
print("orthonormal set) and is structurally incapable of being shown any of the")
print("three regimes where it fails.  It is not evidence for the reduction.")
