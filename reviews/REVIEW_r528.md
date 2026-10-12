# Review r528, Lemma L26

**Target**: Lemma L26, "the dangerous eigenvalue of the two-block spectrum, in closed form", in [findings/nondegeneracy.md](../findings/nondegeneracy.md) at the `#### Lemma L26` heading (line 78), down to the next heading of any level.

**Reviewer**: r528, independent adversarial audit, cold brief. Analysis-only footing: no searches, sweeps, censuses or falsifier hunts; screening a claim about to be recorded is permitted and is labelled as a screen wherever it appears.

**Phase plan**

1. Log and report skeleton.
2. Read the target block verbatim; fix conventions against [findings/conventions.md](../findings/conventions.md), [findings/INDEX-results.md](../findings/INDEX-results.md), [findings/INDEX-traps.md](../findings/INDEX-traps.md).
3. Attack the object $X$: is $X \in \mathcal W_n$, i.e. does the Ricci component vanish as well as the $\Lambda^4$ part?
4. Attack the hypothesis $p,q \ge 2$ against L27's $p,q \ge 3$, $(p,q) \ne (3,3)$.
5. Derive the closed form from the structure constants under the half-trace normalisation.
6. "Dangerous" relative to which threshold; does the block name the set where the threshold is reached?
7. Relation to L27: same $\mu$ or not; redundancy or strength.
8. The 18 citations: what each takes.
9. Contradictions elsewhere in `findings/`, and the provenance line against git.
10. Verdict.

**VERDICT: PLAUSIBLE**, one false closing clause (F4), everything cited confirmed. Detail at the end.

## Findings

### F1 (CONFIRMED), the object $X$ is in $\mathcal W_n$, and the reason is stronger than the block gives

Working in the record's normalisation ([conventions.md](../findings/conventions.md): half-trace at the $\Lambda^2$ level, $\lVert\varphi_{ab}\rVert^2=1$, plain Frobenius on the pair matrix), with core indices $1,2\in P$ and $3,4\in Q$ and $\odot$ read as $A\otimes B+B\otimes A$:

- $\mathrm{Alt}(\varphi_{12}\odot\varphi_{34})$ has the value $\tfrac13$ on $(1,2,3,4)$, so $X=\varphi_{12}\odot\varphi_{34}-\mathrm{Alt}(\cdot)$ has $X_{1234}=\tfrac23$, $X_{1324}=+\tfrac13$, $X_{1423}=-\tfrac13$. **The block's coefficients $\tfrac23,\tfrac13,-\tfrac13$ are reproduced exactly**, and they are the pairings written in increasing index order, under the Bianchi ordering $(1234),(1342),(1423)$ they read $\tfrac23,-\tfrac13,-\tfrac13$ and sum to $0$.
- $\lVert X\rVert^2=2\big((\tfrac23)^2+(\tfrac13)^2+(\tfrac13)^2\big)=\tfrac43$. **The block's $\lVert X\rVert^2=\tfrac43$ is exact in the record's pairing**, and this is a second, independent pin on the half-trace convention.
- **Ricci vanishes for a reason the block never states.** $\mathrm{Ric}_{jl}=\sum_iX_{ijil}$ needs a repeated index, and every nonzero component of $X$ carries **four distinct** indices, so $\mathrm{Ric}(X)=0$ identically. The hypothesis that supplies this is that $\pi$ and $\rho$ are **disjoint**, automatic here because $\pi\subset P$ and $\rho\subset Q$. Had $\pi$ and $\rho$ shared an index, $\mathrm{Alt}$-removal alone would leave a Ricci part and $X\notin\mathcal W_n$.

**Verdict on step 1: the assertion $X\in\mathrm{Weyl}_n$ is true.** The block's justification is incomplete (it names only the $\Lambda^4$ removal) but the missing half is one line and the hypothesis carrying it is already in the statement. *Gap of exposition, not of substance.*

### F2 (CONFIRMED), the general three-block formula, verified entry by entry, by hand

