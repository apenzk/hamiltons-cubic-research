# r224: the top-degree part of Sym^3 of the O-universal character omega_{(2,2)}
# is the GL plethysm h_3[s_{22}] -- trace contractions only lower the degree.
# Step (c) of the argument stands or falls on s_{(2,2,2,2,2,2)} appearing there.
Sym = SymmetricFunctions(QQ); s = Sym.s(); h = Sym.h()
p = s(h[3].plethysm(s[2,2]))
print("h_3[s_22] has %d terms, degree %d" % (len(p.support()), 12))
mx_rows = max(len(la) for la in p.support())
print("max rows in h_3[s_22] =", mx_rows, "  (LR bound 3 x 2 = 6)")
print("coefficient of s_(2,2,2,2,2,2) =", p.coefficient([2,2,2,2,2,2]))
print("coefficient of s_(1^6 ...) check: partitions with 6 rows:")
for la in sorted(p.support(), key=lambda x: (-len(x), list(x))):
    if len(la) >= 5:
        c1 = len(la); c2 = sum(1 for x in la if x >= 2)
        print("   %-22s x%-3s rows=%d  col1+col2=%d" % (str(list(la)), p.coefficient(la), c1, c1+c2))
