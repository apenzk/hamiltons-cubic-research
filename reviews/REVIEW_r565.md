# REVIEW r565, Lemma L70, the deficiency identity and what saturates it

Reviewer r565, independent adversarial audit. Analysis only: no computation was run, and nothing below rests on a numerical result of mine.

Verdicts are appended as they are reached.

## Status

- Created before any mathematics.

## Overall verdict

**The mathematics of [Lemma L70](../findings/bounds.md) is CONFIRMED.** The boxed identity, the nonnegativity of $D$, and the equality case are all correct, and I rebuilt each from the definitions by a route that shares nothing with the block's presentation. **Nine defects are REPAIRED or owed around it, and one downstream citation is REFUTED with a witness derived by hand.**

| # | defect | verdict |
| --- | --- | --- |
| D1 | the boxed identity, $D\ge0$, the equality case | **CONFIRMED** |
| D2 | the direction of the excluded-index looseness | **CONFIRMED**, the bound stays valid and conservative |
| D3 | the blockquote's headline, unqualified | **REFUTED as written**, true only at $\dim E_{\min}=1$ |
| D4 | saturation forces $\dim E_{\min}\ge2$ | **owed**, a free corollary, unstated |
| D5 | the sharpening was never carried to the box | **REPAIR owed**, and the sharp form is already on the record 190 lines away |
| D6 | the argument is not in the block | **REPAIR owed**, its two ingredients sit $27$ lines above under another heading |
| D7 | [nondegeneracy.md](../findings/nondegeneracy.md) claims $W_{\mathbb{CP}^m}$ saturates L70 | **REFUTED** for every $m\ge3$, plus a link to the wrong file |
| D8 | the precedence claim at [bounds.md](../findings/bounds.md) line 180 | **stale**, withdrawn $27$ lines below, still asserted in bold above |
| D9 | four symbols the block leans on are undefined in [conventions.md](../findings/conventions.md) | **owed** |
| D10 | the quantifier | **CONFIRMED as stated**, criticality is genuinely needed; L107's understatement does not repeat |
| D11 | the Lie-theoretic reduction, and proved-versus-observed | **CONFIRMED**; the separation is a theorem presented as a measurement |
| D12 | what L70 takes from [post F40](../findings/fence-posts.md) | **unaffected** by that post's refuted closure |
| D13 | is [r323](REVIEW_r323.md)+[r324](REVIEW_r324.md) a Gate 2 on this block? | **NO**, the block's central blockquote postdates their verdicts by three hours |

**No computation was run.** Every number below is hand arithmetic on a closed form the record already carries, and each is presented as a derivation rather than as a measurement.

---

## D1, the identity, rebuilt from the definitions. CONFIRMED

Fix a critical $W$, $Q(W)=\theta W$, and a unit $v\in E_{\min}$. Extend $v$ to an orthonormal eigenbasis $\{\varphi_a\}$ of $\Lambda^2$ with $\varphi_1=v$, under the half-trace pairing of [conventions.md](../findings/conventions.md), in which $\{\varphi_{ab}\}_{a<b}$ is orthonormal.

**Step 1, criticality at $v$.** Pairing $Q(W)v=W^2v+W^\#v=\theta Wv=\theta\lambda_{\min}v$ against $v$ gives $\lambda_{\min}^2+\langle v,W^\#v\rangle=\theta\lambda_{\min}$, hence

$$\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min}).$$

This holds for **every** unit $v\in E_{\min}$, no choice being made.

**Step 2, the sharp at $v$.** With $A=\mathrm{ad}(v)$ and $A_{ab}=c_{vba}$, $\langle v,W^\#v\rangle=-\tfrac12\mathop{\mathrm{tr}}(AWAW)$ and $\mathop{\mathrm{tr}}(AWAW)=\sum_{a,b}A_{ab}\lambda_bA_{ba}\lambda_a=-\sum_{a,b}c_{vab}^2\lambda_a\lambda_b$ by antisymmetry of $A$. So

$$\langle v,W^\#v\rangle=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{vab}^2 .$$

