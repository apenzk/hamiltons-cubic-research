# Review r679, Lemma L86, the parity rule and the $36$ unknowns

**Reviewer A of an independent pair on identical briefs (the other takes r680). Target: the block headed `#### Lemma L86, the parity rule $\dim V_\lambda^H=1\iff\lambda_2$ even, and the $36$ unknowns it leaves` in [sym3-blocks.md](../findings/sym3-blocks.md), with the section beneath it. Analysis only; no run was opened, and the one arithmetic screen is declared where it is used.**

## Verdict: GAP

**Every mathematical claim in the block is true and was re-derived here from the definitions.** The parity rule, the branching statement, the reduction to one condition, the $16$ blocks, the $3570$, the $25$ multiplicities, the $36$ and its shape all reproduce exactly. What fails is what the block *states*: four load-bearing conventions and facts are absent, one of them flipping a stated sentence into a falsehood if a reader takes the opposite of the unnamed convention; and **the $36$ has no anchor anywhere on the record that distinguishes it from $38$.**

| # | claim | verdict |
| --- | --- | --- |
| 1 | vanishing on the orbit reduces to the single condition $\sigma_\lambda(W_0)=0$ | **correct**, and derived below; three of the facts it uses are unstated, and "single" presupposes the rule proved one sentence later |
| 2 | exactly one $\mathfrak{so}(4)$-constituent has $j_L=0$, namely $(\lambda_2,-\lambda_2)$, with $j_R=\lambda_2$ | **correct under one of the two $L/R$ labellings, false under the other, and the block names neither** |
| 3 | $\dim V_\lambda^H=1\iff\lambda_2$ even | **correct**; $H$ is never written down, the $U(2)$ is $H^\circ$, and *which* $U(2)$ is the fact the argument turns on and is unstated |
| 4 | the $36$, and its independence from L59's $29$ | **arithmetic correct; $65=36+29$ is a tautology and checks nothing.** One computation read two ways |
| 5 | $O(5)$ against $SO(5)$ | **the block does supply the substance**, in the $\varepsilon$-redundancy paragraph, and it is right and basis-free; the odd-$n$ scope is not said |

**[L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) may rest on this as they do, with one qualification each.** Stated in full in §6.

---

## 1. The reduction to a single condition

**The derivation, in four steps.** Write $\mathrm{Sym}^3(\mathcal W_5^*)\cong\bigoplus_\lambda M_\lambda\otimes V_\lambda$ with $M_\lambda$ the multiplicity space and $V_\lambda$ irreducible, and let $H=\mathrm{Stab}_{O(5)}(W_0)$.

1. **From $F_5$ to its summands.** A sum-of-squares certificate is $F_5=\sum_i q_i^2$ (or $\sum_i|q_i|^2$ for the Hermitian ansatz the record actually built). A sum of squares vanishing at a point has every summand vanishing there, so $q_i\rvert_{O(5)\cdot W_0}=0$ for every $i$.
2. **From summands to isotypic components.** The set of cubics vanishing on the orbit is an $O(5)$-submodule, the orbit being $O(5)$-stable; hence it is a sum of pieces of the isotypic decomposition, and each isotypic component of each $q_i$ vanishes on the orbit separately. *This is what licenses the word "covariant" in the block's first sentence.*
3. **From the orbit to the point.** For a covariant $\sigma_\lambda:\mathcal W_5\to V_\lambda$, equivariance gives $\sigma_\lambda(gW_0)=g\,\sigma_\lambda(W_0)$, so vanishing on the whole orbit is exactly $\sigma_\lambda(W_0)=0$. **This much is "by equivariance", and it is the only step the block names.**
4. **From a vector condition to a scalar one.** $h\,\sigma_\lambda(W_0)=\sigma_\lambda(hW_0)=\sigma_\lambda(W_0)$ for $h\in H$, so $\sigma_\lambda(W_0)\in V_\lambda^H$. A priori this is $\dim V_\lambda$ scalar equations; it is $\dim V_\lambda^H$ of them, hence **at most one** once the parity rule is in hand.

