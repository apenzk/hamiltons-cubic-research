# Verifier v298, Lemma L86: the orbit reduction, the stabiliser, the branching and parity rule, the redundant reflection, the sixteen-block counts and the $\ge36$ bound

The brief ([BRIEF_L86.md](BRIEF_L86.md)) was read cold. No numerical work was done, every value below is exact, and no script was written or run. Summing the table of Passage B by hand and evaluating the Weyl dimension formula at its stated labels count as reading. Every quotation in the brief was checked against its source at the cited lines only ([findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36, 70, 84-99, and [results.md](../results.md) lines 290 and 962), and all match verbatim. Log: [agent_logs/verify-L86-v298.log](../agent_logs/verify-L86-v298.log).

| # | Claim | Verdict |
|---|---|---|
| 1a | $F_5$ vanishes on the orbit, so every covariant entering a certificate vanishes there | HYPOTHESIS-DEBT |
| 1b | By equivariance that is the single condition $\sigma_\lambda(W_0)=0$, with $\sigma_\lambda(W_0)\in V_\lambda^H$ | CONFIRMED AS ALGEBRA |
| 2 | $\mathrm{Stab}_{O(5)}(W_0)$: identity component $U(2)\subset SO(4)$, two components, times the padding reflection | HYPOTHESIS-DEBT |
| 3 | Branching leaves exactly one constituent with $j_L=0$, namely $(\lambda_2,-\lambda_2)$, with $j_R=\lambda_2$ | CONFIRMED |
| 4a | $U(2)$-invariants one-dimensional, $\sigma$ acts by $(-1)^{j}$, hence $\dim V_\lambda^H=1\iff\lambda_2$ even (given claim 2 and $-\mathrm{Id}$ trivial) | CONFIRMED AS ALGEBRA |
| 4b | The parity rule as stated in Passage C, for "the $O(5)$-module with highest weight $\lambda$" with no condition on $-\mathrm{Id}$ | REFUTED AS STATED |
| 4c | The four hand-checks $(1,0)\mapsto1$, $(1,1)\mapsto0$, $(2,0)\mapsto1$, $(2,2)\mapsto1$ | CONFIRMED |
| 5 | The reflection $\varepsilon$ is redundant | CONFIRMED |
| 6 | $16$ blocks, dimensions $3570$, $25$ multiplicities, $36$ unknowns, the shape, the eight deaths, read against Passage B | CONFIRMED AS ALGEBRA |
| 7a | The unknown count is at least $36$ | CONFIRMED AS ALGEBRA |
| 7b | Every one of the sixteen ranks is $1$, so $36$ is exact and the eight deaths are unconditional | HYPOTHESIS-DEBT |
| 7c | Passage C's "$\ge36$" and "$65=36+29$ is a tautology" match what Passage A proves | CONFIRMED |
| 8 | The multiplicities of Passage B on which claims 6 and 7 rest | HYPOTHESIS-DEBT |
| 9 | Boundary: $\lambda_2=0$, the trivial block, multiplicity-$1$ blocks, the kernel of $W_0$ | CONFIRMED |

**Summary: the parity mechanism is sound algebra once the stabiliser is granted, the statement needs the hypothesis that $-\mathrm{Id}$ acts trivially, and every count is exact arithmetic on a table whose multiplicities, like the stabiliser and the rank-one step, have no derivation on file.**

Overall verdict: **HYPOTHESIS-DEBT** (with a hypothesis correction to the statement, see 4b).

## 0. Conventions, fixed once

- $\lambda=(\lambda_1,\lambda_2)$ is written in the orthogonal basis $\lambda_1e_1+\lambda_2e_2$ of $B_2$, with $\lambda_1\ge\lambda_2\ge0$ integers. The simple roots are $e_1-e_2$ (long) and $e_2$ (short), and $\rho=(\tfrac32,\tfrac12)$.
- Weyl dimension formula in this basis: $d_\lambda=\tfrac16(\lambda_1-\lambda_2+1)(\lambda_1+\lambda_2+2)(2\lambda_1+3)(2\lambda_2+1)$. It reproduces $d_{(1,0)}=5$, $d_{(1,1)}=10$, $d_{(2,0)}=14$, $d_{(2,2)}=35=\dim\mathcal W_5$, and every dimension in Passage B (section 6). The Casimir $c_2=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)=\langle\lambda,\lambda+2\rho\rangle$ is consistent with this basis.
- $SO(4)\subset SO(5)$ is the stabiliser of $e_5$. Its irreducibles are $(\mu_1,\mu_2)$ with $\mu_1\ge|\mu_2|$, and the label map used throughout is $j_L=\tfrac12(\mu_1+\mu_2)$, $j_R=\tfrac12(\mu_1-\mu_2)$, which is the one under which Passage A's "$(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$" has $j_L=0$. Passage A does not state this map (section 3).
- $\mathfrak{su}(2)_L$ is the factor wholly contained in the identity component of $H$, and $\mathfrak{su}(2)_R$ the factor carrying its $U(1)$. This is the naming Passage A's argument requires.
- $M_\lambda$ is the $m_\lambda$-dimensional space of cubic $O(5)$-covariants $\mathcal W_5\to V_\lambda$, and $\mathrm{ev}_\lambda:M_\lambda\to V_\lambda^H$, $\sigma\mapsto\sigma(W_0)$. $\mathrm{rank}_\lambda$ is its rank. Unknowns of a block of surviving multiplicity $k$ number $k(k+1)/2$, the count that reproduces Passage B's column ($2\cdot10=20$, $6$, $9\cdot3=27$, $12$).
- $H=\mathrm{Stab}_{O(5)}(W_0)$, $H_0$ its identity component.

