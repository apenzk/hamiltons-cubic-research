"""r201: det h over Q(i) on the 12 multiplicity blocks -- the cheap check that
198 removed and that catches coincident copies."""
import pickle
from fractions import Fraction as F
S=("/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/"
   "ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad/")
ex={k:[[(F(a),F(b)) for (a,b) in r] for r in v]
    for k,v in pickle.load(open(S+"r201_h_exact.pkl","rb")).items()}
def cm(x,y): return (x[0]*y[0]-x[1]*y[1], x[0]*y[1]+x[1]*y[0])
def cs(x,y): return (x[0]-y[0], x[1]-y[1])
def cd(x,y):
    d=y[0]*y[0]+y[1]*y[1]; return ((x[0]*y[0]+x[1]*y[1])/d,(x[1]*y[0]-x[0]*y[1])/d)
def det(M):
    M=[r[:] for r in M]; n=len(M); s=(F(1),F(0))
    for c in range(n):
        p=next((r for r in range(c,n) if M[r][c]!=(F(0),F(0))),None)
        if p is None: return (F(0),F(0))
        if p!=c: M[c],M[p]=M[p],M[c]; s=(-s[0],-s[1])
        s=cm(s,M[c][c])
        for r in range(c+1,n):
            f=cd(M[r][c],M[c][c])
            M[r]=[cs(a,cm(f,b)) for a,b in zip(M[r],M[c])]
    return s
for k in sorted(ex):
    d=det(ex[k]); print(f"  lambda={k} m={len(ex[k])}  det h = {d[0]} {'+' if d[1]>=0 else '-'} {abs(d[1])}i")
print("\ncoincident-copy control, (2,0) with copy 1 := copy 0:")
h=[[(F(1),F(0)),(F(1),F(0))],[(F(1),F(0)),(F(1),F(0))]]
print("  det =", det(h))

print("\nleading principal minors (positive-definiteness of h over Q(i)):")
for k in sorted(ex):
    ms=[det([r[:j+1] for r in ex[k][:j+1]]) for j in range(len(ex[k]))]
    print(f"  lambda={k}: " + ", ".join(f"{m[0]}" for m in ms)
          + f"   all real: {all(m[1]==0 for m in ms)}   all > 0: {all(m[0]>0 for m in ms)}")
