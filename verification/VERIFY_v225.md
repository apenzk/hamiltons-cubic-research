# Verification v225, Lemma L39, the two-eigenvalue formula for an arbitrary symmetric pair

Verifier v225, cold reader. The brief [BRIEF_L39.md](BRIEF_L39.md) was read cold, together with [findings/conventions.md](../findings/conventions.md) and the surrounding derivation the block points at. **No numerical work was done: no script, no Sage, no Python, no numeric evaluation.** Every figure below is exact rational or symbolic arithmetic carried by hand on an object constructed for the purpose, and is reported as a screen. Log: [agent_logs/verify-L39-v225.log](../agent_logs/verify-L39-v225.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | The four-invariant form $\theta^2=(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2)^2/(4p^3q(p+q)^3)$ | **PROVEN**, rebuilt from the ansatz; denominator is $a^6$ as claimed |
| 2 | $S_{\mathfrak{kkm}}=0$ from $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k\perp\mathfrak m$ | **PROVEN**, and free of $W$ and of the grading as the annotation says |
| 3 | $S_{\mathfrak{mmm}}=0$ from $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k\perp\mathfrak m$ | **PROVEN**, likewise free |
| 4 | "$[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ … closes the Killing split instead" | **BROKEN**, it closes nothing; it is used nowhere and is a consequence, not a hypothesis |
| 5 | $S_{\mathfrak{kmm}}=cq/2$ by the Killing argument on $\mathfrak m$ | **PROVEN**, and confirmed on three independent families |
| 6 | $S_{\mathfrak{kkk}}=c(p-q/2)$, so the reduction is to three invariants | **PROVEN** |
| 7 | The three-invariant form $\theta^2=(cq(3p-q)-4p(p-q))^2/(16p^3q(p+q))$ | **PROVEN**, the two forms are one expression, the reduction exact |
| 8 | $q\le2p$ for every symmetric pair with $\mathfrak g$ simple | **PROVEN, hypotheses corrected** ($c>0$ used, never stated) |
| 9 | Equality in $q\le2p$ exactly when $\mathfrak k$ is abelian | **PROVEN** |
| 10 | The equal-$\theta$ pair is forced, both members at $(p,q,c)=(7,8,8)$ | **PROVEN**, $\theta^2=9245/8232$ reproduced exactly from $(7,8,8)$ |
| 11 | Maximiser: numerator collapses to $4k^2(k-1)^2(2k-1)$, formula returns $2(n-1)(n-2)/n^2$ exactly | **PROVEN, hypotheses corrected** ($c>0$ and $k\ge3$ both needed for "exactly when") |
| 12 | No admissibility hypothesis; the block copy dropped the guard the canon carries | **GAP, CONFIRMED**; the canonical entry does carry it, this copy does not |
| 13 | Overshoot $1.389084$ against $\Theta_9^2=1.371429$ at $n=9$, and $12.6\%$ at $n=5$ | **PROVEN**, both reproduced in closed form; the pair at $n=9$ is $\mathfrak{so}(4)\oplus\mathfrak{so}(5)$ |
| 14 | $(1,3,3,1)$ are multinomial and hold in the ordered reading; equal under unordered | **PROVEN** |
| 15 | "close **only** in the ordered reading" | **PROVEN, hypotheses corrected**: they close in both, with weights $(6,6,6,6)$ unordered; it is the *stated* weights that are ordered-only |
| 16 | L114's $6/4/2$ is "the unordered form of the same statement" | **PROVEN, hypotheses corrected**: L114 is one row; the $(1,3,3,1)$ identity is L114 **plus its twin** |
| 17 | "$S_{XYZ}$ is defined nowhere on the record, [conventions.md](../findings/conventions.md) included" | **BROKEN, stale by 51 seconds**; conventions.md line 20 defines it |
| 18 | Table row: $h^\vee(\mathfrak{so}(m))=m-2$, $I_\rho=2$ fails at $m=3$ and $m=4$ | **PROVEN** |
| 19 | The product $c=m-2$ survives at $m=3,4$ by a doubling argument; no value moves | **PROVEN**, and the defect is wider than recorded: row 1 breaks the same way at $n=3$ |

**One line.** Both closed forms are correct and are one expression read under one extra hypothesis; the reduction through $S_{\mathfrak{kmm}}=cq/2$ is sound and triply confirmed; the corollaries, the maximiser collapse and both overshoot figures all reproduce exactly; what fails is prose around the mathematics, one annotation clause is false, one is stale, two unstated hypotheses are load-bearing, and this copy of the block is missing the Weyl-ness guard that [results.md](../results.md) carries.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), never restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$", with $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$.
- $\#$: "the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric**, the inner product being ad-invariant; so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide."
- $S_{XYZ}$: "**the block-restricted contraction of $T$ over ORDERED slots**, the reading adopted 2026-09-04 … conversion is **per pattern**, $S^{\mathrm{ord}}=6S^{\mathrm{unord}}$ on $\mathfrak{mmm}$ and $\mathfrak{hhh}$, $2\times$ on the mixed patterns, *not a global constant.*"
- Killing constant of a subalgebra: "$\mathfrak g$ simple: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$, with $c=2h^\vee(\mathfrak g)/I_\rho$ and $I$ normalised so the $\mathfrak{so}(n)$ vector representation has index $1$."
- The row marginal, [Lemma L153](../findings/bounds.md): "$\sum_\beta\lVert[v,v_\beta]\rVert^2=2(n-2)\lVert v\rVert^2$ for any $v\in\mathfrak{so}(n)$ at any $n\ge2$."
- The Killing form of $\mathfrak{so}(n)$: "$B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$, with $\mathop{\mathrm{tr}}(v^2)=-2$ for a unit bivector".
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$; "at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$, the gap being $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))$".
- Symbol collisions in force here: "$\mathfrak m$ carries three incompatible senses across the record, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part". **L39 uses the third sense throughout; L114 uses the second.** $c$ likewise collides with [L44](../findings/problem.md)'s pinned constant and with [L17](../findings/route-a.md)'s $\kappa_n$ neighbourhood; L39 uses the Killing sense.

## 1. Hypothesis inventory

A pass with no inventory is not a pass. Twelve hypotheses are in play; three are unstated and load-bearing, one is stated and never used, one is missing entirely.

