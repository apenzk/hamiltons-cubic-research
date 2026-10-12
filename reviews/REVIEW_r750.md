# r750, L169, the grading and tracelessness determine the saturating operator (Gate 2)

**Cold review.** I worked from [BRIEF-g2-l169.md](BRIEF-g2-l169.md) alone and from mathematics I derived myself; I did not open the findings file the block came from, nor any sibling report, before forming a verdict on every claim. **No numerical work was done.** Every value below is exact, rational or closed-form radical. Three exact screens are reported as screens, in the sense of the standing rule: seconds of `Fraction` arithmetic on curvature tensors I constructed for the purpose, each one *checking a claim I had already derived by hand*, never standing in for a derivation. Log: [agent_logs/g2-l169-r750.log](../agent_logs/g2-l169-r750.log).

## Claim table

| # | Claim as written | Verdict |
|---|---|---|
| C1 | "Ricci-flatness makes $W$ traceless on $\Lambda^2$" | **CONFIRMED**, one-way implication, equivalent only to scalar-flatness; the argument closes because only the implication is consumed |
| C2 | $r=\tfrac{n(n-2)}4$, $N-r=\tfrac{n^2}4$, $\tfrac r{N-r}=\tfrac{n-2}n$ | **CONFIRMED**, all three exact |
| C3 | "exactly two eigenvalues" gives $E_{\min}=E_{\max}^\perp$, no kernel | **CONFIRMED**, airtight; a kernel would be a third eigenvalue |
| C4 | $W$ is the unit **positive** multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ | **CONFIRMED**, and over-determined: the sign is forced twice over |
| C5 | That operator is $W_{S^{n/2}\times S^{n/2}}$ at unit norm | **CONFIRMED**, re-derived from the Einstein reduction, $\kappa=\tfrac{m-1}{2m-1}=\tfrac rN$ |
| C6 | $\theta=\theta_0(n)$ | **CONFIRMED as a value**, derived cold from three $\#$-identities, no criticality; screened exact at $n=4,6,8$ |
| C7 | The closed form $\theta=\tfrac2n\sqrt{\tfrac{rN}{N-r}}$ is available here | **REFUTED as a family identity**, it is false at $\mathfrak h=\mathfrak{so}(n-1)$, $\mathfrak u(m)$ and unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$, in closed form; true at the balanced member |
| C8 | "Neither criticality nor saturation is used" | **CONFIRMED for hypotheses on $W$; MISLEADING for the $\theta$ step**, which routes through a criticality-scoped formula |
| C9 | The ratio hypothesis and tracelessness are one equation | **CONFIRMED**, conditional on C2 and C3, the equivalence needs the multiplicities |
| C10 | "Conjugate so that $E_{\max}=\mathfrak h$ exactly", and conjugating back | **CONFIRMED**, every object in sight is $SO(n)$-equivariant |
| C11 | Odd $n$: the hypothesis is unsatisfiable | **CONFIRMED, but the reason given is the secondary one**, $\tfrac n2\notin\mathbb Z$ kills it before $\tfrac{n^2}4$ does |
| C12 | "at $n=4$ the conclusion would be false" | **REFUTED**, the lemma holds verbatim at $n=4$ and its proof needs no change; what fails at $n=4$ is $\theta_0$'s *maximality*, a different statement |
| C13 | $W_{\mathbb{CP}^2}$ has a $3$-dimensional kernel and so three eigenvalues | **CONFIRMED**, spectrum $\{4^{(1)},0^{(3)},(-2)^{(2)}\}$; but $\dim E_{\max}=1\ne2=r$ is the sharper and unnamed failure |
| C14 | $n=6$, the smallest even case in scope | **CONFIRMED**, nothing degenerates; $\theta^2=\tfrac{10}9$ |
| C15 | *(unstated in the block)* first Bianchi is consumed nowhere in the identification | **NEW FINDING**, the operator is pinned by linear algebra alone |

**Actionable summary.** The lemma is true and its identification step is complete; replace the one-line appeal to the Casimir closed form with the three-line direct evaluation in §5 (the formula is demonstrably not a family identity) and delete or rewrite the $n=4$ remark, which asserts the falsity of a conclusion that in fact holds at $n=4$.

## 0. Conventions, fixed once

The record carries a live factor-of-two hazard between the $\Lambda^2$ and $n\times n$ pairings, so I fix a convention, verify it against $\theta_0$, and use it throughout.

A curvature tensor $R_{ijkl}$ acts on $\Lambda^2\mathbb R^n$ by $(R\omega)_{ij}=\tfrac12R_{ijkl}\omega_{kl}$. In the orthonormal basis $\{e_{ij}\}_{i<j}$ the operator matrix is $M_{(ij),(kl)}=R_{ijkl}$, so $\operatorname{tr}_{\Lambda^2}R=\sum_{i<j}R_{ijij}$ and $\langle X,Y\rangle=\operatorname{tr}_{\Lambda^2}(XY)$, $\lVert W\rVert^2=\operatorname{tr}(W^2)$. The sharp is

