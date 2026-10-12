"""r276 Claim 5: is the n=12 restriction in Nienhaus Theorem 4.17 structural or technical?

The proof's only n-dependent input is the line "f(phi) <= 1 on [0,pi]", i.e.
sqrt(2/3) sup P <= 1, i.e. W_CP2 is the GLOBAL maximiser.  That holds for n <= 11
(theta_0(n) < sqrt(3/2) below n = 6+2sqrt7 = 11.2915) and fails for n >= 12.
Replace the constant 1 by a general c = sqrt(2/3)*sup P and redo both closing
estimates exactly.

  f(phi)   = cos^3 + 3 cos sin^2 alpha + sin^3 gamma
  Gamma_c(alpha) = min_{phi in (0,pi)} (c - cos^3 - 3 alpha cos sin^2)/sin^3   >= gamma
  (i)  ftilde(pi/6) = (3 alpha - 1) cos^2 + (1/2) sin(2 phi) Gamma - alpha   must be < 0
  (ii) f(pi/6) <= 3sqrt3/8 (1 + alpha) + (1/8) Gamma  must be < sqrt(2/3) Theta
"""
import numpy as np

def Gamma(c, a):
    ph = np.linspace(1e-7, np.pi - 1e-7, 4000001)
    g = (c - np.cos(ph)**3 - 3*a*np.cos(ph)*np.sin(ph)**2)/np.sin(ph)**3
    return g.min()

def ftilde(phi, a, G):
    return (3*a - 1)*np.cos(phi)**2 + 0.5*np.sin(2*phi)*G - a

def f_pi6(a, G):
    return np.cos(np.pi/6)**3 + 3*np.cos(np.pi/6)*np.sin(np.pi/6)**2*a + np.sin(np.pi/6)**3*G

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n
def theta_kl(k, l):
    n = k + l
    return np.sqrt(2.0)*np.sqrt((k-1)/k*(l-1)/l*(n-1)/(n-2))

s23 = np.sqrt(2.0/3.0)
print("Nienhaus's own closed form at c=1:  Gamma = 1 - sqrt(2a(1+a))")
for a in (0.0, 0.1, 0.2, 1/3):
    print(f"   alpha={a:.4f}  Gamma_num={Gamma(1.0, a):.9f}  closed={1-np.sqrt(2*a*(1+a)):.9f}")
print()
print(f"{'n':>3} {'sup P (granted)':>16} {'c':>10} {'Gamma(1/3)':>11} {'ftilde(pi/6)':>13} {'f(pi/6) bnd':>12} {'s23*Theta':>10} {'(i)':>4} {'(ii)':>5}")
for n in (9, 10, 11, 12, 13, 14, 16, 20, 40):
    k, l = int(np.ceil(n/2)), int(np.floor(n/2))
    t = theta_kl(k, l)
    sup = max(np.sqrt(1.5), t)
    c = s23*sup
    G = Gamma(c, 1/3)
    ft = ftilde(np.pi/6, 1/3, G); fb = f_pi6(1/3, G); tgt = s23*t
    print(f"{n:>3} {sup:16.9f} {c:10.6f} {G:11.6f} {ft:13.6f} {fb:12.6f} {tgt:10.6f} "
          f"{'ok' if ft < 0 else 'FAIL':>4} {'ok' if fb < tgt else 'FAIL':>5}")
print()
print("How far can c be pushed before each closing estimate breaks (alpha = 1/3):")
for c in (1.0, 1.005, 1.00921, 1.02, 1.05, 1.1, 1.15, 1.2, 1.3, 1.4142, 1.7321):
    G = Gamma(c, 1/3)
    print(f"   c={c:7.5f}  Gamma={G:9.6f}  ftilde(pi/6)={ftilde(np.pi/6,1/3,G):+9.6f}  f(pi/6)bnd={f_pi6(1/3,G):9.6f}")

# ---- exact closed form for Gamma_1(alpha), and the surviving range at n>=12 ----
import sympy as sp
a, t = sp.symbols('alpha t', positive=True)
tt = a/(1-a); ss = sp.sqrt(1-tt**2)
G1 = sp.simplify((1 - tt**3 - 3*a*tt*(1-tt**2))/ss**3)
print("\nexact Gamma_1(alpha) at the stationary point cos(phi_0)=alpha/(1-alpha):")
print("   ", sp.simplify(sp.radsimp(G1)))
for av in (sp.Rational(1,10), sp.Rational(1,5), sp.Rational(1,3)):
    print(f"    alpha={float(av):.4f}  exact={float(G1.subs(a,av)):.9f}"
          f"   Nienhaus's printed form 1-sqrt(2a(1+a)) = {float(1-sp.sqrt(2*av*(1+av))):.9f}")
print("    at alpha=1/3 exactly:", sp.nsimplify(sp.simplify(G1.subs(a, sp.Rational(1,3))), [sp.sqrt(3)]))
print("    ftilde(pi/6) at alpha=1/3, c=1:",
      sp.simplify(sp.Rational(3,4)*(3*sp.Rational(1,3)-1) + sp.sqrt(3)/4*G1.subs(a, sp.Rational(1,3)) - sp.Rational(1,3)))

print("\nhow much of (0,pi/6] survives at c = sqrt(2/3) theta_0(n):")
for n in (12, 14, 16, 20):
    k, l = int(np.ceil(n/2)), int(np.floor(n/2))
    c = s23*theta_kl(k, l); G = Gamma(c, 1/3)
    ph = np.linspace(1e-9, np.pi/6, 2000001)
    v = ftilde(ph, 1/3, G)
    star = ph[np.argmax(v > 0)] if (v > 0).any() else np.pi/6
    print(f"   n={n:2d}  c={c:.6f}  ftilde>0 from phi*={star:.6f} rad = {star/(np.pi/6):.4f} of pi/6"
          f"   (deficit at pi/6: {ftilde(np.pi/6,1/3,G):+.6f})")