I rebuilt $e$ from the definitions rather than from the record. A coordinate-diagonal Weyl operator with sectional matrix $K$ is in $\mathcal D_n$ (symmetric, hollow, $K\mathbf 1=0$), which for three blocks forces $(p-1)\varepsilon_{PP}+q\varepsilon_{PQ}=0$ and $(q-1)\varepsilon_{QQ}+p\varepsilon_{PQ}=0$. With $Q(W)_{\{ab\}}=K_{ab}^2+\sum_{c\ne a,b}K_{ac}K_{bc}$ (which returns $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ on $K\equiv1$, the record's anchor, fixing $W^\#=\tfrac12\sum cc\,WW$), the normalisation $Q(e)=e$ gives

$$\varepsilon_{PQ}=-\frac1{n-1},\qquad \varepsilon_{PP}=\frac q{(p-1)(n-1)},\qquad \varepsilon_{QQ}=\frac p{(q-1)(n-1)},$$

and the $PP$ equation checks independently. Then, with $e\circ X=\tfrac12(eX+Xe)+\Phi(e,X)$ and $\Phi(e,X)_{\alpha\beta}=\tfrac12\sum_{r,\delta,\zeta}c_{\alpha r\delta}\varepsilon_rc_{\beta r\zeta}X_{\delta\zeta}$:

| entry | anticommutator | $\Phi$ | total | $\lambda X$ |
| --- | --- | --- | --- | --- |
| $(\{12\},\{34\})$ | $\tfrac13(\varepsilon_{PP}+\varepsilon_{QQ})$ | $-\tfrac23\varepsilon_{PQ}$ (four terms $r=\{13\},\{14\},\{23\},\{24\}$, each $-\tfrac13\varepsilon_{PQ}$) | $\tfrac13(\varepsilon_{PP}+\varepsilon_{QQ})-\tfrac23\varepsilon_{PQ}$ | $\tfrac23\lambda$ ✓ |
| $(\{13\},\{24\})$ | $\tfrac13\varepsilon_{PQ}$ | $\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})-\tfrac23\varepsilon_{PQ}$ (terms $r=\{12\},\{34\},\{14\},\{23\}$) | $\tfrac16(\varepsilon_{PP}+\varepsilon_{QQ})-\tfrac13\varepsilon_{PQ}$ | $\tfrac13\lambda$ ✓ |
| $(\{14\},\{23\})$ | by the $3\leftrightarrow4$ symmetry, which sends $X\mapsto-X$ and fixes $e$ | | | $-\tfrac13\lambda$ ✓ |

**All other entries vanish, and this is provable rather than enumerable.** A nonzero $\Phi_{\alpha\beta}$ needs triangles $(\alpha,r,\delta)$ and $(\beta,r,\zeta)$ with $\delta,\zeta$ a disjoint pair in $X$'s support; the two triangles share $r$, so their vertex sets meet in $\ge2$ points, and disjointness of $\delta,\zeta$ forces them to meet in exactly $r$ and forces $\alpha,\beta$ themselves to be a disjoint pair on the same four core indices. **In particular no spare index can occur** (a spare index in $r$ puts one in $\delta$, which leaves $X$'s support), and the diagonal entries vanish because $\delta$ is determined by $(\alpha,r)$, giving $X_{\delta\delta}=0$.

So $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ for **any** three-block diagonal operator, **confirmed**, and confirmed without the block's "two spare indices in each block" enumeration, which is sufficient but heavier than needed.

### F3 (CONFIRMED), the closed form and the threshold criterion

Substituting the critical values:

$$\lambda=\frac1{n-1}\Big[\tfrac12\Big(\tfrac q{p-1}+\tfrac p{q-1}\Big)+1\Big]=\frac{p^2+q^2+2pq-3p-3q+2}{2(n-1)(p-1)(q-1)}=\frac{(n-1)(n-2)}{2(n-1)(p-1)(q-1)}=\frac{n-2}{2(p-1)(q-1)}.$$

**$\mu=\frac{n-2}{2(p-1)(q-1)}$ is exactly right.** Equivalently $\mu=\tfrac12\big(\tfrac1{p-1}+\tfrac1{q-1}\big)$, which is the form [result 126](../findings/INDEX-results.md) uses ("met iff $1/(p-1)+1/(q-1)=1$"), the two agree.

