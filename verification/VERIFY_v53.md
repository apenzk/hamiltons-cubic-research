# VERIFY v53, L148-r2: the exact vanishing $\mathrm{Alt}((W^*+tH)_-)=0$, its subspace, and the clause the repair left standing in the boxed statement

**Cold brief.** Read from [ROUND_L148r2.md](ROUND_L148r2.md)'s "brief as dispatched", checked against the source at [second-order.md](../findings/second-order.md):1189–1202 and against every consumer I could locate. **No numerical work was done: no script was run, and every value below is an exact hand evaluation from closed forms the record itself states.** I did not read [ROUND_L148.md](ROUND_L148.md) or any `VERIFY_*.md`, so the identification of which passages are repairs is my own inference from the mathematics. Log: [verify-L148r2-v53.log](../agent_logs/verify-L148r2-v53.log).

## Claim table

| # | Claim, as the entry puts it | Verdict |
|---|---|---|
| C1 | $W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes, hence $W(t)$, hence $W(t)_-$ | **CONFIRMED** |
| C2 | Therefore $\mathrm{Alt}(W(t)_-)=0$ (the step from coordinate-diagonality to zero $\Lambda^4$ content | **CONFIRMED), argument uncited, but on the record at [ATTEMPTS.md](../ATTEMPTS.md):702** |
| C3 | The frame is chosen after $H$; fixed-frame diagonality is false | **CONFIRMED** |
| C4 | The witness for C3: $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ "at every $m\ge3$" | **COEFFICIENT WRONG FOR $m\ge4$; the non-vanishing it supports survives** |
| C5 | The vanishing holds on **both** $S^2_0(\mathbb R^m)$ copies | **CONFIRMED, and it is what every consumer needs** |
| C6 | Boxed **LEMMA L148** states it for one copy, "$H$ in $S^2_0(\mathbb R^m)$" | **NARROWER THAN THE ENTRY PROVES AND THAN CONSUMERS USE** |
| C7 | Boxed **LEMMA L148**: "and both defect branches are absent there" | **FALSE, refuted six lines above in the same entry, and carried unmarked at [plan.md](../plan.md):114** |
| C8 | Branch 1 is present at $w=0$ and equals $c_p/S\le3/(n-2)$ | **CONFIRMED, exact; one input ($S\ge\theta_0$) used and unstated** |
| C9 | Holds for every real $t$, past every crossing, with no gap, no analyticity, no $\ker W^*=0$, no $n\ge12$ | **CONFIRMED, this is the strongest and most defensible sentence in the entry** |
| C10 | $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$, tie at $m=4$, $\Lambda^2\!\otimes\!\Lambda^2$ at $m=3$ | **CONFIRMED, reproduced exactly from L27's own closed form** |
| C11 | The floor: $m\ge3$, and $m\ge5$ for the word "margin" | **CONFIRMED as far as it goes; it omits that $W^*$ is L27's excluded degenerate $(3,3)$ at $m=3$** |
| C12 | It asserts nothing at $W_{\mathbb{CP}^2}$, whose $\delta^2=\tfrac19$ refutes coordinate-diagonality contrapositively | **CONFIRMED, $\delta^2=\tfrac19$ reproduced exactly** |
| C13 | "written singular, used plural by **every** citation" | **THE UNIVERSAL IS FALSE, three citations use it singular** |
| C14 | [results.md](../results.md) carries no canonical L148 | **THE ABSENCE IS A DEFECT: L149, L157 and L158 are in the canon and all three consume L148** |

**One line the round can act on.** *The mathematics of L148 is correct and is stronger than the entry's own headline; the defect is that the repair was written into the scope box and never applied to the boxed statement, which still asserts a clause ("both defect branches are absent") that the same entry refutes six lines above and which [plan.md](../plan.md):114 carries unmarked, while the boxed statement's scope (one $S^2_0$ copy) is narrower than the two-copy version every consumer takes.*

**Verdict: `PROVEN, hypotheses corrected`.**

---

## 0. Conventions, fixed once

