# r817: Gate 2 on L192, the weighted Laplacian on the span

*Cold brief: I was given the block verbatim with its three boxes, the four givens, and the Lean pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) (L178 through L192), [findings/conventions.md](../findings/conventions.md), [lean/INDEX.md](../lean/INDEX.md), [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean), [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) and the `levi6` block of [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work**: no search, sweep, census or falsifier hunt. Every derivation below is by hand and every constant is exact. Three machine actions were screens on objects I constructed or on files handed to me, reported as screens in §9 and never as evidence for a positive claim. The coordinator's mid-round correction (the Pfaffian is now built) reached me and §7 is written against the files as they stand at [cafcfd98](../lean/HamiltonsCubic/Base/Pfaffian6.lean). Log: [agent_logs/g2-l192-r817.log](../agent_logs/g2-l192-r817.log).*

| Claim | Verdict |
|---|---|
| **(1)** Ricci-flatness IS $L[w(x)^2]=0$ | **CONFIRMED**, in both directions, and the word IS is earned. One wording repair: $L[w^2]$ is a constant matrix, so the equation is an identity between constant matrices and not "between matrix-valued quadratic forms" |
| **(2)** at $\dim V=6$, first Bianchi IMPLIES $L[\mathrm{Pf}(w)]=0$ | **CONFIRMED.** Constants check: $C(\omega,\omega,\omega)=6\mathrm{Pf}(\omega)$, $\partial_i^2C(w,w,w)=6C(\omega_i,\omega_i,w)$, $L[\mathrm{Pf}(w)]=\sum_i\lambda_iC(\omega_i,\omega_i,w)$, all three exactly as written |
| **The stated gap**: harmonicity tests Bianchi against the span alone | **CONFIRMED as a statement about the test space.** Requiring $L[\mathrm{Pf}(w(x))]=0$ for **all** $x$ recovers exactly the three tests $\eta=\omega_1,\omega_2,\omega_3$ and nothing more, so the block does not understate what taking all $x$ buys |
| **"(2) is strictly weaker than the hypothesis it comes from"** | **UNPROVEN, and false in the record's own coordinate-diagonal family.** §3 proves in closed form that when the three forms share one orthogonal splitting into planes, harmonicity and Bianchi are EQUIVALENT. A dimension count over $\Lambda^2$ is not an argument for strictness on the constrained set. Verdict **PLAUSIBLE**, and the sentence must be hedged or witnessed |
| **$c_{111}=6\mathrm{Pf}(\omega_1)\ne0$** | **CONFIRMED on the mathematics, REFUTED on the indexing as written.** [L180](../findings/diagonal-half.md)(3) puts $V$ at the MINORITY form, which is index 3 in the pattern $(+,+,-)$ and index 1 in $(+,-,-)$. The box asserts index 1 in both. The repair is one relabelling clause, unstated at present |
| **The $\dim V=4$ box**: "$L$ applied to it returns a constant", hence the reformulation "says nothing" there | **REFUTED.** The constant IS the Bianchi defect: at $\dim V=4$, $L[\mathrm{Pf}(w)]=\sum_i\lambda_i(\omega_i\wedge\omega_i)/\mathrm{vol}$, so harmonicity is EQUIVALENT to first Bianchi. The reformulation is sharpest at $\dim V=4$, not vacuous. An explicit Ricci-flat triple detected by it is in §5 |
| **The "not a general one" box**: "the operator that annihilates it is $L$ only when $m=3$" | **REFUTED.** $L[\mathrm{Pf}(w)]=\frac{1}{(m-2)!}\star\big[\mathcal B\wedge w^{m-2}\big]$ at every $\dim V=2m$, so Bianchi implies $L$ annihilates the Pfaffian in every even dimension. What is special at $m=3$ is that the test element is $w$ itself, so the test space is the span |
| **Carry-over from a neighbouring configuration** | **NONE FOUND in (1) or (2).** Both are dimension-free identities read at $m=3$, and the only six-dimensional inputs are $c_{111}\ne0$ and the identification of $\Lambda^4$ with $\Lambda^2$, and both are used where they hold |
| **Lean `bianchi_implies_harmonic`** | **FAITHFUL, and empty of content beyond `pf6_second_diff`.** The symmetrised hypothesis is EQUIVALENT to [L179](../findings/diagonal-half.md)(b) and smuggles nothing. But the conclusion, quantified over every `w`, is literally twice the hypothesis instantiated at `η = w`, so the theorem is `hB → hB` plus the identity |
| **Lean `1/48`, and the symmetry debt** | **CONFIRMED.** $1/48=(2^mm!)^{-1}$ at $m=3$ and `pf6` is the record's Pfaffian, $s_1s_2s_3$ in normal form. `triple6`'s symmetry is true, is used by no proof in either file, and is needed only where a reader converts L179(b) into `hB` |

**One line.** *The two numbered statements and every constant in them are correct, and the reformulation is real. What is wrong is the block's account of its own scope: the $\dim V=4$ box has the truth inverted, since there harmonicity is not weaker than Bianchi but equal to it, the generality box denies a formula that holds in every even dimension, and the strictness claim in the last box is asserted where the record's own coordinate-diagonal family gives an equivalence. The indexing of $c_{111}$ needs a relabelling clause. Nothing here touches (1) or (2), and the Lean layer is sound.*

## 0. Conventions, fixed once

- $\langle\omega,\eta\rangle=\sum_{a<b}\omega_{ab}\eta_{ab}$, the convention [L180](../findings/diagonal-half.md) fixes by $\operatorname{tr}(\omega\omega^{\mathsf T})=2\lVert\omega\rVert^2$. The $e^{ab}$ with $a<b$ are an orthonormal basis of $\Lambda^2$.
- A $2$-form is read as a skew matrix, its support is $\operatorname{im}\omega$, and $\mathrm{Pf}$ is the Pfaffian of that matrix on $V$, so $\mathrm{Pf}(\sum_jc_j\varepsilon_j)=c_1c_2c_3$ at $\dim V=6$. This is the figure [L187](../findings/diagonal-half.md) uses and the one `pf6` carries.
- $C(\alpha,\beta,\gamma)$ is defined by $\alpha\wedge\beta\wedge\gamma=C(\alpha,\beta,\gamma)\,\mathrm{vol}_V$. It is totally symmetric because $2$-forms commute under $\wedge$.
- $\mathcal B:=\sum_i\lambda_i\,\omega_i\wedge\omega_i\in\Lambda^4V$ is the Bianchi defect, and $B:=\star\mathcal B\in\Lambda^2V$ its dual at $\dim V=6$, which is $2\sum_i\lambda_i\mathrm{Padj}(\omega_i)$ in [L183](../findings/diagonal-half.md)'s notation.
- Everything in (2) happens inside $V$, so $\mathrm{Pf}$, $\mathrm{vol}$ and $\star$ are $V$'s and not $\mathbb R^n$'s. The block writes $\Lambda^2\mathbb R^6$ throughout while its $W$ lives in $\mathcal W_n$. The identification is legitimate because [L180](../findings/diagonal-half.md)(3) puts every $\omega_i$ in $\Lambda^2V$, and it costs a chosen orientation of $V$, which flips the sign of $\mathrm{Pf}$ and of nothing that is claimed.

## 1. Claim (1): the equivalence, and the one wording repair

**Located.** Statement item 1 and the first line of the proof.

**Exhibited.** $w(x)^2=\sum_{j,k}x_jx_k\,\omega_j\omega_k$, whose $x_i^2$ coefficient is $\omega_i^2$, so $\partial_i^2\big(w(x)^2\big)=2\omega_i^2$ and $L[w^2]=2\sum_i\lambda_i\omega_i^2$, **a matrix independent of $x$**. By [L180](../findings/diagonal-half.md)(1) that vanishes exactly when $W$ is Ricci-flat. Both directions are immediate from the same line, so the word IS is earned and no quantifier over $x$ is at stake.

**The opposite argued.** The only way (1) could fail as an equivalence is if $L[w^2]=0$ were a weaker condition through some cancellation in $x$. There is none to have: $L$ has already removed all $x$-dependence, and the surviving object is $2\sum\lambda_i\omega_i^2$ on the nose, with no cross terms $\omega_j\omega_k$, $j\ne k$, surviving.

**Repair.** *"an identity between matrix-valued quadratic forms on $\mathbb R^3$"* names the wrong object. $w(x)^2$ is a matrix-valued quadratic form, and $L[w^2]=0$ is an identity between constant matrices. Suggested: *an identity in $S^2(\mathbb R^n)$, read off a matrix-valued quadratic form on $\mathbb R^3$*.

## 2. Claim (2): every constant checked

**Located.** Statement item 2 and proof step (2).

1. **$C(\omega,\omega,\omega)=6\,\mathrm{Pf}(\omega)$.** In normal form $\omega=\sum_jc_j\varepsilon_j$ with $\varepsilon_1=e^{12}$, $\varepsilon_2=e^{34}$, $\varepsilon_3=e^{56}$, the only surviving terms of $\omega^{\wedge3}$ are the $3!$ orderings of $\varepsilon_1\wedge\varepsilon_2\wedge\varepsilon_3$, each $+c_1c_2c_3\,\mathrm{vol}$, so $\omega^{\wedge3}=6c_1c_2c_3\,\mathrm{vol}=6\,\mathrm{Pf}(\omega)\,\mathrm{vol}$. **Correct**, and consistent with [L183](../findings/diagonal-half.md)'s $\star(\omega\wedge\omega)=2(c_2c_3\varepsilon_1+c_1c_3\varepsilon_2+c_1c_2\varepsilon_3)$, which is the same computation one degree down.
2. **$\mathrm{Pf}(w(x))=\tfrac16C(w,w,w)$** is item 1 read at $w(x)$, hence a cubic form in $x$. **Correct.**
3. **$\partial_i^2C(w,w,w)=6\,C(\omega_i,\omega_i,w)$.** With $c_{ijk}=C(\omega_i,\omega_j,\omega_k)$ totally symmetric, $C(w,w,w)=\sum_{jkl}x_jx_kx_l\,c_{jkl}$, so $\partial_iC=3\sum_{kl}x_kx_l\,c_{ikl}$ and $\partial_i^2C=6\sum_lx_l\,c_{iil}=6\,C(\omega_i,\omega_i,w)$. **Correct.**
4. **$L[\mathrm{Pf}(w)]=\sum_i\lambda_i\,C(\omega_i,\omega_i,w)$** is $\tfrac16\cdot6$. **Correct**, and it is $\star(\mathcal B\wedge w)$, so it is Bianchi tested against $\eta=w$ as the block says.

**The direction is the provable one.** Bianchi is $\mathcal B=0$, which gives $\mathcal B\wedge\eta=0$ for every $\eta$ and in particular for $\eta=w(x)$ at every $x$. The block claims the implication and no more.

**The equivalence to "for every $\eta$" is sound.** $\Lambda^4V\times\Lambda^2V\to\Lambda^6V$ is a perfect pairing, $\dim\Lambda^4=\dim\Lambda^2=15$, so $\mathcal B=0$ iff $\mathcal B\wedge\eta=0$ for all $\eta$. **Correct as written.**

## 3. The gap: what taking all $x$ buys, and where strictness fails

**What all $x$ buys is exactly three tests and no more.** $L[\mathrm{Pf}(w(x))]=\sum_i\lambda_i\,C(\omega_i,\omega_i,w(x))$ is **linear** in $x$, so its vanishing for every $x$ is its vanishing at $x=e_1,e_2,e_3$, which is the box's $\sum_i\lambda_ic_{iik}=0$ for $k=1,2,3$, which is $B\perp\operatorname{span}(\omega_1,\omega_2,\omega_3)$. **So the block's "harmonicity tests it against the three-dimensional span alone" is exactly right**, and the attack's suspicion that quantifying over $x$ recovers more is answered in the negative. The count is also right: ten independent entries in a symmetric $3\times3\times3$ array, three conditions on them. *One caveat on that sentence: the ten entries are not free parameters, since $c_{ijk}$ is determined by the triple and is further constrained by orthonormality and Ricci-flatness, so "constrains without determining" is about the linear system and not about the moduli.*

**Where the block overreaches is "(2) is strictly weaker than the hypothesis it comes from".** That is the assertion that harmonicity does not imply Bianchi, and it needs a witness. The block offers a dimension count instead, which says only that the linear test space is three of fifteen dimensions. **Here is a closed-form family in which the implication is an equivalence.**

**Proposition (r817).** *Let $\omega_1,\omega_2,\omega_3$ be simultaneously in normal form for one orthogonal splitting $V=P_1\oplus P_2\oplus P_3$ into planes, that is $\omega_i=\sum_jc_{ij}\varepsilon_j$ with $\varepsilon_j$ the unit area form of $P_j$. Then harmonicity and first Bianchi are equivalent.*

**Proof.** Orthonormality of the $\omega_i$ makes $M=(c_{ij})$ orthogonal. Each $\star(\omega_i\wedge\omega_i)=2(c_{i2}c_{i3}\varepsilon_1+c_{i1}c_{i3}\varepsilon_2+c_{i1}c_{i2}\varepsilon_3)$ lies in $\operatorname{span}(\varepsilon_1,\varepsilon_2,\varepsilon_3)$, so $B=\star\mathcal B$ has $\varepsilon$-coordinates $B_j=2\,(M^{\mathsf T}\Lambda M)_{kl}$ with $\{k,l\}$ the complement of $j$. Harmonicity is $\langle B,\omega_m\rangle=\sum_jB_jc_{mj}=(MB)_m=0$ for $m=1,2,3$, that is $MB=0$, and $M$ is invertible, so $B=0$, which is $\mathcal B=0$ because $\star$ is an isomorphism. $\square$

**What that costs the block.** In the family where [L181](../findings/diagonal-half.md) lives, harmonicity carries the whole of first Bianchi, so the twelve dimensions the block calls "the gap" are recovered for free there. Strictness therefore cannot be read off the test space and must be witnessed on the constrained set.

**My own attempt at a witness, and where it stopped.** I looked for an orthonormal triple at $\dim V=6$ with weights summing to zero, Ricci-flat, $B\ne0$ and $B\perp$ span, by hand and in closed form, splitting $V=P\oplus Q$ with $\dim P=4$ and writing $\omega_i=\alpha_i+t_iq$. The conditions reduce to a small system: with $G^\pm_{ik}=\langle\alpha_i^\pm,\alpha_k^\pm\rangle$, Ricci is $\sum\lambda_it_i^2=0$ together with $\sum_i\lambda_i\alpha_i^+\alpha_i^-=0$ in $S^2_0(P)$, and harmonicity is $t_kp+\sum_i\lambda_it_i\sigma_{ik}=0$ with $\sigma=G^+-G^-$ and $p=\tfrac12\sum_i\lambda_i\sigma_{ii}$. Two sub-families close by hand with no witness: **all $\alpha_i$ of one duality** forces every $\lambda_k$ with $t_k\ne0$ to be equal, hence zero weights; **each $\alpha_i$ purely self-dual or purely anti-self-dual** forces $\lambda_1=0$ once Ricci on $Q$ is imposed. A third, with $\alpha_1$ and $\alpha_2$ sharing their self-dual part, produces $p=-\tfrac14\ne0$ automatically under harmonicity, which would be a witness, but its last constraint $\mu\nu=1$ fails at the unique admissible root $A\approx0.2263$ of $320A^2-68A-1=0$, where the system needs $\delta^2=s^2-4$ and delivers $3.70$ against $8.12$. **I stopped there.** Going further is a search, and the standing rule forbids opening one. *The record should carry the claim as unwitnessed.*

**A witness does exist one dimension down**, which is §5's triple, and it is worth stating that the block's own $\dim V=4$ reading forbids that from counting: at $\dim V=4$ harmonicity is Bianchi, so the failure there is a failure of the ambient reading, not of the implication.

## 4. $c_{111}\ne0$: the mathematics holds, the index does not

**Located.** The first box: *"$c_{111}=6\mathrm{Pf}(\omega_1)\ne0$ at $\dim V=6$, since L180(3) makes $V$ the minority form's support and a form spanning six dimensions has full rank."*

**The chain is sound where it applies.** [L180](../findings/diagonal-half.md)(3) puts $V=\operatorname{supp}\omega_{\min}$ for the minority-sign form; $\dim V=6$ then makes $\operatorname{rank}\omega_{\min}=6$; a full-rank skew form on six dimensions has $\mathrm{Pf}\ne0$; and $c_{\min\min\min}=C(\omega_{\min},\omega_{\min},\omega_{\min})=6\mathrm{Pf}(\omega_{\min})$ by §2. **So one diagonal entry of the array is nonzero.**

**The index is wrong in one of the two patterns the statement admits.** [L180](../findings/diagonal-half.md)(3)'s own proof reads *"in the first pattern $\operatorname{supp}\omega_1+\operatorname{supp}\omega_2=\operatorname{supp}\omega_3$ and in the second $\operatorname{supp}\omega_2+\operatorname{supp}\omega_3=\operatorname{supp}\omega_1$"*, so the minority form is $\omega_3$ under $(+,+,-)$ and $\omega_1$ under $(+,-,-)$. The Statement offers **both** patterns and fixes no labelling, the first box then names index 1, and the last box says the object is *"harmonic for a signature-$(+,-,-)$ Laplacian with $c_{111}\ne0$"*, which silently drops the $(+,+,-)$ case admitted three paragraphs earlier.

**The repair is one clause**, and it should be added rather than left to the reader: *relabel so that $\omega_1$ carries the minority sign, and replace $W$ by $-W$ if needed so that the pattern is $(+,-,-)$*. Both moves are free for the emptiness question, since $\mathcal W_n$ is a vector space and every hypothesis in play is homogeneous. **One warning to attach to the sign flip**: $P(-W)=-P(W)$, so the normalisation is free for this question and is not free for the optimisation the programme is ultimately about.

**A smaller point on "what makes it usable".** $c_{111}\ne0$ makes the $k=1$ equation $\lambda_1c_{111}+\lambda_2c_{221}+\lambda_3c_{331}=0$ solvable for $\lambda_1$ in terms of the rest, so it says the system is not degenerate at the leading entry. It is not yet a use, and the block's word "usable" is a hope rather than a step.

## 5. The $\dim V=4$ box, refuted, with an explicit triple

**Located.** *"At $\dim V=4$ the corresponding object is quadratic and $L$ applied to it returns a constant, which is why the reformulation says nothing where L178 already closes the case."*

**Both halves of the first clause are true and the inference is the reverse of the truth.** At $\dim V=4$, $\mathrm{Pf}(w(x))=\tfrac12(w\wedge w)/\mathrm{vol}$ is quadratic, so $\partial_i^2\mathrm{Pf}(w)=(\omega_i\wedge\omega_i)/\mathrm{vol}$ and
$$L\big[\mathrm{Pf}(w)\big]=\sum_i\lambda_i\,(\omega_i\wedge\omega_i)/\mathrm{vol}=\mathcal B/\mathrm{vol}.$$
$\Lambda^4V$ is one-dimensional, so **that constant vanishes exactly when first Bianchi holds**. At $\dim V=4$ the reformulation is an EQUIVALENCE, which is the strongest form it takes anywhere, and the block calls it vacuous.

**The block contradicts itself here.** Claim (1) is precisely an instance of "$L$ applied to a quadratic returns a constant", and there the block reads the constant as the condition and calls the result an equivalence. The same reading at $\dim V=4$ gives the same verdict.

**Exhibited in closed form.** On $V=\mathbb R^4$ take
$$\omega_1=\tfrac1{\sqrt2}(e^{12}+e^{34}),\quad \omega_2=\tfrac1{\sqrt2}(e^{13}-e^{24}),\quad \omega_3=\tfrac1{\sqrt2}(e^{12}-e^{34}),\qquad \lambda=(1,1,-2).$$
The first two are self-dual, the third anti-self-dual, all three are orthonormal, and $\sum\lambda_i=0$. Every unit $($anti$)$self-dual form has $\omega^2=-\tfrac12\mathrm{Id}$, so $\sum_i\lambda_i\omega_i^2=-\tfrac12(\sum_i\lambda_i)\mathrm{Id}=0$ and the triple is **Ricci-flat**. But $\omega\wedge\omega=\pm\lVert\omega\rVert^2\mathrm{vol}$ with the sign of the duality, so $\mathcal B=(1+1+2)\,e^{1234}=4\,e^{1234}\ne0$ and **first Bianchi fails**. The reformulation sees it: $L[\mathrm{Pf}(w)]=4$, a nonzero constant. *So the object the box dismisses is the exact detector of the only condition that fails.*

**What the box should say instead.** At $\dim V=4$ the reformulation is an equivalence and is therefore redundant with [L179](../findings/diagonal-half.md)(b) rather than empty, and the reason $\dim V=4$ is not the interesting case is [L178](../findings/diagonal-half.md), not the degree of the Pfaffian.

## 6. The "not a general one" box, refuted by the general formula

**Located.** *"At $\dim V=2m$ the Pfaffian is $\star(\omega^m/m!)$, a form of degree $m$ on the span, so the operator that annihilates it is $L$ only when $m=3$."*

**Exhibited.** $2$-forms commute under $\wedge$, so $\partial_i\,w^{\wedge m}=m\,\omega_i\wedge w^{\wedge(m-1)}$ and $\partial_i^2\,w^{\wedge m}=m(m-1)\,\omega_i\wedge\omega_i\wedge w^{\wedge(m-2)}$. Hence at every even $\dim V=2m\ge4$,
$$L\big[\mathrm{Pf}(w(x))\big]=\frac{1}{(m-2)!}\,\star\!\big[\mathcal B\wedge w(x)^{\wedge(m-2)}\big].$$
**So first Bianchi implies $L[\mathrm{Pf}(w)]=0$ in every even dimension**, and the claim that $L$ is the annihilating operator only at $m=3$ is false. The formula also settles the shape of the general statement, which the block says does not exist:

| $m$ | $L[\mathrm{Pf}(w)]$ | what harmonicity tests $\mathcal B$ against |
|---|---|---|
| $2$ | a constant, $\star\mathcal B$ | everything: harmonicity IS first Bianchi |
| $3$ | linear in $x$ | the span, three conditions |
| $4$ | quadratic in $x$ | $\mathrm{Sym}^2$ of the span inside $\Lambda^4$, six conditions |
| general | degree $m-2$ | $\mathrm{Sym}^{m-2}$ of the span |

**What is genuinely six-dimensional is not the operator but the reading.** At $m=3$ the test element is $w$ itself, so the condition lives on the span and the block's "three linear equations on one symmetric array" is available. That is a real observation and it survives. The box's reason for it does not. **The heading should become** *why the reading is a $\dim V=6$ one*, with the general formula stated and $m=3$ singled out as the case where the test element is $w$.

## 7. Lean

**Screened, not asserted.** [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean) and [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean) both typecheck under `lake env lean` (one unused-simp-argument linter warning at `Pfaffian6.lean:76`, inert), and `#print axioms` on `triple6`, `pf6`, `pf6_second_diff`, `bianchi_implies_harmonic` and `SymTri.cube_second_diff` returns the three standard axioms and nothing else. Details in §9.

**(a) The $1/48$ is right, and `pf6` is the record's Pfaffian.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `sgnR x y` is $+1$, $-1$ or $0$ by trichotomy and `levi6` is the product of `sgnR` over all fifteen pairs $i<j$, which is the Levi-Civita symbol. So $\sum_{abcdef}\varepsilon_{abcdef}X_{ab}X_{cd}X_{ef}=\sum_{\sigma\in S_6}\operatorname{sgn}(\sigma)\prod X_{\sigma(1)\sigma(2)}X_{\sigma(3)\sigma(4)}X_{\sigma(5)\sigma(6)}$, and $(2^mm!)^{-1}=1/48$ at $m=3$ is exactly the Pfaffian's normalisation. **Checked by hand against the record's figure**: at $X=s_1\varepsilon_1+s_2\varepsilon_2+s_3\varepsilon_3$ the surviving terms are the $3!$ block assignments times the $2^3$ pair orientations, each contributing $+s_1s_2s_3$ because reversing a pair flips both $\varepsilon$ and $X_{ab}$, giving $48\,s_1s_2s_3$ before the constant and $\mathrm{Pf}=s_1s_2s_3$ after it. That is [L187](../findings/diagonal-half.md)'s `pf` on pair spectra and §0's convention. **In block terms `triple6` is $C/6$**, so `pf6_second_diff`'s right-hand side $2(T_{\omega\omega w}+T_{\omega w\omega}+T_{w\omega\omega})$ is $C(\omega,\omega,w)$, which is $\tfrac16\cdot6\,C(\omega,\omega,w)$, consistent to the digit.

**(b) The symmetrised hypothesis is EQUIVALENT to L179(b), so nothing is smuggled.** This was flagged as the item most likely to be wrong and it is right, for two reasons that both need saying.
- **Symmetry of `triple6` is true.** Swapping the argument in slots $(a,b)$ with the one in slots $(c,d)$ is a relabelling of summation indices that moves a block of two past a block of two, an even permutation of `levi6`'s slots, so the sign is $+1$, and the same holds for the other transposition. Transpositions generate $S_3$. Hence each of the three summands of `hB` equals $T(\omega_i,\omega_i,\eta)=\tfrac16C(\omega_i,\omega_i,\eta)$ and their sum is $\tfrac12C(\omega_i,\omega_i,\eta)$. **`hB` is therefore $\tfrac12\sum_i\lambda_iC(\omega_i,\omega_i,\eta)=0$ for every $\eta$, which is first Bianchi and not one bit more.**
- **Quantifying $\eta$ over all matrices rather than skew ones adds nothing.** `levi6` is antisymmetric in each of the three slot pairs, so the symmetric part of $\eta$ contracts to zero in every one of the three summands. The extra $\eta$ are the trivial equation $0=0$.

**(c) The second difference is the right stand-in, exactly and not approximately.** For a cubic $h(t)$, $h(1)-2h(0)+h(-1)=2a_2=h''(0)$, the $t^3$ terms cancelling. At $h(t)=\mathrm{Pf}(w(x)+t\,\omega_i)$ this is $\partial_i^2$ of $\mathrm{Pf}(w(x))$ at $x$, since $w(x\pm e_i)=w(x)\pm\omega_i$. **So `pf6 (w + om i) - 2 * pf6 w + pf6 (w - om i)` is $\partial_i^2\mathrm{Pf}(w)$ on the nose**, and the theorem's left-hand side is $L[\mathrm{Pf}(w(x))]$.

**(d) The conclusion is faithful, and the theorem is `hB → hB`.** Quantifying over every matrix `w` rather than over the span is a strengthening of the record's wording and a nullity in substance: by `pf6_second_diff` the conclusion at `w` is exactly twice `hB`'s own summand at $\eta=w$, so *"for every `w`, the conclusion"* is literally the hypothesis. The proof is the identity plus `hB w`, which is what it should be. **The consequence for the row's reading**: what the kernel certifies is `pf6_second_diff`, the algebraic identity, and the specialisation. It does not and cannot certify the content the block cares about, which is that the conclusion restricted to the span loses twelve dimensions of Bianchi. *Formalising that loss needs the span and the three scalar equations, and it is the only part worth typing next.* The docstring's *"it holds at every `w`, not only on the span"* should be read as an admission rather than a boast.

**(e) No proof uses the unproved symmetry.** `triple6_add_*` and `triple6_smul_*` are sum manipulations in one slot each. `pf6_second_diff` expands both cubes through those six lemmas and closes by `ring`, which treats `triple6 ω w ω` and `triple6 w ω ω` as distinct atoms and cannot identify them, which is exactly why the statement keeps the three orders apart. `bianchi_implies_harmonic` rewrites by `pf6_second_diff`, pulls the weight out and applies `hB w`. **The symmetry is needed nowhere inside the files, and is needed by any consumer who wants to derive `hB` from L179(b).** The header says so and the header is right.

**(f) Two smaller notes.** `om` and `η` are arbitrary matrices rather than skew ones, which generalises harmlessly. And the reduction of a six-dimensional $V\subseteq\mathbb R^n$ to `Fin 6` is left to the consumer, as `star6`'s docstring already says for [L184](../findings/diagonal-half.md). That debt is inherited from the layer as it stood.

## 8. Falsifiers, and what I did to look for each

| Claim | What would falsify it | What I did |
|---|---|---|
| **(1)** | An $x$-dependent term surviving in $L[w^2]$, or a Ricci-flat $W$ with $L[w^2]\ne0$ | Expanded $w(x)^2$ in full and read the $x_i^2$ coefficients. The cross terms $\omega_j\omega_k$ carry no $x_i^2$, so nothing survives |
| **(2)'s constants** | Any of $6$, $\tfrac16$, $6$ being $2$, $\tfrac12$ or $3$ | Recomputed $\omega^{\wedge3}$ in normal form, differentiated the coordinate cubic twice, and cross-checked against [L183](../findings/diagonal-half.md)'s $\star(\omega\wedge\omega)$ and against `pf6`'s $1/48$ |
| **(2)'s direction** | Harmonicity implying Bianchi being needed for a proof step, or Bianchi failing to imply harmonicity | Derived $L[\mathrm{Pf}(w)]=\star(\mathcal B\wedge w)$, which makes the implication a substitution and the converse a genuine question |
| **The stated gap** | All-$x$ harmonicity recovering more than three tests | Observed that $L[\mathrm{Pf}(w(x))]$ is linear in $x$, so all $x$ is three tests, and no more |
| **"strictly weaker"** | A proof that harmonicity implies Bianchi under Ricci-flatness at $\dim V=6$, or a witness where it does not | Proved the equivalence inside the coordinate-diagonal family, and worked three closed-form ansätze for a witness at $\dim V=6$, each of which closed with no witness. **I did not run a search**, and the claim stands unwitnessed |
| **$c_{111}\ne0$** | The minority form failing full rank, or the index being wrong | Traced [L180](../findings/diagonal-half.md)(3)'s own two patterns and found the index correct in one and wrong in the other |
| **The $\dim V=4$ box** | The constant $L$ returns being something other than the Bianchi defect | Computed it, found it is the defect, and exhibited a Ricci-flat triple where it is $4$ |
| **The generality box** | The general-$m$ formula failing at some $m$ | Derived $\partial_i^2w^{\wedge m}$ from commutativity of $2$-forms under $\wedge$, valid at every $m\ge2$ |
| **Lean faithfulness** | The symmetrised hypothesis being strictly stronger than Bianchi, or the second difference differing from $\partial_i^2$ | Proved the symmetry of `triple6` by hand, checked the symmetric part of $\eta$ contracts to zero, and checked the cubic's second difference is exactly its second derivative |
| **Lean soundness** | A `sorry`, a `native_decide`, or a proof leaning on the unproved symmetry | Typechecked both files, printed axioms on five declarations, and read every proof for a symmetry appeal |

## 9. The three screens, reported as screens

1. **`lake env lean` on [L192Statement.lean](../lean/HamiltonsCubic/Results/L192Statement.lean)** before the coordinator's correction and again after: clean both times, about eleven seconds and about five.
2. **`lake env lean` on [Pfaffian6.lean](../lean/HamiltonsCubic/Base/Pfaffian6.lean)**: clean in about five seconds, with one unused-simp-argument linter warning at line 76.
3. **`#print axioms`** on `triple6`, `pf6`, `pf6_second_diff`, `bianchi_implies_harmonic` and `SymTri.cube_second_diff`, in a scratch file I wrote for the purpose: all five report `[propext, Classical.choice, Quot.sound]` and nothing else.

*None of these is offered as evidence for a positive mathematical claim. Every verdict above rests on the hand derivations in §§1 to 7.*

## 10. What I would change in the block, in order

1. **Replace the $\dim V=4$ box.** At $\dim V=4$ harmonicity is EQUIVALENT to first Bianchi, so the reformulation is redundant there rather than empty, and the case is closed by [L178](../findings/diagonal-half.md) and not by the degree of the Pfaffian.
2. **Replace the generality box with the general formula** $L[\mathrm{Pf}(w)]=\frac{1}{(m-2)!}\star[\mathcal B\wedge w^{m-2}]$, and single out $m=3$ as the case whose test element is $w$.
3. **Add the relabelling clause** that puts the minority form at index 1 and normalises the pattern to $(+,-,-)$, before the box that writes $c_{111}$, and note that the sign normalisation is free for emptiness and not for $P$.
4. **Hedge "strictly weaker"** to *"not known to be an equivalence, and an equivalence in the coordinate-diagonal family"*, with §3's proposition carried as the reason.
5. **Fix "an identity between matrix-valued quadratic forms"** in item (1) to an identity in $S^2(\mathbb R^n)$.
6. **In the Lean row, say what the theorem is.** The kernel carries `pf6_second_diff` and a specialisation. The reformulation's content, which is the restriction to the span, is not typed and is the thing worth typing next.
