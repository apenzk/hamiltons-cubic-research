import json, os, ast
d = json.load(open(os.path.join(os.path.dirname(__file__), 'sym3_d6.json')))
blocks = {ast.literal_eval(k): v for k, v in d['blocks'].items()}
dims   = {ast.literal_eval(k): v for k, v in d['dims'].items()}
inv    = {ast.literal_eval(k): v for k, v in d['invH0'].items()}

print('D6 (SO(12)) blocks:', len(blocks), ' total multiplicity', sum(blocks.values()))
chiral = sorted([l for l in blocks if l[-1] != 0])
print('chirality-pair constituents (lam_6 != 0):', len(chiral))
for l in chiral:
    print('   ', l, 'm=', blocks[l], 'd=', dims[l])

# fuse into O(12) blocks
O = {}
for l, m in blocks.items():
    key = tuple(list(l[:-1]) + [abs(l[-1])])
    if key not in O:
        O[key] = {'m': m, 'd': 0, 'inv': 0}
    O[key]['d'] += dims[l]
    O[key]['invSO'] = O[key].get('invSO', 0) + inv[l]
    assert O[key]['m'] == m
for k in O:
    O[k]['alleven'] = all(x % 2 == 0 for x in k)
print()
print('O(12) blocks:', len(O), ' total multiplicity', sum(v['m'] for v in O.values()))
print('sum m*d      :', sum(v['m']*v['d'] for v in O.values()))
unk = sum(v['m']*(v['m']+1)//2 for v in O.values())
print('unknowns     :', unk, '  largest multiplicity', max(v['m'] for v in O.values()))

ev = {k: v for k, v in O.items() if v['alleven']}
print()
print('O(12) blocks with ALL PARTS EVEN (dim V^{O(6)xO(6)} = 1):', len(ev))
tot = 0
for k in sorted(ev, key=lambda x: (-sum(x), x)):
    v = ev[k]
    print('   %-22s m=%d  d=%-10d  dimV^{SO6xSO6}=%d' % (str(k), v['m'], v['d'], v['invSO']))
    tot += v['m']
print('sum of their multiplicities        :', tot)
print('sum of their dimensions            :', sum(v['d'] for v in ev.values()))
print()
odd = {k: v for k, v in O.items() if not v['alleven'] and v['invSO']}
print('blocks with an SO6xSO6 invariant but NOT all-even:', len(odd), odd)
print()
print('=== ORBIT REDUCTION AT n=12, upper bound on the cut ===')
print('multiplicities 191(SO)/%d(O)  ->  %d' % (sum(v['m'] for v in O.values()),
                                                sum(v['m'] for v in O.values()) - tot))
newunk = sum((v['m']-(1 if v['alleven'] else 0))*(v['m']-(1 if v['alleven'] else 0)+1)//2
             for v in O.values())
print('unknowns %d -> %d   (cut %.1f%%)' % (unk, newunk, 100*(unk-newunk)/unk))
print('for comparison n=5: 65 -> 36 (cut 44.6%)')

print()
print('=== refining by the factor-swap sigma in Stab(W*) ===')
print('sigma: A -> A^perp on Gr_6(R^12); P = 2*Pi_A - I -> -P, so sigma acts on the')
print('[2mu] line (which first appears in degree |mu| polynomials in P) by (-1)^{|mu|}.')
sw = {k: v for k, v in ev.items() if (sum(k)//2) % 2 == 0}
print('all-even blocks with |lam|/2 EVEN (dim V^{Stab} = 1):', len(sw))
for k in sorted(sw, key=lambda x: (-sum(x), x)):
    print('   %-22s m=%d  |lam|=%d' % (str(k), sw[k]['m'], sum(k)))
t2 = sum(v['m'] for v in sw.values())
print('sum of their multiplicities:', t2)
nu2 = sum((v['m']-(1 if k in sw else 0))*(v['m']-(1 if k in sw else 0)+1)//2 for k, v in O.items())
print('unknowns %d -> %d   (cut %.1f%%)' % (unk, nu2, 100*(unk-nu2)/unk))
