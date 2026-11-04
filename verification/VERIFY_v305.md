# Verifier v305, Lemma L90: evaluation injective on the image, the restricted rank 13, the display placing $F_5$ in the image, and the restricted-space bound

The brief ([BRIEF_L90.md](BRIEF_L90.md)) was read cold. No numerical work was done: no scripts, no computations, every value exact. Quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 128, 149, 163-181 and 260 only, and all match verbatim. Log: [agent_logs/verify-L90-v305.log](../agent_logs/verify-L90-v305.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Kernel algebra: $\ker(\mathrm{ev}\circ\mu)\supseteq\ker\mu$, equal ranks force equal kernels, so $\mathrm{ev}$ is injective on $\mathop{\mathrm{im}}\mu$ and an image element agreeing with $F_5$ at the points is $F_5$ | CONFIRMED AS ALGEBRA |
| C2 | The step's input: $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ "measured at four primes", at "those $40$" points | HYPOTHESIS-DEBT |
| C3 | Restricted rank $13$: "attaining the cap forces equality", headlined as a theorem | HYPOTHESIS-DEBT |
| C4 | Display algebra: rank $13$ and the ambient $14$ give $\dim\mathrm{ANN}=1$, $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, and $F_5(W_0)=0$ gives $F_5$ in the image | CONFIRMED AS ALGEBRA |
| C5 | $F_5(W_0)=0$, "exact over $\mathbb Z$ in both normalisations" | HYPOTHESIS-DEBT |
| C6 | Affine family $36-13=23$ dimensional | HYPOTHESIS-DEBT |
| C7a | Rank cap conditional on an equivariant identification of copies | CONFIRMED AS ALGEBRA |
| C7b | Multi-probe Schur test guards equivariance | HYPOTHESIS-DEBT |
| C7c | Vanishing at $W_0$ suffices for vanishing on the orbit | CONFIRMED AS ALGEBRA |
| C7d | Attainment not self-validating, and "the correct condition is $Ta=0$ ... unconjugated" | HYPOTHESIS-DEBT |
| C8 | Upper bound $13$ from order-$1$ vanishing | CONFIRMED AS ALGEBRA |
| C9 | Order-$2$ vanishing is free, so the bound cannot be sharpened that way | HYPOTHESIS-DEBT |
| C10 | "The rank is open in $[1,13]$" stated beside "THE RESTRICTED RANK IS $13$ ... A THEOREM" | GAP |
| C11 | Heading scope: which $\mu$, which $\mathrm{ev}$, which points, which field | GAP |
| C12 | Attributions: "measured at four primes", "two audits stand behind it", "was nowhere in the record" | GAP |

Summary: every algebraic implication in Passage A holds, but the load-bearing input (the rank of $\mathrm{ev}\circ\mu$ at the specific points used) is a measurement, the statement never fixes the points or field, and the section asserts two incompatible standings for the restricted rank. Overall: HYPOTHESIS-DEBT.

## 0. Conventions, fixed once

- $\mathcal W_5$: algebraic Weyl tensors on $\mathbb R^5$, $\dim\mathcal W_5=35$. $W_0$: the padded Weyl tensor of $\mathbb{CP}^2$. $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$.
- $I_6:=(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, of dimension $14$ by Observation L85 as carried in Lemma L89.
- $K\subseteq\mathrm{Sym}^3\mathcal W_5^*$: the cubics with $\sigma_\lambda(W_0)=0$ (brief). $D:=$ the restricted Gram space on which the certificate ranges, of dimension $36$ per line 169.
- $\mu_K:D\to I_6$ the Gram-to-sextic map on $D$. $\mu_{89}:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}\to I_6$ the map of Lemma L89, onto, rank $14$.
- $P=\{x_1,\dots,x_{40}\}$ a sample, over a field $k$. $\mathrm{ev}_P:I_6\otimes k\to k^{40}$ evaluation. "Sampled rank" means $\mathrm{rank}_k(\mathrm{ev}_P\circ\mu_K)$.
- $\mathcal A$: the $O(5)$-average, so $\mathcal A(W_0^6)\in I_6^*$ pairs with invariant $f$ as a positive multiple of $f(W_0)$. $\mathrm{ANN}\subseteq I_6^*$: the annihilator of $\mathop{\mathrm{im}}\mu_K$.
- The loop's rule: a rank computed mod a prime and reported is a measurement, and a statement resting only on one is HYPOTHESIS-DEBT.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated in L90? |
|---|---|---|---|
| $\mu_{89}$ onto $I_6$, rank $\dim I_6$ | L89 (given) | Only the ambient dimension $14$ enters L90 (cap, $\dim\mathrm{ANN}=14-13$). The onto property itself is explicitly not carried to $K$ (line 179). | Not cited |
| $\dim I_6=14$ with Observation L85's standing | L89 says the value "carries those Observations' standing" | C4, C8 | Not stated. L90 uses $14$ with no mention that it inherits an Observation's standing. Used but unstated. |
| $\dim\mathrm{ann}=1$, rank $13$ | L62 (given, heading only) | Not used by Passage A, which derives rank $13$ from sampling. Could supply $\mathrm{rank}\,\mu_K=13$ (item 2). | Not cited. L62's map and space are not given in the brief, so the match of its "rank" to $\mu_K$ cannot be checked. |
| Every element of $K$ vanishes at $W_0$ | Definition of $K$ via $\sigma_\lambda(W_0)=0$ | C4, C8 | Implicit. The brief does not define $\sigma_\lambda$, so the link from $\sigma_\lambda(W_0)=0$ to $k(W_0)=0$ is taken as the definition's content. |
| $K$ is an $O(5)$-submodule | Line 175 | C7c, and implicitly in $\mu_K$ landing in $I_6$ | Argued (copy index cut, $V_\lambda$ whole) |
| The sampled matrix is a specialisation of the matrix of $\mathrm{ev}_P\circ\mu_K$ | Line 173 | C2, C3 ("sampling only loses rank") | Stated as a condition, guarded by a test only |
| Matrix entries $p$-integral at the primes used | none | C2, C3 ("reduction only loses rank") | Used but unstated |
| $P$ is the same point set at which the certificate's $40$ equations are imposed, and is a set of rational points whose reductions were sampled | none | C1 to C2 transfer, "those $40$ values" | Used but unstated |
| $\dim D=36$ | line 169 | C6 | Unargued |
| $K\neq0$ | none | Lower end $1$ of $[1,13]$ | Used but unstated |

## 1. C1, the kernel algebra (CONFIRMED AS ALGEBRA)

For linear maps $\mu:D\to V$ and $\mathrm{ev}:V\to k^{40}$ on finite-dimensional spaces, $\mu(x)=0$ implies $\mathrm{ev}(\mu(x))=0$, so $\ker\mu\subseteq\ker(\mathrm{ev}\circ\mu)$. Rank-nullity gives $\dim\ker(\mathrm{ev}\circ\mu)-\dim\ker\mu=\mathrm{rank}\,\mu-\mathrm{rank}(\mathrm{ev}\circ\mu)$. If the ranks are equal, the nested kernels have equal dimension and coincide.

Equal kernels give injectivity on the image: if $v=\mu(x)\in\mathop{\mathrm{im}}\mu$ and $\mathrm{ev}(v)=0$, then $x\in\ker(\mathrm{ev}\circ\mu)=\ker\mu$, so $v=0$. Conversely injectivity on the image gives equal ranks, so the step is an equivalence: $\mathrm{rank}(\mathrm{ev}\circ\mu)=\mathrm{rank}\,\mu$ if and only if $\mathrm{ev}$ is injective on $\mathop{\mathrm{im}}\mu$.

Uniqueness: if $F_5\in\mathop{\mathrm{im}}\mu$ and $g\in\mathop{\mathrm{im}}\mu$ with $\mathrm{ev}(g)=\mathrm{ev}(F_5)$, then $g-F_5\in\mathop{\mathrm{im}}\mu\cap\ker\mathrm{ev}=0$. Each link holds, and all three happen over one field $k$ with one point set.

## 2. C2, the input to the load-bearing step (HYPOTHESIS-DEBT)

**Which rank is measured, and the direction.** Sampling can measure only $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)$. It bounds $\mathrm{rank}\,\mu_K$ from below: $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)\le\mathrm{rank}\,\mu_K$ for any composition, and a rank over $\mathbb F_p$ of the reduction of a $p$-integral rational matrix is at most its rank over $\mathbb Q$, since a nonzero minor mod $p$ lifts to a nonzero minor. $\mathrm{rank}\,\mu_K$ itself is never measured by sampling. It follows only from the lower bound together with the cap $\mathrm{rank}\,\mu_K\le13$ (C8) or from L62.

