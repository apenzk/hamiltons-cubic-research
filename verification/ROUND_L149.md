# ROUND L149, the uniformity of the tube-radius branch bound

**Id** L149 · **File** [findings/second-order.md](../findings/second-order.md), lines **1181–1307** · **Statement and proof quoted from lines 1181–1213** · **Opened** 2026-09-05

**Verifiers allocated:** v11, v12, v13. **Phase:** 1, dispatched.

**Why this id first.** [plan-verification.md](../plan-verification.md)'s Queue changes entry of 2026-09-05: the tube-radius constant chain is audited as a block ahead of tier 0, because every one of its six lemmas examined during that day's research loop carried a defect, this one twice under different reviewers, and two of them had already passed Gate 2.

**Canonical cross-check.** [results.md](../results.md) carries no entry for L149 itself. Its L158 entry described this lemma's branch 2 as having an interior minimum; that copy was corrected before dispatch, and the correction is not in the brief.

## The brief as dispatched

**CORRECTED 2026-09-05, mid-phase-1: the fence was two lines short**, ending mid-sentence before the displayed $g(w^*)$ and the endpoint check. Source is lines **1181–1215**, the proof closing with $\square$ at 1215. v11 read the truncated brief, flagged it, and re-derived the missing step independently; v12 and v13 were sent the missing lines while running.

**Provenance stripped, mathematics verbatim.** The block at [findings/second-order.md](../findings/second-order.md):1181–1213 interleaves its statement and proof with Gate 2 verdicts and reviewer numbers, which [the skill](../.claude/skills/verification-loop/SKILL.md) requires be withheld. So every mathematical sentence is quoted unchanged and the provenance sentences are removed: the derivation line, one verdict attribution, three inline reviewer citations replaced by *"a prior review"*, and the Gate 2 clause. **Nothing mathematical was altered, and no paraphrase was introduced.**

