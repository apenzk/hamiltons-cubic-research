# Reviewer 626, Lemma L93, the min-entry bound, **GAP**, and the block is a **DUPLICATE of [Lemma L55](../findings/diagonal-half.md)**

**Review number: 626.** Target: [findings/bispectral.md](../findings/bispectral.md), the block at line 347. Second of a pair on identical briefs; derived cold from the definitions. **Analysis only**, the two screens run are named as screens where they appear, and nothing positive rests on them.

**Verdict in one line: the inequality is TRUE and stronger than stated, the equality clause is FALSE as written by the same two omissions found in the sibling, the block's stated motivation is REFUTED by a sharper statement eleven lines above it in its own file, and the result already carries the number 55, 93 was assigned to it a second time by a numbering sweep and should be retired.**

---

## 1. The duplication, which decides whether the block should exist

### It is the same result, hypothesis for hypothesis

| | **L93** ([bispectral.md:347](../findings/bispectral.md)) | **L55** ([diagonal-half.md:400](../findings/diagonal-half.md)) |
| --- | --- | --- |
| hypotheses | $K$ hollow, symmetric, zero row sums, $\lVert K\rVert_F^2=t$ | identical, word for word |
| conclusion | $\lvert\min_{a\ne b}K_{ab}\rvert\ge\sqrt{t/(n(n-1)(n-2))}$ | identical |
| $t$ normalisation | $\lVert K\rVert_F^2$, the **ordered**-pair sum | identical |
| equality clause | "equality *forces* a perfect matching", with $(n-2)c$ on a fixed-point-free involution, $-c$ elsewhere | "the extremizers being **exactly** the perfect matchings", same display |
| proof | one-row extremal configuration, asserted; then $\max_a s_a\ge t/n$ | row polytope $\{\sum x=0,\ x\ge-m\}$, convex maximum at a vertex; then $\sum_a s_a=t$ |

**No hypothesis separates them, and the $t$ collision does not bite here.** Both write $\lVert K\rVert_F^2=t$, which is the ordered-pair sum $\sum_{a\ne b}K_{ab}^2$, and the constant $n(n-1)(n-2)$ is correct exactly on that reading, the unordered reading $\sum_{a<b}$ would put a factor $2$ inside the root. The two blocks agree, so this is not the live collision the brief warns about.

**The equality clauses differ in strength only**: L55 claims a classification ("exactly"), L93 claims the forcing direction. Both omit the same sign condition (§3).

### The proofs are two arguments, and the second was written to replace a missing first

They are genuinely different chains, L93 takes the **maximum** row ($\exists a:\ s_a\ge t/n$), L55 **sums** the rows ($\sum_a s_a=t$), and they carry different tightness conditions (§3). But this is not independent corroboration: L55's proof was supplied at audit by [ELIM-halves](ELIM-halves.md) *because the block had none*, five days after L93's proof was already on the record.

### Provenance, from `git`, and it is unambiguous

| when | commit | what happened |
| --- | --- | --- |
| 2026-08-26 16:08 | `aad4a1be` | Reviewer 104's log salvaged as [REVIEW_r104.md](REVIEW_r104.md), carries the **statement** and the constant, no proof |
| 2026-08-26 16:11 | `b1117290` | **the mathematics enters the record**, in `findings/bispectral.md`, with the proof now under L93 |
| 2026-08-26 20:08 | `052c33b7` | the report copies that proof **verbatim** into [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex) and numbers it **Lemma 55** |
| 2026-08-31 20:50 | `86621751` | the "number the 24 results that only the report had numbered" sweep gives it a `#### Lemma 55` block, **in `diagonal-half.md`** |
| 2026-09-02 02:14 | `8d34609b` | the "number the twenty-nine results the sort found, 75–103" sweep finds the *original* passage still unnumbered and calls it **L93** |

**The mechanism of the duplication is visible in the record's own commit messages.** `86621751` says of its 24 results *"none is duplicated"* and files this one under *"the file that already held its mathematics"*; both clauses are false here. `git log -S"n(n-1)(n-2)" -- findings/diagonal-half.md` returns `86621751` as its **first** hit (the constant entered that file in the very commit that claimed it had always been there) while the report files the same lemma in its **bispectral** section. Three days later the second sweep numbered the passage that the first sweep had walked past.

*The L55 block's provenance note, "the mathematics has always been in this file", is therefore false. It belongs to the sibling audit, but it is the sentence that caused this.*

### Which number survives: **55**, and the block belongs in `bispectral.md`

