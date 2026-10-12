# Verifier v261, Lemma L59: the apolarity adjunction, ANN as the adjoint's kernel, the two displays, injectivity of Cat, the count 65 = 36 + 29, the necessary-condition sentence, and the Lean statement

The brief ([BRIEF_L59.md](BRIEF_L59.md)) was read cold. No numerical work was done, every value below is exact and obtained by hand, and no script was written or run (the Lean file was read, and was not built). Log: [agent_logs/verify-L59-v261.log](../agent_logs/verify-L59-v261.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The adjunction $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, and $\mathrm{ANN}=\{F:\mathrm{Cat}_F(K,K)=0\}$ as the kernel of the adjoint of $\mu_K$ | HYPOTHESIS-DEBT |
| 2 | $\mathrm{rank}(\mu_K)=14-\dim\mathrm{ANN}$ | CONFIRMED AS ALGEBRA |
| 3 | $F_5\in\mathrm{image}(\mu_K)\iff F_5\perp\mathrm{ANN}$ | CONFIRMED AS ALGEBRA |
| 4 | $\mathrm{Cat}$ injective on the invariant sextics, a copy of the $14$ inside the $65$ | CONFIRMED AS ALGEBRA |
| 5 | $29$ forms vanish on $K\times K$, block by block, and $65=36+29$ | CONFIRMED AS ALGEBRA |
| 6 | "The count is the necessary condition; Lemma L62 shows it is met" (Passage C) | GAP |
| 7 | Passage G, the Lean statement, against Passage A | CONFIRMED AS ALGEBRA |

**Summary:** the linear algebra from the adjunction to both displays is correct and the block arithmetic is exact, but the pairing, $\mu$, $\mathrm{Cat}_F$, $B$ and "the invariants supported on $K$" are never defined, and the step identifying $\mathrm{ANN}$ with the adjoint's kernel is not written. Overall verdict: **HYPOTHESIS-DEBT**.

## 0. Conventions, fixed once

- Quotations were checked against their sources by displaying only the cited lines. Passage A matches [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 299-303 under the heading at line 281. Passages D, E and the five headings of Passage F match lines 5-13, 108-122, 15, 68, 94, 124 and 138 (Passage D differs only in a link path rewritten relative to the brief). Passages B and C match [results.md](../results.md) lines 216 and 741, under the heading at line 739. Passage G is byte-identical to [L59Statement.lean](../lean/HamiltonsCubic/Results/L59Statement.lean) (the file has 178 newline-terminated lines where the brief says 179, a count of the trailing line only).
- The standing of L83, L85, L86 and L87 is taken as given, per the brief's scope. L83's table was read at lines 33-38.
- Notation used below, all of it drawn from the passages: $\lambda=(\lambda_1,\lambda_2)$ a block of $\mathrm{Sym}^3\mathcal W_5$, $M_\lambda$ its multiplicity space, $m_\lambda=\dim M_\lambda$, $V_\lambda$ the irreducible, $d_\lambda=\dim V_\lambda$, $H=\mathrm{Stab}_{O(5)}(W_0)$, and $V$ the $14$-dimensional space of invariant sextics.
- Where the record gives no definition, this report names what the passage needs and does not adopt a definition to prove under. Descriptions of the form "under the reading X" say what a passage would require, and are not a proof supplied on the record's behalf.

## Hypothesis inventory

| Object or hypothesis | Where defined | Used by the argument | Status |
|---|---|---|---|
| $\mathcal W_5$, the $O(5)$-action | Passage D | throughout | defined |
| $\mathrm{Sym}^3$, "the span of cubics" | Passage E writes $\mathrm{Sym}^3(\mathcal W_5)$, Passage C writes "cubics" | the domain of $K$ and of the forms | the identification of $\mathrm{Sym}^3\mathcal W_5$ with cubic polynomials on $\mathcal W_5$ needs an inner product on $\mathcal W_5$, which Passage E mentions ("the inner product on $\mathcal W_5$ in the weight basis") and no quoted passage defines |
| The blocks, $m_\lambda$, $d_\lambda$ | L83's table | the $29$, the $36$, the $65$ | given |
| $M_\lambda$ | used in Passages A and E, never defined | "K containing all of $M_\lambda$" | standard multiplicity space, undefined in the quotes |
| $W_0$ and the orbit constraint | Passage E | defines $K$ | defined |
| $K$ | Passage E, via $\mathrm{ev}_\lambda:M_\lambda\to V_\lambda^H$ | the domain of $\mu_K$, $\mathrm{ANN}$, the $29$ | defined as $\bigoplus_\lambda\ker(\mathrm{ev}_\lambda)\otimes V_\lambda$, an $O(5)$-submodule, with codimension $1$ in $M_\lambda$ for the $16$ even blocks by L86 and L87 |
| $V$, $\dim V=14$ | L85 | the "$14$" of the rank display | given |
| $F_5$ | not in Passage A. Passage E says it vanishes on the orbit, and the Lean docstring writes $(3/2)\lVert W\rVert^6-9\,\mathrm{tr}(W^3)^2$ | both displays place $F_5$ in $V$ | **used, unstated in L59**: that $F_5$ is $O(5)$-invariant |
| The pairing $\langle\cdot,\cdot\rangle$ on sextics | **never named** | "$F_5\perp\mathrm{ANN}$", the adjunction | **used, undefined**: needs nondegeneracy on $V$ (both displays) and $O(5)$-invariance (claim 1) |
| The pairing on forms | **never named** | the adjunction, "supported on $K$" versus "killing $K\times K$" | **used, undefined**: needs nondegeneracy and invariance, and an identification of $\mathrm{Sym}^2(\mathrm{Sym}^3)$ with $\mathrm{Sym}^2((\mathrm{Sym}^3)^*)$ for "splits" in claim 5 |
| $\mu$ | **never defined** | the domain and codomain of every map | **used, undefined**: must send a symmetric tensor $B$ on $\mathrm{Sym}^3$ to a sextic, and be $O(5)$-equivariant so that $\mu_K$ lands in $V$ |
| $\mathrm{Cat}_F$ | named "catalecticant" in Passage C, never defined | $\mathrm{ANN}$, injectivity | **used, undefined**: must be a symmetric bilinear form on $\mathrm{Sym}^3$, invariant when $F$ is |
| $B$ | never defined | the adjunction | **undefined**, and the symbol also denotes $-\tfrac12\mathrm{tr}(XY)$ on $\mathfrak{so}(5)$ in Passage D (withdrawn candidate 1.W2) |
| "the invariants supported on $K$", call it $S$ | **never defined** | the domain of $\mu_K$, the $36$ | **used, undefined**: the count $36$ fits $S=\mathrm{Sym}^2(K)^{O(5)}$ |
| Surjectivity of the unrestricted $\mu$ | asserted in Passage A | injectivity of $\mathrm{Cat}$ | **asserted, no argument on file** |
| Real type of every $V_\lambda$, Schur orthogonality between inequivalent blocks | not stated | "$65$" as $\sum m_\lambda(m_\lambda+1)/2$, "counted block by block" | **used, unstated**, and part of L83/L88's standing for the $65$ |
| Reduction of a certificate to an invariant Gram form supported on $K$ | Passage E supplies support on $K$ ("every covariant entering a certificate vanishes there"), nothing supplies invariance | "the certificate's necessary condition" | **used, the invariance half unstated** (claim 6) |

## 1. The adjunction and ANN as the adjoint's kernel: HYPOTHESIS-DEBT

**What Passage A says.** "Apolarity gives $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, so, for $\mu_K$ the restriction of $\mu$ to the invariants supported on $K$," the two displays follow. The word "so" is the entire argument from the adjunction to the displays.

**Attack item 1, the adjunction.**

- The left pairing lives on sextics: $F$ is a sextic and $\mu(B)$ must be one. The right pairing lives on forms over $\mathrm{Sym}^3$: $\mathrm{Cat}_F$ is a bilinear form on $\mathrm{Sym}^3$, and $B$ must be an element of the space dual to it, a symmetric tensor in $\mathrm{Sym}^2(\mathrm{Sym}^3)$ that $\mu$ multiplies out to a sextic.
- Neither pairing is named in any quoted passage. The word "apolarity" points to the apolar pairing, but no normalisation, no basis, and no statement of which space carries it appears.
- Whether the identity is a theorem or the definition of $\mathrm{Cat}$ depends on the definitions that are missing. If $\mathrm{Cat}_F$ is defined as $(p,q)\mapsto\langle F,pq\rangle$ and $\mu(B)$ as the multiplication of a symmetric tensor, the identity is the definition of the adjoint extended by linearity. If $\mathrm{Cat}_F$ is defined as a matrix of coefficients of $F$, the identity is a theorem needing a proof on file. The record supplies neither version.

**Attack item 2, ANN.** The adjoint of $\mu_K:S\to V$ is $\mu_K^*:V\to S$ with $\langle F,\mu_K(B)\rangle=\langle\mu_K^*F,B\rangle$ for $B\in S$. From the adjunction, $\ker\mu_K^*=\{F\in V:\langle\mathrm{Cat}_F,B\rangle=0\ \text{for all}\ B\in S\}$. Passage A defines $\mathrm{ANN}=\{F\in V:\mathrm{Cat}_F(K,K)=0\}$. The two sets agree only through a step the record does not write.

- **The easy inclusion.** $\mathrm{Cat}_F(K,K)=0$ gives $\langle\mathrm{Cat}_F,B\rangle=0$ for every $B$ built from tensors of elements of $K$, once the pairing on forms is the contraction of a form against a tensor. This uses only that pairing's definition, which is owed.
- **The inclusion that needs more.** $\mathrm{Cat}_F$ orthogonal to every *invariant* element of $\mathrm{Sym}^2(K)$ implies $\mathrm{Cat}_F(k,k')=0$ for *all* $k,k'\in K$ only with three further facts in place: (a) $K$ is an $O(5)$-submodule (Passage E supplies this), (b) $F\mapsto\mathrm{Cat}_F$ is equivariant, so $\mathrm{Cat}_F$ is invariant for invariant $F$ (unstated), and (c) the pairing on forms is $O(5)$-invariant, so that averaging over the compact group moves orthogonality from invariant tensors to all tensors, or equivalently invariant forms pair block by block with no cross terms (unstated). No quoted passage states (b) or (c), and none contains the step.
- The Lean file's own docstring records this step as "genuinely absent" and declares it untyped. That is consistent with what I find in Passage A itself.

**What would have to be supplied.** Definitions of both pairings, of $\mu$, of $\mathrm{Cat}_F$, of $B$'s space and of $S$. The equivariance of $\mu$ and of $F\mapsto\mathrm{Cat}_F$, and the invariance and nondegeneracy of the pairings. The written step $\mathrm{Cat}_F\perp S\Rightarrow\mathrm{Cat}_F(K,K)=0$ using (a), (b), (c).

**Three-step record.**

1. *Location:* "let $\mathrm{ANN}$ be the invariant sextics $F$ with $\mathrm{Cat}_F(K,K)=0$. Apolarity gives $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$, so, for $\mu_K$ [...]" (sym3-blocks.md line 299).
2. *Failure exhibited:* the displays need $\mathrm{ANN}=\ker\mu_K^*$. The adjunction gives $\ker\mu_K^*=\{F:\mathrm{Cat}_F\perp S\}$, a condition on pairings with invariant tensors only, while $\mathrm{ANN}$ is defined by vanishing on all of $K\times K$. The implication from the first to the second uses (b) and (c), which appear nowhere, and the objects $\mu$, $\mathrm{Cat}_F$, $B$, $S$ and both pairings on which it would be argued are undefined. No closed-form counterexample is exhibited, because constructing one would require choosing a non-invariant pairing, which is choosing a definition the record does not give.
3. *Charitable reading:* "apolarity" is standard and, under the apolar pairing induced by an $O(5)$-invariant inner product on $\mathcal W_5$, facts (b) and (c) are standard. This reading supports the claim's plausibility and still leaves the definitions and the step unwritten. The candidate survives as debt, not as an error.

### 1.W Withdrawn candidates

- **1.W1, the Lean docstring's "ANN is ker Cat" as a contradiction with injectivity.** (1) Lean docstring: "`ANN` is `ker Cat`", and theorem `cat_injective_of_mu_surjective` proves `Cat` injective. (2) If both `Cat` were one map, $\mathrm{ANN}=\ker\mathrm{Cat}=0$ identically. (3) In the Lean file each `Cat` is a variable bound in its own theorem: the adjoint of `muK` in the rank theorem and the adjoint of the unrestricted `mu` in the injectivity theorem. In the record the first is $\mu_K^*$, the projection of $\mathrm{Cat}_F$ onto $S$, and the second is $\mathrm{Cat}$ itself. No statement is wrong. Withdrawn, noted as a naming hazard.
- **1.W2, the symbol $B$.** (1) Passage D: "The normalisation is $B(X,Y)=-\tfrac12\operatorname{tr}(XY)$", and Passage A: "$\langle F,\mu(B)\rangle$". (2) One file uses one letter for a form on $\mathfrak{so}(5)$ and for a tensor on $\mathrm{Sym}^3$. (3) The two sit under different headings, one near the top of the file and one under L59's, and $\mu(B)$ cannot take a form on $\mathfrak{so}(5)$. No mathematical consequence. Withdrawn.

## 2. rank(mu_K) = 14 - dim ANN: CONFIRMED AS ALGEBRA

**Derivation, as a check of the word "so".** Let $\mu_K:S\to V$ be linear, with $V$ finite-dimensional, $\dim V=14$, carrying a nondegenerate pairing, and let $\mu_K^*$ satisfy $\langle F,\mu_K(B)\rangle=\langle\mu_K^*F,B\rangle$ with a nondegenerate pairing on $S$.

- $F\in\ker\mu_K^*$ iff $\langle\mu_K^*F,B\rangle=0$ for all $B\in S$ (nondegeneracy on $S$) iff $\langle F,\mu_K(B)\rangle=0$ for all $B$ iff $F\in\mathrm{image}(\mu_K)^\perp$.
- Nondegeneracy on $V$ gives $\dim W+\dim W^\perp=\dim V$ for every subspace $W$ of $V$. Hence $\mathrm{rank}(\mu_K)+\dim\ker\mu_K^*=14$.
- With $\mathrm{ANN}=\ker\mu_K^*$ (claim 1), the display follows.

**Dependencies.** The $14$ is L85's. $\mathrm{image}(\mu_K)\subseteq V$ needs $\mu$ equivariant (inventory). $\mathrm{ANN}=\ker\mu_K^*$ carries claim 1's debt. The step from the adjunction to the display is correct.

**Attack item 8, the edges.**

- $\dim\mathrm{ANN}=0$: $\mathrm{rank}(\mu_K)=14$, so $\mu_K$ maps onto $V$. Consistent.
- $\dim\mathrm{ANN}=14$: $\mathrm{ANN}=V$, $\mathrm{image}(\mu_K)=V^\perp=0$, so $\mu_K=0$. Consistent. The truncated subtraction in $\mathbb N$ is harmless here since $\mathrm{ANN}\subseteq V$ forces $\dim\mathrm{ANN}\le14$.
- $K=\mathrm{Sym}^3$: $S$ is all $65$ invariant forms, $\mathrm{ANN}=\{F:\mathrm{Cat}_F=0\}=0$ by claim 4, so the display gives $\mathrm{rank}=14$. This agrees with Passage A's own assertion that the unrestricted $\mu$ is surjective. The sentences are mutually consistent at this edge. In the record's actual instance $K\neq\mathrm{Sym}^3$, because the $16$ even blocks each have codimension $1$ in $M_\lambda$ (L87, given).
- $K=0$: $S=0$, $\mathrm{rank}=0$, $\mathrm{ANN}=V$, $\dim\mathrm{ANN}=14$. Consistent.

## 3. F_5 in image(mu_K) iff F_5 perp ANN: CONFIRMED AS ALGEBRA

**Derivation.** From section 2, $\ker\mu_K^*=\mathrm{image}(\mu_K)^\perp$. With a nondegenerate pairing on the finite-dimensional $V$, $(W^\perp)^\perp=W$. Hence $F_5\in\mathrm{image}(\mu_K)$ iff $F_5\in(\ker\mu_K^*)^\perp$ iff $F_5\perp\ker\mu_K^*=\mathrm{ANN}$.

**Dependencies.** $F_5\in V$, that is $F_5$ invariant, is used and not stated in L59. The pairing in "$\perp$" must be the same one as in the adjunction. $\mathrm{ANN}=\ker\mu_K^*$ carries claim 1's debt.

**Edges.** At $\dim\mathrm{ANN}=0$ the right side is vacuous and every invariant sextic, $F_5$ included, lies in the image. At $\dim\mathrm{ANN}=14$ both sides say $F_5=0$. At $K=\mathrm{Sym}^3$ both sides hold for every $F_5\in V$.

**Scope of $\mu$ (standing item 2).**

| Sentence of Passage A | Which map "$\mu$" denotes |
|---|---|
| "Apolarity gives $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$" | the unrestricted $\mu$, universally quantified over $F$ and $B$ |
| "for $\mu_K$ the restriction of $\mu$ to the invariants supported on $K$" | defines $\mu_K=\mu\vert_S$ |
| the two displays | $\mu_K$ |
| "the unrestricted $\mu$ is surjective, so its adjoint is injective" | the unrestricted $\mu$, in one of two readings: all forms to all sextics, or the $65$ invariant forms to the $14$ invariant sextics (claim 4) |
| "$\mathrm{ANN}$" | the kernel of $\mu_K^*$, the projection of $\mathrm{Cat}_F$ onto $S$, and never the kernel of $\mathrm{Cat}$ |

### 3.W Withdrawn candidate

- **3.W1, Passage B drops the subscript.** (1) results.md line 216: "apolarity gives $\mathrm{rank}=14-\dim\mathrm{ANN}$ and $F_5\in\mathrm{image}$ iff $F_5\perp\mathrm{ANN}$". (2) Read with the unrestricted $\mu$, whose rank Passage A says is $14$, the display forces $\dim\mathrm{ANN}=0$ for every $K$, and that fails at $K=0$, where $\mathrm{ANN}=V$ and $14\neq14-14$. (3) Passage B is the landscape abbreviation of Passage C, which writes $\mu_K$ explicitly, and $\mathrm{ANN}$ is defined through $K$, which only the restricted map sees. Withdrawn, recommended fix: write $\mathrm{rank}(\mu_K)$ and $\mathrm{image}(\mu_K)$ in Passage B.

## 4. Cat injective on the invariant sextics, a copy of the 14 inside the 65: CONFIRMED AS ALGEBRA

**Derivation of the written implication.** Let $\mu:X\to Y$ be surjective with adjoint $\mathrm{Cat}$ under nondegenerate pairings. If $\mathrm{Cat}\,F=0$ then $\langle F,\mu(B)\rangle=0$ for all $B$, so $F\perp Y$, so $F=0$. The adjoint of a surjection is injective. Correct.

- **Reading 1**, $\mu$ from all symmetric tensors on $\mathrm{Sym}^3$ onto all sextics. $\mathrm{Cat}$ is injective on all sextics, hence on $V$. Placing $\mathrm{Cat}(V)$ inside the $65$ *invariant* forms additionally needs $\mathrm{Cat}_F$ invariant for invariant $F$, fact (b) of claim 1, unstated.
- **Reading 2**, $\mu$ from the $65$ invariant forms onto $V$. $\mathrm{Cat}(V)$ lies in the $65$ by construction, and injectivity follows. Surjectivity of this restricted map needs averaging over $O(5)$ and equivariance, unstated.
- **In both readings** the premise "the unrestricted $\mu$ is surjective" is asserted with no argument on file. The claim's argument is correct given its premise, and the premise joins claim 1's debt list.
- "A copy of the $14$": $\dim\mathrm{Cat}(V)=14\le65$ is an injective linear image. Correct.

**Edge $K=\mathrm{Sym}^3$.** Here $\mu_K$ is the unrestricted invariant $\mu$ of reading 2, and claim 2's display with $\mathrm{ANN}=\ker\mathrm{Cat}\vert_V=0$ returns rank $14$, matching the asserted surjectivity.

## 5. The count 65 = 36 + 29: CONFIRMED AS ALGEBRA

**The per-block rule, derived.** In block $\lambda$ the invariant symmetric forms are $\mathrm{Sym}^2(M_\lambda)$, a space of dimension $m_\lambda(m_\lambda+1)/2$. That uses real type and block orthogonality, which are part of the $65$'s standing. $K$ meets the block in $U_\lambda\otimes V_\lambda$ with $U_\lambda=\ker\mathrm{ev}_\lambda$.

- **Odd $\lambda_2$.** $V_\lambda^H=0$ (L86), so $U_\lambda=M_\lambda$ and $K$ contains the whole block. A form vanishing on $K\times K$ is zero there, contributing $0$. This is "an odd-$\lambda_2$ block dies entirely".
- **Even $\lambda_2$.** $U_\lambda$ has codimension $1$ in $M_\lambda$ (L87). Choose a basis $e_1,\dots,e_{m-1}$ of $U_\lambda$ and $e_m$. A symmetric $C$ with $C(U_\lambda,U_\lambda)=0$ has free entries $C_{im}=C_{mi}$ for $i\le m$, which is $m_\lambda$ parameters, all of the form $u\otimes v+v\otimes u$ with $u=e_m^*$ fixed and $v$ ranging over $M_\lambda^*$. This is "an even one keeps $u\otimes v+v\otimes u$", and it contributes $m_\lambda$. Passage A does not say $u$ is fixed. The total $29$ is reached only under that reading, and the reading is the one the $29$ determines.
- **Unknowns supported on $K$.** The invariant tensors in $\mathrm{Sym}^2(U_\lambda)$ number $m_\lambda(m_\lambda-1)/2$ for even blocks and $m_\lambda(m_\lambda+1)/2$ for odd ones.

**From L83's table (lines 33-38), every row checked.**

| $m$ | even-$\lambda_2$ blocks | odd-$\lambda_2$ blocks | even contribution to $29$ | $36$: even $m(m-1)/2$ + odd $m(m+1)/2$ | $65$: $m(m+1)/2$ per block |
|---|---|---|---|---|---|
| $4$ | $(4,2)_{220}$, $(2,2)_{35}$ | none | $4+4=8$ | $6+6=12$ | $20$ |
| $3$ | $(3,2)_{105}$ | none | $3$ | $3$ | $6$ |
| $2$ | $(5,2)_{390}$, $(4,4)_{165}$, $(4,0)_{55}$, $(3,0)_{30}$, $(2,0)_{14}$ | $(4,3)_{231}$, $(4,1)_{154}$, $(3,1)_{81}$, $(2,1)_{35}$ | $5\cdot2=10$ | $5\cdot1+4\cdot3=17$ | $27$ |
| $1$ | $(6,6)_{455}$, $(6,4)_{810}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,0)_{91}$, $(1,0)_5$, $(0,0)_1$ | $(6,3)_{770}$, $(5,3)_{455}$, $(5,1)_{260}$, $(3,3)_{84}$ | $8\cdot1=8$ | $8\cdot0+4\cdot1=4$ | $12$ |
| total | $16$ blocks | $8$ blocks | $29$ | $36$ | $65$ |

- $29=8+3+10+8$. Exact.
- $36=12+3+17+4$, which regroups as even $6+6+3+5=20$ plus odd $12+4=16$, matching Passage E's "$36$" and the Lean file's "$36=20+16$". Exact.
- $65=20+6+27+12$. Exact.
- Cross-checks against Passage E, all exact: the even blocks number $16$; their dimensions sum to $220+35+105+390+165+55+30+14+455+810+625+140+429+91+5+1=3570$; the multiplicities total $41$, of which even blocks carry $29$ and odd blocks $12$; the surviving multiplicities number $41-16=25$; the shape is two $3\times3$ from $(4,2)$ and $(2,2)$, five $2\times2$ from $(3,2)$ and the four odd $m=2$ blocks, and nine scalars from the five even $m=2$ and four odd $m=1$ blocks; and the eight dying blocks are exactly the eight even $m=1$ blocks listed in Passage E.

**What the identity checks.** Per block, $m(m+1)/2=m(m-1)/2+m$ for even blocks and $m(m+1)/2=m(m+1)/2+0$ for odd ones. So $65=36+29$ holds identically once each summand is computed by the rule. It confirms that Passage E's $36$ and Passage A's $29$ were computed from the same table under the same parity and rank-one rule. It checks nothing about the representation theory behind the multiplicities or the ranks.

**"Splits the invariant forms".** The $36$ lie in $\mathrm{Sym}^2(\mathrm{Sym}^3)$ (tensors that $\mu$ multiplies) and the $29$ in $\mathrm{Sym}^2((\mathrm{Sym}^3)^*)$ (forms that vanish on $K\times K$). As a dimension count, $65=\dim S+\dim S^0$ holds with $S^0$ the annihilator, with no identification needed. As a splitting of one space into complementary subspaces, it needs the unnamed pairing to identify the two, and then the $29$ are $S^\perp$. The count is confirmed. The word "splits" inherits claim 1's debt.

### 5.W Withdrawn candidates

- **5.W1, "codimension 1 there".** (1) sym3-blocks.md line 303: "an even one keeps $u\otimes v+v\otimes u$, $K$ having codimension $1$ there". (2) Read literally in the block $M_\lambda\otimes V_\lambda$, the codimension is $d_\lambda$, not $1$. For $(2,0)_{14}$ with $m=2$, $K$ meets the $28$-dimensional block in a $14$-dimensional subspace, codimension $14$. (3) The preceding clause, "$K$ containing all of $M_\lambda$", already uses $M_\lambda$ as the stand-in for the block. "There" means $M_\lambda$, where the codimension is $1$ and the count $m_\lambda$ follows. Withdrawn.
- **5.W2, "dies" used for opposite sides of the split.** (1) Passage E: "Eight of the twelve multiplicity-$1$ blocks die outright", meaning they have no unknowns. Passage A: "an odd-$\lambda_2$ block dies entirely", meaning it contributes no form killing $K\times K$. (2) The eight blocks that "die" in E are even and contribute to the $29$. The blocks that "die" in A are odd and contribute everything to the $36$. (3) Each sentence says which count it speaks of, and every number is right under that reading. Withdrawn, noted as a terminology hazard.

## 6. "The count is the necessary condition; Lemma L62 shows it is met": GAP

**What is proven.** Claims 2 and 3 establish, modulo claim 1, that $F_5\in\mathrm{image}(\mu_K)$ iff $F_5\perp\mathrm{ANN}$.

**What "necessary" must connect.** A certificate here is $F_5=\mu(B)$ with $B$ positive semidefinite. For the necessary condition to be $F_5\in\mathrm{image}(\mu_K)$, a certificate must yield a $B$ that is (i) supported on $K$ and (ii) invariant.

- (i) is Passage E's "every covariant entering a certificate vanishes there". Each square's cubic vanishes on the orbit, hence lies in $K$. That step uses positive semidefiniteness, since a Gram tensor that is not positive semidefinite need not be supported on $K$.
- (ii) needs averaging $B$ over $O(5)$, with $\mu$ equivariant, $F_5$ invariant, and $K$ a submodule so that the average stays supported on $K$. No quoted passage states it.

**The count versus the condition.** The proven necessary condition is $F_5\perp\mathrm{ANN}$, a condition on $F_5$. A dimension count, $\dim\mathrm{ANN}=0$ or equivalently $\mathrm{rank}(\mu_K)=14$, is a *sufficient* condition for it. It is not necessary: by claim 3, $\dim\mathrm{ANN}\ge1$ with $F_5\perp\mathrm{ANN}$ also puts $F_5$ in the image. The count $65=36+29$ gives $\dim S=36\ge14$, which is necessary for $\mathrm{rank}(\mu_K)=14$ and decides nothing about $F_5$ by itself.

**Attack item 6, the positive semidefinite half.** Membership in the image says the affine space $\{B\in S:\mu_K(B)=F_5\}$ is nonempty, of dimension $36-\mathrm{rank}(\mu_K)$, which is $22$ when $\dim\mathrm{ANN}=0$. A certificate needs that affine space to meet the positive semidefinite cone, blockwise in the two $3\times3$, five $2\times2$ and nine scalar blocks. The count says nothing about that intersection. "Lemma L62 shows it is met" is outside this brief, and I did not check it.

**Three-step record.**

1. *Location:* results.md line 741: "The count is the necessary condition; Lemma L62 shows it is met." Also line 216, title: "The certificate's necessary condition is one dimension count."
2. *Failure exhibited:* Passage A derives the necessary condition as the orthogonality $F_5\perp\mathrm{ANN}$. The count $\dim\mathrm{ANN}=0$ implies that condition, and claim 3's equivalence shows the converse is not implied, because any $\mathrm{ANN}$ of positive dimension orthogonal to $F_5$ satisfies the condition with the count unmet. Separately, the reduction from "a certificate exists" to "$F_5\in\mathrm{image}(\mu_K)$" needs the invariance step (ii), which is not written. This is a missing link and a misstated logical direction, not a false conclusion about the actual objects, whose truth values are L62's business.
3. *Charitable reading:* "one dimension count" means the necessary condition is *decided* by computing $\dim\mathrm{ANN}$. If it is $0$ the condition holds for any $F_5$, and L62 is cited for that. This reading holds for the branch $\dim\mathrm{ANN}=0$ and makes the count a sufficient test, which is still not "the necessary condition". The invariance step remains unwritten under every reading. The candidate survives as GAP: what is proven is narrower than what is stated.

## 7. Passage G, the Lean statement: CONFIRMED AS ALGEBRA

**Attack item 7, what the file types.** The file uses real inner product spaces `B` and `V`, linear maps `muK` and `Cat`, and the adjunction `hadj : ∀ F b, ⟪F, muK b⟫ = ⟪Cat F, b⟫` as a hypothesis. It proves four theorems, each read line by line.

- `ker_adj_eq_range_orthogonal`. Forward: $\mathrm{Cat}\,F=0$ gives $\langle F,\mu_K b\rangle=\langle0,b\rangle=0$. Backward: $\langle\mathrm{Cat}\,F,b\rangle=0$ for all $b$, applied to $b=\mathrm{Cat}\,F$, gives $\mathrm{Cat}\,F=0$ by positive definiteness. Correct.
- `rank_add_dim_ann`: `finrank (range muK) + finrank (ker Cat) = 14` from `finrank_add_finrank_orthogonal` in the finite-dimensional `V`. This is claim 2 with $\mathrm{ANN}$ typed as $\ker\mu_K^*$. The additive form avoids truncated subtraction, as the docstring says.
- `mem_range_iff_orthogonal_ann`: `F5 ∈ range muK ↔ ∀ G ∈ ker Cat, ⟪F5, G⟫ = 0` via `orthogonal_orthogonal`, which needs the range to admit orthogonal projection, and that holds because `V` is finite-dimensional. This is claim 3 with $\mathrm{ANN}$ typed as $\ker\mu_K^*$.
- `cat_injective_of_mu_surjective`: $\ker\mathrm{Cat}=(\mathrm{range}\,\mu)^\perp=\top^\perp=\bot$. This is claim 4 in reading 2, with `V` standing for the invariant sextics.
- `block_counts`, `block_shape` and `multiplicity_split` are closed numeral identities: $8+3+10+8=29$, $65=20+6+27+12$, $36=20+16$, $65=36+29$, $2\cdot6+5\cdot3+9=36$, $2\cdot9+5\cdot4+9=47$, $29+12=41$. All exact. They check arithmetic and carry no reference to blocks.
- The non-vacuity example shows that the zero maps satisfy the adjunction on a $14$-dimensional space. Its docstring adds "the rank equation reads $0+14=14$", a remark the example does not itself state. The hypotheses are satisfiable, which is all non-vacuity needs.

**Standing item 5, is the Lean statement the claim.** It is the adjunction shell of the claim. What it declares untyped matches the debt found in claim 1: $V$ as the invariant sextics, $K$ as the orbit-constraint span, $\mathrm{Cat}_F$ as a bilinear form, $F_5$, the step to $\mathrm{Cat}_F(K,K)=0$, and the block multiplicities. The record's $\mathrm{ANN}$ ($\mathrm{Cat}_F(K,K)=0$) is replaced by `ker Cat` for the adjoint of `muK`, and that replacement is exactly the unwritten identification.

**Does a hypothesis exclude anything.** `InnerProductSpace ℝ` requires positive definite pairings, where the displays need only nondegenerate ones. The record names no pairing. If the intended pairing is the apolar one induced by a Euclidean inner product on $\mathcal W_5$, it is positive definite and nothing is excluded. `B` need not be finite-dimensional, which is more general than needed. `hV : finrank V = 14` is a hypothesis, where the record takes it from L85. No hypothesis excludes a case the record uses.

**Three-step record for the one candidate.**

1. *Location:* Lean docstring, "`ANN` is `ker Cat`".
2. *Failure exhibited:* the Lean `ANN` is not the record's `ANN` as defined. The record defines it by $\mathrm{Cat}_F(K,K)=0$, and the Lean file types the adjoint's kernel.
3. *Charitable reading:* the file says so itself, under "What is NOT typed here", naming the step as absent. The theorems are faithful to the displays as consequences of the adjunction, and they are not presented as typing $\mathrm{ANN}$'s definition. The candidate is withdrawn as a Lean defect and stands as the claim 1 debt.

I did not build the file. Building it is a computation outside this brief's allowance, so the proof terms were read, not compiled.

## 8. Falsifiers sought (standing item 7)

| Claim | Object that would falsify it | What I did to look |
|---|---|---|
| 1 | An invariant sextic $F$ with $\langle\mathrm{Cat}_F,B\rangle=0$ for every invariant $B\in\mathrm{Sym}^2(K)$ but $\mathrm{Cat}_F(k,k')\neq0$ for some $k,k'\in K$ | Identified what excludes it: $K$ a submodule, $\mathrm{Cat}$ equivariant, pairing invariant. The first is on file and the other two are not. A candidate would require a non-invariant pairing, which the record does not give, so none is exhibited. |
| 2, 3 | A pairing degenerate on $V$, for example a nonzero isotropic $F\in V$ orthogonal to all of $V$ | None can exist for a positive definite pairing. The record names no pairing, so this stays with claim 1's debt. |
| 4 | A nonzero sextic $F$ with $\langle F,pq\rangle=0$ for all cubics $p,q$ | Under reading 1, every degree-$6$ monomial is a product of two degree-$3$ monomials, so no such $F$ exists for a nondegenerate pairing. This is my search record, not an argument the record carries. |
| 5 | A row of L83 whose rule-count differs from $29$ or $36$ | All $24$ blocks were checked individually in the table of section 5. None differs. |
| 6 | An instance with a certificate and $\dim\mathrm{ANN}>0$ | The displays admit it abstractly, and that is the GAP. The actual $\dim\mathrm{ANN}$ is L62's content, outside the brief. |
| 7 | A Lean hypothesis excluding the record's pairing, such as an indefinite nondegenerate one | None is named by the record, so none is excluded. |

## Answers to the fixed list, by number

1. Hypothesis inventory: see the inventory table. Used but unstated: the two pairings, $\mu$, $\mathrm{Cat}_F$, $B$, $S$, the equivariance of $\mu$ and $\mathrm{Cat}$, the invariance of $F_5$, surjectivity of $\mu$, and averaging over $O(5)$ for the certificate reduction.
2. Quantifier order and the scope of $\mu$: see the table in section 3. No finding beyond withdrawn candidate 3.W1.
3. Edges $\dim\mathrm{ANN}=0$, $\dim\mathrm{ANN}=14$, $K=\mathrm{Sym}^3$ (and $K=0$): sections 2 and 3. No finding: every edge is consistent with both displays and with the injectivity sentence.
4. Proven against stated: sections 1 and 6. The displays are proven from the adjunction given $\mathrm{ANN}=\ker\mu_K^*$, which is unwritten. "The count is the necessary condition" states more than is proven.
5. Lean: section 7. The file is faithful as an adjunction shell and no hypothesis excludes a used case.
6. Attack items: items 1 and 2 are answered in section 1, item 3 in sections 2 and 3, items 4 to 7 in sections 4 to 7 respectively, and item 8 in sections 2 and 3.
7. Falsifiers: section 8.

## Overall verdict: HYPOTHESIS-DEBT

The two displays, the injectivity of $\mathrm{Cat}$ and the count $65=36+29$ are correct as algebra from the adjunction and from L83, L86 and L87. What is owed:

- definitions of both pairings, of $\mu$, $\mathrm{Cat}_F$, $B$ and "the invariants supported on $K$"
- the written step $\mathrm{Cat}_F\perp S\Rightarrow\mathrm{Cat}_F(K,K)=0$, from $K$ a submodule, the equivariance of $\mathrm{Cat}$ and the invariance of the pairing
- the surjectivity of $\mu$ and the invariance of $F_5$
- a restatement of "the count is the necessary condition" as "a certificate forces $F_5\perp\mathrm{ANN}$, and $\dim\mathrm{ANN}=0$ is sufficient for that", together with the averaging step that makes the certificate's Gram tensor invariant.