## Hypothesis inventory

| Hypothesis | Where it enters | Stated? | Status |
|---|---|---|---|
| H1. $F_5(gW_0)=0$ for all $g\in O(5)$ | claim 1a | stated, no source in the quoted chain | unfiled in the passage |
| H2. A certificate is a representation of $F_5$ in which vanishing of $F_5$ at a point forces each covariant entering it to vanish (a positive semidefinite Gram form over the blocks) | claim 1a, the unknown count $k(k+1)/2$ | used, never stated ("certificate" is undefined in the brief) | used but unstated |
| H3. $W_0$ is a Weyl tensor on $\mathbb R^5$, with kernel exactly $\mathbb Re_5$ | claim 2 | used implicitly (the stabiliser splits along $\mathbb R^4\oplus\mathbb Re_5$) | used but unstated |
| H4. The stabiliser structure of claim 2, including that the non-identity component of the $SO(4)$ part is represented by the $\mathfrak{su}(2)_R$ Weyl element | claims 4a, 5 | stated as fact, attributed to a reviewer | no argument on file |
| H5. Branching $SO(5)\to SO(4)$: $\lambda_1\ge\mu_1\ge\lambda_2\ge|\mu_2|$, multiplicity free | claim 3 | invoked by name | classical, unfiled (brief line 51) |
| H6. $-\mathrm{Id}$ acts trivially on $V_\lambda$ | claims 4a, 5 | stated for constituents of $\mathrm{Sym}^3(\mathcal W_5)$ inside the proof, absent from the statement in Passage C | used, missing from the statement (4b) |
| H7. The multiplicities $m_\lambda$ of Passage B | claims 6, 7 | stated, sourced to a script | HYPOTHESIS-DEBT (brief line 52) |
| H8. $\sum_\lambda\mathrm{rank}_\lambda d_\lambda=3570$ | claim 7b | measured by two reviews, joined to the derived bound by an owed step | HYPOTHESIS-DEBT, self-declared ("what joins them is owed") |
| H9. Frobenius reciprocity | claim 7a | invoked by name | classical, unfiled. The bound actually used, $\mathrm{rank}_\lambda\le\dim V_\lambda^H$, is the dimension of the codomain and needs nothing more |

## 1. The reduction to one condition

**1a. HYPOTHESIS-DEBT.** Line 86: "$F_5$ vanishes on the whole $O(5)$-orbit of the padded $W_{\mathbb{CP}^2}$, so every covariant entering a certificate vanishes there". Two premises carry this sentence and neither is argued in the quoted chain.

