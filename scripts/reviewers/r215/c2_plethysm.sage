# r215: a THIRD route to the top-degree part of the decomposition.
# In degree 12 the trace terms of the Weyl module are invisible, so the
# |lambda| = 12 constituents of Sym^3(Weyl_12) as O(12)-blocks coincide with the
# GL constituents of the plethysm h_3[s_{2,2}].  All of those have at most
# 3*2 = 6 rows, so every one is a legal O(12) label needing no modification rule.
Sym = SymmetricFunctions(QQ)
s = Sym.schur(); h = Sym.homogeneous()
p3 = s(h[3](s[2,2]))
d = {tuple(la): c for la, c in p3}
print("h_3[s_{2,2}] has", len(d), "constituents, total multiplicity", sum(d.values()))
print("max rows:", max(len(k) for k in d))
for k in sorted(d):
    print("   ", k, d[k])
import json
json.dump({",".join(map(str,k)): int(v) for k, v in d.items()},
          open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/plethysm12.json","w"))
