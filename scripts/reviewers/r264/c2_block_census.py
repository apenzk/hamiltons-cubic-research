"""r264 / claim 2: does the seed lemma reach all 71 blocks?  Census of the
n >= 12 table, read from the record's own stored decomposition."""
import pickle, collections
d = pickle.load(open('scripts/runs/n12_sym3_blocks.pkl', 'rb'))
O = {tuple(abs(x) for x in k if x): v for k, v in d.items()}   # SO chiral pairs merge
def conj(l): return tuple(sum(1 for p in l if p > k) for k in range(l[0])) if l else ()
def cols2(l):
    c = conj(l); return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0)
print(f"O(n>=12) blocks: {len(O)}   multiplicities: {sum(O.values())}   (record says 71 / 184)")
print(f"SO(12) entries: {len(d)}   multiplicities: {sum(d.values())}   (record says 77 / 191)")
print(f"all |lambda| even: {all(sum(l) % 2 == 0 for l in O)}    max |lambda|: {max(sum(l) for l in O)}")
print(f"max lambda'_1 + lambda'_2: {max(cols2(l) for l in O)}  -- so every block is O(n)-admissible at every n >= 12")
k = collections.Counter((12 - sum(l)) // 2 for l in O)
print("\nk = (12-|lambda|)/2 over the 71 blocks:")
for kk in sorted(k): print(f"    k = {kk}: {k[kk]:>3} blocks" + ("   <-- NO PADDING AT ALL, c_0 = iota_lambda" if kk == 0 else ""))
so12 = collections.Counter(sum(abs(x) for x in kk) for kk in d)
print(f"\n|lambda| = 12 blocks: {k[0]} in the O table (71 blocks), {so12[12]} in the SO(12) table (77 entries)")
print("   findings/brauer-pairing.md and findings/INDEX.md say 19; the certificate's own table has 16")
