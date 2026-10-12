# Verification v215, Lemma L71, saturation forces the balanced sphere product

**Cold read of [BRIEF_L71.md](BRIEF_L71.md), sections A–C, against [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md) (L70, L73, L117, L153) and the Cartan sources in [references/](../references/). No numerical work of any kind was done: no script, no Sage, no evaluation. Every number appearing below was reproduced by hand in closed form or is quoted as the record's own figure and labelled as such. Log: [agent_logs/verify-L71-v215.log](../agent_logs/verify-L71-v215.log).**

## Claim table

| # | claim | verdict |
|---|---|---|
| 1 | Saturation of [L70](../findings/bounds.md) gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$ | **CONFIRMED** |
| 2 | $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is a subalgebra, and a symmetric pair with odd part $\mathfrak m$ | **CONFIRMED** |
| 3 | $\mathfrak h$ normalises $\mathfrak g'$, $\mathfrak r$ centralises it, so $\mathfrak g'$ is an ideal | **CONFIRMED** |
| 4 | $\mathfrak r=0$ and $\mathfrak h=[\mathfrak m,\mathfrak m]$, from simplicity | **CONFIRMED** |
| 5 | "$W$ has exactly two eigenvalues" is **derived**, not the hypothesis restated | **CONFIRMED, the rescue holds end to end** |
| 6 | $\mathfrak{so}(n)$ simple at every $n\ge3$ except $n=4$; $n=3$ excluded for vacuity | **CONFIRMED** |
| 7 | $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ follows from $\mathfrak h=[\mathfrak m,\mathfrak m]$ | **CONFIRMED, and available twice over** |
| 8 | $\dim\mathfrak h=\tfrac{n(n-2)}4$, derived from (A)+(B)+tracelessness, non-circular | **CONFIRMED, but one stated hypothesis is superfluous** |
| 9 | $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$ forces $t=0$ at every even $n$ | **CONFIRMED** |
| 10 | The $n=8$ conjugacy is fixed "by two independent routes" | **REFUTED, one of the two routes is a non-sequitur, killed by the block's own example** |
| 11 | The $n=8$ conjugacy conclusion itself (the balanced involution is triality-fixed) | **CONFIRMED, by the weight route alone** |
| 12 | The $\mathrm{Aut}$-versus-$SO(n)$ gap at even $n\ne8$ | **UNSTATED, real, closed, and closed nowhere in the block** |
| 13 | No critical point saturates at odd $n\ge5$, since $\dim\mathfrak m=n^2/4\notin\mathbb Z$ | **CONFIRMED** |
| 14 | $\theta=\theta_0(n)$ exactly | **CONFIRMED** |
| 15 | $n=4$ is the sole exception, realised by $W_{\mathbb{CP}^2}$ | **CONFIRMED, in closed form** |
| 16 | $\lVert W\rVert=1$ is a hypothesis of the lemma | **UNSTATED in L71; pinned only by [conventions.md](../findings/conventions.md)** |
| 17 | Every "verified structure" figure is of the disowned tautological kind | **CONFIRMED, the $7\times10^{-16}$ is not alone; three more are the same** |
| 18 | results.md still calls [L117](../findings/bounds.md) "the converse" | **STALE, L117's own block records that label as inverting the dependency** |

**One line.** The central question settles in the lemma's favour (the ideal argument is a genuine derivation and $\mathfrak r=0$ enters nowhere upstream) but the $n=8$ endgame carries a false inference that the same paragraph refutes, and the conclusion survives only because a second, sound route stands beside it.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated:

> $\mathfrak m$, $\mathfrak h$, $\mathfrak r$, at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included. **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context

> $\theta$, $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> $\theta_0(n)$, **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only***

> **Structure constants** $c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide.

> **The pair cap and the Killing marginal, each a numbered result rather than a convention.** … The row marginal is **[Lemma L153](../findings/bounds.md)**, in the general form $\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ … **The marginal has two readings and consumers use both**: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ over ordered pairs, $\sum_{\beta<\gamma}T_{\alpha\beta\gamma}=n-2$ over unordered, so convert before comparing constants.

The convention line for $\theta$ is load-bearing below: $Q(cW)=c^2Q(W)$ while $\theta(cW)=\theta(W)$, so "$Q(W)=\theta W$ at a critical point" is a statement that can hold only at $\lVert W\rVert=1$. That is the record's only pinning of the scale L71 needs and never states.

The symbol collisions flagged in the brief were checked against the block. $\mathfrak h$, $\mathfrak m$, $\mathfrak r$, $E_{\max}$, $E_{\min}$ are used in this block in the eigenspace sense throughout, matching the table; no drift into [target.md](../findings/target.md)'s symmetric-pair sense or [L36](../findings/isotropy-cap.md)'s sense occurs. $t$, $p$, $q$ are local to the uniqueness paragraph and collide with nothing there. $\mathfrak g'$ is untabled and appears only here. $\Pi$ does not appear in the block. **One collision is live and unnoticed:** $T$ in "with $T$'s mass splitting evenly across the support" is the bracket tensor $T_{abc}=c_{abc}^2$, while [conventions.md](../findings/conventions.md) tables a third sense of $T$ as the trilinear form on $\mathcal W_n$ and a fourth as [L35](../findings/stratum-two-negative.md)'s cap. The block never says which; only the bracket reading makes the sentence parse.

## Hypothesis inventory