Spelling out step 4 on the whole isotypic component, which is what the count needs: pick a basis $u_1,\dots,u_{m_\lambda}$ of $M_\lambda$ and let $\psi_j\in(V_\lambda^*)^H$ be evaluation at $W_0$ on the $j$-th copy. All the $\psi_j$ are proportional to one $\psi$, say $\psi_j=c_j\psi$. For $q$ with components $q_j\in V_\lambda$, vanishing on the orbit reads $\psi\big(g\sum_j c_jq_j\big)=0$ for all $g$, and by irreducibility this is $\sum_jc_jq_j=0$, **one linear functional $(c_j)$ on $M_\lambda$, so the multiplicity drops by exactly one when $(c_j)\ne0$ and not at all when $\psi=0$.**

**The facts used, and whether the block states them.**

| fact | in the block? |
| --- | --- |
| the orbit is a single $O(5)$-orbit | yes, by construction |
| a summand of an SOS vanishes where the sum does | no |
| the constraint space is a submodule, so it decomposes isotypically | no |
| $\sigma_\lambda$ is equivariant | yes ("by equivariance") |
| $V_\lambda$ irreducible, so $\psi(gv)\equiv0\Rightarrow v=0$ | no |
| $\sigma_\lambda(W_0)$ is $H$-invariant because $H$ fixes $W_0$ | **no, and this is the step that turns $\dim V_\lambda$ conditions into one** |
| $\dim V_\lambda^H\le1$ | **stated one sentence later**, so the word "single" is a forward reference |

**A positive result the block is missing and would want.** [L61](../findings/sym3-blocks.md)'s audit records that the zero set of $F_5$ also contains the orbit of $-W_0$, a different $O(5)$-orbit, and treats that as an obligation the block ignores. It is not: **cubics are odd**, so $q(-gW_0)=-q(gW_0)=0$ follows from vanishing on $O(5)\cdot W_0$ with nothing added. The second orbit imposes no constraint beyond $K$, and $K$ is therefore the whole of what the zero set gives at degree three.

## 2. The branching claim, symbolically

**Branching $B_2\downarrow D_2$ is multiplicity-free with the classical interlacing** $\lambda_1\ge\mu_1\ge\lambda_2\ge|\mu_2|$, $\mu$ integral, in the $e$-basis. The two $\mathfrak{su}(2)$ spins are $\{(\mu_1+\mu_2)/2,\ (\mu_1-\mu_2)/2\}$.

A constituent has one spin equal to zero exactly when $\mu_2=\pm\mu_1$. Both cases force the same $\mu_1$:

- $\mu_2=+\mu_1$: interlacing gives $\mu_1\ge\lambda_2\ge|\mu_2|=\mu_1$, so $\mu_1=\lambda_2$ and $\mu=(\lambda_2,\lambda_2)$;
- $\mu_2=-\mu_1$: the same two inequalities give $\mu_1=\lambda_2$ and $\mu=(\lambda_2,-\lambda_2)$.

So **exactly one constituent has each of the two spins zero** (they are distinct for $\lambda_2>0$ and coincide at $\mu=(0,0)$ when $\lambda_2=0$) and the one whose *first-named* spin vanishes carries the other spin equal to $\lambda_2$. **The block's sentence is correct precisely under $2j_L=\mu_1+\mu_2$**, since it is $(\lambda_2,-\lambda_2)$ that it names as the $j_L=0$ constituent.

> **GAP 1, THE $L/R$ CONVENTION IS UNSTATED, AND THE SENTENCE IS FALSE UNDER THE OTHER READING.** Under the equally common $2j_L=\mu_1-\mu_2$, the constituent $(\lambda_2,-\lambda_2)$ has $j_L=\lambda_2$ and $j_R=0$, so *both* halves of the block's boldface sentence invert. [conventions.md](../findings/conventions.md) carries no entry for $j_L$, $j_R$ or the $\mathfrak{so}(4)$ splitting, and neither does the block. **A reader who takes the other convention derives $j_R=0$ and then reads "$\sigma$ acts by $(-1)^j$" as $(-1)^0=1$ and concludes the rule is vacuous.**

Cross-check on the module the record cares about: $V_{(2,2)}=\mathcal W_5$ branches to $\mu_1=2$, $\mu_2\in\{-2,\dots,2\}$, spins $(0,2),(\tfrac12,\tfrac32),(1,1),(\tfrac32,\tfrac12),(2,0)$ of dimensions $5,8,9,8,5$ summing to $35$, and the two $5$'s are $\mathrm{Sym}^2_0\Lambda^2_\pm$, the self-dual and anti-self-dual halves of the Weyl tensor, which is the right geometry.