| # | hypothesis | status in the block | where used |
| --- | --- | --- | --- |
| H1 | $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, and $\mathfrak m=\mathfrak k^\perp$ inside $\mathfrak g$ | stated | $S_{\mathfrak{kkm}}=0$; and it is the *only* symmetric-pair input the Killing split needs |
| H2 | $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ | stated | $S_{\mathfrak{mmm}}=0$ |
| H3 | $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ | stated | **nowhere**, see §4 |
| H4 | $\mathfrak g\subseteq\mathfrak{so}(n)$, inner product restricted and ad-invariant | stated | total antisymmetry of $c_{abc}$, hence total symmetry of $T$, hence the multinomial weights |
| H5 | $W=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ with $ap+bq=0$, $a^2p+b^2q=1$ | stated | definitional |
| H6 | $\mathfrak g$ simple | stated for the reduction | **only** place: a single $c$ serving both $\mathfrak k$ and $\mathfrak m$ |
| H7 | $c>0$ | **UNSTATED** | $q\le2p$; and the word "exactly" in the maximiser's $c=4(k-1)$ |
| H8 | $p>0$ and $q>0$ | **UNSTATED** | the denominator $4p^3q(p+q)^3$ |
| H9 | $T$ hollow | not cited here | the ordered↔unordered conversion only; the ordered statement does not need it |
| H10 | the ordered-slot reading of $S_{XYZ}$ | **not cited** (the annotation asserts it is undefined) | the coefficients $(1,3,3,1)$ |
| H11 | sign of $\theta$ | not stated | the ansatz fixes $\theta$ only up to sign; conventions' "normalise $W$ to $\theta>0$" supplies it |
| H12 | $W\in\mathcal W_n$, first Bianchi and Ricci-flatness | **MISSING from this copy**; present in [results.md](../results.md) | nothing in the derivation; everything in the interpretation |

H7 and H8 are free to repair: $c\lVert a\rVert^2=\sum_b\lVert[a,b]\rVert^2\ge0$ with equality only for $a$ central, and a simple non-abelian $\mathfrak g$ has no centre, so $c>0$ follows; $p=0$ forces $\mathfrak g=\mathfrak m$ abelian, contradicting H6, and $q=0$ makes the pair trivial. H3 should be demoted from hypothesis to consequence. H10 is now supplied by conventions.md. H12 is the one real hole.

## 2. The four-invariant formula, rebuilt from the ansatz

Write $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ in an orthonormal basis of $\mathfrak{so}(n)$ adapted to $\mathfrak k\oplus\mathfrak m\oplus\mathfrak g^\perp$, with $\lambda=a$ on $\mathfrak k$, $b$ on $\mathfrak m$, $0$ on $\mathfrak g^\perp$. From the halved Böhm–Wilking product,
$$W^\#=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T},\qquad \langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\,T_{\alpha\beta\gamma},$$
the last sum over ordered triples. **This is where the ordered reading enters, and where the $\tfrac12$ comes from.** Splitting the ordered sum by which block each of the three slots sits in, and using that $T$ is totally symmetric so all placements of a repeated pattern agree, gives the four terms with multinomial weights
$$\langle W,W^\#\rangle=\tfrac12\big[a^3S_{\mathfrak{kkk}}+3a^2b\,S_{\mathfrak{kkm}}+3ab^2S_{\mathfrak{kmm}}+b^3S_{\mathfrak{mmm}}\big].$$
The annotation's "the coefficient $3$ is the multinomial weight on the odd index's three slot placements" is exactly this, and it is right.

With H2 and H1 the middle-outer pair drops. Then $\mathop{\mathrm{tr}}(W^3)=a^3p+b^3q$, and eliminating $b=-ap/q$ and $a^2=q/(p(p+q))$:
$$\mathop{\mathrm{tr}}(W^3)=a^3p\frac{q^2-p^2}{q^2},\qquad ab^2=a^3\frac{p^2}{q^2},$$
$$\theta=P(W)=\frac{a^3}{2q^2}\Big[S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\Big].$$
Squaring and substituting $a^6=q^3/\big(p^3(p+q)^3\big)$:
$$\theta^2=\frac{q^3}{4q^4\,p^3(p+q)^3}\big[\cdots\big]^2=\frac{\big(S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2\big)^2}{4p^3q(p+q)^3}.$$
**The denominator is produced by $a^6$, exactly as the annotation says, not asserted.** Claim 1: PROVEN.

**The $\ker W$ trap, answered.** When $\mathfrak g\subsetneq\mathfrak{so}(n)$, $\ker W\supseteq\mathfrak g^\perp$ has dimension $\binom n2-p-q>0$, so this is a padded object at every proper subalgebra. It is harmless here and I checked why: the kernel contributes nothing to $\mathop{\mathrm{tr}}W$, to $\lVert W\rVert^2$, to $\mathop{\mathrm{tr}}(W^3)$, or to the ordered triple sum, since every surviving term carries at least one factor $\lambda_\alpha$. The derivation is therefore *not* a claim about $\mathfrak{so}(n)$ restricted to $\mathfrak g$; it is a claim about the padded operator, and the padding is exact. What the kernel does break is H12, see §7.

## 3. Both vanishings, and what each really needs

$S_{\mathfrak{kkm}}=\sum_{\alpha,\beta\in\mathfrak k,\ \gamma\in\mathfrak m}\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. Every bracket lies in $\mathfrak k$ by H1 and every $v_\gamma$ in $\mathfrak m=\mathfrak k^\perp$, so every summand vanishes. Symmetrically $S_{\mathfrak{mmm}}=0$ by H2. Neither argument mentions $W$, $a$, $b$, the grading, or criticality: they are statements about the pair of subspaces. **The annotation's "properties of the decomposition, independent of $W$ and of the two-eigenvalue point" is correct, and "identically" does indeed understate it**, the vanishings hold before any operator is placed on the algebra at all. Claims 2 and 3: PROVEN.

## 4. DISCREPANCY, "$[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ … closes the Killing split instead" is false

All three legs of the protocol cleared.

**Locate.** [findings/target.md](../findings/target.md) line 659, final clause of the first annotation: *"The third relation $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is used in neither; it closes the Killing split instead."*