**Circularity.** Read in isolation, line 163 takes "$\mathrm{rank}\,\mu=13$" as measured, and a measurement of $\mathrm{rank}\,\mu$ by sampling presupposes the injectivity the step concludes. With the cap from lines 167 and 181 the chain is non-circular: $13\le\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)\le\mathrm{rank}\,\mu_K\le13$. By C1 the equality of the outer terms is itself the injectivity, so "equal dimensions force equal kernels" needs nothing beyond the measured lower bound and the cap. See withdrawn W1.

**Candidate S1: injectivity is a property of the point set, and the passage never fixes it.**

1. Location. Line 163: "$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes ... a sextic there is pinned by those $40$ values". Line 167: "reviewer 209 reproduced it independently at $p=1000003$ ... with its own code, its own points".
2. Failure exhibited. Take $P$ to be $40$ points on the ray-orbit $\mathbb R_{>0}\cdot O(5)W_0$. Every element of $\mathop{\mathrm{im}}\mu_K$ vanishes at $W_0$ (C8), hence on the orbit (C7c), hence on the ray by homogeneity, so $\mathrm{ev}_P\circ\mu_K=0$ and its rank is $0$, while $\mathrm{rank}\,\mu_K$ is unchanged. More simply, $40$ copies of one point give rank at most $1$. So a rank measured at one point set says nothing about injectivity at another, and the record's two measurements used different point sets. A measurement at random points of $\mathbb F_p$ establishes $\mathrm{rank}\,\mu_K\ge13$, but "pinned by those $40$ values" is a claim about the specific set at which $F_5$'s equations are imposed.
3. Charitable reading. The $40$ points are rational points, the certificate imposes its equations at exactly those points, and the mod-$1000033$ computation sampled their reductions. Then $\mathrm{rank}_{\mathbb F_p}\ge13$ lifts to $\mathrm{rank}_{\mathbb Q}\ge13$ at those points, which holds over $\mathbb R$, and the step goes through. Reviewer 209's reproduction on its own points then corroborates $\mathrm{rank}\,\mu_K\ge13$ only. The passage states none of this.

