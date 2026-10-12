# Verify v93, Lemma L0: the biconditional $M(n)=\Theta_n\Leftrightarrow P\le\Theta_n$ at every critical point, its three scope conditions, and the witness the block asserts

*Verifier v93, cold brief, [findings/problem.md](../findings/problem.md):470–500 (the block headed "Lemma L0), problem p and conjecture a are the same statement", read against [results.md](../results.md), [lean/INDEX.md](../lean/INDEX.md), [lean/HamiltonsCubic/Results/L0.lean](../lean/HamiltonsCubic/Results/L0.lean), [findings/conventions.md](../findings/conventions.md) and the source extraction [references/nienhaus-2023-second-best-einstein/](https://arxiv.org/abs/2311.02404). **No numerical work was done. No script was run.** Every value below is an exact hand evaluation of a rational number, and every source quoted was opened and read at the line given. Log: [agent_logs/verify-L00b-v93.log](../agent_logs/verify-L00b-v93.log).*

## Verdicts

| # | Claim, as a consumer would cite it | Verdict |
|---|---|---|
| C1 | The displayed biconditional at [problem.md](../findings/problem.md):482, with $\Theta_n$ at both parities | **TRUE AS STATED, NOT PROVEN BY THE BLOCK** |
| C2 | ($\Rightarrow$) $\sup=\Theta_n\Rightarrow P\le\Theta_n$ at every critical point | **PROVEN** |
| C3 | ($\Leftarrow$) $P\le\Theta_n$ at every critical point $\Rightarrow\sup=\Theta_n$ | **GAP, the block proves only $\sup\le\Theta_n$, and says so** |
| C4 | The missing half, $\sup\ge\Theta_n$ | **AVAILABLE BY ONE CITATION, NEVER CITED IN THE BLOCK**, Nienhaus Proposition 2.25, read at extraction L1483 |
| C5 | The constant repair, $\Theta_n$ and not $\theta_0(n)$, and the margin-$4$ identity | **CONFIRMED, every value re-derived by hand** |
| C6 | Scope condition 1, value not maximiser | **CONFIRMED AGAINST THE SOURCE; one clause overstates** |
| C7 | Scope condition 2, the $n\ge12$ clause alone | **CONFIRMED AGAINST THE SOURCE, with its witness value re-derived** |
| C8 | Scope condition 3, "products of spheres" is the balanced split | **CONFIRMED, and it is Nienhaus Proposition 2.25 in disguise, uncited** |
| C9 | "each side is then the $n\ge12$ clause of Conjecture A **at both parities**" | **TRUE ONLY WITH C4; the load-bearing citation is absent** |
| C10 | The Lagrange condition $Q(W)=\theta W$ with $\theta=P(W)$ | **TRUE, ON TWO IMPORTED FACTS THE BLOCK DOES NOT NAME** |
| C11 | *"Both directions checked in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) and [L16.lean](../lean/HamiltonsCubic/Results/L16.lean)"* ([problem.md](../findings/problem.md):477) | **AMBIGUOUS, AND FALSE UNDER THE READING A CONSUMER TAKES** |
| C12 | [results.md](../results.md):11, *"**Proven at both parities** (Lemma L0)"* | **THE NAMED TRAP, the correction landed 764 lines away, and the file contradicts itself** |
| C13 | [results.md](../results.md):46, Conjecture A and Problem P are one statement via $\theta_0(n)$ | **THE REPAIR DID NOT REACH IT, false at odd $n$ by L0's own numbers** |
| C14 | Odd $n$, the smallest admissible dimension, reducible and non-compact cases, $\ker W\ne0$ | **NO FINDING, see §5, each answered against a named object** |

**Verdict: `GAP`.**

**One line.** The biconditional is true, its ($\Rightarrow$) half is proven, its ($\Leftarrow$) half is proven only to $\sup\le\Theta_n$ (which the block states in bold and then closes with $\square$ anyway) and the one fact that would finish it is unconditional published mathematics sitting in [references/](../references/), read, and named nowhere in the block; meanwhile two consumer-facing restatements of the same lemma, at [results.md](../results.md):11 and [results.md](../results.md):46, still carry the defects the block repaired.

---

## 0. Conventions, fixed once

| symbol | meaning, and where it is fixed |
|---|---|
| $\mathcal W_n$ | the real vector space of algebraic Weyl curvature operators in dimension $n$; Nienhaus writes $\mathrm{Weyl}_n$, and $\mathrm{Weyl}^1_n=\{W\mid\lVert W\rVert=1\}$ |
| $\langle\cdot,\cdot\rangle$ | $\langle R,S\rangle=\operatorname{tr}(R\circ S)$, so $\lVert I\rVert^2=\binom n2$, [problem.md](../findings/problem.md), "the real convention hazard" |
| $Q$ | $Q(R)=R^2+R^\#$, the Böhm–Wilking ODE right-hand side; $\Phi$ is its polarisation |
| $P$ | $P(R)=\langle R^2+R^\#,R\rangle$, a homogeneous cubic, verbatim the source's definition, extraction L212 |
| $\theta_0(n)$ | the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more**, [conventions.md](../findings/conventions.md):18 |
| $\Theta_n$ | the diagonal maximum; $=\theta_0(n)$ at even $n$, $=\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, [conventions.md](../findings/conventions.md):19 |
| $M(n)$ | the global maximum $\max\{P(A):\lVert A\rVert=1\}$, with $\Theta_n\le M(n)$, [conventions.md](../findings/conventions.md):21 |
| $\theta_{k,l}$ | Nienhaus Proposition 2.25's value at the sphere product $S_{k,l}$, $k+l=n$ |

The block's left-hand side, $\sup\{P(W):W\in\mathcal W_n,\ \lVert W\rVert=1\}$, is exactly $M(n)$ under [conventions.md](../findings/conventions.md):21. The block never writes $M(n)$, but it does not write $\Theta_n$ where $M(n)$ was meant either, so **trap W5 is not triggered here**; the block's assertion $M(n)=\Theta_n$ is the conjecture's content rather than a substitution.

---

## 1. The hypothesis inventory

### 1.1 Hypotheses the block carries

| id | hypothesis | stated? | used by the written proof? | checked against |
|---|---|---|---|---|
| H1 | $n\ge12$ | **yes**, "Fix $n\ge12$" | **no**, see §5.2 | Conjecture A's disjunctive hypothesis, extraction L212 |
| H2 | $\mathcal W_n$ is finite-dimensional | **yes** | yes, for compactness | $\mathcal W_n\subseteq S^2(\Lambda^2\mathbb R^n)$; $\dim\mathcal W_{12}=1638$ is a Lemma on the record |
| H3 | $\lVert\cdot\rVert$ comes from an inner product | **no** | yes, the Lagrange step needs $\{\lVert W\rVert=1\}$ *smooth*, which finite-dimensionality alone does not give | $\langle R,S\rangle=\operatorname{tr}(R\circ S)$, §0 |
| H4 | $P$ is smooth on $\mathcal W_n$ | **yes**, "the polynomial $P$" | yes | $P$ is a homogeneous cubic |
| H5 | $\mathcal W_n\ne0$, so the sphere is nonempty | **no** | yes, the extreme value theorem is vacuous otherwise | true at every $n\ge4$ |
| H6 | $\Theta_n$ is **attained** by some unit $W\in\mathcal W_n$ | **no**, asserted in the closing pull-quote, uncited | **not used by the proof, and it is the half the proof is missing** | Nienhaus Prop 2.25, §3.2 |
| H7 | $\Theta_n=P(W^{\mathrm{crit}}_{\mathrm{sym}})$ | **no** | not by the proof; used by the sentence "each side is then the $n\ge12$ clause of Conjecture A" | Nienhaus's definition of $\mathcal S_{\mathrm{crit},n}$ at L1440–1460 with Prop 2.25 |

### 1.2 Results the block imports, and their own hypotheses

| id | imported result | its hypotheses | discharged at the object? | named in the block? |
|---|---|---|---|---|
| I1 | Extreme value theorem | compact, nonempty domain; continuous function | yes, H2, H4, H5 | in substance ("attains its maximum") |
| I2 | First-order condition at a constrained maximum | constraint surface smooth; $1$ a regular value of $\lVert\cdot\rVert^2$ | yes, H3, and $d(\lVert W\rVert^2)_W=2\langle W,\cdot\rangle\ne0$ off the origin | in substance |
| I3 | $\nabla P|_W=3\,Q(W)$ | full symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ | yes, **BW08 eq. (5)**, recorded as a theorem in [problem.md](../findings/problem.md) some 400 lines above the block | **no** |
| I4 | $Q(\mathcal W_n)\subseteq\mathcal W_n$ | $\Phi$ preserves the first Bianchi identity; $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$ | yes, **BW08 eq. (6)** plus the standard Hamilton fact, both recorded in [problem.md](../findings/problem.md) above the block | **no** |
| I5 | Nienhaus **Proposition 2.25**, $W^2_{S_{k,l}}+W^\#_{S_{k,l}}=\theta_{k,l}W_{S_{k,l}}$ and $P(W_{S_{k,l}})=\theta_{k,l}$ at unit norm | $k+l=n$; the normalisation $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$ set at L1440–1450 | yes | **no**, this is the block's witness *and* its scope-condition-3 formula |
| I6 | Nienhaus **Conjecture A** as published, extraction L212 | the criticality hypothesis; the disjunctive dimension clause | yes, scope condition 2 reads it correctly | as "Conjecture A", without the line reference |
| I7 | $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ | none beyond $n\ge4$ (padded) | yes, used in scope condition 2's figure | **no** |

**Which the written argument uses.** The proof itself runs on H2, H3, H4, H5, I1, I2, I3, I4, and on nothing else. H1 is carried and never spent. H6, H7, I5, I6, I7 are spent by the *statement* and the *scope conditions*, never by the proof.

**The one hypothesis the statement omits and the argument needs is H6.** That is the whole of §3.

---

## 2. Question 1, is the biconditional a biconditional?

### 2.1 The two directions, separately

**($\Rightarrow$).** The block: *"If the supremum is $\Theta_n$ then $P\le\Theta_n$ everywhere, critical points included."* Correct, and it consumes nothing at all, not H1, not H2, not compactness, not smoothness, not the definition of criticality. It is the definition of a supremum plus the inclusion (critical points) $\subseteq$ (the unit sphere). **PROVEN, and the block's hypothesis list is a superset of what it needs.**

**($\Leftarrow$).** The block: *"If $P\le\Theta_n$ at every critical point then $P(W_{\max})\le\Theta_n$, and $P(W_{\max})$ is the supremum, **so this direction gives $\sup\le\Theta_n$ and not the equality.** $\square$"*

Written out, the chain is: $\mathcal W_n$ finite-dimensional $\Rightarrow$ $\{\lVert W\rVert=1\}$ compact (H2, H5) $\Rightarrow$ $P$ attains a maximum at $W_{\max}$ (I1, H4) $\Rightarrow$ $W_{\max}$ is critical for $P|_{\lVert W\rVert=1}$ (I2, H3) $\Rightarrow$ $P(W_{\max})\le\Theta_n$ by hypothesis $\Rightarrow$ $\sup=P(W_{\max})\le\Theta_n$. Every step is sound. **What it delivers is $\sup\le\Theta_n$.**

**So one direction is an implication wearing an equivalence's clothes, and it is ($\Leftarrow$).** The gap is exactly $\sup\ge\Theta_n$, i.e. hypothesis H6.

### 2.2 The block's own honesty, and where it sits

The block does not conceal this. The words *"so this direction gives $\sup\le\Theta_n$ and not the equality"* are in bold, inside the proof, attached to the very step that falls short, this is a correction landing **on** its statement, not beside it, and it is the correct placement. The pull-quote below the proof then names the missing object: *"$\sup\ge\Theta_n$ needs a witness: the balanced product itself, admissible in $\mathcal W_n$ and carrying $\theta=\Theta_n$."*

**What is nonetheless wrong is the $\square$.** The proof closes with a proof-terminator on a statement strictly weaker than the display two paragraphs above it, and the display at [problem.md](../findings/problem.md):482 carries no marker of its own. A consumer who copies the displayed equivalence and its "Fix $n\ge12$" preamble (which is what a display is for), takes an unproven biconditional.

---

## 3. Candidate D1, the witness, and what closes it

### 3.1 Three-step record

**Locate.** [problem.md](../findings/problem.md):490, closing the proof: *"**($\Leftarrow$)** If $P\le\Theta_n$ at every critical point then $P(W_{\max})\le\Theta_n$, and $P(W_{\max})$ is the supremum, **so this direction gives $\sup\le\Theta_n$ and not the equality.** $\square$"* And [problem.md](../findings/problem.md):492: *"carrying $\theta=\Theta_n$ by the $\theta_{k,l}$ formula below."*

**Exhibit the failure concretely.** Take $n=13$. Suppose, counterfactually, that no unit Weyl operator in $\mathcal W_{13}$ attained $\Theta_{13}$. Then the right-hand side "$P\le\Theta_{13}$ at every critical point" could hold while $\sup<\Theta_{13}$, so the left-hand side "$\sup=\Theta_{13}$" would be false, and the biconditional would fail at $n=13$. Nothing in the block's proof excludes this counterfactual, the proof produces only an upper bound. So the block's proof does not entail the block's statement at any $n$, and $n=13$ is a concrete instance.

**Argue the opposite, the most charitable reading the words support.** The block *states* the deficiency in bold and *names* the missing object in the very next paragraph. Read as a whole, the block is a correct proof of ($\Rightarrow$) together with a correct proof of ($\Leftarrow$, $\le$) and a flagged, correctly-located debt for ($\Leftarrow$, $\ge$). That is a materially different document from one that hides the gap. **The candidate survives as a `GAP` and is downgraded from `BROKEN`: nothing asserted is false, and the deficiency is declared.**

### 3.2 What actually closes it, read at the source

[references/nienhaus-2023-second-best-einstein/](https://arxiv.org/abs/2311.02404), extraction L1483, read directly:

> **Proposition 2.25.** The Weyl curvature of $S_{k,l}$ satisfies $W^2_{S_{k,l}}+W^\#_{S_{k,l}}=\theta_{k,l}\cdot W_{S_{k,l}}$, where $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$. Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$.

Its unit normalisation is fixed at L1440–1450, read: $\widetilde W_{S_{k,l}}=R_{S_{k,l}}-\frac{k-1}{n-1}\mathrm{Id}_{\mathfrak{so}(n)}$, then $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$. So $W_{S_{k,l}}\in\mathcal W_n$ with $\lVert W_{S_{k,l}}\rVert=1$, it is **critical** (the displayed equation is the Lagrange condition of §4), and it carries $P=\theta_{k,l}$.

**This is a source in [references/](../references/), and it is unconditional**, the notes' own citation graph records *"Proposition 2.25 is independent of the chain and unconditional"*, and I checked that against the text: its proof runs off Lemma 2.22 and the identity part of $S_{k,l}$, with no appeal to Conjecture A. So the missing half is not a hypothesis debt; it is a **citation debt**.

**Taking $(k,l)=(\lceil n/2\rceil,\lfloor n/2\rfloor)$ gives $\sup\ge\Theta_n$.** At $n=13$, $(k,l)=(7,6)$, exact hand evaluation:
$$\theta_{7,6}^2=2\cdot\frac{6}{7}\cdot\frac{5}{6}\cdot\frac{12}{11}=\frac{2\cdot 5\cdot 12}{7\cdot 11}=\frac{120}{77}=\Theta_{13}^2 .$$

**The block does not cite it.** The pull-quote says *"by the $\theta_{k,l}$ formula below"*, and the formula it points to (scope condition 3), itself carries no source. So the block's route to the witness terminates inside the block.

### 3.3 The block's $\theta_{k,l}$ formula is Proposition 2.25, verified by hand

Scope condition 3 writes $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$. With $k+l=n$,
$$2\frac{n-1}{n-2}\cdot\frac{kl-(n-1)}{kl}=2\frac{n-1}{n-2}\cdot\frac{kl-k-l+1}{kl}=2\frac{n-1}{n-2}\cdot\frac{(k-1)(l-1)}{kl}=\theta_{k,l}^2$$
in Nienhaus's form. **Identical.** So scope condition 3 restates published mathematics without saying so, the same uncited source, spent a second time.

---

## 4. Candidate D2, the Lagrange condition and its two silent imports

**Locate.** [problem.md](../findings/problem.md):490: *"so $W_{\max}$ is critical, for $P|_{\lVert W\rVert=1}$, whose Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$, and never for $P$ on $\mathcal W_n$."*

**Exhibit.** The first-order condition at a constrained maximum is $\nabla P|_W=\mu\,\nabla(\lVert W\rVert^2)|_W$ **inside $\mathcal W_n$**, i.e. $\pi_{\mathcal W_n}(\nabla P|_W)=2\mu W$. Two facts are needed to reduce this to $Q(W)=\theta W$, and the block names neither:

- **$\nabla P|_W=3Q(W)$.** $P(W)=T(W,W,W)$ with $T(A,B,C)=\langle A,\Phi(B,C)\rangle$; the derivative is $3T(W,W,\cdot)=3\langle Q(W),\cdot\rangle$ **only because $T$ is fully symmetric**, which is BW08 eq. (5). [problem.md](../findings/problem.md) records it, *"The symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ is a theorem, BW08 eq. (5)"*, some 400 lines above this block.
- **$Q(W)\in\mathcal W_n$.** Otherwise the condition is $\pi_{\mathcal W_n}(Q(W))=\theta W$ and not $Q(W)=\theta W$. It holds by BW08 eq. (6), $\mathrm{Ric}(\Phi(R))_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, so $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$, together with $\Phi$ preserving the first Bianchi identity. Both are recorded in [problem.md](../findings/problem.md), again above the block.

Then $3Q(W)=2\mu W$, so $Q(W)=\theta W$ with $\theta=\tfrac23\mu$, and pairing with $W$ at unit norm gives $\theta=\langle W,Q(W)\rangle=P(W)$, the block's stated form, confirmed. The clause *"and never for $P$ on $\mathcal W_n$"* is also right: an unconstrained critical point of the cubic $P$ satisfies $Q(W)=0$, hence $P(W)=0$.

**Argue the opposite.** Both imports live in the same file as the block, and [lean/INDEX.md](../lean/INDEX.md):216 explicitly books the honest state, *"the Lagrange condition stays imported"*. A reader of [problem.md](../findings/problem.md) end to end has them.

**Disposition: a hypothesis-inventory finding, not a defect.** The stated condition is true. What is missing is the two names, and the record already flags the import in its Lean row.

---

## 5. Question 2, the three scope conditions, each against a named object

### 5.1 Scope condition 1, value, not maximiser

**Against the source.** Conjecture A's conclusion, extraction L212, read: *"$P(W)\leqslant P(W^{\mathrm{crit}}_{\mathrm{sym}})$."* Non-strict, and no equality or rigidity clause anywhere in the statement. **The block reads its source correctly.** A consumer may cite: *L0 is about the value $M(n)$; uniqueness of the maximiser is untouched by it, and belongs to the nondegeneracy and rigidity results (Lemmas 11, 26–28, L57's equality case).*

**One clause overstates.** *"so it is equivalent to attainment of $\Theta_n$"*, Conjecture A, being $\forall$ critical $W:P(W)\le\Theta_n$, is not by itself equivalent to attainment; attainment is H6, the very fact the block's own pull-quote says is missing. Charitably, the sentence's subject is the contrast with uniqueness and "attainment" is shorthand for "the value being $\Theta_n$", under that reading it is exact given H6. **The candidate is recorded, not pressed: it is the same debt as D1, restated in a different sentence.**

### 5.2 Scope condition 2, the $n\ge12$ clause alone

**Against the source.** Extraction L212, read: *"If either $n\ge12$ or $8\leqslant n\leqslant11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$."* A disjunctive hypothesis, so the published conjecture is genuinely a conjunction of two clauses and an $n\ge12$ statement cannot imply the other. **CONFIRMED.**

**Against a named object, by hand.** At $n=10$: $\Theta_{10}^2=\theta_0(10)^2=\frac{2\cdot9\cdot8}{100}=\frac{144}{100}=\frac{36}{25}$, and $\frac{36}{25}=1.44<1.5=\frac32=P(W_{\mathbb{CP}^2})^2$. **Confirmed exactly.** Cross-checked by an independent route on the record: $\theta_0(n)^2<\tfrac32\iff4(n-1)(n-2)<3n^2\iff n^2-12n+8<0$, which at $n=10$ is $100-120+8=-12<0$. The two agree.

**And this is why H1 is carried but unspent.** The block's proof is valid at every $n\ge4$; what $n\ge12$ buys is that the padded $W_{\mathbb{CP}^2}$ no longer beats $\Theta_n$, so that the left-hand side is not automatically false. At $8\le n\le11$ the biconditional still *holds*, with both sides false, $M(n)\ge\sqrt{3/2}>\Theta_n$ makes the left side false, and the maximiser is critical with $P>\Theta_n$, making the right side false too. **So $n\ge12$ is a hypothesis of the identification with Conjecture A, not of the equivalence.** The block does not say this, and it is worth a consumer knowing.

### 5.3 Scope condition 3, the balanced split

**Monotonicity, by hand.** $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$ is strictly increasing in $kl$ for $kl>0$, since $\frac{n-1}{kl}$ is strictly decreasing and $\frac{2(n-1)}{n-2}>0$ at $n\ge3$. And $kl=k(n-k)$ is maximised over integers at $k=\lceil n/2\rceil$, since $4k(n-k)=n^2-(n-2k)^2$. **CONFIRMED.**

**Both closed forms re-derived from the split formula, by hand.**

- Even $n$, $kl=n^2/4$: $\;2\frac{n-1}{n-2}\left(1-\frac{4(n-1)}{n^2}\right)=2\frac{n-1}{n-2}\cdot\frac{n^2-4n+4}{n^2}=\frac{2(n-1)(n-2)^2}{(n-2)n^2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2.$
- Odd $n$, $kl=(n^2-1)/4$: $\;2\frac{n-1}{n-2}\left(1-\frac{4(n-1)}{n^2-1}\right)=2\frac{n-1}{n-2}\cdot\frac{n+1-4}{n+1}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}=\Theta_n^2.$

**Both match the block's stated closed forms exactly.**

**Against a named object, by hand.** At $n=12$: $\theta_{6,6}^2=2\cdot\frac{11}{10}\left(1-\frac{11}{36}\right)=\frac{11}{5}\cdot\frac{25}{36}=\frac{275}{180}=\frac{55}{36}$, and $\theta_{5,7}^2=\frac{11}{5}\left(1-\frac{11}{35}\right)=\frac{11}{5}\cdot\frac{24}{35}=\frac{264}{175}$. Comparing by cross-multiplication: $264\cdot36=9504$ against $55\cdot175=9625$, so $\frac{264}{175}<\frac{55}{36}$. **Confirmed exactly.** And $\theta_{6,6}^2=\frac{55}{36}=\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{220}{144}$, consistent.

**One caveat a consumer needs.** *"the unbalanced products are critical but strictly sub-maximal"* is sub-maximal **among sphere products**, not globally: [graded-half.md](../findings/graded-half.md):35 records $S^5\times S^7$ at $n=12$ sitting at $1.228239>\sqrt{3/2}$. The block's words support only the intra-family reading, and its own witness pair is intra-family, so this is a reading hazard rather than an error.

### 5.4 What a consumer may cite from the three conditions

All three are **sound as written and checked against named objects**. They are, however, each supplied by the round rather than the original, and two of them (SC1's "attainment", SC3's formula) lean on the same uncited Proposition 2.25.

---

## 6. The constant repair, re-derived by hand, and it is exact

**The margin identity.** $(n-2)^2(n+1)=(n^2-4n+4)(n+1)=n^3-3n^2+4$, and $n^2(n-3)=n^3-3n^2$. So $(n-2)^2(n+1)-n^2(n-3)=4$, **identically in $n$**. Confirmed.

**The gap.**
$$\theta_0(n)^2-\Theta_n^2=2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\right]=\frac{2(n-1)\big[(n-2)^2(n+1)-n^2(n-3)\big]}{n^2(n+1)(n-2)}=\frac{8(n-1)}{n^2(n+1)(n-2)}>0$$
for $n\ge3$. **Confirmed, and the block's $8$ is indeed $2\times4$.**

**At $n=13$, exactly.** $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$; $\Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{240}{154}=\frac{120}{77}$. Difference: over $169\cdot77=13013$, $264\cdot77=20328$ and $120\cdot169=20280$, so $\frac{264}{169}-\frac{120}{77}=\frac{48}{13013}$. Cross-check against the closed form: $\frac{8\cdot12}{169\cdot14\cdot11}=\frac{96}{26026}=\frac{48}{13013}$. **The two agree exactly.**

**Trap one, carried in, is cleared.** The block states $\Theta_n$ throughout, never $\theta_0(n)$, in both the display and the conclusion; the withdrawn $\theta_0$ form is recorded in the pull-quote as withdrawn. **NO FINDING.**

**Trap two, carried in, is where the block is exposed.** Conjecture A hypothesises criticality; the block's left-hand side quantifies over every unit Weyl operator. The block asserts *"each side is then the $n\ge12$ clause of Conjecture A"*, which makes the all-$W$ statement and the critical-$W$ statement interchangeable. That interchange is exactly ($\Leftarrow$), and its equality half is H6. **So trap two and candidate D1 are the same defect seen from two sides**, and a consumer citing "each side is Conjecture A" inherits it.

---

## 7. Question 3, the three forms compared

| form | what it carries that the others do not |
|---|---|
| [problem.md](../findings/problem.md):470–500, the block | the only place with the **proof**, the three scope conditions, and the "does and does not buy" reading; the only place stating the ($\Leftarrow$) shortfall **on the step itself**; the only place naming the witness object |
| [results.md](../results.md):775, under "Audit owed" | the **cleanest consumer statement**: the full biconditional, the constant repair, the provenance ([r591](../reviews/REVIEW_r591.md), [r592](../reviews/REVIEW_r592.md)), and (in bold), *"the lower half needs the balanced product as witness, which the block asserted and did not cite"*. Carries the separation from Lemma L43, which the block does not |
| [results.md](../results.md):11, the state table | asserts *"**Proven at both parities**"* with **no** trace of the ($\Leftarrow$) shortfall; its only qualifier is about the constant. See §8 |
| [results.md](../results.md):46, literature relation | routes the identification through **$\theta_0(n)$**, the refuted constant. See §9 |
| [lean/HamiltonsCubic/Results/L0.lean](../lean/HamiltonsCubic/Results/L0.lean) | machine-checked **arithmetic only**, `margin_is_four`, `gap_closed_form`, `gap_positive`, `values_at_thirteen`, `split_values`, `split_increasing`, `product_identity`, `ten_clause_live`. Every binder is over $\mathbb Q$; **no binder mentions $P$, $\mathcal W_n$, criticality or a supremum** |
| [lean/INDEX.md](../lean/INDEX.md):216, the L0 row | status **proved**, with the honest owed line: *"**Owed, halved**: compactness is closed in [SphereAttains](../lean/HamiltonsCubic/Results/SphereAttains.lean) … the Lagrange condition stays imported"* |
| [lean/INDEX.md](../lean/INDEX.md):182, the L16 row | status **partial**, owing *"that $\Theta_n$ **is** the odd sphere-product maximum"*, the same H6/H7 debt, booked against a different row |

**The Lean layer hides no hypothesis, and it also does not carry the claim.** Its two lemmas touching the biconditional are `backward_gives_only_le {P Θ s : ℚ} (hcrit : P ≤ Θ) (hmax : s = P) : s ≤ Θ` and `equality_needs_witness : ∃ s Θ : ℚ, s ≤ Θ ∧ s ≠ Θ`, the latter witnessed by $\langle0,1\rangle$. These are *about the rationals*, and they **formalise the shortfall rather than the lemma**. That is a legitimate and honest thing for the row to do, but it means no form on the record carries a complete proof of L0.

---

## 8. Candidate D3, the named trap, first instance

**Locate.** [results.md](../results.md):11: *"| The problem $P$ and Conjecture A are one statement, at the constant $\Theta_n$ | **Proven at both parities** (Lemma L0), *refuted at $\theta_0(n)$, which is $\Theta_n$ at even $n$ only* |"*

**Exhibit the failure concretely.** The row's only qualifier concerns the **constant**. The ($\Leftarrow$) shortfall (the fact that no argument on the record closes $\sup\ge\Theta_n$ without an uncited citation), appears at [results.md](../results.md):775, **764 lines further down**, in a different section. A consumer reading the state table at the head of the canon takes "Proven at both parities" and stops.

Sharper: [results.md](../results.md):772, the preamble of the section that contains the honest statement, reads *"They are listed so the reader knows they exist; **none is cited above as a claim**."* Line 11 **is** above, and it **does** cite L0 as a claim, with a verdict. **The file contradicts itself about this lemma, in the same file, and the contradiction is exhibitable without leaving [results.md](../results.md).**

**Argue the opposite.** The canon's own preamble at line 3 says *"Claims only, a result appears here once Gate 2 has passed"*, so the state table is an index of claims pointing elsewhere for proof; and L0 *is* flagged as "audit owed" twice in the file, at lines 46 and 775. A charitable reader treats line 11 as a pointer, not a verdict. **But the cell contains the word "Proven", which is a verdict and not a pointer, and the "none is cited above as a claim" sentence is not charitable-readable away.** The candidate passes all three steps. **CONFIRMED.**

---

## 9. Candidate D4, the named trap, second instance, and it is a mathematical one

**Locate.** [results.md](../results.md):46: *"**Böhm–Wilking** supply the invariance criterion; the cone-bridge (Lemma L43) shows the $a=0$ criterion collapses to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ with $\theta_0(n)=c(n-1)$, **so Conjecture A and the problem $P$ are one statement** (Lemma L0, audit owed)."*

**Exhibit the failure concretely.** Take $n=13$. What the cone bridge delivers is $P(W)\le\theta_0(13)$, i.e. $P(W)^2\le\frac{264}{169}$. What Conjecture A asserts is $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_{13}$, i.e. $P(W)^2\le\frac{120}{77}$. By §6 these differ by $\frac{48}{13013}>0$. **They are not one statement at $n=13$**, the first is strictly weaker, permitting every value in $\left(\frac{120}{77},\frac{264}{169}\right]$ that the second forbids. This is precisely the identification L0 was rewritten to refute, surviving in the canon in a sentence that cites L0 by name. [problem.md](../findings/problem.md)'s own L43 material already says so, *"the criterion gives $P(W)\le\theta_0(n)$ at every $n$, but $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ only when $n$ is even … So this is the Conjecture A **bound**, sharp at even $n$"*, so the record holds the refutation and line 46 does not carry it.

The same phrase sits in [conventions.md](../findings/conventions.md):18 in its corrected form, *"the target of Problem P is $\Theta_n$"*, against [problem.md](../findings/problem.md)'s L43 closing line *"the constant of Problem P is what cone invariance requires"*, i.e. $\theta_0(n)$. **Two files name a different constant as Problem P's.**

**Argue the opposite.** "One statement" can be read as "one variational problem", the same functional $P$, the same domain $\mathcal W^1_n$, differing only in the constant on the right, which is true at every $n$, and the trailing "(Lemma L0, audit owed)" flags the row as unaudited. Under that reading line 46 is loose rather than false. **But the sentence's whole purpose is to identify a bound with a conjecture, and at odd $n$ the two bounds are different numbers; "audit owed" flags the lemma, not this sentence's constant.** The candidate passes all three steps. **CONFIRMED, and it is a live mathematical defect rather than a labelling one.** It sits outside the block, cites the block, and is the block's own conclusion not having propagated.

---

## 10. Candidate D5, *"Both directions checked in [L0.lean] and [L16.lean]"*

**Locate.** [problem.md](../findings/problem.md):477, closing the constant pull-quote: *"**That $4$ is Conjecture L16's constant margin, so the two blocks turn on one identity**, L16 reads it as a gap between $\Theta_n$ and $\theta_0(n)$ that never closes as $n$ grows, this block as the reason a substituted constant asserted the conjecture's own negation. *Both directions checked in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) and [L16.lean](../lean/HamiltonsCubic/Results/L16.lean).*"*

**Exhibit.** Under the reading "both directions of the biconditional", the claim is false: I read [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) in full, and **no theorem in it quantifies over $\mathcal W_n$, $P$, criticality or a supremum**, the two that come nearest are `backward_gives_only_le` and `equality_needs_witness`, both stated over $\mathbb Q$, and the second is witnessed by the rationals $0$ and $1$. [lean/INDEX.md](../lean/INDEX.md):216 confirms it: *"the Lagrange condition stays imported"*. So a consumer taking "both directions are Lean-checked" is misled, and this sentence sits eight lines above a paragraph whose subject is literally the two directions of the biconditional.

**Argue the opposite.** The sentence's grammatical subject is the **margin-$4$ identity** and its "two readings" by the two blocks, which the preceding clause has just named. Under that reading, "both directions" means "both readings", and the claim is exact: `margin_is_four` and `gap_closed_form` are in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean), and [lean/INDEX.md](../lean/INDEX.md):182 records the same identity from L16's side.

**Disposition.** The words support both readings; one is exact and one is false, and the false one is the one a reader arrives at from the surrounding paragraphs. **CONFIRMED as an ambiguity a consumer inherits, not as a false statement.** One word fixes it, "both readings".

## 10b. Candidate withdrawn

*"carrying $\theta=\Theta_n$ by the $\theta_{k,l}$ formula below"* ([problem.md](../findings/problem.md):492) points **below**, but the only $\theta_{k,l}$ formula in the block is scope condition 3, four lines **above**. **Withdrawn**: "below" reads naturally as below the *statement* it qualifies, which the formula is; and it is the only such formula in the block, so no reader can mistake the referent. Located and exhibitable, but the charitable reading fully carries it.

---

## 11. Quantifier order, scope, and the edges of every range

**Quantifier order.** Left side: a statement about one number, $\sup_{\lVert W\rVert=1}P(W)$. Right side: $\forall W$ critical for $P|_{\lVert W\rVert=1}$, $P(W)\le\Theta_n$. No quantifier is exchanged in either direction of the proof; ($\Rightarrow$) instantiates the sup bound at each critical point, ($\Leftarrow$) instantiates the $\forall$ at the single point $W_{\max}$. **NO FINDING.**

**Critical for what.** The block is explicit and correct: critical *for the restriction* $P|_{\lVert W\rVert=1}$, *"and never for $P$ on $\mathcal W_n$"*. This matters, the unconstrained critical points of a homogeneous cubic satisfy $Q(W)=0$, hence $P=0$. And it matches the published Conjecture A, extraction L212: *"a critical point of $P$ … among $\mathrm{Weyl}^1_n$"*. **NO FINDING.**

**Odd $n$.** Fully covered, and this is the block's repair. $\Theta_n$ at odd $n$ equals $\theta_{(n+1)/2,(n-1)/2}$, re-derived in §5.3, and $\Theta_n<\theta_0(n)$ strictly with the gap of §6. **NO FINDING.**

**The smallest admissible dimension.** $n=12$ by H1. Within the block, the smallest object actually evaluated is $n=10$ (scope condition 2's live-content witness), which is **outside** the block's own range and correctly labelled as belonging to the other clause. The proof itself is valid at every $n\ge4$; §5.2 records what $n\ge12$ is for. **NO FINDING, with the note that H1 is unspent by the proof.**

**Reducible cases.** The block's own witness is a **reducible** symmetric space, $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$. Nothing costs anything: only its algebraic Weyl operator $W_{S_{k,l}}\in\mathcal W_n$ enters, and $\mathcal W_n$ carries no irreducibility condition. **NO FINDING.**

**Non-compact cases.** No manifold is quantified over anywhere in the block, the compactness in the proof is that of the unit sphere of a finite-dimensional real inner-product space, an algebraic fact (H2, H3), not a geometric hypothesis on a space form. The witness's compactness is incidental to its use. **NO FINDING.**

**$\ker W\ne0$.** The block never inverts $W$, never divides by an eigenvalue, and never assumes a spectrum is supported off zero. Its witness $W_{S_{k,l}}$ is a genuinely degenerate operator and remains admissible. The record's one kernel-sensitive result (Lemma L7's bracket-grading conditions holding *modulo* $\ker W$), does not feed this block. **NO FINDING: the argument uses no hypothesis on $\ker W$, and none is omitted.**

---

## 12. The gap between what is proven and what is used, what a reader may take from this block

**May cite, unconditionally:**

- ($\Rightarrow$): if $M(n)=\Theta_n$ then $P\le\Theta_n$ at every critical point of $P|_{\lVert W\rVert=1}$. Uses nothing.
- ($\Leftarrow$, half): if $P\le\Theta_n$ at every critical point of $P|_{\lVert W\rVert=1}$, then $M(n)\le\Theta_n$. Uses H2–H5, I1–I4.
- The constant: $\Theta_n$ is $\theta_0(n)$ at even $n$ and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, with $\theta_0^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))>0$ at odd $n$, from the identity $(n-2)^2(n+1)-n^2(n-3)=4$. **Re-derived here by hand, §6.**
- The three scope conditions, each as written. **Checked against named objects, §5.**