**Exhibit.** The Killing split, in full. For $\alpha\in\mathfrak k$, H6 gives $\sum_{\beta\in\mathfrak g}\lVert[v_\alpha,v_\beta]\rVert^2=c$, and $\lVert[v_\alpha,v_\beta]\rVert^2=\sum_{\gamma\in\mathfrak g}T_{\alpha\beta\gamma}$ since $\mathfrak g$ is a subalgebra. Summing over $\alpha\in\mathfrak k$ and decomposing $(\beta,\gamma)$ over the four block patterns,
$$cp=S_{\mathfrak{kkk}}+2S_{\mathfrak{kkm}}+S_{\mathfrak{kmm}}=S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}.$$
The decomposition of $\sum_{\beta,\gamma\in\mathfrak g}$ into four patterns is exhaustive because $\mathfrak g=\mathfrak k\oplus\mathfrak m$ as vector spaces, and the middle term drops by §3, which is H1. **$[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ appears nowhere.** The $\mathfrak m$-row split of §5 is the same: it uses $S_{\mathfrak{kkm}}=0$ and $S_{\mathfrak{mmm}}=0$ and nothing else.

**Argue the opposite.** Three routes by which H3 might still be load-bearing, each closed:
1. *"It is needed for $c$ to be the same constant on $\mathfrak k$ and on $\mathfrak m$."* No. That is H6: on a simple $\mathfrak g$ any two invariant symmetric bilinear forms are proportional, so $-B=c\langle\cdot,\cdot\rangle$ on all of $\mathfrak g$ with one $c$. The form being compared is ad-$\mathfrak g$-invariant, which is stronger than ad-$\mathfrak k$-invariant.
2. *"It is needed for $\mathfrak m$ to be well defined."* No. $\mathfrak m=\mathfrak k^\perp\cap\mathfrak g$ exists for any subspace.
3. *"It is needed for the decomposition to be symmetric, for the involution $\sigma=+1|_{\mathfrak k}$, $-1|_{\mathfrak m}$ to be an automorphism."* True of the *definition*, but the derivation never invokes $\sigma$. And H3 is not independent: ad-invariance of $\langle\cdot,\cdot\rangle$ plus H1 gives $\langle[\mathfrak k,\mathfrak m],\mathfrak k\rangle=\langle\mathfrak m,[\mathfrak k,\mathfrak k]\rangle\subseteq\langle\mathfrak m,\mathfrak k\rangle=0$, so $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ **follows**. It is a consequence of the other hypotheses, not a third hypothesis.

**Verdict.** The clause is BROKEN. The correct sentence is that $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is used nowhere in L39 and is in any case implied by $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ together with ad-invariance. This is the *hypothesis stated but never used* trap, firing inside an annotation whose whole purpose was to audit which hypotheses are used.

## 5. $S_{\mathfrak{kmm}}=cq/2$, the step the brief singles out

Run H6 on the $\mathfrak m$ row. For $\alpha\in\mathfrak m$, $\sum_{\beta,\gamma\in\mathfrak g}T_{\alpha\beta\gamma}=c$; summing over $\alpha\in\mathfrak m$ and splitting the four patterns,
$$cq=\underbrace{S_{\mathfrak{kkm}}}_{(\mathfrak m,\mathfrak k,\mathfrak k)}+\underbrace{2S_{\mathfrak{kmm}}}_{(\mathfrak m,\mathfrak k,\mathfrak m)+(\mathfrak m,\mathfrak m,\mathfrak k)}+\underbrace{S_{\mathfrak{mmm}}}_{(\mathfrak m,\mathfrak m,\mathfrak m)}=2S_{\mathfrak{kmm}},$$
using both vanishings and the total symmetry of $T$ (H4) to identify the two mixed placements. Hence $S_{\mathfrak{kmm}}=cq/2$, and with §4's row identity $S_{\mathfrak{kkk}}=cp-cq/2=c(p-q/2)$. **This is what makes $S_{\mathfrak{kkk}}$ determined rather than free, and it is correct.** It uses H6 and nothing about $\mathfrak k$, in particular it survives a centre in $\mathfrak k$ untouched.

**Three independent confirmations, all exact and all against numbers already on the record.**

| pair | record's $S_{\mathfrak{kkk}}$ | $c(p-q/2)$ | agree |
| --- | --- | --- | --- |
| $(\mathfrak{su}(m),\mathfrak{so}(m))$, $p=\binom m2$, $q=\tfrac{(m+2)(m-1)}2$, $c=2m$ | $(m-2)p$ | $2m\cdot\tfrac{m-1}4\big[2m-(m+2)\big]=\tfrac{m(m-1)(m-2)}2=(m-2)\binom m2$ | ✓ symbolically in $m$ |
| $(\mathfrak{so}(6),\mathfrak u(3))$, $p=9$, $q=6$, $c=8$ | $48$ (record: $S_{\mathfrak{kkk}}/p=48/9$) | $8(9-3)=48$ | ✓, and $\mathfrak k$ here has a centre |
| $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$, $p=7$, $q=8$, $c=8$ | $24$ | $8(7-4)=24$ | ✓ |

The middle row is the sharpest: $\mathfrak u(3)$ is exactly the case the record flagged as breaking $S_{\mathfrak{kkk}}=c_{\mathfrak k}p$, and the $\mathfrak m$-Killing route reproduces the recorded $48$ with no reference to $\mathfrak k$'s ideals at all. Likewise $S_{\mathfrak{kmm}}=cq/2$ gives $mq$ for $(\mathfrak{su}(m),\mathfrak{so}(m))$, matching the record's $(m+2)p=mq$, and $32$ for the $(7,8)$ pair, matching. Claims 5 and 6: PROVEN.

**A by-product the record should hold.** Since $S_{\mathfrak{kkk}}=\sum_i c_i\dim\mathfrak k_i$ over the simple ideals of $\mathfrak k$ is also true, the two expressions give a non-trivial identity for every symmetric pair with $\mathfrak g$ simple: $\sum_i c_i\dim\mathfrak k_i=c(p-q/2)$. It is verified above in three cases and is a free consistency check on any future table row.

## 6. The two formulas are one expression, the reduction, in full

Substitute $S_{\mathfrak{kkk}}=c(p-q/2)$ and $S_{\mathfrak{kmm}}=cq/2$ into the four-invariant numerator bracket:
$$c\big(p-\tfrac q2\big)q^2+3\cdot\tfrac{cq}2\cdot p^2-2p^3+2pq^2=\tfrac{cq}2\big(2pq-q^2+3p^2\big)-2p\big(p^2-q^2\big).$$
Now $3p^2+2pq-q^2=(3p-q)(p+q)$ and $p^2-q^2=(p-q)(p+q)$, so **$(p+q)$ factors out of the whole bracket**:
$$\big[\cdots\big]=\frac{p+q}{2}\Big[cq(3p-q)-4p(p-q)\Big].$$
Squaring and dividing by $4p^3q(p+q)^3$ cancels $(p+q)^2$ against $(p+q)^3$ and the $\tfrac14$ against the $4$:
$$\theta^2=\frac{(p+q)^2\big[cq(3p-q)-4p(p-q)\big]^2/4}{4p^3q(p+q)^3}=\frac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3q(p+q)}.$$
**The second reduces to the first exactly, and the annotation's form is right to the last digit.** Claim 7: PROVEN.

**Under what hypotheses.** The reduction consumes H6 and only H6. The four-invariant form needs H1, H2, H4, H5 and holds for $\mathfrak g$ merely reductive; the three-invariant form additionally needs $\mathfrak g$ simple, without which there is no single $c$, the record's own $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ witness, where $c\in\{2,6\}$, is exactly this boundary.

