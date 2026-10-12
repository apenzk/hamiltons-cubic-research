# Review r601, Lemma L45, off the slice: five surviving triples and one new coupling

**Reviewer A of a concurrent independent pair on identical briefs. Review number 601.**

**Analysis only.** No computation was run, and none was needed: every step below is finite algebra over an orthogonal three-summand decomposition, and every constant is confirmed against the stored full text of the cited source.

## Verdict: **GAP**

**Every mathematical assertion in the block is true**, and I rebuilt all of it cold from [Xu's](https://arxiv.org/abs/2412.13633) Proposition 2.7 and Lemma 2.6 without using the block's own reasoning. The gap is in the block's *apparatus*, and it is in four places:

| # | what is owed | reachable? |
| --- | --- | --- |
| 1 | The provenance note is **false on both counts**, wrong file and wrong section. The argument is in [findings/problem.md](../findings/problem.md), not [findings/target.md](../findings/target.md). | Yes, one-line fix |
| 2 | Two of the five vanishing triples ($(I,I,Y)$ and $(Y,W,W)$), are covered by neither "every $I$–$W$ pairing" nor anything else the block names. | Yes, supplied in §2 below |
| 3 | The copy in [target.md](../findings/target.md) **drops the scoping sentence** that the source passage carries, so the block reads as a bound when it is a restatement of an obligation. | Yes, the sentence exists at [results.md:286](../results.md#L286) and [problem.md:92](../findings/problem.md#L92) |
| 4 | $\mathrm{Ric}_0$ against the block's own $R_{\mathrm{ric}_0}$, a **live factor-2 convention hazard** that this record has already flagged in the same file, and neither symbol is in [conventions.md](../findings/conventions.md). | Yes, name the source's normalisation |

Nothing here refutes the Lemma. Fix the four and it is CONFIRMED.

---

## 1. The pointer, **FALSE, and demonstrably so from `git log` alone**

The note at [target.md:696](../findings/target.md#L696) reads:

> *the result was numbered in [report/](../report/) and the mathematics has always been in this file … **the argument is in this file under "What fence post F29 closes, and what it leaves open"***

Both halves fail.

**The named section holds nothing of the sort.** [target.md:68–72](../findings/target.md#L68) is four lines on whether $\lambda\le\mu_{\max}(K)$ can bound $\theta$ in a fixed frame, the upgrade to $K^2-\lambda K\succeq0$ on the diagonal locus, and a remark about top versus bottom eigenvectors. It contains no $R=cI+Y+W$, no $\Phi$, no $\Omega_0$, no triple, no reflection. It is not a near-miss; it shares no object with the Lemma.

**"Has always been in this file" is false too**, and the history is unambiguous. `git log -S'W\text{-even}'` returns exactly three commits across the whole repository:

| commit | date | file |
| --- | --- | --- |
| [49a8d3c6](../findings/problem.md) *feat(problem): the off-slice criterion has exactly one new coupling* | 2026-08-26 | `findings/problem.md`, **the origin** |
| `d25217b6` *docs(report): the symmetric class closes…* |, | `report/` |
| `86621751` *docs(findings): number the 24 results that only the report had numbered* | 2026-08-31 | `findings/target.md`, **the block, five days later** |

So the mathematics entered `problem.md` on 26 August and has never been in `target.md` at any commit. The block created on 31 August asserted the opposite about itself on the day it was written, and `bbfa159b` then filled the blank with a section title from the file the block was mistakenly sitting in.

**Where the argument actually lives:** [findings/problem.md](../findings/problem.md), the two paragraphs **"OFF THE SLICE: exactly one new coupling, explicitly identified"** and **"The parity argument, and it is two-sided"**, together with the **"CLASSIFICATION"** paragraph that checks the whole expansion against Xu's published identity. That passage is complete, carries its citations, and states its own scope, all three of which the `target.md` copy loses.

**A second pointer failure, from the brief itself.** The brief directs the reviewer to [conventions.md](../findings/conventions.md) for $\Phi$, $I$, $R_{\mathrm{ric}_0}$, $\Omega_0$ and the decomposition $R=cI+Y+W$. **Not one of those five is in that file.** Only $Q$ and the half-trace pairing are. Given that file's own stated purpose (*"definitions and conventions are quoted, never restated"*), the five objects L45 is built from have no home, and the block restates $\Phi$ implicitly by using it.

*Tally for the record: this makes the seventh false provenance note of the eight now audited in this batch.*

## 2. The count, **CONFIRMED, ten triples, five vanish; but two mechanisms are unnamed**

$T(A,B,C):=\langle A,\Phi(B,C)\rangle$ is totally symmetric ([BW08](../references/boehm-wilking-2008-space-forms/) eq. (5); Xu (2.33), $\mathrm{tri}(R,S,T)=2\langle Q(R,S),T\rangle$). With $R=A_1+A_2+A_3=cI+Y+W$,

$$\langle R,\Phi(R)\rangle=\sum_i T(A_i,A_i,A_i)+3\sum_{i\ne j}T(A_i,A_i,A_j)+6\,T(A_1,A_2,A_3),$$

so there are $\binom{3+3-1}{3}=10$ distinct triples carrying multinomial weights $1$, $3$, $6$. The two facts that decide all ten are Xu's Proposition 2.7 (stored text, p. 9) and the **orthogonality** of the decomposition $S^2_B(\mathfrak{so}(n))=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ (Xu (2.5)).

| # | triple | weight | value | verdict and **mechanism** |
| --- | --- | --- | --- | --- |
| 1 | $(I,I,I)$ | $c^3$ | $(n-1)\lVert I\rVert^2$ | **survives**, $\Phi(I)=(n-1)I$, from Xu (2.29) with $\mathrm{Ric}(I)=(n-1)\,\mathrm{id}$ |
| 2 | $(I,I,Y)$ | $3c^2$ | $(n-1)\langle I,Y\rangle$ | **vanishes**, Prop 2.7(1) puts $\Phi(I,I)$ in $\langle I\rangle$; **orthogonality** kills it. *Unnamed by the block* |
| 3 | $(I,I,W)$ | $3c^2$ | $(n-1)\langle I,W\rangle$ | **vanishes**, same, or Prop 2.7(3) |
| 4 | $(I,Y,Y)$ | $3c$ | $\langle I,\Phi(Y)\rangle$ | **survives** |
| 5 | $(I,Y,W)$ | $6c$ | $\langle Y,\Phi(I,W)\rangle$ | **vanishes**, $\Phi(I,W)=0$ (Prop 2.7(3)), **via total symmetry of $T$** |
| 6 | $(I,W,W)$ | $3c$ | $\langle W,\Phi(I,W)\rangle$ | **vanishes**, $\Phi(I,W)=0$ via symmetry; independently, Prop 2.7(4) puts $\Phi(W)$ in $\langle W\rangle$ |
| 7 | $(Y,Y,Y)$ | $1$ | $\langle Y,\Phi(Y)\rangle$ | **survives** |
| 8 | $(Y,Y,W)$ | $3$ | $\langle W,\Phi(Y)\rangle$ | **survives, the new coupling** |
| 9 | $(Y,W,W)$ | $3$ | $\langle Y,\Phi(W)\rangle$ | **vanishes**, Prop 2.7(4), $\Phi(W)\in\langle W\rangle$, **orthogonality**. *Unnamed by the block* |
| 10 | $(W,W,W)$ | $1$ | $\langle W,Q(W)\rangle$ | **survives** |

Five and five. **The block's arithmetic is exactly right**, its five survivors are #1, #4, #7, #8, #10, and the weights it prints ($1$, $3c$, $1$, $3$, $1$), are the correct multinomial ones. No triple is dropped and none is double-counted.

**On the brief's two specific questions.**

- **"Every $I$–$W$ pairing vanishes" covers *three* triples, not two** (#3, #5 and #6) and **one mechanism kills all three at once**: $\Phi(I,W)=0$ together with the total symmetry of $T$, since $T(I,I,W)=\langle I,\Phi(I,W)\rangle$, $T(I,Y,W)=\langle Y,\Phi(I,W)\rangle$ and $T(I,W,W)=\langle W,\Phi(I,W)\rangle$ all carry the same vanishing factor. So the two reasons the brief expects are really one, provided symmetry is invoked. **That matters**: [problem.md:72](../findings/problem.md#L72) records that the symmetry of $T$ is *"not load-bearing"* for the on-slice collapse. **Off the slice it becomes load-bearing**, precisely at #5, and no line of the record says so. (It is avoidable, Xu (2.29) applied to $Y$ gives $Y\#I=\tfrac{n-4}2Y$, hence $\Phi(I,Y)=\tfrac{n-2}2Y\perp W$, but that route is nowhere on the record either.)
- **$(I,W,W)$ genuinely vanishes and is not absorbed into $\langle W,Q(W)\rangle$.** The two are separated by their degree in $c$: #6 carries weight $3c$ and #10 carries weight $1$. Nothing can migrate between them.

**The gap.** #2 and #9 are neither $I$–$W$ pairings nor named anywhere in the block, and #9 needs a genuinely different input, *$\Phi$ preserves the Weyl summand*, which is [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) plus Hamilton's Bianchi preservation, both of which [problem.md:52–53, 70](../findings/problem.md#L52) carries and the L45 block does not. The source passage at least says *"by Xu (3)"*; Xu's (3) covers #3, #5, #6 and **not** #2 or #9. The `target.md` copy drops even that citation.

## 3. The closed form, **CONFIRMED as printed, and the brief's own paraphrase of it is wrong**

Xu's Lemma 2.6 (his statement of [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.2), eq. (2.31) in the stored text: for $R$ of Ricci type,

$$\big(R^2+R^\sharp\big)_W=\tfrac1{n-2}\big(\mathrm{Ric}_0\wedge\mathrm{Ric}_0\big)_W .$$

Setting $\bar\lambda=0$ leaves $R=Y$, and (2.30)'s other two terms are $\wedge\,\mathrm{id}$ and $I$ pieces, both Ricci-type, so the $W$-block is untouched. Hence

$$T(Y,Y,W)=\langle W,\Phi(Y)\rangle=\big\langle W,(\Phi(Y))_W\big\rangle=\tfrac1{n-2}\big\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\big\rangle,$$

and the **term in the expansion**, carrying its multinomial weight $3$, is $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. **That is the block's number, and it is right.**

**Independent confirmation, verbatim in the stored source.** Xu's Lemma 2.8 eq. (2.34), which he attributes to Huisken's proof of his Theorem 3.3, displays the whole five-term expansion with $+\tfrac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$ as its third term, and its $(Y,Y,Y)$ term carries weight $1$ and its $(I,Y,Y)$ term weight $3$. So the block's convention (**each printed term includes its multinomial coefficient**), is the same as the published identity's, and the block is internally consistent in it across all five survivors.

**But the wording is ambiguous, and the ambiguity has already bitten.** The block writes *"the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$"* immediately after calling $T$-values "the ten distinct triples". Read as the trilinear value $T(Y,Y,W)$ (the natural reading of "triple" in that sentence), the constant is wrong by a factor $3$; the value is $\tfrac1{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. **The brief I was given makes exactly that error**, asking me to derive "$\langle Y,\Phi(Y,W)\rangle=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$", which is false. The block should say *"the term $3\,T(Y,Y,W)$"* or write the value without the $3$.

**On the convention question the brief raises.** The factor $3$ is a multinomial coefficient and is therefore **immune to the pairing normalisation**, every one of the ten triples scales identically under a rescaling of $\langle\cdot,\cdot\rangle$, so any global factor cancels out of the coefficient. [conventions.md](../findings/conventions.md) is silent on this and does not need to speak.

**The real convention hazard is a different one, and it is live.** The formula is **degree 2** in $\mathrm{Ric}_0$ while $Y=R_{\mathrm{Ric}_0}=\tfrac2{n-2}\mathrm{Ric}_0\wedge\mathrm{id}$ (Xu (2.6)) is degree 1, so the constant *is* sensitive to the $\mathrm{Ric}$ normalisation. The block writes its summand as $R_{\mathrm{ric}_0}$ in lower case and its closed form in $\mathrm{Ric}_0$ in upper case, **in one sentence**, and [problem.md:74](../findings/problem.md#L74) and [problem.md:112](../findings/problem.md#L112) both warn on this record that **Xu's $\mathrm{Ric}$ is twice Beitz's $\mathrm{ric}$**. A reader who supplies Beitz's normalisation gets $\tfrac{12}{n-2}$. Neither symbol is in [conventions.md](../findings/conventions.md). **The block must name Xu's normalisation, or write both symbols the same way.**

## 4. The reflection argument, **CONFIRMED, on all three counts the brief raises**

**Parity.** The three even terms ($c^3(n-1)\lVert I\rVert^2$, $3c\langle I,\Phi(Y)\rangle$, $\langle Y,\Phi(Y)\rangle$), contain **no $W$ at all**, so they are trivially fixed. $3\langle W,\Phi(Y)\rangle$ is linear in $W$, hence odd. And on the brief's specific worry: $Q(W)=W^2+W^\sharp$ is indeed even, $Q(-W)=Q(W)$, **but the pairing supplies the third factor**, $\langle -W,Q(-W)\rangle=-\langle W,Q(W)\rangle$, a homogeneous cubic and therefore odd. The bracketing is correct.

**The $\Omega_0$ premise, holds, and holds more widely than claimed.** [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96, as quoted at [problem.md:34](../findings/problem.md#L34): $R\in\Omega_a$ iff

$$\tfrac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\big(\tfrac{n-2}4+a\big)\lVert R_W\rVert^2\le0 .$$

Every occurrence of $W$ is inside $\lVert R_W\rVert^2$. At $a=0$ this is $\tfrac{n-2}n\lVert W\rVert^2\le\lVert R_I\rVert^2$. **The constraint sees $W$ through its norm and nothing else, at every $a$**, so the reflection is valid on the whole cone family and not only at $a=0$, a free generalisation the block does not claim.

**And it survives the correction a sibling audit just made.** [problem.md:495](../findings/problem.md#L495) and [results.md:276](../results.md#L276) have added the positivity clause, $\Omega_a=\{\operatorname{scal}(R)>0\}\cap F^{-1}(\cdots)$. Since $\operatorname{scal}(W)=0$, that clause is **$W$-independent**, so $cI+Y-W$ still satisfies it whenever $cI+Y+W$ does. The reflection is untouched. *This is worth recording because the correction landed after L45 was written and could have invalidated its premise.*

**The right-hand side of the criterion also splits by parity**, and here the `target.md` copy is thinner than its source. Writing the criterion as $\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$:

- $\mathrm{ric}(R)$ is **$W$-independent**, $\mathrm{ric}$ is linear and $\mathrm{ric}(W)=0$;
- $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ is **$W$-even**, since orthogonality gives $\lVert R\rVert^2=c^2\lVert I\rVert^2+\lVert Y\rVert^2+\lVert W\rVert^2$;
- $\Phi(R)$'s $W$-dependence is $2\Phi(cI+Y,W)+\Phi(W)$; the first is $2\Phi(Y,W)$ since $\Phi(I,W)=0$, and it is **odd**; the second is even but has **$\mathrm{ric}(\Phi(W))=0$** because $\Phi(W)$ is Weyl. So $\mathrm{ric}(\Phi(R))$'s only $W$-dependence is $2\,\mathrm{ric}(\Phi(Y,W))$, which lands in $\langle\mathrm{Ric}_0\rangle$ by **Xu Prop 2.7(5)** and is odd.

All of this is at [problem.md:82](../findings/problem.md#L82) and **none of it is in the `target.md` block**, which prints $\mathrm{RHS}_{\rm odd}$ and $\mathrm{RHS}_{\rm even}$ as though they needed no justification.

**The derivation.** With $\mathrm{LHS}=E_L\pm O_L$ and $\mathrm{RHS}=E_R\pm O_R$ at $R^\pm=cI+Y\pm W$, the criterion at both signs is the pair $E_L+O_L\le E_R+O_R$ and $E_L-O_L\le E_R-O_R$, i.e. $\pm(O_L-O_R)\le E_R-E_L$, i.e.

$$\big\lvert\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\big\rvert\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}. \qquad\checkmark$$

**Note this is an equivalence, not a weakening**: the two-sided inequality is *logically identical* to the conjunction of the criterion at the two signs. That is the honest description of what the Lemma is.

**The direction, the brief's question answered.** Non-negativity of $\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ is **not a further hypothesis**: adding the two instances gives $2E_L\le2E_R$ directly. So on the hypothesis it is always non-negative, and the inequality is never vacuous for sign reasons. **Where it is negative, the hypothesis has failed**, the criterion fails at one of the two signs, $\Omega_0$ is not invariant, and that is exactly the regime $4\le n\le11$ that [L44](../results.md) establishes with the padded $W_{\mathbb{CP}^2}$ witness. So L45 is a **conditional** statement, true given invariance and false without it, and the block's *"demanding the criterion at both signs gives"* carries that conditionality only by implication.

**A structural point in the Lemma's favour that the block misses.** $\mathrm{LHS}_{\rm even}$ contains no $W$ whatsoever, and $\mathrm{RHS}_{\rm even}$ depends on $W$ only through $\lVert W\rVert^2$ inside $F$. On $\partial\Omega_0$, $\lVert W\rVert$ is pinned to $c$ by the boundary equation. **So with $c$ and $Y$ fixed, the entire right-hand side is a constant as $W$ ranges over its sphere.** The inequality therefore genuinely bounds a $W$-varying odd quantity against a $W$-independent budget, which is the strongest reading available and is not stated anywhere.

## 5. What it buys, **named, not controlled**

**What the on-slice statement gives.** [L43](../results.md#L276) at $Y=0$: $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2=\theta_0(n)\lVert W\rVert^3$.

**What L45 adds.** Setting $Y=0$ in L45 gives $\Phi(Y)=0$ and $\Phi(Y,W)=0$, so $\mathrm{LHS}_{\rm odd}=\langle W,Q(W)\rangle$, $\mathrm{RHS}_{\rm odd}=0$, and the bound becomes $\lvert\langle W,Q(W)\rangle\rvert\le\theta_0(n)\lVert W\rVert^3$, **the two-sided form of L43, which is equivalent to it since $P$ is odd and $\mathcal W_n$ is a linear space.** The consistency check passes exactly. ✓

**Off the slice, the coupling is named and not controlled**, and this is the honest verdict:

$$\langle W,Q(W)\rangle\;\le\;\underbrace{\big[\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}\big]}_{\text{grows with }\lVert Y\rVert,\ \text{unbounded above on the record}}+\underbrace{\mathrm{RHS}_{\rm odd}}_{\text{unsigned}}-\underbrace{3\langle W,\Phi(Y)\rangle}_{\text{unsigned; }=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle}$$

Not one of the three right-hand pieces is sign-controlled or bounded by anything on this record. **The Lemma therefore licenses no statement about $\langle W,Q(W)\rangle$ that the on-slice L43 does not already give.** Its value is exactly bookkeeping: it says *what a general-$R_{\mathrm{ric}_0}$ proof must establish*, and it identifies the single extra term that separates that obligation from Conjecture A.

**[results.md:286](../results.md#L286) says this in terms**, *"It is a bookkeeping identity for the general criterion and proves no case of the conjecture by itself"*, and [problem.md:92](../findings/problem.md#L92) says it too. **The `target.md` block says neither.** A reader landing on `target.md` from the index gets a display headed "the two-sided bound" with no indication that it is an obligation rather than a tool. **That is defect #3 and it is the one with the largest consequence.**

## 6. Hedging clauses and pointers

**Hedges.** Four in the block, and only one conceals anything.

| clause | verdict |
| --- | --- |
| *"exactly one new coupling"* | **exact.** Triple #8 is the unique survivor absent at $Y=0$. Verified against the ten-row table. |
| *"every $I$–$W$ pairing vanishes"* | **true, and incomplete**, it is 3 of the 5, and it is offered where the reader needs all 5. Defect #2. |
| *"depends only on $\lVert W\rVert$"* | **exact**, at every $a$, and robust to the newly added $\operatorname{scal}>0$ clause. |
| *"gives the two-sided bound"* | **the concealing one.** It is an equivalence to the hypothesis, not a consequence drawn from it, and it is conditional on invariance holding. Defect #3. |

**Pointers.** [report/](../report/) resolves. Every citation the *source* passage makes resolves in the stored full text, Xu Prop 2.7 (p. 9), Lemma 2.6/(2.31), Lemma 2.8/(2.34), (2.5)/(2.6), (2.29), and I read each rather than trusting the note. **The block's own single pointer, its provenance note, is the one that fails.**

**Does the file settle it above or below?** [target.md](../findings/target.md) does not (the material is in a *different file* entirely), [problem.md:76–92](../findings/problem.md#L76), where the block at [target.md:694](../findings/target.md#L694) points nowhere near it. This is the checklist item's first miss in the batch, and for an instructive reason: the note asserted "in this file", which is what stopped the search inside `target.md`.

## 7. A defect in a downstream citation, reported rather than fixed

[results.md:286](../results.md#L286) states *"five vanish identically and five survive, **with multiplicities $1,3,3,6$**"*. The five survivors carry multiplicities $1$, $3$, $1$, $3$, $1$, the multiset $\{1,3\}$. **No surviving triple has multiplicity $6$**; the unique weight-$6$ triple is $(I,Y,W)$, which vanishes. The phrase also lists four numbers for five terms. Under every reading I can construct it is wrong, and it sits in the canon. *I have left [results.md](../results.md) untouched as instructed.*

[results.md:276](../results.md#L276) closes L43 with *"It does not reach $a$ strictly between $0$ and $n/4$; Lemma L45 gives the two-sided bound the criterion demands off the slice."* The juxtaposition invites the reading that L45 covers intermediate $a$. **It does not**, L45 is at $a=0$, off the slice. (Per §4 the reflection *would* generalise to every $a$, but the even-part collapse it is paired with does not.) A minor over-read, worth a comma.

## 8. What is owed, and it is all reachable

1. **Repoint the provenance note** to [findings/problem.md](../findings/problem.md), sections *"OFF THE SLICE: exactly one new coupling, explicitly identified"* and *"The parity argument, and it is two-sided"*, and **strike "has always been in this file"**, `git log -S'W\text{-even}'` refutes it in one command.
2. **Name the mechanisms for $(I,I,Y)$ and $(Y,W,W)$**, Xu Prop 2.7(1) and 2.7(4) against the orthogonality of (2.5), and record that the total symmetry of $T$ **is** load-bearing off the slice at $(I,Y,W)$, against [problem.md:72](../findings/problem.md#L72)'s on-slice note that it is not.
3. **Carry the scoping sentence into the block**: it is a bookkeeping identity, conditional on invariance, and proves no case of the conjecture by itself.
4. **Fix the $\mathrm{Ric}_0$ / $R_{\mathrm{ric}_0}$ collision** in the coupling line, naming Xu's normalisation; and add $\Phi$, $I$, $R_{\mathrm{ric}_0}$, $\Omega_0$ and the decomposition to [conventions.md](../findings/conventions.md), where the brief already expects to find them.
5. **Disambiguate "the triple $(Y,Y,W)$, equal to $\tfrac3{n-2}\langle\cdots\rangle$"**, write "the term $3T(Y,Y,W)$", since the value is $\tfrac1{n-2}\langle\cdots\rangle$ and a reader has already been caught by this.
6. **Report the two [results.md](../results.md) defects** of §7 to whoever owns the canon.

None of the six touches the mathematics. **The Lemma is true.**
