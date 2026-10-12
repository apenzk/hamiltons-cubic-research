#!/usr/bin/env python3
"""r178: proof-by-witness that C = c_2*Id does NOT validate an so(5) action.
Basis L_ij = E_ij - E_ji (i<j), 10 elements, orthonormal for -1/2 tr(XY).
C = -sum_a X_a X_a.  Replacing X_a by Y_a = sum_b O_ab X_b with O orthogonal
leaves sum_a Y_a Y_a IDENTICALLY unchanged, while brackets break."""
from sympy import Matrix, zeros, eye
n=5
idx=[(i,j) for i in range(n) for j in range(i+1,n)]
def L(i,j):
    M=zeros(n,n); M[i,j]=1; M[j,i]=-1; return M
X=[L(i,j) for i,j in idx]
def br(A,B): return A*B-B*A
# structure constants c_abc: [X_a,X_b] = sum_c c_abc X_c   (basis is a basis of so(5))
def coords(M):
    return [M[i,j] for i,j in idx]
C_struct=[[coords(br(X[a],X[b])) for b in range(10)] for a in range(10)]
Cas = -sum((X[a]*X[a] for a in range(10)), zeros(n,n))
print("Casimir on vector rep:", set(Cas[i,i] for i in range(n)), "offdiag zero:", all(Cas[i,j]==0 for i in range(n) for j in range(n) if i!=j))
def failures(Y):
    f=0
    for a in range(10):
        for b in range(a+1,10):
            lhs=br(Y[a],Y[b])
            rhs=sum((C_struct[a][b][c]*Y[c] for c in range(10)), zeros(n,n))
            if lhs!=rhs: f+=1
    return f
best=[]
for s in range(10):
    for t in range(s+1,10):
        Y=list(X); Y[s],Y[t]=Y[t],Y[s]
        CasY=-sum((Y[a]*Y[a] for a in range(10)), zeros(n,n))
        assert CasY==Cas, "Casimir changed!"
        best.append((failures(Y), idx[s], idx[t]))
best.sort()
print("transposition witnesses (failed relations of 45, swapped pair):")
for f,p,q in best[:6]: print("  ", f, p, q)
print("  max:", best[-1][0])
print("ALL 45*... : every transposition leaves the Casimir EXACTLY equal:", True)

print("--- single sign flips (also orthogonal, Casimir exactly unchanged) ---")
res=[]
for s in range(10):
    Y=list(X); Y[s]=-Y[s]
    assert -sum((Y[a]*Y[a] for a in range(10)), zeros(n,n))==Cas
    res.append((failures(Y), idx[s]))
res.sort(); print(res[:3], "... max", res[-1][0])
print("--- global sign flip Y_a = -X_a ---")
Y=[-M for M in X]
assert -sum((Y[a]*Y[a] for a in range(10)), zeros(n,n))==Cas
print("failures:", failures(Y), "of 45; Casimir unchanged")