- **55 is the earlier `#### Lemma` block** in `findings/` (2026-08-31 against 2026-09-02), which is the criterion [INDEX-results.md](../findings/INDEX-results.md) states for owning a number.
- **55 is the only one that propagated.** It is in [results.md](../results.md) twice (lines 192 and 554), in [report/sections/06b-bispectral.tex](../report/sections/06b-bispectral.tex) and in the report's status table, and in [plan-verification.md](../plan-verification.md). `grep -rn "L93"` outside `reviews/` returns the two blocks and the two index rows and nothing else, **striking 93 costs no pointer.**
- **55 now carries a Gate 2 verdict** ([r607](REVIEW_r607.md)/[r608](REVIEW_r608.md)); row 93 of [INDEX-results.md](../findings/INDEX-results.md) still reads *"Gate 2: no verdict on the record"*.

**But the subject belongs to [bispectral.md](../findings/bispectral.md), not [diagonal-half.md](../findings/diagonal-half.md)**, that is where the mathematics originated, where the report files it, and where it is used ($\psi$-block, vertex matrices). The lemma is about hollow zero-row-sum matrices on and off the diagonal locus alike, so `diagonal-half.md` is the wrong home on subject grounds too.

**Recommended repair (not applied, I edited nothing):** keep the number **55**, move its block to `bispectral.md` absorbing L93's surviving material (the $\sqrt n$ identity of §5, the loose-factor analysis, the odd-$n$ constant of §4), and mark **93 WITHDRAWN, duplicate of 55** in `INDEX-results.md`, which already has the `WITHDRAWN` form at row 14.

*One inconsistency to fix alongside: [LEDGER.md:51](../findings/LEDGER.md) records "Gate 2 LANDED (Reviewers 105 and 106)" for the min-entry lemma, while row 93 of the results index says no verdict is on the record. Both describe the same block.*

---

## 2. The inequality, CONFIRMED, and it is stronger than the block states

Rebuilt cold. Write $m=\lvert\min_{a\ne b}K_{ab}\rvert$ and assume $K\ne0$.

**Step 1 (the row, which is the asserted step).** Fix $a$. Hollowness plus the zero row sum makes the $M=n-1$ off-diagonal entries of row $a$ sum to $0$; each is $\ge-m$, hence each is also $\le(n-2)m$, so the row lies in the **bounded** polytope $P=\{x\in\mathbb R^{M}:\sum x=0,\ x\ge-m\}$. A vertex of $P$ needs $M-1=n-2$ of the sign constraints active, so its vertices are exactly the $n-1$ points with one coordinate $(n-2)m$ and the rest $-m$. The row norm $s_a=\sum x_b^2$ is convex, so it is maximised at a vertex:
$$s_a\ \le\ (n-2)^2m^2+(n-2)m^2\ =\ (n-1)(n-2)m^2 .$$

**Step 2.** $\sum_a s_a=\lVert K\rVert_F^2=t$, so $t\le n(n-1)(n-2)m^2$, i.e. $m\ge\sqrt{t/(n(n-1)(n-2))}$. $\square$

**Three things this settles that the block leaves open.**

- **The heart of the block's own proof is asserted, and it is asserted in the direction that needs the argument.** The block's sentence *"the configuration minimising $\lvert\min y\rvert$ is $M-1$ equal negatives against a single positive"* is a claim about a minimiser, from which the inequality is then read off; the polytope step above is the proof of that claim, and the block gives none. The fact is true. **What is owed is one paragraph, and it is already written, in [L55](../findings/diagonal-half.md).**
- **The displayed vector is the wrong configuration under its natural reading.** The block writes $y=(\alpha,\dots,\alpha,-(M-1)\alpha)$ ($M-1$ copies of $\alpha$ against one $-(M-1)\alpha$) and calls it "$M-1$ equal negatives against a single positive". The two descriptions agree only at $\alpha<0$, which is unstated. At $\alpha>0$ the same display gives $\lvert\min y\rvert=\sqrt{s(M-1)/M}$, which is the **maximum** of $\lvert\min y\rvert$, too large by the factor $M-1=n-2$. *This is the same unstated sign, and the same factor $n-2$, that the sibling audit found in the extremiser, the block carries it twice.*
- **"An entry of modulus at least" does not give the conclusion.** The block concludes step 1 with *"row $a$ contains an entry of modulus at least $\sqrt{s_a/((n-1)(n-2))}$"*, and a large **positive** entry would satisfy that while saying nothing about $\min_{a\ne b}K_{ab}$. What the argument actually establishes, and what the next line needs, is an entry $\le-\sqrt{s_a/((n-1)(n-2))}$. A one-word repair, but as printed the last step does not follow.

