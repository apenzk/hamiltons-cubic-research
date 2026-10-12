"""C6: is the cheap-basis obstruction real or a sampling artefact?

The screen "worst 3+3 cross-pair count <= 8" depends only on the underlying
4-regular loopless multigraph on the 6 vertices, and there are exactly 3
isomorphism classes of those with worst cut <= 8.  So the cheap family is
EXHAUSTIBLE: 3 graphs x 3^6 slot classes, no sampling anywhere.
"""
import sys, os, itertools, time, numpy as np
from itertools import combinations
d=os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0,os.path.join(d,"..","r179"))
import weyl_invariants as WI

V,K=6,6
P=65537
PAIRS=list(combinations(range(V),2))
SPLITS=[frozenset(c) for c in combinations(range(V),3) if 0 in c]
def worst(m):
    return max(sum(mult for (a,b),mult in m.items() if ((a in S)!=(b in S))) for S in SPLITS)
sols=[]
def rec(idx,deg,cur):
    if idx==len(PAIRS):
        if all(x==0 for x in deg): sols.append(dict(cur))
        return
    a,b=PAIRS[idx]
    for m in range(min(deg[a],deg[b]),-1,-1):
        deg[a]-=m; deg[b]-=m; cur[(a,b)]=m
        rec(idx+1,deg,cur); del cur[(a,b)]; deg[a]+=m; deg[b]+=m
rec(0,[4]*V,{})
def canon(m):
    best=None
    for perm in itertools.permutations(range(V)):
        key=tuple(sorted((tuple(sorted((perm[a],perm[b]))),v) for (a,b),v in m.items() if v))
        if best is None or key<best: best=key
    return best
byclass={}
for s in sols: byclass.setdefault(canon(s),s)
print(f"labelled 4-regular loopless multigraphs on 6 vertices: {len(sols)}")
print(f"isomorphism classes: {len(byclass)}")
for cap in (8,10,12):
    cls=[g for g in byclass.values() if worst(g)<=cap]
    print(f"  worst 3+3 cut <= {cap}: {len(cls)} iso classes, "
          f"{sum(1 for s in sols if worst(s)<=cap)} labelled")
print(f"  worst-cut values that occur: {sorted(set(worst(s) for s in sols))}")

PTS=[WI.random_weyl(5,P,np.random.default_rng(9000+t)) for t in range(25)]
def diagrams_of(g):
    """all slot assignments for graph g, as matchings of the 24 slots.
    Per vertex the 4 incident edge-ends are split into the {0,1} and {2,3}
    index pairs: 3 classes, the rest is W's own symmetry."""
    ends={v:[] for v in range(V)}
    eid=0
    edges=[]
    for (a,b),m in g.items():
        for _ in range(m):
            ends[a].append(eid); ends[b].append(eid); edges.append((a,b)); eid+=1
    choices=[]
    for v in range(V):
        e=ends[v]
        opts=[]
        for pair in combinations(range(4),2):
            if 0 not in pair: continue
            first=[e[i] for i in pair]; second=[e[i] for i in range(4) if i not in pair]
            opts.append((first,second))
        choices.append(opts)          # 3 per vertex
    out=[]
    for combo in itertools.product(*choices):
        slot={}
        for v,(first,second) in enumerate(combo):
            slot[(v,first[0])]=4*v+0; slot[(v,first[1])]=4*v+1
            slot[(v,second[0])]=4*v+2; slot[(v,second[1])]=4*v+3
        # careful with parallel edges: assign ends of the same edge distinctly
        used={}
        m=[]
        ok=True
        for ei,(a,b) in enumerate(edges):
            sa=slot.get((a,ei)); sb=slot.get((b,ei))
            if sa is None or sb is None: ok=False; break
            m.append((sa,sb))
        if ok and len(m)==12: out.append(m)
    return out

def rank_cols(cols):
    if not cols: return 0
    M=np.array(cols,dtype=np.int64).T%P
    nr,nc=M.shape; r=0
    for c in range(nc):
        nz=np.nonzero(M[r:,c])[0]
        if len(nz)==0: continue
        piv=r+nz[0]
        if piv!=r: M[[r,piv]]=M[[piv,r]]
        M[r]=M[r]*pow(int(M[r,c]),P-2,P)%P
        col=M[:,c].copy(); col[r]=0
        nzr=np.nonzero(col)[0]
        if len(nzr): M[nzr]=(M[nzr]-np.outer(col[nzr],M[r]))%P
        r+=1
        if r==nr: break
    return r


import sys
CAP=int(sys.argv[1]); MAX=int(sys.argv[2])
print(f"\n--- EXHAUSTIVE over worst cut <= {CAP} (maxsize {MAX}) ---",flush=True)
cols=[]; nd=0; skipped=0; t0=time.time()
for gi,g in enumerate([g for g in byclass.values() if worst(g)<=CAP]):
    for m in diagrams_of(g):
        v=WI.eval_diagram(PTS[0],m,K,P,maxsize=MAX)
        if v is None: skipped+=1; continue
        col=[WI.eval_diagram(W,m,K,P,maxsize=MAX)%P for W in PTS]
        nd+=1; cols.append(col)
    print(f"   graph {gi+1}: {nd} evaluated, {skipped} skipped, rank so far "
          f"{rank_cols(cols)}, {time.time()-t0:.0f}s",flush=True)
print(f"  diagrams evaluated: {nd}  skipped: {skipped}")
print(f"  RANK: {rank_cols(cols)}")
