# Reviewer 179: the stable Sym^3([2,2]) block table, computed at B6 = SO(13).
# n = 13 >= 4k = 12, so this is the stable decomposition; and at ODD n the O(n)
# blocks are in bijection with the SO(n) ones (-I acts trivially on Sym^3 Weyl),
# so no chirality fusion has to be undone -- unlike a D6 run.
B6 = WeylCharacterRing("B6", style="coroots")
lam = B6.from_highest_weight  if False else None
amb = B6.space()
W = B6(amb.from_vector(vector([2,2,0,0,0,0])).to_dominant_chamber()) if False else None
# build [2,2] directly from the ambient weight
hw = amb([2,2,0,0,0,0])
W13 = B6(hw)
print("dim Weyl_13 =", W13.degree(), " (expect 2275)")
psi = {k: W13.adams_operation(k) for k in (1,2,3)}
h1 = psi[1]
h2 = (psi[1]*h1 + psi[2])/2
h3 = (psi[1]*h2 + psi[2]*h1 + psi[3])/3
rows = []
for wt, m in h3.monomial_coefficients().items():
    l = list(B6(wt).highest_weight().to_ambient().to_vector())
    l = [int(x) for x in l]
    rows.append((tuple(l), B6(wt).degree(), int(m)))
rows.sort()
print("blocks:", len(rows))
print("sum m*dim =", sum(d*m for _,d,m in rows))
print("sum m     =", sum(m for _,_,m in rows))
print("unknowns  =", sum(m*(m+1)//2 for _,_,m in rows))
ev = [(l,d,m) for l,d,m in rows if all(x % 2 == 0 for x in l)]
print("ALL-EVEN blocks (spherical for the real Grassmannian):", len(ev))
print("  their multiplicities sum to", sum(m for _,_,m in ev))
print("  their dimensions sum to", sum(d for _,_,d in [(l,d,m) for l,d,m in ev]))
print("PREDICTED orbit cut at n=12: multiplicities", sum(m for _,_,m in rows), "->",
      sum(m for _,_,m in rows) - len(ev))
surv = sum((m-1)*m//2 for _,_,m in ev) + sum(m*(m+1)//2 for l,_,m in rows if not all(x%2==0 for x in l))
print("PREDICTED unknowns", sum(m*(m+1)//2 for _,_,m in rows), "->", surv)
for l,d,m in rows:
    print("   ", l, "dim", d, "mult", m, "EVEN" if all(x%2==0 for x in l) else "")