$\mu\ge\tfrac12\iff p+q-2\ge(p-1)(q-1)\iff(p-2)(q-2)\le1$: **correct**. Over integers $p,q\ge2$ the solution set is $p=2$ (any $q$), $q=2$ (any $p$), and $(3,3)$, the block names only "$p=2$" and $(3,3)$, leaving the $q=2$ branch to an unstated WLOG.

At $p=2$ the excess is $\mu-\tfrac12=\frac1{2(q-1)}=\frac1{2(n-3)}$: **the recorded excess is correct.** Independent cross-check: at $(2,2)$ the formula gives $\mu=1$, and the block's own $(2,2)$ spectrum $(-1)^4,(\tfrac12)^4,1^2$ carries $1$ at multiplicity $2$, consistent.

### F4 (REFUTED), the gap sentence is false at every split but $n=8$

> "For $p,q\ge3$ other than $(3,3)$ the gap is $1/(2\max(p,q)-2)$."

The gap is $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, which is **exactly [L27](../findings/nondegeneracy.md)'s closed form**. These disagree:

| $(p,q)$ | true gap $\tfrac12-\mu$ | claimed $1/(2\max-2)$ |
| --- | --- | --- |
| $(3,4)$ | $1/12$ | $1/6$ |
| $(3,5)$ | $1/8$ | $1/8$ ✓ |
| $(4,4)$ | $1/6$ | $1/6$ ✓ |
| $(4,5)$ | $5/24$ | $1/8$ |
| $(5,5)$ | $1/4$ | $1/8$ |
| $(3,7)$ | $1/6$ | $1/12$ |
| $(8,8)$ | $5/14$ | $1/14$ |

*(Arithmetic screen over $2\le p\le q\le8$, exact rationals; a screen, reported as one, the mismatch above is settled by the two closed forms alone, which disagree as functions.)*

The claimed expression holds **only at $(3,5)$ and $(4,4)$**, i.e. only at $n=8$. It is neither an upper nor a lower bound: it overstates the gap at $(3,4)$ and understates it everywhere from $(4,5)$ on, and its asymptotics run the wrong way, the true gap rises to $\tfrac12$ as $p,q\to\infty$ while the claimed one falls to $0$.

**The likely provenance of the error is visible in the formula.** $1/(2\max(p,q)-2)=\frac1{2(\max-1)}$ is the $p=2$ **excess** formula $\frac1{2(q-1)}$ from the previous clause, carried across to the $p,q\ge3$ branch where it does not apply. The sentence reads as the wrong branch copied one clause down.

**This is a defect inside L26 that the record already contradicts elsewhere**, since [L27](../findings/nondegeneracy.md) in the same file gives the correct gap. The repair is one clause: replace the expression by $\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, or delete the clause and cite L27.

### F4b, where the false expression comes from: it is a *different eigenvalue's* gap

$1/(2\max(p,q)-2)=\frac1{2(m-1)}$ with $m=\max(p,q)$ is exactly $\tfrac12-\lambda_m$ for $\lambda_m=\frac{m-2}{2(m-1)}$, the value [L27](../findings/nondegeneracy.md) assigns to the summand $S^2_0(\mathbb R^m)$ and [second-order.md](../findings/second-order.md) calls the *"within-factor top"*. The same expression appears in that form at [REVIEW_r370.md:138](REVIEW_r370.md), *"$\lambda_{\max}(L_e|_{\mathcal D_n\cap W^\perp})=\tfrac{\max(p,q)-2}{2\max(p,q)-2}<\tfrac12$"*.

**So the sentence gives the gap of the $S^2_0$ eigenvalue while attributing it to L26's own $\mu$.** The two are different eigenvalues of the same operator, both on L27's ten-value list, and neither dominates the other.

