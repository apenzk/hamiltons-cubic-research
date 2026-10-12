"""r215: Sage's own symmetric_power(3) against my Racah blocks and the file's peel."""
import json, os, pickle
SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
SG = {tuple(int(x) for x in k.split(",")): v for k, v in json.load(open(SC+"/sage_sym3_blocks.json")).items()}
ME = pickle.load(open(SC+"/r215_blocks.pkl","rb"))
AU = pickle.load(open(SC+"/authorrun/n12_sym3_blocks.pkl","rb"))
print("Sage:", len(SG), "constituents, multiplicity", sum(SG.values()))
print("mine:", len(ME), "constituents, multiplicity", sum(ME.values()))
print("file:", len(AU), "constituents, multiplicity", sum(AU.values()))
print("Sage == mine:", SG == ME, "  Sage == file:", SG == AU)
for k in sorted(set(SG)|set(ME)):
    if SG.get(k,0) != ME.get(k,0): print("  DIFFER", k, SG.get(k,0), ME.get(k,0))
