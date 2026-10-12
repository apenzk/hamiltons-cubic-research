import re, os, json, collections
S=os.environ.get("DAG_WORK","/tmp/dag/")
FIND="findings"
files=[os.path.join(FIND,f) for f in sorted(os.listdir(FIND)) if f.endswith(".md") and not f.startswith("INDEX")]
HEAD=re.compile(r'^#### (Lemma|Observation|Conjecture|Theorem|Corollary) L?(\d+)', re.M)
LINK=re.compile(r'\]\([^)]*\)')          # link targets: full of dots and anchors
MATH=re.compile(r'\$[^$]*\$')            # inline math also carries dots

def flatten(block):
    """Replace link targets and math with same-length filler so offsets survive,
    then sentences split on real full stops rather than on `.md)` and `1.5`."""
    b=LINK.sub(lambda m:" "*len(m.group(0)), block)
    b=MATH.sub(lambda m:"@"*len(m.group(0)), b)
    return b

rows=[]; kind={}
for f in files:
    t=open(f,encoding='utf-8').read()
    hs=[(m.start(),m.group(1),m.group(2)) for m in HEAD.finditer(t)]
    for k,(pos,knd,n) in enumerate(hs):
        end=hs[k+1][0] if k+1<len(hs) else len(t)
        # A block ends at the next heading of ANY level, not only the next
        # result heading: plan items relocated into findings/ sit under `### I`
        # and their citations would otherwise be charged to the lemma above.
        after = t.find('\n', hs[k][0]) + 1
        for stop in re.finditer(r'^#{1,4} ', t[after:end], re.M):
            end = after + stop.start(); break
        kind[n]=knd
        block=t[pos:end]; flat=flatten(block)
        for m in re.finditer(r'\bL(\d+)\b', flat):
            tgt=m.group(1)
            if tgt==n: continue
            a=max((flat.rfind(c,0,m.start()) for c in ('. ','.\n','\n\n','! ','? ')), default=-1)
            a=0 if a<0 else a+1
            b=min([x for x in (flat.find('. ',m.end()), flat.find('.\n',m.end()), flat.find('\n\n',m.end())) if x>=0] or [len(flat)])
            sent=" ".join(block[a:b+1].split())
            rows.append({"src":n,"tgt":tgt,"file":os.path.basename(f),"sent":sent[:400]})
json.dump({"rows":rows,"kind":kind}, open(S+"ctx.json","w"), indent=0)
print("mentions:",len(rows)," pairs:",len({(r['src'],r['tgt']) for r in rows}))