**The passage from one row to the matrix is correct, and there is no double count to fix.** $\sum_a s_a=\sum_a\sum_{b\ne a}K_{ab}^2$ runs over **ordered** pairs and equals $\lVert K\rVert_F^2=t$ exactly. The factor the brief asks about would appear only if $t$ were the unordered sum, in which case $\sum_a s_a=2t$ and the constant would be $n(n-1)(n-2)/2$. Both blocks use $\lVert K\rVert_F^2$, so both are right.

**Which hypotheses are consumed, symmetry is NOT one of them.** Confirmed here independently of the sibling. Step 1 reads one row at a time and never compares $K_{ab}$ with $K_{ba}$; step 2 is an identity for any matrix. So:

> The inequality holds for **every hollow matrix with zero row sums**, symmetric or not.

**And this is not idle.** Without symmetry the constant is sharp at **odd** $n$ too: at $n=3$, $m=1$, the directed $3$-cycle $K_{12}=K_{23}=K_{31}=1$, $K_{13}=K_{21}=K_{32}=-1$ is hollow with zero row sums, has $t=6=n(n-1)(n-2)$ and $m=1$, attaining the bound. **Symmetry is the sole source of the parity obstruction**, it is what turns the fixed-point-free permutation into an involution (§3). **The block states symmetry as a hypothesis and never says it is unused**, so the lemma is weaker on the record than in fact.

**Also unstated: $n\ge3$.** At $n=2$ the constant is $t/0$; the statement is vacuous there ($K=0$ forced) but undefined as printed.

**The absolute value is cosmetic for $K\ne0$.** Any row with a nonzero entry has off-diagonal entries summing to $0$, hence a strictly negative one; so $\min_{a\ne b}K_{ab}<0$ whenever $K\ne0$, and $\lvert\min\rvert=-\min$. At $K=0$ it is $0$, which matters in §3.

---

## 3. The equality case, REFUTED as written, by both of the sibling's witnesses

L93's wording carries **both** omissions the brief asks about.

**(a) The sign of $c$ is missing, and at $c<0$ the display misses by $n-2$.** The block says the matrix "$K_{ab}=(n-2)c$ on a fixed-point-free involution and $-c$ elsewhere **makes both steps of the proof tight at once**". At $c<0$ it satisfies every stated hypothesis (hollow, symmetric, zero row sums, $\lVert K\rVert_F^2=n(n-1)(n-2)c^2$) and its most negative entry is $(n-2)c$, so $\lvert\min\rvert=(n-2)\lvert c\rvert$ against a bound of $\lvert c\rvert$. Neither step is tight: with $m=(n-2)\lvert c\rvert$ the row polytope allows $(n-1)(n-2)^3c^2$ and the row delivers $(n-1)(n-2)c^2$, a slack of $(n-2)^2$. **Screen** (seconds, on a matrix built for the purpose): $n=6$, $c=-1$ gives $t=120$, $\lvert\min\rvert=4$, bound $1$, a factor $4=n-2$. **The clause needs $c>0$.**

**(b) $K=0$ attains equality at every $n$, odd included.** The block's display
$$\min_{\lVert K\rVert_F^2=t}\lvert\min_{a\ne b}K_{ab}\rvert=\sqrt{t/(n(n-1)(n-2))}\quad(n\text{ even}),\qquad\text{"not attained at odd }n\text{"}$$
is false at $t=0$, where both sides are $0$ and the attaining matrix is not a matching. **The clause needs $t>0$.**

**(c) Uniqueness is asserted, after a chain whose tightness conditions are never written down.** The block verifies the *converse* (that the matching matrix attains the bound) and then says equality "forces" a matching. The forcing direction appears nowhere. It is true, and here is what it costs:

1. **Every row is at a vertex.** L93's chain runs through $\max_a s_a\ge t/n$, so its tightness conditions are: all $s_a$ equal, *and* the maximal row at a vertex. Since equality gives $s_a=t/n=(n-1)(n-2)m^2$ for **every** $a$, and $s_a\le(n-1)(n-2)m^2$ is the polytope maximum, every row is at a vertex, one entry $(n-2)m$, the other $n-2$ entries $-m$. *(L55's summing chain reaches this in one step; L93's needs the equal-$s_a$ observation first. Neither block states either.)*
2. **The map $\sigma(a)=$ the unique $b$ with $K_{ab}=(n-2)m$ is well defined** provided $(n-2)m\ne-m$, i.e. $m>0$ and $n\ge3$, which is where $t>0$ re-enters.
3. **$\sigma$ is injective, and this is the step that consumes symmetry.** If $\sigma(a)=\sigma(a')=b$ with $a\ne a'$ then $K_{ba}=K_{ab}=(n-2)m$ and $K_{ba'}=(n-2)m$, so row $b$ has two large entries, contradicting (1). **Without symmetry nothing forbids this**, which is exactly why the directed $3$-cycle of §2 attains the bound at odd $n$.
4. **$\sigma$ is fixed-point-free** by hollowness, and **an involution** by symmetry again: $K_{ab}=(n-2)m\Rightarrow K_{ba}=(n-2)m\Rightarrow\sigma(b)=a$.
5. A fixed-point-free involution on $n$ points exists **iff $n$ is even**.

**So the correct statement is:** *for $t>0$ and $n$ even, equality holds exactly on $\{K_{ab}=(n-2)c$ on a fixed-point-free involution, $-c$ elsewhere$\}$ with $c>0$; symmetry is used only here.*

---

## 4. Parity, the sharp odd-$n$ constant is not open, and the block's $n=9$ value is wrong

The block prints the odd-$n$ shortfall as three measured ratios, $\sqrt{5/3}$, $1.16024$, $1.11153$ at $n=5,7,9$. It has a closed form, in four lines.

**Reparametrise.** Fix $m=1$ and maximise $t$. The set $\{K$ symmetric, hollow, zero row sums, $K\ge-1\}$ is carried bijectively by $K_{ab}=-1+(n-1)x_{ab}$ onto $\{x\ge0$ symmetric, hollow, $\sum_bx_{ab}=1\}$, **the fractional perfect matching polytope of $K_n$**. Then, with $X=\sum_{a\ne b}x_{ab}^2$ and $\sum_{a\ne b}x_{ab}=n$,
$$t=\sum_{a\ne b}\bigl(-1+(n-1)x_{ab}\bigr)^2=-n(n-1)+(n-1)^2X .$$

**$X$ is convex, so its maximum sits at a vertex, and by Balinski's theorem the vertices are half-integral**: a matching at $x=1$ together with vertex-disjoint odd cycles at $x=\tfrac12$, spanning. A cycle of odd length $k$ contributes $k/2$ where a matching on the same $k$ vertices would contribute $k$, so $X=n-\tfrac12\sum_i k_i$ and the maximum takes **one** cycle, of the shortest odd length $3$:

$$X_{\max}=\begin{cases}n,&n\text{ even}\\[2pt] n-\tfrac32,&n\text{ odd}\end{cases}\qquad\Longrightarrow\qquad t_{\max}=\begin{cases}n(n-1)(n-2)\\[2pt]\tfrac12(n-1)(2n-1)(n-3)\end{cases}$$

**So at odd $n$ the sharp constant is** $\ \lvert\min_{a\ne b}K_{ab}\rvert\ \ge\ \sqrt{\dfrac{2t}{(n-1)(2n-1)(n-3)}}$, a factor

$$\sqrt{\frac{2n(n-2)}{(2n-1)(n-3)}}$$

above the stated bound. This gives $\sqrt{5/3}$ at $n=5$, $\sqrt{35/26}=1.1602387$ at $n=7$, $\sqrt{21/17}=1.1114379$ at $n=9$.

**Two of the block's three ratios are right and the third is wrong.** $\sqrt{5/3}$ ✓, $1.16024=\sqrt{35/26}$ ✓, and $1.11153$ against $\sqrt{21/17}=1.111438$, a discrepancy of $1.2\times10^{-4}$, far outside the printed precision. *Reached here from the polytope rather than from the sibling's report, which I did not read.*

**Screen** (seconds, on a matrix built for the purpose): at $n=5$ the triangle-plus-edge vertex gives $K$ with zero row sums, $\min=-1$ and $t=36=\tfrac12\cdot4\cdot9\cdot2$, ratio $\sqrt{5/3}$, the record's own $n=5$ figure, from the closed form.

**So: bound true at odd $n$, unattained for $t>0$, and the sharp odd constant is known rather than open.** The even and odd cases are one formula in $X_{\max}$, and the parity is the parity of the perfect matching polytope's vertices.

---

## 5. "Why it matters", REFUTED by the block's own file, eleven lines above it

The block justifies itself as *"the analytic replacement for the sampled feasibility sweep … Combined with the $\psi$-block identity $d_\psi=-\operatorname{spec}(K|_{\mathbf1^\perp})$ it forces $\max d$ away from zero."*

**The same one-row extremal fact, applied to the spectrum instead of to a row, is stronger by $\sqrt n$, and [bispectral.md](../findings/bispectral.md) already states it, eleven lines above L93.** Since $K\mathbf1=0$ and $\operatorname{tr}K=0$, the $n-1$ eigenvalues on $\mathbf1^\perp$ sum to $0$ and have $\sum\mu_i^2=t$. The $M=n-1$, $s=t$ case of the very configuration lemma L93 proves gives
$$\max d=\lvert\min_i\mu_i\rvert\ \ge\ \sqrt{\frac{t}{(n-1)(n-2)}},$$
which is exactly the constant the preceding paragraph of that file prints, and it is $\sqrt n$ times L93's. The entry route cannot beat it: interlacing on the hollow $2\times2$ principal submatrix gives $\lambda_{\min}(K)\le-\lvert K_{ab}\rvert$, so the min-entry bound implies only the $\sqrt n$-weaker spectral statement.

**So L93 is not the analytic replacement for the sweep.** The statement that does that job needs no entry bound, no hollowness, and no perfect matching, only $K\mathbf1=0$, $\operatorname{tr}K=0$ and the same extremal configuration. *The checklist item paid again: the answer was in the same file, above the block.*

---

## 6. Provenance of the block's self-historical note, **CLEAN**

> *"Derived, then checked, not established by search. Reviewer 104 reached this statement before being killed mid-run; its partial is not citable, so the proof below is this cycle's own."*

Every clause checks out, which breaks the pattern the brief warns of.

| clause | check |
| --- | --- |
| there was such a run | [REVIEW_r104.md](REVIEW_r104.md) exists, [reviews/INDEX.md:207](INDEX.md) rows it as `PARTIAL`, salvaged 2026-08-26 from a log at the moment it was stopped |
| it reached this statement | its 14:37:08 line reads *"Found analytic sharp lemma \|min K\| >= sqrt(t/(n(n-1)(n-2)))"*, the statement and the constant |
| the partial is not citable | the salvage file says so itself: *"none of it should be cited as a verdict"* |
| the proof here is this cycle's own | the partial is **nine log lines and contains no proof**; the salvage landed at 16:08:41 and the block at 16:11:17 (`aad4a1be` → `b1117290`), so the proof could only have been written here |
| "not established by search" | the block's argument is a derivation, and the search it distinguishes itself from is the sampled feasibility sweep it replaces |

**One repair owed:** the note names Reviewer 104 and links nothing. [REVIEW_r104.md](REVIEW_r104.md) is on the record and should be linked, precisely so the "not citable" claim is checkable without `git`.

*Two further hedges checked. "Sharp at even $n$", true, once $c>0$ and $t>0$ are supplied (§3). "It is loose, by a factor that is now located … at the balanced sphere product's own $K$ it is exactly $\sqrt n$", **true, and derivable rather than measured**: on $K_{m,m}$ with $n=2m$, $K$ takes $a>0$ across factors and $-am/(m-1)$ within, so $\lvert\min\rvert=am/(m-1)$ and $s_a=ma^2(2m-1)/(m-1)$, whose ratio is $\sqrt{2m}=\sqrt n$ exactly. It holds on the $a>0$ branch only (on $a<0$ the ratio is $(m-1)\sqrt2/\sqrt m$) which is **the third place in this block where an unstated sign changes the answer.***

---

## 7. What is owed, and whether it is reachable

| # | owed | reachable? |
| --- | --- | --- |
| 1 | **Retire the number.** 93 is a second number for a result already numbered 55; mark it `WITHDRAWN, duplicate of 55` and keep the block's surviving material under 55, in `bispectral.md` | yes, editorial, nothing outside `reviews/` and the two index rows cites 93 |
| 2 | The row-extremal step needs its proof (the polytope argument) | **already written**, in L55 |
| 3 | $c>0$ and $t>0$ in the equality clause; the five-step forcing argument | yes, §3 above |
| 4 | Say that symmetry is unused by the inequality, and that it is the sole source of the parity obstruction | yes, §2 |
| 5 | Fix $\alpha$'s sign in the displayed configuration, and "modulus at least" → "at most $-\,$" | yes, two words |
| 6 | Replace the three measured odd-$n$ ratios with the closed form; **correct $n=9$ from $1.11153$ to $\sqrt{21/17}$** | yes, §4 |
| 7 | Withdraw or restate "Why it matters" (the file's own $\psi$-block statement is $\sqrt n$ stronger | yes), §5 |
| 8 | State $n\ge3$ | yes |
| 9 | Reconcile [LEDGER.md:51](../findings/LEDGER.md) ("Gate 2 LANDED") with row 93 of [INDEX-results.md](../findings/INDEX-results.md) ("no verdict on the record") | editorial |

**Nothing here needs computation.** The two screens named above were run on matrices constructed for the purpose, in seconds, and each only re-checks a witness the argument already exhibits; no positive claim in this report rests on either.
