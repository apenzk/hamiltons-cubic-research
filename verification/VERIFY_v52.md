# L148-r2, v52, the coordinate-diagonality vanishing, its two-copy scope, and the two clauses of the entry that the record has already refuted

*Cold brief, [ROUND_L148r2.md](ROUND_L148r2.md), source [findings/second-order.md](../findings/second-order.md):1189–1202. **No numerical work of any kind**: no script was run, and every value below is an exact hand evaluation from closed forms the record itself states. Log: [agent_logs/verify-L148r2-v52.log](../agent_logs/verify-L148r2-v52.log). No other verifier's report was read, and [ROUND_L148.md](ROUND_L148.md) was deliberately left unopened so that the repaired passages stayed unmarked.*

## Claim table

| # | Claim, as the entry writes it | Verdict |
| --- | --- | --- |
| C1 | $W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes, hence $W(t)$, hence $W(t)_-$ | **PROVEN**, in the frame chosen after $H$ |
| C2 | Therefore $\mathrm{Alt}(W(t)_-)=0$ | **PROVEN**, an exact algebraic identity, not a bound |
| C3 | For **every real $t$**, past every crossing, with no gap, no analyticity, no $\ker W^*=0$, no $n\ge12$ | **PROVEN** |
| C4 | The vanishing holds on **both** $S^2_0(\mathbb R^m)$ copies | **PROVEN**, and it is what the consumer needs |
| C5 | The frame is chosen **after** $H$; a fixed frame will not do | **PROVEN**, and it is the load-bearing repair |
| C6 | The witness for C5: $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ **at every $m\ge3$** | **REFUTED as written**, the value is $\alpha h_{12}$ at $m=3$ only; at every $m\ge4$, including the entire live range, it is $-\beta h_{12}$. C5 survives, and is strengthened, since $\beta>\alpha$ |
| C7 | $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$, tying at $m=4$; at $m=3$ the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ | **PROVEN**, reproduced exactly, twice, from [Lemma L27](../findings/nondegeneracy.md)'s spectrum |
| C8 | Branch 1 is present at $w=0$ and equals $c_p/S\le3/(n-2)$; only branch 2 goes unbounded | **PROVEN**, reproduced exactly |
| C9 | The boxed statement's closing clause: "**both defect branches are absent there**" | **REFUTED**, by C8 four lines above it, by [Lemma L147](../findings/second-order.md), and by [INDEX-results.md](../findings/INDEX-results.md):167 |
| C10 | The boxed statement's scope: singular $H$, fixed-frame diagonality, no dimension floor | **BROKEN as a citable statement**, all three corrections live outside the box |
| C11 | "It asserts nothing at $W_{\mathbb{CP}^2}$, whose $\delta^2=\tfrac19\ne0$ shows contrapositively that it is coordinate-diagonal in no frame" | **PROVEN**, $\delta^2=\tfrac19$ reproduced exactly from [conventions.md](../findings/conventions.md) |
| C12 | "This is stronger than [Lemma L146](../findings/second-order.md) and it **displaces** it" | **REFUTED**, [Lemma L149](../findings/second-order.md), the entry carrying the block's surviving bound, consumes L146 at every $w$, and [Lemma L158](../findings/second-order.md) consumes its constant $a_0$ |
| C13 | "Written singular, **used plural by every citation**" | **REFUTED as written**, L149's own box cites L148 at "the named copy", singular. The load-bearing use is plural |
| C14 | The two forms: [results.md](../results.md) against the findings text | **FINDING**, results.md carries no L148 at all, while [LEDGER.md](../findings/LEDGER.md):178 and [INDEX-results.md](../findings/INDEX-results.md):167 record the Gate 2 debt discharged and the source line 1197 still reads "Gate 2 owed" |

## The one line the round can act on

**The vanishing is a correct algebraic identity and the two-copy repair is sound, but the boxed LEMMA L148 must not be cited as it stands: its final clause ("both defect branches are absent there") is false and was already refuted in the same file, its scope corrections all live outside the box, and its closing "displaces L146" is refuted by L149's own proof.**

## 0. Conventions, fixed once

