# REVIEW r1170: L247's certificate at general three-value spectra

*Gate 2 reviewer r1170, brief [2026-09-25-general-spectrum-gate2-brief.md](2026-09-25-general-spectrum-gate2-brief.md), claim in [the working file](2026-09-25-I73c-per-vector-rows.md) at 58225eb7. Analysis by hand. The screens were a sympy expansion of the Lean certificate and a six-variable LP on the per-vector rows (seconds each), reported as screens.*

**Verdict: the claim holds. Items 1 and 3 CONFIRMED, item 2 CONFIRMED with a wording correction (six rows suffice), item 4 CONFIRMED with a correction that strengthens the claim: the rank hypothesis is unnecessary for the certificate to fire, and the floor $b_{20}>0$ off $\lambda_1=0$ holds exactly under an explicit condition, derived below.**

## Item 1: the bracket term, its positive part, its trace. CONFIRMED

- With $e=W/\theta=\tfrac1\theta\sum_c\lambda_cP_c$ and $P_c^2=P_c=P_c^{\mathsf T}$, $B_{\mathrm{lead}}=-\tfrac14C^{\mathsf T}eC=-\tfrac1{4\theta}\sum_c\lambda_c(P_cC)^{\mathsf T}(P_cC)$. Each summand is $-\tfrac{\lambda_c}{4\theta}$ times a PSD matrix, so (with $\theta>0$) the classes with $\lambda_c<0$ contribute PSD terms, those with $\lambda_c>0$ NSD terms, and $\lambda_c=0$ contributes nothing.
- Given $\lambda_0<0<\lambda_2$, the set of classes with $\lambda_c<0$ is $\{0\}$ exactly when $\lambda_1\ge0$, and $\{0,1\}$ when $\lambda_1<0$. So $B_{\mathrm{lead}}\preceq M_0=-\tfrac{\lambda_0}{4\theta}(P_0C)^{\mathsf T}(P_0C)$ on $\lambda_1\ge0$, and Weyl's inequality gives at most $\operatorname{rank}P_0C$ positive eigenvalues. At $\lambda_1<0$ the same argument needs $\operatorname{rank}P_0C+\operatorname{rank}P_1C$.
- Trace: $B_{02}=\tfrac12\sum_{u\in E_0,v\in E_2}[u,v][u,v]^{\mathsf T}$, so $\operatorname{tr}\big((P_cC)^{\mathsf T}P_cC\big)=\sum_{u,v}\lvert P_c[u,v]\rvert^2=2\operatorname{tr}(P_cB_{02})=2t_{02c}$ by total symmetry. Hence $T=\operatorname{tr}B_{\mathrm{lead}}=-\tfrac1{2\theta}\sum_c\lambda_ct_{02c}$. At $\lambda=(-a,0,a)$ this is $\tfrac a{2\theta}(t_{020}-t_{022})=\sum_u\tfrac a{2\theta}(b_{20}(u)-b_{22}(u))$, L247's $T$.

## Item 2: general_identity. CONFIRMED, wording corrected

