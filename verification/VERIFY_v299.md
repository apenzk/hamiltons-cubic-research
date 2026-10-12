# Verifier v299, Lemma L88: the invariant counts 65, 24 and 89 on Sym^3(W_5), the real type of the 24 blocks, the gauge status of the Lambda^2 invariants, and the coordinate remark

The brief ([BRIEF_L88.md](BRIEF_L88.md)) was cold. No numerical work was done: every value below is exact, no scripts were written or run, and every sum over the table was taken by hand. Log: [agent_logs/verify-L88-v299.log](../agent_logs/verify-L88-v299.log). Quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) at lines 23-36, 106 and 120-130 only, and match verbatim. The Lean files of Passage C were withheld and were not read.

| # | Claim | Verdict |
|---|---|---|
| 1 | $\dim\mathrm{Sym}^2(U)^{O(5)}=65$ | HYPOTHESIS-DEBT |
| 1a | $\sum_\lambda\binom{m_\lambda+1}2=65$ over Passage B | CONFIRMED AS ALGEBRA |
| 2 | $\dim\Lambda^2(U)^{O(5)}=24$ | HYPOTHESIS-DEBT |
| 2a | $\sum_\lambda\binom{m_\lambda}2=24$ over Passage B | CONFIRMED AS ALGEBRA |
| 3 | $65+24=89=\sum m_\lambda^2$ | CONFIRMED AS ALGEBRA (a tautology, it checks nothing beyond addition) |
| 4 | every block is of real type, so each $M_\lambda$ carries a real structure and the invariant form is real symmetric in a real basis | CONFIRMED (classical import unfiled, hypotheses match, conclusion routed through Passage B) |
| 5 | "the $24$ directions a Hermitian ansatz offers beyond the $65$ are ... of $\Lambda^2$ ... and they are gauge" | GAP |
| 5a | an antisymmetric form contributes nothing to the sextic | CONFIRMED AS ALGEBRA |
| 6 | "On a multiplicity-$2$ block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$" | REFUTED AS STATED (by the passage's own example $Q=\mathrm{diag}(1,i)$) |
| 6a | the "$4000$ bases", relative distance $\ge0.541$, and the measured $h$ on $(2,0)$ | HYPOTHESIS-DEBT |
| 6b | $Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction | CONFIRMED AS ALGEBRA (under the reading of $h$ and $Q$ fixed in section 0) |

**Summary.** The arithmetic on the table is exact and the real-type step is classically sound, but the two headline dimensions rest only on a script and on measured multiplicities, the identification of the $24$ excess directions with $\Lambda^2$ is inferred from a dimension match, and the "iff" of the coordinate remark is contradicted by the remark's own converse example.

**Overall verdict: HYPOTHESIS-DEBT** (with a GAP in the gauge identification and one sentence REFUTED AS STATED).

## 0. Conventions, fixed once

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$, of dimension $\tfrac{n^2(n^2-1)}{12}-\tfrac{n(n+1)}2=50-15=35$ at $n=5$. $U=\mathrm{Sym}^3(\mathcal W_5)$ has dimension $\binom{37}3=7770$.
- $G$ is $O(5)$ unless $SO(5)$ is named. $U=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ over $\mathbb R$, $m_\lambda=\dim M_\lambda$.
- Highest weights are written in the orthogonal $\varepsilon$-coordinates of $B_2$, with $\rho=(3/2,1/2)$. This convention is forced by Passage B: $\langle\lambda,\lambda+2\rho\rangle=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$ is the stated Casimir, and the Weyl dimension formula in these coordinates is, with $a_1=2\lambda_1+3$ and $a_2=2\lambda_2+1$, $d_\lambda=(a_1^2-a_2^2)\,a_1a_2/24$. In these coordinates $SO(5)$-representations have $\lambda\in\mathbb Z^2$ and genuine $\mathrm{Spin}(5)$-representations have $\lambda\in(\tfrac12+\mathbb Z)^2$. "Integral" in Passage A is read in this sense.
- Objects used in Passage A but not defined in the brief: $h$, $Q$, "the kernel direction", "the imaginary coordinate", "the split", "relative distance", "the Hermitian assert", "the multi-probe test". To check item 5 I fix the following reading, and every statement made under it is labelled. On a block $\lambda$, $v=(v_1,\dots,v_m)$ is the $\mathbb Q(i)$ highest-weight basis of $M_\lambda$ and $e$ is a basis real for the real structure $\sigma$, orthonormal for the inner product of $U$. $Q=P$ is the change of basis $v=eP$, $P\in GL_m(\mathbb C)$. $h=P^*P$ is the Gram of the inner product of $U$ on $v$. An invariant Hermitian form on the block is $X\otimes g_\lambda$ with $X$ Hermitian, and in $v$-coordinates $X_v=P^*X_eP$. On $m=2$ the Hermitian ansatz has coordinates $X_v=\begin{psmallmatrix}a&b+ic\\b-ic&d\end{psmallmatrix}$ and "the imaginary coordinate" is the $c$-direction $iJ$, $J=\begin{psmallmatrix}0&1\\-1&0\end{psmallmatrix}$. The kernel direction is $X_e=iJ$, the one $\Lambda^2$ direction.
- The Gram-to-sextic map sends a form $B$ on $U$ to $p_B(W)=B(W^3,W^3)$, $W\in\mathcal W_5$.

## Hypothesis inventory

**Of the statement.** $\mathcal W_5$ and $U$ as above, the natural $O(5)$-action, the isotypic decomposition of $U$, and an SOS Gram read as a quadratic form on $U$.

**Imported results.**

| Import | Status | Hypotheses | Met by the object? |
|---|---|---|---|
| Schur's lemma, and the resulting decomposition of invariant bilinear forms on $\bigoplus V_\lambda\otimes M_\lambda$ | classical, unfiled, used implicitly (never invoked in the text) | $V_\lambda$ irreducible, pairwise non-isomorphic, $\mathrm{End}_G(V_\lambda)=\mathbb R$ | yes, given Passage B and claim 4: the $24$ highest weights are distinct and all of real type |
| Real, complex and quaternionic type of irreducibles of $\mathrm{Spin}(5)\cong Sp(2)$ and of $SO(5)$ | classical, unfiled | compact connected group, complex irreducible representation labelled by a dominant weight | yes for the $24$ weights of Passage B |
| Weyl integration for $\dim\mathrm{Sym}^2(U)^G$, $\dim\Lambda^2(U)^G$ | script only ([run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py), not opened) | none checkable | HYPOTHESIS-DEBT |
| Weyl dimension formula and Casimir for $B_2$ | classical, stated in Passage B | $\varepsilon$-coordinates | yes, all $24$ dimensions recomputed by hand in section 1 |
| Character computation of the multiplicities | script only ([run_casimir_separation.py](../scripts/runs/run_casimir_separation.py), not opened) | none checkable | HYPOTHESIS-DEBT |

**Used but unstated.**

- **U1.** $-I\in O(5)$ acts trivially on $U$. The passage speaks of $O(5)$ throughout and labels blocks by $B_2$ weights, which label $SO(5)$-representations. Since $O(5)=SO(5)\times\{\pm I\}$, the two groups have the same invariants on $U$, and each $V_\lambda$ is a well-defined $O(5)$-representation, only if $-I$ acts on $U$ by $+1$. Passages A and B do not say so. (The block labelled $(1,0)_5$ is then the determinant twist of $\mathbb R^5$ as an $O(5)$-representation, a labelling point that does not move any count.)
- **U2.** The sextic is $O(5)$-invariant and a Gram may be replaced by its group average, which keeps the sextic and positive semidefiniteness. "An SOS Gram is an invariant quadratic form" needs this to be read as a statement about the reduced ansatz (see withdrawn candidate W1).
- **U3.** The invariant bilinear form on each real-type $V_\lambda$ is unique up to scalar and symmetric.
- **U4.** Every invariant Hermitian form $H$ on $U\otimes\mathbb C$ splits as $H|_{U\times U}=S+iA$ with $S$ symmetric and $A$ antisymmetric invariant real forms on $U$. This is what "beyond the $65$ ... of $\Lambda^2$" requires, and it is where claim 5's GAP sits.
- **U5.** The $\varepsilon$-coordinate reading of "integral" (section 0). In the Lie-theoretic sense every weight of a finite-dimensional representation of $\mathfrak{so}(5)$ is integral, spin weights included, so the word carries the intended meaning only in these coordinates. The passage's own phrase "half-integral spin ones" fixes that reading.

## 1. The dimensions 65 and 24 (attack items 1 and 6)

**What is on file.** Passage A: "Weyl integration settles it in [run_n5_unknown_count.py] ... and those are exactly $\sum m(m+1)/2$, $\sum m(m-1)/2$ and $\sum m^2$ on the measured multiplicities". Two sources are cited, a script and the measured table. Neither is an argument. The agreement with the sums is reported as an observation, and no derivation that $\dim\mathrm{Sym}^2(U)^G=\sum\binom{m_\lambda+1}2$ is written.

**The table, read by hand.** Dimensions by $d_\lambda=(a_1^2-a_2^2)a_1a_2/24$:

| $\lambda$ | $(a_1,a_2)$ | $d_\lambda$ | table |
|---|---|---|---|
| $(4,2)$ | $(11,5)$ | $96\cdot55/24=220$ | 220 |
| $(2,2)$ | $(7,5)$ | $24\cdot35/24=35$ | 35 |
| $(3,2)$ | $(9,5)$ | $56\cdot45/24=105$ | 105 |
| $(5,2)$ | $(13,5)$ | $144\cdot65/24=390$ | 390 |
| $(4,3)$ | $(11,7)$ | $72\cdot77/24=231$ | 231 |
| $(4,4)$ | $(11,9)$ | $40\cdot99/24=165$ | 165 |
| $(4,1)$ | $(11,3)$ | $112\cdot33/24=154$ | 154 |
| $(3,1)$ | $(9,3)$ | $72\cdot27/24=81$ | 81 |
| $(4,0)$ | $(11,1)$ | $120\cdot11/24=55$ | 55 |
| $(2,1)$ | $(7,3)$ | $40\cdot21/24=35$ | 35 |
| $(3,0)$ | $(9,1)$ | $80\cdot9/24=30$ | 30 |
| $(2,0)$ | $(7,1)$ | $48\cdot7/24=14$ | 14 |
| $(6,6)$ | $(15,13)$ | $56\cdot195/24=455$ | 455 |
| $(6,4)$ | $(15,9)$ | $144\cdot135/24=810$ | 810 |
| $(6,3)$ | $(15,7)$ | $176\cdot105/24=770$ | 770 |
| $(6,2)$ | $(15,5)$ | $200\cdot75/24=625$ | 625 |
| $(6,0)$ | $(15,1)$ | $224\cdot15/24=140$ | 140 |
| $(5,4)$ | $(13,9)$ | $88\cdot117/24=429$ | 429 |
| $(5,3)$ | $(13,7)$ | $120\cdot91/24=455$ | 455 |
| $(5,1)$ | $(13,3)$ | $160\cdot39/24=260$ | 260 |
| $(5,0)$ | $(13,1)$ | $168\cdot13/24=91$ | 91 |
| $(3,3)$ | $(9,7)$ | $32\cdot63/24=84$ | 84 |
| $(1,0)$ | $(5,1)$ | $24\cdot5/24=5$ | 5 |
| $(0,0)$ | $(3,1)$ | $8\cdot3/24=1$ | 1 |

All $24$ agree. $\sum m_\lambda d_\lambda$: $4(220+35)=1020$, $3\cdot105=315$, $2(390+231+165+154+81+55+35+30+14)=2\cdot1155=2310$, and the multiplicity-$1$ dimensions sum to $4125$. Total $1020+315+2310+4125=7770=\binom{37}3$. Block counts $2+1+9+12=24$, multiplicities $8+3+18+12=41$.

- $\sum\binom{m+1}2=2\cdot10+6+9\cdot3+12\cdot1=65$.
- $\sum\binom m2=2\cdot6+3+9\cdot1+0=24$.
- $\sum m^2=2\cdot16+9+9\cdot4+12=89$.

So rows 1a and 2a are CONFIRMED AS ALGEBRA.

**What the headline claims need and do not have.** For $\dim\mathrm{Sym}^2(U)^G=\sum\binom{m+1}2$ and $\dim\Lambda^2(U)^G=\sum\binom m2$ to follow from the table, the record owes: every constituent is absolutely irreducible of real type and pairwise non-isomorphic (claim 4 and distinct weights), the invariant form $g_\lambda$ on $V_\lambda$ is unique and symmetric (U3), and by Schur an invariant bilinear form on $U$ is $\bigoplus_\lambda\beta_\lambda\otimes g_\lambda$ with $\beta_\lambda$ a bilinear form on $M_\lambda$, symmetric exactly when the whole form is symmetric and antisymmetric exactly when it is antisymmetric. None of this is written. And the multiplicities themselves come from a character computation that is measured, with only $7770$ as an external check, which Passage B says itself.

**Rows 1 and 2: HYPOTHESIS-DEBT.** Owed: (i) the multiplicity table of Passage B, by an argument on file, and (ii) the Schur decomposition of invariant bilinear forms stated above, with U1 and U3. Alternatively, the Weyl integrals by an argument on file.

**Scope (attack item 6).** Every numerical headline of L88 depends on Passage B's multiplicities: $65$, $24$ and $89$ are functions of the $m_\lambda$ alone. The one external check $\sum m_\lambda d_\lambda=7770$ does not pin them: it is one linear relation among $24$ unknown non-negative integers, while $\sum m_\lambda^2$ is quadratic in them. Claim 4 also routes through the table ("none occur"). Claim 5a is table-independent.

**Edges (standing item 3).** Multiplicity-$1$ blocks contribute $1$ to $\mathrm{Sym}^2$ and $0$ to $\Lambda^2$, so all $24$ gauge directions live on the $12$ blocks with $m\ge2$ ($9\cdot1+3+2\cdot6$). The two coincident dimensions, $(2,2)_{35}$ with $(2,1)_{35}$ and $(6,6)_{455}$ with $(5,3)_{455}$, are distinct highest weights, hence non-isomorphic, so the Schur cross terms vanish between them and equal dimension moves nothing. The real type of each block is item 4.

**Falsifier and search.** A correct multiplicity table differing from Passage B, or a constituent of complex or quaternionic type. I recomputed all $24$ dimensions and the total $7770$ by hand, checked that the top weight $(6,6)=3\cdot(2,2)$ is the top weight of $\mathrm{Sym}^3$ of $\mathcal W_5=V_{(2,2)}$ (consistent with $m_{(6,6)}=1$), and checked every weight is in $\mathbb Z^2$. Pinning the remaining multiplicities is a character computation, which this loop does not do. No falsifier found, none excluded.

## 2. "65 + 24 = 89" as a check (attack item 2)

Per block $\binom{m+1}2+\binom m2=m^2$ identically, so over any table whatever $\sum\binom{m+1}2+\sum\binom m2=\sum m^2$. Against the script outputs the same holds at the level of characters, $\chi_{\mathrm{Sym}^2U}+\chi_{\Lambda^2U}=\chi_U^2$, so the two Weyl integrals sum to $\dim\mathrm{End}_G(U\otimes\mathbb C)$ for every representation, of every type. The equation can detect an arithmetic slip in one of the three sums and nothing else. It carries no information about the multiplicities or about real type. (The split $65/24$ matching $\sum\binom{m+1}2/\sum\binom m2$ would be type-sensitive if the integrals were independent of the table, since a quaternionic block reverses the two binomials. But the integrals are script-only.)

**Row 3: CONFIRMED AS ALGEBRA**, as a tautology.

## 3. Real type (attack item 3)

**Derivation on file.** "Every one of the $24$ weights is integral for $B_2$, hence of real type, the quaternionic representations of $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ are the half-integral spin ones, and none occur, so each multiplicity space carries a real structure and the invariant form is real symmetric in a real basis."

**Link by link.**

- All $24$ weights of Passage B lie in $\mathbb Z^2$ in $\varepsilon$-coordinates (read off the table). Confirmed.
- Every irreducible of $\mathrm{Spin}(5)$ is self-dual because $-1$ lies in the Weyl group of $B_2$, so each is real or quaternionic. Those with $\lambda\in\mathbb Z^2$ factor through $SO(5)$ and are of real type, and the half-integral ones are quaternionic, the spin representation $\mathbb C^4$ of $Sp(2)$ being the basic case. This is the classical classification, unfiled. Its hypotheses (compact connected group, complex irreducible labelled by a dominant weight) are met by each $V_\lambda$ as an $SO(5)$-representation. Under U1, the $O(5)$-commutant equals the $SO(5)$-commutant because $-I$ acts by a scalar, so the type is unchanged for $O(5)$.
- "Of $\mathfrak{so}(5)$": type is a property of the compact group, $\mathrm{Spin}(5)$ or $SO(5)$, and the Lie algebra is read as shorthand for it.
- Real type of $V_\lambda$ gives a conjugate-linear $j$ on $V_\lambda\otimes\mathbb C$ with $j^2=1$, and with complex conjugation $c$ on $U\otimes\mathbb C$ the map $\sigma(f)=c\circ f\circ j$ is a real structure on $M_\lambda=\mathrm{Hom}_G(V_\lambda,U)\otimes\mathbb C$. Confirmed.
- "The invariant form is real symmetric in a real basis": read as the Gram, a real symmetric invariant form on $U$, or as the inner product Gram $h$, it is true in a $\sigma$-real basis because both forms are real on real vectors. Read as an arbitrary invariant Hermitian form it would be false, see W2.

**Row 4: CONFIRMED**, with the classification unfiled and its hypotheses met. "None occur" is established on file only for the table. That no spin-type constituent can occur in $U$ regardless of the table would follow from U1-type reasoning ($U$ is a representation of $SO(5)$), and that is not on file.

**Falsifier and search.** A block with $\lambda\notin\mathbb Z^2$. Every weight in Passage B was read. None.

## 4. The 24 directions and gauge (attack item 4)

**On file.** "So the $24$ directions a Hermitian ansatz offers beyond the $65$ are genuine $O(5)$-invariants, of $\Lambda^2$. An antisymmetric form contributes nothing to a quadratic, hence nothing to the sextic, and they are gauge."

### 4.1 The gauge sentence for the sextic map

If $A$ is an antisymmetric bilinear form on $U$, then $A(u,u)=-A(u,u)$, so $A(u,u)=0$ for every $u\in U$, in particular $A(W^3,W^3)=0$. **Row 5a: CONFIRMED AS ALGEBRA.** It is table-independent. It asserts that $i\Lambda^2(U)^G$ lies in the kernel of the Gram-to-sextic map, not that it is the whole kernel, and the passage claims no more.

### 4.2 Candidate C1, the identification "So ... of $\Lambda^2$"

1. **Location.** "**So the $24$ directions a Hermitian ansatz offers beyond the $65$ are genuine $O(5)$-invariants, of $\Lambda^2$.**" The "So" follows the sentence establishing $65$, $24$ and $89$, and nothing else precedes it.
2. **Failure.** Equality of dimensions, $89-65=24=\dim\Lambda^2(U)^G$, does not identify a $24$-dimensional subspace: a complement of the $65$ inside the $89$ is a choice. The passage's own next paragraph exhibits a complement that is not $\Lambda^2$. Under the section 0 reading, on an $m=2$ block with $P=\mathrm{diag}(1,i)$, the imaginary coordinate $X_v=iJ$ is, in the real basis, $X_e=P^{-*}X_vP^{-1}=\mathrm{diag}(1,i)\begin{psmallmatrix}0&i\\-i&0\end{psmallmatrix}\mathrm{diag}(1,-i)=\begin{psmallmatrix}0&1\\1&0\end{psmallmatrix}$, a real symmetric form, of $\mathrm{Sym}^2$, whose sextic is not forced to vanish. So "the directions beyond the $65$" chosen as imaginary coordinates are neither of $\Lambda^2$ nor gauge.
3. **Charitable reading.** "The directions beyond the $65$" means the canonical complement, the invariant Hermitian forms that are purely imaginary on $U\times U$. That reading makes the sentence true and matches the heading and "That $24$ of the $89$ directions are gauge is a theorem". Under it, though, the step from the counts to "of $\Lambda^2$" is still the dimension match, and the fact that makes it true, U4 ($H|_{U\times U}=S+iA$ uniquely, so the canonical complement is $i\Lambda^2(U)^G$), is not written anywhere in Passage A.

The candidate survives step 3 as a missing step, not as a false claim. **Row 5: GAP.** The step owed is U4: every invariant Hermitian form on $U\otimes\mathbb C$ restricts to $U\times U$ as $S+iA$ with $S\in\mathrm{Sym}^2(U^*)^G$ and $A\in\Lambda^2(U^*)^G$, uniquely, so that the canonical $24$-dimensional complement of the $65$ is $i\Lambda^2(U^*)^G$. Also owed, from section 1, is the value $24$ itself.

### 4.3 Positive semidefiniteness

The passage makes no claim about the cone. Recorded as withdrawn candidate W3, with one statement owed if the reduction from the Hermitian to the real symmetric ansatz is used anywhere for feasibility: that $H\succeq0$ implies $\operatorname{Re}H\succeq0$ in a real basis.

**Falsifier and search.** For 5a, an antisymmetric form with a nonzero diagonal value: impossible over a field of characteristic not $2$. For C1, a coordinate complement that is not $\Lambda^2$: exhibited above, $P=\mathrm{diag}(1,i)$.

## 5. "The dimension is right and the coordinates are not" (attack item 5)

**Undefined objects.** $h$, $Q$, "kernel direction", "relative distance", "the split", "Hermitian assert", "multi-probe test" are not defined in the brief. Checks below use the section 0 reading.

### 5.1 Candidate C2, the "iff"

1. **Location.** "On a multiplicity-$2$ block the kernel direction is the imaginary coordinate iff $\operatorname{Im}h=0$".
2. **Failure.** Two sentences later: "$Q=\mathrm{diag}(1,i)$ gives $h=I$ with a real symmetric kernel direction". Here $\operatorname{Im}h=\operatorname{Im}I=0$, and the kernel direction is real symmetric, which is never the imaginary coordinate: a nonzero multiple of $iJ$ is purely imaginary and antisymmetric. That is a counterexample to the "if" half of the "iff" taken from the passage itself, and it does not depend on my reading of $h$. Under the section 0 reading it is also exact: $h=P^*P=\mathrm{diag}(1,-i)\,\mathrm{diag}(1,i)=I$, and the kernel direction in $v$-coordinates is $X_v=P^*(iJ)P=\mathrm{diag}(1,-i)\begin{psmallmatrix}0&i\\-i&0\end{psmallmatrix}\mathrm{diag}(1,i)=\begin{psmallmatrix}0&-1\\-1&0\end{psmallmatrix}$, real symmetric.
3. **Charitable reading.** "iff" was meant as "only if" (kernel direction equal to the imaginary coordinate implies $\operatorname{Im}h=0$), and "The converse fails too" is the author retracting the "if" half. Under that reading the sentence is not false, but as written it asserts both halves, and the text contains both the assertion and its counterexample.

**Row 6: REFUTED AS STATED.** Corrected form: "only if". The "only if" half has no argument on file, and I did not construct an object that refutes it.

### 5.2 The remaining sub-claims

- **"Such a basis forces $h$ real symmetric".** Under section 0, a $\sigma$-real basis has real inner products because the inner product of $U$ is real on real vectors. The sentence is correct under the reading, and the passage offers no argument for it. Its contrapositive, "$h$ measured non-real, so the basis in hand is not $\sigma$-real", is valid logic. The passage calls this "evidence", which undersells a valid deduction from an unargued premise.
- **The measured $h$ on $(2,0)$.** $h=\begin{psmallmatrix}1&55i/37\\-55i/37&5075/1628\end{psmallmatrix}$ is Hermitian, and $\det h=\tfrac{5075}{1628}-\tfrac{3025}{1369}=\tfrac{187775-133100}{60236}=\tfrac{54675}{60236}>0$ (with $1628=4\cdot11\cdot37$, $60236=4\cdot11\cdot37^2$), so it is positive definite, as a Gram of an inner product must be. Exact arithmetic confirmed. The value itself is a measurement reproduced by reviewers: HYPOTHESIS-DEBT.
- **"Over $4000$ bases consistent with the measured $h$ the relative distance never fell below $0.541$".** A sampled minimum over a continuous family (the $P$ with $P^*P=h$ form a $U(2)$-orbit), with "relative distance" undefined. It bounds nothing, and the conclusion it supports ("false") would need the unargued "only if" half of 5.1 instead. **Row 6a: HYPOTHESIS-DEBT.**
- **The converse example.** Exact under the reading, see 5.1 step 2. The phrase "which the split would have kept among the $65$" holds if "the split" puts real coordinates in the $65$. **Row 6b: CONFIRMED AS ALGEBRA** under the reading.
- **"Rephasing one copy by $i$ moves the split while passing the Hermitian assert, $\det h\ne0$ and the multi-probe test".** Under the reading, $v_2\mapsto iv_2$ sends $h\mapsto\mathrm{diag}(1,-i)\,h\,\mathrm{diag}(1,i)$, which multiplies the off-diagonal entries by $\pm i$, keeps $h$ Hermitian, and keeps $\det h$. The two named tests are undefined script checks. No finding on the algebra, and the tests are not checkable.
- **"Identifying the actual $24$ needs the real structure computed on each $M_\lambda$".** A methodological remark, not a mathematical claim. No finding.

## 6. Passage C (attack item 7)

No finding: both Lean files were withheld from the brief and were not opened.

## 7. Withdrawn candidates

- **W1. "An SOS Gram is an invariant quadratic form on $\mathrm{Sym}^3(\mathcal W_5)$."** (1) Line 122 of [findings/sym3-blocks.md](../findings/sym3-blocks.md), quoted in Passage A. (2) Read literally, an invariant sextic's SOS Grams need not be invariant: the kernel of $\mathrm{Sym}^2(U)\to\mathrm{Sym}^6$ is a nonzero $G$-subrepresentation of dimension far above $65$, so it contains non-invariant elements $K$, and $G_0+\varepsilon K$ is a non-invariant Gram whenever $G_0$ is positive definite. (3) The sentence concludes "so the unknowns are $\mathrm{Sym}^2(\ldots)^{O(5)}$", a statement about the symmetry-reduced ansatz, which loses no generality by averaging (U2). **Withdrawn at step 3.** Step 2 also could not be exhibited in closed form, since no specific sextic with a positive definite Gram is on file. U2 is recorded in the inventory.
- **W2. "The invariant form is real symmetric in a real basis"** read as any invariant Hermitian form. (1) Passage A, third paragraph. (2) $X_e=iJ$ on an $m=2$ block is invariant, Hermitian, and not real symmetric in the real basis. (3) The sentence's subject is the SOS Gram (a real quadratic form) or $h$, both real symmetric in a real basis. **Withdrawn at step 3.**
- **W3. "They are gauge"** read as free directions of the PSD feasible set. (1) Passage A, "and they are gauge". (2) On an $m=2$ block, $X_e=I+2iJ=\begin{psmallmatrix}1&2i\\-2i&1\end{psmallmatrix}$ has eigenvalues $3$ and $-1$, so it is not positive semidefinite while $\operatorname{Re}X_e=I$ is and has the same sextic: the $\Lambda^2$ directions are not free inside the cone. (3) The sentence derives "gauge" from "nothing to the sextic", a statement about the linear map, and asserts nothing about the cone. **Withdrawn at step 3.** If the record anywhere relies on Hermitian and real symmetric feasibility coinciding, the statement owed is $H\succeq0\Rightarrow\operatorname{Re}H\succeq0$ in a real basis.
- **W4. "Integral for $B_2$"** as a false criterion (in the Lie-theoretic sense spin weights are integral too). (1) Passage A, third paragraph. (2) $(\tfrac12,\tfrac12)$ is an integral weight of $\mathfrak{so}(5)$ and is quaternionic. (3) "The half-integral spin ones" fixes the $\varepsilon$-coordinate meaning, the one Passage B's formulas use. **Withdrawn at step 3**, recorded as U5.

## 8. Standing items

1. **Hypothesis inventory.** See the section above: two script-only imports (HYPOTHESIS-DEBT), two unfiled classical imports whose hypotheses are met, and five used-but-unstated hypotheses U1-U5, of which U4 is the GAP of row 5.
2. **Quantifier order and scope.** Group: $O(5)$ in the statement and $SO(5)$ weights in the table, reconciled only through U1, which is unstated. Field: all three dimensions are field-independent (the real dimension of real invariants equals the complex dimension of complex invariants), and the Hermitian count $89$ is a real dimension of a $\mathbb Q(i)$-rational space. Basis: the counts are basis-free, and the coordinate identification is basis-dependent, which is item 5. Gram to sextic against the PSD cone: 4.1 confirms the kernel inclusion, and W3 records that the cone does not see the $\Lambda^2$ directions as free.
3. **Edges.** Multiplicity-$1$ blocks carry no gauge and the $h$ discussion is vacuous there ($1\times1$, real positive). Equal-dimension blocks are non-isomorphic. Every block is of real type on the table. See sections 1 and 3.
4. **Proven against stated.** Proven on file: the arithmetic (rows 1a, 2a, 3, 6b), real type on the table given the classical import (row 4), and $\Lambda^2$ forms are invisible to the sextic (row 5a). Stated beyond that: the two dimensions (debt), the identification of the excess with $\Lambda^2$ (gap), and an "iff" whose "if" half the text itself refutes.
5. **Brief items 1-7.** Sections 1, 2, 3, 4, 5, 1 (scope) and 6 respectively.
6. **Falsifiers.** Named at the end of sections 1, 3, 4 and in 5.1. The objects exhibited are $P=\mathrm{diag}(1,i)$ (against C1's coordinate reading and C2's "if" half) and $X_e=I+2iJ$ (W3). No falsifier exists for 5a. For the dimensions, the falsifier would be a different multiplicity table, and pinning that down is a computation outside this loop.

## Overall verdict

**HYPOTHESIS-DEBT.** Lemma L88's two dimensions have no argument on file beyond a script and measured multiplicities, though they do follow arithmetically from Passage B. Its gauge claim holds for the sextic map but identifies the excess directions with $\Lambda^2$ through a dimension match (GAP, owed U4). Within the supporting remark, the "iff $\operatorname{Im}h=0$" is REFUTED AS STATED by the remark's own example, corrected to "only if".