- $n=2m$, $V=\mathbb R^n=V_1\oplus V_2$ with $\dim V_i=m$, $B_1=\{e_1,\dots,e_m\}\subset V_1$ and $B_2=\{e_{m+1},\dots,e_{2m}\}\subset V_2$. This is the labelling every entry in the block uses and the one C4 turns on.
- $W^*$ = the Weyl operator of the balanced product $S^m\times S^m$; $W(t)=W^*+tH$; $W(t)_-:=\tfrac12(\lvert W(t)\rvert-W(t))\succeq0$, the sign fixed at [conventions.md](../findings/conventions.md):95.
- $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ ([conventions.md](../findings/conventions.md):94). $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$.
- "Diagonal on coordinate $2$-planes" = diagonal as an operator on $\Lambda^2$ in the orthonormal basis $\{e_i\wedge e_j\}$; equivalently $R_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$.
- $L_e$ spectrum at $S^p\times S^q$ ([nondegeneracy.md](../findings/nondegeneracy.md):700, 724): $1$ on $\langle W\rangle$; $\tfrac12$ on $\mathbb R^p\otimes\mathbb R^q$ (the orbit tangent); $\lambda_m=\tfrac{m-2}{2(m-1)}$ on $S^2_0(\mathbb R^m)$ at multiplicity $s_m=\tfrac{(m+2)(m-1)}2$, once for $m=p$ and once for $m=q$; $-\mu$ on $S^2_0\!\otimes\!S^2_0$; $+\mu$ on $\Lambda^2\!\otimes\!\Lambda^2$, with $\tfrac12-\mu=\tfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}$.
- Margin of a summand $=3\theta_0(\tfrac12-\lambda)$; $c_p=3\theta_0(\tfrac12-\lambda_m)$; $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.
- $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$, from [L146](../findings/second-order.md)'s corrected embedding.

---

## 1. Hypothesis inventory, a pass without one is not a pass

**Carried by the statement (boxed LEMMA plus scope box).**

| Hypothesis | Where stated | Used by the written proof? |
|---|---|---|
| $W^*=S^m\times S^m$, the balanced product | scope box | **Yes**, the $O(m)\times O(m)$-invariance of $W^*$ is the whole of the frame argument |
| $n=2m$ (so $n$ even) | scope box | **Yes**, to have two equal factors; the odd case has no base point |
| $m\ge3$ | scope box | **Only** so that $H\ne0$; see §5 |
| $m\ge5$, for the word "margin" | scope box | **Not used by the identity at all**, it is a naming condition, and the entry says so |
| $H\in S^2_0(\mathbb R^m)$ (one copy) | boxed LEMMA | superseded by the scope box's two-copy version |
| $H$ in the joint $\lambda_m$-eigenspace, both copies | scope box | **Yes**, this is the true domain |

**Imported, with the hypotheses of each import checked against the object here.**

| Import | Its own hypotheses | Met here? |
|---|---|---|
| [L27](../findings/nondegeneracy.md) (ten-summand decomposition, $L_e$ spectrum) | $p,q\ge3$, $(p,q)\ne(3,3)$ | **Met for $m\ge4$. Violated at $m=3$**, which the entry's floor admits, see F4 |
| [L146](../findings/second-order.md) (the corrected Weyl embedding, diagonal on coordinate $2$-planes) | $n=2m$, $m\ge3$, $h\in S^2_0(\mathbb R^m)$, single copy | Met; used for C1 and for the C4 witness |
| $O(n)$-equivariance of $\mathrm{Alt}$ and of $x\mapsto x_-$ | none | Met |
| $\lvert\cdot\rvert$ and $(\cdot)_-$ by functional calculus | symmetry of the operator only, **no spectral gap, no analyticity** | Met at every real $t$ |
| $S=\sup\lvert P\rvert\ge\theta_0$ | [L147](../findings/second-order.md), from $S\ge P(W^*)=\theta_0$ | Met, but **used and not named** in the C8 numeral; see F6 |

**Hypotheses the proof needs that the statement omits.** One: $S\ge\theta_0$, for the inequality $c_p/S\le3/(n-2)$ (F6). **Hypotheses the statement carries that the proof does not use.** Two: $m\ge5$ (naming only), and $m\ge3$ beyond the requirement that $H\ne0$.

**No finding of the kind the round most feared:** the proof uses no dimension bound the statement omits, no gap, no analyticity, no kernel condition, and no $n\ge12$. The entry says exactly this and it is right.

---

## 2. The mathematics, checked in full

### 2.1 C1, simultaneous diagonality, per direction

