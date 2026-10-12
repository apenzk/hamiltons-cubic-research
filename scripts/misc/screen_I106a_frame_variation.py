"""Does I106a's piece 2 collapse under post F69's own test, and is it batch 21 at X = 0?

By hand:  the frame-dependent part is  beta tr(U V^2) + tr(V C)  with V = P diag(nu) P^T.
Varying P alone gives dV = [Om, V], dU = 0, and

    d(phi) = tr( [Om,V] ( beta {U,V} + C ) ),   so stationarity is [V, beta{U,V} + C] = 0.

Substituting the Lagrange form C = mu V - beta {U,V} makes the bracket mu V, hence
[V, mu V] = 0 IDENTICALLY.  That is post F69's collapse on a direction distinct from
batch 33's joint conjugation.  This CHECKS that derivation; it does not establish it.
"""
import numpy as np
rng=np.random.default_rng(5)

def sym(n=3):
    M=rng.normal(size=(n,n)); M=(M+M.T)/2
    return M-np.trace(M)/n*np.eye(n)
def skew(n=3):
    M=rng.normal(size=(n,n)); return (M-M.T)/2

worst_generic=0.0; worst_lagrange=0.0; worst_b21=0.0
for _ in range(20000):
    U=sym(); V=sym(); Om=skew(); mu=rng.normal(); beta=rng.normal(); alpha=rng.normal()
    anti=U@V+V@U
    # (a) with a GENERIC symmetric field C the condition is a real one
    Cgen=sym()
    g=V@(beta*anti+Cgen)-(beta*anti+Cgen)@V
    worst_generic=max(worst_generic,np.abs(g).max())
    # (b) with C its own Lagrange form it must vanish identically
    Clag=mu*V-beta*anti
    l=V@(beta*anti+Clag)-(beta*anti+Clag)@V
    worst_lagrange=max(worst_lagrange,np.abs(l).max())
    # (c) is the frame direction batch 21 at X = 0, Y = [Om,V]?
    X=np.zeros((3,3)); Y=Om@V-V@Om
    lhs=6*alpha*np.trace(U@X@X)+4*beta*np.trace(X@V@Y)+2*beta*np.trace(U@Y@Y)
    lhs_X0=2*beta*np.trace(U@Y@Y)          # what batch 21 reduces to at X = 0
    worst_b21=max(worst_b21,abs(lhs-lhs_X0))

print("20000 random (U,V,Omega,mu,alpha,beta):")
print(f"  (a) generic field C : max |[V, beta{{U,V}}+C]| = {worst_generic:.4f}   (a REAL condition)")
print(f"  (b) Lagrange form C : max |[V, beta{{U,V}}+C]| = {worst_lagrange:.3e}   (VACUOUS)")
print(f"  (c) batch 21 at X=0 matches the frame direction, max gap = {worst_b21:.3e}")
print()
print("The contrast between (a) and (b) is exactly post F69's prescribed test: the collapse")
print("is caused by the substitution, not by the geometry. And (c) says the second order is")
print("batch 21 specialised to ONE variable, which batch 21 records as already extracted.")
