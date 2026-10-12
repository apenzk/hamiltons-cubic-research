"""Claim 4: is p_12 = Pf^2 ?"""
import sympy as sp
l = sp.symbols('l1:7')
Pf = sp.prod(l)
p12 = sum(x**12 for x in l)
d = sp.expand(p12 - Pf**2)
print('p_12 - Pf^2 identically zero?', d == 0)
# numeric witness
sub = dict(zip(l, [1, 2, 3, 4, 5, 6]))
print('at l = (1..6):  p_12 =', p12.subs(sub), '  Pf^2 =', (Pf**2).subs(sub))
# the true relation: Pf^2 = e_6(l^2), and Newton gives e_6 in terms of p_k(l^2) = p_{2k}(l)
x = sp.symbols('x1:7')
e = [sp.Integer(1)] + [sp.expand(sp.symmetric_poly(k, x)) for k in range(1, 7)]
p = [None] + [sum(v**k for v in x) for k in range(1, 7)]
newton = sp.expand(6*e[6] - sum((-1)**(j-1)*e[6-j]*p[j] for j in range(1, 7)))
print('Newton  6 e_6 = sum_j (-1)^(j-1) e_{6-j} p_j   residual:', sp.simplify(newton))
print('so Pf^2 = e_6(l^2) = (1/6)( e5 p1 - e4 p2 + e3 p3 - e2 p4 + e1 p5 - p6 )|_{x_i = l_i^2}')
print('   i.e. Pf^2 = -(1/6) p_12(l) + (polynomial in p_2..p_10) : the two are')
print('   interchangeable AS THE SIXTH GENERATOR, but they are not equal.')
