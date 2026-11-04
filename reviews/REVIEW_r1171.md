# REVIEW r1171: L247's certificate at general three-value spectra

*Gate 2 reviewer r1171 for [the brief](2026-09-25-general-spectrum-gate2-brief.md), claim at 58225eb7 in [the working file](2026-09-25-I73c-per-vector-rows.md) (the general-spectrum paragraph). Analysis-only. The screen is one sympy run on the stated system (the Lean combination re-expanded, the rank, the coefficients, the symmetric constant) and one three-variable LP feasibility check on the per-vector rows at four spectra. Written independently of r1170.*

## Verdicts

| item | verdict | correction |
|---|---|---|
| 1. bracket term, positive part from $E_0$ alone, $T$ its trace | CONFIRMED | state $\theta>0$, which the sign reading uses |
| 2. `general_identity` states the claim | CONFIRMED | the identity needs only the six rows of $E_0$ and $E_1$ |
| 3. signs and "fires wherever const $<0$" | CONFIRMED | the region needs $\lambda_2>2\lambda_1$ when $\lambda_1>0$, to be stated |
| 4. carry-over of $\mathop{\mathrm{rank}}P_0C=p_0$ | PLAUSIBLE | the floor on $b_{20}$ is conditional off $\lambda_1=0$, with the explicit condition below |

## Item 1: CONFIRMED