$S^m\times S^m$ has curvature operator $\Pi_{\Lambda^2V_1}+\Pi_{\Lambda^2V_2}$ (each round factor contributes a multiple of the identity on its own $\Lambda^2$; cross planes carry $0$), and the product of equal round spheres is Einstein, so $W^*$ is that operator minus a multiple of $\mathrm{id}_{\Lambda^2}$. Hence $W^*$ acts as one scalar on $\Lambda^2V_1$, the same scalar on $\Lambda^2V_2$, and another on $V_1\wedge V_2$, **diagonal in every frame adapted to the splitting, and invariant under all of $O(m)\times O(m)$.** The record states the same fact independently at [LEDGER.md](../findings/LEDGER.md):1699: $\Pi_{\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)}$ is a $0/1$ diagonal matrix in $\{e_i\wedge e_j\}$, so every balanced-split member is coordinate-diagonal at every even $n$.

Given $H$ in the joint $\lambda_m$-eigenspace, write $H=H_h+H_k$ with $h\in S^2_0(V_1)$, $k\in S^2_0(V_2)$, legitimate because the eigenspace is the direct sum of the two summands of §0. Choose $g=(g_1,g_2)\in O(m)\times O(m)$ with $g_1$ diagonalising $h$ and $g_2$ diagonalising $k$; the two act on complementary subspaces, so one $g$ does both. By [L146](../findings/second-order.md)'s embedding each image is then diagonal on coordinate $2$-planes, and $g\cdot W^*=W^*$. So $g\cdot W(t)=W^*+t\,(g\cdot H)$ is coordinate-diagonal for **every** $t$. **Confirmed.** Diagonal $+$ diagonal $=$ diagonal in the same basis, which is exactly why the frame must be chosen after $H$ and not before.

### 2.2 C1 continued, diagonality passes to $W(t)_-$

$W(t)$ is a symmetric operator on $\Lambda^2$ diagonal in an orthonormal basis; $\lvert\cdot\rvert$ and $x\mapsto\tfrac12(\lvert x\rvert-x)$ act entrywise on the diagonal. **No spectral gap, no analyticity, no invertibility.** This is the reason C9 is true, and it is the entry's best line.

### 2.3 C2, from coordinate-diagonality to $\mathrm{Alt}=0$

$\mathrm{Alt}$ has image $\Lambda^4$, whose components $R_{ijkl}$ carry four **distinct** indices. A coordinate-diagonal $R$ has $R_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, so all three terms of $\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ vanish. Hence $\mathrm{Alt}(W(t)_-)=0$ exactly. **The entry supplies none of this, it writes "Therefore".** The argument is on the record verbatim at [ATTEMPTS.md](../ATTEMPTS.md):702, Result 1(a): *"$\mathrm{Alt}$ lives on four distinct indices where all three pairings vanish; and $W_\pm$ stay coordinate-diagonal, so the defect vanishes termwise."* Because the record holds the argument, this is a missing citation and **not** a `HYPOTHESIS-DEBT`; but it is the entry's only non-trivial implication and it is the one step the entry does not write down.

### 2.4 C10, the numerals of the scope box, reproduced exactly

From L27's own closed form at $p=q=m$:
$$\tfrac12-\mu=\frac{(m-2)^2-1}{2(m-1)^2}=\frac{(m-1)(m-3)}{2(m-1)^2}=\frac{m-3}{2(m-1)},\qquad\text{so }\mu=\frac1{m-1},$$
$$\lambda_m-\mu=\frac{m-2}{2(m-1)}-\frac1{m-1}=\frac{m-4}{2(m-1)}.$$
**Reproduced exactly**, tying at $m=4$ and negative at $m=3$. And $\tfrac12-\lambda_m=\tfrac1{2(m-1)}=\tfrac1{n-2}$, giving $c_p=3\theta_0/(n-2)$, the value L146 and L149 both carry. The $+\mu$ summand's margin $3\theta_0\tfrac{m-3}{2(m-1)}$ agrees with L149's, and $c_{\min}-c_p=3\theta_0\tfrac{m-4}{2(m-1)}$ agrees with L149's $\rho^{\mathrm{eff}}$ numerator. **Every numeral in the scope box's dimension clause is reproducible from the record's own constants.**

### 2.5 C8, the branch-1 numeral

