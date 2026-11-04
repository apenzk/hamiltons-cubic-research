# REVIEW r265, Gate 2, restitution and the 10,393 kernel

Reviewer 265. Commits under review: `d46cda0` (primary), `26833c0`, `ef6ed9e`.
Primary files: [run_restitution_kernel.py](../scripts/runs/run_restitution_kernel.py), [references/weyl-polarization-primer/notes.md](../references/weyl-polarization-primer/notes.md), [plan.md](../plan.md) section 2 item 1. Constraining prior reviews: [r259](REVIEW_r259.md), [r260](REVIEW_r260.md), [r261](REVIEW_r261.md), [r262](REVIEW_r262.md), [r263](REVIEW_r263.md), [r264](REVIEW_r264.md).
Scripts: [scripts/reviewers/r265/](../scripts/reviewers/r265/). Reviewer 266 runs the identical brief concurrently and independently; I read none of its files.

**The tree moved while this review was being written.** Everything below is a verdict on the three commits **as they stand at `26833c0`**. Between my sweep and this filing, `bc593d4` retracted the primary claim and rewrote the search gate. Where the repair has already reached a finding I arrived at independently, the section says so, and Claim 5 reports the gate in **both** states so that the verdict on the commit is separable from the verdict on the repair.

Nothing below shares a line with the reviewed script or with [r260](REVIEW_r260.md)'s. The nine cells are re-ranked over $\mathbb F_p$ at two primes on **integer** evaluation points, and then settled again with **no evaluation at all**. The Weyl tensors are built by an explicit Bianchi projector plus a closed-form trace removal solved from $\mathrm{Ric}(\mathrm{KN}(S,g))=\mathop{\mathrm{tr}}(S)\,g+(n-2)S$, and verified on all four symmetries and against $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ before use. Every diagram is one batched `einsum` over all samples at once. The dimension of the symmetric part is computed **combinatorially**, by Burnside, with no tensor in it. Theorem I.2.1 and Remarks I.2.2, I.2.4 and Theorem I.2.7 are read out of [paper.pdf](https://arxiv.org/abs/2606.24023) itself.

