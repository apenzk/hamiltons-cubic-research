import math
a=3*math.sqrt(3)/2
def th0(n): return math.sqrt(2*(n-1)*(n-2))/n
def tstar(n,delta):
    SF=th0(n)-delta; lo,hi=0.0,1.0/math.sqrt(n-1)
    f=lambda t: th0(n)*(1-6*(n-1)*t*t-2*((n-1)*t*t)**1.5)-(SF+a*t+th0(n)*t**3+a*t*(n-1)*t*t)
    for _ in range(200):
        m=(lo+hi)/2
        if f(m)>0: lo=m
        else: hi=m
    return lo
def schur(n): return math.sqrt(6/((n+1)*(n+2)))
for delta in (0.17,0.10):
  for n in (14,50,100,200,270,300,400,600,1000,2000):
    ts=tstar(n,delta); print(delta,n,round(ts*math.sqrt(n),4),round(ts,5),round(schur(n),5),ts>schur(n))
for delta in (0.17,0.20,0.10):
    n=12
    while tstar(n,delta)<=schur(n): n+=2
    print("crossover delta",delta,"n",n,"c",round(tstar(n,delta)*math.sqrt(n),4))