- **Hypotheses.** h0, h3, h6 are row (A) traced against $P_0,P_1,P_2$ ($\sum_{a,b}t_{cab}=(n-2)p_c$); h1, h4, h7 are row (B) ($\sum_b\lambda_b\sum_at_{cab}=-\lambda_cp_c$); h2, h5, h8 are row (C) ($\sum_{a,b}\lambda_a\lambda_bt_{cab}=\lambda_c(\theta-\lambda_c)p_c$); h9 is $\operatorname{tr}W=0$. Each checked term by term against the per-vector rows with $t$ totally symmetric.
- **Left side.** $-2(\lambda_0t_{002}+\lambda_1t_{012}+\lambda_2t_{022})=\theta\cdot4T$, so the left side is $\mathrm{Den}\cdot(\lambda_0-\lambda_1)\cdot\theta(4T-p_0)$ with $\mathrm{Den}=2\theta(\lambda_0-\lambda_2)^2(\lambda_1-\lambda_2)^2(n-1)$, as stated.
- **Coefficients.** Dividing the Lean coefficients of $t_{000},t_{011},t_{122}$ by Den gives exactly the displayed $c_{000},c_{011},c_{122}$ (by hand, and by a sympy screen). The screen also re-expanded the `linear_combination` certificate: residual $0$. The constant at $\lambda=(-a,0,a)$ is $\tfrac a8p_0(an-5a-\theta)$, and with $c_{000}=-\tfrac{a^2}2$, $c_{011}=-\tfrac{a^2}8$, $c_{122}=-\tfrac{a^2}2$ and $4T-p_0=-2D/\kappa$ the identity is $16D=(n-5-\kappa)p-4t_{000}-t_{011}-4t_{122}$, r1149's.
- **The file compiles** (`lake env lean`, exit 0, unused-variable lints only).
- **Correction.** The certificate uses only h0 to h5, the rows of classes $0$ and $1$. h6 to h9 (class 2's rows and $\operatorname{tr}W=0$) are unused, which is why the constant contains no $p_2$. "The nine traced rows with $\operatorname{tr}W=0$ give" is true but should read "the six traced rows of $E_0$ and $E_1$ give". A consequence worth recording: the constant is free of the trace condition, so one may substitute $\lambda_1m=-\lambda_0p_0-\lambda_2p_2$ to shape the region $\mathrm{const}<0$, which the working note owes.

## Item 3: signs and the direction. CONFIRMED

- $c_{122}=\lambda_2(\lambda_0-\lambda_1)(\lambda_1-\lambda_2)/(\lambda_0-\lambda_2)$: signs $(+)(-)(-)/(-)$, so negative for every ordered spectrum with $\lambda_2>0$.
- $c_{011}$: on $\lambda_1\ge0$, $\lambda_0(2\lambda_1+\lambda_2)<0$ and $-3\lambda_1\lambda_2\le0$, so $c_{011}<0$ strictly.
- $c_{000}\le0$ iff $2\lambda_0\lambda_1-\lambda_0\lambda_2-\lambda_1\lambda_2\ge0$, i.e. $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$. At $\lambda_1=0$ it reads $-\lambda_0\lambda_2>0$, true. For $\lambda_1>0$ the left side must be positive, so the region is $\lambda_1=0$ or $0<\lambda_1<\lambda_2/2$ with $\lvert\lambda_0\rvert\ge\lambda_1\lambda_2/(\lambda_2-2\lambda_1)$. The claim is correct as stated, and this makes its shape explicit.
- Direction: every $t_{abc}=\operatorname{tr}(P_aB_{bc})\ge0$ since $B_{bc}\succeq0$. On the region, the right side is at most const, so $\mathrm{const}<0$ gives $\theta(\lambda_0-\lambda_1)(4T-p_0)<0$, and $\theta>0$, $\lambda_0<\lambda_1$ give $4T>p_0$. Then $\lambda_{\max}(B_{\mathrm{lead}})\ge T/\operatorname{rank}P_0C\ge T/p_0>\tfrac14$ and $\lambda_{\max}(L_e)\ge2\lambda_{\max}>\tfrac12$ at leading order. The step uses $\theta>0$, which the record assumes throughout.

## Item 4: the rank carry-over. CONFIRMED with a correction

- **The rank hypothesis is not needed.** $P_0C$ maps into $E_0$, so $\operatorname{rank}P_0C\le p_0$ always. If $T>0$, then $B_{\mathrm{lead}}$ has a positive eigenvalue, so $\operatorname{rank}P_0C\ge1$ and $T/\operatorname{rank}P_0C\ge T/p_0$. The certificate therefore fires on $4T>p_0$ with no condition on $b_{20}$. The clause "and $\operatorname{rank}P_0C=p_0$ as before when the rows keep $b_{20}>0$ on $E_0$" is correct but carries no weight in the conclusion (it only says when the bound $T/\operatorname{rank}$ equals $T/p_0$).
- **The floor off the symmetric family, derived.** At unit $x\in E_0$, combine the per-vector rows as $\sum_{a,b}(\lambda_a-\lambda_1)(\lambda_b-\lambda_1)b_{ab}=(\mathrm C)-2\lambda_1(\mathrm B)+\lambda_1^2(\mathrm A)$. Every index-$1$ term drops out, leaving $(\lambda_0-\lambda_1)^2b_{00}+2(\lambda_0-\lambda_1)(\lambda_2-\lambda_1)b_{02}+(\lambda_2-\lambda_1)^2b_{22}=\lambda_0(\theta-\lambda_0)+2\lambda_0\lambda_1+(n-2)\lambda_1^2$. With $b_{00},b_{22}\ge0$,
$$b_{20}(x)\ \ge\ \frac{\lvert\lambda_0\rvert\big(\theta+\lvert\lambda_0\rvert+2\lambda_1\big)-(n-2)\lambda_1^2}{2(\lambda_1-\lambda_0)(\lambda_2-\lambda_1)}.$$
At $\lambda_1=0$ this is $(\theta+\lvert\lambda_0\rvert)/(2\lambda_2)>0$ for any $\lambda_0,\lambda_2$, and at $(-a,0,a)$ it is L244's $\tfrac12(\theta\sqrt{2p}+1)$. **So the floor exists at every spectrum with $(n-2)\lambda_1^2<\lvert\lambda_0\rvert(\theta+\lvert\lambda_0\rvert+2\lambda_1)$.**
- **The bound is the exact minimum of the three rows.** An LP screen (minimise $b_{02}$ over $b\ge0$ subject to (A), (B), (C) at $x\in E_0$) returned this value at every test spectrum where it is positive, and $0$ where the numerator is negative (for example $\lambda=(-1,1.2,2)$, $\theta=15$, $n=20$). So off that condition the rows alone admit $b_{20}(x)=0$, and $\operatorname{rank}P_0C=p_0$ would need the caps or more. By the first bullet this does not affect the certificate.
- **Nothing is stated beyond support**, apart from item 2's row count. The region $\mathrm{const}<0$ is stated as owed, with the corrections, and the explicit polynomial is in the Lean file (the working note says "in the file", which should name [ClassTraceGeneral.lean](../lean/HamiltonsCubic/Results/ClassTraceGeneral.lean)).

## Corrections for the record

1. "The nine traced rows with $\operatorname{tr}W=0$ give" becomes "the six traced rows of $E_0$ and $E_1$ give" (h6 to h9 unused in `general_identity`).
2. The certificate needs no rank condition: $\operatorname{rank}P_0C\le p_0$ is automatic, so $4T>p_0$ alone gives $\lambda_{\max}(B_{\mathrm{lead}})>\tfrac14$. Optionally record the general floor above, with its condition $(n-2)\lambda_1^2<\lvert\lambda_0\rvert(\theta+\lvert\lambda_0\rvert+2\lambda_1)$.
3. The sign region on $\lambda_1>0$ is $\lambda_2>2\lambda_1$ with $\lvert\lambda_0\rvert\ge\lambda_1\lambda_2/(\lambda_2-2\lambda_1)$.
4. "(in the file)" should point to the Lean file, since the working note does not display the constant.
