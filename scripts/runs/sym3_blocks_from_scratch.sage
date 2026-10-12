# The 24 blocks of Sym^3(Weyl_5), derived rather than inverted.
#
# run_casimir_separation.py SOLVES for the twelve multiplicity-1 blocks by
# matching a RECORDED Casimir spectrum, so its table is conditional on that
# record (reviewer 177).  This computes the decomposition from the module
# itself, via Adams operations in the Weyl character ring, and depends on
# nothing the record supplies.
B2 = WeylCharacterRing("B2", style="coroots")
W5 = B2(0, 4)                                   # [2,2] = 4 omega_2
assert W5.degree() == 35

# dim 35 does NOT identify the module: V_(2,1) also has dimension 35, and
# reviewer 179 showed the decoy yields 20 blocks / 62 multiplicities / 168
# unknowns.  The Casimir separates them -- c_2(2,2) = 16 against c_2(2,1) = 12 --
# and run_n5_weyl_module.py reaches the same module from the DEFINITION
# (Lambda^2 -> Sym^2 -> Bianchi -> Ricci-traceless) with Casimir 16 exact.
lam = tuple(W5.highest_weight().to_ambient().to_vector()[:2])
assert (int(lam[0]), int(lam[1])) == (2, 2), f"wrong module: highest weight {lam}"
c2_of = lambda l: l[0]*(l[0]+3) + l[1]*(l[1]+1)
assert c2_of((int(lam[0]), int(lam[1]))) == 16, "Casimir is not 16"
print(f"module guarded: highest weight {(int(lam[0]), int(lam[1]))}, dim {W5.degree()}, c2 = 16")


psi = {k: W5.adams_operation(k) for k in (1, 2, 3)}
h1 = psi[1]
h2 = (psi[1]*h1 + psi[2]) / 2
h3 = (psi[1]*h2 + psi[2]*h1 + psi[3]) / 3

d = h3.monomial_coefficients()
c2 = lambda l: l[0]*(l[0]+3) + l[1]*(l[1]+1)
rows = []
for wt, m in d.items():
    lam = tuple(B2(wt).highest_weight().to_ambient().to_vector()[:2])
    lam = (int(lam[0]), int(lam[1]))
    rows.append((lam, B2(wt).degree(), int(m)))
rows.sort()
print(f"{len(rows)} blocks")
tot = 0
for lam, dim, m in rows:
    tot += m*dim
    print(f"  {lam}  dim {dim:4d}  mult {m}  c2 = {c2(lam):3d}")
print(f"sum m*dim = {tot}  (7770: {tot == 7770})")
print(f"sum m     = {sum(r[2] for r in rows)}  (41)")
print(f"unknowns  = {sum(m*(m+1)//2 for _,_,m in rows)}  (65)")
vals = [c2(l) for l,_,_ in rows]
print(f"c2 distinct: {len(set(vals))} of {len(vals)}  (21)")
m1 = sorted(l for l,_,m in rows if m == 1)
print(f"multiplicity-1 blocks: {m1}")
print(f"  their dimensions sum to {sum(dd for l,dd,m in rows if m==1)}  (4125)")
