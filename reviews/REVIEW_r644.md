# Review r644, Lemma L65, "the seed is a diagram, under admissibility"

**Reviewer B of an independent pair on brief `brief_L65`. Review number: r644. Target: [findings/brauer-pairing.md:112](../findings/brauer-pairing.md).**

## Verdict

**CONFIRMED**, the mathematical statement is true, at every $n$ for which it is non-vacuous, and a complete argument for it is present in the target file. Four defects are recorded below; one of them, the block's provenance pointer, is a **false pointer to a section whose own opening sentence disclaims containing the argument**, and it should be fixed.

## The reading I adopt, and where each symbol is defined

[conventions.md](../findings/conventions.md) opens with the rule *"Every definition, normalisation and index convention the record uses, stated here and quoted elsewhere"*. **It carries not one of L65's symbols.** No entry for $V$, $V_\lambda$, $\iota_\lambda$, $\mathrm{cup}$, $M_\lambda$, $\nu$, $B_f(n)$, $e$, or "admissible". The whole Brauer vocabulary is defined inline in [brauer-pairing.md](../findings/brauer-pairing.md) or nowhere. So I derive from the standard objects:

| symbol | reading adopted | where the record fixes it |
| --- | --- | --- |
| $V$ | the defining $n$-dimensional orthogonal representation of $O(n)$, carrying the invariant form | nowhere on the record; forced by $\mathrm{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$ at [brauer-pairing.md:44](../findings/brauer-pairing.md) |
| $\lambda$ | a **partition**, labelling an irreducible of $O(n)$ | nowhere; inferred from $\lambda'_1,\lambda'_2$ at [brauer-pairing.md:92](../findings/brauer-pairing.md). **Collides with the eigenvalue $\lambda_1$, $\lambda_{\min}$ of [conventions.md](../findings/conventions.md)'s table and with [route-a.md](../findings/route-a.md)'s two senses of $V_\lambda$, already flagged in [r628](REVIEW_r628.md)** |
| $V_\lambda$ | the irreducible $O(n)$-module of label $\lambda$; $\iota_\lambda$ its inclusion into $V^{\otimes\lvert\lambda\rvert}$ | [brauer-pairing.md:92](../findings/brauer-pairing.md) only |
| $\mathrm{cup}$ | $\sum_a e_a\otimes e_a\in V\otimes V$ in an orthonormal basis, the inverse metric | [brauer-pairing.md:90](../findings/brauer-pairing.md); **the L65 block itself says only "the pairing", which names the *cap* $V\otimes V\to\mathbb R$, the dual object** |
| admissible | $\lambda'_1+\lambda'_2\le n$, the column-length condition for $V_\lambda\ne0$ over $O(n)$ | [brauer-pairing.md:92](../findings/brauer-pairing.md) only. **"Admissible" carries an unrelated sense five times over in [diagonal-half.md](../findings/diagonal-half.md) and [nondegeneracy.md](../findings/nondegeneracy.md)** (of a deformation direction $N\perp W$) so the word is overloaded across the record |

**Finding 0.** Six symbols carrying a numbered lemma, none of them in the file whose stated purpose is to carry them, and two of them ($\lambda$, "admissible") colliding with live senses elsewhere. This is the same class of defect as the $\mathfrak m$, $\Pi$ and $d$ collisions the conventions table already records, and it belongs in that table.

## 1. Admissibility: what it is, which step consumes it, and why it never bites

**It is stated and it is used**, so this is neither the [L77](../findings/isotropy-cap.md) shape (named, never used) nor the [L75](../findings/isotropy-cap.md) shape (used, never named). The consuming step is the first: *$V_\lambda\ne0$, so $\iota_\lambda$ exists and is a nonzero map.* Weyl's condition $\lambda'_1+\lambda'_2\le n$ is exactly the condition for the $O(n)$-irreducible of label $\lambda$ to be nonzero, and everything downstream (equivariance, non-vanishing of the tensor product) is silent if the source is the zero module. The block's own witnesses ($\lambda=(2,2)$ at $n=2,3$ and $\lambda=(2,1,1)$ at $n=3$), are correct: $(2,2)$ has $\lambda'_1+\lambda'_2=4>3$, $(2,1,1)$ has $3+1=4>3$.

**Finding 1, the hypothesis cannot fail anywhere the programme works, and the block's "tight, zero slack" gloss misdescribes it.**

$\lambda'_1+\lambda'_2$ counts the boxes in the first two columns of $\lambda$, hence $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$, with equality exactly when every row has at most two boxes. Any $\lambda$ for which a seed is wanted labels a constituent of $V^{\otimes12}$, so $\lvert\lambda\rvert\le12$. The programme's claims are for $n\ge12$. Chaining:

$$\lambda'_1+\lambda'_2\;\le\;\lvert\lambda\rvert\;\le\;12\;\le\;n .$$

**So admissibility holds automatically for every label of $V^{\otimes12}$ at every $n\ge12$, as a theorem rather than as a hypothesis to check.** The block says *"it is **tight**: $\lambda=(2,2,2,2,2,2)$ sits at $\lambda'_1+\lambda'_2=12=n$, zero slack"*. Tightness of the inequality is not the hypothesis biting. $(2^6)$ is the equality case of $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ (every row has two boxes) at the extreme $\lvert\lambda\rvert=12$, and it is satisfied at $n=12$ and has slack at every $n>12$. **"Zero slack" reads as fragility that the chain above shows cannot exist.** The honest statement: the hypothesis is load-bearing for the lemma as stated over all $n$, and vacuous over the programme's range $n\ge12$.

## 2. The construction

Write $f=12$ and $k=(12-\lvert\lambda\rvert)/2$, so $\lvert\lambda\rvert+2k=12$ and the arity checks. Set

$$c_0\;:\;V_\lambda\;\cong\;V_\lambda\otimes\mathbb C\;\xrightarrow{\;\iota_\lambda\otimes\mathrm{cup}^{\otimes k}\;}\;V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes2k}\;=\;V^{\otimes12}.$$