**Which should be canonical.** Both, in that order, and the canonical entry currently gets the second half wrong. The four-invariant display should stay as the general statement. What follows it in [results.md](../results.md) (*"so $\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone"*), is stated under "when $\mathfrak g$ is simple", and under that hypothesis $S_{\mathfrak{kkk}}$ is **not** an independent invariant: it is $c(p-q/2)$. The entry therefore lists four invariants where its own hypothesis leaves three, and should be replaced by the closed three-invariant display. That is not an error of fact (a function of four arguments one of which is redundant is still correct) but it hides the three corollaries of §§8–9, each of which is visible only once $\theta^2$ is seen as a function of $(p,q,c)$.

**A second consequence of the same clause.** With $S_{\mathfrak{kkk}}$ determined, the entry's *"when $\mathfrak k$ has a centre, $S_{\mathfrak{kkk}}$ is the sum over its simple ideals"* stops being a needed rule and becomes the consistency check noted at the end of §5. Retaining it is fine; presenting it as the way to obtain $S_{\mathfrak{kkk}}$ is now misleading.

## 7. GAP, admissibility, and what hypothesis the formula needs to be about Weyl tensors at all

**The block copy does drop the guard.** [results.md](../results.md) lines 525-531 carry it in terms: *"The formula gives the value of the point and decides nothing about whether that point is a Weyl tensor: Weyl-ness is a property of the embedding $\rho$…"*. [findings/target.md](../findings/target.md)'s block prose carries no such sentence, the only mention is the annotation flagging its absence. Claim 12: the annotation is CONFIRMED.

**The hypothesis the formula needs.** The ansatz H5 imposes exactly two conditions: $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$ and $\lVert W\rVert=1$. Membership in $\mathcal W_n$ needs three more, none of them implied:

1. **First Bianchi**, $W$ must annihilate the $\Lambda^4$ summand of $\mathrm{Sym}^2(\Lambda^2)$.
2. **Ricci-flatness**, $\mathrm{Ric}(W)=0$ as a symmetric $n\times n$ matrix, which is strictly stronger than $\mathop{\mathrm{tr}}_{\Lambda^2}W=0$; the trace condition is one scalar, Ricci-flatness is $\binom{n+1}2$ of them.
3. **Criticality**, if the interpretation is to be "a critical value" rather than "a value", $Q(W)=\theta W$, which the derivation never touches.

$P$ is defined on all of $\mathrm{Sym}^2(\Lambda^2)$, so the *number* the formula returns is always a real number; what it is not is a value of $\theta$ on $\mathcal W_n$. The record's own census settles the scale of the gap: **of 16 pairs, three pass**, $(\mathfrak{su}(m),\mathfrak{so}(m))$, $(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$, $(\mathfrak{su}(2),\mathfrak{so}(2))$. So the honest scope sentence is: *the formula computes $P(W)/\lVert W\rVert^3$ for the two-eigenvalue graded operator of the pair; it is a value of $\theta$ on $\mathcal W_n$ only when that operator satisfies first Bianchi and $\mathrm{Ric}=0$, which fails for most pairs.*

**The overshoot, reproduced in closed form.** I built the objects the annotation names and did the arithmetic by hand; this is reported as a screen.

*At $n=9$.* $\mathfrak g=\mathfrak{so}(9)$, $c=2(n-2)=14$; $\mathfrak k=\mathfrak{so}(4)\oplus\mathfrak{so}(5)$, so $p=6+10=16$, $q=20$, $p+q=36$. Then $3p-q=28$, $p-q=-4$, and
$$cq(3p-q)-4p(p-q)=14\cdot20\cdot28+4\cdot16\cdot4=7840+256=8096=2^5\cdot11\cdot23,$$
$$\theta^2=\frac{8096^2}{16\cdot16^3\cdot20\cdot36}=\frac{2^{10}\cdot11^2\cdot23^2}{16^4\cdot720}=\frac{64009}{46080}=1.3890842\ldots$$
*Against $\Theta_9^2$.* From conventions, $\theta_0(9)^2=\tfrac{2\cdot8\cdot7}{81}=\tfrac{112}{81}$ and the odd-$n$ gap is $\tfrac{8\cdot8}{81\cdot10\cdot7}=\tfrac{64}{5670}$, so
$$\Theta_9^2=\frac{7840-64}{5670}=\frac{7776}{5670}=\frac{48}{35}=1.3714285\ldots$$
*The comparison, by cross-multiplication so no division is taken:* $64009\cdot35=2\,240\,315$ against $48\cdot46080=2\,211\,840$. **The first is larger, so $\theta^2>\Theta_9^2$ strictly**, by $28475/1612800=0.0176556\ldots$, the annotation's $1.389084$ against $1.371429$ exactly.

*At $n=5$.* $c=6$, $\mathfrak k=\mathfrak{so}(2)\oplus\mathfrak{so}(3)$, $p=4$, $q=6$, $p+q=10$; $3p-q=6$, $p-q=-2$; bracket $=6\cdot6\cdot6+4\cdot4\cdot2=216+32=248$; $\theta^2=248^2/(16\cdot64\cdot6\cdot10)=61504/61440=961/960$. And $\Theta_5^2=\tfrac{24}{25}-\tfrac{32}{450}=\tfrac{8}{9}$. Ratio $\tfrac{961}{960}\cdot\tfrac98=\tfrac{2883}{2560}=1.12617\ldots$, **the annotation's $12.6\%$, and it is an excess on $\theta^2$, not on $\theta$** (on $\theta$ it is $6.1\%$). The annotation's wording "overshoots the true $\theta$ … by $12.6\%$" should read $\theta^2$; a wording defect, not a numerical one.

**Why the overshoot is inevitable, and why it is not a counterexample to anything.** Both witnesses are $\mathfrak k=\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ with $a\ne b$, which the record's own census lists as failing Ricci-flatness. So the operator is not in $\mathcal W_n$ and the number is not a $\theta$. **This is the same fact as the maximiser annotation's "at odd $n$ the maximiser is an unbalanced pair, which this formula cannot reach"**, the two annotations state one phenomenon twice, from opposite sides, and they agree.

## 8. The corollaries

**$q\le2p$.** $S_{\mathfrak{kkk}}=\sum c_{\alpha\beta\gamma}^2\ge0$ and $S_{\mathfrak{kkk}}=c(p-q/2)$, so with $c>0$ (H7) we get $p-q/2\ge0$. **PROVEN, with H7 supplied.** If $c$ were permitted to be $\le0$ the inequality reverses or degenerates, so H7 is genuinely load-bearing and genuinely absent from the annotation.

**Equality exactly when $\mathfrak k$ is abelian.** $q=2p\iff S_{\mathfrak{kkk}}=0\iff c_{\alpha\beta\gamma}=0$ for all $\alpha,\beta,\gamma\in\mathfrak k\iff[\mathfrak k,\mathfrak k]\perp\mathfrak k$. By H1 the bracket already lies in $\mathfrak k$, so this forces $[\mathfrak k,\mathfrak k]=0$. **Both directions, PROVEN**, and H1 is what makes the "$\perp$" upgrade to "$=0$", worth stating, since without $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ the vanishing of $S_{\mathfrak{kkk}}$ would say only that $[\mathfrak k,\mathfrak k]$ is orthogonal to $\mathfrak k$.

