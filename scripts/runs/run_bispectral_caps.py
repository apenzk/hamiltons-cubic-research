"""How much the bi-spectral identity gives away if the two cubics are capped separately.

theta = 3/2 p3(mu) - 1/2 p3(omega) with sum mu = sum omega = 0, |mu|^2 = 1, |omega|^2 = 3.
Okumura: for a traceless vector of N reals with norm r,  |p3| <= r^3 (N-2)/sqrt(N(N-1)).
Bounding the two terms separately therefore cannot reach theta_0(n) -- the coupling is
everything, which is fence post 2's pattern in the new coordinates.
"""
import numpy as np
print(f"{'n':>3} {'N_mu':>6} {'N_om':>6} {'cap 3/2 p3(mu)':>16} {'cap 1/2|p3(om)|':>17} {'combined':>10} {'theta_0(n)':>11} {'ratio':>7}")
for n in range(6, 25, 2):
    Nm = n*(n-1)//2
    No = (n-1)*(n+2)//2
    ok = lambda N, r: r**3*(N-2)/np.sqrt(N*(N-1))
    a = 1.5*ok(Nm, 1.0)
    b = 0.5*ok(No, np.sqrt(3.0))
    t0 = np.sqrt(2*(n-1)*(n-2))/n
    print(f"{n:>3} {Nm:>6} {No:>6} {a:>16.6f} {b:>17.6f} {a+b:>10.6f} {t0:>11.6f} {(a+b)/t0:>7.3f}")