Survives. What would have to be proved: that $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)=13$ at the certificate's own $40$ points, over $\mathbb Q$ (or over $\mathbb F_p$ for reductions of those rational points, with $p$ dividing no denominator of the matrix). Even so stated it is a measurement under the loop's rule, so the verdict is HYPOTHESIS-DEBT rather than GAP.

## 3. C3, the restricted rank $13$ (HYPOTHESIS-DEBT)

The implication "sampled rank $\le\mathrm{rank}\,\mu_K\le$ cap, sampled rank $=$ cap, hence $\mathrm{rank}\,\mu_K=13$" is correct as algebra under two hypotheses: the sampled matrix is a specialisation of $\mathrm{ev}_P\circ\mu_K$ (C7a), and the entries are $p$-integral. The cap is derived (C8). The lower bound is a rank reported mod $1000033$ and mod $1000003$.

**Candidate S2: the headline "A THEOREM" rests on a measurement, and the record's own third condition removes the measurement's self-check.**

1. Location. Line 167: "**THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM.** The restricted sampled rank attains the derived cap". Line 177: "A defect landing the rank exactly *on* the cap is invisible."
2. Failure exhibited. The lower bound $13$ exists only as a reported modular rank, which the brief classes as a measurement. Line 177 grants that a sampled matrix failing to factor through $\mu_K$ (a wrong restriction) can land exactly at $13$, so the value $13$ does not certify that the matrix measured is the matrix of $\mathrm{ev}_P\circ\mu_K$. The inference then rests on the Schur test (C7b) and the restriction's correctness (C7d), neither with an argument on file.
3. Charitable reading. "Theorem" refers to the necessary condition ($F_5$ in the image, C4), which is a theorem given the rank. L62, a given, states "the rank is $13$". If L62's rank is $\mathrm{rank}\,\mu_K$, then $\mathrm{rank}\,\mu_K=13$ holds without measurement. Passage A does not cite L62, and the brief gives only its heading, so neither its map nor whether its own proof rests on this same sampled rank can be checked.