## 3. The parity rule, and what $H$ is

**$H$ is never written in the block.** The heading uses $\dim V_\lambda^H$; the body writes $\mathrm{Stab}_{O(5)}(W_0)$ once and $U(2)$ thereafter. Reading adopted here: $H=\mathrm{Stab}_{O(5)}(W_0)$, and **the $U(2)$ is $H^\circ$, a proper subgroup of index $4$**, the block does treat it as such ("what decides is the extra component"), so the question the brief poses is answered correctly in substance.

**Deriving $H$.** $W_0$ is the padded $W_{\mathbb{CP}^2}$: Fubini–Study is self-dual Einstein, so $W_-=0$ and $W_+$ has spectrum $(2,-1,-1)/\sqrt6$ on $\Lambda^2_+$ with the Kähler form as the distinguished eigenvector. Then

- any $g\in O(5)$ fixing $W_0$ preserves the image of $W_0$ in $\Lambda^2$, hence $\mathbb R^4$ and $\mathbb Re_5$;
- no orientation-reversing element of $O(4)$ fixes $W_0$, since a reflection exchanges $\Lambda^2_\pm$ and would move $W_+\ne0$ into the vanishing $W_-$;
- inside $SO(4)=(SU(2)_L\times SU(2)_R)/\pm$ with $SU(2)_R$ the factor acting on $\Lambda^2_+$, the condition is $\mathrm{Ad}(b)\in O(2)$, the stabiliser of the eigen-axis, with $a\in SU(2)_L$ free. So $H\cap SO(5)=(SU(2)_L\times N(T)_R)/\pm$: **identity component $(SU(2)_L\times T_R)/\pm\cong U(2)$, two components, the extra one represented by $\sigma=(1,w)$ with $w$ the $SU(2)_R$ Weyl element.** Times $\{\pm I_5\}$, that is four components, exactly as the block says.

**The rule.** $H^\circ$-invariance is $SU(2)_L$-invariance, forcing the unique $j_L=0$ constituent, then $T_R$-invariance, forcing $m_R=0$ inside spin $j_R=\lambda_2$: **one dimension, for every $\lambda$, which is the block's "always".** On that line $\sigma$ acts by $d^{\,j}_{00}(\pi)=P_j(\cos\pi)=(-1)^{j}$ with $j=j_R=\lambda_2$, a Legendre value, so convention-free at $m=0$, and unaffected by the lift ambiguity of $\sigma$ because $-1\in SU(2)_L$ acts by $(-1)^{2j_L}=+1$. Hence $\dim V_\lambda^H=1$ iff $\lambda_2$ is even. **Confirmed.**

> **GAP 2, *WHICH* $U(2)$ IS THE WHOLE ARGUMENT, AND IT IS NOWHERE.** "$U(2)\subset SO(4)$" does not say that $H^\circ$ contains one $\mathfrak{su}(2)$ factor *entire* and only the torus of the other; without that, "$j_L=0$" is an unmotivated selection criterion rather than the statement of $SU(2)_L$-invariance. **The geometric source, $W_{\mathbb{CP}^2}$ is self-dual, so the factor acting trivially on $\Lambda^2_+$ survives whole, appears neither in the block nor in [conventions.md](../findings/conventions.md), which defines $W_0$ only as "padded $W_{\mathbb{CP}^2}$" under the entry for $M(n)$.**

> **GAP 3, THE WEIGHT-LABEL BASIS IS UNSTATED, AND HERE IT IS LOAD-BEARING FOR A RULE RATHER THAN FOR LABELS.** $\lambda=(\lambda_1,\lambda_2)$ in the $e$-basis is $(\lambda_1-\lambda_2,\ 2\lambda_2)$ in the $\omega$-basis, **whose second coordinate is even for every dominant weight**, so read in the $\omega$-basis the block's rule says "always one-dimensional", which is false and would keep all $24$ blocks. The file's own prose eight lines above the table is in the $\omega$-basis ($\mathcal W_5=4\omega_2$). [r663](REVIEW_r663.md) and [r664](REVIEW_r664.md) flagged the missing basis on [L83](../findings/sym3-blocks.md)'s table; **it propagates here into a statement that inverts.**

