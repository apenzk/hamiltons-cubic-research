# Verifier v306, Lemma L90 (evaluation injective on the image of the restricted Gram-to-sextic map, the restricted rank 13, F_5 in the image)

The brief was cold. No numerical work was done, every value below is exact, and no scripts were written or run. Quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 128, 149, 163-181 and 260 only, and match the brief verbatim. Log: [agent_logs/verify-L90-v306.log](../agent_logs/verify-L90-v306.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | ker(ev∘μ) ⊇ ker μ, equal ranks force equal kernels, so ev is injective on im μ and the element of im μ agreeing with F_5 at the points is F_5 | CONFIRMED AS ALGEBRA |
| C2 | rank(ev∘μ) = 13 = rank μ, "measured at four primes" | HYPOTHESIS-DEBT |
| C3 | The injectivity holds at the certificate's 40 points (the points at which the equations are imposed) | HYPOTHESIS-DEBT |
| C4 | "Sampling and reduction only lose rank, so attaining the cap forces equality" | GAP |
| C5 | Cap 13 from order-1 vanishing at W_0 | CONFIRMED AS ALGEBRA |
| C6 | dim ANN = 1, ANN = R A(W_0^6), F_5 lies in the image | HYPOTHESIS-DEBT |
| C7 | Vanishing at W_0 suffices for vanishing on the orbit | CONFIRMED |
| C8 | The sampled row is μ*(ev_W) only under equivariant identification, guarded by the multi-probe Schur test | HYPOTHESIS-DEBT |
| C9 | On the restricted space the rank is open in [1,13] | CONFIRMED AS ALGEBRA |
| C10 | The affine family is 36 − 13 = 23 dimensional | HYPOTHESIS-DEBT |
| C11 | Attributions: "was nowhere in the record", "four primes", "two audits stand behind it", and the SDP-point figures of line 165 | HYPOTHESIS-DEBT |
| C12 | Order-2 vanishing adds a free condition, so the bound cannot be sharpened | HYPOTHESIS-DEBT |

**Summary:** the kernel argument is valid linear algebra, but both of its rank premises are measurements, the inference from a mod-p rank to the rational rank omits the hypothesis that the restricted domain is not rebuilt larger mod p, and nothing on file ties the measured sample points to the certificate's 40 points.

## 0. Conventions, fixed once

- $\mathcal W_5$: algebraic Weyl tensors on $\mathbb R^5$. $W_0$: the padded Weyl tensor of $\mathbb{CP}^2$, $W_0\neq0$. $F_5=\tfrac32\lVert W\rVert^6-9\mathop{\mathrm{tr}}(W^3)^2$, an $O(5)$-invariant sextic.
- $S_6:=(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, of dimension $14$ (Observation L85, carried by the given L89).
- $K\subseteq\mathrm{Sym}^3\mathcal W_5^*$: the cubics cut out by $Ta=0$ on the copy index of each isotypic block, each $V_\lambda$ kept whole (line 176).
- $\mu_{\mathrm{full}}$: multiplication $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)^{O(5)}\to S_6$, rank $14$ by L89. $\mu_K$: its restriction to $D:=\mathrm{Sym}^2(K)^{O(5)}$ (the invariant Grams over $K$). Where Passage A writes $\mu$ with rank $13$, it is read as $\mu_K$ (Section 2, withdrawn candidate W1).
- $\mathrm{ev}_P:S_6\to\mathbb F^{40}$: evaluation at a list $P$ of $40$ points over a field $\mathbb F$. $s_p$: the sampled rank reported mod $p$, the rank of the $40\times\dim D$ matrix whose rows are the sampled rows.
- $\mathrm{ANN}\subseteq S_6^*$: the annihilator of $\mathrm{im}\,\mu_K$. $\mathcal A$: the Reynolds average, so $\langle F,\mathcal A(W_0^6)\rangle$ is a nonzero constant times $F(W_0)$ for $F\in S_6$.
- A rank reported mod a prime is a measurement (brief, line 44).

## 1. Hypothesis inventory

| Hypothesis | Source | Used where | Stated? |
|---|---|---|---|
| $\dim S_6=14$ | L85 via given L89 | cap (C5), $\dim\mathrm{ANN}=14-13$ (C6) | Yes, with Observation standing |
| $K$ is an $O(5)$-submodule | line 176 | image of $\mu_K$ is invariant, orbit vanishing (C7) | Yes, argued |
| Grams are $O(5)$-invariant, so $\mathrm{im}\,\mu_K\subseteq S_6$ | implicit | C5, C6 | No, implicit in "Gram-to-sextic" |
| $F_5\in S_6$ and $F_5(W_0)=0$ | line 171 | C6 | Asserted "exact over $\mathbb Z$", no derivation on file |
| $\mathrm{ev}_{W_0}\neq0$ on $S_6$ | line 181 | cap is a hyperplane (C5) | Yes. Exact: $\lVert W\rVert^6\in S_6$ takes $\lVert W_0\rVert^6>0$ |
| rank $\mu_K=13$ | measurement, line 167 (and L62 heading) | C1, C6, C10 | Measured |
| rank$(\mathrm{ev}_P\circ\mu_K)=13$ at the certificate's points | line 163 | C1 applied to $F_5$ | Measured, and at which points is unstated |
| Sampled rows equal $\mu^*(\mathrm{ev}_W)$ (equivariant identification) | line 175 | lower bound in C4 | Stated, guarded by a numerical test |
| Restricted domain mod $p$ is the reduction of $D$ (no rank drop of $T$ mod $p$, no $p$ in denominators) | nowhere | C4 | **Used but unstated** |
| Certificate points are $p$-integral rational points reducing to the sampled points | nowhere | C3 | **Used but unstated** |
| $\dim D=36$ | nowhere in the passages | C10 | **Used but unstated** |
| $K\neq0$ | implicit | lower end $1$ of C9 | Implied by $\dim D=36$ |

## 2. C1, the load-bearing step

**Derivation.** Let $L:D\to S_6$ be linear and $E:S_6\to\mathbb F^{40}$ linear, all spaces finite-dimensional. If $L x=0$ then $ELx=0$, so $\ker L\subseteq\ker(E L)$. Rank-nullity on the common domain $D$ gives $\dim\ker(EL)=\dim D-\mathrm{rank}(EL)$ and $\dim\ker L=\dim D-\mathrm{rank}\,L$. If the ranks are equal the nullities are equal, and a subspace of equal finite dimension is the whole space, so $\ker(EL)=\ker L$. Now take $y=Lx\in\mathrm{im}\,L$ with $Ey=0$. Then $x\in\ker(EL)=\ker L$, so $y=0$. Hence $E$ is injective on $\mathrm{im}\,L$. If $F_5\in\mathrm{im}\,L$ and $y\in\mathrm{im}\,L$ satisfies $Ey=EF_5$, then $y-F_5\in\mathrm{im}\,L$ and $E(y-F_5)=0$, so $y=F_5$. Rank over $\mathbb Q$ of a rational matrix equals its rank over $\mathbb R$, so the conclusion transfers to real Grams once it holds over $\mathbb Q$.

Every link is correct. **CONFIRMED AS ALGEBRA**, conditional on the premises of C2, C3 and C6.

**Circularity (attack item 1).** Both ranks come from one reported number $s_p=13$. The chain, where valid, is $s_p\le\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K\le13=s_p$, which forces both equalities at once. That is a sandwich, not a circle: the upper end is the analytic cap (C5) and the lower end is the measurement. Its lower inequalities are exactly what C3 and C4 examine. Sampling bounds rank from below only: the sampled rank is a lower bound for rank $\mu_K$, never an upper bound.

### Withdrawn candidate W1: "rank μ = 13" contradicts L89

1. Location: line 163, "Writing $\mu$ for the Gram-to-sextic map ... $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$". The given L89 (line 128) names multiplication $\mu$ and gives rank $14$ on invariants.
2. Failure: with $\mu=\mu_{\mathrm{full}}$ on invariants, rank is $14\neq13$ by the given. On the full non-invariant space the rank is $\dim\mathrm{Sym}^6\mathcal W_5^*$, larger still.
3. Charitable reading: the paragraph concerns the certificate over $K$ and the next paragraph names "the restricted sampled rank" with cap $13$, so $\mu=\mu_K$, where the equation is the claim under C2. **Withdrawn**: the charitable reading is consistent. The statement should name its domain, since the file uses $\mu$ for both maps.

## 3. C2, the two rank premises

**Location.** Line 163: "$\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ is measured at four primes". Line 167: "$13$ at $40$ points mod $1000033$, and reviewer 209 reproduced it independently at $p=1000003$".

Both values are measurements by the passage's own word. The only analytic content is the cap $\mathrm{rank}\,\mu_K\le13$ (C5). No argument on file gives $\mathrm{rank}\,\mu_K\ge13$, and line 179 says so ("the rank is open in $[1,13]$"). **HYPOTHESIS-DEBT.** What would have to be proved: an exact exhibit of $13$ elements of $D$ whose sextics are linearly independent in $S_6$ (for instance $13$ Grams and $13$ invariant sextic functionals with a nonsingular $13\times13$ pairing matrix, written in closed form), or an argument that $\mathrm{im}\,\mu_K$ is the whole hyperplane $\{F\in S_6:F(W_0)=0\}$.

**Non-circular route in the passages (attack item 2).**

- Passage C (L62) is a heading only, "$\dim\mathrm{ann}=1$, so the rank is $13$". Taken as stated it would supply rank $\mu_K=13$ if its "ann" is ANN of $\mu_K$. The heading names no map or space, so its scope cannot be matched to $\mu_K$ from the passages. It also sits against line 179's "open in $[1,13]$" (withdrawn candidate W4). Even granted, L62 supplies only $\mathrm{rank}\,\mu_K$ and says nothing about $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)$ at particular points.
- The unrestricted rank (L89, $14$) offers a route to injectivity: $\mathrm{ev}_P$ injective on all of $S_6$ implies injective on the subspace $\mathrm{im}\,\mu_K$. That needs $\mathrm{rank}\,\mathrm{ev}_P|_{S_6}=14$ at the certificate's points, again a statement about specific points with no argument on file.
- No route in the passages makes injectivity at a specific point set analytic. That property depends on the points, so it can only be proved from the points in closed form.

## 4. C3, which points

**Location.** Line 163: "a sextic there is pinned by those $40$ values", where "those" are the points at which "the map's equations" are satisfied. Line 167: "$13$ at $40$ points mod $1000033$", and reviewer 209 used "its own points".

**Derivation of what is needed.** Let $P$ be the certificate's points and $\bar Q$ the points of a mod-$p$ measurement. The lower bound $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}_P\circ\mu_K)\ge\mathrm{rank}_{\mathbb F_p}(\mathrm{ev}_{\bar Q}\circ\bar\mu_K)$ holds when $P$ is $p$-integral and $\bar Q=\bar P$, since the $\mathbb F_p$ matrix is then the reduction of the rational one and a nonzero minor mod $p$ lifts to a nonzero rational minor. When $\bar Q$ is not the reduction of $P$ the measurement bounds $\mathrm{rank}\,\mu_K$ but says nothing about $\mathrm{ev}_P$.

**Three-step record.**

1. Location as above.
2. Failure, concretely: reviewer 209's points are "its own", so that reproduction cannot bear on $\mathrm{ev}_P$ for the certificate's $P$. For the $1000033$ run the passages do not state that its points are reductions of $P$. A closed-form instance of the gap: take a $13$-dimensional space of functions and $40$ points all lying in the common zero set (here, the $O(5)$-orbit of $W_0$, on which every element of $\mathrm{im}\,\mu_K$ vanishes by C5 and C7). Then $\mathrm{ev}_P\circ\mu_K=0$ while $\mathrm{rank}\,\mu_K$ is unchanged, so rank $\mu_K=13$ alone never yields injectivity at a given $P$.
3. Charitable reading: the $1000033$ run used exactly the reductions of the certificate's rational points. Nothing in the passages says so, and the certificate's points are not shown to be rational.

**Survives. HYPOTHESIS-DEBT**: the certificate's $40$ points must be shown to be $p$-integral rationals whose reductions are the sampled points, or $\mathrm{rank}_{\mathbb Q}(\mathrm{ev}_P\circ\mu_K)=13$ must be established at those points directly.

## 5. C4, "sampling and reduction only lose rank"

**Location.** Line 167: "reviewer 209 reproduced it ... with its own code, its own points, and $T$ rebuilt from three different positions. Sampling and reduction only lose rank, so attaining the cap forces equality."

**Derivation of what the sentence needs.** Sampling: $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K$, true over any field. Reduction: for a fixed $p$-integral matrix $M$, $\mathrm{rank}_{\mathbb F_p}\bar M\le\mathrm{rank}_{\mathbb Q}M$, true. But the matrix reduced here is $\mu$ composed with an inclusion of the restricted domain, and the domain is cut out by $Ta=0$. If $T$ is rebuilt mod $p$ and the domain taken as $\ker\bar T$, then $\dim\ker\bar T\ge\dim\ker T$ with strict inequality exactly when $\mathrm{rank}_{\mathbb F_p}\bar T<\mathrm{rank}_{\mathbb Q}T$. On a larger domain the mod-$p$ rank can exceed the reduction of the rational rank, and the cap argument (products of cubics in $\ker\bar T$ vanish at $\bar W_0$) caps the mod-$p$ rank at $13$ as well, so reaching $13$ mod $p$ is compatible with a rational rank below $13$.

**Three-step record.**

1. Location as above.
2. Failure, exact closed form of the inference pattern. Ambient space $\mathbb Q^1$, $T=(p)$, restricted domain $\ker T=0$ over $\mathbb Q$, map $\mathrm{id}:\mathbb Q^1\to\mathbb Q^1$ with cap $1$. Rational restricted rank $0$. Mod $p$: $\bar T=(0)$, $\ker\bar T=\mathbb F_p^1$, restricted rank $1$, which attains the cap. "Reduction only loses rank, so attaining the cap forces equality" would conclude rational rank $1$, which is false. The same happens if a basis vector of $\ker T$ has a denominator divisible by $p$ and is rescaled mod $p$ without saturation.
3. Charitable reading: the restricted basis was computed over $\mathbb Q$ (or $\mathbb Z[i]$) as a saturated lattice basis and then reduced, in which case $L/pL\hookrightarrow\mathbb F_p^n$ keeps the domain the reduction of $D$ and the bound holds. The passage says the opposite for reviewer 209 ("$T$ rebuilt"), and for the $1000033$ run it is silent. No check that $\mathrm{rank}_{\mathbb F_p}\bar T=\mathrm{rank}_{\mathbb Q}T$ is on file.

**Survives. GAP**: the stated principle holds only under the unstated hypothesis that the restricted domain mod $p$ is the reduction of $D$ (equivalently here, $T$ keeps its rank mod $p$ and no basis denominator is divisible by $p$). The claim rank $\mu_K=13$ is not shown false, and the gap is in the inference.

### Withdrawn candidate W2: the split algebra at $p=1000033$

1. Location: line 167, the parenthesis "$p=1000003$ (which is $3\bmod4$, so $\mathbb F_p[i]$ is a field rather than a split algebra)". By contrast $1000033=4\cdot250008+1\equiv1\bmod4$, so there $\mathbb F_p[i]\cong\mathbb F_p\times\mathbb F_p$ has zero divisors, e.g. $1+ci$ with $c^2\equiv-1$, since $(1+ci)(1-ci)=1+c^2\equiv0$.
2. Failure: a pivot count over a ring with zero divisors is not a field rank, so the $1000033$ figure would have no guaranteed relation to the rank over $\mathbb Q(i)$. I cannot exhibit a wrong count, because the elimination method is not on file.
3. Charitable reading: a rank taken after either projection $\mathbb Z[i]\to\mathbb F_p$, $i\mapsto\pm c$, is a genuine field rank and a valid lower bound. The $1000003$ run lies over the field $\mathbb F_{p^2}$ in any case. **Withdrawn**: step 2 cannot be completed from the passages.

## 6. C5, the cap 13

**Derivation.** For $k_1,k_2\in K$, $k_1(W_0)=k_2(W_0)=0$ (C7), so $(k_1k_2)(W_0)=0$. An invariant Gram $G\in D$ maps to $\sum G_{ij}k_ik_j$, which is invariant and vanishes at $W_0$. So $\mathrm{im}\,\mu_K\subseteq H:=\{F\in S_6:F(W_0)=0\}$. $\mathrm{ev}_{W_0}$ is nonzero on $S_6$ because $\lVert W\rVert^6\in S_6$ takes the value $\lVert W_0\rVert^6>0$. Hence $\dim H=14-1=13$ and $\mathrm{rank}\,\mu_K\le13$. **CONFIRMED AS ALGEBRA**, with $14$ carrying L85's standing through the given L89 and with invariance of the Grams taken as implicit.

**Edge (fixed item 3).** A defect that lands the measured rank exactly on $13$ is invisible to this cap, as line 177 itself says. The cap detects only overshoot.

## 7. C6, ANN and F_5 in the image

**Derivation.** $\mathcal A(W_0^6)$ annihilates $\mathrm{im}\,\mu_K$ because it pairs with an invariant sextic as a nonzero multiple of evaluation at $W_0$, and every image element vanishes there (C5). It is nonzero on $S_6$ (pair with $\lVert W\rVert^6$). If $\mathrm{rank}\,\mu_K=13$ then $\dim\mathrm{ANN}=14-13=1$ and $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$. In finite dimension $\mathrm{im}\,\mu_K=\mathrm{ANN}^\perp$ within $S_6$. $F_5\in S_6$, and $F_5\in\mathrm{ANN}^\perp$ iff $F_5(W_0)=0$. So "rank $13$ and $F_5(W_0)=0$ imply $F_5\in\mathrm{im}\,\mu_K$" is correct algebra.

The premises are open on the passages. $\mathrm{rank}\,\mu_K=13$ is C2's measurement. $F_5(W_0)=0$ is asserted "exact over $\mathbb Z$ in both normalisations" with no derivation, and neither normalisation of $\lVert W\rVert$ or $\mathop{\mathrm{tr}}(W^3)$ is defined in the brief, so the value cannot be checked from what is quoted. **HYPOTHESIS-DEBT**: what would have to be proved is $\mathrm{rank}\,\mu_K=13$ (as in C2) and the closed-form evaluation $\tfrac32\lVert W_0\rVert^6=9\mathop{\mathrm{tr}}(W_0^3)^2$ in a fixed stated normalisation.

**Direction check.** $F_5(W_0)=0$ is necessary for $F_5\in\mathrm{im}\,\mu_K$ unconditionally (C5). That necessary condition is the "theorem" of line 167's heading, and it is confirmed. Sufficiency needs rank $13$.

## 8. C7, vanishing on the orbit

**Derivation.** $K=\bigoplus_\lambda V_\lambda\otimes\ker T_\lambda$ with $V_\lambda$ whole is $O(5)$-stable. An element is $f(W)=\langle v,\sum_ca_c\sigma_{\lambda,c}(W)\rangle$ with $Ta=0$, so $f(W_0)=\langle v,Ta\rangle=0$. For $g\in O(5)$, $f(gW_0)=(g^{-1}\!\cdot f)(W_0)$ with $g^{-1}\!\cdot f\in K$, hence $0$. **CONFIRMED.** The contrast "restricting positions instead would break it" is correct: the set of all cubics vanishing at $W_0$ is not $O(5)$-stable in general, and the orbit argument uses stability.

## 9. C8, equivariance of the sampled row

**Location.** Line 175. The inequality $s_p\le\mathrm{rank}\,\mu_K$ holds only if the sampled matrix is $\mathrm{ev}\circ\mu_K$, which requires the copies of each $V_\lambda$ to be identified equivariantly. The passage states the hypothesis and names "the multi-probe Schur test" as its guard. That test is a computation, and no argument is on file that passing it certifies equivariant identification. The $S_3$ example (sampled rank $10$ against cap $7$) is not given in closed form in the passage and cannot be checked from it. It is only illustrative of necessity and does not bear on the proof. **HYPOTHESIS-DEBT**: an exact argument that the identification of copies used in the sampled rows is $O(5)$-equivariant.

## 10. C9, "open in [1,13]"

The upper end is C5. The lower end: any nonzero $k$ in an irreducible $V_\lambda\subseteq K$ with orthonormal basis $k_1,\dots,k_d$ gives the invariant Gram $\sum k_i^2$, a nonzero sextic, so rank $\ge1$ provided $K\neq0$ ($\dim D=36$ implies it). No argument on file closes the interval. **CONFIRMED AS ALGEBRA** as a statement of analytic standing.

### Withdrawn candidate W3: lines 167 and 179 contradict

1. Location: line 167 "THE RESTRICTED RANK IS $13$" and line 179 "On the restricted space the argument does not carry, and the rank is open in $[1,13]$".
2. Failure: both are about $\mathrm{rank}\,\mu_K$, one fixed, one open.
3. Charitable reading: line 179 speaks of what argument establishes (L89's surjectivity does not carry to $K$), and line 167 reports a measurement. "A THEOREM" in line 167 attaches to "the necessary condition", which C7 and C6's direction check confirm. **Withdrawn**: the readings reconcile as analytic status versus measured value, which is exactly the HYPOTHESIS-DEBT of C2.

### Withdrawn candidate W4: L62's heading against line 179

1. Location: line 260 "$\dim\mathrm{ann}=1$, so the rank is $13$" and line 179 "the rank is open in $[1,13]$".
2. Failure: a given Lemma fixing the rank at $13$ contradicts an open interval for the same rank.
3. Charitable reading: the heading names neither the map nor the space, and "ann" in lower case need not be ANN of $\mu_K$. **Withdrawn**: the scope cannot be matched from the passages, so no contradiction can be established.

## 11. C10, the affine family

$\{G\in D:\mu_K(G)=F_5\}$ is empty or an affine space of dimension $\dim D-\mathrm{rank}\,\mu_K$. Nonemptiness is C6. $\dim D=36$ has no derivation in the passages, and rank $13$ is C2. The "confirmed by exact arithmetic" of reviewer 208's figures is a computation. **HYPOTHESIS-DEBT**: $\dim\mathrm{Sym}^2(K)^{O(5)}=36$ and C2.

## 12. C11, attributions (attack item 3)

- **"Was nowhere in the record."** A claim about the record's history, which this verifier is barred from reading. Not checkable and not bearing on correctness. No finding.
- **"Measured at four primes."** The passages name two primes, $1000033$ and $1000003$. Three-step record: (1) line 163 against line 167. (2) Two primes named, four claimed. (3) Charitable reading: the other two are recorded in files outside the brief. Withdrawn as a refutation. The four measurements are not on file here, and all are measurements. HYPOTHESIS-DEBT.
- **"Two audits stand behind it."** Line 165 describes reviewers 211 and 212 finding a block-ordering error in an SDP point (minimum eigenvalue $-1440$) and an LDL test passing a point with third leading minor $-3.47\times10^{-4}$. Both concern positive semidefiniteness of a certificate point, not the injectivity step. Three-step record: (1) line 165, "it" following the load-bearing paragraph. (2) Neither audit mentions $\ker(\mathrm{ev}\circ\mu)$, ranks, or the points. (3) Charitable reading: "it" is the certificate as a whole. Withdrawn as a misattribution, with the consequence that no audit of the injectivity step is on file in the passages.
- **The line 165 figures** ($t=2.34\times10^{-2}$ "strictly positive and interior", the eigenvalue and the minor) are numerical, lie outside L90's heading, and are HYPOTHESIS-DEBT. One exact remark: a negative leading principal minor does exclude positive semidefiniteness, so an acceptance test passing such a point is defective, consistent with the passage.

## 13. C12, order-2 vanishing

Line 181 asserts that demanding order-2 vanishing at $W_0$ adds no condition on $S_6$, "the extra condition being free". The passages give no argument that every $F\in S_6$ with $F(W_0)=0$ has $dF(W_0)=0$. **HYPOTHESIS-DEBT**, not load-bearing for L90.

## 14. Standing list

**1. Hypothesis inventory.** Section 1. Three hypotheses are used but unstated: the restricted domain mod $p$ is the reduction of $D$ (C4), the certificate's points reduce to the sampled points (C3), and $\dim D=36$ (C10). Invariance of the Grams is implicit.

**2. Quantifier order and scope.**

- Map: $\mu_K$, the restriction to invariant Grams over $K$. The statement writes $\mu$, which the same file uses for $\mu_{\mathrm{full}}$ (W1).
- Space: $\mathrm{im}\,\mu_K\subseteq H\subset S_6$. Injectivity is claimed on $\mathrm{im}\,\mu_K$ only, which is all the uniqueness argument needs.
- Points: the certificate's $40$ points for the application, the sampled points for the measurement, not shown equal (C3).
- Field: measured over $\mathbb F_p$ and $\mathbb F_p[i]$, applied over $\mathbb R$. The transfer $\mathbb F_p\to\mathbb Q$ needs C3 and C4, and $\mathbb Q\to\mathbb R$ is automatic.

**3. Edges of every range.**

- Degenerate sample: points on the orbit of $W_0$ give zero rows (C3, step 2). Coincident points repeat rows.
- Rank on the cap: invisible to the cap (C5). The passage says so.
- Reduction mod a prime: a kernel rebuilt mod $p$ can grow (C4). The split algebra at $1000033\equiv1\bmod4$ (W2). A basis denominator divisible by $p$ (C4).

**4. Proven versus stated.** Proven: the kernel lemma (C1), the cap (C5), orbit vanishing (C7), the necessity of $F_5(W_0)=0$, and the implication "rank $13$ and $F_5(W_0)=0$ give $F_5\in\mathrm{im}\,\mu_K$". Stated beyond proof: rank $\mu_K=13$, injectivity at the certificate's specific points, $F_5(W_0)=0$ itself, $\dim D=36$, and the validity of the mod-$p$ lower bound as run.

**5. The brief's attack items.**

1. The measured rank is the sampled rank, a lower bound for both $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ and $\mathrm{rank}\,\mu_K$. Sampling bounds from below only. The step is a sandwich with the cap, not a circle, but its lower inequalities carry the gaps of C3 and C4 (Sections 2, 4, 5).
2. No non-circular analytic route in the passages. L62 is a heading of unstated scope, and the unrestricted route still needs a rank at specific points (Section 3).
3. "Nowhere in the record" is not checkable here. Two primes named against four claimed. The two audits concern the SDP point (Section 12).
4. The restricted rank is a measurement whose inference omits a hypothesis (C4). The display's $\dim\mathrm{ANN}=1$ and $F_5$ in the image follow from rank $13$ and $F_5(W_0)=0$, both open on the passages (C6).
5. Line 179's interval is the correct analytic standing, and item 4's $13$ is the measured value (W3, C9).
6. Equivariance: HYPOTHESIS-DEBT (C8). Orbit vanishing: CONFIRMED (C7). Attainment not self-validating: correct, and C4 adds a second invisible defect, a domain enlarged mod $p$ that still respects the cap.
7. Why $40$: no reason on file. Injectivity on a $13$-dimensional image needs at least $13$ points, and $40\ge13$. The count itself decides nothing, the position of the points decides everything (C3).
8. Passage D is withheld. Nothing a Lean file states can be credited to L90 by this verifier.

**6. Falsifiers and the search.**

| Claim | Falsifying object | What I did |
|---|---|---|
| C1 | Linear maps with equal ranks and $\ker L\subsetneq\ker EL$ | Ruled out by rank-nullity (Section 2) |
| C2 | A proof that $\mathrm{im}\,\mu_K$ has dimension $\le12$, e.g. a second invariant functional annihilating it | None exhibitable without a basis of $D$. None on file |
| C3 | A $40$-point set with $\mathrm{rank}(\mathrm{ev}_P\circ\mu_K)<13$ | Exhibited in closed form: points on the orbit of $W_0$ |
| C4 | A restricted domain that grows mod $p$ with the cap attained | Exhibited in closed form: $T=(p)$ |
| C5 | An image element not vanishing at $W_0$, or $S_6$ with $\mathrm{ev}_{W_0}=0$ | Ruled out: products vanish, $\lVert W_0\rVert^6>0$ |
| C6 | $F_5(W_0)\neq0$ in the stated normalisation | Normalisation not defined in the brief. Not decidable from it |
| C7 | $f\in K$ with $f(gW_0)\neq0$ | Ruled out by stability of $K$ |
| C8 | A non-equivariant identification passing the Schur test | Test not on file. Not searchable analytically |
| C10 | $\dim D\neq36$ | No basis on file. Not decidable |

## Overall verdict

**HYPOTHESIS-DEBT.** The injectivity lemma is correct as linear algebra, and the cap and orbit arguments hold. Its two rank premises are measurements, the mod-$p$ inference carries a GAP (the restricted domain must not be rebuilt larger mod $p$), and nothing on file ties the measured sample points to the certificate's $40$ points.
