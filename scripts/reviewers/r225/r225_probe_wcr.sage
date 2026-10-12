import time
for m in [5]:
    R = WeylCharacterRing("D%d"%m, style="coroots")
    Rw = WeylCharacterRing("D%d"%m)
    V = Rw(2,2,0,0,0)
    print("m",m,"dim V",V.degree(), "expected", 2*m*(2*m+1)*(2*m+2)*(2*m-3)//12)
    t=time.time(); S2 = V.symmetric_power(2); print("sym2 ok", S2.degree(), time.time()-t)
    t=time.time(); S3 = V.symmetric_power(3); print("sym3 ok", S3.degree(), binomial(V.degree()+2,3), time.time()-t)
    print("nterms", len(S3.monomial_coefficients()))
