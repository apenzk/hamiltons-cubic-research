# Verifier v307, Lemma L90: evaluation injective on the restricted image, restricted rank 13, dim ANN = 1, F_5 in the image, and the three conditions of the cap argument

The brief ([BRIEF_L90.md](BRIEF_L90.md)) was read cold. No numerical work was done, every value below is exact, and no scripts were written or run. Quotations were checked against exactly the cited lines 128, 149, 163-181 and 260 of [findings/sym3-blocks.md](../findings/sym3-blocks.md) and match verbatim. Log: [agent_logs/verify-L90-v307.log](../agent_logs/verify-L90-v307.log).

| # | Claim | Source line | Verdict |
|---|---|---|---|
| 1 | $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$ and equal ranks force equal kernels, so ev is injective on the image and $F_5$ is the unique image element agreeing with it at the 40 points | 163 | CONFIRMED AS ALGEBRA |
| 2 | Cap: every restricted image element vanishes at $W_0$, so restricted rank $\le 13$ | 175, 183 | CONFIRMED AS ALGEBRA |
| 3 | Lower bound: $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=13$ at the 40 points, hence restricted rank $=13$ and ev injective on the image | 163, 175 | HYPOTHESIS-DEBT |
| 4 | rank $13\Rightarrow\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, $F_5$ in the image | 177-179 | CONFIRMED AS ALGEBRA (conditional on row 3) |
| 5 | $F_5(W_0)=0$ | 179 | CONFIRMED |
| 6 | Status of the restricted rank: "IS 13 ... A THEOREM" (line 175) against "open in $[1,13]$" (line 181) | 175, 181 | REFUTED AS STATED |
| 7a | Rank cap conditional on equivariance, guarded by the multi-probe Schur test | 177 | HYPOTHESIS-DEBT |
| 7b | Vanishing at $W_0$ suffices for vanishing on the orbit | 178 | CONFIRMED AS ALGEBRA |
| 7c | Attainment is not self-validating | 179 | CONFIRMED |
| 8 | Provenance: "measured at four primes", "two audits stand behind it", "was nowhere in the record" | 163, 165 | HYPOTHESIS-DEBT |
| 9 | Affine family has dimension $36-13=23$ | 179 | HYPOTHESIS-DEBT |

Summary: the linear algebra of L90 is sound for $\mu$ restricted to Grams over $K$, but its one load-bearing input, the lower bound $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=13$ at the certificate's 40 points, is a modular measurement with no argument on file, and the record states the restricted rank both as a theorem and as open.

## 0. Conventions, fixed once