**Hand-checks re-derived.** $(1,0)\mapsto1$: $\mathbb R^5$ has $U(2)$-invariants only along $e_5$, and $\sigma\in SO(4)$ fixes it. $(1,1)\mapsto0$: $\Lambda^2\mathbb R^5=\Lambda^2_+\oplus\Lambda^2_-\oplus\mathbb R^4$ has a one-dimensional $U(2)$-invariant, the Kähler form in $\Lambda^2_+$, and $\sigma$ negates it, the block's "complex structure flipping sign", correct. $(2,0)\mapsto1$: in $\mathrm{Sym}^2_0\mathbb R^5$ the invariants are spanned by $4x_5^2-|x|^2_{\mathbb R^4}$. $(2,2)\mapsto1$: the $(j_L,j_R)=(0,2)$ constituent above, invariant spanned by $W_0$ itself, and $\sigma$ acts by $(-1)^2=+1$. **All four check.**

> **HAZARD ON A SPOT THE RECORD HAS ALREADY BEEN BURNT.** "$(1,0)\mapsto1$, realised by $e_5$" is right in the $SO(5)$ reading the block has just installed, and wrong in the $O(5)$ one: [r173](REVIEW_r173.md) established that the $O(5)$-constituent at this label is $[1]\otimes\det\cong\Lambda^4\mathbb R^5$, whose $H$-invariant is $e_1\wedge e_2\wedge e_3\wedge e_4=\star e_5$, while $e_5$ itself is *anti*-invariant under $\varepsilon$. **This is the exact confusion on which a real block was once deleted from the table** (`2cc444bd`, "the parity argument was wrong and deleted a real block"). *No number moves; the wording invites the repeat.*

## 4. $O(5)$ against $SO(5)$

At odd $n$, $\det(-I)=-1$, so $O(5)=SO(5)\times\{\pm I\}$ and the $O(5)$-representations on which $-I$ acts trivially correspond bijectively to $SO(5)$-representations, restricting irreducibly. $\mathcal W_5\subset(\mathbb R^5)^{\otimes4}$ has $-I$ acting by $(-1)^4=+1$, hence so does $\mathrm{Sym}^3(\mathcal W_5)$, so $SO(5)$ labels are legitimate for the whole table.

**The block does state the operative half, and states it well.** Its $\varepsilon$-redundancy paragraph observes that $-\mathrm{Id}$ acts trivially, hence $\varepsilon$ acts as $-\varepsilon=\mathrm{diag}(-1,-1,-1,-1,1)\in SO(5)$, which is $-I_4$ on $\mathbb R^4$ and therefore the scalar $-1$ in $U(2)\subset H^\circ$. **That argument is correct, and it is basis-free: it holds on the $\det$-twisted constituents too, precisely because $\varepsilon=(-I)\cdot(-\varepsilon)$ and $-I$ acts trivially on whichever twist occurs.** So $H$ acts through two effective cosets, $H^\circ$ and $\sigma H^\circ$, which is what the rule needs.

**What is not said:** that this rests on $\det(-I)=-1$ at odd $n$ and fails at even $n$, and that the scope is $n=5$ alone. *Better than the neighbouring block, which [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) found silent on the same point; still a missing scope line.*

## 5. The $36$, and whether it is independent of the $29$

**The arithmetic reproduces exactly.** Sixteen $\lambda_2$-even blocks; their dimensions sum to $3570$; each loses one multiplicity, leaving $41-16=25$; the surviving multiplicities are two $3$'s, five $2$'s, nine $1$'s and eight $0$'s, giving $2\cdot6+5\cdot3+9\cdot1=36$; the eight dying blocks are exactly the eight mult-$1$ even ones the block names. *Screen: the same arithmetic run once over the table, seconds of compute, confirming a hand computation and not evidence for anything positive. Weyl's $B_2$ dimension formula also reproduces all $24$ subscripts.*