Survives as debt. What would have to be proved: $\mathrm{rank}\,\mu_K\ge13$ by an argument, or an explicit citation of L62 with its statement shown to concern $\mu_K$ on $D$.

## 4. C4, the display algebra (CONFIRMED AS ALGEBRA)

Given $\mathrm{rank}\,\mu_K=13$ and $\dim I_6=14$: $\dim\mathrm{ANN}=14-13=1$. Every element of $\mathop{\mathrm{im}}\mu_K$ is a sum $\sum G_{ij}k_ik_j$ with $k_i\in K$, so it vanishes at $W_0$, and $\mathcal A(W_0^6)$ pairs with invariant $f$ as a positive multiple of $f(W_0)$. Hence $\mathcal A(W_0^6)\in\mathrm{ANN}$.

$\mathcal A(W_0^6)\neq0$ on $I_6$: $\lVert W\rVert^6\in I_6$ and $\lVert W_0\rVert^6>0$ because $W_0\neq0$. So $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$. An element $f\in I_6$ lies in $\mathop{\mathrm{im}}\mu_K$ if and only if $\mathrm{ANN}$ kills it (finite dimension, image equals double annihilator), that is if and only if $f(W_0)=0$. With $F_5\in I_6$ ($\lVert W\rVert$ and $\mathop{\mathrm{tr}}W^3$ are $O(5)$-invariant) and $F_5(W_0)=0$, $F_5\in\mathop{\mathrm{im}}\mu_K$.

Inputs carried: the rank $13$ (C3, debt), the $14$ with Observation L85's standing (unstated in L90), $F_5(W_0)=0$ (C5).

## 5. C5, $F_5(W_0)=0$ (HYPOTHESIS-DEBT)

The only support in the passage is "exact over $\mathbb Z$ in both normalisations" (line 169), a computation. No argument is on file, so the finding is debt: what would have to be proved is $6\mathop{\mathrm{tr}}(W_0^3)^2=\lVert W_0\rVert^6$ in each normalisation used.

Falsifier search, reported as a screen and not as evidence. On $\Lambda^2\mathbb R^5$ the padded tensor acts as $W_0^+\oplus0$ with $W_0^+$ of Kähler spectrum $(2a,-a,-a)$, so $\mathop{\mathrm{tr}}_{\Lambda^2}W^2=6a^2$ and $\mathop{\mathrm{tr}}_{\Lambda^2}W^3=6a^3$. With $\lVert W\rVert^2=c\mathop{\mathrm{tr}}_{\Lambda^2}W^2$ and $\mathop{\mathrm{tr}}W^3=d\mathop{\mathrm{tr}}_{\Lambda^2}W^3$, $F_5(W_0)=324(c^3-d^2)a^6$. Both $(c,d)=(1,1)$ and the full tensor contraction $(c,d)=(4,8)$ satisfy $c^3=d^2$. No failure found.

## 6. C6, the affine family $36-13=23$ (HYPOTHESIS-DEBT)

The arithmetic is right: the solution set of $\mu_K(G)=F_5$ is a coset of $\ker\mu_K$, nonempty by C4, of dimension $\dim D-\mathrm{rank}\,\mu_K$. $\dim D=36$ has no argument in the passage, and the rank is C3's. "Confirmed by exact arithmetic" is a computation. What would have to be proved: $\dim D=36$ and C3.

## 7. C7, the three conditions

### 7a. Equivariance (CONFIRMED AS ALGEBRA)

The bound "sampled $\le\mathrm{rank}\,\mu_K$" is a rank inequality for a composition, and it applies only when the sampled matrix is that composition's matrix. If the copies of $V_\lambda$ are identified non-equivariantly, the rows are not $\mu_K^*(\mathrm{ev}_W)$ and no bound follows, so the conditionality is correct. The $S_3$ example (sampled $10$ against cap $7$) is reported without data in the brief and was not checked. It is not needed for the conditional.