- H1, the value $F_5(W_0)=0$, that is $\tfrac32\lVert W_0\rVert^6=9\mathop{\mathrm{tr}}(W_0^3)^2$, is asserted without derivation or citation. $O(5)$-invariance of $F_5$ then extends it to the orbit, which is immediate since both $\lVert W\rVert$ and $\mathop{\mathrm{tr}}(W^3)$ are $O(5)$-invariant.
- H2: from "$F_5$ vanishes at a point" to "every covariant entering a certificate vanishes there" is valid only if the certificate writes $F_5$ as a sum of nonnegative terms, each a positive semidefinite form in the covariants of one block. Then each term vanishes at $W_0$, and for a Gram matrix $Q_\lambda\succeq0$ this forces $Q_\lambda^{1/2}\sigma(W_0)=0$. "Entering" must then be read as the covariants in the range of $Q_\lambda$. The brief never defines a certificate, so this is a hypothesis used and unstated.

What would have to be proved: the value $F_5(W_0)=0$ for the stated normalisations of $\lVert\cdot\rVert$ and $\mathop{\mathrm{tr}}(W^3)$, and a definition of certificate with the positivity that carries vanishing to its covariants.

**1b. CONFIRMED AS ALGEBRA.** For an $O(5)$-covariant $\sigma$, $\sigma(gW_0)=g\,\sigma(W_0)$ and $g$ is invertible, so $\sigma$ vanishes on the orbit exactly when $\sigma(W_0)=0$. For $h\in H$, $h\,\sigma(W_0)=\sigma(hW_0)=\sigma(W_0)$, so $\sigma(W_0)\in V_\lambda^H$. Passage A does not write the membership, but "by equivariance" is exactly this line, and it is what makes $\mathrm{ev}_\lambda$ land in $V_\lambda^H$ in section 7.

## 2. The stabiliser

**HYPOTHESIS-DEBT.** Line 86: "$\mathrm{Stab}_{O(5)}(W_0)$ has identity component $U(2)\subset SO(4)$, two components, times the reflection on the padding axis". The sentence is a statement with an attribution ("*Reviewer 178, deriving it independently of 174*"), and no derivation is on file in the quoted chain.

What would have to be proved, for the claim as used:

- H3: the kernel of $W_0$ (the vectors $v$ with $\iota_vW_0=0$) is exactly $\mathbb Re_5$, so every element of $H$ preserves $\mathbb R^4\oplus\mathbb Re_5$ and $H=\mathrm{Stab}_{O(4)}(W_{\mathbb{CP}^2})\times O(1)$.
- $\mathrm{Stab}_{O(4)}(W_{\mathbb{CP}^2})$ lies in $SO(4)$, which needs that $W_{\mathbb{CP}^2}$ is purely self-dual (or anti-self-dual) and nonzero, so that an orientation reversal, which exchanges $\Lambda^+$ and $\Lambda^-$, moves it.
- Within $SO(4)$ the stabiliser is the preimage of the stabiliser of $W^+$ in $SO(\Lambda^+)$, which is two-component with identity component $SO(2)$ exactly when $W^+$ has a simple eigenvalue and a double one, times the whole of the other $SU(2)$. This is where the eigenvalue pattern of $W^+_{\mathbb{CP}^2}$ on $\Lambda^+$ enters, and it is not on file here.
- The non-identity component is represented by an element of $SU(2)_R$ normalising its torus, which is what claim 4a uses.

Falsifier sought: a $W_0$-stabilising element outside the stated group, which would require a larger kernel, a nonzero anti-self-dual part, or a triple eigenvalue of $W^+$. None of these is exhibited in the passage, and none can be exhibited without the data of $W_{\mathbb{CP}^2}$, which the brief does not give. The claim is not refuted. It is unargued.

## 3. The branching

**CONFIRMED**, on the classical rule H5. Line 88: "exactly one constituent with $j_L=0$, namely $(\mu_1,\mu_2)=(\lambda_2,-\lambda_2)$, so $j_R=\lambda_2$".

Derivation. A constituent has one spin zero exactly when $\mu_1=|\mu_2|$. Interlacing gives $\mu_1\ge\lambda_2\ge|\mu_2|$, so $\mu_1=|\mu_2|$ forces $\mu_1=|\mu_2|=\lambda_2$. The candidates are $(\lambda_2,\lambda_2)$ and $(\lambda_2,-\lambda_2)$, each occurring once because the rule is multiplicity free. Under the label map of section 0, $(\lambda_2,-\lambda_2)\mapsto(j_L,j_R)=(0,\lambda_2)$ and $(\lambda_2,\lambda_2)\mapsto(\lambda_2,0)$. So exactly one constituent has $j_L=0$, and its $j_R$ is $\lambda_2$. At $\lambda_2=0$ the two candidates coincide in $(0,0)$ and the count is still one.

