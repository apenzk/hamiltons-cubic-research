# r215 claim 2: Sage's own Sym^3 of V(2,2,0,0,0,0) for D_6, decomposed.
import json, time
t0 = time.time()
Rc = WeylCharacterRing("D6")
chi = Rc(2,2,0,0,0,0)
s3 = chi.symmetric_power(3)
print("elapsed", time.time()-t0)
print("degree:", s3.degree())
d = s3.monomial_coefficients()
out = {}
for k, v in d.items():
    out[",".join(str(ZZ(x)) for x in k.to_vector())] = int(v)
print("constituents:", len(out), "total multiplicity:", sum(out.values()))
json.dump(out, open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/sage_sym3_blocks.json","w"))
