# Review r400, the collapsed four-set identity: pure algebra, and its advantage is notional

*Gate 2, adversarial. Cold brief: the identity was derived independently from the six entries before [ATTEMPTS.md](../ATTEMPTS.md) was opened. Analysis only; the two numerical passes are exact rational arithmetic on matrices constructed for the purpose, reported as screens.*

## Verdicts

| # | Claim under review | Verdict |
|---|---|---|
| 1 | The collapsed identity $\Sigma=3m_4-\tfrac12\sigma^2-6\mathop{\mathrm{Var}}(\rho)$ | **CONFIRMED as an identity** |
| 2 | It is a criticality result, the $\theta$-cancellation a discovery | **REFUTED**, pure algebra on six reals; $\theta$ *must* cancel |
| 3 | "Strictly sharper than the incumbent", and that this helps | **CORRECTED / REFUTED**, sharper than a *weakened* incumbent; the gain is $0$ at every dangerous recorded set |
| 4 | The chain $X=\tfrac12\sum(t_c^2-w_c)\to\lVert M\mathbf1_S\rVert^2=2\theta\sigma+E\to X=\theta\sigma-\tfrac12\sum\rho_a^2$ | **CONFIRMED**, every step, including the Laplacian factor and the $E$ cancellation |
| 5 | The $S^6\times S^6$ numbers | **CONFIRMED**, one sixth-decimal slip in $X$ |
| 6 | Novelty ("nothing of this form in findings/" | **REFUTED**), it is [post F50](../findings/second-order.md)'s own identity re-coordinatised |
| 7 | [Post F50](../findings/second-order.md): "equality on the whole two-factor family" | **REFUTED, with witnesses** |

## 1. The identity, derived cold from the six entries

Label the four-set's entries by opposite pairs: $a=M_{ij},a'=M_{kl}$; $b=M_{ik},b'=M_{jl}$; $c=M_{il},c'=M_{jk}$, so $A=a+a'$, $B=b+b'$, $C=c+c'$. Hollowness makes the four within-set row sums the four **even-parity selections**, one entry from each pair:

$$\rho_i=a+b+c,\quad \rho_j=a+b'+c',\quad \rho_k=a'+b+c',\quad \rho_l=a'+b'+c .$$

Each of the six entries appears in exactly two of them, so $\sum_a\rho_a^2=2m_4+2\Xi$ with $\Xi$ the sum of the twelve cross terms. Those twelve group **exactly** into $(a+a')(b+b')+(b+b')(c+c')+(c+c')(a+a')$, giving

$$\sum_{a\in S}\rho_a=2\sigma,\qquad AB+BC+CA=\tfrac12\sum_{a\in S}\rho_a^2-m_4 .$$

With $\Sigma=(A+B+C)^2-3(AB+BC+CA)$ this is

$$\boxed{\ \Sigma=3m_4+\sigma^2-\tfrac32\sum_{a\in S}\rho_a^2=3m_4-\tfrac12\sigma^2-6\mathop{\mathrm{Var}}(\rho).\ }$$

**The hypotheses it consumes are $M$ symmetric and hollow, and nothing else.** No criticality, no $M\mathbf1=0$, no $\mathop{\mathrm{tr}}M^2=2$. It is an identity on six arbitrary reals, checked by hand on $a=1$; $a=a'=1$; $a=b=1$ (returning $1,4,1$) and then as exact `Fraction` equality at every four-set evaluated below.

**So the $\theta$-cancellation is forced, not discovered.** The endpoint is $\theta$-free by algebra; any route that reaches it through two $\theta$-carrying steps must cancel $\theta$. The section presents the cancellation as the payoff of the collapse (*"No $\theta$, no complement"*) when it is a consequence of the destination.

### 1a. The correction term IS the incumbent's Cauchy–Schwarz defect

Put $u=M_{ij}-M_{kl}$, $v=M_{ik}-M_{jl}$, $w=M_{il}-M_{jk}$. The four deviations $\rho_a-\bar\rho$ are $\tfrac12(u{+}v{+}w),\ \tfrac12(u{-}v{-}w),\ \tfrac12({-}u{+}v{-}w),\ \tfrac12({-}u{-}v{+}w)$, whose squares sum to $u^2+v^2+w^2$ exactly. Hence

$$6\mathop{\mathrm{Var}}(\rho)=\tfrac32\big(u^2+v^2+w^2\big)=\tfrac32\!\!\sum_{\text{opposite pairs}}\!\!\big(M_{ij}-M_{kl}\big)^2=3m_4-\tfrac32\big(A^2{+}B^2{+}C^2\big),$$

