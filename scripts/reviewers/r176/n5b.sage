R = WeylCharacterRing("B2", style="coroots")
V = R(0,4)
print("dim V =", V.degree(), " (Weyl_5)")
S3 = V.symmetric_power(3)
rows = []
tot = 0
for w, m in S3.monomial_coefficients().items():
    v = vector(QQ, w.to_vector())   # ambient e-coordinates
    l1, l2 = v[0], v[1]
    cas = l1*(l1+3) + l2*(l2+1)
    dim = R(w).degree()
    rows.append((cas, (l1,l2), dim, m))
    tot += dim*m
rows.sort()
print("blocks =", len(rows), "| total dim =", tot, "| Sym3 dim =", binomial(37,3))
print("mult sum =", sum(r[3] for r in rows), "| unknowns =", sum(r[3]*(r[3]+1)//2 for r in rows))
for r in rows: print("  c=%-3s lam=%-8s dim=%-5s mult=%s" % (r[0], r[1], r[2], r[3]))
cs = sorted(r[0] for r in rows)
print("casimirs:", cs)
print("distinct:", len(set(cs)))
ev = [r for r in rows if r[1][1] % 2 == 0]
print("even-second-label blocks:", len(ev), "| dim sum:", sum(r[2] for r in ev))
unk = sum(((r[3]-1 if r[1][1]%2==0 else r[3])*((r[3]-1 if r[1][1]%2==0 else r[3])+1))//2 for r in rows)
print("unknowns after orbit constraint:", unk)
shapes = {}
for cas,(l1,l2),dim,m in rows:
    mm = m-1 if l2%2==0 else m
    if mm>0: shapes[mm] = shapes.get(mm,0)+1
print("residual block shapes (size: count):", shapes)