| # | Claim | Verdict |
|---|---|---|
| 1 | Does polarization say what the record now claims? | **THE SOURCE IS QUOTED FAITHFULLY AND THE INFERENCE IS REFUTED, IN TWO INDEPENDENT ACCOUNTINGS.** Remark I.2.2 reads verbatim *"It agrees with $F$ if and only if $F$ is already symmetric. Hence the linear map $(\mathcal P_d\circ\mathcal R_d)$ is a projection on the subspace of symmetric multilinear forms"*, and $\ker\mathcal R_d=\ker(\mathcal P_d\mathcal R_d)$ since $\mathcal P_d$ is injective, the abstract statement is right. **The measured map is $\rho\circ\mathcal R_3$ and Weyl governs one factor.** Restituting first: the $S_3$-symmetric part of the $10{,}395$ has dimension **$1{,}779$** (Burnside, exact) and restricts to rank $2$, so **$1{,}777$ SYMMETRIC dimensions die**, which *"nothing a symmetric functional could have seen is lost"* forbids. Restricting first: the invariant trilinear forms on **three independent** Weyl tensors already have dimension $\mathbf2$ at $n=6,7$ and at $n=12$, so restitution accounts for **$0$ of the $10{,}393$**. Exhibited whole one degree down: $105$ matchings, symmetric part $\mathbf{65}$, generic $4$-tensor $\mathbf{65}$ (Weyl confirmed to the digit), Weyl tensor $\mathbf1$ |
| 2 | The numerical identification | **THE NUMBER IS RIGHT, THE REASON IS WRONG, AND THE CITATION NAMES THE REGIME WHERE IT IS $1$.** Measured independently: $\dim\mathrm{Sym}^3(\mathcal W_n)^{O(n)}=1,1,2,2,2,2$ at $n=4,5,6,7,8,12$, so $2$ is the invariant dimension for $n\ge6$ and it **is** the degree-3 entry of the record's own $1,2,7,19,89$. It is $2$ because the $\gamma_D$ **span** the invariants at every $n$ (the FFT), not because restitution is injective. And *"r250's $I_1,I_2$ with $I_2=I_1/2$"* cites the **degenerate** case: $I_2=I_1/2$ is r250's finding at $n=4,5$, exactly where I measure rank $\mathbf1$; at $n\ge6$, where the $2$ lives, r250 reports them **independent**. r260's sentence carried the qualifier (*"with $I_2=I_1/2$ **resolved**, independent from $n\ge6$"*) and [plan.md](../plan.md), the notes and the commit body all dropped it |
| 3 | The verification script | **ASSERT 2 IS ASSERT 1 WITH `total` ADDED TO BOTH SIDES, AND ASSERT 1 IS THE DEFINITION OF $\binom{V+d-1}{d}$.** All nine cells reproduce exactly over $\mathbb F_p$ at two primes on integer points, and are reached again with **no evaluation at all**: restituting $e^*_{i_1\dots i_d}$ gives the **monomial** $x_{i_1}\cdots x_{i_d}$, so the image is spanned by monomials and its dimension is the number of **distinct** ones. The point count and `tol=1e-8` are adequate and beside the point; neither assert ever looks at $\ker\mathcal R_d$ **as a subspace**. Run on the case the record cares about (a subspace $S\subset V\otimes V$ with symmetries), the rank is $\dim\mathrm{Sym}^3(S^*)$ at **every** cell, never $\dim\mathrm{Sym}^3(U^*)$, so the kernel exceeds the non-symmetric complement by $130$ at $n=3$ symmetric traceless and $2{,}365$ at $n=5$. **The script's slogan fails at the first tensor it is applied to** |
| 4 | What the record now claims is open | **NOTHING TRUE WAS DROPPED, and the new obligation is the OLD measurement with the SAME answer, while [plan.md](../plan.md) item 1 now asserts and denies one sentence seventeen lines apart.** `d46cda0` is $+4/-1$ and the deleted paragraph **reappears intact** three paragraphs down, so there is no `ae44228` repeat. But *"independence must be asked of the **symmetrised** functionals"* is not a different question: $W\otimes W\otimes W$ is already $S_3$-fixed, so $\gamma_D$ and $\sigma\cdot\gamma_D$ take the same value there (spread within an orbit $\le1.5\times10^{-10}$), and the $1{,}779$ orbit sums have rank $\mathbf2$, the same $2$. Obligation (i) was **not edited** and still reads *"the restriction kernel is the whole difficulty"* under a paragraph headed *"the $10{,}393$ is not the difficulty"*. **The decidable form is sharp and is elsewhere**: $2=m_\varnothing$ exactly, read from the record's own [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl), so the measurement probes **$2$ of $184$ multiplicities and finds NO loss at them**; the $\gamma_D$ are invariants and cannot reach the other $70$ blocks at all |
| 5 | The skill and hook change | **`_opens_an_item` DOES NOT DO WHAT ITS DOCSTRING SAYS, AND SIX ROUTES WALK PAST IT, ONE OF THEM TAKEN BY THE PREVIOUS CYCLE.** The docstring says *"its subject says an item **opened**"*; the regex is the four re-forms only, so *"the covariant item is OPENED again"*, *"restore the deliverable"* and *"obligation (ii) is not closed"* all pass. **The record's witness is `90ad8d9`**, `fix(plan):`, plan.md staged, body *"Both are restored, as obligation (ii)"*, reopening an obligation without the word. *"Subject"* is `command.split("\n")[0]`, **line 1 of the bash command**: under a heredoc that line is `… -m "$(cat <<'EOF'` and the gate is silent while the `Deliverable` gate, reading the whole string, fires, **the two gates disagree about what commit they are looking at**. Also bypassed by `-a`, by staging plan.md separately, and by typing `docs(plan):`. `Searched:[ \t]*(\S.*)` matches **prose**: *"We never Searched: anything"* passes, `Searched: .` passes, and an `echo` earlier in the shell line passes. *`bc593d4` closes three of these, the `docs(` bypass, the substring `plan.md`, and the loose trailer, and leaves the line-1 subject, `-a`, the split commit, and a bare `Searched: none`, which still passes because the shell's closing quote counts as its reason* |
| 6 | Anything from r259–r264 still unapplied | **FOUR STAND. The Frobenius one has now been named by FOUR reviewers and applied by none.** *(1)* The Gram identity's reason, $n^{\mathrm{loops}}$ is the **Frobenius** pairing of $\nu(D),\nu(E)$ and that form is **positive definite** (r261 rec 6, r262 claim 4(a), r263 6(ii), r264 6(2)): **zero** occurrences of either word in [brauer-pairing.md](../findings/brauer-pairing.md) or either script. *(2)* [plan.md:55](../plan.md)'s *"A3 cannot start without it"*, untouched. *(3)* [brauer-pairing.md:79](../findings/brauer-pairing.md)'s $f=12$ row, asserted with no committed run. *(4)* **New, and it is r260 claim 5 applied to the script but not the file**: [brauer-pairing.md:73](../findings/brauer-pairing.md) still says $\dim\nu$ is what *"**semisimplicity** plus the double centraliser forces"* to equal $\sum(\dim\Delta_\lambda)^2$, the identity holds at every $n$ by the double centraliser alone, and the same file says *"The inequality never enters"* fifteen lines above |

