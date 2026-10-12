# Independent weight multiplicities of the Weyl-tensor irrep, via Sage.
import json, sys
which = sys.argv[1]
if which == 'B2':
    R = WeylCharacterRing('B2')
    # e-basis (2,2) -> Dynkin labels (l1-l2, 2*l2) = (0,4)
    ch = R(2,2)
else:
    R = WeylCharacterRing('D6')
    ch = R(2,2,0,0,0,0)
print("ring", R, "elt", ch, "dim", ch.degree())
wm = ch.weight_multiplicities()
out = {}
for k,v in wm.items():
    out[",".join(str(x) for x in k.to_vector())] = int(v)
print("num distinct weights", len(out), "sum", sum(out.values()))
json.dump(out, open('scripts/reviewers/r177/wm_%s.json'%which,'w'))
