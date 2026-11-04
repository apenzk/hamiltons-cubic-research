# REVIEW r1149: the class-trace form of the leading pair test

*Gate 2 reviewer r1149, 2026-09-25, brief [2026-09-25-class-trace-gate2-brief.md](2026-09-25-class-trace-gate2-brief.md), claim as committed at 76fbc0ed in [the working file](2026-09-25-I73c-per-vector-rows.md). Every step below was derived by hand from the givens. One sympy screen of seconds on the nine symbolic rows agreed with the rank, the solved form, the identity of correction B and the witness of item 4. It is a screen, and none of the verdicts rests on it.*

## Summary

| item | verdict |
|---|---|
| 1. total symmetry of $t_{abc}$ | CONFIRMED |
| 2. rows, rank 7, solved form | CONFIRMED |
| 3. "exceeds $\tfrac12$ exactly when $D<0$" | PLAUSIBLE with correction A: the class-level certificate fires exactly when $D<0$, and the bracket part can exceed $\tfrac12$ at $D\ge0$ as well |
| 4. "the linear rows allow both signs" | REFUTED as stated, correction B: the rows give $16D=(n-5-\theta\sqrt{2p})\,p-4t_{000}-t_{011}-4t_{122}$, so nonnegativity forces $D<0$ whenever $\theta\sqrt{2p}\ge n-5$ (strictly unless three traces vanish), and $D\ge0$ is compatible with all ten nonnegativities iff $\theta\sqrt{2p}\le n-5$ |

## Item 1