$$R^{\#}_{ijkl}=\sum_{p,q}\bigl(R_{ipkq}R_{jplq}-R_{iplq}R_{jpkq}\bigr),\qquad (R\# S)=\tfrac12\text{-polarisation of the above.}$$

Two facts pin this convention rather than leave it a choice. First, it returns $\mathrm{Id}^{\#}=(n-2)\mathrm{Id}$, which is the classical normalisation. Second (and this is the decisive one), under it §5 returns $\theta(\hat A)^2=\theta_0(n)^2$ *identically in $n$*, and no rescaling $\#\mapsto c\,\#$ with $c\ne1$ can do that: §5 shows $\theta^2$ would become $\tfrac{(1+cm(2m-3))^2}{(2m-1)m^2(m-1)}$, which agrees with $\theta_0^2$ at every $m$ only at $c=1$. So the brief's $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$ itself certifies the convention.

Throughout, $n=2m$, $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $\Pi=\Pi_{\mathfrak h}$, $A=\Pi-\tfrac rN\mathrm{Id}$, $t=r/N$, $a=r$, $b=N-r$, and $\hat A=A/\lVert A\rVert$.

**Screen 1** (exact, `Fraction`): $\mathrm{Id}^{\#}=(n-2)\mathrm{Id}$ verified entry by entry at $n=4,5,6$.

## Hypothesis inventory

**Hypotheses of the statement, and where each is spent.**

| Hypothesis | Where it is consumed |
|---|---|
| $W$ symmetric on $\Lambda^2$ | §3, spectral theorem: the two eigenspaces are orthogonal and span |
| Ricci-flat | §1 only, and only through $\operatorname{tr}_{\Lambda^2}W=0$ |
| first Bianchi | **nowhere**, see §6 |
| exactly two eigenvalues | §3, and §4 to write $W$ on the two-dimensional plane |
| $\lambda_{\max}>0>\lambda_{\min}$ | §4 for the sign, and it is **derivable**, not independent: traceless and $\lVert W\rVert=1$ already force the extremes to straddle $0$ |
| $E_{\max}$ $SO(n)$-conjugate to $\mathfrak h$ | §7 to normalise, §2 for the multiplicities $r$, $N-r$, §5 for the value of $\theta$ |
| $\lVert W\rVert=1$ | §4, fixing the scale |
| $n$ even | §2, so that $\mathfrak{so}(n/2)$ exists |

**Imported facts, checked against the object.**

- **I1.** $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ is a subalgebra of $\mathfrak{so}(2m)$ of dimension $2\binom m2=m(m-1)=\tfrac{n(n-2)}4$. **Verified**, §2. It is the block-diagonal subalgebra of $\Lambda^2V_1\oplus\Lambda^2V_2\subset\Lambda^2(V_1\oplus V_2)$.
- **I2.** The Casimir member at $\mathfrak h$ is the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$. Taken as a **definition**; the brief does not fix the sign, and the proof reads "the unit *positive* multiple". **Verified consistent**, §4, and §4 shows the sign is forced independently of the reading.
- **I3.** That operator is the Weyl tensor of $S^{n/2}\times S^{n/2}$. **Verified independently**, §5, from the Einstein reduction; the trace-correction constant lands on $\tfrac rN$ exactly.
- **I4.** $\theta=\tfrac2n\sqrt{\tfrac{rN}{N-r}}$ for the Casimir member "when it is critical". **Used, and its scope is the block's one real weakness**, §5 exhibits the formula's failure off the balanced member in closed form.
- **I5.** The isotropy of $S^{n/2}\times S^{n/2}$ is that $\mathfrak h$ at that dimension. **Verified.** As a symmetric space $S^m\times S^m=\bigl(SO(m+1)/SO(m)\bigr)^2$, so the isotropy algebra is $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ acting on $T_p=\mathbb R^m\oplus\mathbb R^m$, of dimension $m(m-1)=r$. It coincides with the holonomy algebra and with $\operatorname{im}W=E_{\max}$, which is why the hypothesis on $E_{\max}$ is the natural one. At $m=3$: $\dim=6=r$.

## 1. Ricci-flatness and the trace on $\Lambda^2$ (attack 1)

**The derivation.** $\operatorname{Ric}(W)_{ik}=\sum_jW_{ijkj}$ and $s=\sum_i\operatorname{Ric}(W)_{ii}=\sum_{i,j}W_{ijij}=2\sum_{i<j}W_{ijij}=2\operatorname{tr}_{\Lambda^2}W$. Ricci-flat therefore gives $s=0$ and $\operatorname{tr}_{\Lambda^2}W=0$. No Bianchi identity enters: the chain is the definition of the Ricci trace and the antisymmetry $W_{ijij}=W_{jiji}$.

**The normalisation.** The identity as displayed reads $\operatorname{tr}_{\Lambda^2}W=\tfrac12 s$ in the $\tfrac12$-at-$\Lambda^2$ convention of §0. Under the competing convention $(R\omega)_{ij}=R_{ijkl}\omega_{kl}$ the operator, its trace and $s$ all scale by $2$ together. **The factor-of-two hazard is inert here**, because the claim is that a trace *vanishes*, and vanishing is scale-invariant. The hazard is live for $\lVert W\rVert$ and for $\#$, which is why §0 pins the convention against $\theta_0$ rather than by assertion.

**Implication, not equivalence.** $\operatorname{tr}_{\Lambda^2}W=0$ says $s=0$, which is scalar-flatness, strictly weaker than $\operatorname{Ric}=0$ as soon as $n\ge3$. The gap is not hypothetical: take $\mathfrak h=\mathfrak{so}(n-1)$ and $A=\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $r=\binom{n-1}2$. Then $\operatorname{tr}_{\Lambda^2}A=0$ by construction, while $\operatorname{Ric}(A)=(n-2)P-\tfrac{r(n-1)}{N}\delta$ with $P$ the rank-$(n-1)$ projection, which is nonzero because $P$ is not a multiple of $\delta$. At $n=4$: $\operatorname{Ric}(A)=2P-\tfrac32\delta\ne0$.

**Does the argument still close? Yes, and cleanly.** The proof consumes only the forward implication, it needs $\operatorname{tr}_{\Lambda^2}W=0$ as a *consequence* of a hypothesis, never as a characterisation of one. The block's own sentence, "so it and tracelessness are the same equation read in two directions", is about the ratio hypothesis versus tracelessness, not about Ricci-flatness versus tracelessness; read that way it is correct (§6). Read the other way it would be false, and a reader could take it that way, which is worth a word in the block.

## 2. The dimension count (attack 2)

$\dim\mathfrak{so}(m)=\binom m2=\tfrac{m(m-1)}2$, so with $m=\tfrac n2$,

$$r=2\cdot\frac{\tfrac n2\bigl(\tfrac n2-1\bigr)}2=\frac n2\Bigl(\frac n2-1\Bigr)=\frac{n(n-2)}4.\qquad\checkmark$$

$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{2n(n-1)-n(n-2)}4=\frac{n\bigl(2n-2-n+2\bigr)}4=\frac{n^2}4.\qquad\checkmark$$

$$\frac r{N-r}=\frac{n(n-2)/4}{n^2/4}=\frac{n-2}n.\qquad\checkmark$$

**Independent corroboration.** $\Lambda^2(V_1\oplus V_2)=\Lambda^2V_1\oplus\Lambda^2V_2\oplus(V_1\otimes V_2)$, so $\mathfrak h^\perp=V_1\otimes V_2$ has dimension $\bigl(\tfrac n2\bigr)^2=\tfrac{n^2}4$, matching $N-r$ on the nose. All three values verified at $n=4,6,8$ in Screen 2 below as a by-product.

Note the equivalence $\tfrac{\lvert\lambda_{\min}\rvert}{\lambda_{\max}}=\tfrac{n-2}n\iff(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert$ needs $\lambda_{\max}>0$ to clear the denominator, which the hypothesis supplies.

## 3. Two eigenvalues, the complement, and the kernel (attack 3)

$W$ is symmetric, so $\Lambda^2\mathbb R^n$ decomposes orthogonally into its eigenspaces. "Exactly two eigenvalues" means the spectrum is the two-element set $\{\lambda_{\max},\lambda_{\min}\}$, so the decomposition is $E_{\max}\oplus E_{\min}$ and $E_{\min}=E_{\max}^\perp$ exactly. **A kernel is excluded twice over**: $0$ would be a third eigenvalue, contradicting "exactly", and independently $\lambda_{\max}>0>\lambda_{\min}$ places both eigenvalues off zero, so no eigenvalue is $0$ and $W$ is invertible.

**The reading matters and the words are the right ones.** Read loosely ("$W$ has two eigenvalues", meaning at least these two), a kernel would be admissible, $\Lambda^2$ would split into three summands, and everything downstream would fail: the traceless equation would read $\lambda_{\max}r+\lambda_{\min}\dim E_{\min}=0$ with $\dim E_{\min}<N-r$ unknown, the ratio would be undetermined, and $W$ would not lie on the line $\mathbb R\,A$. **This record's recurring obstruction is therefore excluded, and it is excluded by the word "exactly" rather than by anything proved.** That is the correct place to put the weight, and the block puts it there. I flag only that the load on the single word is total: an editorial paraphrase to "two eigenvalues" would silently break the lemma.

The concrete shape of the failure is on file in this very block: $W_{\mathbb{CP}^2}$, spectrum $\{4^{(1)},0^{(3)},(-2)^{(2)}\}$ at $n=4$, see §9.

## 4. The identification and the sign (attack 4)

With $\Pi:=\Pi_{E_{\max}}=\Pi_{\mathfrak h}$ after §7's normalisation,

$$W=\lambda_{\max}\Pi+\lambda_{\min}(\mathrm{Id}-\Pi),\qquad \operatorname{tr}W=\lambda_{\max}r+\lambda_{\min}(N-r)=0\ \Longrightarrow\ \lambda_{\min}=-\lambda_{\max}\frac r{N-r},$$

so

$$W=\lambda_{\max}\Bigl[\Pi-\frac r{N-r}(\mathrm{Id}-\Pi)\Bigr]=\lambda_{\max}\Bigl[\frac{N}{N-r}\Pi-\frac r{N-r}\mathrm{Id}\Bigr]=\frac{\lambda_{\max}N}{N-r}\,A .$$

Since $\lambda_{\max}>0$ and $N>r$, the coefficient is **positive**, and $\lVert W\rVert=1$ then gives $W=\hat A$, uniquely. Two unit positive multiples of one nonzero operator do coincide.

**Is the Casimir member the positive multiple, and is its $E_{\max}$ really $\mathfrak h$?** $A$ has eigenvalue $1-\tfrac rN=\tfrac{N-r}N>0$ on $\mathfrak h$ and $-\tfrac rN<0$ on $\mathfrak h^\perp$, so $E_{\max}(A)=\mathfrak h$ and $E_{\max}(-A)=\mathfrak h^\perp$. And

$$\lVert A\rVert^2=r\Bigl(\frac{N-r}N\Bigr)^2+(N-r)\Bigl(\frac rN\Bigr)^2=\frac{r(N-r)}{N^2}\bigl[(N-r)+r\bigr]=\frac{r(N-r)}N=\frac{ab}N .$$

**The sign under the two choices.** $P$ is cubic-homogeneous ($W^{\#}$ is quadratic in $W$, so $P(cW)=c^3P(W)$ while $\lVert cW\rVert^3=\lvert c\rvert^3$), hence $\theta(-\hat A)=-\theta(\hat A)=-\theta_0(n)$. The positive choice is therefore not cosmetic: the negative one flips the sign of the conclusion.

**The block's sign argument is sound, and it is over-determined.** Even if one refused the sign of $\lambda_{\max}$, the hypothesis $E_{\max}\cong\mathfrak h$ already excludes $-\hat A$, because $\dim E_{\max}(-\hat A)=N-r=\tfrac{n^2}4\ne\tfrac{n(n-2)}4=r$ at every $n$. Two independent hypotheses each pin the sign; the block names one.

## 5. The $\theta$ evaluation, the sharpest question (attack 5)

**The block's route.** It cites the family closed form $\theta=\tfrac2n\sqrt{rN/(N-r)}$, whose statement on the record is qualified *when it is critical*, while asserting on the same page that criticality is not used. This is the one place criticality could enter, so the question is whether the citation is legitimate.

**First, the arithmetic of the citation is right.** With $r=\tfrac{n(n-2)}4$, $N=\tfrac{n(n-1)}2$, $N-r=\tfrac{n^2}4$,

$$\frac{rN}{N-r}=\frac{n(n-2)}4\cdot\frac{n(n-1)}2\cdot\frac4{n^2}=\frac{(n-1)(n-2)}2,\qquad \theta^2=\frac4{n^2}\cdot\frac{(n-1)(n-2)}2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .\ \checkmark$$

**Second, the formula is not a family identity, it is false off the balanced member.** Take $\mathfrak h=\mathfrak{so}(n-1)$, so $r=\binom{n-1}2$, $N-r=n-1$, $t=\tfrac{n-2}n$. Writing $\Pi=\Pi_{\mathfrak h}$, the three sharp identities of §5.1 below give, for this $\mathfrak h$, $\Pi^{\#}=(n-3)\Pi$ and $\Pi\#\mathrm{Id}=\tfrac{n-2}2(P\owedge\delta)-\Pi$ with $P$ the rank-$(n-1)$ projection; the operator of $P\owedge\delta$ is $\omega\mapsto P\omega+\omega P$, which equals $\Pi+\mathrm{Id}$, so $\langle A,P\owedge\delta\rangle=r(1-t)$. Assembling,

$$\operatorname{tr}A^3=\frac{(n-1)(n-2)(4-n)}{n^2},\qquad \langle A,A^{\#}\rangle=\frac{(n-1)(n-2)(3n-8)}{n^2},\qquad P(A)=\frac{2(n-1)(n-2)^2}{n^2},$$

$$\lVert A\rVert^2=\frac{(n-1)(n-2)}n,\qquad \boxed{\theta^2=\frac{4(n-2)}{n(n-1)}}\quad\text{against the closed form's}\quad \frac{(n-1)(n-2)}n .$$

At $n=6$ that is $\tfrac8{15}=0.5\overline3$ against $\tfrac{10}3=3.\overline3$, a factor of $6.25$, not a convention slip.

**Screen 2** (exact): building $\Pi_{\mathfrak h}$ and $\#$ from the index formula, $\theta^2$ for $\mathfrak h=\mathfrak{so}(n-1)$ comes out $\tfrac23,\tfrac35,\tfrac8{15},\tfrac{10}{21}$ at $n=4,5,6,7$, matching $\tfrac{4(n-2)}{n(n-1)}$ exactly and the closed form at none of them. Also screened: $\mathfrak u(m)\subset\mathfrak{so}(2m)$ gives $\theta^2=\tfrac3{16}$ at $m=2$ and $\tfrac{125}{162}$ at $m=3$ against $3$ and $\tfrac52$; unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ likewise disagrees.

**Third, argue the opposite, the strongest reading the words support.** The record may intend the closed form only for family members lying in $\mathcal W_n$, criticality being its selector for those. That reading survives my exhibits: $\mathfrak{so}(n-1)$ and unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ are traceless but **not Ricci-flat**, and $\mathfrak u(m)$, though Ricci-flat, **fails first Bianchi** (residual $1$, screened), so none of my witnesses is in $\mathcal W_n$. **So I do not refute the formula in its intended scope.** What the exhibits establish is narrower and still decisive for this block: the formula is not an identity in $(r,N)$ alone, it carries a genuine hypothesis, and a proof that claims to use no criticality cannot lean on it without saying which hypothesis it is discharging.

**Fourth, the repair, the value, derived cold, with no criticality.** Three exact identities in the convention of §0, each derived from the index formula:

$$\mathrm{Id}^{\#}=(n-2)\mathrm{Id},\qquad \Pi_{\mathfrak h}^{\#}=(m-2)\,\Pi_{\mathfrak h},\qquad \Pi_{\mathfrak h}\#\mathrm{Id}=(m-1)\mathrm{Id}-\Pi_{\mathfrak h}.$$

The second holds because $\Pi_{\mathfrak h}=R^{(1)}+R^{(2)}$ with $R^{(a)}_{ijkl}=P^a_{ik}P^a_{jl}-P^a_{il}P^a_{jk}$ the constant-curvature tensor of the factor; the cross term $R^{(1)}\#R^{(2)}$ vanishes because every summand carries a contracted index $p$ required to lie in both $V_1$ and $V_2$, and each diagonal term contributes $(m-2)R^{(a)}$ by the same computation that gives $\mathrm{Id}^{\#}$ one block down. The third follows from $R^{(a)}\#\mathrm{Id}=\tfrac{m-1}2(P^a\owedge\delta)-R^{(a)}$ and $P^1+P^2=\delta$ with $(\delta\owedge\delta)=2\,\mathrm{Id}$ as an operator. Sanity check: at $\mathfrak h=\mathfrak{so}(n)$ the third returns $(n-1)\mathrm{Id}-\mathrm{Id}=(n-2)\mathrm{Id}$, reproducing the first.

Now with $A=\Pi-t\,\mathrm{Id}$ and $n=2m$, so $n-2=2(m-1)$,

$$A^{\#}=\Pi^{\#}-2t\,(\Pi\#\mathrm{Id})+t^2\,\mathrm{Id}^{\#}=\bigl[(m-2)+2t\bigr]\Pi+2(m-1)t(t-1)\,\mathrm{Id},$$

and since $\operatorname{tr}A=0$ and $\operatorname{tr}(A\Pi)=r(1-t)$,

$$\langle A,A^{\#}\rangle=r(1-t)\bigl[(m-2)+2t\bigr].$$

With $a=r=m(m-1)$, $b=N-r=m^2$, $N=m(2m-1)$, $t=\tfrac{m-1}{2m-1}$, $1-t=\tfrac m{2m-1}$:

$$\operatorname{tr}A^3=a(1-t)^3-bt^3=\frac{ab(b-a)}{N^2}=\frac{m^2(m-1)}{(2m-1)^2},\qquad \langle A,A^{\#}\rangle=\frac{m^3(m-1)(2m-3)}{(2m-1)^2},$$

$$P(A)=\frac{m^2(m-1)}{(2m-1)^2}\bigl[1+m(2m-3)\bigr]=\frac{m^2(m-1)(2m-1)(m-1)}{(2m-1)^2}=\frac{m^2(m-1)^2}{2m-1}>0,$$

$$\lVert A\rVert^2=\frac{ab}N=\frac{m^2(m-1)}{2m-1},\qquad \theta^2=\frac{P(A)^2}{\lVert A\rVert^6}=\frac{m^4(m-1)^4}{(2m-1)^2}\cdot\frac{(2m-1)^3}{m^6(m-1)^3}=\frac{(m-1)(2m-1)}{m^2}.$$

With $n=2m$, $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}=\tfrac{2(2m-1)\cdot2(m-1)}{4m^2}=\tfrac{(m-1)(2m-1)}{m^2}$. **Equal**, and $P(A)>0$ gives $\theta=+\theta_0(n)$.

**Screen 3** (exact): the three sharp identities verified entry by entry, and $\theta^2(\hat A)=\tfrac34,\tfrac{10}9,\tfrac{21}{16}$ at $n=4,6,8$ against $\theta_0(n)^2=\tfrac34,\tfrac{10}9,\tfrac{21}{16}$.

**Verdict on attack 5.** The block does import a criticality-scoped formula while claiming criticality is unused, and the formula it imports is not valid on the family as the brief renders it. The conclusion $\theta=\theta_0(n)$ nevertheless stands, established above without criticality, saturation, or first Bianchi. The repair is three lines and belongs in the block.

## 6. The redundancy claims (attack 6)

**"Neither criticality nor saturation is used."** As a statement about hypotheses imposed on $W$: **correct**. Nothing in §§1–4 or §7 mentions either, and §5 above reaches $\theta_0$ without them. As a statement about the block's own route: **misleading**, because that route reaches $\theta$ through a formula whose recorded scope is critical members. The distinction worth writing into the block is that criticality of the *target* (a property of $\hat A$, not of $W$), is a fact one may invoke, whereas criticality of $W$ is a hypothesis one may not; with §5's derivation in place, neither is needed at all.

**"The ratio hypothesis is not independent of tracelessness."** **Correct, and conditional.** Given the two-eigenvalue structure with multiplicities $r$ and $N-r$, the chain $\operatorname{tr}W=0\iff\lambda_{\max}r+\lambda_{\min}(N-r)=0\iff\tfrac{\lvert\lambda_{\min}\rvert}{\lambda_{\max}}=\tfrac{n-2}n$ is a genuine two-way equivalence, so the ratio is a consequence rather than an input. The equivalence consumes the multiplicities, hence C2 and C3; it is not an equivalence between tracelessness and the ratio *as free-standing conditions*, and the block should say so in the same breath, because §1 has already shown that a nearby two-way reading (Ricci-flatness against tracelessness), is false.

**A third redundancy the block does not claim.** $\lambda_{\max}>0>\lambda_{\min}$ is derivable: $\operatorname{tr}W=0$ with $W\ne0$ forces eigenvalues of both signs. So the hypothesis list is one item longer than it needs to be.

**C15, first Bianchi is consumed nowhere.** Tracking every step: §1 uses the Ricci trace, §3 the spectral theorem, §4 linear algebra on a plane, §7 equivariance. **The conclusion "$W=\hat A$" holds for every symmetric traceless operator on $\Lambda^2\mathbb R^n$ with exactly two eigenvalues and $E_{\max}=\mathfrak h$, Bianchi or not.** Bianchi is spent only inside the membership clause $W\in\mathcal W_n$, which the lemma never has to cash. This is a strengthening the block could state and does not.

## 7. The conjugation (attack 7)

$SO(n)$ acts on $\Lambda^2\mathbb R^n$ by $\Lambda^2g$, which under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ is $\operatorname{Ad}_g$. "$E_{\max}$ is $SO(n)$-conjugate to $\mathfrak h$" means there is $g$ with $\Lambda^2g\,(E_{\max})=\mathfrak h$ as **subspaces of $\Lambda^2$**, which is what is needed, and what the statement says. Setting $W'=\Lambda^2g\,W\,(\Lambda^2g)^{-1}$:

- $E_{\max}(W')=\Lambda^2g\,(E_{\max}(W))=\mathfrak h$, and the spectrum with multiplicities is unchanged, so "exactly two eigenvalues" survives;
- $\mathcal W_n$ is $O(n)$-invariant, first Bianchi and Ricci-flatness are tensorial conditions;
- $\lVert\cdot\rVert$ is invariant, conjugation by an orthogonal map being an isometry for $\operatorname{tr}(XY)$;
- $\theta$ is invariant, since $W\mapsto W^{\#}$ is $O(n)$-equivariant (the index formula is built from contractions alone) and $P$ is a contraction of equivariant objects.

Conjugating back is then free: the conclusion "$W$ is $SO(n)$-conjugate to $W_{S^{n/2}\times S^{n/2}}$ at unit norm" is a statement about a conjugacy class, so it transports, and $\theta$ is a class function. **Sound as written.**

The one thing worth naming: the hypothesis must be conjugacy **of the subspace $E_{\max}\subset\Lambda^2$**, not abstract isomorphism of $E_{\max}$ with $\mathfrak h$ as a Lie algebra. Under the weaker reading, $E_{\max}$ could be some other $r$-dimensional subspace and §5's evaluation would collapse, $\Pi^{\#}_U$ depends on $U$, not on $\dim U$, which is precisely what §5's exhibits show. The statement uses the right words; a paraphrase could easily not.

## 8. Hypothesis inventory (attack 8)

Given in full above, before §1. Every imported fact I1, I3, I5 was re-derived rather than accepted. I2 is a definition whose sign the brief leaves open and §4 closes twice over. I4 is the block's one live debt and §5 discharges it.

**On I3, the derivation.** $S^m\times S^m$ with unit round factors has curvature operator $\Pi_{\mathfrak h}$ exactly: the operator is $\omega\mapsto P^1\omega P^1+P^2\omega P^2$, which is the orthogonal projection onto $\Lambda^2V_1\oplus\Lambda^2V_2=\mathfrak h$, and the mixed block $V_1\otimes V_2$ is flat. The metric is Einstein, $\operatorname{Ric}=(m-1)g$, $s=2m(m-1)$, so $R=W+\tfrac s{n(n-1)}\mathrm{Id}$ with

$$\kappa=\frac s{n(n-1)}=\frac{2m(m-1)}{2m(2m-1)}=\frac{m-1}{2m-1},\qquad \frac rN=\frac{m(m-1)}{m(2m-1)}=\frac{m-1}{2m-1}.$$

The two agree, so $W_{S^m\times S^m}=\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=A$ **exactly**, and the unit multiple is $\hat A$. "Balanced" is load-bearing: unequal radii break the Einstein condition and the identification with it.

## 9. The edges (attack 9)

**Odd $n$.** The claim is correct and the reason given is the secondary one. At odd $n$ the hypothesis fails already because $\tfrac n2\notin\mathbb Z$, so $\mathfrak{so}(n/2)$ does not exist, the statement's own "let $n$ be even" is the first gate. The block's reason, $\tfrac{n^2}4\notin\mathbb Z$, is separately true ($n$ odd $\Rightarrow n^2$ odd), as is $\tfrac{n(n-2)}4\notin\mathbb Z$, but both are downstream of the first. **No defect; the reason should be the primary one.**

**$n=6$, does anything degenerate?** No. $m=3$, $r=6$, $N=15$, $N-r=9$, $t=\tfrac25$. $\Pi^{\#}=(m-2)\Pi=\Pi$, nonzero. $\lVert A\rVert^2=\tfrac{18}5$, $P(A)=\tfrac{36}5$, $\theta^2=\tfrac{(3-1)(6-1)}9=\tfrac{10}9=\theta_0(6)^2$. The eigenvalues are $\tfrac{3/5}{\sqrt{18/5}}>0>\tfrac{-2/5}{\sqrt{18/5}}$, distinct and both nonzero, with ratio $\tfrac23=\tfrac{n-2}n$. $S^3\times S^3$ is a genuine Einstein $6$-manifold with nonzero Weyl tensor, and $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ is a $6$-dimensional subalgebra of $\mathfrak{so}(6)$. **The statement holds at $n=6$ with nothing degenerating.**

**$n=4$, the block's remark is wrong.** Running the proof at $m=2$: $r=2$, $N=6$, $N-r=4$, $t=\tfrac13$, $\Pi^{\#}=(m-2)\Pi=0$, and §5 gives $\theta^2=\tfrac{(2-1)(4-1)}4=\tfrac34=\theta_0(4)^2$. Every step is valid; $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ is a $2$-dimensional (maximal torus) subalgebra of $\mathfrak{so}(4)$; $W_{S^2\times S^2}$ has spectrum $\tfrac23^{(2)}$, $(-\tfrac13)^{(4)}$, exactly two eigenvalues, no kernel, ratio $\tfrac12=\tfrac{n-2}n$. **The lemma is true at $n=4$ and its proof needs no modification.** The block's "at $n=4$ the conclusion would be false" is therefore refuted as written.

What *is* true at $n=4$ is a different statement: $\theta_0(4)$ is not the maximum of $\theta$ on $\mathcal W_4$. Building $W_{\mathbb{CP}^2}$ from the Kähler curvature $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$ and subtracting its trace part, one gets an operator with spectrum $\{4^{(1)},0^{(3)},(-2)^{(2)}\}$, Ricci-flat, first Bianchi residual $0$, $\lVert W\rVert^2=24$, $P=144$, so

$$\theta(W_{\mathbb{CP}^2})^2=\frac{144^2}{24^3}=\frac{20736}{13824}=\frac32\ >\ \frac34=\theta_0(4)^2 .$$

(Screened exactly; and independently by the $\Lambda^{\pm}$ route, $\theta=18c^3$ at $c=6^{-1/2}$, giving $\theta=\sqrt{3/2}$.) **So the block has conflated the failure of $\theta_0$'s maximality at $n=4$ with the failure of this lemma's conclusion at $n=4$.** The first is real, the second is not.

**The kernel claim itself is correct, and the sharper failure is unnamed.** $W_{\mathbb{CP}^2}$ does have a $3$-dimensional kernel ($W^-=0$ on $\Lambda^-$) and so three eigenvalues, which does bar it from the hypothesis. But it is barred more decisively by $\dim E_{\max}=1$ against $r=\tfrac{n(n-2)}4=2$: even granting it two eigenvalues, its top eigenspace is not conjugate to $\mathfrak h$, because it has the wrong dimension. The block names the weaker of the two obstructions.

## 10. What would break it (attack 10)

**The falsifier, named.** A $W\in\mathcal W_n$, $n$ even, $\lVert W\rVert=1$, with exactly two eigenvalues $\lambda_{\max}>0>\lambda_{\min}$ and $E_{\max}$ $SO(n)$-conjugate to $\mathfrak h$, which is *not* $SO(n)$-conjugate to $\hat A$, or which is, but has $\theta\ne\theta_0(n)$.

**Why none exists, argued rather than searched.** §7 normalises $E_{\max}=\mathfrak h$ at no cost. §3 then makes $E_{\min}=\mathfrak h^\perp$, so $W$ lies on the two-dimensional plane $\operatorname{span}\{\Pi_{\mathfrak h},\mathrm{Id}\}$. §1 cuts that plane with one linear equation to a line, and §4 cuts the line with the norm and the sign to a single point. **There is no free parameter left to vary**, so the first form of the falsifier is impossible; and the second is impossible because $\theta$ is a function of the operator, which is now determined. In keeping with the standing analysis-only rule I ran no search for a falsifier: the argument closes the space, so a search would have nothing to look in.

**Where a falsifier could hide, if a hypothesis were weakened.** Each of the following is the exact escape the corresponding hypothesis blocks, and each is worth recording because a paraphrase of the statement could open it:

- **Drop "exactly".** A kernel makes $\dim E_{\min}<N-r$, the traceless equation no longer determines the ratio, and $W$ leaves the line. $W_{\mathbb{CP}^2}$ padded to even $n$ is the shape of the escape.
- **Weaken conjugacy to abstract isomorphism.** Then $E_{\max}$ may be any $r$-dimensional subspace $U$ with $\Pi_U-\tfrac rN\mathrm{Id}\in\mathcal W_n$, and §5 shows $\theta$ depends on $U$ and not on $r$, $\mathfrak u(m)$ and $\mathfrak{so}(n-1)$ give $\tfrac3{16}$, $\tfrac{125}{162}$, $\tfrac{4(n-2)}{n(n-1)}$ against the family formula. **The conjugacy hypothesis is load-bearing, not decorative**, and this is the cleanest evidence for it. Whether some *other* $U$, not conjugate to $\mathfrak h$, has $\Pi_U-\tfrac rN\mathrm{Id}\in\mathcal W_n$ is the natural next question; it needs a census and is therefore blocked under the standing rule, which I record rather than start.
- **Drop $\lambda_{\max}>0$.** Then $-\hat A$ qualifies and $\theta=-\theta_0(n)$, though as §4 notes, the $E_{\max}$ hypothesis independently excludes it on dimension.
- **Replace Ricci-flat by scalar-flat.** Nothing breaks: §6 shows the proof uses only the trace. The lemma is true in that greater generality, and so is C15's still stronger version with Bianchi dropped as well.

## Overall verdict

**PROVEN, hypotheses corrected.**

The statement is true, at every even $n\ge4$ including $n=4$ and $n=6$, and the identification half of the proof is complete as written. Three corrections:

1. **§5, the $\theta$ step.** Replace the appeal to the Casimir closed form (false on the family as the brief renders it, and scoped to critical members on the record), with the direct evaluation via $\mathrm{Id}^{\#}=(n-2)\mathrm{Id}$, $\Pi_{\mathfrak h}^{\#}=(\tfrac n2-2)\Pi_{\mathfrak h}$, $\Pi_{\mathfrak h}\#\mathrm{Id}=(\tfrac n2-1)\mathrm{Id}-\Pi_{\mathfrak h}$, which yields $\theta^2=\tfrac{(m-1)(2m-1)}{m^2}=\theta_0(n)^2$ with no criticality. Until that is done, the "criticality is not used" claim is true of the hypotheses and false of the route.
2. **§9, the $n=4$ remark.** The conclusion is *not* false at $n=4$; the proof runs verbatim there. Rewrite the remark to say what is actually exceptional at $n=4$ (that $\theta_0(4)=\tfrac{\sqrt3}2$ is not maximal, $W_{\mathbb{CP}^2}$ reaching $\sqrt{3/2}$) and, if $\mathbb{CP}^2$ is to be excluded by hypothesis, note that $\dim E_{\max}=1\ne2$ excludes it more directly than the kernel does.
3. **§1 and §6, the two-way readings.** State that Ricci-flatness *implies* tracelessness without converse, and that the ratio-tracelessness equivalence is conditional on the two-eigenvalue structure and the multiplicities. As written, one sentence invites the false reading of the first.

One strengthening the block should claim: **first Bianchi is consumed nowhere in the identification**, so the operator is pinned by linear algebra on symmetric traceless operators alone.
