# Verifier v296, Lemma L86: the orbit reduction, the stabiliser, the so(5) to so(4) branching, the parity rule, the redundancy of the padding reflection, the block counts, the rank-one step and the canonical statement

The brief was cold. No numerical work was done: no scripts, no runs, no computation beyond reading the given table by hand. Every value below is exact. Log: [agent_logs/verify-L86-v296.log](../agent_logs/verify-L86-v296.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Orbit reduction: vanishing on the orbit is the single condition $\sigma_\lambda(W_0)=0$, with $\sigma_\lambda(W_0)\in V_\lambda^H$ | CONFIRMED AS ALGEBRA |
| 2 | $\mathrm{Stab}_{O(5)}(W_0)$: identity component $U(2)\subset SO(4)$, two components, times $\varepsilon$ | HYPOTHESIS-DEBT |
| 3 | Branching: exactly one constituent with $j_L=0$, namely $(\lambda_2,-\lambda_2)$, $j_R=\lambda_2$ | CONFIRMED |
| 4 | Parity rule in Passage A, for constituents of $\mathrm{Sym}^3(\mathcal W_5)$, with the four hand-checks | CONFIRMED AS ALGEBRA |
| 4C | Parity rule as stated in Passage C, for "the $O(5)$-module with highest weight $\lambda$" | REFUTED AS STATED |
| 5 | The reflection $\varepsilon$ is redundant | CONFIRMED |
| 6 | Counts against Passage B: $16$ blocks, $3570$, $25$ multiplicities, $36$ unknowns, the shape, the eight deaths | CONFIRMED AS ALGEBRA |
| 7a | The lower bound: at least $36$ unknowns (heading, Passage C landscape and detail) | CONFIRMED AS ALGEBRA |
| 7b | The rank-one step: every one of the sixteen ranks is $1$, so $36$ is exact and the eight blocks die | HYPOTHESIS-DEBT |
| 8 | Passage B's multiplicities, on which items 6 and 7 rest | HYPOTHESIS-DEBT |
| 9 | Boundary: $\lambda_2=0$, the trivial block, multiplicity-one blocks, the padded kernel | CONFIRMED |

**Summary:** the parity rule's algebra is sound for $O(5)$-modules on which $-\mathrm{Id}$ acts trivially, but the stabiliser is asserted without argument, the numbers rest on script-only multiplicities and a measured rank, and the canonical line in Passage C omits the $-\mathrm{Id}$ hypothesis. Overall: HYPOTHESIS-DEBT.

## 0. Conventions, fixed once

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$, the $SO(5)$-irreducible of highest weight $(2,2)$, dimension $35$. $\mathrm{Sym}^3(\mathcal W_5)$ has dimension $\binom{37}{3}=7770$.
- $W_0$ is the Weyl tensor of $\mathbb{CP}^2$ on $\mathbb R^4=\langle e_1,\dots,e_4\rangle$, extended by zero in $e_5$. Its $\mathbb R^5$-Ricci contraction is the $\mathbb R^4$ one plus the $e_5$ term, which is zero, so the zero extension already lies in $\mathcal W_5$ and "padded" needs no further projection.
- $H=\mathrm{Stab}_{O(5)}(W_0)$. $\varepsilon=\mathrm{diag}(1,1,1,1,-1)$.
- $SO(5)$ weights $\lambda=\lambda_1e_1+\lambda_2e_2$ with $\lambda_1\ge\lambda_2\ge0$. $SO(4)$ weights $(\mu_1,\mu_2)$ with $\mu_1\ge|\mu_2|$. The label map used below is $j_L=(\mu_1+\mu_2)/2$, $j_R=(\mu_1-\mu_2)/2$, which is the one the quoted pair $(\lambda_2,-\lambda_2)\mapsto j_L=0$, $j_R=\lambda_2$ forces. The passage does not state it.
- Classical branching $\mathfrak{so}(5)\to\mathfrak{so}(4)$ (unfiled): $V_{(\lambda_1,\lambda_2)}$ restricts multiplicity-free to the $(\mu_1,\mu_2)$ with $\lambda_1\ge\mu_1\ge\lambda_2\ge|\mu_2|$, integer steps.
- An $SO(5)$-irreducible extends to $O(5)=SO(5)\times\{\pm\mathrm{Id}\}$ in two ways, with $-\mathrm{Id}$ acting by $+1$ or by $-1$. "The $O(5)$-module with highest weight $\lambda$" is therefore not a single object until that sign is fixed.
- "Unknowns" of a block of multiplicity $m$: $m(m+1)/2$, read off Passage B ($4\mapsto10$, $3\mapsto6$, $2\mapsto3$, $1\mapsto1$, total $2\cdot10+6+9\cdot3+12=65$). A block whose evaluation map has rank $r$ keeps $(m-r)(m-r+1)/2$.
- Dimension formula for $B_2$: $\dim(a,b)=(2a+3)(2b+1)(a+b+2)(a-b+1)/6$. Spot-read against Passage B: $(2,2)\mapsto35$, $(4,2)\mapsto220$, $(6,2)\mapsto625$, $(6,3)\mapsto770$, $(6,4)\mapsto810$, $(5,4)\mapsto429$, all agree.

## Hypothesis inventory

| Hypothesis | Where from | Used by | Stated? |
|---|---|---|---|
| H1. $F_5$ vanishes on the $O(5)$-orbit of $W_0$ | Imported into Passage A | The orbit constraint, hence items 6 and 7 | Asserted, no argument in the passages. The brief does not fix the normalisations of $\lVert W\rVert$ and $\mathop{\mathrm{tr}}(W^3)$, on which the vanishing depends |
| H2. A certificate is a block-diagonal Gram form, positive semidefinite per block, so a zero of $F_5$ forces the Gram matrix to annihilate the evaluation vectors there | Implicit in "every covariant entering a certificate vanishes there" | Item 1, and the unknown count | Unstated. "Certificate" is undefined in the brief |
| H3. Covariants are $O(5)$-equivariant, not only $SO(5)$-equivariant | Implicit in "by equivariance" | $\sigma_\lambda(W_0)\in V_\lambda^H$, since $H$ contains $\varepsilon\notin SO(5)$ | Unstated |
| H4. The stabiliser $H$ is exactly as described, with $\sigma$ acting as the $\mathfrak{su}(2)_R$ Weyl element | Passage A, attributed to "Reviewer 178" | Item 4 | Asserted, no argument on file |
| H5. Classical branching $\mathfrak{so}(5)\to\mathfrak{so}(4)$ and the label map | Unfiled classical | Item 3 | Rule unfiled, label map unstated |
| H6. The Weyl element acts on the $m=0$ vector of integer spin $j$ by $(-1)^j$ | Unfiled classical ($d^j_{00}(\pi)=P_j(-1)=(-1)^j$) | Item 4 | Stated, unfiled |
| H7. $-\mathrm{Id}$ acts trivially on every $V_\lambda$ considered | Passage A, redundancy paragraph | Items 4 and 5, and the $(1,0)$ hand-check | Stated in A with no reason (the reason is that $\mathcal W_5$ sits in degree-four tensors). **Absent from Passage C** |
| H8. Passage B's multiplicities | Character computation by script | Items 6 and 7 | Script only, no derivation on file |
| H9. Frobenius reciprocity bound $\mathop{\mathrm{rank}}(M_\lambda\to V_\lambda^H)\le\dim V_\lambda^H$ | Unfiled classical | Item 7a | Stated |
| H10. $\sum_\lambda\mathrm{rank}_\lambda d_\lambda$ equals the dimension of the $O(5)$-submodule generated by $W_0^3$, and that dimension is $3570$ | Passage A, measured by reviews r170 and r178 | Item 7b | Identity asserted, value measured, and the passage itself says the join between the measured and the derived ranks "is owed" |

## 1. The orbit reduction

**Quoted:** "every covariant entering a certificate vanishes there, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$."

**Derivation read.**

- For an $O(5)$-equivariant $\sigma$ and $g\in O(5)$, $\sigma(g\cdot W_0)=g\cdot\sigma(W_0)$. Since $g$ is invertible, $\sigma$ vanishes on the orbit exactly when $\sigma(W_0)=0$. This link is correct.
- Membership $\sigma_\lambda(W_0)\in V_\lambda^H$ is not written in the orbit paragraph. It is presupposed later by "the evaluation map $M_\lambda\to V_\lambda^H$". It follows from the same identity at $h\in H$: $h\cdot\sigma(W_0)=\sigma(h\cdot W_0)=\sigma(W_0)$. The passage cites equivariance, so I record the omission as presentational.
- The step "every covariant entering a certificate vanishes there" needs H2. Under H2 the constraint on block $\lambda$ is that the Gram matrix kills the image of the transposed evaluation map, which has dimension $\mathrm{rank}_\lambda$. The phrase "the single condition" is loose, because it is a condition on the Gram matrix's support, not on each basis covariant, but the count that Passage A draws from it (each selected block loses $\mathrm{rank}_\lambda\le1$ multiplicities) is the correct reading.
- H3 matters: $\varepsilon\in H$ lies outside $SO(5)$, so $SO(5)$-equivariance alone would not place $\sigma(W_0)$ in $V_\lambda^H$. The $O(5)$-orbit equals the $SO(5)$-orbit here (for $g\notin SO(5)$, $g\cdot W_0=(g\varepsilon)\cdot W_0$), so the orbit statement itself is unaffected.

**Verdict:** CONFIRMED AS ALGEBRA, under H1, H2 and H3, of which H1 is an imported premise with no argument in the passages and H2, H3 are unstated.

## 2. The stabiliser

**Quoted:** "$\mathrm{Stab}_{O(5)}(W_0)$ has identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis", and later "$\sigma$ is the $\mathfrak{su}(2)_R$ Weyl element".

**What is on file.** An assertion and an attribution ("Reviewer 178, deriving it independently of 174"). No argument appears in the passages.

**What would have to be proved.**

- (a) Every $g\in H$ preserves $\mathbb R^4$ and the line $\mathbb R e_5$.
- (b) $H\cap(O(4)\times1)\subset SO(4)\times1$, that is, no orientation-reversing element of $O(4)$ fixes $W_0$.
- (c) $H\cap SO(4)$ is the preimage of the stabiliser in $SO(3)$ of the self-dual part of $W_0$, it has identity component $U(2)=(SU(2)_L\times U(1)_R)/\pm1$ and exactly two components, and the non-identity component contains an element whose $SU(2)_R$ part normalises $U(1)_R$ and acts as the Weyl element.
- (d) $\varepsilon$ fixes $W_0$.

**Scope of the debt.** The lower bound of item 7a needs only containment: that $U(2)$ and $\sigma$ fix $W_0$. A larger $H$ could only shrink $V_\lambda^H$, and the bound uses $\dim V_\lambda^H\le[\lambda_2\text{ even}]$. The equality "$\dim V_\lambda^H=1$ for $\lambda_2$ even" needs the full statement (a) to (c): an extra element of $H$ acting by $-1$ on the $U(2)$-invariant line would break it.

**Verdict:** HYPOTHESIS-DEBT for (a) to (d).

## 3. The branching

**Quoted:** "leaves exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$."

**Derivation read.** Under the label map of Section 0, $j_L=0$ means $\mu_2=-\mu_1$. The interlacing gives $\mu_1\ge\lambda_2\ge|\mu_2|=\mu_1$, so $\mu_1=\lambda_2$ and $\mu_2=-\lambda_2$. This pair is admissible for every $\lambda$ since $\lambda_1\ge\lambda_2$. Multiplicity-freeness makes the constituent unique, and $j_R=(\lambda_2+\lambda_2)/2=\lambda_2$.

**Label map.** Unstated. The opposite map $j_L=(\mu_1-\mu_2)/2$ would make the $j_L=0$ constituent $(\lambda_2,\lambda_2)$ and the quoted pair wrong. The quoted pair fixes the map, and which $\mathfrak{su}(2)$ factor carries the name $L$ is an orientation convention. The dimension count is symmetric under the swap provided the $U(1)$ and $\sigma$ sit in the factor with spin $\lambda_2$, which Passage A says ("$\sigma$ is the $\mathfrak{su}(2)_R$ Weyl element").

**Hand-read of the branching at small labels.** $(1,0)\to(1,0)\oplus(0,0)$, dimensions $4+1=5$. $(1,1)\to(1,1)\oplus(1,0)\oplus(1,-1)$, dimensions $3+4+3=10$. Both agree with the dimension formula.

**Verdict:** CONFIRMED, given the unfiled classical rule (H5). Record: the label map should be stated.

## 4. The parity rule

**Quoted:** "The $U(2)$-invariants are therefore *always* one-dimensional ... $\sigma$ ... acts on the $m=0$ vector of spin $j$ by $(-1)^j$. **Hence $\dim V_\lambda^H=1$ iff $\lambda_2$ is even.**"

**Chain read link by link.**

1. $U(2)=(SU(2)_L\times U(1)_R)/\pm1$. $SU(2)_L$-invariants in a constituent $(j_L,j_R)$ are non-zero only for $j_L=0$. By item 3 that is the single constituent $V_0\boxtimes V_{\lambda_2}$.
2. $U(1)_R$-invariants in $V_{\lambda_2}$ are the weight-zero line, one-dimensional because $\lambda_2$ is an integer. So $\dim V_\lambda^{U(2)}=1$. Correct.
3. $\sigma$ preserves the constituent (it is an $SO(4)$-submodule) and normalises $U(1)_R$, so it preserves the line and acts on it by a sign. Its $SU(2)_L$ part acts trivially because $j_L=0$, and the lift ambiguity $\pm w$ acts trivially on integer spin. By H6 the sign is $(-1)^{\lambda_2}$. Correct given H4 and H6.
4. $\varepsilon$ acts trivially on the line by item 5, given H7.
5. Hence $\dim V_\lambda^H=1$ for $\lambda_2$ even and $0$ for $\lambda_2$ odd. Correct given H4, H5, H6, H7.

**Hand-checks read.**

- $(1,0)\mapsto1$, "realised by $e_5$". The $j_L=0$ constituent is $(0,0)$, the line $\mathbb R e_5$. This is correct only in the $O(5)$-module on which $-\mathrm{Id}$ acts trivially, namely $\mathbb R^5\otimes\det$, where $\varepsilon$ acts on $e_5$ by $\det(\varepsilon)\cdot(-1)=+1$. In the standard vector representation $\varepsilon e_5=-e_5$. See 4C.
- $(1,1)\mapsto0$. In $\Lambda^2\mathbb R^5$ the $j_L=0$ constituent $(1,-1)$ is the three-dimensional self-dual factor. Its $U(1)_R$-fixed line is the Kähler form $\omega$, which the non-identity component sends to $-\omega$. Agrees with the passage.
- $(2,0)\mapsto1$. The $j_L=0$ constituent of $\mathrm{Sym}^2_0\mathbb R^5$ is $(0,0)$, spanned by $\mathrm{diag}(1,1,1,1,-4)$, fixed by $SO(4)$ and by $\varepsilon$. Agrees.
- $(2,2)\mapsto1$. The $j_L=0$ constituent is $(2,-2)$, spin $2$, and its weight-zero line contains $W_0$ itself. Agrees.

**Verdict:** CONFIRMED AS ALGEBRA, conditional on H4 (item 2) and on H7, which Passage A states.

## 4C. The parity rule as stated in Passage C

**Candidate record.**

1. **Location.** [results.md](../results.md) line 290: "The $H$-invariant dimension is one exactly when the second highest-weight coordinate is even", and line 962: "$\dim V_\lambda^H=1$ exactly when $\lambda_2$ is even." Neither line restricts the module, and the brief's definitions read "$V_\lambda^H$ the $H$-fixed vectors of the $O(5)$-module with highest weight $\lambda$".
2. **Concrete failure.** Take the standard representation $\mathbb R^5$ of $O(5)$, highest weight $(1,0)$, $\lambda_2=0$ even. Vectors fixed by $U(2)$ are the line $\mathbb R e_5$ (since $U(2)$ acts irreducibly on $\mathbb R^4=\mathbb C^2$). $\varepsilon\in H$ sends $e_5\mapsto-e_5$. So $\dim(\mathbb R^5)^H=0$, contradicting the line. More generally, on every $O(5)$-module where $-\mathrm{Id}$ acts by $-1$, $\varepsilon$ acts on the $U(2)$-invariant line by $-1$ (it equals $-\mathrm{Id}$ times the scalar $-1\in U(2)$), so $V_\lambda^H=0$ for every $\lambda$.
3. **Charitable reading.** Passage A pins the module by "every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially", and the landscape line mentions "the certificate's unknown count", which places it among the blocks of $\mathrm{Sym}^3(\mathcal W_5)$. Under that reading the line is true. The reading imports the hypothesis from Passage A, and neither canonical line contains it, nor does the brief's definition of $V_\lambda$. The candidate survives as a statement defect, with no effect on the certificate count, which only ever concerns constituents of $\mathrm{Sym}^3(\mathcal W_5)$.

**Verdict:** REFUTED AS STATED. The correction is one clause: "for $O(5)$-modules on which $-\mathrm{Id}$ acts trivially, as every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ does".

## 5. The reflection $\varepsilon$ is redundant

**Quoted:** "every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially, so $\varepsilon$ acts as $\mathrm{diag}(-1,-1,-1,-1,1)\in SO(5)$, which is already the scalar $-1$ in $U(2)$."

**Derivation read.**

- $-\mathrm{Id}$ acts on $\mathcal W_5$, a space of four-index tensors, by $(-1)^4=1$, hence trivially on $\mathrm{Sym}^3(\mathcal W_5)$ and every constituent. The passage gives no reason, but the fact is definitional.
- $\varepsilon=(-\mathrm{Id})\cdot\mathrm{diag}(-1,-1,-1,-1,1)$, so on such modules $\varepsilon$ acts as $\mathrm{diag}(-1,-1,-1,-1,1)$, whose restriction to $\mathbb R^4=\mathbb C^2$ is the scalar $-1\in U(2)$. It therefore acts trivially on $U(2)$-invariants. Correct.
- Consistency with the branching: $-\mathrm{Id}_4$ lifts to $(-1,1)\in SU(2)_L\times SU(2)_R$, acting on the $j_L=0$ constituent by $(-1)^{2j_L}=1$.

**Verdict:** CONFIRMED, within H7. Outside H7 it fails, which is 4C.

## 6. The counts against Passage B

Read by hand from the table.

**Selected blocks ($\lambda_2$ even).**

| mult | selected | not selected |
|---|---|---|
| 4 | $(4,2)_{220}$, $(2,2)_{35}$ | none |
| 3 | $(3,2)_{105}$ | none |
| 2 | $(5,2)_{390}$, $(4,4)_{165}$, $(4,0)_{55}$, $(3,0)_{30}$, $(2,0)_{14}$ | $(4,3)$, $(4,1)$, $(3,1)$, $(2,1)$ |
| 1 | $(6,6)_{455}$, $(6,4)_{810}$, $(6,2)_{625}$, $(6,0)_{140}$, $(5,4)_{429}$, $(5,0)_{91}$, $(1,0)_{5}$, $(0,0)_{1}$ | $(6,3)$, $(5,3)$, $(5,1)$, $(3,3)$ |

- **Number:** $2+1+5+8=16$. Agrees.
- **Dimensions:** $220+35+105=360$. $390+165+55+30+14=654$. $455+810+625+140+429+91+5+1=2556$. Total $360+654+2556=3570$. Agrees.
- **Surviving multiplicities** (each selected block losing one): $41-16=25$. Agrees.
- **Unknowns:** $2\cdot\binom{4}{2}=12$ from multiplicity $4\to3$, $\binom32=3$ from $3\to2$, $5\cdot1$ from selected $2\to1$, $4\cdot3=12$ from unselected multiplicity $2$, $0$ from selected multiplicity $1$, $4\cdot1$ from unselected multiplicity $1$. Total $12+3+5+12+0+4=36$. Agrees.
- **Shape:** $3\times3$ blocks $(4,2)$, $(2,2)$: two. $2\times2$ blocks $(3,2)$ and the four unselected multiplicity-$2$ blocks: five. Scalars: the five selected multiplicity-$2$ blocks and the four unselected multiplicity-$1$ blocks: nine. Agrees, and $2\cdot6+5\cdot3+9=36$.
- **Eight deaths:** the selected multiplicity-$1$ list is exactly $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$. Agrees.
- **Passage B's own arithmetic:** $4\cdot255+3\cdot105+2\cdot1155+4125=1020+315+2310+4125=7770=\binom{37}3$. Multiplicities $8+3+18+12=41$. Unknowns $65$. Multiplicity-$1$ dimensions $4125$. All agree.
- **The difference $65-36=29$** equals the sum of the selected multiplicities, $4+4+3+2\cdot5+8=29$, the unknowns removed at rank one ($m(m+1)/2-(m-1)m/2=m$). This is what Passage C's "$65=36+29$" names.

**Verdict:** CONFIRMED AS ALGEBRA on the given table. "$25$", "$36$", the shape and the eight deaths are the rank-one values (item 7b). "$16$" and "$3570$" depend only on the parity rule and the table.

## 7. The rank-one step and the stated numbers

### 7a. The lower bound

**Derivation read.** With $\mathrm{rank}_\lambda\le\dim V_\lambda^H$ (H9) and item 4, a selected block keeps $(m-r)(m-r+1)/2\ge(m-1)m/2$ unknowns and an unselected block keeps $m(m+1)/2$. The sum is at least $36$, with equality exactly when all sixteen selected ranks equal $1$. The bound uses only $\dim V_\lambda^H\le[\lambda_2\text{ even}]$, so it survives any enlargement of $H$ (item 2).

**Statements compared.**

| Place | Claim | Matches the proof? |
|---|---|---|
| Passage A heading, line 70 | "the $\ge36$ unknowns it leaves" | Yes |
| Passage A counts paragraph | "$36$ unknowns", "Eight ... die outright" | Stated as equalities, then relabelled conditional by the next paragraph. Consistent once read together |
| Passage C landscape, line 290 | "bounds the certificate's unknown count from below by thirty-six" | Yes, reading "unknown count" as the count after the $W_0$-orbit constraint |
| Passage C detail, line 962 | "The lemma proves only $\ge36$ unknowns" | Yes |

**Verdict:** CONFIRMED AS ALGEBRA, conditional on H1, H2, H8 and the containment half of H4.

### 7b. The rank-one step

**Quoted:** "Frobenius reciprocity bounds the evaluation map ... **it does not force rank $1$ rather than rank $0$.**" and "**An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact.**"

**Derivation read.**

- "Each block loses one multiplicity" is not proved in the passages. Passage A says so itself.
- The implication "if $\sum_\lambda\mathrm{rank}_\lambda d_\lambda=3570$ then every rank is $1$" is correct algebra: each selected term is at most $d_\lambda$, the unselected terms are $0$, the selected $d_\lambda$ sum to $3570$ (item 6), and every $d_\lambda>0$.
- Its premise is H10. The identity between $\sum\mathrm{rank}_\lambda d_\lambda$ and the dimension of the submodule generated by $W_0^3$ is asserted without argument in the passage, the value $3570$ is a measurement (r170) and a finite-field recomputation (r178), and the passage itself states "what joins them is owed, see L87".

**What would have to be proved.** For each of the sixteen selected $\lambda$, a covariant $\sigma\in M_\lambda$ with $\sigma(W_0)\ne0$. Passage A's final paragraph names exactly this check.

**Verdict:** HYPOTHESIS-DEBT. The canonical statement in Passage C claims only the lower bound, so this debt attaches to "$36$ is exact", the shape, the eight deaths and everything the passage lists as downstream, and it leaves 7a untouched.

## 8. Scope: Passage B's multiplicities

The dimensions in Passage B are arithmetic on the highest weights, and six were spot-read against the $B_2$ formula (Section 0). The multiplicities "come from the character computation" by [run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), and Passage B says of its sums that "only $7770$ is an external check". The total $7770$ constrains $\sum m_\lambda d_\lambda$ and does not determine the individual $m_\lambda$. The trivial multiplicity $1$ is accompanied by an explicit "are owed".

Items 4 and 5 do not depend on Passage B. Items 6, 7a and 7b do: the $16$, the $3570$, the $36$ and the list of deaths each change if any multiplicity or the block list changes.

**What would have to be proved.** The decomposition of $\mathrm{Sym}^3(V_{(2,2)})$ under $SO(5)$ into the $24$ listed blocks with the listed multiplicities, by a character argument on file.

**Verdict:** HYPOTHESIS-DEBT.

## 9. The boundary

- **$\lambda_2=0$.** The constituent $(0,0)$ appears for every $(\lambda_1,0)$, since $\lambda_1\ge0\ge0$. Spin $0$, sign $(-1)^0=1$, so $\dim V_\lambda^H=1$. Hand-checks $(1,0)$ and $(2,0)$ fall here and agree. No finding.
- **The trivial block $(0,0)$.** The module is trivial (with $-\mathrm{Id}$ trivial, it is the trivial representation and not $\det$). $\dim V^H=1$, selected, multiplicity $1$, so it "dies" at rank one. Its rank is $1$ exactly when the cubic invariant spanning $M_{(0,0)}$ is non-zero at $W_0$, which Passage B marks as owed and 7b leaves unproved. No finding beyond 7b and 8.
- **Multiplicity-one blocks.** A selected one keeps $0$ unknowns at rank $1$ and $1$ at rank $0$. An unselected one keeps $1$. The count in item 6 treats both cases correctly. No finding.
- **The padded kernel.** Padding puts $\varepsilon$ into $H$, which is the only place the $-\mathrm{Id}$ convention bites. Inside $\mathrm{Sym}^3(\mathcal W_5)$ item 5 disposes of it. Outside, it produces 4C. No further finding.

## 10. Falsifiers named, and what was done to look

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | An $O(5)$-equivariant cubic $\sigma$ vanishing at $W_0$ but not on its orbit | Impossible by the equivariance identity, read. None |
| 2 | An element of $O(5)$ fixing $W_0$ outside the described group, or a described element not fixing it | Considered elements moving $e_5$ off its line, orientation-reversing elements of $O(4)$ (which exchange self-dual and anti-self-dual parts), and $-\mathrm{Id}_4\oplus1$. No closed-form falsifier found. The claim stays debt because no proof is on file |
| 3 | A second $j_L=0$ constituent, or none | Interlacing read, forced unique. None |
| 4 | An $H$-fixed vector in a $\lambda_2$-odd block, or a $\lambda_2$-even block without one, among modules with $-\mathrm{Id}$ trivial | Checked $(1,0)$, $(1,1)$, $(2,0)$, $(2,2)$ by explicit invariants. None |
| 4C | An $O(5)$-module of highest weight $\lambda$ contradicting the rule | Found: standard $\mathbb R^5$, $\lambda=(1,0)$, $V^H=0$ |
| 5 | A constituent of $\mathrm{Sym}^3(\mathcal W_5)$ on which $-\mathrm{Id}$ acts by $-1$ | Excluded by tensor degree. None |
| 6 | A misread label or dimension in the table | Every row recounted by hand. None |
| 7a | A zero of $F_5$ off $\pm\mathbb R_{>0}\cdot$orbit$(W_0)$ imposing further kernel constraints | See withdrawn candidate W1 |
| 7b | A selected block $\lambda$ with $\sigma(W_0)=0$ for all $\sigma\in M_\lambda$ | Not searched: it requires evaluating the covariants, which is computation |
| 8 | A multiplicity differing from the table | Not searched: it requires a character computation |

## 11. Withdrawn candidates

### W1. Zeros of $F_5$ beyond the orbit

1. **Location.** Passage C line 290: "which bounds the certificate's unknown count from below by thirty-six".
2. **Concrete failure.** Not exhibited. Every further zero of $F_5$ adds kernel constraints and could lower the count. $-W_0$ is a zero off the orbit (the self-dual spectrum changes sign, and the image argument keeps any stabilising element inside $O(4)\times O(1)$), but a cubic covariant satisfies $\sigma(-W_0)=-\sigma(W_0)$, so it adds no constraint. Scalings add none for the same reason. No other zero was produced in closed form.
3. **Charitable reading.** The count is the one left by "the orbit constraint", the section's own title.

**Withdrawn:** fails step 2.

### W2. "The heading claiming $65$"

1. **Location.** Passage C line 962: "the heading claiming $65$ claims a number the section itself disclaims".
2. **Concrete failure.** In the quoted material no heading claims $65$. The L86 heading (line 70) reads "$\ge36$", the Passage B heading reads "The 24 blocks", and $65$ appears only as a table sum.
3. **Charitable reading.** The sentence refers to a heading outside the quoted lines, or records the reason an earlier heading was changed. The brief does not let me exclude either, so no contradiction can be exhibited.

**Withdrawn:** fails step 2 as a correctness defect. It remains a readability note: the sentence reads as stale against the current heading.

### W3. The counts paragraph states $36$ as an equality

1. **Location.** "Each loses one multiplicity, leaving **$25$ surviving multiplicities and $36$ unknowns**", and "Eight ... die outright".
2. **Concrete failure.** Unconditional as written, while the rank-one step is unproved.
3. **Charitable reading.** The next paragraph explicitly relabels both as conditional on the measurement, and the heading and Passage C both state $\ge36$.

**Withdrawn:** the charitable reading holds. The substantive point is carried by 7b.

## Overall verdict

**HYPOTHESIS-DEBT.**

- The parity rule's chain (items 1, 3, 4, 5) is correct algebra for modules with $-\mathrm{Id}$ trivial, but rests on a stabiliser (item 2) asserted without argument.
- The lower bound $\ge36$ (7a) is correct algebra on script-only multiplicities (item 8). It needs only the containment half of the stabiliser.
- "$36$ is exact", the shape and the eight deaths (7b) rest on a measured rank.
- Passage C's canonical line needs the hypothesis "$-\mathrm{Id}$ acts trivially on $V_\lambda$" (4C). With it, it would read PROVEN (hypotheses corrected) once items 2 and 8 are discharged.
