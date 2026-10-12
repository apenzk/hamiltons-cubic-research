# I73 (c): the x-free general-spectrum ceiling (per-vector note, 'L253 at every three-value spectrum') applied to the recorded
# off-ray survivors at n = 12; 4 of 190 excluded at theta = 1.2361, 0 of 147 under T_7 <= 42. /usr/bin/python3, seconds.
# apply theta <= [(n-2)l2^2 - 2 l2|l0| - l0^2 - (l2-l1)^2 (n-3-p2)]/|l0| to recorded survivors
import re, ast, sys, numpy as np
n=12
def spectrum(m, frac):
    a = m[1]*frac+m[2]; b = -m[0]-m[1]+m[1]*frac; s = -b/a; t = -1+frac*(s+1)
    d = np.array([-1.0, t, s]); return list(d/np.sqrt(np.dot(m, d**2)))
for f,th in [('agent_logs/I73c_offray_n12_theta0.log',1.2361),('agent_logs/I73c_offray_n12_theta0_T42.log',1.2361)]:
    pts=[]
    for l in open(f):
        if l.startswith('FEASIBLE'):
            m=ast.literal_eval(re.search(r'\(.*?\)',l).group(0))
            for fr in ast.literal_eval(re.search(r'\[.*\]',l).group(0)): pts.append((m,fr))
    exc=0; old=0; ex=[]
    for m,fr in pts:
        l0,l1,l2=spectrum(m,fr); p0,p1,p2=m
        assert abs(p0*l0+p1*l1+p2*l2)<1e-9
        b=((n-2)*l2**2-2*l2*abs(l0)-l0**2-(l2-l1)**2*(n-3-p2))/abs(l0)
        b248=((n-2)*l2**2-2*l2*abs(l0)-l0**2)/abs(l0)
        if b<th: exc+=1; ex.append((m,round(fr,3),round(b,3)))
        if b248<th: old+=1
    print(f,len(pts),'points; excluded by new bound',exc,'(L248 alone',old,')'); print(ex[:8])