At $w=0$ the defect vanishes, so $u=0$, and branch 1 in [L147](../findings/second-order.md)'s form is
$$\frac{c_p+u^2}{S+au}\bigg|_{u=0}=\frac{c_p}{S}=\frac{3\theta_0}{(n-2)S}\le\frac{3\theta_0}{(n-2)\theta_0}=\frac3{n-2},$$
the last step using $S\ge P(W^*)=\theta_0$. At $n=12$: $\theta_0=\sqrt{220}/12=\sqrt{55}/6$, $c_p=\sqrt{55}/20$, and at $S=\theta_0$ the branch is exactly $3/10$. **Exact, and reproduced.** The inequality's input $S\ge\theta_0$ is used and unnamed (F6).

### 2.6 C12, the $W_{\mathbb{CP}^2}$ clause

From [route-a.md](../findings/route-a.md):229, $g_0=\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$, so $\delta^2=a^2\lVert\star\rVert^2=\tfrac1{54}\cdot6=\tfrac19$. **Reproduced exactly.** The contrapositive of §2.3 then says $W_{\mathbb{CP}^2}$ is coordinate-diagonal in no frame, sound, and it costs nothing, since §2.3 needs no hypothesis at all. The entry's claim that L148 *asserts nothing* there is correct: its base point is $W^*$, and $W_{\mathbb{CP}^2}$ is a different tensor.

The one numeral in the surrounding brief I could **not** reproduce is $\dim\ker W_{\mathbb{CP}^2}=3$; I take it from [L147](../findings/second-order.md)'s hypothesis box and record that I did not re-derive it. It is not load-bearing for L148, which asserts nothing there.

---

## 3. Findings

### F1, the boxed statement asserts what the same entry refutes six lines above `CONFIRMED`

**Locate.** [second-order.md](../findings/second-order.md):1199, the boxed LEMMA: *"the defect is identically zero along the whole segment, **and both defect branches are absent there**."* Against [second-order.md](../findings/second-order.md):1193, the scope box of the same entry: *"**WHAT IS ABSENT AT $w=0$ IS THE TWO DEFECT TERMS, NOT TWO BRANCHES.** Branch 1 is present there and equals $c_p/S\le3/(n-2)$ ... Only branch 2 goes unbounded."*

**Exhibit, in closed form at a named parameter.** At $w=0$ we have $u=0$ by L148 itself, and branch 1 is $(c_p+u^2)/(S+au)=c_p/S$. At $n=12$ with $S=\theta_0(12)=\sqrt{55}/6$: $c_p=3\theta_0/10=\sqrt{55}/20$ and branch 1 $=3/10$ exactly, **finite, positive, and present.** So "both defect branches are absent there" is false at the smallest admissible dimension of every consumer, by the entry's own arithmetic.

**Argue the opposite.** The most charitable reading is that "branches" is a loose word for the two *defect terms* (the $u^2$ in branch 1's numerator and the $\rho^{\mathrm{eff}}w^2$ under branch 2's radical), both of which do vanish at $w=0$. Under that reading the sentence labels a true statement badly. **The charitable reading is unavailable here**, because the scope box of this very entry names it and rejects it in capitals: *"NOT TWO BRANCHES."* An entry may not both make and forbid the same reading. The candidate survives all three steps.

**Impact, and why it is not merely stale text.** [plan.md](../plan.md):114 carries the refuted clause unmarked (*"so the two defect branches are absent exactly where [Lemma L27] puts the margin maximum"*) and it is the only other place in the record that does. The two are exactly the boxed statement and its one downstream copy: the correction was written into the scope box and propagated nowhere.

### F2, the boxed statement's scope is one copy; every consumer takes two `CONFIRMED`

**Locate.** [second-order.md](../findings/second-order.md):1199: *"For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$..."*, one summand. Against the scope box at :1191: *"**And the vanishing holds on both $S^2_0(\mathbb R^m)$ copies**, $h$ on $V_1$ and $k$ on $V_2$ diagonalising in one frame."*

**Exhibit.** [L149](../findings/second-order.md):1211 defines $H_s$ as the component in the **joint** $\lambda_m$-eigenspace, *both copies*, and $w:=\lVert H_r\rVert$ as the weight outside **both**; its whole chain then reads "$w=0$" as "$H$ lies in the joint eigenspace". [L157](../findings/second-order.md) and [L158](../findings/second-order.md) inherit that reading through results.md:358 (*"At $w=0$ the branch is absent, the defect vanishing identically there"*). Take $m=6$, $h=\mathrm{diag}(1,-1,0,0,0,0)$ on $V_1$ and $k=\mathrm{diag}(1,-1,0,0,0,0)$ on $V_2$, normalised: this $H$ has $w=0$ and is **not** covered by the boxed statement, which quantifies over one copy. It *is* covered by the scope box.

