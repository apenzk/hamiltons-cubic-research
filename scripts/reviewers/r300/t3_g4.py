"""G4: derive tr(L_X) = 0 on Weyl_n and test its exact hypotheses."""
import sys; sys.path.insert(0,'scripts/reviewers/r300')
import numpy as np, core300 as C
rng = np.random.default_rng(300)

print("=== (a) tr(L_X) at RANDOM (non-critical) X in Weyl_n ===")
for n in (5,6,7,8,9,10):
    B = C.weyl_basis(n); D=len(B)
    x = rng.standard_normal(D); X = np.einsum('k,kij->ij',x,B); X/=np.linalg.norm(X)
    M,_ = C.Le_matrix(n,X)
    QX=C.Q(n,X); th=float(np.tensordot(X,QX)); res=float(np.linalg.norm(QX-th*X))
    # tr(L_e|W^perp) with e = X/P(X), no criticality
    e = X/th; Me,_ = C.Le_matrix(n,e)
    w = C.to_coords(n,X); w/=np.linalg.norm(w)
    print(f"  n={n:2d} dim={D:4d} noncrit_res={res:.2e}  tr(L_X)={float(np.trace(M)):+.2e}"
          f"  <X,L_eX>={float(w@Me@w):.12f}  tr(L_e|X^perp)={float(np.trace(Me)-w@Me@w):+.12f}")

print()
print("=== (b) the two ingredients of the derivation ===")
for n in (5,6,7,8,9,10):
    B = C.weyl_basis(n); D=len(B); N=B.shape[1]
    S = np.einsum('kij,kjl->il', B, B)            # sum_k B_k^2
    c = D/N
    print(f"  n={n:2d}: || sum_k B_k^2 - (dim/N) I || = {np.linalg.norm(S-c*np.eye(N)):.2e}   (dim/N = {c:.6f})")
    # tr(W)=0 for W in Weyl (scalar curvature); and the two halves of the trace
    x = rng.standard_normal(D); X=np.einsum('k,kij->ij',x,B); X/=np.linalg.norm(X)
    part1 = sum(float(np.trace(Bk@(X@Bk+Bk@X)/2)) for Bk in B)
    part2 = sum(float(np.tensordot(Bk, C.sharp_bilin(n,X,Bk))) for Bk in B)
    print(f"        tr(X)={float(np.trace(X)):+.2e}  half1=sum<B,(XB+BX)/2>={part1:+.3e}  half2=sum<B,sharp(X,B)>={part2:+.3e}")

print()
print("=== (c) does the identity survive if Ricci-flatness is dropped? ===")
# work in the larger space: Bianchi-only (algebraic curvature tensors), which HAS a trivial summand
for n in (5,6):
    prs,idx=C.pairs_of(n); N=len(prs)
    S=[]
    for a in range(N):
        E=np.zeros((N,N)); E[a,a]=1.0; S.append(E)
    for a in range(N):
        for b in range(a+1,N):
            E=np.zeros((N,N)); E[a,b]=E[b,a]=1/np.sqrt(2); S.append(E)
    S=np.array(S)
    rows=[C.alt_defect(n,E) for E in S]
    M=np.array(rows).T
    u,s,vt=np.linalg.svd(M,full_matrices=True)
    r=int((s>1e-9*s[0]).sum()); ker=vt[r:]
    Bc=np.einsum('kd,dij->kij',ker,S)
    D=len(Bc)
    # L_X on the curvature space, X = identity operator (constant curvature, Ric != 0)
    Xc = np.eye(N)/np.linalg.norm(np.eye(N))
    tr = 0.0
    for Bk in Bc:
        tr += float(np.tensordot(Bk, C.circ(n,Xc,Bk)))
    print(f"  n={n}: dim(Bianchi-only)={D}  tr(L_X) on that space, X=I/|I| (Ric != 0): {tr:+.6f}")
    # and a Weyl element traced over the BIGGER space
    Bw=C.weyl_basis(n)
    xw=rng.standard_normal(len(Bw)); Xw=np.einsum('k,kij->ij',xw,Bw); Xw/=np.linalg.norm(Xw)
    trw = sum(float(np.tensordot(Bk, C.circ(n,Xw,Bk))) for Bk in Bc)
    print(f"        tr over the BIGGER space of L_X for X in Weyl_n: {trw:+.3e}")