---

## Claim 1, does polarization say what the record now claims?

Evidence: [out_c1_pdf.txt](../scripts/reviewers/r265/out_c1_pdf.txt), [c1_symmetric_part.py](../scripts/reviewers/r265/c1_symmetric_part.py), [c1b_three_slots.py](../scripts/reviewers/r265/c1b_three_slots.py) / [out_c1b_three_slots.txt](../scripts/reviewers/r265/out_c1b_three_slots.txt), [c2_weyl_rank.py](../scripts/reviewers/r265/c2_weyl_rank.py) / [out_c2_weyl_rank.txt](../scripts/reviewers/r265/out_c2_weyl_rank.txt), [c4_symmetrised.py](../scripts/reviewers/r265/c4_symmetrised.py) / [out_c4_symmetrised.txt](../scripts/reviewers/r265/out_c4_symmetrised.txt).

### The source, read from the PDF

The three citations are faithful. Decompressing the streams of [paper.pdf](https://arxiv.org/abs/2606.24023) gives, verbatim, the embedded font maps the glyph `d` to `3`, so every `3` below is the paper's `d`:

> **Theorem I.2.1.** Every homogeneous polynomial $f(v)\in\mathbb R[V]$ of degree $d$ can be **uniquely** associated to a symmetric multilinear form $\mathcal P_d(f)(v_1,\dots,v_d)\in\mathrm{Sym}^d(V^*)$ … Moreover, the original polynomial $f$ is recovered from $\mathcal P_d(f)$ by evaluating it on the diagonal.

> **Remark I.2.2.** … The process $F\mapsto\mathcal R_d(F)$ is called the **restitution**. Therefore, for any $F$, after polarization, $\mathcal P_d(\mathcal R_d(F))$ is again a multilinear form on $V^d$, but which is symmetric. **It agrees with $F$ if and only if $F$ is already symmetric. Hence the linear map $(\mathcal P_d\circ\mathcal R_d)$ is a projection on the subspace of symmetric multilinear forms.**

> **Remark I.2.4.** Since we use the diagonal action of the group $G$ on the vector space $V^d$, the polarization process $\mathcal P_d$, the restitution process $\mathcal R_d$, and the projector $(\mathcal P_d\circ\mathcal R_d)$ all commute with the action of $G$.

Theorem I.2.7 is the multi-degree version over several representations, as the notes say. **The record's reading of the source is accurate**, and the step the notes add on their own (*"$\ker\mathcal R$ is precisely the complement of the symmetric multilinear forms"*), is correct too: Theorem I.2.1 makes $\mathcal P_d$ injective, so $\ker\mathcal R_d=\ker(\mathcal P_d\circ\mathcal R_d)$, and the kernel of a projection is a complement of its image.

**Claim 1's literature half survives.** What fails is the next step.

### The step that fails: the slots are not vectors

The theorem is about $\mathcal R_d$ on multilinear forms on $V^d$ for **one** space $V$, with $v\mapsto(v,\dots,v)$ the diagonal of that same space. r260's map is not that map. Two readings are available and both break:

- **Take $V:=\mathcal W_n$.** The theorem applies as stated, but the $\gamma_D$ are **not** multilinear forms on $\mathcal W_n^3$. They are multilinear forms on $(V^{\otimes4})^3$, and reaching $\mathcal W_n^3$ from there is a **restriction of the domain**, which the theorem never mentions.
- **Take $V:=V^{\otimes4}$.** The $\gamma_D$ are genuinely multilinear, the theorem applies, and $\mathcal R_3$ lands in degree-3 polynomials on $V^{\otimes4}$, where the rank is **not** $2$. Getting to a function of a Weyl tensor needs one more map: restriction of a polynomial from $V^{\otimes4}$ to $\mathcal W_n\subsetneq V^{\otimes4}$.

Either way the measured operator is a composite of restitution with a domain restriction, and Remark I.2.2 governs one factor. **A Weyl tensor is not a generic element of $V^{\otimes4}$, and no polarization statement crosses that gap.**

### Accounting A, restitute first: $1{,}777$ symmetric dimensions die

The symmetric part is combinatorial here and needs no numerics. The $10{,}395$ $\gamma_D$ are a basis of the $O(n)$-invariant functionals on $V^{\otimes12}$ for $n\ge12$ (Lehrer–Zhang 3.4, the record's own citation); $S_3$ permutes the three four-leg blocks and hence **permutes that basis**; so the $S_3$-invariant subspace is spanned by orbit sums and its dimension is the **number of orbits**. Burnside:

| legs / blocks | perfect matchings | fixed points over $S_3$ | orbits $=\dim$ symmetric part |
|---|---|---|---|
| $6$, three blocks of $2$ | $15$ | $15,3,3,3,3,3$ | $\mathbf5$ |
| $12$, three blocks of $4$ | $10{,}395$ | $10{,}395,75,75,27,27,75$ | $\mathbf{1779}$ |

If restitution were the only kernel (*"nothing a symmetric functional could have seen is lost"*), the rank after restriction would be $1{,}779$. **It is $2$, so $1{,}777$ dimensions of the symmetric part are lost**, and Remark I.2.2 says nothing about any of them. The split of the $10{,}393$ under this order is $8{,}616$ non-symmetric, which restitution explains, and $1{,}777$ symmetric, which it does not.

### Accounting B, restrict first: restitution explains none of it

The same composite, taken in the other order. Evaluating the $10{,}395$ at **three independent** Weyl tensors $A,B,C$ measures the dimension after the domain restriction and before restitution:

| $n$ | rank at three independent Weyl tensors | rank on the diagonal $W^{\otimes3}$ | domain restriction costs | restitution costs |
|---|---|---|---|---|
| $6$ | $\mathbf2$ | $2$ | $\mathbf{10{,}393}$ | $\mathbf0$ |
| $7$ | $\mathbf2$ | $2$ | $\mathbf{10{,}393}$ | $\mathbf0$ |
| $12$ | $\mathbf2$ | $2$ | $\mathbf{10{,}393}$ | $\mathbf0$ |

**The invariant trilinear forms on three independent Weyl slots are already two-dimensional, hence already $S_3$-symmetric**, so the non-symmetric complement at that stage is zero-dimensional and restitution has nothing left to remove. On this accounting the entire $10{,}393$ is the passage from $V^{\otimes4}$ to $\mathcal W_n$ (the antisymmetries, the pair symmetry, the first Bianchi identity and tracelessness) and Remark I.2.2 accounts for **none** of it.

**The two accountings are the same refutation seen from either end**, and B is the sharper one. A is the one that contradicts the record's own words in its own units: the claim *"nothing symmetric is lost"* is false by $1{,}777$.

### The whole chain, exhibited one degree down

At degree $2$ every number is computable, so the failure is shown rather than inferred. Eight legs, two blocks of four; the $105$ matchings are a basis of the invariants for $n\ge4$:

| $n$ | matchings | $\dim$ symmetric part (orbits) | rank on a **generic** $4$-tensor | rank on a **Weyl** tensor |
|---|---|---|---|---|
| $6$ | $105$ | $65$ | $\mathbf{65}$ | $\mathbf1$ |
| $7$ | $105$ | $65$ | $\mathbf{65}$ | $\mathbf1$ |
| $12$ | $105$ | $65$ | $\mathbf{65}$ | $\mathbf1$ |

**The middle column confirms Weyl's theorem to the digit**, restitution loses exactly the non-symmetric part, $105-65=40$ dimensions, and not one more. **The last column is the record's error**: $64$ further dimensions gone, every one symmetric, all of it caused by $\mathcal W_n$ being a proper subspace of $V^{\otimes4}$ and none by restitution.

At degree $3$ the same contrast is sample-limited rather than closed, and it is already decisive: the $10{,}395$ restituted to a **generic** $4$-tensor have rank $\ge130$ at $n=6$ and at $n=12$ (the run's sample count, so a lower bound, against a ceiling of $1{,}779$) while on a Weyl tensor the rank is $2$.

*`bc593d4`, filed after my sweep, retracts the claim on accounting B and states the composite the same way.*

## Claim 2, the numerical identification

Evidence: [c2_weyl_rank.py](../scripts/reviewers/r265/c2_weyl_rank.py) / [out_c2_weyl_rank.txt](../scripts/reviewers/r265/out_c2_weyl_rank.txt).

**The Weyl tensors are checked before they are used.** All four symmetries to $\le2.7\times10^{-15}$ and traceless to $\le1.2\times10^{-14}$, with $\dim\mathrm{span}$ of $200$ samples equal to $n(n+1)(n+2)(n-3)/12$ at $n=6$ ($84$) and $n=7$ ($168$). The $n=12$ row of that particular check is sample-limited, $200<1638$, and is evidence for nothing.

**The dimension itself**, as the rank of the $10{,}395$ complete contractions of $W\otimes W\otimes W$, a **spanning** set of the degree-3 invariants at every $n$ by the FFT, whether or not they are a basis:

| $n$ | $4$ | $5$ | $6$ | $7$ | $8$ | $12$ |
|---|---|---|---|---|---|---|
| $\dim\mathrm{Sym}^3(\mathcal W_n)^{O(n)}$ | $1$ | $1$ | $\mathbf2$ | $\mathbf2$ | $\mathbf2$ | $\mathbf2$ |

**So the two twos are the same two.** The stable-range sequence the record carries is $1,2,7,19,89$ for degrees $2$ through $6$ ([sym3-blocks.md](../findings/sym3-blocks.md), audited at [r177](REVIEW_r177.md)), whose degree-3 entry is $2$; its degree-2 entry $1$ is the Weyl column of Claim 1's degree-2 table; and the $n=5$ collapse to $1$ is the record's own Lovelock degeneracy, *"degree $3$ being $1$"* in the same file. Three independent agreements. **The identification in the commit and in [plan.md](../plan.md) is correct**, this is the one part of `d46cda0`'s new material that survives.

**Its stated reason is not.** The rank is $2$ because the $\gamma_D$ span the invariants on $V^{\otimes12}$ at every $n$, so their restrictions span the degree-3 invariants of $W$: a spanning set pushed along a map onto the target spans the target. Injectivity of restitution on the symmetric part is neither used nor available (Claim 1). The correct one-line reason is the FFT, which the record already has and cites elsewhere.

**And the citation attached to it points at the regime where the answer is $1$.** *"r250's $I_1,I_2$ with $I_2=I_1/2$"* appears in the commit body, in [notes.md](../references/weyl-polarization-primer/notes.md) and in [plan.md](../plan.md). [r250](REVIEW_r250.md)'s row reads: *"independent at $n=6,7$; at $n=4,5$ **$I_2=I_1/2$ identically**"*. The relation **is** the dependence, holding exactly where I measure rank $\mathbf1$; the $2$ requires the independence, which holds exactly where the relation fails. [r260](REVIEW_r260.md) wrote it with the qualifier that makes it true (*"with $I_2=I_1/2$ **resolved**, independent from $n\ge6$"*) and all three downstream copies dropped it. As written, the sentence offers the degeneracy as evidence for the non-degenerate count. *(The record also carries [r140](REVIEW_r140.md)'s form of the same degeneracy as $I_2=2I_1$ at $n=5$, a normalisation difference, unremarked.)*

## Claim 3, the verification script

Evidence: [c3_restitution_exact.py](../scripts/reviewers/r265/c3_restitution_exact.py).

### The nine cells reproduce, twice

Exact ranks over $\mathbb F_p$ at $p=2^{31}-1$ and $p=2147483629$, on integer evaluation points, agree with the reviewed script at all nine cells: $3,4,5\,/\,6,10,15\,/\,10,20,35$. **The float rank and `tol=1e-8` were adequate here** and the point count is more than sufficient, but neither question is the interesting one, because the rank can be had with no evaluation at all.

**The restitution of the basis functional $e^*_{i_1\dots i_d}$ is the monomial $x_{i_1}\cdots x_{i_d}$.** So the image of $\mathcal R_d$ on the full multilinear space is spanned by monomials, its dimension is the number of **distinct** ones, and the number of distinct degree-$d$ monomials in $V$ variables is $\binom{V+d-1}{d}$ by counting multisets. My `#distinct monomials` column equals the rank column at all nine cells because it **is** the rank column. `assert r == sd` restates the definition of $\binom{V+d-1}{d}$; Theorem I.2.1 and Remark I.2.2, which the assert message invokes, predict no entry of the table that counting does not.

### The second assert

`assert total - r == total - sd` adds `total` to both sides of `assert r == sd`. It holds at exactly the cells where the first holds, at all nine, and it cannot do otherwise. What the sentence beside it claims (*"the kernel is the non-symmetric complement"*), is a statement about a **subspace**; the assert compares two **integers** and constructs neither space. `total - r` is rank–nullity and `total - sd` is arithmetic; their agreement is not an identification.

### The case the record cares about

Now let $U=V\otimes V$, let $S\subseteq U$ be a subspace with symmetries, and restitute all multilinear functionals on $U^3$ to $T\otimes T\otimes T$ with $T\in S$. Exact ranks over $\mathbb F_p$:

| $n$ | $S$ | $\dim S$ | multilinear on $U^3$ | rank | $\dim\mathrm{Sym}^3(S^*)$ | $\dim\mathrm{Sym}^3(U^*)$ |
|---|---|---|---|---|---|---|
| $2$ | all | $4$ | $64$ | $20$ | $20$ | $20$ |
| $2$ | symmetric | $3$ | $64$ | $10$ | $10$ | $20$ |
| $2$ | symmetric traceless | $2$ | $64$ | $4$ | $4$ | $20$ |
| $2$ | antisymmetric | $1$ | $64$ | $1$ | $1$ | $20$ |
| $3$ | all | $9$ | $729$ | $165$ | $165$ | $165$ |
| $3$ | symmetric | $6$ | $729$ | $56$ | $56$ | $165$ |
| $3$ | symmetric traceless | $5$ | $729$ | $35$ | $35$ | $165$ |
| $3$ | antisymmetric | $3$ | $729$ | $10$ | $10$ | $165$ |

**The rank is $\dim\mathrm{Sym}^3(S^*)$ at every cell, never $\dim\mathrm{Sym}^3(U^*)$**, restriction of multilinear forms from $U^3$ to $S^3$ is onto, so the image is all of $\mathrm{Poly}_3(S)$. The kernel therefore has dimension $\text{total}-\dim\mathrm{Sym}^3(S^*)$, while the non-symmetric complement has dimension $\text{total}-\dim\mathrm{Sym}^3(U^*)$, **strictly smaller at every proper $S$**. The gap is symmetric functionals that restitution sends to zero on $S$:

| $n$ | symmetric | symmetric traceless | antisymmetric |
|---|---|---|---|
| $3$ | $109$ | $130$ | $155$ |
| $4$ | $596$ | $651$ | $760$ |
| $5$ | $2245$ | $2365$ | $2705$ |

The reviewed script asserts *"the kernel is the non-symmetric complement"* at nine cells where $S=U$, the only case in which it is true, and the record then applies the conclusion where $S\subsetneq U$. **The generalisation the record needs is the one the script does not run, and it fails.**

## Claim 4, what the record now claims is open

Evidence: the `d46cda0` diff on [plan.md](../plan.md), [c4_symmetrised.py](../scripts/reviewers/r265/c4_symmetrised.py) / [out_c4_symmetrised.txt](../scripts/reviewers/r265/out_c4_symmetrised.txt), [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl).

### Nothing true was dropped, this is not `ae44228` again

`d46cda0` is $+4/-1$ on [plan.md](../plan.md). The single removed line, the *"THEOREM 3.4 DOES NOT SUPPLY THE HYPOTHESIS"* paragraph, **reappears word for word** three paragraphs later under the heading *"THEOREM 3.4 STILL DOES NOT SUPPLY THE HYPOTHESIS"*, with r260's witness, the $10{,}393$, the $r=6$ correction and the $n=6$ admissibility count all intact. Obligations (ii) and (iii) are untouched. **The deletion the brief warns about did not recur.**

### But the item now contradicts itself

The retention is what creates the problem. [plan.md](../plan.md) item 1 now contains, in this order:

1. *"$\ker\mathcal R_d$ is exactly the non-symmetric complement … **Hence the $10{,}393$ is not the difficulty**"*
2. *"restriction is a linear map with a kernel … **A basis on twelve free legs says nothing** once the three slots are filled with the same $W$"*
3. obligation (i): *"reopened, and no literature closes it. **The restriction kernel is the whole difficulty.**"*

(1) and (3) are direct negations of each other, seventeen lines apart in one item. **The brief's premise that obligation (i) was rewritten does not match the tree**: obligation (i) was not edited by `d46cda0` at all, the *"symmetrised functionals"* sentence lives in the new second paragraph, and the old obligation was left standing beneath it. So one vague obligation was not swapped for another, a **second, incompatible** one was written above it.

### The new obligation has the answer the old one already had

*"Independence must be asked of the symmetrised functionals, and on those restriction loses nothing."* This is not a different measurement, for a one-line reason: **$W\otimes W\otimes W$ is $S_3$-fixed**, so $\gamma_D$ and $\sigma\cdot\gamma_D$ take the same value at it, and symmetrisation acts on the restricted family as multiplication by the orbit size. Measured:

| $n$ | rank of the $10{,}395$ $\gamma_D$ at $W^{\otimes3}$ | rank of the $1{,}779$ **symmetrised** functionals | max spread within an orbit |
|---|---|---|---|
| $6$ | $2$ | $\mathbf2$ | $1.1\times10^{-10}$ |
| $7$ | $2$ | $\mathbf2$ | $1.5\times10^{-10}$ |

At degree $2$, on a generic $4$-tensor and on a Weyl tensor alike, symmetrising moves neither number ($65\to65$, $1\to1$). **The question is well posed, it is decidable, and it is already decided, with the answer that was there before.** What changed is the label on it.

### What would settle it, and it is sharp

Read the record's own block table. [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) gives $m_\varnothing=\mathbf2$ at the trivial weight $(0^6)$, out of $184$ multiplicities over $71$ $O(12)$ blocks. **So rank $2$ is not a collapse at all, it lands exactly on the multiplicity of the block being probed.** The $\gamma_D$ are $O(n)$-**invariants**: they see the $\lambda=\varnothing$ block and nothing else, and at that block restriction is **surjective onto the whole multiplicity space and loses nothing**. That is the true content of r260's measurement, and neither the old framing (*"the kernel is the whole difficulty"*) nor the new one (*"restitution explains the kernel"*) states it.

**The decidable form of obligation (i) is therefore per block, and it is a finite rank question**: for each of the $71$ blocks $\lambda$, whether the $m_\lambda$ constructed covariants $V_\lambda\to\mathrm{Sym}^3\mathcal W_n$ restrict to $m_\lambda$ **independent functions of one $W$**, equivalently whether the evaluation map on $\mathrm{Hom}_{O(n)}(V_\lambda,\mathrm{Sym}^3\mathcal W_n)$ is injective, block by block. **Two of the $184$ are now settled affirmatively.** The remaining $182$ are unreachable by any computation on the $\gamma_D$, symmetrised or not, and that (not the $10{,}393$), is the size of what is open.

## Claim 5, the skill and hook change

Evidence: [c5_hook.py](../scripts/reviewers/r265/c5_hook.py) / [out_c5_hook.txt](../scripts/reviewers/r265/out_c5_hook.txt). Both versions of the hook are **imported and exercised**, never edited: the one committed at `26833c0` and the one now on disk after `bc593d4`. `git diff --cached` is answered by a scratch repository whose index is set to match each case.

### `_opens_an_item` against its docstring

The docstring at `26833c0`: *"True when this commit changes plan.md AND its subject says an item **opened**."* The regex is `reopen|reopens|reopened|reopening`, the four re-forms only. With plan.md staged:

| subject | at `26833c0` | after `bc593d4` |
|---|---|---|
| `fix(plan): independence is REOPENED, both reviewers refute the closure` | fires | fires |
| `fix(plan): the covariant item is OPENED again by r260` | **silent** | **silent** |
| `fix(plan): item 1 is open again, the closure was refuted` | **silent** | fires |
| `fix(plan): restore the deliverable the rewrite deleted` | **silent** | **silent** |
| `fix(plan): obligation (ii) is not closed` | **silent** | **silent** |
| `fix(plan): the closure claimed in fcaf711 does not hold` | **silent** | **silent** |

**The record has such a commit, and it is the one immediately before this cycle.** `90ad8d9` (*"fix(plan): restore the deliverable the rewrite deleted, and stop ranking two decorations"*), is a `fix(` commit that stages plan.md and whose body reads *"Both are restored, **as obligation (ii)**"*: it moves an obligation back into the open column, exactly the status change the gate exists to catch, and it contains no re-word. It is still silent after the repair. `ef6ed9e`, under review here, reopens obligation (ii) in its own subject and misses on both conditions, staging no plan.md.

### What "the subject" is, unchanged by the repair

`subject = command.split("\n", 1)[0]` is line 1 of the **bash command**, not of the commit message. Both message forms are in ordinary use:

| commit form | line 1 | gate, either version |
|---|---|---|
| message opens on line 1 (`… -m "fix(plan): … REOPENED …`) | carries the subject | fires |
| heredoc (`… -m "$(cat <<'EOF'` + message + `EOF`) | `… -m "$(cat <<'EOF'` | **silent** |

In the heredoc form the `Deliverable` gate still fires, `re.findall` over the **whole** command finds `fix(plan):`, so within one invocation the two gates disagree about whether this commit has a subject at all. The sibling `_trailer` carries a docstring about reading the command string raw and whole; `_opens_an_item` was written against a different assumption and neither version says which form is expected.

### Three more ways past it

- **`-a`.** At `PreToolUse` nothing has been staged, `git diff --cached --name-only` is empty, the gate returns `False`. Both versions.
- **Split the commit.** Edit plan.md in one commit and derive in the next; neither has both properties. Both versions, inherent to a per-commit gate, and worth stating as a limit rather than leaving implied.
- **Type `docs(plan):`.** At `26833c0`, `main()` exits at the `GATED = ("feat(", "fix(")` check **before** the search gate is reached. `fcaf711`, the commit whose closure this whole thread refutes, is `docs(plan):`. **`bc593d4` fixes this**, running the search gate on any commit type.

### The `Searched:` trailer

At `26833c0`, `re.search(r"Searched:[ \t]*(\S.*)", text)` over the whole command, with only non-emptiness tested:

| text | at `26833c0` | after `bc593d4` |
|---|---|---|
| `Searched: none` | passes | **passes**, the shell's closing quote satisfies the reason clause |
| `Searched: none -- the item is a wording fix` | passes | passes |
| `We never Searched: anything, and derived anyway.` | **passes** | rejected |
| `Searched: .` | **passes** | rejected |
| `Searched: yes` | **passes** | rejected |
| `Searched: restitution -> references/weyl-polarization-primer/` | passes | passes |
| an `echo "Searched: x"` earlier in the same shell line | **passes** | rejected |

Two of the three holes at `26833c0` are things a careless cycle produces by accident rather than by evasion, which is the failure mode that matters: `Searched: none -- <why>` is designed to be uncomfortable and the parser accepted `Searched: none` without the discomfort. **The repair closes the prose and `echo` routes and leaves the bare `none`**, because the reason clause `\S.*` is satisfied by the trailing shell quote the same docstring warns about two functions below.

### And one substring, now fixed

At `26833c0`, `return "plan.md" in out.stdout` matched any staged path **containing** `plan.md`: staging `old/oldplan.md` alone fired the gate with plan.md untouched. `bc593d4` matches the path exactly.

**Verdict on the commit.** The gate is not theatre in intent, it fires on the exact commit shape the cycle it was written for produced, and I confirmed that. It is theatre in coverage: it catches one phrasing of one of several ways an item's status changes, reads a line that need not exist, and accepts any non-empty string after a colon. The narrowness is defended in the docstring as deliberate, and the defence is about **false positives**; every result above is a **false negative**, which the commit body does not discuss. *`bc593d4` closes three, names the tripwire limit honestly in its own docstring, and leaves the line-1 subject and the bare `none`.*

## Claim 6, anything from r259–r264 still unapplied

Checked against the working tree at `26833c0`.

| finding | first named | status |
|---|---|---|
| The Gram identity's reason: $n^{\mathrm{loops}}$ is the **Frobenius** pairing of $\nu(D),\nu(E)$, and that form is **positive definite** | [r261](REVIEW_r261.md) rec 6 | **STANDS.** Zero occurrences of *"Frobenius"* or *"positive definite"* in [brauer-pairing.md](../findings/brauer-pairing.md), [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) or [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py). Named again by [r262](REVIEW_r262.md), [r263](REVIEW_r263.md) and [r264](REVIEW_r264.md), **four reviewers, four cycles, no application** |
| [plan.md:55](../plan.md)'s *"A3 cannot start without it"* | [r262](REVIEW_r262.md) claim 3 | **STANDS**, unchanged. As [r264](REVIEW_r264.md) notes it is now ambiguous rather than wrong, obligation (ii) having been restored beneath it |
| The $f=12$ row (*"the two part company at every $n\le10$ and agree at every $n\ge11$"*), asserted with no committed run | [r259](REVIEW_r259.md) rec 5, [r263](REVIEW_r263.md) 6(iii) | **STANDS.** [brauer-pairing.md:79](../findings/brauer-pairing.md) still asserts it and no script in [scripts/runs/](../scripts/runs/) computes it. r263 verified it is true |
| *"which **semisimplicity** plus the double centraliser forces to equal $\sum_\lambda(\dim\Delta_\lambda)^2$"* | [r260](REVIEW_r260.md) claim 5 | **STANDS, and it is new to this list.** [brauer-pairing.md:73](../findings/brauer-pairing.md) still attributes the identity to a hypothesis that is never in question, the image is $\bigoplus_\lambda\mathrm{End}(M_\lambda)$ at every $n$ by the double centraliser alone, and the same file says *"The inequality never enters"* fifteen lines above. `ef6ed9e` fixed the matching circularity in the **script** and left the **file** |
| The conditional theorem box heading both files | [r259](REVIEW_r259.md) rec 1, [r261](REVIEW_r261.md) rec 3 | **APPLIED** by `ef6ed9e`; neither file now opens with *"$B_{12}(12)$ is semisimple"* |
| The $SO$/$O$ *"19 blocks"* collision | [r263](REVIEW_r263.md), [r264](REVIEW_r264.md) claim 2 | **APPLIED**; [findings/INDEX.md](../findings/INDEX.md) now reads *"the $16$ $O(12)$ blocks … ($19$ is the $SO(12)$ count)"* |
| The seed lemma's missing $O(n)$-admissibility hypothesis | [r263](REVIEW_r263.md), [r264](REVIEW_r264.md) claim 1 | **APPLIED**, with the $n=12$ tightness at $(2^6)$ recorded |
| Obligation (ii) claimed closed in the script header | [r263](REVIEW_r263.md), [r264](REVIEW_r264.md) claim 4 | **APPLIED**; the header now opens *"obligation (ii) is NOT closed"* |
| `padded_seed` inferring $k$ from `log(len)/log(n)` | [r263](REVIEW_r263.md), [r264](REVIEW_r264.md) claim 3 | **APPLIED**; it takes $m$ |
| The *"six primes"* assert over a two-prime tuple | [r264](REVIEW_r264.md) claim 5 | **APPLIED**; no prime appears in the file |
