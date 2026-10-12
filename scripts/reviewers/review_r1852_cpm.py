# r1852: CP^m Weyl spectrum arithmetic check (tr W^3, E, eps_n) from the stated spectrum
from fractions import Fraction as F
import math
for m in range(2,9):
    n=2*m
    ev=[(2*(m*m-1),1),(m-2,m*m-1),(-(m+1),m*m-m)]
    assert sum(k for _,k in ev)==n*(n-1)//2
    tr=sum(l*k for l,k in ev)
    nrm2=sum(l*l*k for l,k in ev)
    tr3=sum(l**3*k for l,k in ev)/nrm2**1.5
    th=math.sqrt((m+1)*(2*m-1)/(3*m*(m-1))) if m>1 else float('nan')
    lmax=2*(m*m-1)/math.sqrt(nrm2)
    th0=math.sqrt(2*(n-1)*(n-2))/n
    eps=th0-1.5/th0
    print(m,n,"trace",tr,"th %.6f tr3 %.6f thlmax %.4f E %.6f eps %.6f  3/(n+2) %.4f"%(th,tr3,th*lmax,th-1.5*tr3,eps,3/(n+2)))
