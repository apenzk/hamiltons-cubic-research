"""The two 'other' grading conditions are ONE condition: total antisymmetry of c_abc."""
import numpy as np
from review_r47_core import *
from review_r47_t3 import cp_m

def split_leaks(g,M):
    N=g.N; w,U=np.linalg.eigh(M); tol=1e-9*max(1.0,np.abs(w).max()); neg=w<-tol
    Uad=np.concatenate([U[:,neg],U[:,~neg]],axis=1); dm=int(neg.sum())
    A=g.so_basis(); X=np.einsum('an,aij->nij',Uad,A)
    br=np.einsum('aik,bkj->abij',X,X)-np.einsum('bik,akj->abij',X,X)
    C=0.5*np.einsum('abij,cij->abc',br,X)
    m=slice(0,dm); h=slice(dm,N)
    hh_to_m = (C[h,h,m]**2).sum()      # [h,h] leaking into m
    hm_to_h = (C[h,m,h]**2).sum()      # [h,m] leaking out of m
    mm_to_m = (C[m,m,m]**2).sum()      # the slack S
    return dm, hh_to_m, hm_to_h, mm_to_m, (C[h,h,m][np.triu_indices(N-dm,1)]**2).sum()

g4,Wcp2=cp_m(2); g6=Geom(6); W33=sphere_product(g6,3,3)
print(f"{'point':26s} {'dim m':>5s} {'||[h,h]->m||^2':>15s} {'||[h,m]->h||^2':>15s} {'S':>10s} {'unordered a<b':>13s}")
for n in (8,10,12):
    g=Geom(n); dm,a,b,s,u = split_leaks(g,pad(g4,g,Wcp2))
    print(f"{'W_CP2 padded n='+str(n):26s} {dm:5d} {a:15.6f} {b:15.6f} {s:10.2e} {u:13.6f}")
for n in (8,10):
    g=Geom(n); dm,a,b,s,u = split_leaks(g,pad(g6,g,W33))
    print(f"{'S3xS3 padded n='+str(n):26s} {dm:5d} {a:15.6f} {b:15.6f} {s:10.2e} {u:13.6f}")
g=Geom(8); dm,a,b,s,u = split_leaks(g,sphere_product(g,4,4))
print(f"{'S4xS4 native n=8':26s} {dm:5d} {a:15.6f} {b:15.6f} {s:10.2e} {u:13.6f}")
print("\n=> [h,h]->m and [h,m]->h are the SAME sum of squares, identically:")
print("   c_abc = <[X_a,X_b],X_c> is totally antisymmetric on so(n), so a triple with")
print("   exactly one m-index contributes to both. The 'three grading conditions' are two.")
print("   With <X,Y> = tr(X^T Y) instead of (1/2)tr(X^T Y) each square halves:")
print(f"   W_CP2 padded n=8 gives {u/2:.3f} and n=10 gives ... (matches R30/31's 4.0 / 4.899 scale)")
g=Geom(10); dm,a,b,s,u=split_leaks(g,pad(g4,g,Wcp2)); print(f"   n=10: {u/2:.3f}   (R30/31 report 4.899 = sqrt(24))")
