import numpy as np
# Direct saturation scan over all FEASIBLE SRG parameter sets (superset of realisable graphs),
# using only closed forms: no graph built.
def feasible(v,k,l,m):
    if not (1<=k<=v-2 and 0<=l<=k-1 and 0<=m<=k): return False
    if k*(k-l-1)!=(v-k-1)*m: return False
    d=(l-m)**2+4*(k-m)
    if d<0: return False
    s=np.sqrt(d)
    if abs(s-round(s))>1e-9:
        return (2*k+(v-1)*(l-m)==0)   # conference-graph case
    s=round(s); r=(l-m+s)/2; ss=(l-m-s)/2
    f=((v-1)-(2*k+(v-1)*(l-m))/s)/2
    return abs(f-round(f))<1e-9
hits=[]
for v in range(5,201):
  for k in range(1,v-1):
    w=v-1-k
    for l in range(0,k):
      num=k*(k-l-1)
      if num%w: continue
      m=num//w
      if not feasible(v,k,l,m): continue
      a=np.sqrt(2.0*w/(v*k*(v-1)))
      F=((v-1)**2*l+2*k*(v-1)-k*k*v+w*w)/(w*w)
      for sg in (1,-1):
        aa=sg*a; bb=-aa*k/w
        lmax=max(aa,bb); lmin=min(aa,bb); th=aa*F
        if lmin>=0 or lmax<0: continue
        if abs(th-(lmin+(v-2)*lmax))<1e-12*max(1,abs(th)):
            hits.append((v,k,l,m,sg,th,np.sqrt(2*(v-1)*(v-2))/v))
print("SRG parameter sets whose diagonal critical point SATURATES Lemma 70 (theta = lmin+(n-2)lmax):")
for h in hits[:40]:
    v,k,l,m,sg,th,t0=h
    name = "K_{m,m}" if (l==0 and m==k) else ("2K_m" if m==0 else "OTHER<<<<")
    print(f"  v={v:3d} k={k:3d} lam={l:3d} mu={m:3d} sign(a)={sg:+d}  theta={th:.9f}  theta0(n)={t0:.9f}  {name}")
print("total:",len(hits))
# and the Lemma 73 saturation set within the family
print("\nSRG sets saturating Lemma 73 (max ratio = n-2):")
c=0
for v in range(5,61):
  for k in range(1,v-1):
    w=v-1-k
    for l in range(0,k):
      num=k*(k-l-1)
      if num%w: continue
      m=num//w
      if not feasible(v,k,l,m): continue
      if abs(max(k/w,w/k)-(v-2))<1e-12:
        print(f"  v={v} k={k} lam={l} mu={m}   ratio={max(k/w,w/k)} = n-2"); c+=1
print("total:",c)