```
#### Lemma L149, no direction is both low-margin and high-operator-norm, so the bound is uniform


> **THE SUBSTANCE, STATED AS BOTH REVIEWERS STATE IT.** *No direction is both low-margin and high-operator-norm*, and that single fact is the sweep:
> $$\lVert A''\rVert=\Theta(n)\ \Rightarrow\ \lVert H\rVert_{op}=\Theta(1)\ \Rightarrow\ w=\Theta(1)\ \Rightarrow\ c(H)=\Theta(1).$$
> **So a prior review's counterexample direction (margin $\Theta(1/n)$ with $\lVert A''\rVert=\Theta(n)$), does not exist.** *An earlier version of this entry called it the minimiser, which is weaker and was wrong: margin $\Theta(1/n)$ forces $w\lesssim n^{-1/2}$, hence $\lVert A''\rVert=O(n^{1/2})$, and the branch returns to $\Theta(n^{-1})$.*

**Set-up, with the correction that decides it.** At $p=q=m$ there are **two** $S^2_0(\mathbb R^m)$ summands, both carrying $\lambda_m$, the swap of the factors fixes $W^*$ and commutes with $L_e$. *Write $H=H_s+H_r$ with $H_s$ in the **joint** $\lambda_m$-eigenspace, both copies, and $w:=\lVert H_r\rVert$ the weight outside **both**.* **An earlier version wrote "the margin summand", singular, and put the second copy into $H_r$**, under which a unit vector in that copy has $w=1$ while $c(H)=c_p=\Theta(1/n)$ against a claimed $\Theta(1)$: *wrong by a factor $n$ on a subspace of dimension $\Theta(n^2)$.* [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects), a prior review and a prior review all say *two*; reading $w$ as the weight outside both restores every number unchanged.

**The two inputs, uniform in $w$, for $m\ge5$.** *[L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) prices **one** $S^2_0(\mathbb R^m)$ copy and is applied here to the **joint** two-copy eigenspace; no $\sqrt2$ is owed, the two images being Hilbert–Schmidt orthogonal and the cross-plane branch reaching only $\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$ at $n=12$, recorded because the step was silent.*

- $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$, by the triangle inequality and [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects), which is homogeneous so $\lVert H_s\rVert_F<1$ only helps.
- $c(H)\ge c_p+3\theta_0\tfrac{m-4}{2(m-1)}\,w^2$, the margin being $3\theta_0(\tfrac12-\lambda)$ on each summand of [Lemma L27](nondegeneracy.md) and the form quadratic, so on $\lVert H\rVert_F=1$ it is a **convex combination** of the summand margins. *The bound once written here, $c(H)\gtrsim c_p+w^2$, is **a lower bound stated upward** at the dimensions that matter: the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$. **It is unsafe exactly on $n\in\{12,14\}$**, and repairing it lowers branch 2 there, which strengthens rather than weakens [L158](ROUND_L158.md#lemma-l158-the-branch-comparison-is-n-free-and-it-says-suplvert-prvert-must-grow-before-i31-can-bind)'s conclusion that branch 2 binds.* **The range matters**: the smallest off-summand margin is the $+\mu$ one, $3\theta_0\frac{m-3}{2(m-1)}$, which is **zero at $m=3$** and ties with $c_p$ at $m=4$, reaching $\ge\tfrac34\theta_0$ only from $m=5$. *The orbit summand is excluded cleanly, $E(\tfrac12)$ **equals** the orbit tangent by [Lemma L27](nondegeneracy.md).*

Hence $\lVert A''\rVert=O(1/\rho)=O(n^{1/2}+nw)$, and with $S:=\sup\lvert P\rvert=\Theta(n^\beta)$,

$$r(H)\;\gtrsim\;\min\!\left(\frac{c_p+w^2}{S},\ \frac{\sqrt{c_p+w^2}}{n^{1/2}+nw},\ \frac{\rho(H)}2\right).$$

> **LEMMA L149.** *For $m\ge5$, the second branch is $\Omega(n^{-1})$ **uniformly in $w\in[0,1]$**, the first is minimised at $w=0$, and the validity branch is $\Omega(n^{-1})$ as well. Hence*
> $$r_n\;\gtrsim\;n^{-1-\beta}\quad\text{over every direction},\qquad\text{with }\Theta(n^{-1})\text{ the ceiling of the method.}$$

> $$\rho_n^{\mathrm{eff}}=3\theta_0\frac{n-8}{2(n-2)}-\frac29\lvert\kappa_n\rvert,\qquad\lvert\kappa_n\rvert=9\big(\theta_0(n)-\sqrt{3/2}\big),$$
> **increasing from $0.71904$ at $n=12$ through $0.87239$ and $0.98564$ to $\tfrac32\sqrt2-2(\sqrt2-\sqrt{3/2})=1.74238$.** *This entry charges itself with the penalty in "The penalty term, which had no account" and did not carry it into the margin.*
>
> **THE CLOSED FORM IS NOT THE MINIMUM, THOUGH IT SURVIVES AS A LOWER BOUND.** Carrying the *uncorrected* $\rho_n$ through gives $w^*=Bc/(\rho A)$ with $\theta_0$ cancelling as it does from the ratio, *it does **not** cancel once the penalty is carried, $\kappa/\rho^{\mathrm{eff}}$ being $6.188$ against $6$ at $n=12$ and $2.435$ against $2$ asymptotically*, so $w^*=2\sqrt n/(n-8)$, which is $3.16$, $1.73$ and $1.25$ at $n=10,12,14$ and reaches $1$ only at $n=16$. *So the stationary point is outside $[0,1]$ at every dimension in range, and it also exceeds [L158](ROUND_L158.md#lemma-l158-the-branch-comparison-is-n-free-and-it-says-suplvert-prvert-must-grow-before-i31-can-bind)'s saturation kink $w_0=(n-4)/n$ under every reading of $A$*, **the minimiser sits where the operator-norm envelope has saturated and neither the interior nor the endpoint expression applies.** *What the closed form $\tfrac1n\sqrt{\kappa(n-8)/(3n-8)}$ remains is a **valid but lossy lower bound**, $15.5\%$ low at $n=12$, and that is what carries $\Theta(n^{-1})$ and this lemma's conclusion, rather than any claim to be the infimum.* **The ratios once quoted here compared two unattained values**: at the attained minimum they are $0.9008$ and $0.9794$, and $0.9215$ and $0.9840$ under the admissible envelope; only the $1.32$ asymptote was right, and only from $n\ge16$.

> **WHAT THE COEFFICIENT DOES BUY, AND IT IS THE EXPONENT RATHER THAN THE CONSTANT.** At $\rho=0$, which is $m=4$, branch 2 degrades to $\Theta(n^{-3/2})$, *so $m\ge5$ is load-bearing for the $\Omega(n^{-1})$ conclusion itself, not merely for its constant*. **The order $\Theta(n^{-1})$ and this lemma's stated conclusion both stand.**

**Proof of the uniformity.** With $g(w)=\sqrt{c+w^2}/(A+Bw)$, $c=\kappa/n$, $A=n^{1/2}$, $B=n$, *the repaired form carries $\rho_n$ on the $w^2$, treated in the blockquote above*:
$$\operatorname{sign}g'(w)=\operatorname{sign}(wA-Bc),$$
so $g$ has a single interior minimum at $w^*=Bc/A=\kappa n^{-1/2}$, where
$$g(w^*)=\frac{\sqrt c}{\sqrt{A^2+B^2c}}=\frac1n\sqrt{\frac\kappa{1+\kappa}} .$$
The endpoints give $\sqrt\kappa/n$ and $\asymp1/n$, so the branch never leaves that order. $\square$ *An earlier version displayed this value with $A+Bc/A$ in place of $A+B^2c/A$; the literal expression evaluates to $g(0)$ rather than the minimum, which is how both reviewers' grid screens caught it.*
```

