# REVIEW r262, Gate 2, the APPLICATION of r259 and r260

Reviewer 262. Commits under review: `ae44228` (plan.md), `fd356d2` (brauer-pairing.md), `527fcbc` (the two reference notes), `1fd017c` (the scripts).
Files: [plan.md](../plan.md) section 2 item 1; [findings/brauer-pairing.md](../findings/brauer-pairing.md) final section; [findings/INDEX.md](../findings/INDEX.md) line 40; [references/rui-brauer-semisimplicity/notes.md](../references/rui-brauer-semisimplicity/notes.md); [references/lehrer-zhang-sft-orthogonal/notes.md](../references/lehrer-zhang-sft-orthogonal/notes.md); [scripts/runs/run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py). Prior reviews: [REVIEW_r259.md](REVIEW_r259.md), [REVIEW_r260.md](REVIEW_r260.md).
Scripts: [scripts/reviewers/r262/](../scripts/reviewers/r262/). Reviewer 261 runs the identical brief concurrently and independently.

What is audited is the application, not the underlying theorem. Every number below comes from a code path written here: the loop count is re-derived as a union-find component count, $\dim\nu(B_f(n))$ is computed a second time from the **definition** (rank of the span of the actual operators $\nu(D)$, exact over $\mathbb Q$), and the multiplicities are tested against the El Samra–King $O(n)$ dimension through $\sum_\lambda m_\lambda(n)\dim V_\lambda=n^f$, an identity the up–down recursion knows nothing about. The primary source [arXiv:1507.07676](https://arxiv.org/abs/1507.07676) was downloaded and read, not paraphrased.

| # | Claim as applied | Verdict |
|---|---|---|
| 1 | The theorem is unconditional in $n$ | **THE MATHEMATICS IS CORRECT AND THE AUTHORITY CITED FOR IT FAILS AT $n=12$.** The double centraliser needs complete reducibility, absolute irreducibility of the $V_\lambda$, and $\nu(B_f(n))=\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$; only the third is load-bearing and it is the one miscited. **ASWT Theorem 3.17(b), read from the source, gives surjectivity in type $B_m$ ($n$ odd) and NOT in type $D_m$ ($n$ even)**, there it gives only *injective if $n\ge d$*, isomorphism at $n\ge2d+1$, and §3.5 states *"surjectivity of $\Phi_{Br}$ fails in general for $U_1(\mathfrak{so}_{2m})$"*. The route sits at $n=12$, type $D_6$. The claim survives because ASWT's $U_1$ is $SO$ and the route's group is $O$, a distinction the record's own $92\to89$ and $77\to71$ counts depend on and this passage never makes. The associate/chirality worry is **absent for $O(n)$**: no doubling is owed, confirmed at $72$ pairs |
| 2 | Step (iii) as now stated | **CONFIRMED, ALL THREE PARTS, AND THE SCRIPT STILL CARRIES THE REFUTED WORDING.** $e$ preserves isotypic components, $e\,M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathrm{Weyl}_n)$ exactly, and spanning follows by linearity alone, so a seed $e$ annihilates costs nothing. Explicit case built here with a genuine $\mathrm{Sym}^2$-of-an-irreducible projector: $\lVert e\,c_0\rVert\le9\times10^{-16}$ and $\mathop{\mathrm{span}}\{e\,\nu(D)c_0\}=e\,M_\varnothing$ at $n=3,4,5,6$. **But [run_diagram_realisation.py:26–28](../scripts/runs/run_diagram_realisation.py#L26) still says "e itself to be a diagram element, and it is" by "the SURJECTIVITY half of the SFT"**, both corrected in [brauer-pairing.md](../findings/brauer-pairing.md) by a commit forty-five minutes earlier and left standing in a file the later commit rewrote |
| 3 | The deletion of the dependency audit | **THE CORRECT THIRD IS LOST, AND THE DELETION TOOK THE ITEM'S DELIVERABLE WITH IT.** Conclusion (c) (*A3 needs the covariants BUILT, which is not the same as proving them independent*), was **confirmed by both reviewers** and is now stated nowhere in [plan.md](../plan.md), [findings/INDEX.md](../findings/INDEX.md) or [findings/](../findings/). The same rewrite deleted the item's stated theorem, *"each of the 184 constructed covariants is exhibited as an explicit combination of Brauer diagrams … it is the item's whole content"*, and nothing replaces it. [plan.md:55](../plan.md) still reads *"A3 cannot start without it"*, which is the conflation (c) named |
| 4 | The new verification | **(a), (b), (c) CONFIRMED INDEPENDENTLY; (d)'s STATED REASON IS A NON SEQUITUR.** (a) The Gram identity is right and the reason is positive-definiteness, which the file does not give, verified against the definition, exact rational rank of $\mathop{\mathrm{span}}\{\nu(D)\}$, at $14$ cells. (b) `loops` is right: **zero disagreements with a union-find component count over all $11{,}025$ pairs at $f=4$ and all $893{,}025$ at $f=5$**. (c) The restricted up–down count **is** $m_\lambda(n)$, and **no doubling is owed at self-associate $\lambda$**: $\sum_\lambda m_\lambda(n)\dim V_\lambda=n^f$ at all $72$ pairs with $f\le8$, $n\le9$. (d) *"a modular rank can only understate, so agreement between two primes licenses reading it as exact"* **does not follow**, $\mathrm{rank}_p\le\mathrm{rank}_{\mathbb Q}$ for every $p$, so $k$ agreeing primes bound the rank from **below** only. Six primes agree at all $24$ cells and exact $\mathbb Q$-rank agrees at all $18$ with $f\le4$, so the table is right. Separately: [brauer-pairing.md](../findings/brauer-pairing.md)'s **"all $40$ pairs tested" matches nothing**, r259 tested $32$, the script tests $24$ |
| 5 | plan.md's reopened item | **CORRECT EXCEPT FOR ONE MISATTRIBUTION.** The restriction-kernel refutation, $r=6+\lvert\lambda\rvert/2$, and obligations (i) and (ii) are all faithful; $23!!=316{,}234{,}143{,}225=3.162\times10^{11}$ **exact**, and $184\to71$ is right *with* the qualifying clause the item carries. (iii)'s r242 half is verbatim. **But "r244 prices it at order $\sim89$ with entries of degree $\le6$" is r244's pricing of $\xi(n)$, the A2′ pivot minor, not of $\det\mathrm{Gram}_S$**, r260 wrote *"prices the same **shape** of obligation"* and the application dropped the hedge. r242's own $\det\mathrm{Gram}_S$ witness is a $3\times3$ Gram |
| 6 | The reference-note corrections | **BOTH VERIFIED VERBATIM AGAINST THE PRIMARY SOURCE; THE NEW COMPARISON CONTRADICTS ITS OWN PRECEDING CLAUSE.** ASWT Theorem 7.1(3): *"$\delta_0\ne0$, $\mathrm{char}(K)=0$ and $d\le\delta_0+1$"*, with Conventions 3.11 fixing $\delta_0=\lvert\delta\rvert$, so $\delta=-2n$ gives $f\le2n+1$, exactly as the note now says. 7.1(5): *"$\delta_0=0$, $\mathrm{char}(K)=0$ and $d\in\{1,3,5\}$"*, exactly as the note now says. $n\ge12$ for injectivity of $\nu:B_{12}(n)\to\mathop{\mathrm{End}}_{O(n)}(V^{\otimes12})$ is **right**, and ASWT's type $D_m$ line independently gives it. **What is wrong is the sentence around it**: [notes.md:28](../references/rui-brauer-semisimplicity/notes.md) says *"neither ranking nor a shared 'slack' scale is meaningful"* and then, in the same sentence, ranks them as *"tighter than Rui's"* |

---

## Claim 1, unconditional in $n$: the argument holds and the citation does not

### The hypotheses, stated

The record's sentence is: *"$M_\lambda$ is a module over the **image** $\nu(B_f(n))$, and the double centraliser theorem, needing only complete reducibility of the $O(n)$-action, which holds at every $n$ in characteristic zero, makes the image $\bigoplus_\lambda\mathop{\mathrm{End}}(M_\lambda)$ with each $M_\lambda$ irreducible."*

Three hypotheses are used, and the sentence names one and a half of them.

| hypothesis | status at $O(n)$, char $0$ | named in the record? |
|---|---|---|
| $V^{\otimes f}$ is a semisimple $O(n)$-module | true, $O(n)$ reductive in char $0$ | yes |
| $\mathop{\mathrm{End}}_{O(n)}(V_\lambda)=k$, i.e. the $V_\lambda$ are absolutely irreducible | true for $O(n)$ | no |
| $\nu(B_f(n))=\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$, the FFT | true for $O(n)$ at every $n$ | yes, "plus the FFT" |

Without the second, "the image is $\bigoplus\mathop{\mathrm{End}}(M_\lambda)$" reads $\bigoplus\mathop{\mathrm{End}}_{D_\lambda}(M_\lambda)$ over division rings, and "irreducible" is still fine but the displayed decomposition is not. It is true here and it is unstated; the run's own docstring says *"$B_{12}(12)$ is SEMISIMPLE over $\mathbb Q$"*, so the field is left ambiguous in exactly the place where it matters.

### The third hypothesis is the load-bearing one, and its citation fails at $n=12$

[findings/brauer-pairing.md](../findings/brauer-pairing.md) attributes it: *"the **First** Fundamental Theorem (ASWT Theorem 3.17(b)), which holds at every $n$, with no threshold"*. I downloaded [arXiv:1507.07676](https://arxiv.org/abs/1507.07676) and read Theorem 3.17(b). It is stated **per type**:

> $B_m$: $\Phi_{Br}:B_d(\delta)\twoheadrightarrow\mathop{\mathrm{End}}_{U_1}(T_n^d)$, and $\Phi_{Br}:B_d(\delta)\xrightarrow{\ \cong\ }\mathop{\mathrm{End}}_{U_1}(T_n^d)$ if $n\ge d$.
> $C_m$: $\Phi_{Br}:B_d(\delta)\twoheadrightarrow\mathop{\mathrm{End}}_{U_1}(T_n^d)$, and $\cong$ if $n\ge 2d$.
> $D_m$: $\Phi_{Br}:B_d(\delta)\hookrightarrow\mathop{\mathrm{End}}_{U_1}(T_n^d)$ if $n\ge d$, and $\cong$ if $n\ge2d+1$.

Type $B_m$ has $n=2m+1$, **odd**. Type $D_m$ has $n=2m$, **even**, and its line carries no surjection at all, only an injection. Four paragraphs later the paper says why, in its own words:

> **3.5. A slightly stronger statement in type D.** Let $m\ge1$. Then surjectivity of $\Phi_{Br}$ **fails in general** for $U_1=U_1(\mathfrak{so}_{2m})$.

The route is at $f=d=12$ and $n=12=2\cdot6$, type $D_6$. **At the route's own dimension the cited theorem states the opposite of what it is cited for.** r259's evidence paragraph is explicit that it read the type-$B_m$ line (*"ASWT Theorem 3.17(b), type $B_m$"*); the application kept the pointer and dropped the type.

**The claim survives anyway, for a reason the record never states.** ASWT's $U_1$ is $\mathfrak{so}_{2m}$ (the connected group $SO(n)$) and $\mathop{\mathrm{End}}_{SO(n)}(V^{\otimes d})\supsetneq\mathop{\mathrm{End}}_{O(n)}(V^{\otimes d})$ at even $n$. Brauer's classical FFT for the **full** orthogonal group is surjective at every $n$, and ASWT's own Theorem 3.24 says the image is $\mathop{\mathrm{End}}_{\tilde U_1}$ with $\tilde U_1$ the extension by the Dynkin-diagram symmetry, which is $O$. So the right citation is Brauer 1937, as r260 said, and ASWT 3.17(b) is the wrong pointer at even $n$.

This is not a pedantic distinction in this record. [findings/sym3-stability.md:34](../findings/sym3-stability.md) records that at $n=12$ the $SO$ count is $77$ against $O$'s $71$, *"the six six-row labels splitting at $\ell=n/2$"*; [plan.md](../plan.md) A1 records $92\to89$ for $SO$ where $O$ is constant at $89$. The whole route depends on the group being $O$, and this passage cites a theorem about $SO$ for the step that makes the algebra the full commutant.

*Incidental confirmation from my own run.* In [r262_seed.py](../scripts/reviewers/r262/r262_seed.py) I built the empty block as the joint kernel of the $\mathfrak{so}(n)$ action. At $n=3,5,6$ it has dimension $3$, the three pairings. At $n=4$ it has dimension **$4$**, the pairings plus $\varepsilon_{abcd}$, which is $SO(4)$-invariant and not $O(4)$-invariant. The gap the citation ignores shows up in a four-dimensional example.

### Does the conclusion hold for every $\lambda$, including the self-associate ones?

**Yes, for $O(n)$, and this is where the brief's suspicion is misplaced.** A partition with $\lambda'_1=n/2$ satisfies $\lambda=\lambda^*$, so $V_\lambda\otimes\det\cong V_\lambda$; restricted to $SO(n)$ it splits into two, but as an $O(n)$-module it stays irreducible and absolutely irreducible. No multiplicity is doubled.

That is a testable statement, and I tested it rather than asserting it. If any $m_\lambda(n)$ were wrong (by a factor of two at the self-associate row or anywhere else), the isotypic decomposition would not account for $V^{\otimes f}$:

| test | result |
|---|---|
| $\sum_\lambda m_\lambda(n)\dim V_\lambda^{O(n)}=n^f$, El Samra–King dimensions | **holds at all $72$ pairs**, $1\le f\le8$, $1\le n\le9$ |
| pairs whose label set contains a self-associate $\lambda$ ($\lambda'_1=n/2$) | $26$ of the $72$, including $(f,n)=(6,6)$ with four such labels and $(8,8)$ with eight |
| $\sum_\lambda m_\lambda(n)^2$ against the exact $\mathbb Q$-rank of $[\,n^{\mathrm{loops}}\,]$ | equal at all $18$ pairs with $f\le4$ |

Evidence: [out_mult.txt](../scripts/reviewers/r262/out_mult.txt). **The blanket claim does not break at the associate pairs.** It would break if the group were $SO(n)$, which is the same distinction claim 1's citation gets wrong.

## Claim 2, step (iii) is correct, and the script was not corrected

### The three assertions

**"$e$ preserves isotypic components."** $e$ is the orthogonal projector onto the $O(n)$-submodule $\mathrm{Sym}^3(\mathrm{Weyl}_n)\subset V^{\otimes12}$, so $e$ commutes with $O(n)$, so it preserves each isotypic component and restricts to an endomorphism of each $M_\lambda$. **Correct.**

**"$e\,M_\lambda=\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathrm{Weyl}_n)$ EXACTLY."** Post-composition with $e$ sends $\varphi:V_\lambda\to V^{\otimes12}$ to $e\varphi$, whose image lies in $\mathrm{Sym}^3\mathrm{Weyl}_n$; and every $\psi:V_\lambda\to\mathrm{Sym}^3\mathrm{Weyl}_n$ satisfies $e\psi=\psi$, so it is in the image. Equality, not inclusion. **Correct, and "exactly" is the right word.**

**"The seed need not lie in the covariant space."** The spanning claim is $\mathop{\mathrm{span}}\{e\,\nu(D)c_0:D\}=e\,M_\lambda$. Since $e$ is linear and the diagrams span $B_f(n)$,
$$\mathop{\mathrm{span}}\{e\,\nu(D)c_0\}=e\cdot\mathop{\mathrm{span}}\{\nu(D)c_0\}=e\cdot\big(\nu(B_f(n))\,c_0\big)=e\,M_\lambda,$$
the last step by simplicity of $M_\lambda$ over the image and $c_0\ne0$. **$e\,c_0=0$ never enters.** It makes one member of the spanning family zero and nothing else.

### The explicit case

r259 used a product of antisymmetrisers as its stand-in projector. I built the shape the route actually has ($\mathrm{Sym}^k$ of an irreducible piece of $V^{\otimes2}$) and projected rather than asserted. $f=4$; $T_n\subset V^{\otimes2}$ the symmetric traceless tensors; $e$ the orthogonal projector onto $\mathrm{Sym}^2(T_n)\subset V^{\otimes4}$, built as $P\!\otimes\!P$ composed with the swap symmetriser and verified idempotent to $10^{-9}$. Seed $c_0$: a nonzero element of the empty block chosen **inside the kernel of $e$**.

| $n$ | $\mathop{\mathrm{rank}}e=\dim\mathrm{Sym}^2T_n$ | $t(t+1)/2$, $t=\tfrac{n(n+1)}2-1$ | $\dim e\,M_\varnothing$ | $\lVert e\,c_0\rVert$ | $\dim\mathop{\mathrm{span}}\{e\,\nu(D)c_0\}$ |
|---|---|---|---|---|---|
| 3 | 15 | 15 | 1 | $3.8\times10^{-16}$ | **1** |
| 4 | 45 | 45 | 1 | $4.1\times10^{-16}$ | **1** |
| 5 | 105 | 105 | 1 | $4.2\times10^{-16}$ | **1** |
| 6 | 210 | 210 | 1 | $9.3\times10^{-16}$ | **1** |

The $105$ diagrams applied to a seed the projector kills recover the block's covariant space in full, at every $n$ tested. Evidence: [out_seed.txt](../scripts/reviewers/r262/out_seed.txt).

### What the application missed

[fd356d2](../findings/brauer-pairing.md) records r259 claim 4 and r260 claim 4 in the findings file: *"as a **linear combination** of diagrams rather than as a single diagram"*, and *"the **First** Fundamental Theorem (ASWT Theorem 3.17(b)) … not 'the surjectivity half of the SFT'"*. Forty-five minutes later [1fd017c](../scripts/runs/run_diagram_realisation.py) rewrote the same theorem's script and left both refuted sentences in place:

> [run_diagram_realisation.py:26–28](../scripts/runs/run_diagram_realisation.py#L26), *"Step (iii) needs **e itself to be a diagram element**, and it is: e is an O(n)-equivariant endomorphism of V^{tensor 12}, and the **SURJECTIVITY half of the SFT**, which holds at EVERY n, with no threshold, puts every such endomorphism in nu(B_12(n))."*

Both are the exact wordings the same cycle corrected. The record now says two contradictory things about one object, in two files touched in the same hour.

**And the same docstring's third line is the claim `ae44228` reopened:**

> [run_diagram_realisation.py:6](../scripts/runs/run_diagram_realisation.py#L6), *"Independence is settled (Lehrer-Zhang 3.4, r <= n); the realisation is not"*.

That sentence is the central claim of `fcaf711`/`cb964bc`, refuted with a witness by both reviewers and reopened in [plan.md](../plan.md) by the first commit of this application. It survives, unqualified, in the file the last commit of this application rewrote.

## Claim 3, the deletion loses the correct third and the item's deliverable

I read [run_b_dependency_audit.py](../scripts/runs/run_b_dependency_audit.py) at `cb964bc`. Its three conclusions and their fate:

| conclusion | r259 | r260 | in the record after `1fd017c`? |
|---|---|---|---|
| (a) Theorem 3.4 supplies A2″'s hypothesis | refuted | refuted, with a witness | correctly refuted, in [plan.md](../plan.md) item 1 and [lehrer-zhang notes](../references/lehrer-zhang-sft-orthogonal/notes.md) §"does not close" |
| (b) $\det\mathrm{Gram}_S$ is checkable at the point of use | refuted | refuted | correctly refuted, [plan.md](../plan.md) item 1 (iii) |
| (c) A3 needs the covariants **built**, which is not proving them independent | *"right and is the useful one"* | **CONFIRMED** | **nowhere** |

**(c) is gone.** I grepped [plan.md](../plan.md), [findings/INDEX.md](../findings/INDEX.md), [ATTEMPTS.md](../ATTEMPTS.md), [response.md](../response.md), [findings/](../findings/) and [references/](../references/) for the statement in any form, "built", "conflated", "consumes the objects", "combination of Brauer diagrams". The only survivor is [lehrer-zhang notes:53](../references/lehrer-zhang-sft-orthogonal/notes.md), which states the *gap* (*"the construction emits vectors in a weight space"*) without stating that A3 consumes the objects rather than the theorem.

**Worse, the rewrite deleted the item's own deliverable.** `ae44228` removed this from [plan.md](../plan.md) section 2 item 1 and put nothing in its place:

> *"**The theorem this item must now produce:** each of the 184 constructed covariants is exhibited as an explicit combination of Brauer diagrams. That is a fact about our own construction, which no literature can supply, and it is the item's whole content."*

The nearest replacement is obligation (ii), *"the seeds, 71 of them, one per block"*, which names the count and the missing coefficient bound but never says the seeds must be exhibited **over diagrams**, the fact that made the item unclosable by literature in the first place. **A reader of the current [plan.md](../plan.md) cannot tell what item 1 must deliver.**

**And the section header re-states the conflation (c) named.** [plan.md:55](../plan.md) still reads *"reviewer 245 traced A2″'s hypothesis to it, A2 rests on it through $\det\mathrm{Gram}_S$, and A3 cannot start without it"*, one "it" doing duty for the theorem and for the objects, which is exactly the merge the audit's surviving conclusion identified. The deletion removed the file that made the distinction and left the sentence that blurs it.

*On the deletion itself: it was justified.* All four asserts are constant-folded, as both reviewers showed and as re-reading the file confirms, `two_r` is `3*4`, `r` is `two_r//2`, and `1/n - 1/n**2 < 1/n < 1/n + 1/n**2` is an identity for $n>0$. Nothing in it is a function of anything measured. **The objection is not to deleting the file; it is that the one-third that was true went with it.**

## Claim 4, the new verification

### (a) The Gram identity is correct, and the reason is not the one given

$\dim\nu(B_f(n))=\mathop{\mathrm{rank}}[\,n^{\mathrm{loops}(D,E)}\,]$. The derivation is three steps.

1. **$\gamma_D\in V^{\otimes2f}$ spans the invariants.** By the FFT for $O(n)$, $(V^{\otimes2f})^{O(n)}$ is spanned by the products of $f$ Kronecker deltas, one per perfect matching.
2. **The Gram entry is $n^{\mathrm{loops}}$.** $\langle\gamma_D,\gamma_E\rangle$ in the standard basis of $V^{\otimes2f}$ contracts $D$ against $E$; $D\cup E$ is $2$-regular, hence a disjoint union of cycles, and each closes to $\delta^a{}_a=n$.
3. **The form is positive definite**, being the restriction of the standard inner product on $V^{\otimes2f}$ over $\mathbb R$. **A Gram matrix of a spanning set under a positive-definite form has rank equal to the dimension of the span.** So the rank is $\dim(V^{\otimes2f})^{O(n)}=\dim\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})=\dim\nu(B_f(n))$.

Step 3 is where the identity actually comes from, and the file gives no justification at all, it states the computation and moves on. Positive-definiteness is not a detail: over a field where the form degenerates on the span, the rank would understate.

**Verified against the definition, not against another identity.** [r262_gram.py](../scripts/reviewers/r262/r262_gram.py) builds every $\nu(D)$ as an $n^f\times n^f$ integer matrix, flattens it to a row of length $n^{2f}$, and takes the **exact rational rank** of the resulting $ (2f-1)!!\times n^{2f}$ matrix. That is $\dim\mathop{\mathrm{span}}\{\nu(D)\}$ by definition, with no Gram, no loop count and no representation theory.

| $f$ | $n$ | $\mathop{\mathrm{rank}}[n^{\mathrm{loops}}]$, exact $\mathbb Q$ | $\dim\mathop{\mathrm{span}}\{\nu(D)\}$, exact $\mathbb Q$ | $\sum_\lambda m_\lambda(n)^2$ |
|---|---|---|---|---|
| 2 | 1–5 | 1, 3, 3, 3, 3 | 1, 3, 3, 3, 3 | 1, 3, 3, 3, 3 |
| 3 | 1–5 | 1, 10, 15, 15, 15 | 1, 10, 15, 15, 15 | 1, 10, 15, 15, 15 |
| 4 | 1–4 | 1, 35, 91, 105 | 1, 35, 91, 105 | 1, 35, 91, 105 |

**Fourteen cells, three routes, no disagreement.** Evidence: [out_gram.txt](../scripts/reviewers/r262/out_gram.txt).

### (b) `loops` counts cycles correctly

The traversal re-walks a multigraph and falls back to `m[cur][0]` when every neighbour equals the vertex it came from, which is the case that would bite on a double edge ($D=E$ on some pair). I replaced it with an invariant that cannot be mis-walked: for a $2$-regular multigraph the cycle count **is** the number of connected components, which union-find gives with no traversal.

| $f$ | ordered pairs compared | disagreements |
|---|---|---|
| 2 | 9 | **0** |
| 3 | 225 | **0** |
| 4 | 11,025 | **0** |
| 5 | **893,025** | **0** |

And the double-edge case is exercised directly: $\mathrm{loops}(D,D)=f$ for all $3$, $15$, $105$ and $945$ diagrams at $f=2,3,4,5$, which is the fallback branch on every one of the $f$ pairs. Evidence: [out_gram.txt](../scripts/reviewers/r262/out_gram.txt), [out_loops_f5.txt](../scripts/reviewers/r262/out_loops_f5.txt).

### (c) The restricted up–down count is $m_\lambda(n)$, and no doubling is owed

The admissibility rule `admissible` ($\lambda'_1+\lambda'_2\le n$), is the standard labelling of $O(n)$-irreducibles and is applied to **every intermediate shape**, which is what makes the count the multiplicity at finite $n$ rather than the abstract cell-module dimension. Both are right, and the test that decides it is the one the recursion cannot self-confirm: $\sum_\lambda m_\lambda(n)\dim V_\lambda^{O(n)}=n^f$, with $\dim V_\lambda^{O(n)}$ from the El Samra–King hook formula (independently spot-checked: $\lambda=(1)\to n$, $(1,1)\to\binom n2$, $(2)\to\tfrac{n(n+1)}2-1$).

**It holds at all $72$ pairs with $1\le f\le8$, $1\le n\le9$**, including every pair whose label set contains a self-associate $\lambda$ ($(4,4)$, $(6,6)$, $(8,8)$, $(5,2)$, $(7,6)$ and $21$ others), $26$ of the $72$. Had any multiplicity been doubled, or any label missing, the identity would fail by a multiple of that label's dimension. Evidence: [out_mult.txt](../scripts/reviewers/r262/out_mult.txt).

**The brief's doubling is an $SO(n)$ phenomenon and the record's labels are $O(n)$.** At $\lambda'_1=n/2$ the $O(n)$-irreducible is self-associate and stays irreducible; it is its $SO(n)$-restriction that splits, and the record's own $77$-versus-$71$ count at $n=12$ is that split. There is nothing to repair here.

### (d) Two primes are not grounds to read a modular rank as exact

[run_diagram_realisation.py:192–194](../scripts/runs/run_diagram_realisation.py#L192) argues:

> *"a modular rank can only UNDERSTATE the rational one, so agreement between two unrelated primes is what licenses reading it as exact."*

**The premise is true and the conclusion does not follow from it.** $\mathop{\mathrm{rank}}_p\le\mathop{\mathrm{rank}}_{\mathbb Q}$ for every $p$, so $k$ primes agreeing at $v$ establish $\mathop{\mathrm{rank}}_{\mathbb Q}\ge v$ and place **no upper bound at all**. Understatement is precisely why agreement between understating computations cannot certify: two primes both losing the same pivot agree with each other and disagree with $\mathbb Q$. The assertion message in the file says the same thing again (*"neither value can be read as $\dim\nu$"* on disagreement) which is right, but its converse is what the docstring claims.

The numbers are nevertheless correct, and here is what actually certifies them:

| $f$ | $n$ | six primes | exact $\mathbb Q$ | $\sum m_\lambda(n)^2$ |
|---|---|---|---|---|
| 2–4 | 1–6 | all agree, $18$ cells | **agrees at every cell** | agrees |
| 5 | 1–6 | all agree: $1$, $126$, $603$, $903$, $945$, $945$ | not computed ($945\times945$ over $\mathbb Q$) | agrees |

Primes used: $2147483647$, $2147483629$, $1000003$, $999983$, $65537$, $46337$. Evidence: [out_exactrank.txt](../scripts/reviewers/r262/out_exactrank.txt), whose spectral column locates the largest multiplicative gap in the eigenvalues and is **not** a rank, since a full-rank Gram has no gap to find; the two columns that decide are the prime ranks and the exact $\mathbb Q$ rank.

**And the one-sidedness is benign for this particular test**, which is worth saying because it is the reason the check is sound despite the reasoning. The theory supplies the upper bound: $\mathop{\mathrm{rank}}_{\mathbb Q}=\dim\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})=\sum_\lambda m_\lambda(n)^2$. A modular under-report can therefore only make the assert **fire spuriously**, never pass spuriously, unless every prime tried loses exactly the same rank, which is what more primes reduce. The file should say that instead of what it says.

### The reproduction

I ran [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) end to end. It reproduces exactly: the $24$-row table, $\dim\nu=\sum m_\lambda(n)^2$ at every cell, and

> `the cell-module form fails below the threshold at: [(3, 1), (4, 1), (4, 2), (5, 1), (5, 2), (5, 3)]`

**Six sub-threshold failures, as the commit says.** Evidence: [out_repro_reviewed.txt](../scripts/reviewers/r262/out_repro_reviewed.txt).

### One number the application imported that matches nothing

[findings/brauer-pairing.md](../findings/brauer-pairing.md) now says the universal identity *"matches the rank at **all 40 pairs** tested"*. Counting:

| source | grid | pairs |
|---|---|---|
| r259's own evidence, [out_gram_f5.txt](../scripts/reviewers/r259/out_gram_f5.txt) | $f\in\{2,3,4,5\}$, $n\in[1,8]$ | **32** |
| r259's prose | *"every $(f,n)$ with $2\le f\le5$, $1\le n\le8$"*, then *"all 40 pairs"* | **32**, mis-stated as 40 |
| [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) as applied | $f\in\{2,3,4,5\}$, $n\in[1,6]$ | **24** |

**$40$ is nobody's count.** It is r259's arithmetic slip, carried verbatim into the findings file, where it now over-states the evidence base of the record's own headline identity by two-thirds relative to the script that ships with it.

## Claim 5, plan.md's reopened item

| element | check | verdict |
|---|---|---|
| restriction-kernel refutation, $10{,}395\to$ rank $2$, kernel $10{,}393$, at $n=6,7$ | r260 claim 6(a) measured it; attributed to r260 in the plan | **correct** |
| *"the surviving rank 2 is r250's two cubic Weyl invariants with $I_2=I_1/2$"* | r260 states exactly this as a cross-check | **correct** |
| $r=6+\lvert\lambda\rvert/2$, running to $12$; attributed to r259 | r259 claim 1 derives it | **correct** |
| *"at $n=6$ only 77 of 160 labels are admissible, so 83 blocks do not exist"* | r259 claim 1 | **correct** |
| (i) independence on the diagonal, reopened, no literature closes it | both reviewers | **correct** |
| (ii) $71$ seeds, no coefficient bound, $23!!$ spanning set, attributed to r260 | r260 claim 4 | **correct** |
| $23!!=3.16\times10^{11}$ | $23!!=316{,}234{,}143{,}225=3.162\times10^{11}$ | **correct** |
| $184\to71$ | [sym3-stability.md:5](../findings/sym3-stability.md): $71$ blocks, $184$ multiplicities at $n\ge12$ | **correct as qualified** |
| (iii) $\det\mathrm{Gram}_S$ global; the syzygy; $92\to89$; uniformity lemma or A5's Sturm list | [r242:34,36,135](REVIEW_r242.md) verbatim | **correct** |
| (iii) *"r244 prices it at order $\sim89$ with entries of degree $\le6$"* | see below | **MISATTRIBUTED** |

### Is $184\to71$ the right description?

**Yes, for the task the item names, and the plan states the residue correctly.** The theorem replaces *"exhibit each of the $184$ covariants over diagrams"* with *"exhibit one seed per block over diagrams"*, and there are $71$ blocks, so $71$ objects must be written down instead of $184$. It does **not** hand back the $184$: recovering a specific covariant means finding its coefficients inside $\{e\,\nu(D)c_0\}$, a family of $23!!$ elements with no bound on how many are needed. The plan says exactly that (*"a structure theorem, not yet an algorithm"*) so the phrase is not overselling. The blocks of multiplicity $1$ are where the reduction buys nothing, and $184-71=113$ is the honest saving.

### The r244 misattribution

r244's pricing sentence is about a different determinant:

> [r244](REVIEW_r244.md), R-owed: *"state the hypothesis as root-freeness of the **chosen** `xi(n)` on `[12, infinity)`; name `B_p` as the basic solution at that pivot set … `xi(n)` is a determinant of an r x r matrix with r of order 89 and entries of degree <= 6."*

$\xi(n)$ is the **pivot minor of A2′'s constraint solve**. $\det\mathrm{Gram}_S$ is the Gram determinant of the chosen independent covariant subset in A2, a different matrix, from a different step, first exhibited by r242 as a $3\times3$ Gram with $\det\mathrm{Gram}_S(n)=343n(n-1)(869n-2767)/24$. r244 says nothing about it.

r260 was careful about this: *"[r244](REVIEW_r244.md) prices the **same shape** of obligation"*. [plan.md](../plan.md) (iii) reads *"r244 prices **it**"*, the hedge is gone and the pronoun points at $\det\mathrm{Gram}_S$. The order and degree may well transfer (A2″ speaks of $89$ constraint functionals separating), but **that is a conjecture the plan attributes to a reviewer who did not make it.**

## Claim 6, the reference-note corrections

### Both corrections verified against the primary source

I downloaded [arXiv:1507.07676](https://arxiv.org/abs/1507.07676) and read §7.

> **Theorem 7.1.** (Semisimplicity criterion for the Brauer algebra) $B_d(\delta)$ is semisimple if and only if one of the following conditions hold: … (3) $\delta_0\ne0$, $\mathrm{char}(K)=0$ and $d\le\delta_0+1$. … (5) $\delta_0=0$, $\mathrm{char}(K)=0$ and $d\in\{1,3,5\}$. …

> **Conventions 3.11.** … By convention, $\delta\in\mathbb Z$ and $\delta_0=\lvert\delta\rvert$ if $\mathrm{char}(K)=0$.

**The $\delta=-2n$ correction is right.** $\delta_0=\lvert-2n\rvert=2n$, so 7.1(3) reads $d\le2n+1$, i.e. $f\le2n+1$, verbatim what [notes.md:17](../references/rui-brauer-semisimplicity/notes.md) now says. The old sentence *"same statement holds for $\delta=-2n$"* was indeed false, and understated the symplectic bound by a factor of two.

**The $\delta=0$ correction is right, and its exclusivity is worth stating.** In characteristic zero conditions (1), (2), (4) and (6) are all unavailable (they require $\mathrm{char}(K)=p>2$ or $=2$) so for $\mathrm{char}(K)=0$ the theorem reduces to *"(3) or (5)"*, and at $\delta_0=0$ only (5) survives: $B_d(0)$ semisimple exactly for $d\in\{1,3,5\}$. That is exactly what [notes.md:18](../references/rui-brauer-semisimplicity/notes.md) now says, and it is the clause both reviewers rediscovered from their own trace forms.

**The note's own reproduction figure is right too.** *"Both directions at all 32 pairs with $f\le5$, $n\ge1$"*, r259's grid is $f\in\{2,3,4,5\}\times n\in[1,8]$, which is $32$. (Contrast claim 4: the *other* number the same cycle imported from r259, "40 pairs", is wrong. The application copied one count correctly and one incorrectly from the same review.)

### The Lehrer–Zhang comparison: the number is right, the sentence is not

**$n\ge12$ is correct.** Theorem 3.4 as quoted in [lehrer-zhang notes:29](../references/lehrer-zhang-sft-orthogonal/notes.md): *"If $r\le n$ the map $\nu:B_r(n)\to\mathop{\mathrm{End}}_{O(V)}(V^{\otimes r})$ is an isomorphism. If $r\ge n+1$, $\ker(\nu)$ is generated as an ideal by $E$."* At $r=12$ that is injectivity iff $n\ge12$. It is independently supported by ASWT's type-$D_m$ line (*injective if $n\ge d$*) and by r259's direct count at $f=12$, where $\sum_{\text{all }\lambda}(\dim\Delta_\lambda)^2=23!!$ first at $n=12$ and falls short by $208{,}012$ at $n=11$.

**"Tighter than Rui's" is where a second category error enters.** [notes.md:28](../references/rui-brauer-semisimplicity/notes.md) reads, as one sentence:

> *"This is a **different** threshold from Lehrer–Zhang Theorem 3.4, and the two govern different objects, so **neither ranking nor a shared 'slack' scale is meaningful**. Applied to $B_{12}(n)$ … Lehrer–Zhang gives injectivity of $\nu$ only for $n\ge12$, which is **tighter** than Rui's $n\ge11$ and has zero slack at $n=12$."*

The first clause denies a shared scale; the second clause uses one. Both cannot stand.

**Which is right, precisely.** The correction did fix something real, the old table ranked Rui's $f=12$ constraint against Lehrer–Zhang at $r=6$, two different algebras, and that comparison was meaningless. The new pairing is better: both are now conditions on $n$ for statements about the same algebra $B_{12}(n)$, so $\{n\ge12\}\subset\{n\ge11\}$ is a genuine inclusion and "tighter" has a referent. **But they are conditions for different properties** (semisimplicity of the abstract algebra against injectivity of its representation) and calling one tighter still invites the reading the correction was written to remove: that one of them binds. Neither does. Both reviewers established that the theorem consumes *neither*, and [brauer-pairing.md](../findings/brauer-pairing.md) says so two lines above its own table. Ranking two decorations reintroduces the frame.

**The honest form is the one the record almost has**: two rows, each with what it governs and what it reads at $n=12$, and a sentence saying the theorem uses neither. That table exists in [brauer-pairing.md](../findings/brauer-pairing.md); what should go is the word *tighter* and the bolded *zero slack*, which is a slack column by another name.

---

## Verdict

**The application is largely faithful, and it has one hole in each direction.**

**It undershot in the scripts.** [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) was rewritten by the last commit of this cycle and still carries three refuted sentences in its docstring: *"Independence is settled (Lehrer-Zhang 3.4, r <= n)"*, which `ae44228` reopened forty-five minutes earlier; *"e itself to be a diagram element"*, which r259 corrected; and *"the SURJECTIVITY half of the SFT"*, which r260 corrected. All three were applied to [findings/brauer-pairing.md](../findings/brauer-pairing.md) and none to the file that shares the theorem's name.

**It overshot in the deletion.** [run_b_dependency_audit.py](../scripts/runs/run_b_dependency_audit.py) deserved deleting (every assert in it is constant-folded) but its one confirmed conclusion went with it, and so did the item's deliverable sentence. [plan.md](../plan.md) section 2 item 1 no longer says what it must produce.

**It misattributed twice, once from each reviewer.** "$40$ pairs" is r259's arithmetic slip repeated as fact; "r244 prices it" attaches to $\det\mathrm{Gram}_S$ a pricing r244 gave for a different determinant, dropping r260's *"same shape of"*.

**And it inherited a citation that fails at $n=12$.** The record now rests the FFT half (the only load-bearing hypothesis of the unconditionality claim), on ASWT Theorem 3.17(b), which grants surjectivity in type $B_m$ ($n$ odd) and denies it in type $D_m$ ($n$ even), the type the route is in. The claim is true for $O(n)$ by Brauer's own theorem; the pointer is to a theorem about $SO(n)$, in a record whose $92\to89$ and $77\to71$ counts exist precisely because the two differ.

**What holds up.** The theorem is right and every part of step (iii) is right, including the "exactly" and including the seed the projector annihilates, which I exhibited at four dimensions with a projector of the route's own shape. The new verification is right in all three of its mathematical parts, reproduced here from the definition and by a loop counter that cannot mis-walk; both reference-note corrections are verbatim correct against the primary source; and the plan's reopened item states the refutation, the count and the three obligations faithfully.

**What to change.**

1. Fix [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py)'s docstring, three sentences, all already corrected elsewhere in the same cycle.
2. Restore the audit's conclusion (c) and the item's deliverable to [plan.md](../plan.md) item 1: the $71$ seeds must be exhibited **over Brauer diagrams**, that is a fact about the construction, and A3 consumes the objects rather than the theorem.
3. Cite Brauer 1937 for surjectivity onto $\mathop{\mathrm{End}}_{O(n)}$, and note that ASWT 3.17(b) is a statement about $\mathfrak{so}_{2m}$ whose type-$D$ line carries no surjection.
4. Replace "$40$ pairs" with $32$, or with $24$ if the script is meant to be the evidence.
5. Restore r260's *"the same shape of obligation"* to (iii), or price $\det\mathrm{Gram}_S$ directly.
6. Drop *tighter* and *zero slack* from [rui notes:28](../references/rui-brauer-semisimplicity/notes.md); the sentence contradicts its own first clause, and neither threshold is consumed.