*Boundary witnesses, all exact.* $(\mathfrak{su}(2),\mathfrak u(1))$: $p=1$, $q=2=2p$, $\mathfrak k$ abelian ✓. $(\mathfrak{so}(3),\mathfrak{so}(2))$: $p=1$, $q=2=2p$ ✓. $(\mathfrak{su}(m),\mathfrak{so}(m))$: $q\le2p\iff(m+2)(m-1)/2\le m(m-1)\iff m\ge2$, equality at $m=2$ where $\mathfrak{so}(2)$ is abelian ✓. $(\mathfrak{so}(2k),\mathfrak{so}(k)^{\oplus2})$: $k^2\le2k^2-2k\iff k\ge2$, equality at $k=2$ where $\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ is abelian ✓.

*The $\mathfrak g$-not-simple boundary, where it fails.* $\mathfrak g=\mathfrak{so}(2)$, $\mathfrak k=0$: $p=0$, $q=1>0=2p$. The inequality is **false** here, and what excludes it is H6, a clean demonstration that "for every symmetric pair with $\mathfrak g$ simple" is not a decorative hypothesis. It is also excluded by H8.

**The equal-$\theta$ pair is forced.** With $\theta^2$ a function of $(p,q,c)$ alone, two pairs sharing $(p,q,c)$ share $\theta$, a one-line consequence, and a real upgrade on the four-invariant reading, where the record had to observe *"identical $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})=(7,8,24,32)$"* as a coincidence. The witnesses are $(\mathfrak{so}(6),\mathfrak{so}(2)\oplus\mathfrak{so}(4))$ and $(\mathfrak{su}(4),\mathfrak s(\mathfrak u(2)\oplus\mathfrak u(2)))$, and $(p,q,c)=(7,8,8)$ for both, $c=2(6-2)=8$ for $\mathfrak{so}(6)$ and $c=2m=8$ for $\mathfrak{su}(4)$, consistent because $\mathfrak{su}(4)\cong\mathfrak{so}(6)$. **The value reproduces exactly**: bracket $=8\cdot8\cdot(21-8)+4\cdot7=832+28=860$, and
$$\theta^2=\frac{860^2}{16\cdot343\cdot8\cdot15}=\frac{739600}{658560}=\frac{9245}{8232},$$
the record's own figure. **PROVEN.** One caveat on the word "forced": the implication runs one way. Equal $(p,q,c)$ forces equal $\theta$; equal $\theta$ does not force equal $(p,q,c)$, since $\theta^2$ is a square and far from injective. The annotation claims only the forward direction, and is right.

## 9. The maximiser

$(\mathfrak{so}(2k),\mathfrak{so}(k)\oplus\mathfrak{so}(k))$, $n=2k$, $p=k(k-1)$, $q=k^2$, $p+q=k(2k-1)$, $3p-q=k(2k-3)$, $p-q=-k$. The bracket is
$$cq(3p-q)-4p(p-q)=ck^3(2k-3)+4k^2(k-1).$$
At $c=4(k-1)$ this factors: $4k^2(k-1)\big[k(2k-3)+1\big]=4k^2(k-1)(2k-1)(k-1)=\mathbf{4k^2(k-1)^2(2k-1)}$, **the annotation's collapse, exactly.** Then
$$\theta^2=\frac{16k^4(k-1)^4(2k-1)^2}{16\cdot k^3(k-1)^3\cdot k^2\cdot k(2k-1)}=\frac{(k-1)(2k-1)}{k^2},$$
and with $n=2k$, $\ \dfrac{2(n-1)(n-2)}{n^2}=\dfrac{2(2k-1)(2k-2)}{4k^2}=\dfrac{(k-1)(2k-1)}{k^2}$. **Identical. PROVEN, exactly, symbolically in $k$, with no division taken until the final cancellation of common factors.**

**$c=4(k-1)$ is right and the normalisation claim stands.** $\mathfrak g=\mathfrak{so}(2k)$ in its standard rep on $\mathbb R^{2k}$ has $c=2(n-2)=4(k-1)$ by [Lemma L153](../findings/bounds.md), and $2h^\vee(\mathfrak{so}(2k))=2(2k-2)=4(k-1)$, so $I_\rho=1$. The annotation's *"the maximiser decides the $I_\rho$ normalisation rather than table data doing it"* is a fair reading: the value $2(n-1)(n-2)/n^2$ is independently known, and matching it pins $c$.

**Two hypotheses the word "exactly" needs.** (i) $\theta^2$ is a *square* of a linear function of $c$, so $\theta^2=v$ has two roots in $c$. The second root solves $ck(2k-3)=-4(k-1)\big[1+(k-1)(2k-1)\big]$ and is **negative** for $k\ge2$; it is excluded only by H7, $c>0$, which is nowhere stated. (ii) $\mathfrak g=\mathfrak{so}(2k)$ is simple only for $k\ge3$. At $k=2$, $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ is not simple and H6 fails; the formula happens to survive because the two ideals are isomorphic and carry the same constant $c=2(4-2)=4=4(k-1)$, giving $\theta^2=3/4=2\cdot3\cdot2/16$ ✓, but this is luck, not scope. **The claim "the maximiser is in scope" is right for $k\ge3$, i.e. $n\ge6$, and needs that restriction written down.**

*The $k=2$ member is also the equality case of §8*: $p=2$, $q=4=2p$, $\mathfrak k=\mathfrak{so}(2)\oplus\mathfrak{so}(2)$ abelian. The two boundaries coincide, which is a useful cross-check and is recorded nowhere.

**"Simplicity was aimed one level too low."** Correct as stated: H6 constrains $\mathfrak g=\mathfrak{so}(2k)$, not $\mathfrak k$; $\mathfrak k=\mathfrak{so}(k)\oplus\mathfrak{so}(k)$ is free to be non-simple, and indeed also free to have a centre, since §5 shows the reduction never looks at $\mathfrak k$.

## 10. The convention, and the $(1,3,3,1)$ weights

**The weights are multinomial and hold in the ordered reading.** §2 derives them: the ordered triple sum splits into four patterns, and the two mixed patterns each admit three slot placements, all equal by total symmetry of $T$. ✓

**"Close only in the ordered reading", imprecise.** Under the unordered reading the same sum closes with weights $(6,6,6,6)$: $S^{\mathrm{ord}}_{\mathfrak{kkk}}=6S^{\mathrm u}$ while $3S^{\mathrm{ord}}_{\mathfrak{kkm}}=3\cdot2S^{\mathrm u}=6S^{\mathrm u}$, and likewise for the other two. So the expansion closes in **both** readings; what is ordered-only is the *displayed* coefficient vector $(1,3,3,1)$. The annotation's own next sentence (*"under the unordered reading L39's two coefficients become equal"*), says exactly this and is **correct**; it is the word "only" one clause earlier that overreaches. Claims 14 and 15.