- $\mathcal W_5$: algebraic Weyl tensors on $\mathbb R^5$. $W_0$: padded Weyl tensor of $\mathbb{CP}^2$. $F_5=\tfrac32\lVert W\rVert^6-9\operatorname{tr}(W^3)^2$.
- $K\subset\mathrm{Sym}^3\mathcal W_5^*$: the cubics with $\sigma_\lambda(W_0)=0$, read (line 178) as the copy-index cut $K=\bigoplus_\lambda V_\lambda\otimes\ker T_\lambda$ inside each isotypic component $V_\lambda\otimes\mathbb R^{m_\lambda}$.
- $G_K:=\mathrm{Sym}^2(K)^{O(5)}$, the restricted invariant Gram space, of dimension $36$ per line 179. $G:=\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}$, of dimension $65$ per L89.
- $S:=(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, of dimension $14$ per L89 (Observation L85's standing).
- $\mu: G\to S$ is multiplication (L89). $\mu_K:=\mu|_{G_K}$. $\mathrm{ev}:S\to\mathbb R^{40}$ evaluates at the 40 sample points. $\mathrm{ev}_{W_0}:S\to\mathbb R$ evaluates at $W_0$.
- $\mathcal A(W_0^6)\in S$ is read as the invariant sextic representing $\mathrm{ev}_{W_0}$ under the apolar (Bombieri) pairing, which is positive definite on $\mathrm{Sym}^6$ and hence on $S$. $\mathrm{ANN}:=(\mathrm{im}\,\mu_K)^\perp\subseteq S$.
- Field: the image, ANN and the certificate live over $\mathbb R$. Ranks of matrices with entries in $\mathbb Q$ (or $\mathbb Q(i)$ representing a real map) are field-independent in characteristic $0$. Measurements are over $\mathbb F_p$ or $\mathbb F_p[i]$.
- $1000003\equiv3\bmod4$ and $1000033\equiv1\bmod4$, read off from $4\mid10^6$. Both are recorded primes (they are the first two primes above $10^6$). So $\mathbb F_{1000033}[i]\cong\mathbb F_p\times\mathbb F_p$ is split, as line 175 implies.

## Hypothesis inventory

| Hypothesis | Source | Used by the argument | Stated |
|---|---|---|---|
| $\dim S=14$ | L89, carrying Observation L85's standing | Yes. The cap is $\dim S-1=13$, and "attaining the cap forces equality" needs it exactly | Via L89 only. L90 inherits L85's standing, which Passage A never says |
| L89's surjectivity of $\mu$ onto $S$ | L89 | No. Line 181 correctly says it does not carry to $G_K$ | Yes |
| L62, "$\dim\mathrm{ann}=1$, so the rank is 13" | L62 heading | Not cited in Passage A. Its objects (ann versus ANN, which rank) are not identifiable from the heading | Heading only |
| Every element of $K$ vanishes at $W_0$ | Definition of $K$ | Yes, for the cap | Yes |
| $K$ is an $O(5)$-submodule | Line 178 | Yes, so that $\mu_K$ lands in $S$ and for 7b | Yes (reviewer 210) |
| Copies of $V_\lambda$ identified equivariantly | Line 177 | Yes. Without it neither the submodule property nor "sampled row $=\mu^*(\mathrm{ev}_W)$" holds | Yes, with the Schur test as its guard |
| $\mathrm{ev}_{W_0}\neq0$ on $S$ | Line 183 | Yes, for $\dim\mathrm{ANN}\ge1$ being spanned by a nonzero $\mathcal A(W_0^6)$ | Asserted. It checks against the definitions: $\lVert W\rVert^6\in S$ and $\lVert W_0\rVert\neq0$ |
| $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}\circ\mu_K)=13$ at the certificate's 40 points | Lines 163, 175 | Yes, load-bearing | Measured only |
| The 40 points of the measurement are the 40 points of the certificate, with rational (or Gaussian-rational) coordinates whose reductions were the sampled points | None | Yes. Injectivity is a property of a specific point set | **Used but unstated** |
| Every denominator (and any square root) in $W_0$, $T$, the Gram basis and the points is a unit in the ring reduced mod $p$ | None | Yes, for "reduction only loses rank" | **Used but unstated** |
| The restriction computed mod $p$ is the reduction of the rational one: $\mathrm{rank}_{\mathbb F_p}T=\mathrm{rank}_{\mathbb Q}T$ | None | Yes. If $\ker T$ grows mod $p$, the mod-$p$ domain is larger and its sampled rank bounds nothing over $\mathbb Q$ | **Used but unstated** |
| $\dim G_K=36$ | Line 179 | Only for the 23 of row 9 | Asserted, no source in the passages |

## 1. The load-bearing step (rows 1, 3; attack items 1, 2)

**Which map.** The step reads "$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$" with $\mu$ "the Gram-to-sextic map" and no restriction named. L89 gives $\mathrm{rank}\,\mu=14$ for the unrestricted $\mu$. So the step must be read with $\mu_K$, which is the reading lines 179 and 181 support ($36-13$, "the certificate ranges over the cubics $K$").

**Derivation, for $\mu_K$.**

1. $\ker\mu_K\subseteq\ker(\mathrm{ev}\circ\mu_K)$ trivially.
2. Sampling bounds from above: $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K$, because $\mathrm{im}(\mathrm{ev}\circ\mu_K)=\mathrm{ev}(\mathrm{im}\,\mu_K)$.
3. Cap (section 2): $\mathrm{rank}\,\mu_K\le13$.
4. If $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\ge13$, then 2 and 3 give $\mathrm{rank}\,\mu_K=13$ and $\dim\ker(\mathrm{ev}\circ\mu_K)=36-13=\dim\ker\mu_K$. With 1, the kernels are equal.
5. If $s\in\mathrm{im}\,\mu_K$ with $\mathrm{ev}(s)=0$, write $s=\mu_K(x)$. Then $x\in\ker(\mathrm{ev}\circ\mu_K)=\ker\mu_K$, so $s=0$. So ev is injective on $\mathrm{im}\,\mu_K$.
6. If $Q\in G_K$ has $\mathrm{ev}(\mu_K(Q))=\mathrm{ev}(F_5)$ and $F_5\in\mathrm{im}\,\mu_K$, then $\mu_K(Q)-F_5\in\mathrm{im}\,\mu_K$ has zero evaluations, so $\mu_K(Q)=F_5$.