### 7b. The Schur test as guard (HYPOTHESIS-DEBT)

"What guards it is the multi-probe Schur test" (line 173). A test run on probes is a computation, and no argument that passing it implies an equivariant identification is on file. What would have to be proved: that the identification used is $O(5)$-equivariant.

### 7c. Orbit vanishing (CONFIRMED AS ALGEBRA)

With $(g\cdot m)(W)=m(g^{-1}W)$: if $M$ is a submodule and every $m\in M$ vanishes at $W_0$, then $m(gW_0)=(g^{-1}\cdot m)(W_0)=0$ since $g^{-1}\cdot m\in M$. A restriction of the form $U_\lambda\otimes V_\lambda$ inside $M_\lambda\otimes V_\lambda$ is a submodule because $O(5)$ acts on the second factor only (given an equivariant identification, 7a). A proper nonzero subspace of the irreducible $V_\lambda$ is not invariant, which is the content of "restricting positions instead would break it". Every link holds.

### 7d. Attainment and the condition $Ta=0$ (HYPOTHESIS-DEBT)

"A defect landing the rank exactly on the cap is invisible" is correct: a sampled rank equal to $13$ is consistent with a matrix that does not factor through $\mu_K$. The same sentence undercuts the evidence for "the correct condition is $Ta=0$ for the expansion vector $a$, unconjugated" (line 177). Coming out above the cap proves the two wrong restrictions wrong, but by the record's own point landing on it does not prove the third right. $T$, $a$ and the multiplicity Gram are undefined in the brief, and no argument is on file. What would have to be proved: that $Ta=0$ with $a$ unconjugated cuts out exactly the copies whose span vanishes at $W_0$.

## 8. C8, the order-$1$ upper bound (CONFIRMED AS ALGEBRA)

$\mathop{\mathrm{im}}\mu_K\subseteq\{f\in I_6: f(W_0)=0\}=\ker(\mathrm{ev}_{W_0}|_{I_6})$, since each product of two elements of $K$ vanishes at $W_0$. $\mathrm{ev}_{W_0}$ is nonzero on $I_6$ ($\lVert W\rVert^6$, §4), so its kernel has dimension $13$ and $\mathrm{rank}\,\mu_K\le13$. Hypotheses: elements of $K$ vanish at $W_0$ (definition), $\dim I_6=14$ (L85 standing). The lower end $1$ of $[1,13]$ additionally needs $K\neq0$, unstated.

## 9. C9, order-$2$ vanishing is free (HYPOTHESIS-DEBT)

Line 181: "the bound **cannot be sharpened** by demanding more vanishing at the point, the extra condition being free". This claims every $f\in I_6$ with $f(W_0)=0$ has $df(W_0)=0$. The passage gives no argument, so it is debt. What would have to be proved: that invariance forces $df(W_0)=0$.

Falsifier search, a screen only. A falsifier is $f\in I_6$ with $f(W_0)=0$ and $df(W_0)\neq0$. $df(W_0)$ is fixed by $\mathrm{Stab}(W_0)\supseteq U(2)$. Under $O(4)\times O(1)$, $\mathcal W_5=\mathcal W_4\oplus S^2_0\mathbb R^4\oplus(\text{a }16\text{-dim piece in }\Lambda^2\mathbb R^4\otimes\mathbb R^4)$, and the $U(2)$-fixed vectors are $\mathbb R W_0$ in $\mathcal W_4^+$ and nothing else (no invariant in $\mathcal W_4^-$, no trace-free invariant symmetric form on $\mathbb C^2$, odd central weights on the $16$). So $df(W_0)=c\langle W_0,\cdot\rangle$, and Euler's identity gives $c\lVert W_0\rVert^2=6f(W_0)=0$. No falsifier exists.

## 10. C10, two standings for one rank (GAP)

**Candidate S3.**