- By the givens, $B_{bc}=\tfrac12\sum_{\gamma\in E_b,\delta\in E_c}[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$ over orthonormal bases, so $t_{abc}=\mathop{\mathrm{tr}}(P_aB_{bc})=\tfrac12\sum_{\varepsilon\in E_a,\gamma\in E_b,\delta\in E_c}\langle[\psi_\gamma,\psi_\delta],\psi_\varepsilon\rangle^2$.
- The squared structure constant $\langle[\psi_\gamma,\psi_\delta],\psi_\varepsilon\rangle^2$ is invariant under every permutation of $(\gamma,\delta,\varepsilon)$: antisymmetry of the bracket handles the transposition of $\gamma,\delta$, and ad-invariance $\langle[x,y],z\rangle=-\langle y,[x,z]\rangle$ moves an index between slot and bracket up to sign. The prefactor $\tfrac12$ is common to all three index placements, so $t_{abc}$ is totally symmetric with the stated normalisation. CONFIRMED.
- The same formula gives $B_{bc}=B_{cb}$ and $t_{abc}\ge0$, both used below.

## Item 2

Notation: $d=(p,m,p)$, $\lambda=(-a,0,a)$, $\kappa:=\theta/a=\theta\sqrt{2p}$. Row $(R)_c$ is the trace over a basis of $E_c$ of the per-vector row, sums over ordered $(a,b)$.

- $(A)_0$: $t_{000}+t_{011}+t_{022}+2t_{001}+2t_{002}+2t_{012}=(n-2)p$, and $(A)_1$, $(A)_2$ likewise with $d_1=m$, $d_2=p$.
- $(B)_c$: $\sum_{a,b}\lambda_bt_{cab}=a\sum_a(t_{ca2}-t_{ca0})$, which telescopes to $a\,(t_{c22}-t_{c00}+t_{c12}-t_{c01})=-\lambda_cd_c$. So $(B)_0$: $t_{022}-t_{000}+t_{012}-t_{001}=p$, $(B)_1$: $t_{122}-t_{001}+t_{112}-t_{011}=0$, $(B)_2$: $t_{222}-t_{002}+t_{122}-t_{012}=-p$. The per-vector form of $(B)_0$ is $b_{22}-b_{00}+b_{12}-b_{01}=1$, the claim's "$b_{22}-b_{00}-1=b_{01}-b_{12}$", and its trace turns the test $t_{022}<t_{000}+p$ into $t_{001}<t_{012}$. Correct.
- $(C)_c$: only $a,b\in\{0,2\}$ contribute, so $a^2(t_{c00}-2t_{c02}+t_{c22})=\lambda_c(\theta-\lambda_c)d_c$. Hence $(C)_0$: $t_{000}-2t_{002}+t_{022}=-(\kappa+1)p$, $(C)_1$: $t_{001}-2t_{012}+t_{122}=0$, $(C)_2$: $t_{002}-2t_{022}+t_{222}=(\kappa-1)p$. $(C)_0$ agrees with the file's per-vector $2b_{02}=b_{00}+b_{22}+\theta\sqrt{2p}+1$.
- **The solved form uses three rows only.** $(B)_2$ gives $t_{012}=t_{122}+2D$ with $D=\tfrac12(t_{222}-t_{002}+p)$. $(C)_1$ then gives $t_{001}=2t_{012}-t_{122}=t_{122}+4D$, and $(B)_1$ gives $t_{011}-t_{112}=t_{122}-t_{001}=-4D$. All three displayed relations CONFIRMED.
- **Rank at most 7.** Total symmetry makes $\sum_c\lambda_c\cdot(\text{LHS of }(A)_c)=\sum_c(\text{LHS of }(B)_c)$ and $\sum_c\lambda_c\cdot(\text{LHS of }(B)_c)=\sum_c(\text{LHS of }(C)_c)$, with right sides agreeing because $\sum_c\lambda_cd_c=0$ ($0=0$, and $-\sum\lambda_c^2d_c=\sum\lambda_c(\theta-\lambda_c)d_c$). Two dependencies, both consistent.
- **Rank at least 7.** Suppose $\alpha_c(A)_c+\beta_1(B)_1+\gamma_c(C)_c$ vanishes identically. The coefficient of $t_{111}$ gives $\alpha_1=0$. Then $t_{011}$: $\alpha_0=\beta_1$. $t_{112}$: $\alpha_2=-\beta_1$. $t_{000}$: $\gamma_0=-\alpha_0$. $t_{222}$: $\gamma_2=-\alpha_2$. $t_{001}$: $2\alpha_0-\beta_1+\gamma_1=0$, so $\gamma_1=-\alpha_0$. $t_{122}$: $2\alpha_2+\beta_1+\gamma_1=0$, so $\gamma_1=-\alpha_2$. Hence $\alpha_0=\alpha_2=-\alpha_0$, and every coefficient vanishes. The seven rows $(A)_{0,1,2},(B)_1,(C)_{0,1,2}$ are independent, and $(B)_0,(B)_2$ follow from the two dependencies. Rank 7, CONFIRMED.
- **Parametrisation.** Ten unknowns minus rank 7 leaves three, and $t_{022},t_{122},t_{222}$ do parametrise: $(C)_2$ fixes $t_{002}$, hence $D=t_{222}-t_{022}-\tfrac12(\kappa-2)p$, then $t_{012},t_{001}$ as above, $(C)_0$ fixes $t_{000}$, $(A)_0$ fixes $t_{011}$, $(B)_1$ fixes $t_{112}$, $(A)_1$ fixes $t_{111}$. Writing $D$ through $t_{002}$ is a shorthand, correct on the solution set.

## Item 3

- The chain: the certificate $\lambda_{\max}(B_{\mathrm{lead}})\ge T/\mathop{\mathrm{rank}}P_0C=T/p$, and $4T=p+\kappa^{-1}(t_{000}-t_{022}+p)$ from $(C)_0$. So $T/p>\tfrac14$ iff $t_{022}<t_{000}+p$ iff $t_{001}<t_{012}$ by $(B)_0$ iff $D<0$ by the solved form. Each step is an equivalence. The mirror form $\mathop{\mathrm{tr}}(P_2B_{00})>\mathop{\mathrm{tr}}(P_2B_{22})+p$ is $t_{002}>t_{222}+p$, i.e. $D<0$. Correct.

### Correction A: what "exactly" can mean

- **What holds exactly**: the rank certificate $T/\mathop{\mathrm{rank}}P_0C>\tfrac14$ holds iff $D<0$. That is an exact equivalence between two class-level conditions.
- **What it cannot mean**: the bracket part $\lambda_{\max}(B_{\mathrm{lead}})$ exceeds $\tfrac14$ (its $L_e$ form exceeds $\tfrac12$) only when $D<0$. The certificate bounds $\lambda_{\max}$ from below and is attained only when the positive eigenvalues are equal, so at $D\ge0$ the bracket part may still exceed $\tfrac12$. The same caveat applies to "binds" in the bold headline, which moreover concerns the leading (bracket) part only, with the Ricci and $\Lambda^4$ corrections at relative size $p^{-1/2}$ still owed.
- **Suggested wording**: "the rank certificate for the bracket part fires exactly when $D<0$, i.e. $\mathop{\mathrm{tr}}(P_2B_{00})>\mathop{\mathrm{tr}}(P_2B_{22})+p$".
- **On "mirror"**: the condition is the formal $0\leftrightarrow2$ mirror of the $E_0$ one, but the rows themselves are not mirror symmetric ($(C)_0$ carries $-(\kappa+1)$, $(C)_2$ carries $\kappa-1$), so the mirror is of form only.

## Item 4

- The claim's evidence ("nonnegativity of $t_{001}$ gives only $D\ge-t_{122}/4$") uses one of ten nonnegativities, and the others are decisive.

### Correction B: an identity on the solution set, and a forced sign

- **The identity.** From the parametrisation, $t_{000}=3t_{022}-2t_{222}+(\kappa-3)p$ and $t_{011}=(n+3\kappa-9)p+4t_{022}-8t_{222}-4t_{122}$. Then $4t_{000}+t_{011}=16t_{022}-16t_{222}-4t_{122}+(n+7\kappa-21)p$, and with $16D=16t_{222}-16t_{022}-8(\kappa-2)p$:
$$16D=\big(n-5-\theta\sqrt{2p}\big)\,p-4t_{000}-t_{011}-4t_{122}.$$
- **Forced sign.** Since $t_{000},t_{011},t_{122}\ge0$, **every solution of the rows with nonnegative traces has $D<0$ whenever $\theta\sqrt{2p}>n-5$**, and $D\le0$ at equality (strict unless $t_{000}=t_{011}=t_{122}=0$). So on that region the rank certificate for the bracket part fires at every point the class system allows, by nonnegativity alone, with no per-vector cap needed.
- **The converse, a witness.** For $\theta\sqrt{2p}\le n-5$ take $t_{122}=0$, $t_{222}=\tfrac14(n+\kappa-5)p$, $t_{022}=\tfrac14(n-\kappa-1)p$. Then $D=0$, $t_{000}=\tfrac14(n-\kappa-5)p$, $t_{002}=\tfrac14(n+\kappa-1)p$, $t_{001}=t_{012}=t_{011}=t_{112}=0$, $t_{111}=(n-2)m$, all nonnegative. So $D\ge0$ is compatible with all ten nonnegativities **iff** $\theta\sqrt{2p}\le n-5$. $D>0$ needs in addition $m>0$: at $m=0$ every trace carrying index $1$ vanishes, and $t_{001}=t_{012}=0$ force $D=0$.
- **Where this bites.** The family needs $n(n-1)/2=2p+m\ge2p$, so $n$ is about $2\sqrt p$ when $m$ is small, against $\theta\sqrt{2p}\approx1.75\sqrt p$ at $\theta\approx1.24$. For example $p=12$, $n=8$ ($m=4$): $\kappa=\theta_0(12)\sqrt{24}\approx6.06>3=n-5$, so $D<0$ is forced there. For $n$ large against $\sqrt p$ (large $m$), $D\ge0$ is open at the level of nonnegativity, and there the claim's remaining question (whether the per-vector caps exclude $D\ge0$) stands. The region $n<5+\theta_0\sqrt{2p}$ is described by one inequality in $(n,p)$ and is analytic, so it needs no sweep.
- **Not checked**: whether $D<0$ is feasible in the region $\theta\sqrt{2p}<n-5$ under the per-vector caps, and the caps in general. The Ricci and $\Lambda^4$ corrections remain owed everywhere, so the forced sign is a statement about the leading-order certificate, not the full second-order test.
- **Verdict**: "the linear rows allow both signs" is REFUTED as a general statement. It holds exactly on $\theta\sqrt{2p}\le n-5$ (with $m>0$ for $D>0$), and on $\theta\sqrt{2p}>n-5$ the rows with nonnegativity force $D<0$.