**"L114's $6/4/2$ is the unordered form of the same statement", half right, and the record itself supplies the correction.** Convert L114 per pattern: $6S^{\mathrm u}_{\mathfrak{mmm}}=S^{\mathrm{ord}}_{\mathfrak{mmm}}$, $4S^{\mathrm u}_{\mathfrak{mmh}}=2S^{\mathrm{ord}}_{\mathfrak{mmh}}$, $2S^{\mathrm u}_{\mathfrak{mhh}}=S^{\mathrm{ord}}_{\mathfrak{mhh}}$, so [Lemma L114](../findings/bounds-relaxations.md) reads
$$S^{\mathrm{ord}}_{\mathfrak{mmm}}+2S^{\mathrm{ord}}_{\mathfrak{mmh}}+S^{\mathrm{ord}}_{\mathfrak{mhh}}=2d(n-2),$$
which is **precisely §5's Killing row-sum $cd$ at $\mathfrak g=\mathfrak{so}(n)$, where $c=2(n-2)$.** So L114 and L39's Killing split are one identity, a real and unrecorded connection, worth a cross-reference both ways. But L114 is **one row**. Weights $(1,2,1)$, over three patterns. L39's $(1,3,3,1)$, over four, is the *sum* of L114 and its $\mathfrak h$-row twin:
$$\big[S^{\mathrm{ord}}_{\mathfrak{mmm}}+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}\big]+\big[S_{\mathfrak{hhh}}+2S_{\mathfrak{mhh}}+S_{\mathfrak{mmh}}\big]=S_{\mathfrak{mmm}}+3S_{\mathfrak{mmh}}+3S_{\mathfrak{mhh}}+S_{\mathfrak{hhh}}=c\binom n2,$$
which is what [bounds-relaxations.md](../findings/bounds-relaxations.md)'s own last annotation calls *"[nondegeneracy.md](../findings/nondegeneracy.md)'s $1/3/3/1$ identity"*. **So the annotation identifies L114 with the wrong half.** And there is a second slippage: L39's $(1,3,3,1)$ are the coefficients of the **$P(W)$ expansion**, whereas the $1/3/3/1$ identity is a **Killing total-sum**. The coefficient vectors coincide because both are the multinomial weights of the same four patterns, but they are different statements. Claim 16: the substance survives, the identification does not.

**DISCREPANCY, "$S_{XYZ}$ is defined nowhere on the record, [conventions.md](../findings/conventions.md) included" is now false.** All three legs cleared. *Locate*: [findings/target.md](../findings/target.md) line 669, final sentence. *Exhibit*: [conventions.md](../findings/conventions.md) line 20 is a table row for $S_{XYZ}$ giving it as "the block-restricted contraction of $T$ over ORDERED slots", with the per-pattern conversion law; together with line 60's $T_{abc}=c_{abc}^2$ that is a definition sufficient to reconstruct every display in §2. *Argue the opposite*: could the annotation be true at the time of writing? Yes, `git` puts the annotation at `cf5aa8a1`, 2026-09-04 21:56:05, and the conventions row at `6f27283d`, 2026-09-04 21:56:56, **fifty-one seconds later**. So the sentence was accurate when written and is stale now. **Verdict: BROKEN as a present-tense claim, and the repair is to strike it and cite the convention instead**, which is exactly what the block needs anyway, since H10 is otherwise uncited.

## 11. The table's two columns

The row at issue: $\mathfrak{so}(m)\subset\mathfrak{su}(m)$ on $\mathbb R^m\oplus\mathbb R^m$, with $h^\vee=m-2$, $I_\rho=2$, $c=m-2$.

**The column data fails at $m=3$ and $m=4$, as recorded.** $h^\vee(\mathfrak{so}(m))=m-2$ holds for $B_r$ ($m\ge5$ odd) and $D_r$ ($m\ge6$ even). At $m=3$, $\mathfrak{so}(3)=A_1$ and $h^\vee=2$, against the column's $m-2=1$. At $m=4$, $\mathfrak{so}(4)=A_1\oplus A_1$ is not simple and $h^\vee$ is undefined. ✓ Claim 18: PROVEN.

**The doubling argument, checked.** $c$ is a ratio of two things: $-B(a,a)=-\mathop{\mathrm{tr}}(\mathrm{ad}\,a)^2$, which is intrinsic to $\mathfrak{so}(m)$ and blind to the representation, and $\langle a,a\rangle$, which is the ambient norm and is not. Under conventions' $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$, an element acting on $\mathbb R^m\oplus\mathbb R^m$ as $a\oplus a$ has $\mathop{\mathrm{tr}}_{\mathbb R^{2m}}\big((a\oplus a)^2\big)=2\mathop{\mathrm{tr}}_{\mathbb R^m}(a^2)$, so $\langle a,a\rangle_{\mathfrak{so}(2m)}=2\langle a,a\rangle_{\mathfrak{so}(m)}$ and therefore
$$c_{\text{row}}=\tfrac12\,c_{\mathfrak{so}(m)\ \text{standard}}=\tfrac12\cdot2(m-2)=m-2.$$
The input $c_{\mathfrak{so}(m)}=2(m-2)$ is [Lemma L153](../findings/bounds.md), stated on the record "for any $v\in\mathfrak{so}(n)$ at any $n\ge2$", **so it is available at $m=3$ and $m=4$, where $h^\vee$ is not.** I checked L153 by hand at $m=3$ on the basis $e_1\wedge e_2,\,e_2\wedge e_3,\,e_1\wedge e_3$: $[e_1\wedge e_2,e_2\wedge e_3]=e_1\wedge e_3$ of unit norm, $[e_1\wedge e_2,e_1\wedge e_3]$ likewise, $[e_1\wedge e_2,e_1\wedge e_2]=0$, total $2=2(3-2)$ ✓. Hence $c=1=m-2$ at $m=3$ and $c=2=m-2$ at $m=4$. **No value in the table moves.** Claim 19: PROVEN.

**The defect is wider than recorded, and this is a new finding.** Row **1** of the same table ($\mathfrak{so}(n)$ standard, $h^\vee=n-2$, $I_\rho=1$, $c=2(n-2)$), breaks the same way at $n=3$. There $h^\vee(\mathfrak{so}(3))=2$ and the stated $I_\rho=1$ would give $c=4$, whereas the true value is $2$: the vector rep of $\mathfrak{so}(3)$ *is* the adjoint of $A_1$, and this file's own line 351 records that "every adjoint rep gives $2$ identically". So the correct $I_\rho$ for $\mathfrak{so}(3)$'s vector rep is $2$, not $1$, in the record's normalisation. **The product $c=2(n-2)$ is again right at $n=3$; the factorisation again is not.** The general lesson the table should carry: *the column $c$ is the theorem, via L153 and the doubling argument, valid at every $m\ge2$; the columns $h^\vee$ and $I_\rho$ are a generic-$m$ factorisation of it and are wrong at $m=3$ and undefined at $m=4$.*