**May NOT cite from this block alone:**

- The full biconditional, and therefore the sentence *"each side is then the $n\ge12$ clause of Conjecture A"*. Both need H6, and this block contains no argument and no citation for H6.
- Any claim that the biconditional is Lean-checked in either direction. §7 and §10.

**What closes it, in one line a repair could write.** *By Nienhaus Proposition 2.25 (extraction L1483), $W_{S_{k,l}}$ is a unit Weyl operator with $Q(W_{S_{k,l}})=\theta_{k,l}W_{S_{k,l}}$ and $P(W_{S_{k,l}})=\theta_{k,l}$; at $(k,l)=(\lceil n/2\rceil,\lfloor n/2\rfloor)$ this gives $\sup\ge\Theta_n$, and with the ($\Leftarrow$) bound, equality.* **I have not written it into the block; supplying it is not this report's job.**

---

## 13. What would falsify the block, and what I did to look for it

**The single object.** A dimension $n\ge12$ at which **no** unit Weyl operator attains $\Theta_n$. At such an $n$ the right-hand side could hold (every critical point below $\Theta_n$) while $M(n)<\Theta_n$, so the left-hand side would be false and the biconditional would fail. This is the *only* way either direction can break: ($\Rightarrow$) is definitional, and ($\Leftarrow$)'s $\le$ half is proved outright.