which is precisely the defect in $A^2\le2(a^2+a'^2)$, the one step that turns [post F50](../findings/second-order.md)'s identity into [post F50](../findings/second-order.md)'s bound. **Both bounds are tight on the same set**, $\{u=v=w=0\}$, and $\mathop{\mathrm{Var}}(\rho)=0\iff a=a',\,b=b',\,c=c'$.

**The same defect appears twice over.** Cauchy–Schwarz on the four $\rho_a$ gives $\sum\rho_a^2\ge\sigma^2$, and substituting that into the boxed identity returns $\Sigma\le3m_4-\tfrac12\sigma^2$ again. So the incumbent is reachable from the identity in the $(A,B,C)$ variables *and* in the $\rho$ variables, with the same defect $6\mathop{\mathrm{Var}}(\rho)$ both times.

## 2. Novelty, REFUTED

[Post F50](../findings/second-order.md) already records $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$ **as an identity**, and derives $\Sigma\le3m_4-\tfrac12\sigma^2$ from it by one Cauchy–Schwarz. Section 1a shows the collapsed form is that same identity written in $(\rho,m_4)$ instead of $(A,B,C)$; the change of variables is invertible, since $\sum A^2=2m_4-(u^2{+}v^2{+}w^2)$ and $u,v,w$ are recovered from the $\rho$'s by $u=\tfrac12(\rho_i+\rho_j-\rho_k-\rho_l)$ and its two partners.

**Consequence for the "beats the incumbent" claim.** The record's incumbent is F50's *identity*, which is exact and therefore unimprovable. The section compares against F50's *weakened* corollary. Calling the result "strictly sharper" is true of the corollary and empty of the identity.

**What the $\rho$ coordinates do add, and it is one thing.** By $M\mathbf1=0$, $\rho_a=-\sum_{c\notin S}M_{ac}$, so the correction term is the spread of the four rows' **flows into the complement**, a quantity $(A,B,C)$ cannot see. That is a real handle, and it is unexploited.

## 3. The chain, every step CONFIRMED

**(a) $X=\tfrac12\sum_{c\notin S}(t_c^2-w_c)$.** For fixed $c$, $\sum_{a<b\in S}M_{ac}M_{cb}=\tfrac12\big[(\sum_{a\in S}M_{ac})^2-\sum_{a\in S}M_{ac}^2\big]$. Algebra only. ✓

**(b) $\sum_{c\notin S}t_c=-2\sigma$ and $\sum_{c\notin S}w_c=\sum_{a\in S}s_a-2m_4$.** The first is $\sum_{a\in S}(0-\rho_a)$ and uses $M\mathbf1=0$; the second splits each row mass. ✓

**(c) $\lVert M\mathbf1_S\rVert^2=\sum_{c\notin S}t_c^2+\sum_{a\in S}\rho_a^2$.** $(M\mathbf1_S)_x$ is $t_x$ off $S$ and $\rho_x$ on $S$. ✓

**(d) $\mathbf1_S^\top M^2\mathbf1_S=2\theta\sigma+E$, and the Laplacian factor is right.** [Lemma L129](../findings/diagonal-half.md)'s $M^2=\theta M+L(w)$ re-derived cold: criticality gives $(M^2)_{ij}=\theta M_{ij}-w_{ij}$ off the diagonal, and hollowness gives $(M^2)_{ii}=s_i=\sum_bw_{ib}$ on it, so $M^2-\theta M$ is exactly $D-W$ for the weight matrix $w=M^{\circ2}$. Then $\mathbf1_S^\top M\mathbf1_S=2\sigma$, and $\mathbf1_S^\top L(w)\mathbf1_S=\sum_{\{a,b\}}w_{ab}(\mathbf1_S(a)-\mathbf1_S(b))^2=\sum_{a\in S,\,b\notin S}M_{ab}^2=E$, each cross pair counted once. **No factor-of-two error.** ✓

**(e) $E$ cancels exactly, but it is not a cancellation.** $\sum_{c\notin S}w_c$ of step (b) and $E$ of step (d) are the *same sum over the same cross pairs*, written two ways. They cancel identically, at every matrix, for that reason. ✓

**(f) $X=\theta\sigma-\tfrac12\sum_{a\in S}\rho_a^2$.** Follows from (a)–(e). **This is the only genuinely criticality-dependent statement in the section, and it is the part worth keeping**, see §6. ✓

**(g) The substitution into $\Sigma=3m_4+\sigma^2-3\theta\sigma+3X$.** Correct. But note the joint content: since the endpoint is an algebraic identity (§1), (f) and (g) are **equivalent to each other** given that algebra. The section derives one from the other and reports the agreement as a collapse; the two carry one piece of information between them, not two.

**Variance convention.** $\sum\rho_a^2-\sigma^2=4\mathop{\mathrm{Var}}(\rho)$ holds with $\mathop{\mathrm{Var}}=\tfrac14\sum(\rho_a-\bar\rho)^2$, the population variance over the four values, $\bar\rho=\sigma/2$. The section uses it consistently. ✓

## 4. The evaluations, including the one that was owed

Two-factor point $S^p\times S^q$: $\alpha$ within $F_1$, $\beta$ within $F_2$, $\gamma=-t$ across; $(p-1)\alpha+q\gamma=0$, $(q-1)\beta+p\gamma=0$, $\mathop{\mathrm{tr}}M^2=2$, $\theta=(n-1)t$. Exact rational arithmetic throughout.

**Closed forms by four-set type, derived cold:**

| type | $\Sigma$ | $6\mathop{\mathrm{Var}}(\rho)$ = incumbent slack |
|---|---|---|
| $(4,0)$ / $(0,4)$ | $0$ | $0$, all six entries equal |
| $(3,1)$ / $(1,3)$ | $0$ | $\tfrac92(\alpha-\gamma)^2$ |
| $(2,2)$ | $(\alpha+\beta-2\gamma)^2$ | $\tfrac32(\alpha-\beta)^2$ |

**The numbers:**

| point | $\theta^2$ | set | $\Sigma$ | incumbent $3m_4-\tfrac12\sigma^2$ | $6\mathop{\mathrm{Var}}(\rho)$ | $m_4$ |
|---|---|---|---|---|---|---|
| $S^6\times S^6$ | $1.527778$ | $(4,0)$ | $0$ | $0$ | $0$ | $0.109091$ |
| | | $(3,1)$ | $0$ | $0.275000$ | $0.275000$ | $0.092424$ |
| | | $(2,2)$ | $0.244444$ | $0.244444$ | $\mathbf0$ | $0.086869$ |
| $S^5\times S^7$ | $1.508571$ | $(3,1)$ | $0$ | $0.424286$ | $0.424286$ | $0.151948$ |
| | | $(2,2)$ | $0.261905$ | $0.277619$ | $0.015714$ | $0.096710$ |
| $S^5\times S^{43}$ | $1.596764$ | $(4,0)$ | $0$ | $0$ | $\mathbf0$ | $\mathbf{0.501203}$ |
| | | $(3,1)$ | $0$ | $0.449090$ | $0.449090$ | $0.252770$ |
| | | $(2,2)$ | $0.119712$ | $0.242253$ | $0.122541$ | $0.086435$ |

*Calibration: this parametrisation reproduces $\theta=1.236033$, $1.228239$, $1.263631$ and the recorded $m_4=0.501203$ at [post F50](../findings/second-order.md)'s $S^5\times S^{43}$ witness, to every printed digit.*

**The $S^6\times S^6$ numbers are confirmed**, with one slip: $X=-\tfrac{118}{495}=-0.2383838$, not the printed $-0.238387$. Sixth decimal, immaterial to anything.

## 5. Does it help?, the advantage is notional

**The improvement vanishes exactly where the mass concentrates.**

- At every $(4,0)$ set of every $S^p\times S^q$ all six entries are $\alpha$, so $\mathop{\mathrm{Var}}(\rho)=0$ and the incumbent is *already exact* at $0$. **This is [post F50](../findings/second-order.md)'s own witness**, $m_4=0.501203$, the configuration that killed the mass criterion. The new term contributes nothing there.
- At every balanced $(2,2)$ split, $\alpha=\beta$, so $\mathop{\mathrm{Var}}(\rho)=0$ and the incumbent is exact. $S^6\times S^6$ is this case.
- The reason is symmetry, and it is structural: $\rho_a=-\sum_{c\notin S}M_{ac}$, and when the four indices of $S$ sit in one factor they have identical flows into the complement by the family's own symmetry. **The correction is annihilated by exactly the symmetry that makes $m_4$ large.**

**Where the term is nonzero, nothing is decided by it.** Screen over every in-band two-factor four-set, $5\le p\le40$, $q\le200$: $\max\ (3m_4-\tfrac12\sigma^2)/\theta^2=0.28125$, at $S^5\times S^7$'s $(3,1)$ set. *The incumbent alone clears $\Sigma\ne\theta^2$ by a factor exceeding $3.5$ everywhere in the family*, so subtracting $6\mathop{\mathrm{Var}}(\rho)$ never changes a verdict at any recorded point.

**And no unconditional lower bound on $\mathop{\mathrm{Var}}(\rho)$ exists.** Witness: every $(4,0)$ four-set of every $S^p\times S^q$ with $p\ge4$ has $\mathop{\mathrm{Var}}(\rho)=0$ exactly. A conditional bound is what would be needed ("$m_4$ large $\Rightarrow\mathop{\mathrm{Var}}(\rho)$ large") and the same witness refutes that too, carrying the family's *largest* $m_4$ at $\mathop{\mathrm{Var}}=0$. **The one hypothesis under which the identity could pay is therefore the one the family's witnesses falsify.**

## 6. What actually survives

**The criticality content of the section is (f), not the collapsed identity.** Combining (f) with the algebraic identity of §1 gives a statement that is *not* algebra:

$$\sum_{a<b\in S}\ \sum_{c\notin S}M_{ac}M_{cb}\;=\;\theta\sigma-\tfrac12\sum_{a\in S}\rho_a^2 ,$$

**the four-set's coupling to its complement, pinned by $\theta$ and four within-set row sums.** This is the first quantity in the item that lives outside $S$ and survives to an equality. It bounds $\Sigma$ by nothing on its own (it is the term that cancels out of $\Sigma$) but it is the one thing here that criticality buys.

**And it composes with the section's own Cauchy–Schwarz on $t$** ($\sum t_c^2\ge4\sigma^2/(n-4)$) into a genuine inequality:

$$\tfrac12\sum_{a\in S}s_a+\theta\sigma\;\ge\;\frac{2\sigma^2}{n-4}+m_4+\tfrac12\sum_{a\in S}\rho_a^2 .$$

*Screened at $S^6\times S^6$'s $(2,2)$ set: both sides equal $1/9$, the Cauchy–Schwarz is tight there, because every outside index has $t_c=0.4t$ by symmetry. It is strict at $S^5\times S^{43}$. So this inequality is also blind at the balanced point, and a successor should check its slack before spending a cycle on it.*

## 7. Correction owed to [post F50](../findings/second-order.md)

> "$\Sigma\le3m_4-\tfrac12\sigma^2$, **equality on the whole two-factor family**"

**This is false, and the identity of §1 says exactly why.** Equality needs $\mathop{\mathrm{Var}}(\rho)=0$, i.e. $\alpha=\beta$ at a $(2,2)$ split. Witnesses:

- $S^5\times S^7$, $(2,2)$: incumbent $0.277619$ against $\Sigma=0.261905$.
- $S^5\times S^{43}$, $(2,2)$: incumbent $0.242253$ against $\Sigma=0.119712$, a factor of $2.02$.
- Every $(3,1)$ set of every unbalanced or balanced product: incumbent $\tfrac92(\alpha-\gamma)^2>0$ against $\Sigma=0$.

**Equality holds exactly on the $(4,0)/(0,4)$ sets and on the $(2,2)$ sets of the *balanced* products.** The record's own $S^6\times S^6$ sits in the second class, which is why the claim was never caught.

## 8. Silently used hypotheses

1. **Criticality and $M\mathbf1=0$ are consumed by the derivation and unused by the conclusion.** The section's framing, the identity arriving *through* [Lemma L129](../findings/diagonal-half.md), implies the identity is a fact about critical points. It holds at every hollow symmetric matrix, and a reader who takes the framing at face value will not apply it off the critical set, where it is equally true.
2. **Hollowness is used and unstated.** $\rho_a=\sum_{b\in S}M_{ab}$ is a three-term sum only because $M_{aa}=0$; with a diagonal the parity structure of §1 breaks and the identity fails.
3. **$\mathop{\mathrm{Var}}$ is the population variance over four values.** Used correctly, never defined.
4. **"$\mathop{\mathrm{Var}}(\rho)\ge0$" is offered as the source of the improvement.** The improvement's real source is a Cauchy–Schwarz defect that the record's own [post F50](../findings/second-order.md) discarded one line earlier; the positivity is not additional information.

## 9. What a successor must clear

Any use of the $\rho$ form must beat this test, which [post F51](../findings/INDEX-traps.md)'s two checks do not catch:

- **Does the correction survive the family's symmetry?** $\mathop{\mathrm{Var}}(\rho)$ is the spread of the four complement-flows, and it is annihilated by any symmetry acting transitively on $S$, which is what every high-$m_4$ four-set in the record has. A correction term that vanishes on the witnesses is not a correction to the witnesses.
- **Compare against the identity, not the corollary.** [Post F50](../findings/second-order.md) records $\Sigma=\tfrac32(A^2+B^2+C^2)-\tfrac12\sigma^2$, exact. Nothing can be "sharper" than it; a new form must either use an input it lacks ($\theta$, the complement, the row masses) or be a change of coordinates.