## Clustering

**Three verifiers, all `GAP`.** Clustered by the step attacked and the mechanism, not by wording.

| # | finding | step attacked | raised by |
|---|---|---|---|
| **F1** | $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is **negative at $n=10$**, the range's own smallest dimension ($\theta_0(10)=6/5$ exactly) | the $\rho^{\mathrm{eff}}$ display | v11, v12, v13 |
| **F2** | *"unsafe exactly on $n\in\{12,14\}$"* is false, $\rho^{\mathrm{eff}}_{16}=0.98564<1$, printed three lines below the claim; and $m\ge5$ admits $n=10$ | the margin bullet's gloss | v11, v12 |
| **F3** | **Three hypotheses used and never stated**: $H\perp W^*$ (the $\langle W\rangle$ summand carries margin $-\tfrac32\theta_0$), $H\perp T_{W^*}\mathcal O$, and $\beta\ge0$ | the convex-combination step and the ceiling clause | v11, v12, v13 |
| **F4** | *"valid but lossy lower bound, $15.5\%$ low"*, unreproducible under nine readings between them, and under the penalised coefficient it **exceeds** the branch-2 minimum at $n=14$, so it is not a lower bound at all | the closed-form gloss | v11, v12, v13 |
| **F5** | The $w^*$-location claims are stated for all $m\ge5$ and are **false above $n=18$**, at $n=20$, $w^*=0.7454<w_0=0.8$, contradicting the block's own *"reaches 1 only at $n=16$"* two lines above | the "outside $[0,1]$ and above the kink" clause | v11, v12, v13 |
| **F6** | $A=n^{1/2}$ discards [L146](../findings/second-order.md)'s own $1/\sqrt{m-1}$, so the displayed constant is a lower bound stated upward | the "Proof of the uniformity" inputs | v11, v13 |
| **F7** | **The kernel hypothesis is nowhere stated**: branches 2 and 3 rest on $\rho(H)\ge g_n/\lVert H\rVert_{op}$, i.e. $\ker W^*=0$ | branches 2 and 3 | v13 |
| **F8** | **Nothing in the block bounds the repaired branch 2 below.** The written proof executes at $w^2$-coefficient $1$ (the form the block itself calls unsafe) and the repaired case is delegated to a blockquote the round refutes elsewhere | the proof as a whole | v12 |
| **F9** | $\rho^{\mathrm{eff}}_n>0$ across the range has **no argument on file**, four values and the word *"increasing"*. It is what separates $\Omega(n^{-1})$ from $\Theta(n^{-3/2})$ | the $\rho^{\mathrm{eff}}$ display | v12 |
| **F10** | The $m=4$ argument names the wrong failure, the joint-eigenspace recipe gives $\rho=\theta_0>0$ there; what fails is L146's operator-norm input | the "what the coefficient buys" clause | v11 |
| **F11** | $\kappa$ and $w^*$ each name two different quantities inside one block | notation | v12 |
| **F12** | *"the first is minimised at $w=0$"*, branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)<0$, and $u\ne w$ | the boxed statement | v13 raises; **v11 withdrew the same candidate** |