The label map is not stated in Passage A. Under the opposite map the constituent named would be $(\lambda_2,\lambda_2)$ instead. The content used downstream, that exactly one constituent is trivial for the factor wholly inside $H_0$ and carries spin $\lambda_2$ for the other, is the same under either map and either orientation, since the two candidates are exchanged. No finding.

Screens at stated labels: $(1,1)\to(1,1)_3+(1,0)_4+(1,-1)_3$, total $10$. $(2,0)\to(2,0)_9+(1,0)_4+(0,0)_1$, total $14$. $(2,2)\to(2,2)_5+(2,1)_8+(2,0)_9+(2,-1)_8+(2,-2)_5$, total $35$, with the spin-$2$ pieces $(2,\pm2)$ the two halves of the Weyl tensor in dimension four.

## 4. The parity rule

**4a. CONFIRMED AS ALGEBRA**, given claim 2 and H6.

- $H_0=(SU(2)_L\times U(1)_R)/\pm1$. A constituent $(j_L,j_R)$ contributes $H_0$-invariants only if $j_L=0$, and then exactly the $U(1)_R$ weight-zero space of spin $j_R$, which is one-dimensional for integer $j_R$. By section 3 there is one such constituent, with $j_R=\lambda_2$ an integer. Hence $\dim V_\lambda^{H_0}=1$ for every $\lambda$, "always one-dimensional" as stated.
- The other component of the $SO(4)$ part is $\sigma H_0$. Since $H_0$ fixes the invariant line, the action of $\sigma$ on it does not depend on the representative. Taking $\sigma$ the Weyl element of $SU(2)_R$, a rotation by $\pi$ about an axis orthogonal to the torus axis, its matrix element on the $m=0$ vector of spin $j$ is $d^{j}_{00}(\pi)=P_j(\cos\pi)=P_j(-1)=(-1)^j$, a value free of phase conventions. A lift ambiguity by $(-1,1)$ or $(1,-1)$ acts on $(0,j)$ with $j$ integer by $+1$.
- With $\varepsilon$ acting trivially on $V_\lambda^{H_0}$ (section 5), $\dim V_\lambda^H=1$ if $(-1)^{\lambda_2}=1$ and $0$ otherwise.

**4b. REFUTED AS STATED.** The record of the three steps:

1. *Location.* [results.md](../results.md) line 290: "The $H$-invariant dimension is one exactly when the second highest-weight coordinate is even", and line 962: "$\dim V_\lambda^H=1$ exactly when $\lambda_2$ is even", with $V_\lambda$ "the $O(5)$-module with highest weight $\lambda$" (brief line 50). No condition on $-\mathrm{Id}$ appears.
2. *Failure.* $-I_5\in H$, because $-I_5$ acts on any $4$-tensor by $(-1)^4=1$ and so fixes $W_0$. On any $O(5)$-module on which $-I_5$ acts by $-1$, a fixed vector $v$ satisfies $v=-v$, so $V^H=0$. Concretely, the defining module $\mathbb R^5$ has highest weight $(1,0)$ and $\lambda_2=0$ even, yet $V^H=0$: the vector $e_5$ fixed by $H_0$ and by the $SO(4)$ part is sent to $-e_5$ by $\varepsilon=\mathrm{diag}(1,1,1,1,-1)\in H$. The rule's own hand-check "$(1,0)\mapsto1$, realised by $e_5$" holds only in the other extension $\mathbb R^5\otimes\det$, where $\varepsilon e_5=(-1)(-1)e_5=e_5$. For every $\lambda$ the two $O(5)$-extensions of the $SO(5)$-module give $\dim V^H=1\iff\lambda_2$ even ($-\mathrm{Id}$ trivial) and $\dim V^H=0$ always ($-\mathrm{Id}=-1$).
3. *Charitable reading.* The lemma sits in a section on the blocks of $\mathrm{Sym}^3(\mathcal W_5)$, and Passage A's proof states H6 for exactly those constituents (line 90). Read as "for every constituent of $\mathrm{Sym}^3(\mathcal W_5)$", or for the $SO(5)$-module with $H\cap SO(5)$ in place of $H$, the rule is right. Neither restriction is in the canonical statement or the brief's definition, and the defining module is the most natural reading of "the $O(5)$-module with highest weight $(1,0)$". The candidate survives.