*Impact on L39:* none on any value. The pairs L39 actually evaluates all have $\mathfrak g$ simple with $c$ obtained either from L153 or from the $\mathfrak{su}(m)$ row, both of which are correct where used.

## 12. The named traps, answered one by one

**Silence is not a verdict, every item below is answered, including where I found nothing.**

| trap | finding |
| --- | --- |
| $\ker W\ne0$, padded objects | **Present and harmless.** $\ker W\supseteq\mathfrak g^\perp$ at every proper $\mathfrak g$, and §2 shows every term in $\mathop{\mathrm{tr}}W$, $\lVert W\rVert^2$, $\mathop{\mathrm{tr}}W^3$ and the triple sum carries a factor $\lambda_\alpha$, so the padding is exact. It does bear on H12: a padded operator is not thereby a Weyl tensor. |
| Smallest admissible $p$ | **Unstated and needed.** $p=0$ makes the denominator vanish; it is excluded by H6 but only indirectly. $p=1$ ($\mathfrak k=\mathfrak{so}(2)$) is admissible and is the equality case. |
| Smallest admissible $q$ | **Unstated and needed.** $q=0$ makes the pair trivial and the denominator vanish. $q=1$ is admissible in principle; $q=2$ occurs at $(\mathfrak{su}(2),\mathfrak u(1))$. |
| $\mathfrak k$ abelian | **Reached, and it is the equality boundary of $q\le2p$.** Everything survives there: $S_{\mathfrak{kkk}}=0$, the formula reduces to $\theta^2=\big(cq(3p-q)-4p(p-q)\big)^2/(16p^3q(p+q))$ with $q=2p$, i.e. $\big(2cp^2-4p(-p)\big)^2/(16p^3\cdot2p\cdot3p)=(2cp^2+4p^2)^2/(96p^5)=(c+2)^2/(24p)$. Witness $(\mathfrak{su}(2),\mathfrak u(1))$, $p=1$, $c=4$: $\theta^2=36/24=3/2$, the record's own $m=2$ member of the $\mathfrak{su}(m)$ family, at exactly its stated $3/2$. **Consistent.** |
| $\mathfrak g$ not simple | **The genuine failure boundary, and correctly guarded.** $\mathfrak{so}(2)$ breaks $q\le2p$; $\mathfrak{so}(3)\oplus\mathfrak{so}(5)\subset\mathfrak{so}(8)$ breaks the single-$c$ premise, per the record's own witness. $\mathfrak{so}(4)$ at $k=2$ survives by accident (isomorphic ideals) and should not be cited as in scope. |
| The crossover $n=6+2\sqrt7$ | **Nothing found, and it is not this lemma's business.** $6+2\sqrt7=11.2915$ is the root of $n^2-12n+8$, the dimension above which $\theta_0(n)^2\ge\tfrac32$; L39 makes no claim against $\sqrt{3/2}$ and states no range in $n$. The nearest contact is the record's remark that the balanced family "exceeds $\sqrt{3/2}$ from $k=6$ on", i.e. $n\ge12$, consistent with the crossover at $11.29$ and with the odd-$n$ root $\tfrac{13+\sqrt{97}}2=11.4244$, since both give integer threshold $12$. **No defect.** |
| Proven on a subfamily, used in general | **Not found in the mathematics; found in the provenance.** §2's derivation is symbolic in $(p,q,S_{\mathfrak{kkk}},S_{\mathfrak{kmm}})$ throughout, and §§5-6 are symbolic in $(p,q,c)$; nothing is pattern-matched from $\mathfrak{su}(m)$. What *is* subfamily-based is the record's evidence sentence "confirmed on 16 pairs across four Cartan series", that is a check, not the proof, and the proof stands without it. |
| Hypothesis stated but never used | **FOUND: H3.** §4, and it is asserted in an annotation to be used where it is not. |
| Step using a hypothesis never stated | **FOUND twice: H7 ($c>0$) and H8 ($p,q>0$).** H7 carries $q\le2p$ and the word "exactly" in the maximiser. A third, H10, was uncited when the annotation was written and is now available in conventions.md. |
| Universal claim with no witness | **Not found.** Every universal here is exhibited: both vanishings on any pair; $q\le2p$ with four equality witnesses; the forced equal-$\theta$ pair with both members named and its value reproduced; the maximiser symbolically in $k$. |
| Imported theorem, hypotheses unchecked | **One import, hypotheses check out; one adjacent trap does not apply.** The import is $c=2h^\vee/I_\rho$, resting on (a) uniqueness up to scale of the invariant form on a simple Lie algebra, needs H6, which is stated; (b) $B=2h^\vee(\,,)_{\mathrm{norm}}$ and $\mathop{\mathrm{tr}}_{\mathbb R}\rho(X)\rho(Y)=2I_\rho(\,,)_{\mathrm{norm}}$, real-versus-complex normalisation, and the record already carries the factor-2 correction. Where it *does* fail is at $m=3,4$ (§11), and there the record has the doubling argument as an independent route. **The "cited theorem assumes a unital algebra and $\mathcal W_n$ has no unit" trap does not fire here**: no algebra-with-unit theorem is invoked anywhere in L39; the only algebraic input is the Lie bracket on $\mathfrak g$ and the $\#$-product on $\mathrm{Sym}^2(\Lambda^2)$, neither used through a unital hypothesis. |
| Symbol collisions | **Three checked.** $\mathfrak m$: L39 uses [conventions.md](../findings/conventions.md)'s third sense (the symmetric-pair odd part) consistently in all three copies; **but L114, which the annotation identifies with L39, uses the second sense (an eigenspace block)**, the identification of §10 is therefore across two senses of $\mathfrak m$, which is legitimate here only because L114's identity holds "at every orthogonal two-block split", as its own annotation says. $c$: L39's Killing sense is distinct from [L44](../findings/problem.md)'s pinned constant and from $\kappa_n$; no leakage found. $p$, $q$: L39 uses them as $\dim\mathfrak k$, $\dim\mathfrak m$, whereas the record's $(\mathfrak{so}(p+q),\mathfrak{so}(p)\oplus\mathfrak{so}(q))$ notation at line 367 uses the **same two letters for the sphere dimensions**, in that one sentence $p$ and $q$ mean $a$ and $b$ with $a+b=n$, not $\dim\mathfrak k$ and $\dim\mathfrak m$. **That is a live collision inside the block's own file and should be renamed.** $S_{XYZ}$: checked against the settled ordered reading in §10; the block's weights are consistent with it. |

