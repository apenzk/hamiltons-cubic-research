import pickle, json
R = WeylCharacterRing("D6"); V = R(2,2,0,0,0,0)
d = {}
for w,m in V.weight_multiplicities().items():
    key = tuple(int(c) for c in w.to_vector())
    d[str(list(key))] = int(m)
json.dump(d, open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/w12.json","w"))
print("weights", len(d), "dim", sum(d.values()))
