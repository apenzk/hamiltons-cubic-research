"""r222 claim 1: is dim^1.77 supported, and does it survive the repo's own data?

Timings are read off the three committed run logs, NOT re-typed from the commit
message.  agent_logs/n12_mark.log, n12_tier3.log, n12_tail.log.
"""
import math, re, os, sys
d = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(d, "..", "..", "..")
LOGS = ["n12_mark.log", "n12_tier3.log", "n12_tail.log"]
pat = re.compile(r"^\s+(\([^)]*\))\s+dim\s+([\d,]+)\s+rows\s+([\d,]+)\s+nullity\s+(-?\d+)\s+\[build ([\d.]+)s, rank ([\d.]+)s\]")
rec = []
for L in LOGS:
    for line in open(os.path.join(ROOT, "agent_logs", L)):
        m = pat.match(line)
        if m:
            rec.append(dict(log=L, lam=m.group(1), n=int(m.group(2).replace(",","")),
                            rows=int(m.group(3).replace(",","")), nul=int(m.group(4)),
                            build=float(m.group(5)), rank=float(m.group(6))))
print(f"{len(rec)} timed blocks recovered from {len(LOGS)} logs\n")

# ---- 1. duplicates: how reproducible is one timing? --------------------------
from collections import defaultdict
byl = defaultdict(list)
for r in rec: byl[r["lam"]].append(r)
print("A. REPEATS OF THE SAME BLOCK (the noise floor the exponent inherits)")
for lam, rs in sorted(byl.items(), key=lambda kv: kv[1][0]["n"]):
    if len(rs) > 1:
        ts = [r["rank"] for r in rs]
        print(f"   {lam:22s} n={rs[0]['n']:>7,}  " +
              "  ".join(f"{t:8.1f}s({r['log'][4:-4]})" for t, r in zip(ts, rs)) +
              f"   spread {max(ts)/min(ts)-1:+.1%}")
print()

# ---- 2. local exponent along the sorted series -------------------------------
best = {}
for r in rec:                       # keep the FASTEST timing per block: most
    k = r["lam"]                    # generous to the claim under review
    if k not in best or r["rank"] < best[k]["rank"]: best[k] = r
S = sorted(best.values(), key=lambda r: r["n"])
print("B. LOCAL EXPONENT d(log t)/d(log n) BETWEEN CONSECUTIVE BLOCKS")
print(f"   {'lambda':22s} {'n':>8s} {'rows':>9s} {'t (s)':>9s} {'local k':>8s}")
for i, r in enumerate(S):
    if i == 0:
        k = ""
    else:
        p = S[i-1]
        k = f"{math.log(r['rank']/p['rank'])/math.log(r['n']/p['n']):8.2f}" if r["n"] != p["n"] else "    (tie)"
    print(f"   {r['lam']:22s} {r['n']:>8,} {r['rows']:>9,} {r['rank']:>9.1f} {k}")
print()

# ---- 3. the two points the commit used, and what the rest of the data says ----
def powfit(a, b):
    return math.log(b["rank"]/a["rank"])/math.log(b["n"]/a["n"])
def predict(base, n, k):
    return base["rank"]*(n/base["n"])**k
TRIV = 635220
print("C. THE COMMIT'S FIT AND ITS OUT-OF-SAMPLE TEST")
A = [r for r in rec if r["n"] == 27030 and r["rank"] < 600][0]     # 578.6, tail
B = [r for r in rec if r["n"] == 34731 and abs(r["rank"]-901.0) < 1][0]
k = powfit(A, B)
print(f"   commit's pair: {A['n']:,}->{A['rank']}s, {B['n']:,}->{B['rank']}s  =>  k = {k:.4f}")
print(f"   trivial block extrapolation: {predict(B, TRIV, k)/3600:.1f} h  (commit says ~42 h)")
# alternative duplicate choices
A2 = max((r for r in rec if r["n"] == 27030), key=lambda r: r["rank"])
B2 = max((r for r in rec if r["n"] == 34731), key=lambda r: r["rank"])
for a, b in [(A, B), (A, B2), (A2, B), (A2, B2)]:
    kk = powfit(a, b)
    print(f"   pair {a['rank']:7.1f}s / {b['rank']:7.1f}s -> k={kk:.3f}, trivial = {predict(b,TRIV,kk)/3600:8.1f} h")
print()
print("D. HELD-OUT POINT: the 62,101 block was already in n12_tier3.log")
H = [r for r in rec if r["n"] == 62101][0]
print(f"   measured                       : {H['rank']:.1f} s")
print(f"   predicted by k=1.77 from 34,731: {predict(B, H['n'], k):.1f} s"
      f"   -> under-predicts by {H['rank']/predict(B,H['n'],k):.2f}x over only {H['n']/B['n']:.2f}x in n")
