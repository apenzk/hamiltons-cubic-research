"""Validate r971's GREAT-CIRCLE identity, which reopens R28 and subsumes batch 21 and
batch 29 as two coefficients of one object.  A finding of that reach gets checked.

Phi(p) = a tr U^3 + b tr(U V^2) + tr(U A) + tr(V C),   T = (3/2)tr U^2 + (1/2)tr V^2.
p is made CRITICAL by construction: A, C are set to their Lagrange forms at a chosen mu.
Z = (X,Y) is tangent, 3 tr(UX) + tr(VY) = 0, normalised to 3|X|^2+|Y|^2 = 2T.
gamma(t) = cos t * p + sin t * Z.

Claimed:  Phi(gamma) - Phi(p) = -(1/2) Phi(p) (c-1)^2 (c+2) + (1/2) c s^2 Q(Z)
                                 + s^3 (Xi(Z) - S(Z))
with Q(Z) batch 21's form, Xi(Z) = a tr X^3 + b tr(X Y^2), S(Z) = D Psi(p)[Z].
"""
import numpy as np
rng=np.random.default_rng(31337)
AF,BF=15/4,9/4
def sym():
    M=rng.normal(size=(3,3)); M=(M+M.T)/2; return M-np.trace(M)/3*np.eye(3)
tr=np.trace

worst=0.0; worst_S=0.0
for _ in range(4000):
    U=sym(); V=sym(); mu=rng.normal()*2
    A=(3*mu)*U-(3*AF)*(U@U)-BF*(V@V)          # Lagrange forms: p is critical
    C=mu*V-BF*(U@V+V@U)
    T=1.5*tr(U@U)+0.5*tr(V@V)
    # a tangent direction, then normalised to |Z| = |p|
    X=sym(); Y=sym()
    lam=(3*tr(U@X)+tr(V@Y))/(3*tr(U@U)+tr(V@V))
    X=X-lam*U; Y=Y-lam*V                       # project onto the tangent space
    nz=3*tr(X@X)+tr(Y@Y)
    k=np.sqrt(2*T/nz); X*=k; Y*=k
    assert abs(3*tr(U@X)+tr(V@Y))<1e-9

    Phi=lambda Uu,Vv: AF*tr(Uu@Uu@Uu)+BF*tr(Uu@Vv@Vv)+tr(Uu@A)+tr(Vv@C)
    Phi0=Phi(U,V)
    Q=6*AF*tr(U@X@X)+4*BF*tr(X@V@Y)+2*BF*tr(U@Y@Y)-mu*(3*tr(X@X)+tr(Y@Y))
    Xi=AF*tr(X@X@X)+BF*tr(X@Y@Y)
    S=3*AF*tr(U@U@X)+BF*tr(V@V@X)+2*BF*tr(U@V@Y)
    worst_S=max(worst_S,abs(S+(tr(A@X)+tr(C@Y))))   # S = -(<A,X>+<C,Y>)

    for t in (0.3,0.9,1.7,2.6):
        c,s=np.cos(t),np.sin(t)
        lhs=Phi(c*U+s*X, c*V+s*Y)-Phi0
        rhs=-0.5*Phi0*(c-1)**2*(c+2)+0.5*c*s**2*Q+s**3*(Xi-S)
        worst=max(worst,abs(lhs-rhs))

print("4000 critical points, 4 angles each:")
print(f"  max |LHS - RHS| of the great-circle identity : {worst:.3e}")
print(f"  max |S(Z) + (<A,X> + <C,Y>)|                 : {worst_S:.3e}")
print()
print("If both are at machine precision the identity holds as stated, batch 21 sits at")
print("theta^2 and batch 29's comparison at finite c, so they are ONE object. The theta^3")
print("coefficient Xi - S carries no mu, which is why it escapes the sign obstruction.")