**Equivariance.** For $g\in O(n)$, $\;(g\otimes g)\,\mathrm{cup}=\sum_a ge_a\otimes ge_a=\sum_{b,c}(gg^{\mathsf T})_{bc}\,e_b\otimes e_c=\mathrm{cup}$, since $gg^{\mathsf T}=1$. The computation uses orthogonality alone, so it holds for the **full** $O(n)$, reflections included, which is the clause the record's $SO$-versus-$O$ discussion at [brauer-pairing.md:52](../findings/brauer-pairing.md) turns on, and it survives here. $\iota_\lambda$ is equivariant by construction. A tensor product of equivariant maps is equivariant. ✓

**Non-vanishing.** $\iota_\lambda\ne0$ by admissibility and injectivity; $\mathrm{cup}\ne0$ because its coefficient on $e_1\otimes e_1$ is $1$. Over a field, the tensor product of a nonzero map with a nonzero vector is nonzero. The record's alternative (capping gives $n^k\iota_\lambda\ne0$ in characteristic zero), is also correct and is the stronger of the two, proving the map nonzero rather than one contraction of it. **No further argument is owed: the composite cannot vanish.** ✓

**Nonzero as a map = nonzero in $M_\lambda$.** Correct, $M_\lambda$ *being* $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$. ✓

### Finding 2, the parity and range constraints are consequences, not hypotheses, and the block says neither

$k=(12-\lvert\lambda\rvert)/2$ is an integer only at even $\lvert\lambda\rvert$ and non-negative only at $\lvert\lambda\rvert\le12$. **Both are forced, not assumed**: a label of $V^{\otimes f}$ is reached by an up–down tableau of length $f$ from $\varnothing$, each step adding or removing one box, so $\lvert\lambda\rvert\le f$ and $\lvert\lambda\rvert\equiv f\pmod 2$. At $f=12$ that is exactly $\lvert\lambda\rvert\in\{0,2,\dots,12\}$, which [brauer-pairing.md:13](../findings/brauer-pairing.md) does state, but for the *pairing* theorem seventy lines earlier and never for L65.

So the defect that refuted a neighbouring result today (a formula silently requiring a parity), is present in form but **benign in substance**: outside the parity, $M_\lambda=0$ and the lemma has no content to be wrong about. What is owed is one clause, not an argument. Neither the block nor [results.md:614](../results.md) carries it.

### Finding 3, the $12$ is the leg count $f$, not the dimension $n$, and the block never says which

[brauer-pairing.md:42](../findings/brauer-pairing.md) fixes it: *"Write $f=12$ for the leg count, three Weyl tensors, four legs each."* **This is the one place the collision matters most on this record, because $n=12$ too**, and the L65 block writes both $V^{\otimes12}$ and $(12-\lvert\lambda\rvert)/2$ with no gloss. Read as $n$, the lemma would be a statement about dimension twelve alone.