Step 4 needs only the dimension count on a common domain, and the domain dimension cancels. Row 1 is CONFIRMED AS ALGEBRA.

**Which rank is measured, and in which direction.** The text says "$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured". What is measured is the sampled rank $\mathrm{rank}_{\mathbb F_p}(\mathrm{ev}_p\circ\mu_{K,p})$ (line 175, "$13$ at $40$ points mod $1000033$"). The unsampled rank $\mathrm{rank}\,\mu_K$ is derived, never measured. Reduction bounds $\mathrm{rank}_{\mathbb F_p}\le\mathrm{rank}_{\mathbb Q}$ for a fixed matrix over a ring mapping to $\mathbb F_p$. Sampling bounds $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K$. Both directions are stated correctly on line 175.

**Circularity.** The step is not circular. The cap is analytic (section 2), and the measurement supplies the opposite inequality. Nothing in the chain assumes injectivity or $\mathrm{rank}\,\mu_K=13$ in advance.

**What is not proven.** The input $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}\circ\mu_K)\ge13$ has no argument on file. Per the brief, a rank computed mod a prime and reported is a measurement. Row 3 is HYPOTHESIS-DEBT. To discharge it, one must prove that no nonzero element of $\mathrm{im}\,\mu_K$ vanishes at all 40 certificate points, together with $\mathrm{im}\,\mu_K$ having dimension 13. Equivalently, one must exhibit $13$ Grams in $G_K$ whose sextics have linearly independent evaluation vectors at those points. Beyond the modular measurement itself, the debt carries the three unstated hypotheses marked in the inventory: point identity, good reduction, and $\mathrm{rank}_{\mathbb F_p}T=\mathrm{rank}_{\mathbb Q}T$. Reviewer 209's reproduction used "its own points" (line 175). It therefore bears on $\mathrm{rank}\,\mu_K$ but cannot bear on injectivity at the certificate's points.

**Non-circular routes in the passages (item 2).**

- **The unrestricted rank.** L89's $14$ gives no lower bound on $\mathrm{rank}\,\mu_K$, because $G_K\subsetneq G$ and line 181 records that surjectivity does not carry.
- **L62.** Its heading "$\dim\mathrm{ann}=1$, so the rank is $13$" would, if its ann is ANN for $\mu_K$, give $\mathrm{rank}\,\mu_K=13$ without measurement. Passage A does not cite it, and its objects cannot be identified from the heading.
- **Point-specific injectivity.** Neither route reaches injectivity of ev at the 40 specific points. That is a property of the point set, and no argument for it appears in the passages.

## 2. The cap (row 2)

Each $k\in K$ vanishes at $W_0$ by definition. An element of $\mathrm{im}\,\mu_K$ is $\sum_{ij}Q_{ij}k_ik_j$ with $k_i\in K$, so it vanishes at $W_0$. It lies in $S$ because $K$ is a submodule and $\mu$ is equivariant. Hence $\mathrm{im}\,\mu_K\subseteq\ker(\mathrm{ev}_{W_0}|_S)$.

$\mathrm{ev}_{W_0}|_S\neq0$, since $\lVert W\rVert^6\in S$ takes the value $\lVert W_0\rVert^6\neq0$ at $W_0$. So the kernel has dimension $\dim S-1=13$, and $\mathrm{rank}\,\mu_K\le13$.

The only order-1 input is vanishing of the factors, which matches line 183 "it comes from order 1". Line 183's further remark is also correct: products already vanish to order 2 at $W_0$, so demanding order-2 vanishing adds no linear condition beyond this one. Row 2 is CONFIRMED AS ALGEBRA, and the number 13 inherits the standing of $\dim S=14$.

