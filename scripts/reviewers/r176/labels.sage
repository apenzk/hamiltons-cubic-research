import json
Sym = SymmetricFunctions(QQ); s, h, o = Sym.s(), Sym.h(), Sym.o()
W = s[2,2] - s[2]
P = o(h[3].plethysm(W))
d = P.monomial_coefficients()
out = []
for lam, m in d.items():
    p = [int(x) for x in lam]
    out.append((p, int(m)))
out.sort(key=lambda t: (-sum(t[0]), t[0]))
json.dump(out, open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/labels.json","w"))
print(len(out), "blocks")
for p,m in out[:8]: print(p, m)