**One weaker statement is nearly rescuable, and is not L26's.** The true spectral gap of $L_e$ below $\tfrac12$ off the orbit is $\min\{\tfrac12-\lambda_{\max(p,q)},\ \tfrac12-\mu\}$, the form [r526](REVIEW_r526.md) uses. Over $p,q\ge3$, $(p,q)\ne(3,3)$ that minimum equals $\frac1{2\max(p,q)-2}$ **at every split but one**: it fails only at $(3,4)$, where the minimum is $\tfrac1{12}$ and the claimed value $\tfrac16$. *(Screen over $3\le p\le q\le11$ in exact rationals; the inequality $\tfrac12-\mu\ge\tfrac12-\lambda_m$ reduces to $(\min-2)(\max-2)\ge\min$, which for $\min=3$ needs $\max\ge5$ and for $\min\ge4$ is automatic, so $(3,4)$ is the unique failure, provable without the screen.)*

That reading needs **L27's upper bound**, which L26 explicitly disclaims two paragraphs later ("*An exhibited eigenvector bounds $\lambda_{\max}$ … from below*"). So it cannot be what the sentence means, and it is false at $(3,4)$ anyway.

### F5, L27 cites L26 for a value L26 does not contain

[L27](../findings/nondegeneracy.md)'s ten-value list reads *"$-\mu$ and $+\mu$ on the two tensor summands, **by Lemma L26**"*, the two summands being $S^2_0(\mathbb R^p)\otimes S^2_0(\mathbb R^q)$ and $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$.

**L26 produces one eigenvector, in $\Lambda^2\otimes\Lambda^2$, at $+\mu$.** Its own Sources line says so: *"this family is the $\Lambda^2(\mathbb R^p)\otimes\Lambda^2(\mathbb R^q)$ summand"*. Nothing in the block touches $S^2_0\otimes S^2_0$, and nothing derives the sign $-\mu$ or the coincidence of moduli between the two summands.

**L27's conclusion survives** (it needs only $\lvert{\pm\mu}\rvert<\tfrac12$, which follows from $\mu<\tfrac12$) but the attribution is over-broad by one summand and one sign, and the $S^2_0\otimes S^2_0$ value is currently unsourced in the record.

### F6, L11 cites L26 for the *correct* gap formula, which L26's block does not carry