**Where I looked.** [references/nienhaus-2023-second-best-einstein/](https://arxiv.org/abs/2311.02404) at L1420–1500, reading the definition of $\mathcal S_{\mathrm{crit},n}$, its unit normalisation, and Proposition 2.25 in the source rather than the notes; [references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) for the citation graph, which records Proposition 2.25 as unconditional and independent of the Theorem 4.19 chain; [findings/graded-half.md](../findings/graded-half.md):35 and :440 and [findings/nondegeneracy.md](../findings/nondegeneracy.md):764, where the record's own sphere-product values are reported as agreeing with Proposition 2.25; [lean/INDEX.md](../lean/INDEX.md):203, whose L5 row reaches $55/36$ and $264/175$ from a norm formula by a disjoint route. **The object does not exist**, and the witness is available at every $n$ and every split.

**A second, weaker falsifier.** A dimension $n\ge12$ at which $P(W^{\mathrm{crit}}_{\mathrm{sym}})\ne\theta_{\lceil n/2\rceil,\lfloor n/2\rfloor}$ would break the sentence identifying each side with Conjecture A while leaving the biconditional intact. Excluded by Nienhaus's own definition of $\mathcal S_{\mathrm{crit},n}$ at L1440–1460 read together with Proposition 2.25, the definition *is* the balanced split.

**What I could not exclude.** Nothing on the mathematics. The two confirmed defects that remain are documentary: [results.md](../results.md):11 (§8) and [results.md](../results.md):46 (§9).

---

## Verdict

**`GAP`.**

The statement is true; ($\Rightarrow$) is proven; ($\Leftarrow$) is proven only to $\sup\le\Theta_n$, and the block says so on the step and then closes with $\square$ anyway; the missing half is unconditional published mathematics in [references/](../references/), read at extraction L1483, and cited nowhere in the block. Two imported facts under the Lagrange condition are unnamed but true and on the record. The three scope conditions are sound and check out against named objects. Two consumer-facing restatements still carry defects the block repaired, [results.md](../results.md):11 asserting "Proven at both parities" in a file whose own preamble says the lemma is not cited above as a claim, and [results.md](../results.md):46 identifying Conjecture A with Problem P at $\theta_0(n)$, which is false at $n=13$ by $\tfrac{48}{13013}$.

Not `BROKEN`: nothing asserted in the block is false. Not `HYPOTHESIS-DEBT`: the argument for the missing half is on file, in a read source. Not `PROVEN`: no form of L0 anywhere on the record (prose, canon or Lean), carries a complete proof of the biconditional.