1. Location. Line 167: "**THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM.**" and line 169's display "$\mathrm{rank}=13$". Line 179: "**On the restricted space the argument does not carry, and the rank is open in $[1,13]$.**"
2. Failure exhibited. Both sentences concern $\mu_K$ on the cubics $K$ (line 179 names "$\mu$ restricted to them"). One asserts the value $13$ with theorem standing, the other asserts that the value is undetermined in $[1,13]$. As standings of one quantity these are incompatible, and no sentence in the quoted passage says which holds or that one supersedes the other. With L62 taken as stated ("the rank is $13$"), line 179 is wrong. Under the loop's rule (a modular rank is a measurement), line 167's "theorem" is wrong for the lower bound.
3. Charitable reading. "Open" describes what the order-$1$ argument alone gives, and "theorem" describes the implication from the measured rank. That reading reconciles the mathematics but leaves the record stating, unqualified, both that the rank is $13$ and that it is open.

Survives. What is missing: a statement of the rank's standing on $D$ and its ground (L62, or the measurement with its debt).

## 11. C11, heading scope (GAP)

**Candidate S4.**

1. Location. Line 149: "#### Lemma L90, evaluation is injective on the image". Line 163: "Writing $\mu$ for the Gram-to-sextic map and $\mathrm{ev}$ for evaluation".
2. Failure exhibited. The heading names no map, point set or field. The only $\mu$ with a stated statement in the brief is L89's $\mu_{89}$, of rank $14$, for which "$\mathrm{rank}\,\mu=13$" is false. For multiplication on all of $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)$ the image is all of $\mathrm{Sym}^6\mathcal W_5^*$, of dimension $\binom{40}{6}$, and $40$ evaluations cannot be injective on it. Injectivity also fails for degenerate samples (S1). So the heading, read literally, is false or undefined for every map it could name except $\mu_K$ at a suitable point set.
3. Charitable reading. Context ("restricted", the $13$, the certificate) fixes $\mu=\mu_K$, $P=$ the certificate's points, $k=\mathbb Q$. On that reading the heading is C1 plus C2.

Survives as a gap between what is stated and what is argued. What is missing: a statement naming $\mu_K$ on $D$, the $40$ points, and the field.

## 12. C12, attributions (GAP)

**Candidate S5.**

1. Location. Line 163: "measured at four primes". Line 165: "**Two audits stand behind it, and both found real errors.**" Line 163: "was nowhere in the record".
2. Failure exhibited. Passage A names two primes, $1000033$ and $1000003$, not four. The two audits of line 165 (block ordering by $\lambda$ versus $(-m,\lambda)$, and the inline LDL passing a point with leading minor $-3.47\times10^{-4}$) concern the SDP optimum and its acceptance test. Neither touches evaluation, its rank, or the kernel argument, so neither stands behind the load-bearing step.
3. Charitable reading. The other two primes are recorded elsewhere in the file, outside the cited lines. "It" in line 165 refers to the certificate section as a whole. "Nowhere in the record" cannot be checked from a cold brief, and nothing in Passages B and C states the injectivity, so that phrase is no finding.

"Four primes" and "two audits stand behind it" survive as unsupported by the passages: the audits cannot be counted as review of the step.

## 13. Withdrawn candidates

- **W1, circularity of line 163.** Step 1: "$\mathrm{rank}\,\mu$ is measured". Step 2: sampling measures $\mathrm{rank}\,\mu$ only if $\mathrm{ev}$ is injective on the image, the conclusion. Step 3: the cap (lines 167, 181) plus "sampled $\le\mathrm{rank}\,\mu_K$", which holds without injectivity, gives the equality non-circularly. Withdrawn at step 3. The residual mislabel of $\mathrm{rank}\,\mu$ as measured is in C2.
- **W2, $\mu$ is L89's map and $13\neq14$.** Withdrawn at step 3 as a mathematical error: context fixes $\mu_K$. The underspecification is kept in C11.
- **W3, $1000033\equiv1\bmod4$ makes $\mathbb F_p[i]\cong\mathbb F_p\times\mathbb F_p$ and the rank ill-defined.** $1000033=4\cdot250008+1$, so the algebra is split. Step 2 fails: an elimination completing with $13$ unit pivots yields a unit $13\times13$ minor whose image in each factor field is nonzero, so no overstatement follows, and the inert prime $1000003=4\cdot250000+3$ is reported to agree. No concrete failure. Withdrawn at step 2. The value remains a measurement (C2).
- **W4, $\mathcal A(W_0^6)=0$ on $I_6$, voiding the cap.** Step 2 fails: $\lVert W_0\rVert^6>0$. Withdrawn.
- **W5, orbit vanishing false.** Step 2 fails: the submodule argument of §7c is valid. Withdrawn.
- **W6, $F_5(W_0)\neq0$.** Step 2 fails in both natural normalisations (§5 screen). Withdrawn. The debt stands.
- **W7, order-$2$ vanishing imposes an extra condition.** Step 2 fails: no falsifier exists (§9 screen). Withdrawn. The debt stands.