## 3. From rank 13 to $F_5$ in the image (rows 4, 5; item 4)

Assume $\mathrm{rank}\,\mu_K=13$.

- **dim ANN.** $\dim\mathrm{ANN}=14-13=1$, since the pairing is definite on $S$.
- **ANN is spanned by $\mathcal A(W_0^6)$.** $\mathcal A(W_0^6)$ pairs with $s\in S$ as a nonzero multiple of $s(W_0)$. By section 2 it annihilates the image, and it is nonzero because $\mathrm{ev}_{W_0}|_S\neq0$. So $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$.
- **$F_5$ in the image.** $F_5\in S$, and $F_5(W_0)=0$ gives $F_5\perp\mathrm{ANN}$. So $F_5\in\mathrm{ANN}^\perp=\mathrm{im}\,\mu_K$ over $\mathbb R$.

Row 4 is CONFIRMED AS ALGEBRA, conditional on row 3.

**Row 5, closed form.** $W_0$ is the padded Fubini–Study Weyl tensor. As an operator on $\Lambda^2\mathbb R^5$ its only nonzero eigenvalues are those of $W^+$ on $\Lambda^+$, namely $(2c,-c,-c)$ for some $c\neq0$ ($W^-=0$, and the padding adds zeros).

- **Operator normalisation.** $\lVert W_0\rVert^2=\operatorname{tr}W_0^2=6c^2$ and $\operatorname{tr}W_0^3=(8-1-1)c^3=6c^3$. So $F_5(W_0)=\tfrac32\cdot216c^6-9\cdot36c^6=324c^6-324c^6=0$.
- **Index normalisation.** $W_{ijkl}W_{ijkl}=4\operatorname{tr}W^2$ and $W_{ijkl}W_{klmn}W_{mnij}=8\operatorname{tr}W^3$. Both terms scale by $64$, and the value is again $0$.

This agrees with "exact over $\mathbb Z$ in both normalisations". Row 5 is CONFIRMED. The record's own support for it is its computation. The closed form above is this verifier's check, not an argument credited to the record.

## 4. The status of the restricted rank (row 6; items 4, 5)

**Candidate: lines 175 and 181 state incompatible statuses for one number.**

1. **Location.** Line 175: "**THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM.**" Line 181: "**On the restricted space the argument does not carry, and the rank is open in $[1,13]$.**" Line 181 names the map as "$\mu$ restricted to them", the cubics $K$. That is the same $\mu_K$ whose "restricted sampled rank" line 175 reports.
2. **Failure.** One passage asserts $\mathrm{rank}\,\mu_K=13$ as a theorem, and the other asserts that $\mathrm{rank}\,\mu_K$ is undetermined in $[1,13]$. Both cannot hold of the same object at the same time.
3. **Most charitable reading.** Line 181 describes the analytic status and line 175 adds a measurement. Under that reading the rank is analytically open and measured to be 13. The mathematics is then consistent, but line 175's "IS A THEOREM" becomes false, because the lower bound it rests on is the measurement of section 1. Reading "theorem" as the implication "sampled rank 13 implies rank 13" rescues the word but not the capitalised claim that the restricted rank is 13. Under every reading one of the two sentences is false as written.

The candidate survives all three steps. Row 6 is REFUTED AS STATED. The lower bound $1$ in $[1,13]$ raises no issue: for any nonzero irreducible $V\subseteq K$ with orthonormal basis $k_i$, $\sum k_i^2$ is a nonzero invariant sextic in $\mathrm{im}\,\mu_K$.

## 5. The three conditions (rows 7a-7c; item 6)

**7a, equivariance.** The claim is that the sampled row equals $\mu^*(\mathrm{ev}_W)$ only when copies are identified equivariantly. This is correct as algebra. The cut $V_\lambda\otimes\ker T_\lambda$ is a submodule, and $T_\lambda a=\sum_c a_c\,(\mathrm{ev}_{W_0}\circ\varphi_c)$ is a single condition for all of $V_\lambda$, only when each copy map $\varphi_c:V_\lambda\to\mathrm{Sym}^3$ is equivariant. Without that, neither the cap nor 7b holds. The guard named, "the multi-probe Schur test", is a computation with no argument on file that it certifies equivariance. The $S_3$ example (sampled rank $10$ against cap $7$) is reported without its data and cannot be checked from the brief. It is illustrative, not load-bearing. Row 7a is HYPOTHESIS-DEBT: one must prove that the identification used is equivariant, or that the Schur test as run implies it.