| # | hypothesis | stated in L71? | used? | where |
|---|---|---|---|---|
| H1 | $W\in\mathcal W_n$, $W\ne0$, $\lVert W\rVert=1$ | **no**, pinned only by conventions.md's $\theta$ line | **yes, load-bearing** | L70's boxed identity, which "needs $\lVert W\rVert=1$" by its own text |
| H2 | $W$ critical, $Q(W)=\theta W$ | yes | yes | L70's identity |
| H3 | $n\ge5$ | yes | yes | simplicity of $\mathfrak{so}(n)$ (§4), non-vacuity (§5) |
| H4 | saturation, $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ | yes | yes | everywhere |
| H5 | $\lambda_{\min}<0<\lambda_{\max}$ strictly | **no** | **yes, load-bearing** | §1: without it the *only-if* of L70's equality case fails, as L70's own text says |
| H6 | L70's equality characterisation in its **weakened** form | by reference | yes | §1 |
| H7 | relations (A) = [L153](../findings/bounds.md) and (B) = Böhm–Wilking Lemma 2.1 | by reference in the $\dim\mathfrak h$ paragraph | yes | §6 |
| H8 | Cartan's classification of involutions of compact $\mathfrak{so}(n)$ | named, **cited to nothing** | yes | §7 |
| H9 | $\mathrm{Aut}(\mathfrak g)/\mathrm{Inn}(\mathfrak g)\cong\mathrm{Sym}(D(\mathfrak g))$, so $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ for $n\ne8$ | **no** | **yes, load-bearing at every even $n\ne8$** | §8 |
| H10 | $\Pi_{\mathfrak h}-\tfrac rNI$ with $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ *is* the Weyl tensor of $S^m\times S^m$ | by reference to [L23](../results.md) | yes | §9 |
| H11 | "$T$'s mass splitting evenly across the support" | **yes** | **no, never used, and unproved** | §6 |

**Stated but never used: H11.** **Used but never stated: H1, H5, H9.** H5 and H1 are recoverable from elsewhere on the record and cost the lemma nothing but a clause; H9 is a genuine import that appears nowhere in the block.

## 1. Saturation to the three bracket relations, CONFIRMED

[L70](../findings/bounds.md) is

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert},\qquad D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2 .$$

Saturation is the vanishing of the last term, hence $D(v)=0$, and since every summand is a nonnegative weight on a nonnegative factor, $c_{vab}=0$ whenever $\lambda_a\lambda_b>\lambda_{\min}\lambda_{\max}$.

**When is $\lambda_a\lambda_b=\lambda_{\min}\lambda_{\max}$?** With $\lambda_{\min}<0<\lambda_{\max}$ (H5, free on $\mathcal W_n$ from $\operatorname{tr}W=0$, $W\ne0$), the value $\lambda_{\min}\lambda_{\max}$ is strictly negative, so one factor is negative and one positive; then $\lvert\lambda_a\rvert\le\lvert\lambda_{\min}\rvert$ and $\lvert\lambda_b\rvert\le\lambda_{\max}$ give $\lvert\lambda_a\lambda_b\rvert\le\lvert\lambda_{\min}\rvert\lambda_{\max}$ with equality only when both are equalities. So the support condition is exactly $\{\lambda_a,\lambda_b\}=\{\lambda_{\min},\lambda_{\max}\}$, i.e. one index in $\mathfrak m$ and one in $\mathfrak h$. **A zero eigenvalue is excluded outright**, since $0>\lambda_{\min}\lambda_{\max}$, which is how $\ker W$ gets swept into $\mathfrak r$ and killed, and it answers the $\ker W\ne0$ trap by name.

Now fix a unit $v\in\mathfrak m$, extend to an orthonormal eigenbasis containing it (so $v$ *is* a basis index and no general-$v$ form of (A)/(B) is needed), and read $c_{vab}=\langle[v,v_a],v_b\rangle$ for each placement of $v_a$:

- $v_a\in\mathfrak m$: the pair $(a,b)$ is admissible only for $b\in\mathfrak h$, so $\langle[v,v_a],v_b\rangle=0$ for all $v_b\notin\mathfrak h$, i.e. $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$.
- $v_a\in\mathfrak h$: admissible only for $b\in\mathfrak m$, i.e. $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$.
- $v_a\in\mathfrak r$: no pair containing an $\mathfrak r$-index is admissible, so $\langle[v,v_a],v_b\rangle=0$ for **every** $b$, i.e. $[\mathfrak m,\mathfrak r]=0$.

All three, derived. Total antisymmetry of $c$ makes the three readings consistent rather than three separate conditions.

**Two riders the block does not carry.** First, H5 above. Second, L70's own blockquote says the boxed form is the **weakened** member of its family and that its equality case characterises saturation of the weakened bound; the sharp condition differs when $\lambda_{\min}$ is simple. L70 also proves $\dim E_{\min}\ge n/2$ at any saturating point, so $\lambda_{\min}$ has multiplicity $\ge2$ and the two agree. The chain is sound, but it passes through a result stated in the *parent* block and not flagged in L71's.

## 2. Subalgebra, and the symmetric-pair structure of $\mathfrak g'$, CONFIRMED

Write $\mathfrak k=[\mathfrak m,\mathfrak m]$, $\mathfrak g'=\mathfrak m+\mathfrak k$. Then:

- $[\mathfrak m,\mathfrak m]=\mathfrak k\subseteq\mathfrak g'$, by construction.
- $[\mathfrak k,\mathfrak m]\subseteq[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, using relation 1 then relation 2.
- $[\mathfrak k,\mathfrak k]$: for $a,b\in\mathfrak m$ and $Z\in\mathfrak k$, Jacobi gives $[[a,b],Z]=[a,[b,Z]]-[b,[a,Z]]$, and $[b,Z]\in[\mathfrak m,\mathfrak k]\subseteq[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, so both terms lie in $[\mathfrak m,\mathfrak m]=\mathfrak k$.

The sum is direct: $\mathfrak k\subseteq\mathfrak h$ and $\mathfrak h\perp\mathfrak m$, distinct eigenspaces of a symmetric operator, $\lambda_{\min}\ne\lambda_{\max}$ by H5. So $\mathfrak g'=\mathfrak k\oplus\mathfrak m$ is a $\mathbb Z_2$-graded subalgebra, which is the symmetric-pair claim.

**One notational defect.** The block writes the third bullet as $[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]\subseteq[\mathfrak m,\mathfrak m]$. Jacobi produces a **sum of two** such terms, not one; the single-term display is a compression, correct in content and wrong as an inclusion of sets. Cosmetic, and worth one word.

## 3. Ideal, CONFIRMED, and the containment does follow from Jacobi

Every summand of $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h\oplus\mathfrak r$ (a genuine decomposition: $W$ is symmetric, so its eigenspaces span) maps $\mathfrak g'$ into itself.

- $[\mathfrak m,\mathfrak g']\subseteq\mathfrak g'$, §2.
- $[\mathfrak r,\mathfrak m]=0$ by relation 3, and $[\mathfrak r,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak r,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak r,\mathfrak m]]=0$. So $\mathfrak r$ centralises $\mathfrak g'$.
- $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m\subseteq\mathfrak g'$ by relation 2, and
 $$[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak h,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak h,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]+[\mathfrak m,\mathfrak m]=[\mathfrak m,\mathfrak m].$$

The displayed containment is exactly $\mathrm{ad}(h)$ being a derivation, and it does hold **outright** given relation 2. The brief asks whether Jacobi gives it outright: it does.

**But the sentence carrying it is ambiguous and wrong on its nearer reading.** The block writes: *"using only $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, **which the Jacobi identity proves outright**."* The nearest antecedent of "which" is $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, and the Jacobi identity does **not** prove that, saturation does, in §1. What Jacobi proves outright is the display above, *from* that relation. On the intended reading the sentence is right; on the reading its grammar offers it credits Jacobi with a relation Jacobi cannot see.

## 4. $\mathfrak r=0$, and where simplicity enters, CONFIRMED

$\mathfrak g'$ is a nonzero ideal ($\mathfrak m\ne0$, since $\operatorname{tr}W=0$ at $W\ne0$ forces $\lambda_{\min}<0$ and its eigenspace is nonempty) of $\mathfrak{so}(n)$. Simplicity gives $\mathfrak g'=\mathfrak{so}(n)$. Since $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]\subseteq\mathfrak m\oplus\mathfrak h$ and the three eigenspace summands are orthogonal, $\mathfrak r=0$ and $[\mathfrak m,\mathfrak m]=\mathfrak h$.

**Simplicity, checked at the boundary.** $\mathfrak{so}(3)\cong\mathfrak{su}(2)$ simple; $\mathfrak{so}(4)\cong\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ not simple; $\mathfrak{so}(5)\cong\mathfrak{sp}(2)$, $\mathfrak{so}(6)\cong\mathfrak{su}(4)$, and $\mathfrak{so}(n)$ for $n\ge7$, all simple. So the block's "holds at every $n\ge3$ except $n=4$" is exactly right.

**$n=3$.** $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ vanishes at $n=3$, so $\mathcal W_3=0$ and there is no unit critical point: the claim is vacuous, and the block's stated reason is the correct one. Note the consequence, the argument of §1–§4 would in fact run at $n=3$; nothing is lost by excluding it, and nothing about simplicity is being hidden there.

## 5. The two-eigenvalue conclusion, the round's central question, CONFIRMED as DERIVED

Trace the dependence of every step above on $\mathfrak r=0$:

| step | inputs | uses $\mathfrak r=0$? |
|---|---|---|
| three bracket relations (§1) | L70 identity, H1, H2, H5 | no |
| $\mathfrak g'$ subalgebra (§2) | relations 1, 2 | no |
| $\mathfrak h$ normalises, $\mathfrak r$ centralises (§3) | relations 1, 2, 3 | no |
| $\mathfrak g'=\mathfrak{so}(n)$ (§4) | simplicity, $\mathfrak m\ne0$ | no |
| $\mathfrak r=0$, $\mathfrak h=[\mathfrak m,\mathfrak m]$ | the above | it is the output |

Nothing upstream consumes it. The blockquote's defect (i), that "two eigenvalues, derived not assumed" was circular *while $\mathfrak r=0$ was hypothesised*, is a correct diagnosis of the predecessor (with $\mathfrak r=0$ assumed, $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h$ is literally the two-eigenvalue statement), and the ideal argument is a correct repair of it. **The rescue works end to end.** This is the one place the record's own blockquote can be believed on the mathematics as well as on the history.

## 6. $\dim\mathfrak h=\tfrac{n(n-2)}4$, CONFIRMED, non-circular, and one hypothesis is superfluous

Write $\lambda_{\max}=h>0$, $\lambda_{\min}=-m<0$. Take the row $v\in\mathfrak m$. Relation (A) = [L153](../findings/bounds.md) gives the row mass $\sum_{bc}T_{vbc}=2(n-2)$, so $\mu_v=T_{v\bullet\bullet}/2(n-2)$ is a probability measure; relation (B) gives $\mathbb E_{\mu_v}[(\lambda_b+\lambda_c)/2]=-\lambda_v/(n-2)=m/(n-2)$.

By §1 the measure is supported on pairs with one index in $\mathfrak m$ and one in $\mathfrak h$, on which $\lambda_b+\lambda_c=h-m$ is **constant**. Hence $\mathbb E_{\mu_v}[(\lambda_b+\lambda_c)/2]=(h-m)/2$, and

$$\frac{h-m}2=\frac m{n-2}\quad\Longrightarrow\quad (n-2)(h-m)=2m\quad\Longrightarrow\quad (n-2)h=nm .$$

That is the block's $(n-2)h=nm$, and it matches [L117](../findings/bounds.md)'s $M=nm/(n-2)$ exactly.

**H11 is superfluous.** The block derives this "with $T$'s mass splitting evenly across the support". Nothing of the kind is needed or used: $\lambda_b+\lambda_c$ is constant on the support, so **every** distribution supported there returns the same expectation. The evenness claim is moreover unproved anywhere in the block. It is the brief's "hypothesis stated but never used" trap, present in the very paragraph the record wrote to repair an under-derivation.

**Then tracelessness.** With $\mathfrak r=0$ and $N=\binom n2$, $\operatorname{tr}W=0$ reads $\dim\mathfrak h\cdot h=\dim\mathfrak m\cdot m$, so $\dim\mathfrak m=\tfrac n{n-2}\dim\mathfrak h$; with $\dim\mathfrak h+\dim\mathfrak m=N$,

$$\dim\mathfrak h\cdot\frac{2n-2}{n-2}=\frac{n(n-1)}2\quad\Longrightarrow\quad\dim\mathfrak h=\frac{n(n-2)}4,\qquad\dim\mathfrak m=\frac{n^2}4 .$$

**Non-circular.** The inputs are (A), (B), the support statement, $\operatorname{tr}W=0$ and $\mathfrak r=0$, none of which mentions $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ or the sphere product. The block's "only after $\mathfrak r=0$ does tracelessness turn that ratio into the dimensions" is exactly right, and its parenthetical check at $W_{\mathbb{CP}^2}$ (ratio holds, dimension formula does not), is the correct discriminator, since $(n-2)h=nm$ at $n=4$ reads $2h=4m$, i.e. $h/m=2$, which the $\mathbb{CP}^2$ spectrum $(0,0,0,-1,-1,2)/\sqrt6$ satisfies while $\dim\mathfrak h=1\ne 4\cdot2/4=2$.

## 7. Uniqueness, the identity and the forcing, CONFIRMED

With $p=\tfrac n2+t$, $q=\tfrac n2-t$,

$$\dim\big(\mathfrak{so}(p)\oplus\mathfrak{so}(q)\big)=\frac{p(p-1)+q(q-1)}2=\frac{p^2+q^2-n}2=\frac{\tfrac{n^2}2+2t^2-n}2=\frac{n^2}4+t^2-\frac n2 .$$

Setting this to $\tfrac{n(n-2)}4=\tfrac{n^2}4-\tfrac n2$ gives $t^2=0$, so $t=0$, over the reals, hence a fortiori over the integers, at every even $n$ and with no case list. The block's defect (iv) is correct and its replacement of the $n=6\ldots16$ list is sound. $\mathfrak u(n/2)$ has $\dim=n^2/4\ne n^2/4-n/2$ for $n>0$, so it is excluded, as claimed. The degenerate members are inside the identity, not outside it: $t=\tfrac n2$ gives $\dim=N$ (excluded by $\mathfrak m\ne0$), $t=\tfrac n2-1$ gives $\mathfrak{so}(n-1)$.

**The import.** $\{\mathfrak{so}(p)\oplus\mathfrak{so}(q),\ \mathfrak u(n/2)\}$ being the *complete* list is Cartan, and the block cites nothing for it. It is now on the record: [Etingof](../references/etingof-2024-real-forms-involutions/) §41.4 items 3, 5, 6 realise every involution of type $B_n$ and $D_n$ as conjugation by a named element of $O(n)$ with its determinant, giving $\mathfrak k=\mathfrak{so}_{2p}\oplus\mathfrak{so}_{2q}$ ($g^2=1$, $\det=+1$), $\mathfrak k=\mathfrak{gl}_n(\mathbb C)$, compactly $\mathfrak u(n/2)$ ($g^2=-1$), and $\mathfrak k=\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q-1}$ ($\det=-1$); [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) Ch. 8 states it for the compact form. **The hypothesis of the import checks out against the object**: $\mathfrak{so}(n)$ is a compact simple real Lie algebra for $n\ge5$ (§4), and the grading of §1–§4 defines an honest involutive automorphism, because all three of $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ hold, the first by §8 below. This is the trap the brief names (an imported theorem whose hypotheses were never checked, the way a cited theorem's unital hypothesis killed an earlier route): here the hypotheses do check, and the block simply never says so.

## 8. $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, CONFIRMED, and available twice

Defect (ii)'s repair: $[\mathfrak h,\mathfrak h]=[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]=\mathfrak h$, the middle step being §3's normalisation, which used only relation 2. Correct and non-circular.

It is also already in hand from §2: $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ was proved for $\mathfrak g'$ before $\mathfrak g'=\mathfrak{so}(n)$ was known, and $\mathfrak k=\mathfrak h$ afterwards. So the block understates: the relation it says "was never derived" was in fact one substitution away from a line it had already written.

## 9. Cartan up to $\mathrm{Aut}$ against the $SO(n)$-conjugacy consumed, the gap is real, and closed unevenly

The lemma needs $\mathfrak h$ conjugate to the standard $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$ by an element of $O(n)$, enough, because $W=(h+m)\Pi_{\mathfrak h}-mI$ is determined by $\mathfrak h$ once $h/m=n/(n-2)$ and $\lVert W\rVert=1$ are fixed, and because the standard $\mathfrak h$ is normalised by $\mathrm{diag}(-1,1,\dots,1)\in O(n)$, so $O(n)$-conjugacy to it collapses to $SO(n)$-conjugacy. Cartan supplies conjugacy under $\mathrm{Aut}(\mathfrak{so}(n))$ ([Etingof](../references/etingof-2024-real-forms-involutions/) Thm. 41.5: *"Real forms of $\mathfrak g$ are in bijection with conjugacy classes of involutions $\theta\in\mathrm{Aut}(\mathfrak g_c)$"*).

**At even $n\ne8$ the gap does not exist**, and the block never says why. [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/) Prop. 4.43 gives $\mathrm{Aut}(\mathfrak g)/\mathrm{Int}(\mathfrak g)\cong\mathrm{Sym}(D(\mathfrak g))$, and Ex. 4.45 reads it off: *"For $\mathfrak{so}(2n,\mathbb C)$ or $SO(2n,\mathbb R)$ we can choose conjugation with $\mathrm{diag}(-1,1,\dots,1)$ to represent the outer automorphism"*, with $S_3$ only at $D_4$. So $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ for every $n\ne8$, and Cartan's relation *is* the consumed one. This is H9: used at every even $n\ne8$, stated nowhere in the block, and present on the record only in [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md).

**At $n=8$ the gap is real.** Triality is an outer automorphism not induced by $O(8)$, so $\mathrm{Aut}$-conjugacy is strictly coarser than $O(8)$-conjugacy there. The block offers two routes to close it. One works. One does not.

### 9a. The determinant route, REFUTED

The block, in two places (defect blockquote and the uniqueness paragraph) and again in [results.md](../results.md)'s canonical entry:

> its determinant is $+1$, so $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is inner and Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy, where $\mathrm{Ad}(\mathrm{diag}(-1_3,1_5))$ has $\det=-1$ and is outer, which is exactly why dimension $12$ is safe and $13$ is not.

**Located.** The inference is "inner $\Rightarrow$ the $\mathrm{Aut}$-class equals the $\mathrm{Inn}$-class". **Exhibited, in closed form, inside $\mathfrak{so}(8)$ itself:**

- $u=\mathrm{diag}(-1_2,1_6)$ has $\det u=(-1)^2=+1$, so $u\in SO(8)$ and $\mathrm{Ad}(u)$ is **inner**; its fixed algebra is $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$, dimension $1+15=16$.
- $J$ an orthogonal complex structure on $\mathbb R^8$ has eigenvalues $\pm i$ with multiplicity $4$ each, so $\det J=i^4(-i)^4=+1$ and $\mathrm{Ad}(J)$ is **inner**; its fixed algebra is $\mathfrak u(4)$, dimension $16$. [Etingof](../references/etingof-2024-real-forms-involutions/) §41.4 item 5 files both under the *same* "compact inner class" of type $D_n$, the two cases $g^2=1$ and $g^2=-1$.
- They are $\mathrm{Aut}$-conjugate: by Thm. 41.5 their classes correspond to the real forms $\mathfrak{so}(6,2)$ and $\mathfrak{so}^*(8)$, and $\mathfrak{so}^*(8)\cong\mathfrak{so}(6,2)$, the $D_4$ triality isomorphism, and the reason Etingof states pairwise distinctness for types $A$ and $B$ and pointedly not for $D$.
- They are **not** $O(8)$-conjugate: $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ preserves a $2$-plane in $\mathbb R^8$ while $\mathfrak u(4)$ acts irreducibly on $\mathbb R^8$, and $O(8)$-conjugation preserves the isomorphism class of the action on $\mathbb R^8$.

So two inner, $\det=+1$ involutions of $\mathfrak{so}(8)$ are $\mathrm{Aut}$-conjugate without being $O(8)$-conjugate. The inference is a non-sequitur, and **the counterexample is printed in the same sentence of the block**, which closes by calling the $\mathfrak u(4)\leftrightarrow\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ swap at dimension $16$ "moving". The paragraph refutes itself between its two halves.

**Argued the opposite.** Could "inner" be doing legitimate work under a charitable reading? Three tries. (i) "Inner-ness is preserved, so triality cannot move it out of $\mathrm{Inn}$", true and useless: triality permutes inner classes among themselves, which is precisely what happens at dimension $16$. (ii) "The determinant is what distinguishes the $D_n$ inner classes", true for $n\ne4$ and exactly what fails at $D_4$, where the diagram symmetry group is $S_3$ rather than $\mathbb Z_2$ (Ziller Ex. 4.45). (iii) "Dimension $12$ is safe *because* it is inner", the stated reason is refuted; the true reason is §9b. The discrepancy survives all three, and it is a *stated inference*, not a stated conclusion, so reporting it does not touch the theorem.

**Also refuted, as a by-product: the "two independent routes" framing.** There is one route. The block's own defect (iii) diagnoses exactly this overstatement one paragraph earlier (*"Routes (i) and (ii) to uniqueness are not independent"*) and the same overstatement is reintroduced two sentences later under the words **"What is true, by two independent routes"**. [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md) already records the standing rule this violates: *"That step stays the record's own, and the citation to use is 'triality exists and $\mathrm{Out}(D_4)=S_3$', never 'triality separates these two'."*

### 9b. The weight route, CONFIRMED

Take $u=\mathrm{diag}(-1_4,1_4)$, i.e. rotation by $\pi$ in the first two coordinate $2$-planes and the identity on the others, so the torus element is $(\theta_1,\theta_2,\theta_3,\theta_4)=(\pi,\pi,0,0)$.

- On $V=\mathbb R^8$: eigenvalues $(-1)^4,(+1)^4$, pattern $(1^4,(-1)^4)$.
- On a half-spin representation, the weights are $\tfrac12(\epsilon_1,\epsilon_2,\epsilon_3,\epsilon_4)$ with $\epsilon_j=\pm1$ and $\prod\epsilon_j=+1$ on $S^+$, $-1$ on $S^-$. The eigenvalue is $\exp\!\big(\tfrac i2\sum_j\theta_j\epsilon_j\big)=\exp\!\big(\tfrac{i\pi}2(\epsilon_1+\epsilon_2)\big)$, which is $-1$ when $\epsilon_1=\epsilon_2$ and $+1$ when $\epsilon_1=-\epsilon_2$. On $S^+$: $\epsilon_1=\epsilon_2$ leaves $(\epsilon_3,\epsilon_4)\in\{(+,+),(-,-)\}$, so $2+2=4$ states at $-1$; $\epsilon_1=-\epsilon_2$ (two ways) leaves $(\epsilon_3,\epsilon_4)\in\{(+,-),(-,+)\}$, so $4$ states at $+1$. Pattern $(1^4,(-1)^4)$. The same count on $S^-$.

Triality permutes $V,S^+,S^-$, so the image of $\mathrm{Ad}(u)$ acts on the vector representation with the pattern $u$ had on $S^\pm$, namely $(1^4,(-1)^4)$: it is $\mathrm{Ad}$ of an element $O(8)$-conjugate to $u$, and $u$ commutes with $\mathrm{diag}(-1,1,\dots,1)$, so $O(8)$- and $SO(8)$-conjugacy to $u$ coincide. Hence the class is triality-fixed and $\mathrm{Aut}$-conjugacy to it delivers $SO(8)$-conjugacy. **Sound.** The one step the block leaves out is the $O(8)\to SO(8)$ collapse; it is one line, given above.

The block's control (that the same test detects the dimension-$16$ swap as moving), is consistent with §9a: $\mathrm{diag}(-1_2,1_6)$ has $V$-pattern $(1^6,(-1)^2)$, which no half-spin pattern of a $J$ can match.

**Verdict on the gap.** Real at $n=8$ only; closed there by 9b alone; closed at every even $n\ne8$ by an import (H9) the block never makes.

## 10. Parity, and the boundary of every stated range, CONFIRMED

- **Odd $n\ge5$.** §6 gives $\dim\mathfrak m=n^2/4$, not an integer at odd $n$ (nor is $\dim\mathfrak h=n(n-2)/4$), so no saturating critical point exists. The conclusion is a genuine non-existence theorem and does **not** rest on the record's search of "$92$ at $n=5$". The lemma's naming of $S^{n/2}\times S^{n/2}$ at odd $n$ is vacuous rather than nonsensical, which is the right reading, though [results.md](../results.md)'s landscape line at line 196 asserts the sphere-product conclusion for all $n\ge5$ and only afterwards says odd $n$ is empty, true, but read in the wrong order.
- **$n=3$.** Vacuous, $\mathcal W_3=0$; §4.
- **$n=4$.** §11.
- **$n=5$.** Covered by odd-$n$ non-existence; $\mathfrak{so}(5)$ is simple, so the exclusion is arithmetic, not structural.
- **$n=6$.** $\dim\mathfrak h=6=\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(3))$; $\mathfrak u(3)$ has $\dim 9$; $t^2=0$. Clean.
- **The crossover $n=6+2\sqrt7\approx11.29$.** It does **not** enter L71 and does not threaten it. What it does mean is that for even $n\le10$ the unique saturating point sits at $\theta=\theta_0(n)<\sqrt{3/2}$, below padded $W_{\mathbb{CP}^2}$, so the classified set is not the maximiser set there. The lemma is consistent with this: it classifies and, by its own closing sentence, "serves as no step of a proof of the conjecture". No conflict found.