### Disposed in phase 2, before adjudication

- **v11's "the $\tfrac29$ carries no argument on file", DISPOSED.** The loop's own check *search the whole record before accepting "no argument on file"* locates it at [findings/second-order.md:949](../findings/second-order.md), and v13 reconstructs $\rho^{\mathrm{eff}}$ term-for-term from it. *A finding about the brief, not about the record, which is what that check exists to catch.*
- **The brief was two lines short**, ending mid-sentence before the displayed $g(w^*)$ and the endpoint check. Found by the round's re-read against source and by v11 independently; v12 and v13 were sent the missing lines mid-run, and v13 had already recovered them from source. **Corrected above; no finding rests on it.**

### Confirmed by the verifiers, and recorded because a pass means what it enumerates

- The **margin bullet is exactly tight**: the $(m-4)$ coefficient is (smallest off-summand margin) $-\,c_p$, from [L27](../findings/nondegeneracy.md)'s ten summands, with equality exhibited on an $S^2_0\oplus(\Lambda^2\otimes\Lambda^2)$ family (v12, v13).
- The **two-copy operator-norm step closes for every $m\ge3$**, not merely at $n=12$ as the block records: in-block $1/\sqrt{m-1}$ beats cross-plane $\sqrt{m-2}/m$ since $(m-1)(m-2)<m^2$ (v13). **No $\sqrt2$ is owed.**
- All four $\rho^{\mathrm{eff}}$ values, $\kappa/\rho^{\mathrm{eff}}=6.188$ and $2.435$, $\kappa/\rho=2n/(n-8)$, $w^*=2\sqrt n/(n-8)$ and $g(w^*)$ reproduce **exactly** by hand (all three).
- **No falsifying direction exists inside the scope** (v12, trying a witness from each of L27's ten summands).


## Adjudications

### F8, CONFIRMED

**v14 and v15, on the neutral question, both `GAP`.** Neither was told a finding existed.

> **The boxed claim is true; the written proof does not establish it, and no other text in the block supplies the missing step.** (v15)

- **The direction of the error, derived rather than assumed.** $\min_{w\ge0}\sqrt{c+\rho w^2}/(A+Bw)=\tfrac1n(1/\rho+1/\kappa)^{-1/2}$, **strictly increasing in $\rho$**. So a proof executed at $\rho=1$ when the inputs give $\rho^{\mathrm{eff}}<1$ bounds the truth **from above**, $0.903606/n$ against $0.786775/n$ at $n=12$, an overstatement of $14.85\%$. *A lower bound stated upward, inside the proof of the lemma whose margin bullet was repaired for exactly that fault.* **Reproduced by the round independently.**
- **Three coefficients in one block.** The margin bullet's $3\theta_0\tfrac{m-4}{2(m-1)}$ and the blockquote's $\rho_n^{\mathrm{eff}}$ are related but distinct, and the proof's $1$ is a third value the inputs never supply. *The bullet's $m$-form and the blockquote's $n$-form are the same quantity under $n=2m$, both equal to $c_{\min}-c_p$, which also resolves the apparent $(m-3)$/$(m-4)$ clash, tested and **withdrawn** by three verifiers.*
- **A self-contradiction twelve lines wide.** Line 1213 asserts *"a single interior minimum"*; line 1207 asserts the opposite. $w^*\le1$ requires $n\ge10+\sqrt{82}=19.055$ at coefficient $1$, and $n\ge16$ at $\rho_n$.
- **The nominated repair fails.** $\rho_n\kappa/(\rho_n+\kappa)=\kappa(n-8)/(3n-8)$ **identically**, so the closed form is the *pre-penalty* infimum; against the $\rho^{\mathrm{eff}}$ branch it overshoots at $n=14$, $16$ and asymptotically, holding at $n=12$ alone by $1.6\%$. *Reproduced by the round.*
- **The order survives, by a line the block does not write.** $\inf_{[0,1]}g_\rho\ge\inf_{w\ge0}g_\rho$ whatever $w^*$ does, giving branch $2\ge0.7841/n$ for every $n\ge12$ (v15), or $\ge0.714/n$ carrying $a_0$ (v14). **Both adjudicators reach $\Omega(n^{-1})$ by the same route, and it is not the block's.**

**Hypotheses, from both.** $m\ge5$ is **overstated**: at $n=10$, $\theta_0=6/5<\sqrt{3/2}$, so $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$ is negative and $\rho^{\mathrm{eff}}$ has no definition, honest range $m\ge6$. $\ker W^*=0$ is **used and never stated**, inherited silently from [L145](../findings/second-order.md); without it $W\mapsto W_-$ is not analytic at $W^*$ and branch 2 has no domain. **$\beta$ is irrelevant to the boxed claim**, it enters branch 1 and the final display only, which narrows F3.

## Spread and impact

**Impact class: `NARROWS`.** The order conclusion and the boxed claim stand; what falls is the proof of them, the stated range, and every constant quoted around it.

| dependent | kind | disposition |
|---|---|---|
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), `Lem 149` | **full copy, not a citation**, a second original | `NARROWED`. Carries the uncorrected $c(H)\gtrsim c_p+w^2$ and $m\ge5$; both corrected in the same commit |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row 149 | index row stating the range | `NARROWED` to $m\ge6$, verdict replaced |
| [results.md](../results.md):367, L158's entry | cites L149's parametrisation and branch-2 order | `SURVIVES`, it uses the order, which stands, and was already corrected today for the interior-minimum claim |
| [plan.md](../plan.md) I2, I33 | name L149 as structurally complete | `SURVIVES`, they cite the conclusion, not the constant |
| [findings/LEDGER.md](../findings/LEDGER.md) | no L149 row | not a dependent |