**7b, orbit.** Let $k\in K$ and $g\in O(5)$. Then $k(gW_0)=(g^{-1}\cdot k)(W_0)$, and $g^{-1}\cdot k\in K$ because $K=\bigoplus V_\lambda\otimes\ker T_\lambda$ is a submodule. So $k(gW_0)=0$. Cutting individual weight vectors ("positions") would not give a submodule, so the remark that it "would break it" is correct. Row 7b is CONFIRMED AS ALGEBRA, given 7a.

**7c, attainment.** A construction defect that yields sampled rank exactly 13 is indistinguishable from a correct one by the rank alone. So "attaining the cap forces equality" certifies $\mathrm{rank}\,\mu_K=13$ only if the matrix measured is $\mathrm{ev}\circ\mu_K$ for the correct $K$. The statement is true, and it is the reason row 3 is debt rather than merely a modular certificate. Row 7c is CONFIRMED. The account of the correct condition ("$Ta=0$ for the expansion vector $a$, unconjugated", with the vectors differing by the multiplicity Gram) uses objects the brief does not define, and was not checked.

## 6. Provenance and the affine dimension (rows 8, 9; item 3)

- **"measured at four primes" (line 163).** The passages name two primes, $1000033$ and $1000003$ (line 175). Further primes may be recorded outside the brief, so this is not a contradiction. The attribution is unsupported within the brief, and row 8 is HYPOTHESIS-DEBT.
- **"Two audits stand behind it" (line 165).** Both audits described concern the SDP point: the $47$-column block partition with minimum eigenvalue $-1440$, and the LDL acceptance test at the denominator-$10^4$ point. Neither touches $\ker(\mathrm{ev}\circ\mu)$ or any rank. See withdrawn candidate W2.
- **"was nowhere in the record" (line 163).** This concerns files outside the brief and cannot be checked cold. No finding.
- **Row 9.** Given $F_5\in\mathrm{im}\,\mu_K$, the affine family $\{Q\in G_K:\mu_K(Q)=F_5\}$ has dimension $\dim\ker\mu_K=\dim G_K-13$. That is $23$ exactly when $\dim G_K=36$, which the passages assert without source, and it rests on row 3. Row 9 is HYPOTHESIS-DEBT. "Confirmed by exact arithmetic" is exact modular arithmetic combined with the cap. It is a valid lower-bound route, with the debt of section 1.

## 7. Scope, edges, and the gap between proven and stated (standing items 2, 3, 4; attack items 7, 8)

**Scope (item 7).**

| Question | Answer |
|---|---|
| Map | $\mu_K:G_K\to S$. The heading "evaluation is injective on the image" and the step on line 163 do not name the restriction. For the unrestricted $\mu$, rank is $14$ and $\mathrm{ev}$ of rank $13$ would not be injective on its image |
| Points | The 40 certificate points, which must coincide with the measured ones |
| Field | $\mathbb R$ for the image and the certificate. The measurement is over $\mathbb F_p$ or $\mathbb F_p[i]$ |
| Why 40 | Injectivity on a 13-dimensional space needs at least 13 points, so 40 is margin. Nothing in the argument depends on 40 beyond $40\ge13$ |

**Edges.**

- **Degenerate sample.** A point on the orbit of $W_0$ gives a zero row. That loses rank and cannot create a false attainment.
- **Rank exactly on the cap.** See 7c: attainment of the cap is invisible to defects that also land on it.
- **Reduction mod $p$.** At $p=1000033$, $\mathbb F_p[i]$ is split. Rank over each factor is still at most the rank over $\mathbb Q(i)$ under a ring map $\mathbb Z[i][1/N]\to\mathbb F_p$, so the direction survives provided the elimination was done in a factor field. The kernel-jump hazard for $T$ mod $p$ is listed in the inventory.