Correction to the statement: add "for $O(5)$-modules on which $-\mathrm{Id}$ acts trivially, in particular every constituent of $\mathrm{Sym}^3(\mathcal W_5)$". The counts of section 6 use only such modules and are unaffected.

**4c. CONFIRMED**, each hand-check derived directly, with the $SO(4)$ part of $H$ from claim 2.

- $(1,0)$, in $\mathbb R^5\otimes\det$: $H_0=U(2)$ fixes no nonzero vector of $\mathbb R^4=\mathbb C^2$ (it contains $-1$), fixes $e_5$, and $\sigma$ and $\varepsilon$ fix $e_5$ there. Dimension $1$.
- $(1,1)=\Lambda^2\mathbb R^5=\Lambda^+\oplus\Lambda^-\oplus(\mathbb R^4\wedge e_5)$: $H_0$-invariants are the Kähler form $\omega\in\Lambda^+$ only ($SU(2)_L$ has no fixed vector on its spin-$1$ piece, and $\mathbb R^4\wedge e_5\cong\mathbb R^4$ has none). $\sigma$ rotates $\Lambda^+$ by $\pi$ about an axis orthogonal to $\omega$, so $\omega\mapsto-\omega$. Dimension $0$, as stated.
- $(2,0)=\mathrm{Sym}^2_0\mathbb R^5$: the $H_0$-invariants of $\mathrm{Sym}^2\mathbb R^5=\mathrm{Sym}^2\mathbb R^4\oplus(\mathbb R^4\otimes e_5)\oplus\mathbb Re_5^2$ are spanned by $I_4$ and $e_5^2$, whose traceless combination $I_4-4e_5^2$ is fixed by all of $H$. Dimension $1$.
- $(2,2)=\mathcal W_5$: $W_0$ itself is fixed, and section 3 bounds the dimension by $1$. Dimension $1$, with $W_0$ the $m=0$ vector of the spin-$2$ constituent.

## 5. The reflection $\varepsilon$ is redundant

**CONFIRMED.** Line 90. $-I_5$ acts on $\mathcal W_5$ by $(-1)^4=1$, hence trivially on $\mathrm{Sym}^3(\mathcal W_5)$ and on each constituent. $\varepsilon\in H$ because $W_0$ has no component along $e_5$. $\varepsilon=(-I_5)\cdot\mathrm{diag}(-1,-1,-1,-1,1)$, and $\mathrm{diag}(-1,-1,-1,-1,1)$ has determinant $1$, restricts to $-I_4$ on $\mathbb R^4$, and $-I_4$ is the scalar $-1$ of $U(2)$ acting on $\mathbb C^2$. So $\varepsilon$ acts on $V_\lambda$ as an element of $H_0$, trivially on $V_\lambda^{H_0}$. The redundancy holds exactly under H6, which is the hypothesis section 4b asks to be carried into the statement.

## 6. The counts against Passage B

**CONFIRMED AS ALGEBRA**, relative to the table. Every sum below is read off Passage B by hand.

Dimensions. The Weyl formula of section 0 gives, for the sixteen even-$\lambda_2$ labels: $(4,2)$ $3\cdot8\cdot11\cdot5/6=220$, $(2,2)$ $35$, $(3,2)$ $2\cdot7\cdot9\cdot5/6=105$, $(5,2)$ $4\cdot9\cdot13\cdot5/6=390$, $(4,4)$ $1\cdot10\cdot11\cdot9/6=165$, $(4,0)$ $5\cdot6\cdot11/6=55$, $(3,0)$ $4\cdot5\cdot9/6=30$, $(2,0)$ $14$, $(6,6)$ $1\cdot14\cdot15\cdot13/6=455$, $(6,4)$ $3\cdot12\cdot15\cdot9/6=810$, $(6,2)$ $5\cdot10\cdot15\cdot5/6=625$, $(6,0)$ $7\cdot8\cdot15/6=140$, $(5,4)$ $2\cdot11\cdot13\cdot9/6=429$, $(5,0)$ $6\cdot7\cdot13/6=91$, $(1,0)$ $5$, $(0,0)$ $1$. The eight odd-$\lambda_2$ labels: $(4,3)$ $231$, $(4,1)$ $154$, $(3,1)$ $81$, $(2,1)$ $35$, $(6,3)$ $770$, $(5,3)$ $455$, $(5,1)$ $260$, $(3,3)$ $84$. All match the table.