**Two internal consistency checks the block does not claim and passes.** Of [L84](../findings/sym3-blocks.md)'s three Casimir collisions, $(4,3)/(5,0)$ and $(5,4)/(6,2)$ each contain a dying block and $(4,1)/(3,3)$ contains none, so "two collisions vanish, one pair still needs the quartic" is exactly right. And $\sum_{\lambda_2\text{ even}}m_\lambda=29$, which is [L59](../findings/sym3-blocks.md)'s number, arrived at from the other side.

> **GAP 4, $65=36+29$ IS ONE COMPUTATION READ TWICE, AND IT SURVIVES THE PERTURBATION THAT MOVES THE $36$.** By construction $36=\sum_\lambda\binom{k_\lambda+1}2$ with $k_\lambda=m_\lambda-[\lambda_2\text{ even}]$ and $29=\sum_\lambda\big(\binom{m_\lambda+1}2-\binom{k_\lambda+1}2\big)=\sum_{\lambda_2\text{ even}}m_\lambda$. **The identity $65=36+29$ therefore holds for *every* assignment of multiplicities to the $24$ labels**, it is a partition of one sum, not a cross-check. Concretely, apply [L83](../findings/sym3-blocks.md)'s own killer witness, swapping the multiplicities of the two dimension-$35$ blocks $(2,2)_{35}$ and $(2,1)_{35}$: $36\to38$ and $29\to27$, **and $65=38+27$ still holds.**

> **AND NO NUMBER ON THE RECORD DISTINGUISHES $36$ FROM $38$.** Under that same swap, $7770$, $41$, $65$, $24$, $89$, the Casimir multiset, $16$, $25$ and (critically), **$3570$ are all unchanged**, the last because $\sum_{\lambda_2\text{ even}}d_\lambda$ involves no multiplicity at all. So [L87](../findings/sym3-blocks.md)'s mod-$p$ Gram rank, which proves every even block's evaluation map is nonzero, **provides no check on the multiplicity column whatever.** The $36$ is one arithmetic on [L83](../findings/sym3-blocks.md)'s imported column, and it is exactly as strong as that column and no stronger. *The only quantity in the file that does detect the swap is the shape "two $3\times3$, five $2\times2$, nine scalars", and [r204](REVIEW_r204.md) already recorded that this assert "tests the multiplicity table against the $\lambda_2$-even rule and tests the rule against nothing".*

**BLOCKED, and named as the brief requires.** The check that would close this is **$\dim(\mathrm{Sym}^3\mathcal W_5)^H\overset?=29$**, since $\dim V^H=\sum_\lambda m_\lambda\dim V_\lambda^H=\sum_{\lambda_2\text{ even}}m_\lambda$. It is a character integral over $H=U(2)\cup\sigma U(2)$, needing no adapted basis, no prime, and no linear algebra on the $7770$; it touches neither the block table nor the certificate machinery, so it is genuinely external. **Outcomes:** $29$ anchors the even-block multiplicity sum externally and makes $36=65-29$ anchored with it; **anything else refutes either the multiplicity column or the parity rule**, and would move a number every downstream result uses. *Under the standing analysis-only rule this needs explicit approval, which this review does not have. It is not opened here.*

## 6. Whether L59 and L62 may rest on this as they do

**[L62](../findings/sym3-blocks.md): yes, unreservedly.** Its use is the single statement $\dim\mathcal W_5^H=1$ at $\lambda=(2,2)$, which I derived independently in §2–§3 from the branching alone: the $(j_L,j_R)=(0,2)$ constituent, its $m_R=0$ line, and $\sigma$ acting by $(-1)^2=+1$. **This use touches no multiplicity and no table entry, so it is immune to everything in §5.** The block's own hand-check list carries "$(2,2)\mapsto1$", so the two statements agree explicitly as well as in substance. *The companion audit's reading is confirmed.*

**[L59](../findings/sym3-blocks.md): yes for the rule, with one correction to how its verification was scored.** The qualitative half it consumes (an odd-$\lambda_2$ block dies entirely, an even one has $K$ of codimension one), is exactly §1's conclusion plus [L87](../findings/sym3-blocks.md), and is proved. But [r651](REVIEW_r651.md) and [r652](REVIEW_r652.md) record "$65=36+29$ IS THE STRONGEST PART OF THE BLOCK, AND BOTH REVIEWERS VERIFIED IT BY HAND": **checking that identity by hand, block by block, verifies nothing beyond the column it is computed from, because it holds identically under any multiplicity assignment.** The real content of L59's numbers is the multiplicity column, which neither reviewer could have tested this way. *No number of L59's moves; its evidential standing does.*