**Proven versus stated (item 4).**

- **Stated.** Evaluation is injective on the image, the restricted rank is a theorem equal to 13, and $F_5$ lies in the image.
- **Proven.** For $\mu_K$, if $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}\circ\mu_K)\ge13$ at the certificate's rational points, then ev is injective on $\mathrm{im}\,\mu_K$, $\mathrm{rank}\,\mu_K=13$, $\dim\mathrm{ANN}=1$, and $F_5\in\mathrm{im}\,\mu_K$. The antecedent is measured.

**Passage D (item 8).** Both Lean files are withheld, so nothing they state can be checked in this round. No finding. No claim in the table rests on them.

**Falsifiers and search (item 6).**

| Claim | Falsifying object | What was done |
|---|---|---|
| Row 1 | Linear maps with $\ker\mu\subseteq\ker(\mathrm{ev}\circ\mu)$, equal finite ranks, and ev not injective on $\mathrm{im}\,\mu$ | None exists, by steps 4-5 of section 1 |
| Row 2 | An element of $\mathrm{im}\,\mu_K$ nonzero at $W_0$ | Excluded by the factor argument |
| Row 3 | A nonzero $s\in\mathrm{im}\,\mu_K$ vanishing at all 40 points, or a second functional in ANN independent of $\mathcal A(W_0^6)$ | Searched analytically for an invariant linear condition beyond order-1 vanishing at $W_0$. Order-2 vanishing is free, and no other condition is derivable from the passages. Not settled, since the point set is not on file |
| Row 5 | $F_5(W_0)\neq0$ | Evaluated in closed form, value $0$ |
| Row 6 | The two sentences themselves | Quoted in section 4 |
| Row 7b | $k\in K$ and $g$ with $k(gW_0)\neq0$ | Excluded by the submodule argument |

### Withdrawn candidates

- **W1, "$13=\mathrm{rank}\,\mu$" contradicts L89's rank 14 (line 163).** (1) Located at line 163, with $\mu$ "the Gram-to-sextic map", against L89 line 128, where rank is $\dim S=14$. (2) Read with the unrestricted $\mu$, $13\neq14$, and the step fails. (3) Charitable reading: $\mu$ means $\mu_K$, supported by lines 179 and 181. **Withdrawn at step 3.** The scope imprecision is recorded in section 7.
- **W2, "Two audits stand behind it" misattributes support to the injectivity step (line 165).** (1) Located at line 165, immediately after the step. (2) The audits concern the SDP point's block partition and the LDL acceptance test, not the rank or the kernels. (3) Charitable reading: "it" is the certificate as a whole, of which the step is one part. **Withdrawn at step 3.** The step's support is the measured rank alone.
- **W3, "three wrong restrictions" against "the two wrong ones" (line 179).** (1) Located at line 179. (2) Three wrong restrictions, then "the two wrong ones each carried one half". (3) Charitable reading: the correct condition pairs two binary choices, the expansion vector and no conjugation. That gives $2\times2-1=3$ wrong combinations, of which exactly two carry one half. **Withdrawn at step 3.**
- **W4, the kernel of $T$ grows mod $p$ and inflates the domain (inventory).** (1) Line 175, "Sampling and reduction only lose rank". (2) No concrete prime, $T$ or dimension is on file where $\mathrm{rank}_{\mathbb F_p}T<\mathrm{rank}_{\mathbb Q}T$, so no failure can be exhibited in closed form. **Withdrawn at step 2.** It is retained as an unstated hypothesis inside row 3's debt.

## Overall verdict

**HYPOTHESIS-DEBT.** The chain from the ranks to injectivity, from rank 13 to $F_5$ in the image, the cap, and the orbit argument are all correct as algebra, and $F_5(W_0)=0$ holds in closed form. The one load-bearing input, $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}\circ\mu_K)=13$ at the certificate's 40 points, is a modular measurement with three unstated hypotheses (point identity, good reduction, no kernel jump in $T$ mod $p$) and an equivariance guard with no argument. Separately, lines 175 and 181 are REFUTED AS STATED as a pair: the record calls the restricted rank a theorem and also calls it open.