# in-batch comparison, same log, same machine state
Bt = [r for r in rec if r["n"] == 34731 and r["log"] == "n12_tier3.log"]
for b in Bt:
    kk = powfit(b, H)
    print(f"   local exponent {b['lam']} -> {H['lam']} (same log): k = {kk:.3f}")
print()
print("E. WHAT EXPONENT PUTS THE TRIVIAL BLOCK AT A WEEK, AND IS IT EXCLUDED?")
for label, tgt in [("42 h", 42*3600), ("1 week", 7*24*3600), ("1 month", 30*24*3600)]:
    kk = math.log(tgt/H["rank"])/math.log(TRIV/H["n"])
    print(f"   from the 62,101 block, {label:8s} needs k = {kk:.3f}")
print("   observed local exponents at the top of the measured range: see B/D above")
print()
print("F. TWO-PARAMETER MODELS THAT FIT THE COMMIT'S TWO POINTS EXACTLY")
for name, f in [("t = a + b n^2", 2), ("t = a + b n^3", 3), ("t = a + b n^1.77", 1.77)]:
    b = (B["rank"]-A["rank"])/(B["n"]**f - A["n"]**f)
    a = A["rank"] - b*A["n"]**f
    t = a + b*TRIV**f
    print(f"   {name:18s} a={a:10.1f} b={b:.4g}  residual on both points = 0"
          f"   trivial = {t/3600:10.1f} h = {t/86400:7.1f} d")
print("   (all of these reproduce the two measured points EXACTLY, as the power")
print("    law does: two points cannot choose between two-parameter models.)")
print()
print("G. SAME MODELS SCORED ON THE HELD-OUT 62,101 POINT")
for name, f in [("a + b n^2", 2), ("a + b n^3", 3), ("c n^1.77", None)]:
    if f is None:
        p = predict(B, H["n"], k)
    else:
        b = (B["rank"]-A["rank"])/(B["n"]**f - A["n"]**f); a = A["rank"] - b*A["n"]**f
        p = a + b*H["n"]**f
    print(f"   {name:12s} predicts {p:8.1f} s   measured {H['rank']:.1f} s   ratio {H['rank']/p:.2f}")

print()
print("H. GLOBAL LOG-LOG REGRESSION OVER ALL 19 DISTINCT BLOCKS (fastest timing each)")
import statistics
xs = [math.log(r["n"]) for r in S]; ys = [math.log(r["rank"]) for r in S]
mx, my = statistics.mean(xs), statistics.mean(ys)
kk = sum((x-mx)*(y-my) for x,y in zip(xs,ys))/sum((x-mx)**2 for x in xs)
c = my - kk*mx
res = [y - (c+kk*x) for x,y in zip(xs,ys)]
print(f"   k_global = {kk:.3f}   -> trivial block = {math.exp(c)*TRIV**kk/3600:.1f} h")
print(f"   residual sd = {statistics.pstdev(res):.3f} in log t ({math.exp(statistics.pstdev(res))-1:+.1%})")
print("   regression restricted to the largest half of the range:")
T = S[len(S)//2:]
xs2=[math.log(r['n']) for r in T]; ys2=[math.log(r['rank']) for r in T]
mx2,my2=statistics.mean(xs2),statistics.mean(ys2)
k2=sum((x-mx2)*(y-my2) for x,y in zip(xs2,ys2))/sum((x-mx2)**2 for x in xs2)
c2=my2-k2*mx2
print(f"   k_upper  = {k2:.3f}   -> trivial block = {math.exp(c2)*TRIV**k2/3600:.1f} h "
      f"= {math.exp(c2)*TRIV**k2/86400:.1f} d")
print()
print("I. STRUCTURE AT FIXED SIZE (cost is not a function of n)")
print(f"   {'lambda':22s} {'n':>8s} {'rows/n':>7s} {'t':>9s} {'t/n^2 (us)':>11s}")
for r in S:
    print(f"   {r['lam']:22s} {r['n']:>8,} {r['rows']/r['n']:7.3f} {r['rank']:>9.1f} "
          f"{1e6*r['rank']/r['n']**2:>11.3f}")
pairs = [((4,0,0,0,0,0),(2,2,2,1,1,0)), ((3,1,1,1,0,0),(2,2,2,0,0,0))]
print("   near-equal dimensions, unequal cost:")
for a,b in pairs:
    ra = [r for r in S if r["lam"]==str(a)][0]; rb=[r for r in S if r["lam"]==str(b)][0]
    print(f"     {ra['lam']} n={ra['n']:,} t={ra['rank']:.1f}   vs {rb['lam']} n={rb['n']:,} "
          f"t={rb['rank']:.1f}  -> {abs(ra['n']-rb['n'])/max(ra['n'],rb['n']):.1%} in n, "
          f"{abs(ra['rank']-rb['rank'])/min(ra['rank'],rb['rank']):.1%} in t")