- With $e=W/\theta$ and $W=\sum_c\lambda_cP_c$, $B_{\mathrm{lead}}=-\tfrac14C^{\mathsf T}eC=-\tfrac1{4\theta}\sum_c\lambda_c(P_cC)^{\mathsf T}(P_cC)$, each $(P_cC)^{\mathsf T}(P_cC)\succeq0$. For $\theta>0$ the classes with $\lambda_c<0$ contribute positive semidefinite terms and the others negative semidefinite ones.
- Since $\lambda_0<0<\lambda_2$, the only other candidate is $E_1$. At $\lambda_1=0$ its term vanishes, at $\lambda_1>0$ it is negative semidefinite, and at $\lambda_1<0$ it is positive semidefinite with rank $\mathop{\mathrm{rank}}P_1C$. So $B_{\mathrm{lead}}\preceq M_0:=-\tfrac{\lambda_0}{4\theta}(P_0C)^{\mathsf T}(P_0C)$ exactly when $\lambda_1\ge0$, and the certificate $\lambda_{\max}\ge T/\mathop{\mathrm{rank}}P_0C$ follows as in L247 (at most $\mathop{\mathrm{rank}}M_0$ positive eigenvalues, summing to at least $\mathop{\mathrm{tr}}B_{\mathrm{lead}}$ when that is positive).
- The trace: $\mathop{\mathrm{tr}}(C^{\mathsf T}P_cC)=\sum_{u,v}\lvert P_c[u,v]\rvert^2=\mathop{\mathrm{tr}}(P_c\mathcal B)$ with $\mathcal B=CC^{\mathsf T}=2B_{02}$ (the note's normalisation, $B_{ab}=\tfrac12\sum[\psi_\gamma,\psi_\delta]\otimes[\psi_\gamma,\psi_\delta]$), so $\mathop{\mathrm{tr}}B_{\mathrm{lead}}=-\tfrac1{4\theta}\sum_c\lambda_c\cdot2t_{02c}=-\tfrac1{2\theta}\sum_c\lambda_ct_{02c}=T$. At $\lambda=(-a,0,a)$ this is $\tfrac a{2\theta}(t_{002}-t_{022})$, L247's $T$.
- Correction: the sign reading assumes $\theta>0$, which holds on the programme's range ($\theta\ge\theta_0(n)>0$) and should be written into the statement, since for $\theta<0$ the roles of the classes swap.

## Item 2: CONFIRMED

- **Hypotheses.** Expanding (A) $\sum_{a,b}t_{cab}=(n-2)d_c$, (B) $\sum_{a,b}\lambda_bt_{cab}=-\lambda_cd_c$ and (C) $\sum_{a,b}\lambda_a\lambda_bt_{cab}=\lambda_c(\theta-\lambda_c)d_c$ over $c=0,1,2$ with $t$ totally symmetric reproduces `h0` to `h8` term by term (off-diagonal pairs counted twice in (A) and (C), the $(a,b)$ and $(b,a)$ terms of (B) combining to $\lambda_a+\lambda_b$). `h9` is $\mathop{\mathrm{tr}}W=0$.
- **Left side.** $\theta\cdot4T=-2\sum_c\lambda_ct_{02c}$, so the Lean left side is $\mathrm{Den}\,(\lambda_0-\lambda_1)(\theta\cdot4T-\theta p_0)=\mathrm{Den}\cdot\theta(\lambda_0-\lambda_1)(4T-p_0)$ with $\mathrm{Den}=2\theta(\lambda_0-\lambda_2)^2(\lambda_1-\lambda_2)^2(n-1)$. The screen confirms the Lean left side equals this expression exactly.
- **Coefficients.** Dividing the Lean coefficients of $t_{000},t_{011},t_{122}$ by Den gives the displayed $c_{000},c_{011},c_{122}$ exactly (checked by hand, residual $0$ in the screen). The constant contains $p_0,m$ and no $p_2$, as the claim says. At $\lambda=(-a,0,a)$ the constant divided by Den is $\tfrac a8p_0(an-5a-\theta)$, and with $a=(2p)^{-1/2}$ (unit $W$) the identity is r1149's $16D=(n-5-\theta\sqrt{2p})p-4t_{000}-t_{011}-4t_{122}$ up to the positive factor.
- **The certificate itself.** Re-expanding the `linear_combination` gives residual $0$, and the nine-row coefficient matrix has rank $7$, as screened in the note.
- **Correction, a strengthening.** The combination uses only `h0` to `h5`, the rows traced over $E_0$ and $E_1$. The rows of $E_2$ and $\mathop{\mathrm{tr}}W=0$ are hypotheses of the theorem and play no part in the proof. The note's "the nine traced rows with $\mathop{\mathrm{tr}}W=0$ give" is true and should read "the six rows traced over $E_0$ and $E_1$ give". Dividing by Den needs $\theta\ne0$, $n\ne1$ and distinct eigenvalues, all of which hold.

## Item 3: CONFIRMED

- $c_{122}=\lambda_2(\lambda_0-\lambda_1)(\lambda_1-\lambda_2)/(\lambda_0-\lambda_2)$: the numerator is (positive)(negative)(negative), which is positive, over a negative denominator, so $c_{122}<0$ for every ordered spectrum with $\lambda_2>0$.
- $c_{011}$: its sign is that of $\lambda_0(2\lambda_1+\lambda_2)-3\lambda_1\lambda_2$. For $\lambda_1\ge0$ the first term is negative ($\lambda_0<0$, $2\lambda_1+\lambda_2>0$) and the second is nonpositive, so $c_{011}<0$.
- $c_{000}$: its sign is that of $-(2\lambda_0\lambda_1-\lambda_0\lambda_2-\lambda_1\lambda_2)$, so $c_{000}\le0$ iff $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$. At $\lambda_1=0$ this reads $-\lambda_0\lambda_2\ge0$, which holds strictly.
- **Direction.** Each $t_{abc}=\mathop{\mathrm{tr}}(P_aB_{bc})\ge0$ since $B_{bc}\succeq0$. On the stated region every $c\le0$, so the right side is at most const. When const $<0$ the left side $\theta(\lambda_0-\lambda_1)(4T-p_0)$ is negative, and with $\theta>0$, $\lambda_0-\lambda_1<0$ this gives $4T>p_0$. With $\mathop{\mathrm{rank}}P_0C=p_0$ that is $\lambda_{\max}(B_{\mathrm{lead}})\ge T/p_0>\tfrac14$, the leading-order threshold $\lambda_{\max}(L_e)\ge2\lambda_{\max}>\tfrac12$ as in L247. The inequality runs the stated way.
- **Correction, the shape of the region.** For $\lambda_1>0$ the condition $\lambda_0(2\lambda_1-\lambda_2)\ge\lambda_1\lambda_2$ has a positive right side, so it needs $\lambda_2>2\lambda_1$ and then reads $\lvert\lambda_0\rvert\ge\lambda_1\lambda_2/(\lambda_2-2\lambda_1)$. The region is therefore $\lambda_1=0$, or $0<\lambda_1<\lambda_2/2$ with $\lvert\lambda_0\rvert$ at least that bound. Worth writing in, since "$\lambda_1\ge0$" alone suggests more.

## Item 4: PLAUSIBLE

- The ad-invariance step is spectrum-free: a unit $w\in E_0$ orthogonal to $P_0[E_0,E_2]$ has $b_{20}(w)=0$. So $\mathop{\mathrm{rank}}P_0C=p_0$ follows from $b_{20}>0$ on the unit sphere of $E_0$ at every spectrum, and the claim's conditional form is correct.
- **What the per-vector rows give at a general spectrum.** At unit $x\in E_0$ the rows read (A) $\sum_{a,b}b_{ab}=n-2$, (B) $\sum_{a,b}\lambda_bb_{ab}=-\lambda_0$, (C) $\sum_{a,b}\lambda_a\lambda_bb_{ab}=\lambda_0(\theta-\lambda_0)$. The multiplier $-\lambda_1^2(\mathrm A)+2\lambda_1(\mathrm B)-(\mathrm C)$, i.e. the form $-(s-\lambda_1)(t-\lambda_1)$ on the spectrum, annihilates $b_{01},b_{11},b_{12}$ and gives
  $$2(\lambda_1-\lambda_0)(\lambda_2-\lambda_1)\,b_{02}=(\lambda_0-\lambda_1)^2(1+b_{00})+(\lambda_2-\lambda_1)^2b_{22}+\lvert\lambda_0\rvert\theta-(n-1)\lambda_1^2 .$$
- So $b_{20}(x)>0$ at every unit $x\in E_0$ whenever $(\lambda_0-\lambda_1)^2+\lvert\lambda_0\rvert\theta>(n-1)\lambda_1^2$. At $\lambda_1=0$ this always holds and the floor is $b_{20}\ge(\lvert\lambda_0\rvert+\theta)/(2\lambda_2)$, which at $\lambda=(-a,0,a)$ is L244's $\tfrac12(\theta/a+1)$.
- **The floor can fail off $\lambda_1=0$.** The screen (an LP on the five remaining per-vector unknowns with $b_{02}=0$) finds $b_{02}=0$ feasible at $n=10$, $\theta=1$, $\lambda=(-1,0.8,1)$, where the condition above fails, and infeasible at three spectra where it holds. So L244's floor does not carry over to every general spectrum. The rank carry-over is justified exactly where the rows force $b_{20}>0$, and the sufficient condition above is one explicit such region.
- **Correction.** Replace "$\mathop{\mathrm{rank}}P_0C=p_0$ as before when the rows keep $b_{20}>0$ on $E_0$" by "$\mathop{\mathrm{rank}}P_0C=p_0$ wherever $(\lambda_0-\lambda_1)^2+\lvert\lambda_0\rvert\theta>(n-1)\lambda_1^2$, by the per-vector rows (L244's floor at $\lambda_1=0$)". Elsewhere the certificate reads $\lambda_{\max}\ge T/\mathop{\mathrm{rank}}P_0C$ with the rank unknown, and $4T>p_0$ no longer implies $\lambda_{\max}>\tfrac14$.
- **Beyond support, minor.** The closing clause "Screened by sympy ..., proved in Lean" is right for the identity only. The sign analysis, the positive-part statement and the rank step are hand arguments with no Lean declaration, as the brief's table says, and the paragraph should say which part is typed.

## Summary

The identity, its coefficients, its Lean statement and the sign argument are correct. Three corrections to the wording: the identity needs only the $E_0$ and $E_1$ rows; the sign region for $\lambda_1>0$ requires $\lambda_2>2\lambda_1$ and $\lvert\lambda_0\rvert\ge\lambda_1\lambda_2/(\lambda_2-2\lambda_1)$; and the rank carry-over holds under the explicit condition $(\lambda_0-\lambda_1)^2+\lvert\lambda_0\rvert\theta>(n-1)\lambda_1^2$, which is automatic at $\lambda_1=0$ and can fail elsewhere.