**Argue the opposite.** A reader could say the boxed "$S^2_0(\mathbb R^m)$" is shorthand for the isotypic component, which at $p=q=m$ is both copies. That reading is defensible in isolation, but the entry itself forecloses it by writing the two-copy clause as a **correction** ("*written singular, used plural by every citation*"), which only makes sense if the singular reading was the operative one. The candidate survives.

**Verdict on F2: the scope box is the load-bearing statement and the boxed LEMMA is not.** The two-copy version is correct, I verified it independently in §2.1, so this is a statement defect, not a mathematical one. What a reader may take is set out in §5.

### F3, the fixed-frame witness carries the wrong coefficient for $m\ge4$ `CONFIRMED, non-fatal`

**Locate.** [second-order.md](../findings/second-order.md):1191: *"'$W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes' is **false in a fixed frame**, $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$."*

**Exhibit, in closed form.** Take $h$ with $h_{12}=h_{21}=1$ and all other entries zero, traceless, admissible. Its eigenframe is $f_\pm=(e_1\pm e_2)/\sqrt2$ with eigenvalues $\pm1$. The map $h\mapsto H$ is $O(m)\times O(m)$-equivariant, so L146's diagonal formula applies in the $f$-frame.

*At $m=3$*, index $4\in B_2$, so $e_1\wedge e_4$ and $e_2\wedge e_4$ are **cross** planes, carrying $\alpha\tilde h_a$:
$$H(e_2\wedge e_4)=\tfrac1{\sqrt2}\big[\alpha\,f_+\!\wedge e_4-(-\alpha)\,f_-\!\wedge e_4\big]=\alpha\,e_1\wedge e_4,\qquad H_{1424}=+\alpha h_{12}. \checkmark$$