Selection by $\lambda_2$ even:

| mult | selected | not selected |
|---|---|---|
| $4$ | $(4,2)$, $(2,2)$ | none |
| $3$ | $(3,2)$ | none |
| $2$ | $(5,2)$, $(4,4)$, $(4,0)$, $(3,0)$, $(2,0)$ | $(4,3)$, $(4,1)$, $(3,1)$, $(2,1)$ |
| $1$ | $(6,6)$, $(6,4)$, $(6,2)$, $(6,0)$, $(5,4)$, $(5,0)$, $(1,0)$, $(0,0)$ | $(6,3)$, $(5,3)$, $(5,1)$, $(3,3)$ |

- Block count $2+1+5+8=16$.
- Dimension sum $(220+35)+105+(390+165+55+30+14)+(455+810+625+140+429+91+5+1)=255+105+654+2556=3570$.
- Surviving multiplicities $41-16=25$, where $41=4\cdot2+3+2\cdot9+12$.
- Unknowns after losing one multiplicity in each selected block: $2\cdot6+3+5\cdot1+4\cdot3+4\cdot1=36$.
- Shape: $3\times3$ from the two multiplicity-$4$ blocks, $2\times2$ from $(3,2)$ and the four unselected multiplicity-$2$ blocks (five), scalars from the five selected multiplicity-$2$ blocks and the four unselected multiplicity-$1$ blocks (nine). Matches "two $3\times3$, five $2\times2$ and nine scalars".
- The eight deaths are exactly the eight selected multiplicity-$1$ blocks: $(0,0)$, $(1,0)$, $(5,0)$, $(5,4)$, $(6,0)$, $(6,2)$, $(6,4)$, $(6,6)$. Matches.
- Table self-consistency: $4\cdot255+3\cdot105+2\cdot1155+4125=7770=\binom{37}3$, the multiplicity-$1$ dimensions sum to $4125$, and unknowns sum to $20+6+27+12=65$.

"Each loses one multiplicity" is an equality in line 96 and is the subject of section 7. The arithmetic above is conditional on it and on the table.

## 7. The rank-one step and the stated bound

**7a. CONFIRMED AS ALGEBRA**, given claims 1 and 2, H2 and H7. A certificate uses only covariants in $\ker\mathrm{ev}_\lambda$ (section 1), of dimension $m_\lambda-\mathrm{rank}_\lambda$. Since $\mathrm{rank}_\lambda\le\dim V_\lambda^H$, the rank is $0$ on the eight odd-$\lambda_2$ blocks and at most $1$ on the sixteen. Surviving multiplicities are therefore at least $25$ and unknowns at least $36$, with equality exactly when all sixteen ranks equal $1$. This is Passage A line 94's reading and the heading's "$\ge36$".

**7b. HYPOTHESIS-DEBT.** Line 96 states "Each loses one multiplicity ... Eight of the twelve multiplicity-$1$ blocks die outright" as equalities, and line 98 promotes them with "An upper bound attained forces every one of the sixteen ranks to be exactly $1$, so no block has rank $0$ and $36$ is exact."

- The implication is valid algebra. With $\mathrm{rank}_\lambda\in\{0,1\}$ on the sixteen and every $d_\lambda>0$, $\sum_{16}\mathrm{rank}_\lambda d_\lambda=\sum_{16}d_\lambda=3570$ forces each rank to be $1$. The derived upper bound $3570$ is the dimension sum of section 6.
- Its premise is H8, which rests on a measurement (r170) and a recomputation over $\mathbb F_{46337}$ (r178). Under brief line 52 a statement supported only by a run is HYPOTHESIS-DEBT. The logical shape is right, since a rank over $\mathbb F_p$ of the reduction of a rational matrix is a lower bound for its rank over $\mathbb Q$, and it meets the derived upper bound.
- The identification of $\sum_\lambda\mathrm{rank}_\lambda d_\lambda$ with the dimension of the $O(5)$-submodule generated by $W_0^3$ is itself declared owed in the same paragraph ("what joins them is owed, see L87").