- $W^*$ is the unit-norm Weyl tensor of $S^m\times S^m$, $n=2m$, with index blocks $B_1=\{1,\dots,m\}$ and $B_2=\{m+1,\dots,2m\}$, the labelling the block uses throughout.
- "Diagonal on coordinate $2$-planes" means the operator on $\Lambda^2\mathbb R^n$ is diagonal in the orthogonal basis $\{e_i\wedge e_j\}$, equivalently $R_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$.
- $\mathrm{Alt}$ is the orthogonal projection $S^2(\Lambda^2)\to\Lambda^4$, $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ ([conventions.md](../findings/conventions.md):94); $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$ ([conventions.md](../findings/conventions.md):95); $\delta^2:=\lVert\mathrm{Alt}(W_-)\rVert^2$.
- $L_e$'s spectrum at $S^p\times S^q$ ([Lemma L27](../findings/nondegeneracy.md), line 700): $1$ simple; $\tfrac12$ on the orbit tangent at multiplicity $pq$; $\lambda_m=\tfrac{m-2}{2(m-1)}$ on each $S^2_0(\mathbb R^m)$ at multiplicity $s_m=\tfrac{(m+2)(m-1)}2$; $\pm\mu$ with $\mu=\tfrac{n-2}{2(p-1)(q-1)}$; $0$ on $\mathrm{Weyl}_p,\mathrm{Weyl}_q$. At $p=q=m$, $\mu=\tfrac1{m-1}$.
- $\Sigma$ denotes the **joint** two-copy summand: the Weyl image of $S^2_0(V_1)\oplus S^2_0(V_2)$, $V_1,V_2$ the two factors. $w:=\lVert H_r\rVert$ is the weight of $H$ outside $\Sigma$.
- The embedding, from [L146](../findings/second-order.md):1137–1138, with $\alpha=\tfrac{m-2}{2(m-1)}$ and $\beta=\tfrac m{2(m-1)}$, for $h\in S^2_0(\mathbb R^m)$ **diagonal** on $B_1$: the Weyl image is diagonal on coordinate $2$-planes with $\alpha h_a$ on $e_a\wedge e_b$ ($a\in B_1,b\in B_2$), $-\beta(h_a+h_{a'})$ on $e_a\wedge e_{a'}$ ($a,a'\in B_1$), and $0$ inside $B_2$.

## 1. Hypothesis inventory

**Carried by the statement.** The boxed LEMMA L148 (line 1199) carries exactly two: *"$H$ in $S^2_0(\mathbb R^m)$"* and *"at $W^*$"*. **It carries no dimension floor, no parity, no norm, no kernel condition and no restriction on $t$.** The preamble at line 1191 adds: $W^*=S^m\times S^m$; $n=2m$; $m\ge3$; and $m\ge5$ for the word "margin" in the title.

**Used by the written proof.** Three things, and no more:

1. $W^*$ is diagonal on coordinate $2$-planes in every frame adapted to $V_1\oplus V_2$, and is $O(m)\times O(m)$-invariant. Both hold: the sphere-product Weyl tensor takes one value on $B_1$-pairs, one on $B_2$-pairs and one on mixed pairs ([second-order.md](../findings/second-order.md):593), so its entries depend only on block membership.
2. $h$ (and $k$) may be diagonalised inside its own factor. Available from the same invariance.
3. $\mathrm{Alt}$ and $x\mapsto x_-$ are $O(n)$-equivariant, so the conclusion is frame-free.

**Not used, and correctly disclaimed:** $\lVert H\rVert_F=1$; $H\perp W^*$; $H\perp T_{W^*}\mathcal O$; $\ker W^*=0$; analyticity of $W\mapsto W_-$; the spectral gap $g_n$; $n\ge12$; $t$ small. I confirm each: the argument is a statement about which entries of a symmetric operator vanish, and none of these enters it.

**Imported results and their own hypotheses.**

| Import | Its hypotheses | Met at the object? |
| --- | --- | --- |
| The embedding, [L146](../findings/second-order.md):1137–1138 | $n=2m$, $m\ge3$, single $h$, $h$ diagonal for the displayed form | Yes; the two-copy extension is by the same map applied on $V_2$ |
| $\mathrm{Alt}$ kills coordinate-diagonal tensors ([conventions.md](../findings/conventions.md):94) | None beyond $R\in S^2(\Lambda^2)$ | Yes; $W(t)_-\in S^2(\Lambda^2)$ |
| $L_e$ spectrum, [L27](../findings/nondegeneracy.md) | $p,q\ge2$ for the summands, $n\ge5$ for the count; $(p,q)\ne(3,3)$ for nondegeneracy | Used only to locate the margin, so only C7 depends on it |

**No finding on the hypothesis side of the vanishing itself:** the proof uses no hypothesis the preamble omits, and the preamble states two ($m\ge3$; and, through the title, $m\ge5$) that the vanishing does not need. The finding is on the other side, §4.2, the box states none of them.

## 2. The core algebra, in full

**Step 1, the image of a diagonal $h$ is coordinate-diagonal.** Directly from the displayed embedding: every entry is attached to a single plane $e_a\wedge e_b$ or $e_a\wedge e_{a'}$. Nothing to check beyond reading it.

**Step 2, both copies at once.** $h$ acts on $V_1$ and $k$ on $V_2$, on orthogonal subspaces, so one frame diagonalises both: pick an orthonormal eigenbasis of $h$ inside $V_1$ and of $k$ inside $V_2$. That frame change lies in $O(m)\times O(m)$, which fixes $W^*$. The image of $(h,k)$ then has $\alpha(h_a+k_b)$ on mixed planes, $-\beta(h_a+h_{a'})$ on $B_1$-pairs, $-\beta(k_b+k_{b'})$ on $B_2$-pairs, coordinate-diagonal. *Cross-check, independent of this entry:* the cross-plane branch $\alpha(h_a+k_b)$ is exactly the "third, cross-plane branch" [L146](../findings/second-order.md):1143 names on the joint eigenspace. The two entries agree.

**Step 3, $W(t)$ and $W(t)_-$.** $W(t)=W^*+tH$ is a sum of two operators diagonal in one and the same orthogonal basis $\{e_i\wedge e_j\}$, so it is diagonal there, for every real $t$; the frame depends on $H$ but **not on $t$**, which is what makes the segment statement work. $W(t)_-=\tfrac12(\lvert W(t)\rvert-W(t))$ is a function of $W(t)$, hence diagonal in the same basis, and this needs no smoothness in $t$, so eigenvalue crossings are irrelevant. C3's "past every eigenvalue crossing" is exactly right.

**Step 4, the projection.** For $R$ coordinate-diagonal and $i,j,k,l$ distinct, all three of $R_{ijkl},R_{iklj},R_{iljk}$ pair two *different* coordinate $2$-planes, so each is $0$; and $\Lambda^4$ has no component with a repeated index. Hence $\mathrm{Alt}(W(t)_-)=0$ **exactly**. No inequality is used anywhere in the chain.

**Verdict on C1–C5: PROVEN.** The one thing the proof needs that a fixed-frame reading would not give it is the frame-after-$H$ choice, and the entry supplies it.

## 3. The two pre-registered questions, answered

### 3.1 Scope against the neighbours

| Where | Floor |
| --- | --- |
| Boxed LEMMA L148, line 1199 | **none** |
| Preamble, line 1191 | $m\ge3$; $m\ge5$ for the word "margin" |
| What the proof needs | **none**, and the claim is vacuous below $m=3$ (§5.1) |
| [L146](../findings/second-order.md) | $m\ge3$ |
| [L149](../findings/second-order.md), the consumer | $m\ge6$ |

**The direction is safe.** L148 proves a strictly wider statement than its consumers use, so nothing is propagated upward from a missing floor here. The exposure is the opposite one, and it is real: the box states no floor, so a reader who quotes the box alone acquires the title's word "margin" without the $m\ge5$ that licenses it, and the identification of the margin eigenspace with $\Sigma$ without the $m\ge5$ that makes it true (§5.2).

### 3.2 Identity or bound, and on which subspace

**An algebraic identity, exactly.** $\mathrm{Alt}(W(t)_-)=0$, not $\le$ anything: no inequality appears in §2. It holds:

- on the **affine** subspace $W^*+\Sigma$, for every $H\in\Sigma$ and every real $t$, with $t$ absorbable into $H$;
- with $\Sigma$ the **joint** two-copy summand, which for $m\ge5$ **is** the full $\lambda_m$-eigenspace of $L_e$ (the other eigenvalues are $1,\tfrac12,\pm\mu,0$, and $\lambda_m$ coincides with $\mu$ only at $m=4$ and with $0$ only at $m=2$);
- **in a frame that depends on $H$.** There is no single frame in which all of $W^*+\Sigma$ is coordinate-diagonal, and the entry does not claim one. The live risk is a consumer needing a uniform frame; none on file does, L149 uses the identity per direction, through $A'(0)[H]=0$ for each $H\in\Sigma$ separately.

**What it is not:** it says nothing at $w>0$, and nothing about a neighbourhood of $W^*+\Sigma$.

## 4. Findings

### 4.1 F1, the boxed statement's closing clause is false, and its own preamble says so, REFUTED

**Locate.** [second-order.md](../findings/second-order.md):1199: *"the defect is identically zero along the whole segment, **and both defect branches are absent there**."*

**Exhibit, in closed form.** At $w=0$ the record's own parametrisation ([L149](../findings/second-order.md), the three-branch display) gives $u\le w=0$, so branch 1 is
$$\frac{c_p+u^2}{S+au}\Big|_{u=0}=\frac{c_p}{S},\qquad c_p=\frac{3\theta_0}{n-2},\quad S=\sup\lvert P\rvert\ge\theta_0 ,$$
a finite **positive** number, not an absent one. At $n=12$: $\theta_0=\sqrt{220}/12=\sqrt{55}/6$, so $c_p=\sqrt{55}/20$, and with $\theta_0\le S\le1+\sqrt{10}$ ([Lemma L143](../findings/bounds.md)) branch 1 lies in $[\,\sqrt{55}/(20(1+\sqrt{10}))\,,\,3/10\,]$, bounded away from $0$ at both ends. Line 1193, four lines above the box, states this: *"Branch 1 is present there and equals $c_p/S\le3/(n-2)$, it is the branch that proves the route's $\Theta(n^{-1})$ ceiling."* [L147](../findings/second-order.md):1185 states it as a matter of principle: *"'both defect branches moved out of the way' is impossible in principle."* And [INDEX-results.md](../findings/INDEX-results.md):167 records the correction: *"what is absent at $w=0$ is the two defect **terms** rather than two branches"*.

**The consequence is not cosmetic.** If both branches were absent at $w=0$, the $\Theta(n^{-1})$ ceiling (the block's one unconditional conclusion), would lose the branch that proves it.

**Argue the opposite.** The most charitable reading is that "both defect branches" is loose for "the two defect *terms*", which is true. But the preamble names precisely that substitution as the error it was written to fix, so the charitable reading is available only by importing a correction the sentence itself lacks, and the box is what gets quoted.

**Upheld.** The clause must be struck from the box.

### 4.2 F2, every correction lives outside the statement, BROKEN as a citable statement

**Locate.** Line 1199 reads *"For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$, the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes"*.

**Exhibit.** Taken alone the box asserts (i) one copy, (ii) simultaneous diagonality flatly, i.e. in a fixed frame, (iii) no dimension floor, (iv) the false clause of F1. Of these, (ii) is **false** by the preamble's own witness, and (i) is the wording that [L149](../findings/second-order.md) records as having cost it a factor of $n$, a unit vector in the second copy has $w=1$ under the singular reading while its true margin is $c_p=\Theta(1/n)$, on a subspace of dimension $s_m=\tfrac{(m+2)(m-1)}2=\Theta(n^2)$. So the box, read as the canon reads boxes, is a statement three of whose four clauses the surrounding prose corrects or refutes.

**Argue the opposite.** The block's house style puts corrections in blockquotes above the box, and [INDEX-results.md](../findings/INDEX-results.md):167 carries all three corrections faithfully, so a reader arriving through the index is not misled. That is a real mitigation for the index route and none at all for the file route, which is the one every neighbouring entry uses when it links to `#lemma-l148-…`.

**Upheld.** What a reader may take from L148 is in §6; it is not what the box says.

### 4.3 F3, the witness numeral is right at $m=3$ and wrong at every $m\ge4$, REFUTED as written

**Locate.** Line 1191: *"'$W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes' is **false in a fixed frame**, $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$."*

**Exhibit, in closed form, from the record's own embedding.** Take $h=e_1\odot e_2$, i.e. $h_{12}=h_{21}=1$ and all other entries zero; it is traceless and supported on $B_1$. Set $f_1=(e_1+e_2)/\sqrt2$, $f_2=(e_1-e_2)/\sqrt2$, so $h=\mathrm{diag}(1,-1,0,\dots,0)$ in the frame $(f_1,f_2,e_3,\dots,e_m)$ of $B_1$, and apply the displayed embedding **there**. Then rotate back and read the entry $\langle H(e_1\wedge e_4),\,e_2\wedge e_4\rangle$, using $e_1\wedge e_4=\tfrac1{\sqrt2}(f_1\wedge e_4+f_2\wedge e_4)$ and $e_2\wedge e_4=\tfrac1{\sqrt2}(f_1\wedge e_4-f_2\wedge e_4)$.

- **$m=3$**, so $4\in B_2$ and both $f_a\wedge e_4$ are **mixed** planes, carrying $\alpha h_a$: $H(f_1\wedge e_4)=\alpha\,f_1\wedge e_4$, $H(f_2\wedge e_4)=-\alpha\,f_2\wedge e_4$, giving $\tfrac12[\alpha\cdot1+(-\alpha)(-1)]=\alpha$. The entry's numeral is **exactly right**.
- **$m\ge4$**, so $4\in B_1$, $e_4=f_4$, $h_4=0$, and both planes are **in-block**, carrying $-\beta(h_a+h_4)$: $H(f_1\wedge e_4)=-\beta\,f_1\wedge e_4$, $H(f_2\wedge e_4)=+\beta\,f_2\wedge e_4$, giving $\tfrac12[(-\beta)(1)+\beta(-1)]=-\beta$.

So $H_{1424}=-\beta h_{12}$ at every $m\ge4$, not $\alpha h_{12}$. At $m=6$ (the smallest dimension the block admits) that is $-3/5$ against the stated $2/5$: wrong in magnitude by $\beta/\alpha=\tfrac m{m-2}=\tfrac32$ and in sign. The comparison is convention-free: whichever normalisation is used for $\langle e_i\wedge e_j,e_i\wedge e_j\rangle$ and for the $4$-tensor-versus-operator reading, it scales both cases identically.

**Argue the opposite.** If the indices are read schematically ("$4$" standing for *some* index of the other block), the numeral $\alpha$ is right and the sentence is unimpeachable. That reading is available, and it is presumably what was meant. But the sentence pins the dimension range ("at every $m\ge3$") while using an index whose block membership changes inside that range, and under the block's own labelling $B_1=\{1,\dots,m\}$ the value is $-\beta$ throughout the live range $m\ge6$. This is the failure mode the round's warning names: a value computed at one end of a range and quoted across it.

**Upheld, as a numeral. The claim it supports is untouched**, indeed strengthened, since $\beta>\alpha>0$, so the off-diagonal entry is *larger* than advertised and C5 holds a fortiori at every $m\ge3$.

### 4.4 F4, "it displaces L146" is refuted by the entry that carries the block's surviving bound, REFUTED

**Locate.** Line 1201: *"**THIS IS STRONGER THAN LEMMA L146 AND IT DISPLACES IT.** A bound on $\lVert A''\rVert$ over a summand where $A\equiv0$ prices a quantity that is not there."* Propagated in stronger form into L146's own entry: *"**AND LEMMA L148 DISPLACES THIS LEMMA ENTIRELY** … What it establishes about the ten-summand infimum is nothing."*

**Exhibit.** [L149](../findings/second-order.md)'s proof, written after, consumes L146 twice, at every $w$ and not only at $w=0$:

- its first bullet, $\lVert H\rVert_{op}\le\lVert H_s\rVert_{op}+\lVert H_r\rVert_{op}\le\Theta(n^{-1/2})+w$, *"by the triangle inequality and Lemma L146"*;
- its uniformity proof, $g_\rho(w)=\sqrt{c_p+\rho w^2}/(a_0n^{1/2}+nw)$ with *"$a_0=\sqrt{2n/(n-2)}$ from Lemma L146"*, and that constant then propagates into [L158](../findings/second-order.md)'s envelope $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$, which is what fixes the kink $w_0=(n-4)/n$.

A lemma two other entries consume in their proofs is not displaced. What L148 voids is one *use* of L146 (its pricing of $\lVert A''\rVert$ at $w=0$) and only there.

**Argue the opposite.** The sentence's own second half restricts the claim to that use ("a bound on $\lVert A''\rVert$ over a summand where $A\equiv0$"), and the narrower reading of L146's line, that L146 contributes nothing to the *infimum over all ten summands*, since at $w=0$ branch 1 $=c_p/S=\Theta(n^{-1})$ binds below the validity branch $\rho/2=\Theta(n^{-1/2})$ that L146's operator norm improves, is defensible and I could not refute it. It is the headline, and the "ENTIRELY" it grew into at L146, that overreach.

**Upheld, against the headline and its propagated form.** The accurate statement is: L148 voids L146's $\lVert A''\rVert$ use at $w=0$; L146's operator-norm bound remains load-bearing at every $w>0$.

### 4.5 F5, the two forms, FINDING

**Locate.** [results.md](../results.md) carries **no L148**: not in the numbered canon, not in the closing "Audit owed" list. Meanwhile [LEDGER.md](../findings/LEDGER.md):178 reads *"**DISCHARGED 2026-09-05** … `PROVEN, hypotheses corrected`. *Formerly:* **Gate 2 OWED**"*, [INDEX-results.md](../findings/INDEX-results.md):167 agrees, and [second-order.md](../findings/second-order.md):1197 (the source line, immediately under the entry), still reads ***"Gate 2 owed."***

**Exhibit.** results.md's own rule is *"a result appears here once Gate 2 has passed; single-audited results are listed by number in the closing section."* By the LEDGER's bookkeeping L148 has passed and belongs in the canon; by its own source file it is still owed. Three files, two states, and the canon carrying neither. This is the pattern the round's warning names.

**Argue the opposite.** The absence may be deliberate rather than an oversight: L145, L146, L147 and L149 are **all** absent from results.md too, so the whole tube-radius block is being withheld from the canon while it is audited, and L148's conclusion is entangled with L146's status through F4. Under that reading the absence is correct and only the stale line 1197 is a defect. I cannot decide between the two from the files, so I record both and name the stale line as the part that is a defect either way.

**Upheld in part:** line 1197's "Gate 2 owed" contradicts two index files and is stale. The results.md absence is flagged, not adjudicated.

### 4.6 F6, "used plural by every citation", REFUTED as written, NOTE

**Locate.** Line 1191: *"written singular, used plural by every citation"*.

**Exhibit.** [L149](../findings/second-order.md)'s own boxed statement cites it singular: *"[L148] pins the **variable** $u$ to zero on **the named copy**, not the **coefficient** $a$."* [L147](../findings/second-order.md) likewise: *"L148 sets that to zero on the very summand."* [plan.md](../plan.md) I33: *"the margin summand"*.

**Argue the opposite.** The *substantive* use is plural and that is what the sentence is about: L149 defines $w$ as the weight outside **both** copies, and its $u\le w$ step needs $A'(0)$ to vanish on the whole of $\Sigma$. On that reading the sentence is true and the singular wordings are inherited from the box F2 is about.

**Upheld as an overstatement only.** No mathematical consequence.

## 5. The edges of the range

### 5.1 $m=2$, the statement is vacuous, and the floor is exactly right there

At $m=2$: $\alpha=\tfrac{2-2}{2\cdot1}=0$ and $\beta=\tfrac2{2\cdot1}=1$, so the mixed-plane entries are $0\cdot h_a=0$, the single $B_1$-pair entry is $-1\cdot(h_1+h_2)=0$ by tracelessness, and the $B_2$ block is $0$. **The Weyl image of $S^2_0(\mathbb R^2)$ is identically zero**, so $\Sigma=0$ and L148 says nothing at $n=4$. The preamble's $m\ge3$ is therefore the exact floor for non-vacuity, a point in the entry's favour that it does not make.

### 5.2 $m=3$ and $m=4$

- **$m=3$:** $\mu=\tfrac1{m-1}=\tfrac12$, so $\lambda_3=\tfrac14<\mu$ and the entry's *"at $m=3$ the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ instead"* is correct as a location. **But that margin is exactly zero**, $\mu=\tfrac12$ *equals* the orbit eigenvalue, $S^3\times S^3$ is [Lemma L27](../findings/nondegeneracy.md)'s single degenerate exception, and [L149](../findings/second-order.md)'s own bullet says the smallest off-summand margin *"is **zero at $m=3$**"*. The vanishing itself is unaffected (it is pure algebra), but the entry's floor $m\ge3$ admits, without flagging it, the one base point at which the whole surrounding tube construction has no margin to work with.
- **$m=4$:** $\lambda_4=\tfrac13=\mu$, the tie the entry names. Beyond the word "margin", the tie has a consequence the entry does not state: **the $\lambda_m$-eigenspace strictly contains $\Sigma$ at $m=4$**, picking up $\Lambda^2\!\otimes\!\Lambda^2$, on which L148 asserts nothing. A reader who reads "the margin summand" as "the $\lambda_m$-eigenspace" is wrong at $m=4$ and right at $m\ge5$.

Both are below the live range $n\ge12$, i.e. $m\ge6$, so neither is a live error.

### 5.3 Odd $n$

The base point is $S^m\times S^m$, so $n=2m$ is even by construction and **the entry asserts nothing at odd $n$**. Nothing in the block reads it at odd $n$. No finding.

### 5.4 $\ker W\ne0$, and the named witness $W_{\mathbb{CP}^2}$

**The entry's disclaimer is correct and its contrapositive checks out.** L148's argument nowhere touches the kernel, so C3's "no $\ker W^*=0$" is right. At $W_{\mathbb{CP}^2}$, with $\dim\ker W=3$: L148 gives *coordinate-diagonal $\Rightarrow\ \mathrm{Alt}(W_-)=0$*, and [conventions.md](../findings/conventions.md):95 fixes $\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$, so
$$\delta^2=a^2\lVert\star\rVert^2=\frac{6}{9\cdot6}=\frac19\neq0 ,$$
reproducing [problem.md](../findings/problem.md)'s *"exactly $1/9$ in every ambient dimension"* exactly, and forcing $W_{\mathbb{CP}^2}$ to be coordinate-diagonal in no frame. **C11 is proven.** *Two cautions on the surrounding sentence:* "this is the one link in the tube chain that survives a kernel" is a comparative claim about the other links, which I did not verify and which is outside this entry; and "survives a kernel" licenses *"the proof uses no kernel hypothesis"*, not *"L148 holds at a base point with a kernel"*, no such base point is named in the statement, whose object is $W^*$ throughout.

## 6. What a reader may take from this entry

Exactly this, and it is enough for the consumers:

> Let $W^*=S^m\times S^m$, $n=2m$, $m\ge3$, and let $H$ lie in the Weyl image $\Sigma$ of $S^2_0(V_1)\oplus S^2_0(V_2)$, **both** copies. Then in a frame chosen **after** $H$, $W^*+tH$ is diagonal on coordinate $2$-planes for every real $t$, hence so is $(W^*+tH)_-$, hence $\mathrm{Alt}((W^*+tH)_-)=0$ identically in $t$. For $m\ge5$, $\Sigma$ is the full $\lambda_m$-eigenspace of $L_e$ and carries the margin.

Consequences a consumer may draw: $u=0$ at $w=0$; $A'(0)$ vanishes on $\Sigma$, hence $u\le w$ once $A'(0)$ is linear and bounded ([L140](../results.md)); branch 2, being $\sqrt c/\lVert A''\rVert$ with $\lVert A''\rVert=0$ there, is unbounded at $w=0$, which is [L149](../findings/second-order.md)'s $\Omega$-not-$\Theta$.

Consequences a consumer may **not** draw: that both defect branches are absent at $w=0$ (F1, branch 1 is $c_p/S$ there, and is what proves the ceiling); that $W^*+\Sigma$ is coordinate-diagonal in one common frame; that L146 is displaced (F4); anything at all at $w>0$, at $m=4$ off $\Sigma$, at odd $n$, or at $W_{\mathbb{CP}^2}$.

## 7. Numerals, reproduced and not

| Numeral, as the entry states it | Status |
| --- | --- |
| $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$ | **Reproduced exactly.** $\lambda_m=\tfrac{m-2}{2(m-1)}$, $\mu=\tfrac{n-2}{2(m-1)^2}=\tfrac1{m-1}$ at $p=q=m$, $n=2m$; the difference is $\tfrac{(m-2)-2}{2(m-1)}$. Independently: $c_{\min}-c_p=3\theta_0\tfrac{m-4}{2(m-1)}$ in [L149](../findings/second-order.md) is the same quantity times $3\theta_0$ |
| ties at $m=4$ | **Reproduced.** $\lambda_4=\tfrac13=\mu$ |
| at $m=3$ the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ | **Reproduced**, with §5.2's caveat: $\mu=\tfrac12$ there, so the margin is zero |
| $m\ge5$ for the word "margin" | **Reproduced**, and needed for a second reason the entry omits (§5.2) |
| $H_{1424}=\alpha h_{12}$ at every $m\ge3$ | **NOT reproduced at $m\ge4$**: the value is $-\beta h_{12}$ (§4.3). Reproduced exactly at $m=3$ |
| $c_p/S\le3/(n-2)$ | **Reproduced exactly.** $c_p=3\theta_0(\tfrac12-\lambda_m)=\tfrac{3\theta_0}{2(m-1)}=\tfrac{3\theta_0}{n-2}$, and $S\ge P(W^*)=\theta_0$, so $c_p/S\le3/(n-2)$; $=3/10$ at $n=12$ |
| only branch 2 goes unbounded | **Reproduced** against [L149](../findings/second-order.md)'s own reading, *"the branch is unbounded there rather than $\Theta(n^{-1})$"*; the displayed $\sqrt{c_p+\rho w^2}/(n^{1/2}+nw)$ stays finite at $w=0$ only because it substitutes an upper bound for $\lVert A''\rVert$, which is a valid lower bound on the radius either way |
| $\delta^2=\tfrac19$ at $W_{\mathbb{CP}^2}$ | **Reproduced exactly**, $a^2\lVert\star\rVert^2=\tfrac6{54}$ (§5.4) |
| "cost L149 a factor of $n$" | **Reproduced.** A unit vector in the second copy has $w=1$ under the singular reading against a true margin $c_p=\Theta(1/n)$, on a subspace of dimension $s_m=\Theta(n^2)$ |
| "the one link in the tube chain that survives a kernel" | **Not checked**, a comparative claim about the other links, outside this entry |

## 8. What would break it

**The object that would falsify the vanishing:** a direction $H$ in the Weyl image of $S^2_0(V_1)\oplus S^2_0(V_2)$, and a real $t$, with $\mathrm{Alt}((W^*+tH)_-)\neq0$. **Where I looked:** at the embedding itself, since the identity reduces to it, a nonzero entry of the Weyl image joining two *distinct* coordinate $2$-planes when $h$ and $k$ are diagonal would break Step 1, and [L146](../findings/second-order.md):1137–1138's displayed image has no such entry, on any of its three branch types; at the two-copy sum, where the cross-plane entries $\alpha(h_a+k_b)$ are the only new ones and are again plane-diagonal; at eigenvalue crossings, where $x\mapsto x_-$ could in principle leave the algebra generated by $W(t)$ and does not, being a function of it; and at $\Lambda^4$, where a coordinate-diagonal tensor has no component at all since every $\Lambda^4$ index quadruple is distinct. **I found no candidate, and I believe none exists**: the identity is forced by which entries of a symmetric operator are nonzero, and that is settled by the record's own embedding.

**The object that would falsify the *entry*** is weaker and it exists: a citation that quotes the box. F1's clause and F4's headline are both false as written, and both are already in the file's neighbours.

## Verdict

**`PROVEN, hypotheses corrected`, with two clauses REFUTED and to be struck.**

The identity of C1–C5, C7, C8 and C11 is correct, complete, and needs none of the hypotheses the entry disclaims; the frame-after-$H$ repair and the two-copy repair are both sound, and the second is exactly what the consumer requires. I did not return `BROKEN`, because the load-bearing identity survives intact, nor `GAP`, because no step of the argument is missing. The corrections owed are:

1. **Strike** *"and both defect branches are absent there"* from line 1199 (F1); the replacement already stands at line 1193.
2. **Move** the floor, the plural, and the frame-after-$H$ into the box (F2), so that a citation of the statement carries them.
3. **Repair** $H_{1424}=\alpha h_{12}$ to $-\beta h_{12}$ for $m\ge4$, or say "an index of the other block" (F3).
4. **Cut back** *"it displaces it"* to *"it voids its $\lVert A''\rVert$ use at $w=0$"* (F4), here and in the stronger propagated form at L146.
5. **Retire** the stale *"Gate 2 owed"* at line 1197 (F5), and decide whether the canon carries L148.