*At $m\ge4$*, index $4\in B_1$, so $e_1\wedge e_4$ and $e_2\wedge e_4$ are **in-block** planes, carrying $-\beta(\tilde h_a+\tilde h_{a'})$:
$$H(e_2\wedge e_4)=\tfrac1{\sqrt2}\big[-\beta\,f_+\!\wedge e_4-(+\beta)\,f_-\!\wedge e_4\big]=-\beta\,e_1\wedge e_4,\qquad H_{1424}=-\beta h_{12}.$$
At $m=4$ that is $-\tfrac23$ against the entry's $\alpha=+\tfrac13$: **wrong in sign and by a factor $2$.**

**Argue the opposite.** The charitable reading is that "$4$" is schematic for a $B_2$ index, i.e. the intended component is $H_{1b2b}$ with $b\in B_2$, which does equal $\alpha h_{12}$ at every $m\ge3$. That reading is genuinely available and, under it, the sentence is right. **I record the candidate as confirmed but non-fatal**: under the record's own $B_1=\{1,\dots,m\}$ labelling the numeral is wrong for $m\ge4$, while the conclusion the witness supports (that fixed-frame diagonality fails at every $m\ge3$), holds under either reading, since $-\beta h_{12}\ne0$ too.

### F4, $m=3$ is inside the stated floor and outside L27 `CONFIRMED, scope`

**Locate.** [second-order.md](../findings/second-order.md):1191: *"$m\ge3$, and $m\ge5$ for the word 'margin' ... at $m=3$ the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ instead."*

**Exhibit.** At $p=q=3$, L27's own formula gives $\tfrac12-\mu=\tfrac{(3-2)(3-2)-1}{2\cdot2\cdot2}=0$, so $\mu=\tfrac12$ **exactly**. The margin on $\Lambda^2\!\otimes\!\Lambda^2$ is therefore $3\theta_0(\tfrac12-\mu)=0$, and [nondegeneracy.md](../findings/nondegeneracy.md):442 and :760 record $(3,3)$ as L27's **excluded** case: $\dim E(\tfrac12)=18$ against orbit $9$, the point Morse–Bott **degenerate**. So at $m=3$ the margin does not merely move to another summand, it is zero, and the base point of the whole tube construction is degenerate.

**Argue the opposite.** L148's identity is pure algebra and needs nothing from L27, so the *conclusion* $\mathrm{Alt}(W(t)_-)=0$ is true at $m=3$ regardless. Only the naming fails. That is the charitable reading and I accept it, hence "scope" rather than "break". But the entry's gloss understates by a wide margin: "the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ instead" reads as a relocation when it is a collapse to zero at a degenerate point.

### F5, "used plural by every citation" is false `CONFIRMED, minor`

**Locate.** [second-order.md](../findings/second-order.md):1191: *"written singular, used plural by every citation."*

**Exhibit.** Three citations use it singular: [L146](../findings/second-order.md):1147 (*"the defect is identically zero on this summand"*, referring to L146's own single copy); [plan.md](../plan.md):114 (*"vanishes identically on the margin summand"*); [INDEX-traps.md](../findings/INDEX-traps.md):83, trap 60 (*"the margin is attained on a pair block, where the defect response vanishes identically"*). The title of L148 itself is singular.

**Argue the opposite.** Read as "every citation *in the tube chain*" (L149, L157, L158), the claim holds, since all three read $w=0$ as the joint eigenspace. The universal quantifier as written does not.

### F6, the branch-1 inequality uses an unstated input `CONFIRMED, minor`

**Locate.** [second-order.md](../findings/second-order.md):1193: *"Branch 1 ... equals $c_p/S\le3/(n-2)$."*

**Exhibit.** $c_p/S=3\theta_0/((n-2)S)$, and $\le3/(n-2)$ requires $S\ge\theta_0$. That input is [L147](../findings/second-order.md)'s ($S\ge P(W^*)=\theta_0$) and is not named here. **Argue the opposite:** the record states it three lines away in L147 and again in L149's closing note, so no reader of the block is at risk. Minor, and listed only because the inventory demands it.

### Withdrawn candidates

- **"The conclusion is wider than the entry claims: $\mathrm{Alt}(W(t)_-)=0$ for every real $t$."** The boxed LEMMA already says "for every $t$", so the scope box appears to correct a claim its own entry does not make. **Withdrawn**: the natural reading is that "the entry" names the pre-repair text, which the brief strips. Not a discrepancy in the mathematics.
- **"$m\ge5$ is needed for the word 'margin'."** At $m=4$ the two summands **tie**, so $S^2_0\oplus S^2_0$ is still *a* minimum-margin summand and the word is defensible there. **Withdrawn as a finding** and recorded as a reading: $m\ge5$ is where the minimum is *unique*.
- **"C2 is a `HYPOTHESIS-DEBT`."** The step "coordinate-diagonal $\Rightarrow\mathrm{Alt}=0$" carries no argument in the entry, which would ordinarily be the finding. **Withdrawn**: the record holds the argument at [ATTEMPTS.md](../ATTEMPTS.md):702 Result 1(a), reached three independent ways. It is a missing citation for the entry's only non-trivial implication, recorded as C2's verdict rather than as a debt.
- **"$m=2$ is unaddressed."** At $m=2$, $\alpha=0$ and the in-block eigenvalue is $-\beta(h_1+h_2)=-\beta\operatorname{tr}h=0$, so L146's embedding sends every $h\in S^2_0(\mathbb R^2)$ to $H=0$ and the statement is vacuous. **Withdrawn**: the floor $m\ge3$ excludes it, correctly.

---

## 4. The two pre-registered questions, answered

### Q1, does the entry's scope match what its neighbours take from it?

**What the entry states:** $m\ge3$ for the setting; $m\ge5$ for the title's word "margin"; $n=2m$; and (in the scope box only), both $S^2_0$ copies.

**What the proof needs:** for the identity itself, **no dimension floor at all** beyond $m\ge3$ making $H$ non-zero. The frame argument needs $O(m)\times O(m)$-invariance of $W^*$, the equivariance of $\mathrm{Alt}$ and $x\mapsto x_-$, and nothing else. The $m\ge5$ is naming, not mathematics.

**What the consumers assume:** [L149](../findings/second-order.md) states $m\ge6$; [L147](../findings/second-order.md) and [L158](../findings/second-order.md) state $n\ge12$, i.e. $m\ge6$; [L146](../findings/second-order.md) states $m\ge3$ and cites L148 only about its own single copy, which L148 covers at $m\ge3$.

**Answer: the floors nest correctly and this entry is not the one that propagated a floor.** Every consumer assumes strictly more than the entry states, which is the safe direction. **The mismatch is not in the floor but in the summand count** (F2): consumers need the two-copy version, and the boxed statement gives one copy. And the entry's *title* ("on the margin summand"), is unsafe at $m\in\{3,4\}$, where the minimum-margin summand is $\Lambda^2\!\otimes\!\Lambda^2$ and L148 says nothing about it; no current consumer reads it there, so nothing is presently broken by it.

### Q2, is the vanishing identical, or identical on a subspace?

**It is an exact algebraic identity, and it holds on a subspace of directions.** Both halves matter and the entry states only the first clearly.

- **Identity, not bound.** $\mathrm{Alt}(W(t)_-)=0$ is exact (zero, not $O(\text{something})$) because $W(t)_-$ has no component on four distinct indices at all (§2.3). Nothing is estimated anywhere in the argument.
- **The subspace, precisely.** In the *direction* variable: $H$ ranges over the joint $\lambda_m$-eigenspace of $L_e$ at $W^*$, i.e. $\{H_h+H_k: h\in S^2_0(V_1),\,k\in S^2_0(V_2)\}$, of dimension $2s_m=(m+2)(m-1)=\Theta(n^2)$. In the *segment* variable: all real $t$, with no restriction whatever. So the correct phrasing is **"identically zero on the whole affine line $W^*+tH$, for every $H$ in a $\Theta(n^2)$-dimensional subspace of directions"**, not "on a summand of $\Lambda^2$", which the title's wording invites.

---

## 5. What a reader may take from it

**May take.** For $W^*=S^m\times S^m$ with $n=2m$, $m\ge3$, and for every $H$ in the joint $\lambda_m$-eigenspace (**both** $S^2_0(\mathbb R^m)$ copies) and every real $t$:
$$\mathrm{Alt}\big((W^*+tH)_-\big)=0\quad\text{exactly},\qquad\text{hence }\delta^2\equiv0\text{ along the segment, hence }u=0\text{ and every higher defect derivative is }0 .$$
This needs no spectral gap, no analyticity, no $\ker W^*=0$ and no $n\ge12$, and it survives every eigenvalue crossing. It is the one link in the tube chain that would survive a kernel at the base point.

**May not take.**
1. **That both radius branches are absent at $w=0$.** Branch 1 is present and equals $c_p/S\le3/(n-2)$, this is L147's $\Theta(n^{-1})$ ceiling on the method, not slack. (F1.)
2. **A lower bound on $\lVert A''\rVert$ anywhere.** L148 sets it to zero on this summand; L147's reason (b) needs the opposite and L147 already records that.
3. **Anything at $m\le2$, at odd $n$, or at any base point other than $W^*$**, in particular nothing at $W_{\mathbb{CP}^2}$, $\dim\ker W=3$. The contrapositive use ($\delta^2=\tfrac19\ne0\Rightarrow$ not coordinate-diagonal) is sound and is the only thing L148 says in that direction.
4. **That the summand it names is the minimum-margin summand at $m\in\{3,4\}$.** It is not; at $m=3$ the base point is L27's excluded degenerate case besides.
5. **Anything about directions outside the joint eigenspace.** The mixed directions are where the question lives, and the entry says so.

---

## 6. The two forms, [results.md](../results.md)

**[results.md](../results.md) carries no canonical L148.** I grepped the file for the identifier and for the entry's headline phrasing; neither appears. The file does carry L143, L149, L153–L158 as numbered canon entries.

**The absence is a defect, not a correct omission.** Three canonical entries consume L148 by name or by content:
- L149 (results.md:367 block) is the block's surviving lower bound and reads $w=0$ as the joint eigenspace, which is L148's two-copy statement;
- L157's canon text (results.md:358) states outright *"At $w=0$ the branch is absent, the defect vanishing identically there"*, that sentence **is** L148, uncited;
- L158's canon text is built on L149's parametrisation and its findings entry explicitly adjudicates a caveat about L148.

So the canon asserts L148's conclusion in L157's entry while carrying no statement of L148 to which a reader can appeal, and no hypotheses for it. Since the whole of the block's surviving bound rests on the $w=0$ behaviour, **the canonical form of L148 is exactly the piece a reader of results.md cannot check.** Any repair should carry the two-copy scope and must not carry the "both branches absent" clause.

---

## 7. What would break it, and what I did to look

**The falsifier.** A direction $H$ in the joint $\lambda_m$-eigenspace at $W^*$ and a real $t$ with $\mathrm{Alt}((W^*+tH)_-)\ne0$. By §2.1–§2.3 such an object forces one of: (i) $W^*$ not $O(m)\times O(m)$-invariant, (ii) L146's embedding not coordinate-$2$-plane-diagonal for diagonal $h$, (iii) some element of the joint eigenspace failing to decompose as $H_h+H_k$, or (iv) $\mathrm{Alt}$ non-zero on a coordinate-diagonal tensor.

**What I did.** (i) I rebuilt $W^*$ from the product curvature operator by hand and found it a scalar on each of $\Lambda^2V_1$, $\Lambda^2V_2$, $V_1\wedge V_2$, and cross-checked that against [LEDGER.md](../findings/LEDGER.md):1699, which states the same independently. (ii) I re-derived the general-$h$ action from L146's diagonal formula by $O(m)\times O(m)$-equivariance, that is the derivation that produced F3, and it confirms diagonality in the eigenframe. (iii) I checked the multiplicity table at [nondegeneracy.md](../findings/nondegeneracy.md):700: $\lambda_m$ appears once for $m=p$ and once for $m=q$, so the eigenspace is exactly the direct sum of the two images and there is no third source. (iv) I checked the index support of $\mathrm{Alt}$ against [conventions.md](../findings/conventions.md):94 and against the independent statement at [ATTEMPTS.md](../ATTEMPTS.md):702. **I found no such object, and I do not believe one exists**: the argument is closed and elementary once the frame is chosen after $H$.

**Where the entry is genuinely at risk is not the mathematics but the text.** The two live defects are the clause in the boxed statement (F1, with its one unmarked copy at [plan.md](../plan.md):114) and the boxed statement's one-copy scope (F2). Both are repairs that were written once, in the scope box, and applied nowhere else.

---

## Verdict

**`PROVEN, hypotheses corrected`.**

The vanishing is an exact algebraic identity, correct as the scope box states it, and stronger than the entry's title suggests: it holds on the whole affine line for every direction in a $\Theta(n^2)$-dimensional subspace, with no gap, no analyticity, no kernel condition and no dimension bound. **Corrections carried by this verdict:**

1. **Strike "and both defect branches are absent there"** from the boxed LEMMA, and from [plan.md](../plan.md):114. Branch 1 is present at $w=0$ and equals $c_p/S\le3/(n-2)$; what is absent is the two defect *terms*.
2. **Widen the boxed LEMMA's scope from one $S^2_0(\mathbb R^m)$ copy to the joint $\lambda_m$-eigenspace, both copies.** This is what L149, L157 and L158 take from it, and the boxed statement as written does not supply it.
3. **Name $S\ge\theta_0$** as the input to $c_p/S\le3/(n-2)$.
4. **Cite [ATTEMPTS.md](../ATTEMPTS.md):702 Result 1(a)** for the step "coordinate-diagonal $\Rightarrow\mathrm{Alt}=0$", which is the entry's only non-trivial implication and is currently written as "Therefore".
5. **Repair or drop the $H_{1424}=\alpha h_{12}$ witness for $m\ge4$**, where the same component equals $-\beta h_{12}$; the claim it supports is unaffected.
6. **Record at $m=3$** that the base point is L27's excluded degenerate $(3,3)$ and the $\Lambda^2\!\otimes\!\Lambda^2$ margin is exactly zero, the margin collapses rather than relocates.
7. **[results.md](../results.md) should carry a canonical L148**, since L157's canon entry already asserts its conclusion with nothing to cite.

*No numerical work was done. Every value above, $\mu=\tfrac1{m-1}$, $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$, $c_p=3\theta_0/(n-2)$, $c_p/\theta_0=3/(n-2)$, $\theta_0(12)=\sqrt{55}/6$, branch 1 $=3/10$ at $n=12$, $\alpha(4)=\tfrac13$ against $\beta(4)=\tfrac23$, $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$, is an exact hand evaluation from a closed form the record itself states. The one figure I could not reproduce and did not attempt is $\dim\ker W_{\mathbb{CP}^2}=3$, taken from [L147](../findings/second-order.md) and not load-bearing here.*
