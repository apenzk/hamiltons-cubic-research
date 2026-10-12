# r215 claim 1: independent Sage check of the D_6 weight system of V(2,2,0,0,0,0).
R = WeylCharacterRing("D6", style="coroots")
L = RootSystem("D6").ambient_space()
lam = L([2,2,0,0,0,0])
# convert ambient weight to coroot (fundamental-weight) coordinates
cw = [ZZ(lam.inner_product(a.associated_coroot().to_ambient())) if False else 0 for a in []]
Rc = WeylCharacterRing("D6")          # ambient/"lattice" style: keys are tuples
chi = Rc(2,2,0,0,0,0)
print("Sage highest weight :", chi)
print("Sage dimension      :", chi.degree())
wm = chi.weight_multiplicities()
print("distinct weights    :", len(wm))
print("sum of mults        :", sum(wm.values()))
# dominant ones
W = WeylGroup("D6", prefix="s")
amb = RootSystem("D6").ambient_space()
dom = {}
for w, m in wm.items():
    v = tuple(QQ(x) for x in w.to_vector())
    # dominance for D6: v1>=v2>=...>=v5>=|v6|
    if all(v[i] >= v[i+1] for i in range(4)) and v[4] >= abs(v[5]):
        dom[v] = m
print("dominant weights and multiplicities:")
for v in sorted(dom, key=lambda t: (-sum(t), t)):
    print("   ", v, "mult", dom[v])
# orbit sizes
print("orbit sizes:")
for v in sorted(dom, key=lambda t: (-sum(t), t)):
    e = amb(list(v))
    orb = set()
    for w in W:
        orb.add(tuple(QQ(x) for x in (w.matrix()*e.to_vector())))
    print("   ", v, "orbit", len(orb))
print("total from dominant x orbit:", sum(dom[v]*len(set(tuple(QQ(x) for x in (w.matrix()*amb(list(v)).to_vector())) for w in W)) for v in dom))
