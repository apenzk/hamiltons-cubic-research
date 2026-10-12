from fractions import Fraction as F
import math

def build(p,q):
    p=F(p); q=F(q); n=p+q
    alpha = q/((p-1)*(n-1))
    beta  = p/((q-1)*(n-1))
    gamma = -F(1)/(n-1)
    normsq = F(p*(p-1),2)*alpha**2 + F(q*(q-1),2)*beta**2 + p*q*gamma**2
    # tr(W^3) = sum over pairs lambda_ij^3
    trW3 = F(p*(p-1),2)*alpha**3 + F(q*(q-1),2)*beta**3 + p*q*gamma**3
    # W# term = sum_{i<j} lam_ij * sum_{k!=i,j} lam_ik lam_jk
    QW_PP = (p-1)*alpha**2 + q*gamma**2         # this INCLUDES lam_ij^2 self term as written, need subtract
    QW_QQ = (q-1)*beta**2 + p*gamma**2
    QW_PQ = gamma**2 + (p-1)*alpha*gamma + (q-1)*beta*gamma
    # Recall (Q(W))_ijij = lam_ij^2 + sum_{k!=i,j} lam_ik lam_jk  => the "sum" part is (Q(W))_ijij - lam_ij^2
    Wsharp_PP = QW_PP - alpha**2   # = sum_{k!=i,j} for PP pair
    Wsharp_QQ = QW_QQ - beta**2
    Wsharp_PQ = QW_PQ - gamma**2
    Wsharp_term = F(p*(p-1),2)*alpha*Wsharp_PP + F(q*(q-1),2)*beta*Wsharp_QQ + p*q*gamma*Wsharp_PQ
    N = p*(p-1+q)*F(1,1)  # placeholder, will compute N=n(n-1)/2 separately
    return trW3, Wsharp_term, normsq

print(f"{'n':>5} {'(p,q)':>8} {'tr(W^3)':>12} {'<W#,W>':>12} {'sum':>12} {'||W||^2':>10} {'N=n(n-1)/2':>10} {'LemmaBound_trW3':>16}")
for n_val in [8,10,12,16,20,30,50,100,200]:
    p_val = n_val//2; q_val = n_val-p_val
    trW3, Wsharp, normsq = build(p_val,q_val)
    N = n_val*(n_val-1)//2
    lemma_bound = (N-2)/math.sqrt(N*(N-1)) * float(normsq)**1.5
    print(f"{n_val:5d} {str((p_val,q_val)):>8} {float(trW3):12.6f} {float(Wsharp):12.6f} {float(trW3+Wsharp):12.6f} {float(normsq):10.6f} {N:10d} {lemma_bound:16.6f}")
