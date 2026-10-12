# leaner variant of c3_littlewood.sage: no expand(), progress flushed.
import time, json, sys
Sym = SymmetricFunctions(QQ); s = Sym.schur(); h = Sym.homogeneous()
t0 = time.time()
W = s[2,2] - s[2]
F = s(h[3].plethysm(W))
print("plethysm built [%.0fs]; degrees:" % (time.time()-t0), sorted(set(sum(la) for la,c in F)), flush=True)
print("max rows:", max(len(la) for la,c in F), flush=True)
B = s(0)
for d in range(0, 13, 2):
    for beta in Partitions(d):
        if all(x % 2 == 0 for x in beta): B += s(beta)
print("B built [%.0fs]" % (time.time()-t0), flush=True)
res = {}
for d in range(0, 13):
    for mu in Partitions(d):
        if len(mu) > 6: continue
        m = F.scalar(s(mu)*B)
        if m: res[tuple(mu)] = ZZ(m)
    print("  degree %d done, %d blocks so far [%.0fs]" % (d, len(res), time.time()-t0), flush=True)
print("O(12) blocks: %d, total multiplicity %d" % (len(res), sum(res.values())), flush=True)
print("negatives:", {k:v for k,v in res.items() if v<0}, flush=True)
print("max rows among labels:", max(len(k) for k in res), flush=True)
json.dump({",".join(map(str,k)): int(v) for k,v in res.items()},
          open("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/o12_blocks.json","w"))
for k in sorted(res): print("   ", k, res[k])
