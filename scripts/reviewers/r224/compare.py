import json, re, sys
n = int(sys.argv[1])
pred = {tuple(json.loads(k)): v for k, v in json.load(open('scripts/reviewers/r224/pred_so_%d.json' % n)).items()}
got = {}
for ln in open('agent_logs/r224_n%d.log' % n):
    m = re.match(r'\s+\[([\-0-9, ]+)\]\s+x(\d+)', ln)
    if m: got[tuple(int(x) for x in m.group(1).split(','))] = int(m.group(2))
print("n=%d  predicted %d blocks/%d mult   computed %d blocks/%d mult" % (n, len(pred), sum(pred.values()), len(got), sum(got.values())))
d = {k: (pred.get(k), got.get(k)) for k in set(pred) | set(got) if pred.get(k) != got.get(k)}
print("  block-by-block mismatches:", len(d))
for k, v in sorted(d.items())[:20]: print("    ", list(k), "pred", v[0], "got", v[1])
