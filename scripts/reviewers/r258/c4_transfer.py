"""r258 claim 4, part B -- what, if anything, transfers from n=5 to n=12.

Three questions:
  B1  is the projector the identity on everything the file reads?
  B2  does the n=5 block table stand in any relation to the n=12 one?
  B3  does r250's padding lemma apply to these carriers?
"""
import pickle
from fractions import Fraction as F

RAW = pickle.load(open("scripts/runs/n5_adapted.pkl", "rb"))
N12 = pickle.load(open("scripts/runs/n12_sym3_blocks.pkl", "rb"))

def dimB2(l): return (l[0]-l[1]+1)*(l[0]+l[1]+2)*(2*l[0]+3)*(2*l[1]+1)//6

# --- B1.  the copies are whole isotypic components, so P acts as the identity
print("B1  is every vector the file reads already inside V_lambda?")
tot = 0; bad = []
for lam, cs in RAW.items():
    d = dimB2(lam)
    for cp in cs:
        if len(cp) != d: bad.append((lam, len(cp), d))
        tot += len(cp)
print(f"  copies whose length differs from dim V_lambda: {len(bad)}")
print(f"  sum over blocks of m_lambda * dim V_lambda = {tot}")
print(f"  dim Sym^3(Weyl_5) = C(35+2,3) = {35*36*37//6}")
print("  => the copies exhaust Sym^3(Weyl_5) as whole so(5)-submodules, so the")
print("     isotypic projector P_lambda is the IDENTITY on every vector read.")
print("     r256's degree-3 hazard is a statement about vectors OUTSIDE V_lambda;")
print("     no such vector occurs in this file.")

# --- B2.  the two block tables ---------------------------------------------
print("\nB2  the n=5 table against the n=12 table")
m5 = sorted(len(c) for c in RAW.values())
print(f"  n=5   so(5) labels, rank 2 : {len(RAW)} blocks, {sum(m5)} copies, "
      f"max multiplicity {max(m5)}")
m12 = sorted(N12.values())
print(f"  n=12  so(12) labels, rank 6: {len(N12)} blocks, {sum(m12)} copies, "
      f"max multiplicity {max(m12)}")
print(f"  labels at n=5 are pairs, at n=12 six-tuples -- the two tables have no")
print(f"  label in common as written; n=5 is seven below the stability threshold")
print(f"  12, where sym3-stability.md says modification and associate")
print(f"  identification both fire.")
big = sorted(((v, k) for k, v in N12.items()), reverse=True)[:6]
print(f"  the n=12 blocks the certificate must actually handle: {big}")
print(f"  the widest block the file exercises: 4 columns, against 9.")
covered = [v for v in N12.values() if v <= max(m5)]
print(f"  n=12 blocks of multiplicity <= 4: {len(covered)} of {len(N12)}, "
      f"holding {sum(covered)} of {sum(m12)} copies")

# --- B3.  r250's padding hypothesis ----------------------------------------
print("\nB3  r250's transfer lemma against these carriers")
print("  r250: independence transfers along RESTRICTION T(f) = pi . f . iota,")
print("        and T(J_D^(n)) = (n/m)^L J_D^(m) needs the carrier to be a fixed")
print("        contraction DIAGRAM with n-independent coefficients.")
print("  the carriers here: dicts monomial-index -> Gaussian rational, i.e.")
print("        coefficient vectors in a basis of Sym^3(Weyl_5) chosen at n=5")
print("        by a BFS echelon over the two so(5) lowering generators.")
print("  so(5) has rank 2 and so(12) rank 6: the word alphabet the positions")
print("        index has 2 letters at n=5 and 6 at n=12, so 'position t' has no")
print("        n-independent meaning and no diagram is named anywhere.")
print("  the induced map Sym^3(iota) IS injective, so the 41 padded vectors are")
print("        independent in Sym^3(Weyl_12) -- but iota commutes only with")
print("        O(5) < O(12), so the images are not so(12)-isotypic and are not")
print("        the 184 covariants.  Independence of 41 vectors that are not the")
print("        objects in question is what transfers.")