## 13. What would falsify it, and what I did to look

**The object.** A symmetric pair $(\mathfrak g,\mathfrak k)$ with $\mathfrak g$ simple and $\mathfrak g\subseteq\mathfrak{so}(n)$, for which any one of the following holds:

1. $q>2p$, this would refute the corollary and, by $S_{\mathfrak{kkk}}=c(p-q/2)\ge0$, refute the $\mathfrak m$-row Killing step that generates the three-invariant form;
2. $S_{\mathfrak{kmm}}\ne cq/2$, or $S_{\mathfrak{kkk}}+S_{\mathfrak{kmm}}\ne cp$, refuting the reduction directly;
3. a value where the three-invariant and four-invariant displays disagree, which would mean the algebra of §6 is wrong;
4. **the dangerous one**: an *admissible* pair (one whose two-eigenvalue operator satisfies first Bianchi and $\mathrm{Ric}=0$), whose formula value exceeds $\Theta_n$. That would falsify not L39 but the conjecture L39 serves.

**What I did.** No search, no sweep: this is analysis-only and I have no per-task approval for computation. I attacked the reduction algebraically rather than empirically, and then screened it against every closed-form datum the record already carries, by hand and in exact arithmetic:

- Derived $S_{\mathfrak{kmm}}=cq/2$ from H6 alone and checked its consequence $S_{\mathfrak{kkk}}=c(p-q/2)$ against three recorded values, one of them ($\mathfrak u(3)$, $48$) the record's own designated hard case for a centre in $\mathfrak k$, one symbolic in $m$. **All three agree exactly.** For (2) to fail, one of those three would have to be wrong.
- Tested $q\le2p$ at every family the record names, symbolically in $m$ and in $k$, plus the real Grassmannian $(\mathfrak{so}(a+b),\mathfrak{so}(a)\oplus\mathfrak{so}(b))$, where it reads $ab\le a(a-1)+b(b-1)$ and holds for all $a,b\ge1$ with $(a,b)\ne(1,1)$; the single exception $(1,1)$ is $\mathfrak{so}(2)$, not simple. **No falsifier for (1) exists among the record's pairs, and the general proof of §8 covers the rest.**
- Reduced the four-invariant to the three-invariant form by exact factorisation, exhibiting the $(p+q)$ that cancels; then re-derived $9245/8232$, $64009/46080$, $961/960$, $3/2$, $10/9$ and $(k-1)(2k-1)/k^2$ from the three-invariant form and matched each against a value already on the record. **No disagreement for (3).**
- For (4), the two overshoots of §7 are the nearest candidates and **both are excluded**: $\mathfrak{so}(a)\oplus\mathfrak{so}(b)$ with $a\ne b$ fails Ricci-flatness by the record's own census, so neither operator is in $\mathcal W_n$ and neither number is a $\theta$. **A falsifier of type (4) would have to be a pair passing Bianchi and Ricci-flatness that is not one of the three the census found, and locating one is a computation this loop may not run.** That is the standing block, and it is the honest boundary of what §7's GAP can be closed by analysis.

**Boundaries walked, not assumed.** $p=0$; $q=0$; $p=1$; $\mathfrak k$ abelian ($q=2p$, formula $(c+2)^2/(24p)$, checked at $3/2$); $\mathfrak g$ not simple ($\mathfrak{so}(2)$ and $\mathfrak{so}(4)$); $k=2$ where the maximiser leaves scope; $m=3$ and $m=4$ where the table's factorisation breaks; and the crossover $6+2\sqrt7$, which turns out not to touch this lemma.

## 14. What the record should change

1. **Strike** *"it closes the Killing split instead"* from the first annotation; replace with the positive statement that $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$ is used nowhere and follows from $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$ with ad-invariance.
2. **Strike** *"$S_{XYZ}$ is defined nowhere on the record"* (stale by 51 seconds) and cite [conventions.md](../findings/conventions.md)'s ordered-slot row, which the $(1,3,3,1)$ weights need.
3. **Restore the Weyl-ness scope sentence** from [results.md](../results.md) into the [target.md](../findings/target.md) block. This is the load-bearing repair, exactly as the annotation says.
4. **Add $c>0$ and $p,q>0$** to the hypotheses, with the one-line reasons of §1; without $c>0$ neither $q\le2p$ nor the maximiser's "exactly" is proved.
5. **Replace** the canonical entry's *"$\theta$ depends on $p$, $q$, $S_{\mathfrak{kkk}}$ and $c$ alone"* with the three-invariant display, and demote the $\mathfrak k$-centre clause to the consistency check $\sum_ic_i\dim\mathfrak k_i=c(p-q/2)$.
6. **Restrict** the maximiser claim to $k\ge3$, and note that $k=2$ is simultaneously the $\mathfrak g$-not-simple boundary and the $\mathfrak k$-abelian equality case.
7. **Correct the L114 identification**: L114 is one row and equals L39's Killing split at $\mathfrak g=\mathfrak{so}(n)$; the $(1,3,3,1)$ identity is L114 **plus its twin**; and L39's $(1,3,3,1)$ are $P(W)$-expansion weights, a different statement with the same multinomial coefficients. Cross-reference both ways.
8. **Widen** the table caveat: row 1 breaks at $n=3$ for the same reason row 3 breaks at $m=3$. The $c$ column is the theorem via L153 and doubling; $h^\vee$ and $I_\rho$ are a generic factorisation of it.
9. **Rename** the sphere dimensions at [target.md](../findings/target.md) line 367, which reuse $p$ and $q$ against the block's own $\dim\mathfrak k$, $\dim\mathfrak m$.
10. **Change the wording** of the $n=5$ overshoot from "$\theta$" to "$\theta^2$": the $12.6\%$ is an excess on the square.

## Verdict

**PROVEN, hypotheses corrected.**

Both closed forms are correct, are one expression, and the reduction between them through $S_{\mathfrak{kmm}}=cq/2$ is sound; all three corollaries hold; the maximiser collapse and the value $2(n-1)(n-2)/n^2$ are exact; both overshoot figures reproduce to the digit. Three hypotheses need adding ($c>0$; $p,q>0$; the ordered-slot convention cited), one needs demoting from hypothesis to consequence ($[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$), and the maximiser needs $k\ge3$.

**Against the block copy alone, the admissibility item is a standing `GAP`**, this copy carries no Weyl-ness guard, and the operator it values is generically not a Weyl tensor. The canonical entry in [results.md](../results.md) does carry the guard, so the *numbered result* is not gapped; the derivation file's copy is, and repair 3 closes it by transcription rather than by argument.

Two annotation clauses are **BROKEN**: *"it closes the Killing split instead"* (§4, false) and *"$S_{XYZ}$ is defined nowhere on the record"* (§10, stale). Neither touches a value.