## 14. The fixed list

1. **Hypothesis inventory.** See the table. Used but unstated: the Observation standing of $14$, $p$-integrality, identity of the sampled points with the certificate's points, $K\neq0$, $\dim D=36$.
2. **Quantifier order and scope.** The map is $\mu_K$ on the restricted space $D$, not L89's. The injectivity holds for a fixed point set over a fixed field, and the passage fixes neither (C11, S1). $F_5$ must lie in the restricted image, supplied by C4.
3. **Edges.** Degenerate sample: points on the ray-orbit of $W_0$ give rank $0$ (S1). Rank on the cap: invisible defects (C7d, S2). Mod a prime: split algebra at $1000033$ (W3), and unstated $p$-integrality.
4. **Proven versus stated.** Proven: C1, C4, C7a, C7c, C8 as algebra. Stated beyond that: the rank $13$ as a theorem, injectivity at unnamed points, $F_5(W_0)=0$, $\dim D=36$, the correctness of $Ta=0$, the order-$2$ remark.
5. **What to attack.**
   1. The measured rank is $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)$, which bounds $\mathrm{rank}\,\mu_K$ from below. Read alone line 163 is circular. With the cap it is not (W1, C2).
   2. A non-circular route to $\mathrm{rank}\,\mu_K=13$: cap $\le13$ from order $1$ (C8), and $\ge13$ from L62 if its scope is $\mu_K$, which the brief does not show. The unrestricted rank ($14$, L89) supplies only the ambient dimension. No route in the passages removes the measurement at the specific points (S1).
   3. "Four primes": two named. "Two audits stand behind it": they audit the SDP point. "Nowhere in the record": not checkable cold, no finding (C12).
   4. The restricted rank: the implication holds, the lower bound is a measurement, and attainment cannot certify the matrix (C3, S2). The display follows from the rank (C4).
   5. "Open in $[1,13]$" contradicts the headline rank $13$ as a standing (C10).
   6. Equivariance: conditional correct, guard is a test (C7a, C7b). Orbit: correct (C7c). Attainment: correct, and it undercuts the evidence for $Ta=0$ (C7d).
   7. Why $40$: injectivity on a $13$-dimensional image needs at least $13$ points. $40\ge36=\dim D$ lets the sampled rank exceed the cap, which is the only way the wrong restrictions were detected. The passage states no reason. Scope: C11.
   8. Passage D: both Lean files withheld. Nothing about what they state can be checked, and no machine-checked standing is credited.
6. **Falsifiers.** C1: nested kernels of equal finite dimension that differ, impossible. C2: a degenerate $40$-point set, exhibited (S1). C3: a non-factoring sampled matrix of rank $13$, admitted by line 177. C4: $\mathcal A(W_0^6)=0$, excluded (W4). C5: $F_5(W_0)\neq0$, screened (W6). C6: $\dim D\neq36$, not searchable cold. C7c: an element of a submodule vanishing at $W_0$ but not at $gW_0$, impossible. C8: an image element nonzero at $W_0$, impossible. C9: $f\in I_6$ with $f(W_0)=0\neq df(W_0)$, excluded (W7). C10, C11, C12: the quoted lines themselves.

## Overall verdict

**HYPOTHESIS-DEBT.** The kernel argument, the display, the cap and orbit vanishing are correct algebra. The lemma's load-bearing input, $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=13$ at the very $40$ points where $F_5$'s equations are imposed, rests on modular rank measurements at point sets the passage does not identify with the certificate's. The restricted rank $13$ is likewise measured unless L62 is shown to state it for $\mu_K$. Around this sit three statement-level gaps: incompatible standings for the rank (C10), an unscoped heading (C11), and attributions the passages do not support (C12).