What would have to be proved: for each of the sixteen blocks, a covariant $\sigma\in M_\lambda$ with $\sigma(W_0)\neq0$. Equivalently, as line 99 proposes, that each block's highest-weight cubic fails to vanish somewhere on the orbit of $W_0$. The exactness of $36$, the shape, and the eight deaths hang on this.

**7c. CONFIRMED.** Passage C line 290 "bounds the certificate's unknown count from below by thirty-six" and line 962 "The lemma proves only $\ge36$ unknowns, the rank-one step belonging to a separate measurement" match 7a and 7b and the heading at line 70. "$65=36+29$": $65$ is Passage B's total, and $29$ is the number removed if every selected block loses one multiplicity, which is $\sum m_\lambda$ over the sixteen, $4+4+3+5\cdot2+8\cdot1=29$, since a block of multiplicity $m$ loses $m(m+1)/2-(m-1)m/2=m$ unknowns. The identity holds and is a restatement of the table, as line 962 says. The remark about "the heading claiming $65$" is taken up in the withdrawn candidates below.

## 8. Scope: dependence on Passage B

**HYPOTHESIS-DEBT.** Line 25: "The weight list and the multiplicities come from the character computation", sourced to a script. Line 38 itself records that "only $7770$ is an external check". That check passes (section 6), but it is one linear condition on twenty-four unknown multiplicities and does not fix them. Sections 6, 7a and 7b are exact arithmetic on the multiplicity column and inherit its status.

What would have to be proved: the decomposition of $\mathrm{Sym}^3V_{(2,2)}$ for $B_2$ with the multiplicities listed.

Falsifier screen, reported as a screen and not as evidence: the top of the table was read against weight multiplicities fixed by the simple-root string argument. In $V_{(2,2)}$ the weights $(2,1)=(2,2)-e_2$ and $(2,0)=(2,2)-2e_2$ have multiplicity $1$, because $(2,2)-(e_1-e_2)$ is not a weight. $\mathrm{Sym}^3$ then has weight $(6,6)$ once, $(6,5)$ once (from $(2,2)+(2,2)+(2,1)$), and $(6,4)$ twice (from $(2,2)+(2,2)+(2,0)$ and $(2,2)+(2,1)+(2,1)$). $V_{(6,6)}$ has $(6,5)$ and $(6,4)$ once each by the same argument. This leaves $(6,6)$ with multiplicity $1$, no $(6,5)$ block, and $(6,4)$ with multiplicity $1$, all as tabulated. No discrepancy was found at the three labels screened.

## 9. The boundary

**CONFIRMED**, no finding.

- $\lambda_2=0$: the two spin-zero candidates of section 3 coincide in $(0,0)$, one constituent, $j_R=0$, $(-1)^0=1$. The invariant is the $SO(4)$-fixed line, $\dim V^H=1$. Seen concretely at $(1,0)$ and $(2,0)$ in section 4c.
- The trivial block $(0,0)$: $V=\mathbb R$ with trivial action, $\dim V^H=1$, $\lambda_2=0$ even, consistent. Its death requires rank $1$, which falls under 7b like the other fifteen. No separate argument for it is on file.
- Multiplicity-$1$ blocks: rank at most $1=m$, so "dies outright" means rank exactly $1$ and is conditional on 7b. The four odd-$\lambda_2$ ones keep multiplicity $1$ unconditionally.
- The kernel of $W_0$: the padding is what makes $\varepsilon\in H$ (section 5) and what splits $H$ along $\mathbb R^4\oplus\mathbb Re_5$. That the kernel is exactly $\mathbb Re_5$ belongs to the stabiliser debt of section 2 (H3). Padding preserves tracelessness, since the $e_5$ terms of the Ricci contraction vanish, so $W_0\in\mathcal W_5$.