*The copy in the report was found by the statement-signature search, not by the number search, it never names L149's number in the line that carries the claim.*




## Outcome

**Verdict: `GAP` on the proof as written. Repaired, and the repair is unaudited.**

**What was deleted.** The proof that ran on $g(w)=\sqrt{c+w^2}/(A+Bw)$ at $w^2$-coefficient $1$, its stationary point $w^*=\kappa n^{-1/2}$, its value $\tfrac1n\sqrt{\kappa/(1+\kappa)}$ and its endpoint check; the blockquote clauses asserting the closed form is a valid lower bound $15.5\%$ low, and that the stationary point is outside $[0,1]$ *at every dimension in range*. **The old text is gone rather than annotated**; it survives here and in [ATTEMPTS.md](../ATTEMPTS.md).

**What replaced it.** One line, needing no case analysis on where the stationary point sits:
$$\inf_{w\in[0,1]}g_\rho\;\ge\;\inf_{w\ge0}g_\rho\;=\;\frac1n\sqrt{\frac{\rho\,\kappa}{\rho\,a_0^2+\kappa}},\qquad a_0=\sqrt{\tfrac{2n}{n-2}},\ \rho=\rho^{\mathrm{eff}}_n,$$
increasing in $n$ and equal to $0.71980/n$ at $n=12$, **so branch 2 is $\ge0.7198/n$ for every even $n\ge12$, uniformly in $w$.** *Both adjudicators reached this bound independently, v14 carrying $a_0$ and v15 without it.*

**Hypotheses now stated:** $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, and $\ker W^*=0$, the last **holds**, its gap recorded at [L145](../findings/second-order.md), and was used silently. **Range narrowed to $m\ge6$**, since $\lvert\kappa_{10}\rvert$ is negative as written.

**Copies corrected in the same commit**, per phase 4: the full statement in [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex), which carried the uncorrected margin and $m\ge5$ and which the number search never found; the row in [findings/INDEX-results.md](../findings/INDEX-results.md); and [L158](../findings/second-order.md)'s citation of $n^{-1}\sqrt{\kappa/(1+\kappa)}$, high by $11.5\%$ at $n=12$.

**Findings F1–F7 and F9–F12 are not adjudicated.** F8 was taken first as the only one reaching the proof itself, and the repair subsumes F1, F2, F5 and F6 by rewriting the text they attacked; F3's $\beta$ clause is narrowed by both adjudicators. **F7, F9, F10, F11 and F12 remain open and are carried to the queue.**

**The repair enters the queue unchecked**, at the top of the chain block, per the rule that a repair is a new result its author does not bless.
