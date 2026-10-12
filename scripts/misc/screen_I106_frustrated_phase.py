# Screen of batch 12's closed form, seconds: for a, b, c > 0, max over angles of
# g = a cos t1 + b cos t2 - c cos(t1 - t2) is (ab/c + bc/a + ca/b)/2 when 1/a, 1/b, 1/c satisfy the triangle
# inequalities, and a + b + c - 2 min(a, b, c) otherwise, and in the triangle case it is at most a + b + c.
import numpy as np
rng = np.random.default_rng(53)
t = np.linspace(0, 2 * np.pi, 2001)
worst_int = 0; worst_col = 0; viol = 0; n_int = 0
for trial in range(400):
    a, b, c = np.exp(rng.normal(size=3))
    G = a * np.cos(t)[:, None] + b * np.cos(t)[None, :] - c * np.cos(t[:, None] - t[None, :])
    brute = G.max()
    x, y, z = 1 / a, 1 / b, 1 / c
    tri = x < y + z and y < x + z and z < x + y
    if tri:
        n_int += 1; closed = 0.5 * (a * b / c + b * c / a + c * a / b)
        worst_int = max(worst_int, abs(brute - closed)); viol += closed > a + b + c + 1e-12
    else:
        closed = a + b + c - 2 * min(a, b, c); worst_col = max(worst_col, abs(brute - closed))
print(f"400 cases, {n_int} with the triangle condition: max |brute - closed form| interior {worst_int:.1e}, collinear {worst_col:.1e}")
print(f"interior cases with closed form above a + b + c: {viol}  (grid step error bound ~ (a+b+c)*h^2 with h = {t[1]-t[0]:.1e})")