**Step 3, the mass.** $\sum_{a,b}c_{vab}^2=\sum_a\lVert[v,\varphi_a]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}\,v)^2=2(n-2)$, from the Killing form $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ with $\mathop{\mathrm{tr}}(v^2)=-2$ at a unit bivector. **This is Lie-algebraic**: no $W$, no Weyl membership, no eigenvector property.

**Step 4.** Subtracting the constant and spending the mass, $\tfrac12\sum\lambda_a\lambda_bc_{vab}^2=D(v)+\tfrac12\cdot2(n-2)\lambda_{\min}\lambda_{\max}$, so $\lambda_{\min}\theta-\lambda_{\min}^2=D(v)+(n-2)\lambda_{\min}\lambda_{\max}$. **Dividing by $\lambda_{\min}<0$ reverses nothing here because this is an equation, but it does flip the sign of the $D$ term**, giving the boxed form

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert}. \qquad\checkmark$$

**Step 5, $D\ge0$.** $\lambda_{\min}\lambda_{\max}$ is the minimum of $\lambda_a\lambda_b$ over the spectrum whenever $\lambda_{\min}<0\le\lambda_{\max}$: like signs give a product $\ge0>\lambda_{\min}\lambda_{\max}$ when $\lambda_{\max}>0$; opposite signs give $\lambda_a\lambda_b\ge\lambda_{\min}\lambda_b\ge\lambda_{\min}\lambda_{\max}$, the first because $\lambda_b>0$ and the second because $\lambda_{\min}<0$. **The block's hypothesis is exactly right and exactly minimal**, and $\mathop{\mathrm{tr}}W=0$ with $W\ne0$ supplies it, for a Weyl tensor $\sum_jW_{ijij}=\mathrm{Ric}_{ii}=0$, so $\mathop{\mathrm{tr}}_{\Lambda^2}W=\tfrac12\sum_{i,j}W_{ijij}=0$.

**Step 6, the equality case, and where the block's "exactly" comes from.** The chain in step 5 is strict unless both inequalities are equalities, which forces $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$, **the minimiser is unique as a pair of eigenvalues**. Hence $D(v)=0$ iff every pair carrying mass has one index in $E_{\min}$ and one in $E_{\max}$, which is the block's statement. **That uniqueness is what makes the word "exactly" true, and it is argued nowhere in [bounds.md](../findings/bounds.md) or in [results.md](../results.md)**, see D6.

**Step 7, the quantifier over $v$.** At a critical point $W^\#=\theta W-W^2$ is a polynomial in $W$, so $\langle v,W^\#v\rangle=\theta\lambda_{\min}-\lambda_{\min}^2$ on the whole unit sphere of $E_{\min}$ and $D(v)=\langle v,W^\#v\rangle-(n-2)\lambda_{\min}\lambda_{\max}$ is constant there. **Two lines, no measurement.** The block supplies this in a later blockquote and supplies it with a measured spread of $3\times10^{-16}$; the proof is shorter than the measurement.

---

## D2, which direction the excluded-index looseness runs. The block is right

The brief's own question answers itself, and the block's phrasing survives it. Let $m_1=\min\{\lambda_a\lambda_b:(a,b)\in\mathop{\mathrm{supp}}c_{v\cdot\cdot}\}$. Since $m_1\ge\lambda_{\min}\lambda_{\max}$,

$$D(v)\;\ge\;\tfrac12\sum_{a,b}(m_1-\lambda_{\min}\lambda_{\max})c_{vab}^2\;=\;(n-2)\big(m_1-\lambda_{\min}\lambda_{\max}\big)\;\ge\;0 .$$

So a strictly larger true minimum makes $D$ **more** positive, the identity is untouched, and the derived inequality $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$ stays **valid and conservative**. **The looseness is slack in the bound, never a failure of the identity, and the block says so.** CONFIRMED.

The sharp member is obtained by keeping $m_1$ rather than $\lambda_{\min}\lambda_{\max}$: $\lambda_{\min}\theta-\lambda_{\min}^2\ge(n-2)m_1$, and dividing by $\lambda_{\min}<0$ **reverses the inequality**, giving

$$\theta\;\le\;\lambda_{\min}+\frac{(n-2)m_1}{\lambda_{\min}} ,$$

which reduces to the boxed bound at $m_1=\lambda_{\min}\lambda_{\max}$ and dominates it otherwise.