## 7. Provenance, pointers, duplication, and the block's own file

**Provenance is clean, which is rare in this file.** `git log -S` puts the orbit-constraint paragraph in `b432dfd7` ("the Sym^3(Weyl_5) block structure gets its own file", 2026-08-28), where the sentence already read *"branching leaves exactly one constituent with $j_-=0$, and $\dim V_\lambda^H=1$ iff the second label is even"*, the conclusion, from reviewer 174, without a mechanism. `f25586af` ("the branching rule gets its mechanism") replaced $j_-$ by the $L/R$ split and added the $(\lambda_2,-\lambda_2)$ constituent, the $\sigma$ argument, the hand-checks and the $\varepsilon$ paragraph. **The conclusion is unchanged across the rewrite and the commit body matches the diff exactly. No narrowing commit and no manufactured pointer here**, unlike [L59](../findings/sym3-blocks.md), [L61](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) in the same file.

**Pointers: there are none.** The block contains no link of any kind, so nothing fails to resolve, and **four dependencies are consumed uncited**: [L83](../findings/sym3-blocks.md) for the multiplicity column that the $36$ is computed from, [L87](../findings/sym3-blocks.md) for the rank-one step, [L84](../findings/sym3-blocks.md) for the collisions it says vanish, and [conventions.md](../findings/conventions.md)/[L61](../findings/sym3-blocks.md) for $W_0$, which is used two words after it is first named and defined far below in the same file.

**Duplication: none of the derivation, some of the consequence.** The branching argument and the parity rule appear once on the record, here. The *consequences* are restated verbatim in three places, [L59](../findings/sym3-blocks.md)'s body, [results.md](../results.md) line 586, and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) line 899, all three carrying "an odd-$\lambda_2$ block dies entirely" and "$65=36+29$", so GAP 4 propagates to all three unchanged.

> **THE FILE ANSWERS PART OF IT, AND THE ANSWER SITS UNDER THE WRONG HEADING, IN MIRROR IMAGE OF THE PATTERN THE BRIEF NAMES.** Three of the seven paragraphs under L86's heading are about **[L87](../findings/sym3-blocks.md)**: the rank-one objection, its resolution by 174's measured $3570$, and "the check that would remove the dependency". [L87](../findings/sym3-blocks.md)'s own heading then carries a single paragraph that **supersedes all three**, it proves what L86's text calls measured, and settles the dependency L86's last paragraph proposes a check for. **So L86's block ends with a superseded account of a step it needs, and a reader who stops at the next heading has the stale version.** *The three paragraphs belong under [L87](../findings/sym3-blocks.md); the last of them should go.*

## 8. What would repair the block

1. Name the convention $2j_L=\mu_1+\mu_2$, and say $H=\mathrm{Stab}_{O(5)}(W_0)$ in the body rather than only in the heading, **two clauses, and GAP 1 closes.**
2. Say that $W_{\mathbb{CP}^2}$ is self-dual, so $H^\circ=U(2)$ contains $SU(2)_L$ whole and only $T_R$, **one sentence, and GAP 2 closes and the argument becomes readable.**
3. Say the labels are $e$-basis, **four words, and GAP 3 closes.**
4. Say that the $36$ is one arithmetic on [L83](../findings/sym3-blocks.md)'s multiplicity column, that $29=65-36$ is its complement rather than a check, and that $3570$ does not test the column, **and add the $\dim(\mathrm{Sym}^3\mathcal W_5)^H$ integral to the plan as the check that would.**
5. Move the three rank-one paragraphs under [L87](../findings/sym3-blocks.md), and cite [L83](../findings/sym3-blocks.md), [L84](../findings/sym3-blocks.md) and [L87](../findings/sym3-blocks.md).

*None of these moves a number. $16$, $3570$, $25$, $36$, the shape and the eight deaths stand exactly as written, conditional on [L83](../findings/sym3-blocks.md)'s column and [L87](../findings/sym3-blocks.md)'s rank, and the record has nothing that tests the first of those two.*
