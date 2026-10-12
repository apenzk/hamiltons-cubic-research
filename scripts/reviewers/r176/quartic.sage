# Harish-Chandra: Z(U(so(5))) = C[e1,e2] in l=(p,q)=lambda+rho, W(B2)-invariants
# e1 = p^2+q^2  (<->  C2 = <lam,lam+2rho> = e1 - |rho|^2 = e1 - 5/2)
# e2 = p^2 q^2  (<->  the degree-4 generator, e.g. HC image of tr(F^4) = p^4+q^4+... = e1^2-2e2+...)
rho = vector(QQ,[QQ(3)/2, QQ(1)/2])
pairs = [((3,3),(4,1)), ((5,0),(4,3)), ((5,4),(6,2))]
def data(lam):
    l = vector(QQ,lam)+rho
    p,q = l[0],l[1]
    return (p^2+q^2, p^2*q^2, p^4+q^4)
print("lam      p^2+q^2   p^2q^2     p^4+q^4   C2")
for pr in pairs:
    for lam in pr:
        e1,e2,pw = data(lam)
        print("%-8s %-9s %-10s %-9s %s" % (lam, e1, e2, pw, e1-QQ(5)/2))
    a,b = data(pr[0]), data(pr[1])
    print("   -> e1 equal:", a[0]==b[0], "| e2 differ:", a[1]!=b[1], "| p^4+q^4 differ:", a[2]!=b[2])
    print()
# Cartan-only separation: is hw of one a weight of the other?
R = WeylCharacterRing("B2", style="coroots")
def toC(lam):  # e-coords -> coroot labels for B2: lam = a1*w1 + a2*w2, w1=e1, w2=(e1+e2)/2
    l1,l2 = lam
    return R(l1-l2, 2*l2)
for pr in pairs:
    A,B = toC(pr[0]), toC(pr[1])
    wA = set(A.weight_multiplicities().keys()); wB = set(B.weight_multiplicities().keys())
    hwA = A.highest_weight(); hwB = B.highest_weight()
    print(pr, "dims", A.degree(), B.degree(), "| hwA in wt(B):", hwA in wB, "| hwB in wt(A):", hwB in wA)
