import numpy as np
from core111 import Core
import points111 as P

rng = np.random.default_rng(111)
print("Claim 1 -- the Q decomposition. worst deviations over test points.\n")
hdr = ("n", "point", "rho-2(n-2)", "row:sum lam R+2lam", "g-(2sum lam^2 R-2Q)",
       "sumQ+2|W|^2", "sum lam Q-2<W#,W>", "sum g-4(n-1)", "sum lam g+4th")
print(("%3s %-14s" + " %11s"*7) % hdr)
for n in (5, 6, 7, 8):
    C = Core(n)
    pts = [("random%d" % k, P.random_weyl(C, rng)) for k in range(2)]
    if n % 2 == 0:
        pts.append(("S^%dxS^%d" % (n//2, n//2), P.sphere_product(C, (n//2, n//2))))
    if n >= 4:
        C4, M4 = P.cp2_native()
        Cn, Mp = P.pad(C4, M4, n)
        pts.append(("CP2 padded", Mp))
    for name, M in pts:
        lam, V = C.spectral(M)
        T, A = C.Ttensor(V)
        R = T.sum(axis=2)
        rho = R.sum(axis=0)
        g = np.einsum('gab,ab->g', T, (lam[:, None] - lam[None, :])**2)
        Q = np.einsum('gab,a,b->g', T, lam, lam)
        d1 = np.abs(rho - 2*(n-2)).max()
        d2 = np.abs(R @ lam + 2*lam).max()
        d3 = np.abs(g - (2*(R @ (lam**2)) - 2*Q)).max()
        d4 = abs(Q.sum() + 2*np.sum(M*M))
        d5 = abs(lam @ Q - 2*np.sum(C.sharp(M)*M))
        d6 = abs(g.sum() - 4*(n-1))
        d7 = abs(lam @ g + 4*C.theta(M))
        print(("%3d %-14s" + " %11.2e"*7) % (n, name, d1, d2, d3, d4, d5, d6, d7))