**Read correctly, the $12$ generalises without change.** The degree of the invariant is fixed at three Weyl tensors whatever $n$ is, so $f=12$ at every $n$, and the construction, the equivariance computation and the non-vanishing argument are all uniform in $n$. **The hard-coded $12$ bounds nothing.** The statement at other $n$ is the same statement; only admissibility could in principle vary, and Finding 1 shows it does not for $n\ge12$.

## 3. "It need not be searched for"

**Finding 4, the construction exhibits *a* seed, and both the block and [results.md](../results.md) say *the* seed.**

$\dim M_\lambda=m_\lambda(n)$ is generally far larger than one, $m_\varnothing(12)=11!!=10395$ at the empty label alone, so $c_0$ is one point of a large space and **there is no uniqueness, up to scale or otherwise**. The definite article at [brauer-pairing.md:116](../findings/brauer-pairing.md) (*"the seed is the composite"*) and at [results.md:616](../results.md) (*"the block's seed is the composite"*) claims more than is true.

**And uniqueness is not owed**, which is why the payoff survives. Step 1 of the realisation theorem, $M_\lambda$ irreducible over the image $\nu(B_{12}(n))$, hence *generated by any nonzero vector*, makes exhibition of one seed sufficient. **That is the load-bearing clause, and L65's statement does not mention it.** The correct reading of L65 is: *any nonzero element of $M_\lambda$ serves as a seed, and here is one in closed form.*

I checked step 1 independently and it is sound at every $n$: $V^{\otimes f}=\bigoplus_\lambda V_\lambda\otimes M_\lambda$ as $O(n)$-modules ($O(n)$ reductive, characteristic zero), so $\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})=\bigoplus_\lambda\mathop{\mathrm{End}}(M_\lambda)$, and the First Fundamental Theorem for $O(n)$ (which holds at every $n$, with no threshold), makes $\nu(B_f(n))$ all of it. Each $M_\lambda$ is then irreducible over the image. No semisimplicity of the abstract $B_f(n)$ enters, exactly as [brauer-pairing.md:54](../findings/brauer-pairing.md) says.

**Finding 5, the theorem L65's payoff depends on carries no number.** "The diagram-realisation theorem" is a `##` section, and [INDEX-results.md](../findings/INDEX-results.md) lists it nowhere; only L65 itself appears, at row 65. So a numbered result rests on an unnumbered one in the same file, and the audit programme's numbered sweep will never reach the part that does the work.

**What the search was, and what it cost.** The record states the search qualitatively at [brauer-pairing.md:87](../findings/brauer-pairing.md), *"finding a nonzero element of $\mathop{\mathrm{Hom}}(V_\lambda,V^{\otimes12})$ is the same construction problem the item started with, once per block"*, i.e. 71 times, and prices it nowhere. **So the payoff is real but unquantified**, and the block should say so. Against that, [brauer-pairing.md:108](../findings/brauer-pairing.md) does price what remains: the expansion search over $23!!=316{,}234{,}143{,}225$ diagrams is untouched. **"It need not be searched for" is true of the seed and false of the certificate**, and only the surrounding section says so.

## 4. Scope, consumers, and the transfer gap

- **Nothing consumes L65.** Grepping the record outside [reviews/](.), L65 appears only at [brauer-pairing.md:112](../findings/brauer-pairing.md), at [results.md:212](../results.md) and [results.md:614](../results.md), and as an unchecked row in [plan-verification.md:84](../plan-verification.md). No finding, no proof step, no plan item cites it.
- **The route it serves is closed.** [routes.md:17](../routes.md) records R1, the universal-certificate route, as **closed**, on the ground that *"endgame is a machine certificate, no readable proof"*. **So the blast radius of any defect here is nil.**
- **L65 does not inherit L64's gap.** [Lemma L64, the transfer mechanism](../findings/fence-posts.md), audited today to GAP (true but with no known satisfiable instance), is a statement about extending an $O(n_0)$-invariant along the signed permutation groups $B_n$ under padding. **L65 consumes none of it.** Its argument is one orthogonality computation plus a tensor-product non-vanishing, at a single fixed $n$, with no padding and no transfer between dimensions. The two do share the FFT for $O(n)$ as a common ancestor, L64 through "the first fundamental theorem spans $O$-invariants by contraction diagrams at every $n$", L65's payoff through the realisation theorem's step 2, but sharing an ancestor is not inheriting a gap, and the FFT is the uncontested part of both.