## Falsifying objects, claim by claim

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1a | A normalisation under which $F_5(W_0)\neq0$, or a certificate with a covariant nonzero at $W_0$ | No value of $W_{\mathbb{CP}^2}$ is in the brief, so none exhibited. Recorded as debt |
| 1b | An equivariant $\sigma$ vanishing on the orbit with $\sigma(W_0)\neq0$ | Excluded by the one-line equivariance argument |
| 2 | An element of $O(5)$ fixing $W_0$ outside the stated group | Listed the three structural features such an element needs (larger kernel, anti-self-dual part, triple eigenvalue). None exhibitable from the brief |
| 3 | A second constituent with $j_L=0$, or one with $j_R\neq\lambda_2$ | Interlacing rules both out, and screened at $(1,1)$, $(2,0)$, $(2,2)$ |
| 4a | A $\lambda$ with $\lambda_2$ odd and a fixed vector, or even and none | $d^j_{00}(\pi)=(-1)^j$ and the four hand-checks, derived directly |
| 4b | An $O(5)$-module with highest weight $\lambda$, $\lambda_2$ even, $V^H=0$ | Found: the defining module $\mathbb R^5$, and every module with $-\mathrm{Id}=-1$ |
| 5 | A constituent of $\mathrm{Sym}^3(\mathcal W_5)$ on which $\varepsilon$ acts nontrivially on $V^{H_0}$ | Excluded: $-I_5$ acts on $\mathcal W_5$ by $(-1)^4$ |
| 6 | A mismatch between the stated counts and the table | Every sum, dimension and shape recomputed by hand, no mismatch |
| 7a | A certificate with fewer than $36$ unknowns | Excluded by $\mathrm{rank}_\lambda\le\dim V_\lambda^H$ under H2 |
| 7b | A block among the sixteen whose every cubic covariant vanishes at $W_0$ | None exhibited in closed form. The question is exactly the debt |
| 8 | A multiplicity differing from the table | Screened at $(6,6)$, $(6,5)$, $(6,4)$, consistent |

## Withdrawn candidates

**W1. "The heading claiming $65$".**

1. *Location.* [results.md](../results.md) line 962: "the heading claiming $65$ claims a number the section itself disclaims". The L86 heading at [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 70 reads "and the $\ge36$ unknowns it leaves", with no $65$.
2. *Failure.* The only heading quoted for L86 does not claim $65$, so the sentence describes a claim absent from the passage it annotates.
3. *Charitable reading.* "The heading" may refer to a heading outside the cited lines (the $65$ appears in the table summary at line 38, and the section and file headings were not in the permitted lines), or to an earlier wording since corrected. The mathematical content of line 962, that only $\ge36$ is proved, matches Passage A exactly.

Withdrawn: the referent cannot be pinned to line 70 within the lines this verifier may read, and the discrepancy concerns the wording of a remark rather than any claim of the lemma. Recorded for the adjudicator as an editorial note.

**W2. "Frobenius reciprocity bounds the evaluation map".**

1. *Location.* Line 94: "Frobenius reciprocity bounds the evaluation map $M_\lambda\to V_\lambda^H$ by $\dim V_\lambda^H=1$".
2. *Failure.* The bound is the dimension of the codomain and uses no reciprocity.
3. *Charitable reading.* Frobenius reciprocity is what identifies $V_\lambda^H$ as the multiplicity of $V_\lambda$ in functions on $O(5)/H$, which is the natural home of the evaluation map. The bound stated is correct under either reading.

Withdrawn: the attribution is loose, and the inequality is correct.

## Overall verdict

**HYPOTHESIS-DEBT.**

- The parity mechanism (sections 3, 4a, 4c, 5) is correct algebra given the stabiliser.
- The canonical statement needs the hypothesis that $-\mathrm{Id}$ acts trivially (section 4b), without which the defining module $\mathbb R^5$ is a counterexample.
- Every count (section 6) and the lower bound $\ge36$ (section 7a) are exact arithmetic on Passage B.
- Four premises have no derivation on file: the stabiliser (section 2), the value $F_5(W_0)=0$ and the certificate's positivity (section 1a), the multiplicities of Passage B (section 8), and, for the exactness of $36$ and the eight deaths, the measured rank (section 7b).
- Once the first three are discharged, the lemma as headed (parity rule and $\ge36$) is PROVEN (hypotheses corrected). The exact $36$ additionally needs the rank-one step.