## 11. $n=4$, the sole exception, CONFIRMED in closed form

The exception is structural, and the witness is exact. With $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2\mathbb R^4$ ([problem.md](../findings/problem.md)):

- $\mathfrak h$ is the $2/\sqrt6$ line inside $\Lambda^2_+$, $\mathfrak m$ the $(-1,-1)$ plane inside $\Lambda^2_+$, $\mathfrak r=\Lambda^2_-\cong\mathfrak{su}(2)_-$ (the kernel). Under the cross-product bracket on $\mathfrak{su}(2)_+$: $[\mathfrak m,\mathfrak m]=\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, and $[\mathfrak m,\mathfrak r]=0$ because the two $\mathfrak{su}(2)$ factors commute. All three relations hold with $\mathfrak r\ne0$, so simplicity is exactly what the argument needs and exactly what $\mathfrak{so}(4)$ lacks.
- It saturates: $\lambda_{\min}+(n-2)\lambda_{\max}=(-1+2\cdot2)/\sqrt6=3/\sqrt6=\sqrt{3/2}=\theta$.
- Saturation is not sign-invariant, as the block says. For $-W_{\mathbb{CP}^2}$: $\theta=-\sqrt{3/2}$ and $\lambda_{\min}+2\lambda_{\max}=(-2+2)/\sqrt6=0$, defect $\sqrt{3/2}=1.224744871$, **the block's figure, exactly.**
- For the balanced $S^2\times S^2$: $\mathfrak h=\mathfrak{so}(2)\oplus\mathfrak{so}(2)$, $r=2$, $W=c(\Pi_{\mathfrak h}-\tfrac13 I)$ with $c=\sqrt3/2$, spectrum $(1/\sqrt3)^{\times2}$ and $(-1/(2\sqrt3))^{\times4}$; $\theta=\lambda_{\min}+2\lambda_{\max}=\sqrt3/2=\theta_0(4)$, and $h/m=2=n/(n-2)$. For $-(S^2\times S^2)$ the defect is $\sqrt3/2=0.866025404$, **again the block's figure, exactly.**
- The criticality reduction is right: with $W^+=\mathrm{diag}(a_1,a_2,a_3)$, $\sum a_i=0$, $W^{\#+}=2\,\mathrm{cof}$, the diagonal of $Q(W)=\theta W$ differenced across $i,j$ gives $(a_i-a_j)(a_i+a_j-2a_k-\theta)=0$, and $a_i+a_j=-a_k$ turns this into $(a_i-a_j)(3a_k+\theta)=0$ as printed. Its solutions are $W^\pm\in\{0,\ \propto(1,1,-2)\}$ with a common $\theta=-3a_1$, giving exactly $\pm S^2\times S^2$ and $\pm W_{\mathbb{CP}^2}$ up to $O(4)$.

**And "$\ker W=0$ for $n\ge5$" is correctly filed as a corollary rather than a strengthening**: $\ker W\subseteq\mathfrak r$ by the convention, so $\mathfrak r=0$ implies it and is strictly stronger; and it is false at $n=4$, where $W_{\mathbb{CP}^2}$ saturates with $\dim\ker W=3$. The deleted-conjecture blockquote is right on both counts.

## 12. Padded objects, CONFIRMED excluded, and analytically

$W_{\mathbb{CP}^2}$ zero-padded into $\Lambda^2\mathbb R^n$ keeps $\lambda_{\min}=-1/\sqrt6$, $\lambda_{\max}=2/\sqrt6$, $\theta=\sqrt{3/2}$, so its L70 defect is $\lambda_{\min}+(n-2)\lambda_{\max}-\theta=(2n-8)/\sqrt6$ and

$$D(v)=\lvert\lambda_{\min}\rvert\cdot\frac{2n-8}{\sqrt6}=\frac1{\sqrt6}\cdot\frac{2(n-4)}{\sqrt6}=\frac{n-4}3 ,$$

**exactly the block's "deficiency $(n-4)/3$"**, zero at $n=4$ and positive at every $n\ge5$. Independently, L70's dimension theorem forces $\dim E_{\max}\ge(n-2)/2$ at a saturating point while padded $W_{\mathbb{CP}^2}$ has $\dim E_{\max}=1$, so it cannot saturate for $n\ge5$ with no computation at all. Two closed-form exclusions where the block offers a measured norm.

## 13. The numbers, which carry weight

The brief asks whether any numerical claim besides the disowned $7\times10^{-16}$ is of the same kind. **Three more are, and the block does not say so.**

| figure | kind |
|---|---|
| $[\mathfrak h,[\mathfrak m,\mathfrak m]]$ off $[\mathfrak m,\mathfrak m]$ at $\le7\times10^{-16}$ | **tautological**, correctly disowned in the block |
| $\dim\mathfrak r=0$ at the saturating points | **tautological**, measured where $\mathfrak r=0$ is the conclusion |
| $[\mathfrak m,\mathfrak m]=\mathfrak h$ exactly, dimensions $6,12,20,30$ at $n=6,8,10,12$ | **tautological**, these are $n(n-2)/4$, the conclusion evaluated |
| $\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$ | **tautological**, restates $\mathfrak r=0$ |
| tori put $82\%$–$89\%$ of $[\mathfrak m,\mathfrak m]$ outside $\mathfrak h$ | genuine control; shows the hypothesis is restrictive, not that the theorem holds |
| padded $W_{\mathbb{CP}^2}$: $\lVert[\mathfrak m,\mathfrak r]\rVert=2.8$, deficiency $(n-4)/3$ | the deficiency is **exact** (§12); the norm is a measurement of something §12 settles in closed form |
| $\sim200$ critical points at $n=4$–$8$, $92$ at $n=5$, none saturating off the family | a finite search, now **superseded** by §4 and §10, the $n=5$ half is a search for objects the lemma proves cannot exist |
| smallest off-family defect $0.866$, and the $n=4$ defects $1.224744871$, $0.866025404$ | the last two are **exact**: $\sqrt{3/2}$ and $\sqrt3/2$, reproduced by hand in §11 |

So the block's "Verified structure at the saturating points" paragraph is, in all four of its entries, the noise of a tautology, the disowning sentence attached to one of them applies to the whole paragraph. The load-bearing numbers in the block are the ones that are closed forms, and every one of those checks.

## 14. The traps, answered by name

- **$\ker W\ne0$ and padded objects.** §1 (kernel indices are excluded from the support because $0>\lambda_{\min}\lambda_{\max}$), §11, §12. No leak.
- **The boundary of every stated range.** §10. $n=3$ vacuous, $n=4$ exceptional and correctly so, $n=5$ and odd $n$ empty by arithmetic, $n=8$ the only place the Cartan gap bites, crossover irrelevant here.
- **A claim proven on a subfamily and used in general.** L70's blockquote proves the equality case *on L23's two-eigenvalue family*, "there $W=\Pi_{\mathfrak h}-\tfrac rNI$, so $E_{\max}=\mathfrak h$…". L71 does **not** inherit that restriction: §1 rederives the three relations from $D(v)=0$ with no two-eigenvalue assumption. Checked and clean.
- **A hypothesis stated but never used.** H11, §6, and it is unproved as well as unused.
- **A step using a hypothesis never stated.** H1 ($\lVert W\rVert=1$), H5 ($\lambda_{\min}<0<\lambda_{\max}$), H9 ($\mathrm{Aut}=\mathrm{Ad}(O(n))$ for $n\ne8$). The two-eigenvalue circularity the brief points at is **not** an instance: §5.
- **A universal claim with no witness.** The converse direction has one, in closed form: at even $n$, $W=c(\Pi_{\mathfrak h}-\tfrac rNI)$ with $\mathfrak h=\mathfrak{so}(n/2)^{\oplus2}$, $r=n(n-2)/4$, gives $h/m=(N-r)/r=n/(n-2)$, $\theta=(n-1)m$ and $\lVert W\rVert=1\Rightarrow m^2=\tfrac{2(n-2)}{n^2(n-1)}$, so $\theta^2=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$ and the saturation equation closes identically. Verified at $n=4$ numerically-free in §11.
- **An imported theorem whose hypotheses were never checked.** §7 and §9. The hypotheses do check; the citations are missing, and one *inference drawn from* the import is false.
- **Symbol collisions.** §0. $\mathfrak h,\mathfrak m,\mathfrak r,E_{\max},E_{\min}$ clean; $\mathfrak g'$ untabled; $t,p,q$ local; the live one is $T$ in the $\dim\mathfrak h$ paragraph.

## 15. One stale label

[results.md](../results.md)'s canonical entry still opens its last third with *"The converse holds: if $D(v)=0$ at a critical unit $W$ then…"*. [L117](../findings/bounds.md)'s own block records that label as wrong, *"the 'converse' label **inverts the dependency**: L117 is an *input* to L71, not its converse"*, and §6 above confirms it: the ratio $(n-2)h=nm$ is consumed by L71's dimension count. The correction lives in one block and not in the other. (Note also that the canonical entry's clause *"$\lVert W\rVert=1$"* appears there, inside the converse sentence, and nowhere in the lemma's own hypotheses, which is where H1 belongs.)

## What would falsify this, and what I did to look for it

**The object.** A critical unit $W\in\mathcal W_n$ at some even $n\ge6$ with $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ whose $E_{\max}$ is not $O(n)$-conjugate to $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$. By §1–§8 such a $W$ would have to supply one of: (i) a nonzero proper ideal of $\mathfrak{so}(n)$, $n\ge5$, impossible; (ii) a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$ with $\dim\mathfrak h=n(n-2)/4$ and $\mathfrak h$ off Cartan's list, impossible if the list is complete; or (iii) at $n=8$ only, **a second $SO(8)$-conjugacy class of involutions with $12$-dimensional fixed algebra**, $\mathrm{Aut}$-conjugate to the balanced one and not $SO(8)$-conjugate to it. Route (iii) is the live one, and it is the only place the lemma is exposed.

**What I did.** I checked (iii) directly by computing the eigenvalue pattern of $\mathrm{diag}(-1_4,1_4)$ on all three eight-dimensional representations of $D_4$ from the weight lattice, by hand, and found it triality-invariant, so no such second class exists and route (iii) is closed. I then tested the block's *other* route for the same conclusion by looking for a pair of inner, determinant-$+1$ involutions of $\mathfrak{so}(8)$ that are $\mathrm{Aut}$-conjugate without being $O(8)$-conjugate, and found one at dimension $16$, printed, as it happens, in the block's own closing clause. I read the involution lists at source in [Etingof](../references/etingof-2024-real-forms-involutions/) §41.4 and the $\mathrm{Out}$ computation in [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/) Prop. 4.43 / Ex. 4.45, and I read [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md), which independently records that no located source states the consequence the block draws. No numerical work was done at any point.

## Verdict

**PROVEN, hypotheses corrected.**

The theorem is true as stated for $n\ge5$ and its proof is sound. The two-eigenvalue conclusion is genuinely derived; $\mathfrak r=0$ enters nowhere upstream of itself; the ideal argument, the dimension count and the $t^2$ forcing all hold; and the $\mathrm{Aut}$-versus-$SO(n)$ gap is real at $n=8$ alone and is closed there. Four corrections are owed before the block reads as a proof:

1. **Delete the determinant route at $n=8$** (§9a) and the phrase "by two independent routes" with it. The inference is a non-sequitur and the block prints its own counterexample two clauses later. The weight route alone carries the conclusion, and needs one added line: $O(8)$-conjugacy to $\mathrm{diag}(-1_4,1_4)$ collapses to $SO(8)$-conjugacy because that element commutes with a reflection.
2. **State H9**, $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ for $n\ne8$, [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/) Ex. 4.45, which is what makes Cartan's relation the consumed one at every even $n$ except $8$, and cite [Etingof](../references/etingof-2024-real-forms-involutions/) or [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) for the involution list itself, which the block currently names and sources to nothing.
3. **Delete H11**, "with $T$'s mass splitting evenly across the support" (§6): unused, unproved, and unnecessary, $\lambda_b+\lambda_c$ is constant on the support, so the expectation is distribution-free.
4. **State H1 and H5** in the lemma's own hypotheses, $\lVert W\rVert=1$, without which L70's identity does not hold and the scalar saturation equation is not scale-invariant, and $\lambda_{\min}<0<\lambda_{\max}$, without which the equality characterisation loses its *only-if*.

Two smaller repairs: the "which the Jacobi identity proves outright" clause (§3) should name the display rather than the relation before it, and [results.md](../results.md)'s "The converse holds" (§15) should be brought into line with L117's own correction.