## Provenance, checked, and clean on one count, false on the other

**The boilerplate is TRUE here.** The block says *"the mathematics has always been in this file"*. `git log -S'iota_\lambda' -- findings/brauer-pairing.md` returns three commits; the earliest, `e0b9cb0c` *"feat(diagrams): the seed is a padding diagram, so obligation (ii) needs no search"* (2026-08-30), touches exactly two paths, [findings/brauer-pairing.md](../findings/brauer-pairing.md), +19 lines, and [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py). The same content reaches [report/](../report/) only on 2026-08-31, in `6b23f710`. **The mathematics was in this file first and has never lived anywhere else.** This is one of the clean copies of the 42-block paste; 16 copies of the sentence survive across [findings/](../findings/) today.

**The section pointer is FALSE, and self-refutingly so.**

The block says *"the argument is in this file under **The diagram-realisation theorem, one seed per block**"*. The headings of the file are: `## The diagram-realisation theorem, one seed per block` at line 40, running to line 85; `## The seed is itself a diagram` at line 86; `### What stays open` at line 106; and L65's own `####` at line 112.

**The reading I use:** a heading owns everything from itself to the next heading of the same or higher level, subordinate `###` and `####` blocks included. Under that reading the named section is lines 40–85 and L65's block sits inside a *different* `##` section, lines 86–117.

**Under either reading the pointer misses**, because the construction $c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$, the admissibility hypothesis, the equivariance and the non-vanishing are all at lines 88–98, inside `## The seed is itself a diagram`. And the named section's own first sentence, [brauer-pairing.md:87](../findings/brauer-pairing.md), is:

> *"The realisation theorem says one nonzero seed per block generates that block, and **says nothing about where a seed comes from**."*

**The pointer names the one section in the file that explicitly disclaims containing L65's argument.** The named section supplies the *payoff* clause (any nonzero seed generates), which is real and which L65 needs; it supplies none of the construction, which is what L65 states.

The history shows how: `86621751` created the block saying *"the argument is the surrounding material in this file"*, which was correct; `bbfa159b` then replaced that with the named section, in a commit whose own message claims the sections were *"located by searching each lemma's own distinctive content rather than by title similarity, which had matched five different lemmas to one heading"*. **Here it matched by title similarity anyway** ("one seed per block" against "the seed is a diagram") and landed one section short. The earlier, vaguer wording was true; the precise replacement is false.

**The fix is one string:** point at `## The seed is itself a diagram`.

## Other pointers

The block's only link is [report/](../report/), which resolves. [results.md:212](../results.md) and [results.md:614](../results.md) restate the lemma faithfully, carrying the same three defects ("the seed", the unglossed $12$, and no parity clause) and adding one of their own: *"The lemma removes a search from the certificate pipeline and adds no certificate"*, which is right, and which the findings block does not say.

## Summary of what is owed

| # | defect | severity | reachable? |
| --- | --- | --- | --- |
| P | the section pointer names a section that disclaims containing the argument | **must fix** | one string, now |
| 0 | six symbols and two colliding words absent from [conventions.md](../findings/conventions.md) | real | one table block |
| 1 | "tight, zero slack" misdescribes a hypothesis that cannot fail at $n\ge12$ | real | one sentence, with the two-line proof $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le12\le n$ |
| 2 | parity and range of $k$ unstated | cosmetic, they are forced | one clause |
| 3 | the $12$ unglossed, and $n=12$ on the same page | real, collision-shaped | one clause: "$12=f$, the leg count, at every $n$" |
| 4 | "*the* seed" claims a uniqueness that fails; the "any nonzero vector" clause it needs is unstated | real | one clause |
| 5 | the realisation theorem, which carries the payoff, is unnumbered | real | a number |

**None of the seven touches the mathematics.** The statement is true, the argument is complete and in the file, and the verdict stands at CONFIRMED.

## Computation

**None run.** The analysis-only footing was inherited from the brief and honoured: every claim above is a hand derivation or a `git log`/`grep` over the record. Nothing here needed a run to decide, the two facts a numerical screen might have been reached for, $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert$ and $(g\otimes g)\,\mathrm{cup}=\mathrm{cup}$, are one line each.