---

## D3, the blockquote's headline is false as written. REFUTED, and the blockquote refutes itself four sentences later

The block reads, in bold capitals:

> $\lambda_{\min}\lambda_{\max}$ is attained only on a pair *containing* the row index, which $c_{vab}$'s support excludes.

**This is true only when $\lambda_{\min}$ is simple.** The support exclusion is $\mathrm{ad}(v)v=[v,v]=0$ together with $\langle[v,x],v\rangle=0$, so $c_{vab}=0$ whenever $a=v$ or $b=v$, **it excludes the vector $v$, not the eigenvalue $\lambda_{\min}$**. If $\dim E_{\min}\ge2$ there is an index $a'\ne v$ with $\lambda_{a'}=\lambda_{\min}$, the pair $(a',b)$ with $\lambda_b=\lambda_{\max}$ is inside the support, and $m_1=\lambda_{\min}\lambda_{\max}$ **with no gap at all**.

The blockquote's own closing clause (*"The two agree whenever $\lambda_{\min}$ has multiplicity $\ge2$"*), is the correction, and it contradicts the headline it sits under. **The unqualified sentence is repeated verbatim in the canonical statement at [results.md](../results.md) line 562**, where the same correction follows it.

**Repair.** Qualify the headline: *"when $\lambda_{\min}$ is simple, $\lambda_{\min}\lambda_{\max}$ is attained only on a pair containing the row index, which $c_{vab}$'s support excludes; at multiplicity $\ge2$ the two constants coincide."* Both files.

---

## D4, saturation forces $\dim E_{\min}\ge2$. A free corollary, and it is not on the record

The brief asks whether a dimension hypothesis is needed for the equality case. **It is not needed as a hypothesis: it is a consequence.** Saturation puts all $2(n-2)>0$ units of mass on pairs with one index at $\lambda_{\min}$ and one at $\lambda_{\max}$, and no such index may be $v$ itself by D3's exclusion. So a second $\lambda_{\min}$-direction orthogonal to $v$ must exist:

$$D(v)=0\ \text{at a critical point}\ \Longrightarrow\ \dim E_{\min}\ge2 .$$

**The equality case is therefore attainable as stated**, and it silently carries this dimension conclusion. **Recording it costs one line and it is owed**, because it is the hypothesis under which D3's two constants coincide, so the block's *"which covers every saturating point on this record"* is not an observation about the catalogue at all: **it is a theorem, and stating it as coverage of a population understates it.**

**The saturation population satisfies it, necessarily.** At the balanced products $\dim E_{\min}=n^2/4=9,16,25,36$ at $n=6,8,10,12$; at $W_{\mathbb{CP}^2}$ at $n=4$, $\dim E_{\min}=2$. Both are forced by the corollary rather than checked against it.

---

## D5, the sharpening was never carried to the box, and the record now says two incompatible things about it

**Answer to the brief's question (1), part two: yes, the boxed form should be restated over the true support, and doing so is a deduplication rather than a new result, because the sharp member is already on the record.** [bounds.md](../findings/bounds.md)'s per-row family, $190$ lines below the block, states

$$\theta\le\lambda_a+\frac{(n-2)m_a}{\lambda_a}\quad(\lambda_a<0),$$

with $m_a$ the extreme product $\lambda_b\lambda_c$ over **distinct** $b,c$ both $\ne a$. **At $a=\arg\min$ that is exactly D2's sharp member.** The same effect was carried at the $\lambda_{\max}$ row today, when [Lemma L107](../findings/bounds.md)'s chord was moved onto the row's true support; **the $\lambda_{\min}$ row, where the effect was first noticed, still carries the unsharpened constant.**

**And the record asserts both readings.** Line $191$ calls the box *"the **weakened** member of the per-row family"*; lines $375$ and $383$ say the family's *"negative half **is** Lemma L70"* and that L70 **is** the pinned system read at the $\lambda_{\min}$ row. **The box is the weakened member and the sharp member cannot both be L70.** They coincide exactly when $\dim E_{\min}\ge2$, which by D4 is every saturating point, and which is why the collision has never bitten.

**A second ambiguity worth closing while the sentence is being rewritten.** *"$m_1$, the minimum over the support"* has two readings: the minimum over $\{(b,c):b,c\ne a\}$, which is **spectral and computable from $(\lambda,n)$** and is what the per-row family means; and the minimum over the actual support of $c_{vab}$, which is strictly larger, is not a function of the spectrum, and is unusable as a bound. **The first is the one that makes the sharpened statement a theorem.** The symbol $m_1$ is defined in neither place, see D9.

---

## D6, the block states its claim, and does not carry its argument

**The heading is honoured**: the block states the identity and it states what saturates it. **The argument is another matter.**

- **The two load-bearing ingredients are $27$ lines above the heading, under a different one.** [bounds.md](../findings/bounds.md) line $158$, headed *"The walk identity at the $\lambda_{\min}$ eigenvector"*, carries both $\langle v,W^\#v\rangle=\tfrac12\sum\lambda_a\lambda_bc_{1ab}^2$ and $\sum c_{1ab}^2=-\mathop{\mathrm{tr}}(\mathrm{ad}\,v)^2=2(n-2)$. **The block cites neither, and states the mass as a bare fact.**
- **Which relation supplies the mass, and does it carry a number?** It is the Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$, filed in [conventions.md](../findings/conventions.md) under *"the pair cap and the Killing marginal"* as a **standing fact with no result number**, the numbered result on that line is [Lemma L31](../findings/stratum-two-negative.md), which is the *pair cap* $\sum_\gamma T_{\alpha\beta\gamma}\le2$, a different statement. **So the answer to the brief is: no number, and the block should cite conventions.md rather than assert the value.** The record does number it in another guise: relation (A) of the row calculus, $80$ lines below the block, is the same identity.
- **The sign step is nowhere.** Passing from $\lambda_{\min}\theta-\lambda_{\min}^2=D+(n-2)\lambda_{\min}\lambda_{\max}$ to the boxed form divides by a **negative** number, which is what turns $+D$ into $-D/\lvert\lambda_{\min}\rvert$ and what reverses the derived inequality. The block's whole derivation is the phrase *"Keeping the difference instead"*. **The record has lost a cycle to a sign at least twice**, [conventions.md](../findings/conventions.md)'s $W_-$ row records four lemmas refuted in one day by one, so this is the step most worth writing down.
- **The uniqueness of the minimiser is unargued**, in [bounds.md](../findings/bounds.md) and in [results.md](../results.md) alike, though it is the whole content of the word "exactly" in the equality case (D1, step 6).

**Verdict: REPAIR owed, not a defect in the claim.** Steps 1–6 of D1 fit in a short paragraph and would make the block self-contained.

---

## D7, REFUTED: [nondegeneracy.md](../findings/nondegeneracy.md) cites L70's equality case outside its hypotheses, and links to the wrong file

[nondegeneracy.md](../findings/nondegeneracy.md) line $540$, checking its closed form for $e=W/\theta$ at $W_{\mathbb{CP}^m}$, reads: *"It is traceless exactly, satisfies $\lVert e\rVert^2=1/\theta^2$ exactly … and **saturates [Lemma L70](../findings/second-order.md) exactly**."* **The block is about $m\ge3$ throughout, and the claim is false at every one of those $m$.**

**Derived from that file's own closed form, by a route sharing nothing with the block's or with [r324](REVIEW_r324.md)'s.** The file gives

$$e=-\frac{1}{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega,$$

with $\dim\mathfrak m=m(m-1)$, $\dim\mathfrak{su}(m)=m^2-1$, $\dim\omega=1$, summing to $2m^2-m=\binom{2m}2$. For $m\ge3$ the middle coefficient is positive, so $\lambda_{\min}=-\theta/(2m-1)$ on $\mathfrak m$ and $\lambda_{\max}=2(m-1)\theta/(2m-1)$ on $\omega$, giving

$$\frac{\lambda_{\max}}{\lvert\lambda_{\min}\rvert}=2(m-1).$$

**Saturation forces $\lambda_{\max}/\lvert\lambda_{\min}\rvert=n/(n-2)=m/(m-1)$**, by row $v$ of relation (B): all the mass sits on pairs $\{\lambda_{\min},\lambda_{\max}\}$, split evenly by the symmetry of $c_{vab}^2$, so its first moment is $(n-2)(\lambda_{\min}+\lambda_{\max})$, and (B) sets that equal to $-2\lambda_{\min}$. Equating the two ratios gives $2(m-1)^2=m$, i.e. $2m^2-5m+2=0$, whose roots are $m=2$ and $m=\tfrac12$. **So $W_{\mathbb{CP}^m}$ saturates Lemma L70 at $m=2$ alone.**

**The slack has a closed form**, and it is not small:

$$\lambda_{\min}+(n-2)\lambda_{\max}-\theta=\theta\cdot\frac{4m^2-10m+4}{2m-1}=\boxed{\,2(m-2)\,\theta\,}$$

using $2(2m-1)(m-2)=4m^2-10m+4$. With the record's $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ from [algebra.md](../findings/algebra.md): **$2.108185$ at $m=3$, $3.944053$ at $m=4$, $5.692100$ at $m=5$**, and $0$ at $m=2$. *These reproduce [r324](REVIEW_r324.md)'s independently measured slacks digit for digit, and [bounds.md](../findings/bounds.md)'s own $\mathbb{CP}^3$ figure of $3.162$ against $\theta_0(6)=1.054$; my route used only the two closed forms already on the record and the (B)-row criterion.*

**Two repairs.**

1. **The claim is false for $m\ge3$ and must go.** If it was meant as *"satisfies the identity exactly"* it is a category error (an identity is satisfied, never saturated) and it is then also vacuous as a check on the closed form, since the identity holds at every critical point. **What the closed form does check, and what the sentence should say, is $2(m-2)\theta$: the slack is a clean function of $m$, vanishing at $m=2$.**
2. **The link points to [second-order.md](../findings/second-order.md), where L70 does not appear**, grep returns nothing. L70 lives in [bounds.md](../findings/bounds.md).

*This is the citation the brief asked for: the most-cited result on the record without a verdict, cited once outside its equality case.* Every other consumer I checked, [Lemma L71](../findings/bounds.md), the per-row family, [routes.md](../routes.md)'s R14 closure, [diagonal-half.md](../findings/diagonal-half.md)'s strongly-regular-graph line, [fence-posts.md](../findings/fence-posts.md) line $368$, uses the scalar saturation condition or the identity, and stays inside the hypotheses.

---

## D8, the precedence claim is withdrawn $27$ lines below where it is still asserted

[bounds.md](../findings/bounds.md) line $180$, in the paragraph the block builds on, reads in bold: *"**This is the first recorded quantity tight at the balanced products and slack at the unbalanced ones**."* Line $207$, inside the block, reads: *"It was called the **first** such quantity here; [Reviewer 326](REVIEW_r326.md)'s repaired marginal LP separates them too, and exactly, **so the precedence claim is dropped**."*

**The withdrawal did not reach the sentence it withdraws.** This is the shape the file already documents at line $35$, [L142](../findings/bounds.md)'s framing error *"repeated eighteen lines below its own withdrawal notice"*, repeated here at $27$ lines above one. **Delete the claim at line 180.**

---

## D9, four symbols the block leans on have no definition in [conventions.md](../findings/conventions.md), and one letter collides

The brief predicted at least one; there are four, plus a collision and a miscount.

| symbol | status |
| --- | --- |
| $E_{\min}$, $E_{\max}$ | **undefined.** Neither appears in [conventions.md](../findings/conventions.md). They carry the equality case, [Lemma L71](../findings/bounds.md), and the whole saturation apparatus |
| $c_{vab}$ | **undefined at a vector.** Conventions defines $c_{abc}=\langle[v_a,v_b],v_c\rangle$ at **basis indices**; the block's $v$ is an arbitrary unit of $E_{\min}$. The extension is by linearity in the first slot and is legitimate, but the total antisymmetry the record leans on has to be read across that extension, and it is nowhere stated that it survives |
| $m_1$ | **undefined anywhere on the record.** Introduced in the block's blockquote as *"the minimum over the support"*, with the ambiguity of D5 unresolved |
| $D(v)$ | defined in the block itself, which is correct, but it is **cited from four other files** and belongs in conventions.md by that file's own rule |

**And $m_a$ carries two incompatible meanings.** [bounds.md](../findings/bounds.md) line $375$ uses $m_a$ for the **extreme product** $\lambda_b\lambda_c$ over $b,c\ne a$; [fence-posts.md](../findings/fence-posts.md) line $368$ uses $m_a=\lVert[v,\varphi_a]\rVert^2$ for the **row mass**. *The same paragraph at line 375 also writes $m=\lvert\lambda_{\min}\rvert$, so the letter carries three objects within one display.* This is the class [conventions.md](../findings/conventions.md) already tables for $B$, $M$, $\Pi$ and $\mu$, and it belongs in the same table.

**One miscount in conventions.md itself, live.** The $\Pi$ row opens *"the letter carries **three** unrelated objects"* and then lists **four**, (i)–(iv), and [fence-posts.md](../findings/fence-posts.md)'s refutation notice and [Lemma L107](../findings/bounds.md)'s heading note both say four. **The word should be "four".**

---

## D10, the quantifier. CONFIRMED as stated; L107's understatement does not repeat here

The brief asks whether the identity needs criticality or holds on $\mathcal W_n$, today's [L107](../findings/bounds.md) audit having found exactly that understatement one screen away. **It does not repeat, and the reason is structural.**

- **L107 had a criticality-free route**: $g_k\ge0$ manifestly at every $W$, with the two aggregates $\sum g_k=4(n-1)\lVert W\rVert^2$ and $\sum\lambda_kg_k=-4P(W)$ following from (A) and (B) alone. So its bound was provable on all of $\mathcal W_n$ and was filed as a critical-point statement.
- **L70's boxed form has no such route.** It relates $\theta$ to **row $\arg\min$** of the bracket tensor, and the only relation on the record tying a single row's second moment to $\theta$ is (C), which *is* the diagonal of $W^\#=\theta W-W^2$, criticality itself. [LEDGER.md](../findings/LEDGER.md) line $413$ already states this reconciliation. **Criticality is genuinely needed, and the block's quantifier is right.**
- **What is understated is the criticality-free core.** $\langle v,W^\#v\rangle=D(v)+(n-2)\lambda_{\min}\lambda_{\max}$ holds at **every** symmetric $W$ on $\Lambda^2$ and every unit $v$, with no Weyl membership, no criticality and no eigenvector property, steps 2 and 3 of D1 use neither. The block's *"What the identity does **not** need"* list gives unit norm, Weyl membership, $\theta>0$ and $n\ge5$, and **stops one item short of the one that is worth having**: the split between the algebraic core and the criticality-dependent box. Both [r323](REVIEW_r323.md) and [r324](REVIEW_r324.md) reached it; the block absorbed the list and not the split.

**The norm checks out.** Under [conventions.md](../findings/conventions.md)'s half-trace pairing at the $\Lambda^2$ level (the one making $\{\varphi_{ab}\}_{a<b}$ orthonormal), $\mathop{\mathrm{tr}}(v^2)=-2$ at a unit bivector gives the Killing value $2(n-2)$ used in step 3, and the block's $\tfrac12\sum_{a,b}$ against ordered pairs reproduces the coefficient $(n-2)\lambda_{\min}\lambda_{\max}$ that the boxed $(n-2)\lambda_{\max}$ term needs. **The block is internally consistent with the record's norm, and would be off by a factor $2$ under plain Frobenius.**

---

## D11, the Lie-theoretic reduction, and what in this block is proved

**The reduction is CONFIRMED and "no computation" is accurate.** On [Lemma L23](../results.md)'s family $W=\Pi_{\mathfrak h}-\tfrac rNI$ has eigenvalues $1-\tfrac rN$ on $\mathfrak h$ and $-\tfrac rN$ on $\mathfrak m=\mathfrak h^\perp$, so $E_{\max}=\mathfrak h$ and $E_{\min}=\mathfrak m$ as claimed. For $v\in\mathfrak m$ the three blocks of $\mathrm{ad}(v)$'s mass are:

- $\mathfrak h\times\mathfrak h$: $\sum_{a,b\in\mathfrak h}\langle v,[\varphi_a,\varphi_b]\rangle^2$, using total antisymmetry of $\langle[x,y],z\rangle$. **Zero automatically**, since $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\perp\mathfrak m\ni v$. The block's word is right.
- $\mathfrak h\times\mathfrak m$: the permitted block.
- $\mathfrak m\times\mathfrak m$: zero iff $v\perp[\mathfrak m,\mathfrak m]$.

So saturation at every $v\in\mathfrak m$ is $[\mathfrak m,\mathfrak m]\perp\mathfrak m$, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$; with $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ and $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ (the last free, from $\langle[h,x],h'\rangle=-\langle x,[h,h']\rangle=0$) that is a symmetric pair. **CONFIRMED.**

**The quantifier inside the reduction is the one place it could have failed, and it does not.** $D(v)=0$ at a single $v$ gives only $v\perp[\mathfrak m,\mathfrak m]$; the step to $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ needs saturation at every $v\in\mathfrak m$, which D1 step 7 supplies for free. **The block states the reduction without the constancy and supplies the constancy $40$ lines later in a blockquote about something else.** [r323](REVIEW_r323.md) flagged exactly this and asked that it be cited rather than assumed; **it still is not.**

**Proved against observed, per the brief's item (3).** The labels split cleanly:

| statement | status |
| --- | --- |
| the boxed identity; $D\ge0$; the equality case; the "for every $v$" clause | **proved**, and re-derived here |
| the reduction to $(\mathfrak{so}(n),\mathfrak h)$ symmetric on L23's family | **proved** |
| the table's criticality residuals, slacks and mass counts at $n=6,8,10,12$ | **Observations at the dimensions run**, measurements, correctly labelled as such by the brief |
| the torus fraction $\tfrac{m-2}{m-1}$ | stated as a closed form, **derived nowhere** |
| *"the slack growing in $n$"* | an extrapolation from four points |
| *"it separates the balanced sphere products from the rest of the subalgebra family"* | **a theorem, presented as a measurement** |

**No downgrade is owed, and one upgrade is.** The separation follows from the equality case through [Lemma L71](../findings/bounds.md) (saturation forces the balanced sphere product for $n\ge5$), with no circularity, since L71 consumes L70 and not the table. **The table corroborates a theorem the block already has.** The two rows that are genuinely only measured are the torus fraction and the growth in $n$; if either is to be cited, it owes a derivation, and the fraction looks derivable from $[\mathfrak t,\mathfrak t]=0$ and root multiplicities.

---

## D12, what L70 takes from [post F40](../findings/fence-posts.md), and whether the refutation touches it

**It takes a population and a framing, and neither is affected.** Post F40's refuted claim is its **closure of [Lemma L107](../findings/bounds.md)**, which transferred [post F28](../findings/INDEX-traps.md)'s equality case between two incompatible quantities both written $\Pi$. **L70 takes neither the transfer nor the equality case**: it takes correction (i)'s list of points (maximal tori, the $\mathfrak{su}(3)$ bi-invariant, $(S^4)^3$, $(S^3)^4$) as the population its own separation is tested against. **That population survives its post's refutation intact.**

**One loose attribution.** The block says correction (i) refuted *"saturated exactly at the balanced sphere products"* **for the $\lambda$-weighted bound**; correction (i) is stated about the $\dim E_+$ form $\theta\le\tfrac2n\sqrt{rN/(N-r)}$. [r319](REVIEW_r319.md) is what licenses the transfer, the $\dim E_+$ bound is identically $(n-1)\sqrt{r/(N(N-r))}$, whose radical is $\lvert\lambda_{\min}\rvert$ **for a two-eigenvalue operator**. Every member of the subalgebra family has exactly two eigenvalues, so **the transfer is sound on the population in question and unsound in general.** Worth one clause; not a defect in L70.

---

## D13, is [r323](REVIEW_r323.md) + [r324](REVIEW_r324.md) a Gate 2 on this block as it now stands? **No**

**What that pair settled, and it is substantial.** Their brief-local L1, L2 and L5 map onto this block and its successor, and the block visibly absorbed their repairs: the $\mathop{\mathrm{tr}}W=0$ hypothesis on the nonnegativity clause (the block records it as *"missing when this was first written"*, which is [r323](REVIEW_r323.md)'s recommendation verbatim); the withdrawal of the "control" sentence in the Hilbert–Schmidt section, credited to [Reviewer 324](REVIEW_r324.md); the *"carries no new information"* blockquote, credited to both; the eigenspace-constancy blockquote; the *"not Weyl tensors at all"* scoping correction; and the elimination $D=\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$, which reached [bounds.md](../findings/bounds.md) at line $443$ and [routes.md](../routes.md)'s R14 row. **On the identity, the nonnegativity, the equality case, the "for every $v$" clause and the Hilbert–Schmidt twin, that round is a genuine two-reviewer confirmation and my own derivation agrees with it in every particular.**

**What it did not settle.**

1. **The block's central blockquote did not exist when they reviewed it.** [r323](REVIEW_r323.md) and [r324](REVIEW_r324.md) landed at 20:38 and 20:42 on 2026-09-01; the excluded-index blockquote was written at 23:46 the same evening, by commit 0ceac92f, *"propagate the excluded-index effect to Lemma 70's identity and equality case"*. **Neither reviewer saw the paragraph that now carries the block's sharpest claim**, and D3 finds its headline false as written.
2. **Their verdicts are keyed to brief-local labels L1–L5**, none of which name this block, and their L3 verdict (CONFIRMED on the family, **REFUTED in generalisation**), is a verdict on [plan.md](../plan.md)'s T4 and on [Lemma L71](../findings/bounds.md), not on L70. **Reading their table as a verdict on L70 imports a refutation that belongs to a different statement.**
3. **[INDEX-results.md](../findings/INDEX-results.md) row 70 records no verdict at all**, where row 107 carries its Gate 2 in full. The row should carry one after this round.
4. **Both recommended repairs that are still outstanding**: [r323](REVIEW_r323.md)'s *"the subalgebra-family reduction quietly needs the constancy, it should be cited rather than assumed"* (D11), and both reviewers' split between the criticality-free core and the criticality-dependent box (D10).

**So: their round is a Gate 2 on the statement, and not on the block.** The statement they confirmed is the statement I confirm, independently, in D1. What stands unreviewed is the paragraph added after they finished, the index row that records nothing, the two repairs they asked for and did not get, and (outside the block entirely), the false citation of D7, which no reviewer of this lemma has looked at.

---

## Summary of repairs owed

1. **Qualify the blockquote's headline** in [bounds.md](../findings/bounds.md) and in [results.md](../results.md) line $562$, the exclusion is of the vector $v$, not of the eigenvalue $\lambda_{\min}$, and the gap exists only at $\dim E_{\min}=1$ (D3).
2. **Record the corollary** $D(v)=0\Rightarrow\dim E_{\min}\ge2$, and restate *"covers every saturating point on this record"* as the theorem it is (D4).
3. **Carry the sharpening into the box**, or state plainly that the sharp member is the per-row family's negative row and stop calling both L70 (D5).
4. **Put the six-step derivation in the block**, with the sign step written down, the mass cited to [conventions.md](../findings/conventions.md) as a standing fact with no number, and the uniqueness of the minimiser argued (D6).
5. **Fix [nondegeneracy.md](../findings/nondegeneracy.md) line 540**, the claim is false for every $m\ge3$, the slack is $2(m-2)\theta$, and the link points at the wrong file (D7).
6. **Delete the withdrawn precedence claim** at [bounds.md](../findings/bounds.md) line $180$ (D8).
7. **Add $E_{\min}$, $E_{\max}$, $c_{vab}$ at a vector, and the $m_a$ collision to [conventions.md](../findings/conventions.md)**, define $m_1$ or drop it, and correct that file's $\Pi$ row from "three" to "four" (D9).
8. **State the criticality-free core** alongside the "what it does not need" list (D10), and **cite the constancy** where the family reduction uses it (D11).
9. **Give [INDEX-results.md](../findings/INDEX-results.md) row 70 a verdict** (D13).

*No computation was run for this review. The three $\mathbb{CP}^m$ slacks in D7 are hand evaluations of a derived closed form against two closed forms already on the record, offered as a derivation; that they agree with [r324](REVIEW_r324.md)'s independent measurements is corroboration and not the evidence.*
