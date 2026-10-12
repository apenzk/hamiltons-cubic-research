import numpy as np, itertools
# 1. octahedron true parameters from the graph
A=np.ones((6,6))-np.eye(6)
for i in range(0,6,2): A[i,i+1]=A[i+1,i]=0
A2=A@A
lam={A2[i,j] for i in range(6) for j in range(6) if i!=j and A[i,j]==1}
mu ={A2[i,j] for i in range(6) for j in range(6) if i!=j and A[i,j]==0}
print("octahedron: k=",A.sum(1)[0]," lambda=",lam," mu=",mu)
print("SRG identity k(k-l-1)=(v-k-1)mu with (6,4,2,3):",4*(4-2-1),"vs",(6-4-1)*3)
print("SRG identity with (6,4,2,4):",4*(4-2-1),"vs",(6-4-1)*4)
# 2. octahedron diagonal W vs maximal torus so(2)^3 in so(6)
w=1; a=-np.sqrt(2.0*w/(6*4*5)); b=-a*4/w
M=a*A+b*(np.ones((6,6))-np.eye(6)-A)
print("\nM entries (a<0 branch): on-edge",a," on-nonedge",b)
print("nonedges of octahedron =",[(i,j) for i in range(6) for j in range(i+1,6) if A[i,j]==0])
# maximal torus so(2)^3: Pi_h - (r/N) I, h = span{phi_01,phi_23,phi_45}, r=3, N=15
lamW=np.array([1-3/15.]*3+[-3/15.]*12); lamW/=np.linalg.norm(lamW)
print("torus so(2)^3 spectrum, sorted:",np.sort(lamW)[::-1][:4],"... mult of max =",(np.abs(lamW-lamW.max())<1e-12).sum())
ev=np.sort(np.array([M[i,j] for i in range(6) for j in range(i+1,6)]))[::-1]
print("octahedron Lambda^2 spectrum, sorted:",ev[:4],"... mult of max =",(np.abs(ev-ev.max())<1e-12).sum())
print("MATCH as multisets:",np.allclose(np.sort(ev),np.sort(lamW)))
# 3. scan feasible SRG parameter sets for the saturation ratio conditions
print("\nfeasible (v,k,lam,mu) with k=v/2 or k=(v-2)/2:")
for v in range(5,61):
  for k in range(1,v-1):
    if 2*k not in (v,v-2): continue
    for l in range(0,k):
      num=k*(k-l-1); den=v-k-1
      if den and num%den==0:
        mu=num//den
        if 0<=mu<=k:
          # integrality of multiplicities
          disc=(l-mu)**2+4*(k-mu)
          if disc<0: continue
          s=int(round(np.sqrt(disc)))
          if s*s!=disc and not (2*k+(v-1)*(l-mu)==0): continue
          print(f"   v={v} k={k} lam={l} mu={mu}   {'K_mm' if (l==0 and mu==k) else ('2K_m' if mu==0 else 'OTHER<<<')}")
