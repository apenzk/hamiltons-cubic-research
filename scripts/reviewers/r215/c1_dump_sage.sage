import json
Rc = WeylCharacterRing("D6")
chi = Rc(2,2,0,0,0,0)
wm = chi.weight_multiplicities()
out = {}
for w, m in wm.items():
    out[",".join(str(ZZ(x)) for x in w.to_vector())] = int(m)
json.dump(out, open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/sage_chi.json","w"))
print("dumped", len(out))