[L11's proof](../findings/nondegeneracy.md), sixty lines below, reads *"[Lemma L26] gives the closed form $\mu=\frac{n-2}{2(p-1)(q-1)},\ \tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$"*. **The second half is not in L26's block**; L26's block gives $1/(2\max(p,q)-2)$ instead. The formula L11 attributes is the true one and follows in one line from $\mu$, so **L11 is sound**, but the record currently states two incompatible gaps for the same quantity, in the same file, and the correct one is only in the consumer.

### F7, the defect has spread to two further files

| location | carries the false clause |
| --- | --- |
| [findings/nondegeneracy.md:90](../findings/nondegeneracy.md) | yes, the source |
| [results.md:392](../results.md) | yes, verbatim |
| [report/sections/07-gradedness-split.tex:618](../report/sections/07-gradedness-split.tex) | yes, in the Lemma 26 environment |
| [results.md:138](../results.md) (the landscape summary) | **no**, stops at "$\mu\ge\tfrac12$ exactly at $p=2$ and at $(3,3)$", which is correct |

### F8, the other 18-citation consumers, and what each takes

Grepped across `findings/`, `results.md`, `ATTEMPTS.md`, `report/` and `reviews/`.

| citation | what it takes | status |
| --- | --- | --- |
| [findings/nondegeneracy.md:438](../findings/nondegeneracy.md) (L11) | "$\mu$ reaches $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}$" | **safe**, F3 confirms both |
| [findings/nondegeneracy.md:440](../findings/nondegeneracy.md) (L11 proof) | $\mu$ **and** the gap formula | **sound but misattributed**, see F6 |
| [findings/nondegeneracy.md:461](../findings/nondegeneracy.md) (L27 motivation) | "L26 closes only the half that runs the wrong way" | **safe**, L26 says the same of itself |
| [findings/nondegeneracy.md:480](../findings/nondegeneracy.md) (L27 proof) | $\pm\mu$ on **two** summands | **over-broad**, see F5 |
| [findings/second-order.md:635](../findings/second-order.md) | the value $\frac{n-2}{2(p-1)(q-1)}$ | **safe** |
| [findings/second-order.md:869](../findings/second-order.md) (L133) | "attained on L26's direction" in every $(2,2)$-split four-subset | **safe**, with [r419](REVIEW_r419.md)/[r420](REVIEW_r420.md)'s correction that the maximiser set is the whole span |
| [findings/second-order.md:889](../findings/second-order.md) | $\mu_{m,m}=\frac{n-2}{2(m-1)^2}=\frac2{n-2}$, eigenvector $(2,-1,-1)$, coefficients $\tfrac23,\tfrac13,-\tfrac13\to(\tfrac23,-\tfrac13,-\tfrac13)$ under Bianchi | **safe, and it independently reproduces my F1**, the signed triple is exactly what I derived |
| [findings/LEDGER.md:232](../findings/LEDGER.md) | $\mu$ and $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ | **sound**, same misattribution as F6 |
| [findings/INDEX-results.md:26](../findings/INDEX-results.md) (row 11), [:152](../findings/INDEX-results.md) (row 133) | the closed form, via L11 and L133 | **safe** |
| [findings/INDEX-results.md:144](../findings/INDEX-results.md) (row 126) | "$1/(p-1)+1/(q-1)=1$ only at $S^3\times S^3$" | **safe and equivalent**, $\mu=\tfrac12(\tfrac1{p-1}+\tfrac1{q-1})$ |
| [results.md:138](../results.md) | closed form, threshold, "criticality unused", "lower bound only" | **safe** |
| [results.md:748](../results.md) (L133) | L26's direction as the supremum's attainer | **safe** |
| [ATTEMPTS.md:2813](../ATTEMPTS.md) | the value at $(2,2)$-split four-subsets | **safe** |
| [ATTEMPTS.md:3972](../ATTEMPTS.md) | "L26 for $\mu$ **and for the eigenvector's coordinates and norm**" | **safe**, F1 confirms both coordinates and $\lVert X\rVert^2=\tfrac43$ |
| [reviews/ELIM-canon.md:146](ELIM-canon.md), [ELIM-secondorder.md:185](ELIM-secondorder.md) | descriptive | **safe** |

**No consumer takes the false gap clause.** Every downstream use takes $\mu$, the threshold criterion, the $p=2$ excess, or the eigenvector's coordinates, all of which F1–F3 confirm. The clause is inert in the record and wrong on the page; the damage is that it contradicts L27 in the same file.

### F9, the provenance line is TRUE here, unlike its neighbour's

> *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*

Checked against git. The move is `a9e4b8c0` (*refactor(results): the proofs move to findings, results.md states and points*), which added 134 lines to [findings/nondegeneracy.md](../findings/nondegeneracy.md). At `a9e4b8c0^` that file carried **no** L26 block, no "dangerous eigenvalue", no $\phi_\pi\odot\phi_\rho$, its only `2(p-1)(q-1)` hit being an unrelated $\theta$ formula. `git grep` at that commit finds the argument in `results.md` and in two `report/sections/*.tex` write-ups plus a reviewer script.

**So the claim holds for the findings tree**, which is what the sentence is about. This is the opposite outcome from the same sentence sixty lines below, where [L11's note](../findings/nondegeneracy.md) has already been repaired to *"the claim … is false against the commit before the move"*. **L26's wording is unrepaired because it needed no repair.**

### F10, the motivation's label is stale

> "Needed because **Observation L3's** nondegeneracy claim at $S^p\times S^q$ rested on a scan…"

[Result 3](../findings/INDEX-results.md) is now a **Lemma**, refuted at $n=6$ and proved for every even $n\ge8$ via [L24](../findings/second-order.md) and [L27](../findings/nondegeneracy.md). The historical statement (that the pre-L26 warrant was a split-by-split scan), is still true, and the motivation still reads correctly; only the label "Observation" is stale. [r525](REVIEW_r525.md) and [r526](REVIEW_r526.md) both flagged this line and both called it safe. **Agreed: stale label, sound motivation.**

### F11, two smaller scope slips inside the block

- **The threshold is named but not sourced.** The block says "the eigenvalue that threatens to reach $\tfrac12$" and gives $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$, so *what* dangerous means is stated. **Why $\tfrac12$** is the threshold is [L24](../findings/second-order.md)'s $\mathrm{Hess}=6\theta(L_e-\tfrac12\mathrm{Id})$, which the block never cites. One cross-reference would close it.
- **"$(3,3)$ is the unique split reaching $\tfrac12$"**, in the "what it does not reach" paragraph, is true only within $p,q\ge3$, the block's own statement, three paragraphs above, has $p=2$ reaching it with excess $\tfrac1{2(n-3)}$. The paragraph names the statement nondegeneracy *needs*, and after [L11's correction to two exceptional families](../findings/nondegeneracy.md) that need is no longer what nondegeneracy wants. **Restrict the clause to $p,q\ge3$.**
- **The range $p,q\ge2$ is exactly right and is not overstated.** $(p-1)(q-1)$ degenerates only at $p=1$ or $q=1$, and $\pi$ needs $p\ge2$. L27's narrower $p,q\ge3$, $(p,q)\ne(3,3)$ is a hypothesis of *L27's* upper bound, not of L26's eigenvector. At $(2,2)$ the formula gives $\mu=1$, and the block's own recorded $n=4$ spectrum $(-1)^4,(\tfrac12)^4,1^2$ carries $1$ at multiplicity $2$ ($e$ itself plus $X$), an independent confirmation at the extreme end of the claimed range.

## VERDICT: PLAUSIBLE

**Everything L26 is cited for is true and I re-derived all of it by hand; one sentence of the block is false and no citation uses it.**

**Confirmed from the definitions, independently of the record:**

- $X\in\mathcal W_n$, with the Ricci vanishing supplied by the disjointness of $\pi$ and $\rho$ (F1).
- The coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$, in the record's half-trace pairing (F1).
- $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$ for any three-block diagonal operator, entry by entry, with the vanishing of all other entries proved rather than enumerated (F2).
- $\mu=\frac{n-2}{2(p-1)(q-1)}$ and $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$, and the $p=2$ excess $\tfrac1{2(n-3)}$ (F3).
- The hypothesis $p,q\ge2$ is exactly the right range (F11).
- The provenance line is true (F9).

**The defect (F4, F4b):** *"For $p,q\ge3$ other than $(3,3)$ the gap is $1/(2\max(p,q)-2)$"* is **false**, it is $\tfrac12-\lambda_{\max(p,q)}$, the $S^2_0$ summand's gap, written in place of $\tfrac12-\mu$. It agrees with the truth only at $(3,5)$ and $(4,4)$. It contradicts [L27](../findings/nondegeneracy.md) and [L11](../findings/nondegeneracy.md) in its own file, and it has propagated verbatim to [results.md:392](../results.md) and [report/sections/07-gradedness-split.tex:618](../report/sections/07-gradedness-split.tex).

**Verdict PLAUSIBLE rather than REFUTED** because the defect is a closing remark, not a step: the statement's equation, its range, its threshold criterion and its argument all stand, no consumer depends on the clause, and the repair is one substitution.

**Repairs, in order of urgency:**

1. Replace the gap clause in all three files by $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, or delete it and cite [L27](../findings/nondegeneracy.md).
2. Narrow [L27](../findings/nondegeneracy.md)'s *"by Lemma L26"* to the $\Lambda^2\otimes\Lambda^2$ summand, and source the $S^2_0\otimes S^2_0$ value separately (F5).
3. Add the one-line Ricci argument to the statement's justification of $X\in\mathrm{Weyl}_n$ (F1).
4. Restrict *"$(3,3)$ is the unique split reaching $\tfrac12$"* to $p,q\ge3$, and cite [L24](../findings/second-order.md) for the threshold (F11).
5. Relabel "Observation L3" as "Lemma L3" (F10).
