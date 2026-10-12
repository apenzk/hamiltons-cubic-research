# Review r671, Lemma L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$

**Review number: r671.** Reviewer A of a two-reviewer pair on identical cold briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md), the block headed [Lemma L85](../findings/sym3-blocks.md#L68) at line 68 and its section [The constraint count](../findings/sym3-blocks.md#L70), lines 70–74; plus the trivial-multiplicity sentence the brief assigns to it, which is at [line 42](../findings/sym3-blocks.md#L42).

**Analysis-only footing.** No search, sweep, census, plethysm or decomposition run was made, and **no script of the record was executed**, [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) was read line by line and audited as source, never run, so its output is treated throughout as testimony. No screen was taken; none was needed, every derivation below being by hand. Provenance was traced with `git log -S` and `git show`, which is reading.

## Verdict: GAP, the $14$ stands, as a measurement with an honest label; one clause of the block is false, and the $O(5)$ step the block needs is nowhere in it

| clause | standing |
| --- | --- |
| $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | **measured**, by an exact deterministic Weyl integration whose code I audited and which does **not** hardcode. Independently corroborated from below at $14$; the upper bound is single-sourced |
| the degree sequence $1,1,4,5,14$ | **the same single run.** Two of its five entries are hand-forced ($1$ at degree $2$, $1$ at degree $3$); three are testimony. The $14$ **is** the sequence's last entry, not a reconciliation of it |
| *"Every entry is strictly smaller"* ([line 60](../findings/sym3-blocks.md#L74)) | **FALSE, with a hand witness.** Degree $2$ is $1$ at $n=5$ and $1$ in the stable range, and the equality is **forced** |
| the trivial multiplicity is $1$ at $n\le5$, $2$ from $n\ge6$ | **true, and supported, at [ATTEMPTS.md](../ATTEMPTS.md), uncited.** The block's one-line reason is a non-sequitur without a step it does not name |
| *"parity-sensitive"* | **misdescription.** The collapse is a threshold at $n=6$, not an even/odd effect |
| $O(5)$ against $SO(5)$ | **unstated, and the brief's own proposed bridge is insufficient.** The displayed formula computes $SO(5)$-invariants |

**[L59](../findings/sym3-blocks.md#L183) and [L62](../findings/sym3-blocks.md#L227) may rest on the $14$ as they do**, the object matches, the dependency is one-directional, and there is no cycle. What they inherit with it is its standing: an exact machine computation, not a hand derivation. §7 states this precisely.

## 1. Readings adopted

[conventions.md](../findings/conventions.md) carries none of this block's symbols, so every reading below is mine and is stated so the other reviewer can disagree with it.

| symbol | reading |
| --- | --- |
| $\mathcal W_5$ | [conventions.md](../findings/conventions.md)'s space of algebraic Weyl curvature operators on $\mathbb R^5$, $\dim=\tfrac{5\cdot2\cdot6\cdot7}{12}=35$, the $O(5)$-irreducible of partition $(2,2)$ |
| $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | the $O(5)$-invariants inside the sixth symmetric power. Identified with the **invariant sextic polynomial functions** on $\mathcal W_5$ through the invariant inner product, $\mathcal W_5$ being self-dual. **The record uses the two interchangeably and states the identification nowhere**, [L89](../findings/sym3-blocks.md) writes $\mathrm{Sym}^6\mathcal W_5^*$ where L85 writes $\mathrm{Sym}^6\mathcal W_5$. It is automatic and costs no number |
| the degree sequence | $\dim(\mathrm{Sym}^k\mathcal W_5)^{O(5)}$ for $k=2,\dots,6$ |
| the stable range | $\dim(\mathrm{Sym}^k\mathcal W_n)^{O(n)}$ at $n$ large; $0,1,2,7,19,89$ for $k=1,\dots,6$, the sequence [c1_haar_moments.py](../scripts/reviewers/r239/c1_haar_moments.py) checks by Haar integration. So degrees $2$–$6$ read $1,2,7,19,89$, matching the block |
| trivial multiplicity | the multiplicity of the trivial $O(n)$-module in $\mathrm{Sym}^3(\mathcal W_n)$, i.e. $\dim(\mathrm{Sym}^3\mathcal W_n)^{O(n)}$ |
| $W^\#$, $Q$, $\langle\cdot,\cdot\rangle$ | [conventions.md](../findings/conventions.md)'s: $Q(W)=W^2+W^\#$, the $\tfrac12$ at the $\Lambda^2$ level, under which $\langle W,W^2\rangle=\operatorname{tr}(W^3)$. Needed only for §3 |

## 2. Is the $14$ derived, imported or measured?, **measured, and the block says so**

**Measured, by exact Weyl integration in [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py).** The brief asks whether it has the shape of support the neighbouring [L83](../findings/sym3-blocks.md) headline was found to have, a false *"no linear algebra is involved"* over a script that hardcodes its answer. **It does not, and the difference is worth recording as plainly as the defect was.** I read the script in full:

- the $B_2$ character of $\lambda=(2,2)$ is built from the Weyl character formula as a ratio of alternants, in exponents doubled to clear $\rho$, with $2\rho=(3,1)$, correct for $B_2$ in the $e$-basis, and the same $\rho$ the file's own [L84](../findings/sym3-blocks.md) was corrected to;
- the specialisation to $t=1$ is asserted to be $35$;
- $\mathrm{Sym}^k$ characters come from $p_j(t)=\chi(t^j)$ by Newton's $h_k=\tfrac1k\sum_{j=1}^kp_jh_{k-j}$, with $t\mapsto t^j$ implemented as $(a,b)\mapsto(ja,jb)$ on doubled exponents, correct, since a stored exponent is $2\mu$ and $2(j\mu)=j\cdot 2\mu$;
- the eight roots $\pm e_1,\pm e_2,\pm e_1\pm e_2$ are all of $\Phi(B_2)$, applied as $+2\alpha$ on doubled exponents, and the constant term is divided by $|W(B_2)|=8$.

That is Weyl's integration formula, correctly implemented, with **the answer computed rather than asserted**. There is no hardcoded $14$ anywhere in the file, and no table read from a pickle. So the block's *"By Weyl integration in exact Laurent polynomials … the answer is $14$"* names its method and cites its script, and is honest.

**It remains a measurement, and the record should not read the $14$ as given.** It is an exact, deterministic, integer computation, a stronger form of testimony than a sample or a floating-point fit, and a different class from the mod-$p$ rank [r633](REVIEW_r633.md) separated out of [L62](../findings/sym3-blocks.md), but no human has checked it, and it is stated in the record under a `Lemma` heading. **Under the record's literal labels this block is an `Observation`.** *[r633](REVIEW_r633.md) reached the same reading in passing while auditing L62; I reached it before reading that line and hold it.*

**Provenance, traced.** [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) arrives whole in `9fe61d96`, whose message records the honest history: *"reviewer 175 found '36 unknowns against 14 constraints' carrying a 14 that had never been written down"*. **So the $14$ was first an import with no source at all, and the script was written to close that hole.** The block text arrives in `b432dfd7` and the `#### Lemma 85` heading in `8d869d2c`, whose *"headings only"* promise **holds here**, the heading was inserted above the pre-existing section and nothing else in the block moved. *Provenance clean, which the brief warns is rare in this file.*

**One corroboration exists and the block never cites it.** [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) builds $14$ complete metric contractions of $W^{\otimes6}$ whose evaluation vectors at $40$ Weyl tensors are independent over $\mathbb F_{10007}$. A mod-$p$ evaluation rank is a lower bound for the characteristic-zero span, so that is $\dim\ge14$ **by the first fundamental theorem for $O(n)$, sharing nothing with the character-theoretic route**. It stalls at $14$ rather than proving it cannot exceed $14$, so:

> **The $14$ is two-sourced from below and one-sourced from above.** The lower bound $\ge14$ has an independent diagram-theoretic witness; **the upper bound $\le14$ rests on [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) alone.** The record nowhere says which half is which, and the block cites neither script but its own.

## 3. The Lovelock collapse

### 3.1 The identity, and why $n=6$ breaks it

$P(W)=\langle W,Q(W)\rangle=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$, so the two cubic $O(n)$-invariants in play are $s=\operatorname{tr}(W^3)$ and $t=\langle W^\#,W\rangle$, the two independent complete contractions of $W^{\otimes3}$. The claim $t=2s$ at $n\le5$ is [L50](../findings/bispectral.md#L118)'s, and its mechanism is Lovelock's dimensionally-dependent identity: $t-2s$ is, up to a constant, the full contraction of the generalised Kronecker delta $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ against $W\otimes W\otimes W$, and **a totally antisymmetric object on six indices has no nonzero component when only $n\le5$ index values exist**. At $n\ge6$ the delta is not identically zero and the two contractions separate.

**I confirm the mechanism and I do not confirm the constant by hand.** The factor $2$ sits inside the $720$-term expansion of that delta ([bispectral.md](../findings/bispectral.md#L118)'s $-\tfrac1{64}$), which is a computation and is out of scope here. What I can add is that the constant is over-determined on the record: it is fixed at $n=4$ by the conceptual $\mathrm{Sym}^2_0\Lambda^+\oplus\mathrm{Sym}^2_0\Lambda^-$ argument, and screened at $n=4,5$ against failure at $n=6,7$ by [r282](REVIEW_r282.md).

### 3.2 Does the multiplicity really go $1\to2$?, **yes, and the support is at [ATTEMPTS.md](../ATTEMPTS.md), which the block does not cite**

The complete statement is at [ATTEMPTS.md](../ATTEMPTS.md) Result 2: $0$ at $n\le3$, $\mathbf1$ at $n=4,5$, $\mathbf2$ at $n\ge6$. I rebuilt its logic and it is the right shape:

1. **$\le2$ at *every* $n$.** By the first fundamental theorem for $O(n)$, which [brauer-pairing.md](../findings/brauer-pairing.md#L50) correctly notes holds at every $n$ with no threshold, every cubic invariant is a combination of complete contractions of $W^{\otimes3}$. The span of those contractions can only *shrink* as $n$ decreases, since relations are added and never removed, and in the stable range it is $2$ (the Newell–Littlewood number $N_{(2,2),(2,2),(2,2)}=2$). **So $\dim\le2$ unconditionally.**
2. **$\ge2$ at $n=6$**, by exhibiting $s$ and $t$ independent there, exact integer arithmetic on the polarisation, plus [r282](REVIEW_r282.md)'s screen.
3. **$\ge2$ at every $n\ge6$**, by zero-extension: $\mathcal W_6\subset\mathcal W_n$ and both contractions restrict, so independence is monotone upward.
4. **$=1$ at $n=4,5$**: $\ge1$ because $s\not\equiv0$, $\le1$ by the Lovelock relation of §3.1 together with the spanning of step 1.

**Steps 1 and 4 are exactly what the block's "so" omits.** The block writes *"at $n\le5$, $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$, so the cubic invariant space is one-dimensional"*. The identity alone says two named invariants are proportional; **it says nothing about a third**. Without the FFT spanning step the conclusion does not follow, and that step is on the record, in [ATTEMPTS.md](../ATTEMPTS.md), a file [conventions.md](../findings/conventions.md) elsewhere treats as citable, and not in [findings/](../findings/) at all.

### 3.3 *"Parity-sensitive"* is the wrong word, and this record has trained its readers to misread it

The collapse holds at $n=4$ **and** $n=5$, and fails at $n=6$ **and** $n=7$. It is a **threshold at $6$**, produced by an antisymmetrisation over $n+1$ indices, no even/odd distinction anywhere in it. Meanwhile [conventions.md](../findings/conventions.md)'s $\theta_0(n)$ row is about a genuine parity effect in $n$, and [L86](../findings/sym3-blocks.md#L90) fourteen lines below L85 calls $\lambda_2$-evenness *"the parity rule"*. **A reader of this record arrives at the word already primed to read it as even/odd $n$, and here that reading is false.** The phrase is duplicated verbatim into [report/sections/07-gradedness-split.tex:892](../report/sections/07-gradedness-split.tex#L892), so the repair is two-sited.

### 3.4 Circularity against the companion audit, **none, and the record is one sentence away from manufacturing some**

[r598](REVIEW_r598.md), today's [L61](../findings/sym3-blocks.md#L208) audit, runs the implication **the other way**: from L85's degree-$3$ entry $\dim(\mathrm{Sym}^3\mathcal W_5)^{O(5)}=1$ it concludes $s$ and $t$ proportional, then fixes the constant by one evaluation to get $P=3\operatorname{tr}(W^3)$. So the record now holds both arrows:

| arrow | premise's own anchor |
| --- | --- |
| $t=2s\;\Rightarrow\;\dim=1$, [sym3-blocks.md:42](../findings/sym3-blocks.md#L42) | Lovelock's six-index identity, [L50](../findings/bispectral.md#L118). **Independent of any dimension count** |
| $\dim=1\;\Rightarrow\;t\propto s$, then $t=2s$, [r598](REVIEW_r598.md) §Route 1 | the Weyl integration of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py). **Independent of any contraction identity** |

**Each premise has its own anchor, so the pair is not circular**, it is a genuine two-way cross-check, and [line 60](../findings/sym3-blocks.md#L74)'s *"by a method sharing nothing with the contraction identity that first gave it"* is the correct statement of why. **The circle closes the moment either anchor is dropped from a citation**, which is a live risk given that neither arrow cites the other's anchor: line 42 cites nothing at all, and r598 cites L85 without noting that L85's degree-$3$ entry is character-theoretic.

**One overstatement, in the block under audit.** Line 60 says the degree-$3$ entry *"reproduces the Lovelock collapse"*. It reproduces the collapse's **dimensional consequence**. It does not reproduce the identity: $\dim=1$ gives $t=cs$ for *some* $c$, and the record's Lovelock collapse is the statement $c=2$. **The constant is strictly more than the dimension count contains**, and r598 has to supply an evaluation for exactly that reason. Sharpen to *"reproduces the collapse's dimension count"*.

## 4. The degree sequence, one computation, presented as one computation, and carrying a false universal

**What it is a sequence of:** $\dim(\mathrm{Sym}^k\mathcal W_5)^{O(5)}$ at $k=2,\dots,6$.

**How it reconciles to the $14$: it does not, the $14$ *is* its last entry.** The entries do not sum ($1+1+4+5=11$, and $1+1+4+5+14=25$). The heading, the sentence *"the answer is $14$"*, and the sequence are **three renderings of one loop over $k$ in one script**, and the brief's worry is well placed: a reader who takes the sequence as corroborating the total is corroborating a number with itself. **To the block's credit it never claims otherwise**, unlike the neighbouring [L83](../findings/sym3-blocks.md) headline, it advertises no independent closures.

**Two entries are hand-forced, and one of them refutes a stated clause.**

> **REFUTED, with a witness a reader can check in one line: *"Every entry is strictly smaller"* is false at degree $2$.** The block puts $1,1,4,5,14$ against the stable-range $1,2,7,19,89$; at degree $2$ these are $1$ and $1$. **The equality is not an accident but forced.** $\mathcal W_n$ is an absolutely irreducible real $O(n)$-module, so $\mathrm{End}_{O(n)}(\mathcal W_n)=\mathbb R$ and the invariant symmetric bilinear forms on it are the scalars: $\dim(\mathrm{Sym}^2\mathcal W_n)^{O(n)}=1$ at **every** $n\ge4$, the stable range included, $\lVert W\rVert^2$ spanning it. So no computation could ever have made degree $2$ drop, and the sentence is false at the one entry where it had to be.

The error is **inherited verbatim**: `git log -S'Every entry is strictly smaller'` returns the single commit `b432dfd7`, which copied the wording from `9fe61d96`'s bullet *"Every entry is strictly smaller, which is the syzygies"*. **It has stood since 2026-08-28 and no audit has touched it.**

*The clause is true of degrees $3,4,5,6$ ($1<2$, $4<7$, $5<19$, $14<89$) and the attributed cause, dimension-dependent syzygies, is right for those four. The repair is one word: "Every entry from degree $3$ on is strictly smaller", with degree $2$ noted as forced equal.*

**Degree $3$ is the other hand-forced entry**, at $1$, by §3. It is also the file's own cross-check against [L83](../findings/sym3-blocks.md)'s table, whose $(0,0)$ block carries multiplicity $1$, **a genuine agreement between two computations that share no method**, claimed correctly in [L83](../findings/sym3-blocks.md#L25)'s audit note and not in L85's block. **Degrees $4$, $5$ and $6$ have no hand check at all**, and the $14$ is the one the record consumes.

*A consistency test the entries do pass, offered because it could have failed.* Reading $1,1,4,5,14$ as a Hilbert function: with generators $q$ in degree $2$ and $c$ in degree $3$, degree $4$ admits $q^2$ and so needs $3$ new generators, degree $5$ admits $qc$ and needs $4$, and degree $6$ admits at most $q\cdot(\text{degree }4)$ and $c^2$ (five decomposables), leaving $9$ new. Every count is non-negative and the total, $18$ generators through degree $6$, sits below the transcendence degree $35-\dim SO(5)=25$ that the invariant field must have. **Nothing here proves $14$; a value below $5$ would have been refuted by it.**

## 5. $O(5)$ against $SO(5)$, the step is real, the block omits it, and **the brief's own version of it is insufficient**

**The displayed formula is the connected-group one.** $\dim V^G=\tfrac1{|W|}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$ is Weyl integration over a **connected** compact group with Weyl group $W$ and root system $\Phi$; with $|W(B_2)|=8$ and $\Phi(B_2)$ it computes $\dim V^{SO(5)}$. **The block writes $O(5)$ in its heading, in its statement and in its sequence, and never bridges the two.**

**The bridge, and it is not the brief's.** The brief proposes: at odd $n$, $\det(-I)=-1$, so $O(5)=SO(5)\times\{\pm I\}$ and *even-degree* invariants coincide. The first half is right; **the second half does not cover this block.** "Even degree" is the correct bridge for the *standard* representation, where $-I$ acts by $-1$. Here $\mathcal W_5$ sits in $\bigotimes^4\mathbb R^5$, so

$$(-I)\cdot W=(-1)^4W=W,$$

**$-I$ acts trivially on $\mathcal W_n$ at every $n$**, and at odd $n$ therefore

$$(\mathrm{Sym}^k\mathcal W_5)^{O(5)}=(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}\qquad\text{for every }k,\text{ odd and even alike.}$$

**This matters rather than being pedantry: the degree sequence contains degrees $3$ and $5$, which are odd.** Under the brief's version of the step, the entries $1$ and $5$ at those degrees would be $SO(5)$ numbers carrying no $O(5)$ claim, and the degree-$3$ entry is precisely the one [r598](REVIEW_r598.md) and [L83](../findings/sym3-blocks.md) consume as an $O(5)$ statement. *The stronger reason repairs that; the brief's does not.*

**And it fails at even $n$, as the brief says.** There $-I\in SO(n)$, so $O(n)\ne SO(n)\times\{\pm I\}$; the quotient is generated by a reflection $\varepsilon$, which acts non-trivially on $\mathcal W_n$, at $n=4$ it swaps $\Lambda^+$ and $\Lambda^-$, and the two $SO(4)$-cubic invariants it exchanges are exactly why $\mathcal W_4$ has one $O(4)$-cubic invariant rather than two.

**Where the record already holds the missing sentence, three places, none of them the block.**

| site | what it says |
| --- | --- |
| [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), the print at the foot | *"this is the SO(5) integration; O(5) = SO(5) x {+-Id} and -Id acts trivially on Weyl_5, so the two agree here"*, **the exact argument, in the script and not in [findings/](../findings/)** |
| [L86](../findings/sym3-blocks.md#L90), fourteen lines below | *"every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially"*, which forces the same conclusion, $-I$ acting on an irreducible by a scalar $\varepsilon$ with $\varepsilon^3=1$ |
| [L83](../findings/sym3-blocks.md#L27)'s audit note | flags the identical omission for the block table, and gives the weaker $\det(-I)=-1$ reason |

**So the brief's checklist question, "does the block's own file already settle it, below?", answers yes, at [line 76](../findings/sym3-blocks.md#L90), and this is the sixth time today in this file.**

## 6. Scope

**$n=5$ alone, and the file is right about that.**

**Licensed.** The constraint count for the $n=5$ SOS certificate; the target dimension in [L89](../findings/sym3-blocks.md)'s $\mathrm{rank}=14$, nullity $65-14=51$; [L59](../findings/sym3-blocks.md#L183)'s $\mathrm{rank}=14-\dim\mathrm{ANN}$; [L62](../findings/sym3-blocks.md#L227)'s $\mathrm{rank}\le13$; and the identity step of the $\Theta_5=\sqrt{3/2}$ certificate, where [report/sections/07-gradedness-split.tex:883](../report/sections/07-gradedness-split.tex#L883) needs *"$120$ explicit invariant sextics have rank $14$ against a cap of $14$"*, **that cap is L85's, and if the true dimension exceeded $14$ the injectivity-of-evaluation step fails.**

**Not licensed.** Anything at $n\ge6$. The file states this correctly at [line 167](../findings/sym3-blocks.md#L181), and gives the reason: trace-word transfer needs the stable range, which $n=5$ is outside of. The stable-range comparison sequence $1,2,7,19,89$ is a *contrast*, not a bound being approached.

**The $n\ge6$ half of the multiplicity sentence: supported, not asserted, but not from anywhere the sentence points.** §3.2 above is its proof, and it lives at [ATTEMPTS.md](../ATTEMPTS.md) Result 2. **Neither the sentence at [line 42](../findings/sym3-blocks.md#L42) nor its duplicate at [line 167](../findings/sym3-blocks.md#L181) cites it, or anything.** Inside [findings/](../findings/) the reader can reach the $\le2$ upper bound only by assembling [brauer-pairing.md](../findings/brauer-pairing.md#L50)'s FFT with [sym3-stability.md](../findings/sym3-stability.md#L9)'s Newell–Littlewood, neither of which is about cubic invariants.

## 7. **May [L59](../findings/sym3-blocks.md#L183) and [L62](../findings/sym3-blocks.md#L227) rest on the $14$ as they do?**

**Yes, with one qualification each, and no cycle.**

- **The object matches.** Both speak of *"the $14$-dimensional space of invariant sextics"*, i.e. $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$, while L85 states $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. These agree because $\mathcal W_5$ is self-dual as an $O(5)$-module. **The identification is stated nowhere on the record.** It is automatic and changes no number.
- **Neither adds a hypothesis.** L62's cap is $14$ minus the codimension of one point condition, needing only that $\mathrm{ev}_{W_0}$ is a nonzero functional on the $14$, which $\lVert W\rVert^6$ witnesses, itself an element of the $14$ by the degree-$2$ entry cubed. L59's $\mathrm{rank}=14-\dim\mathrm{ANN}$ is rank–nullity for the adjoint of $\mu$ against a $14$-dimensional target. **Both consume exactly the number L85 claims and nothing more.**
- **There is no cycle.** L85's support is the $B_2$ character of $(2,2)$ and Weyl integration. It consumes nothing from [L59](../findings/sym3-blocks.md), [L62](../findings/sym3-blocks.md), [L83](../findings/sym3-blocks.md), [L86](../findings/sym3-blocks.md)–[L89](../findings/sym3-blocks.md), or the block table. **The dependency runs strictly downward.**
- **What they inherit is its standing.** L62's whole content is $14-1=13$, and L59's formula is stated *inside* the $14$. **Both are therefore at most as established as an unreplicated exact machine computation**, and both were audited today as though the $14$ were given. That is not a defect in either block's reasoning; it is a fact about the base of the chain that should be visible from it. *[r633](REVIEW_r633.md) flagged the same thing from L62's side and named it a different class from the mod-$p$ rank, which I confirm: the $14$ is deterministic and exact where the $13$'s lower bound is sampled.*

## 8. The remaining checklist

**Every hedging clause.** *"here"* at [line 42](../findings/sym3-blocks.md#L42) means $n=5$ and is correct, though the sentence's own claim is about $n\le5$, *"here"* names the file's dimension and the identity's range is wider. *"which is the syzygies"* at [line 60](../findings/sym3-blocks.md#L74) is right for the four entries where the inequality holds. *"the answer is $14$"* is a statement about a script's output and reads as a derivation; *"sharing nothing with"* is correct; *"reproduces the Lovelock collapse"* overstates by the constant (§3.4). **The opening *"so the constraint count is $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$" compresses a real step**: it holds only after the Gram is averaged over $O(5)$ by the Reynolds operator, which is legitimate (the SOS cone is convex and $G$-stable and $F_5$ is invariant) and is supplied by [L88](../findings/sym3-blocks.md) further down, not here.

**Duplication.** The $14$ appears at [results.md:202](../results.md#L202), [results.md:586](../results.md#L586), [results.md:598](../results.md#L598) and [report/sections/07-gradedness-split.tex:883](../report/sections/07-gradedness-split.tex#L883), **always as a consumer and never with a source**. The degree sequence appears once in [findings/](../findings/) and nowhere in [report/](../report/). **The trivial-multiplicity claim appears three times in this one file**, [line 42](../findings/sym3-blocks.md#L42), [line 165](../findings/sym3-blocks.md#L179) as the identity, [line 167](../findings/sym3-blocks.md#L181) as the dimension, and a fourth time at [report/sections/07-gradedness-split.tex:892](../report/sections/07-gradedness-split.tex#L892), which carries the *"parity-sensitive"* wording with it. [INDEX-results.md:100](../findings/INDEX-results.md#L100) records the statement with *"no verdict on the record"*, which was accurate until this review.

**Do all pointers resolve?** The block carries exactly one, [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), and it resolves and contains what is claimed. **Rare in this file, and worth saying.**

**A drift the audit should know about, because it produced this brief's one error.** My brief locates the trivial-multiplicity sentence *"beneath"* the L85 heading. It is at [line 42](../findings/sym3-blocks.md#L42), **twenty-six lines above it**, and under this file's convention (every `####` lemma heading sits immediately above the `##` section carrying its content), **it belongs to [L83](../findings/sym3-blocks.md), where [r663](REVIEW_r663.md) and [r664](REVIEW_r664.md) already audited it today.** The cause is mechanical: at commit `8d869d2c` line 42 *was* L85's heading, and four reviews ([r597](REVIEW_r597.md), [r598](REVIEW_r598.md), [r634](REVIEW_r634.md), [r651](REVIEW_r651.md)) anchor L85 as `#L42`. Today's L83 and L84 audit notes added twenty-six lines above it, so **every one of those four anchors now lands on the trivial-multiplicity sentence instead.** *Line-number anchors into this file are load-bearing and are already stale; the file moved twice while this review was being written, so the anchors above are as of the working tree at the time of writing and the headings are the stable way in.*

## 9. What I would change, in order of what it costs the record

| # | repair | what is wrong without it |
| --- | --- | --- |
| 1 | **Fix *"Every entry is strictly smaller"***, from degree $3$ on, with degree $2$ noted as forced equal by irreducibility | **a false universal on the record**, refutable in one line by a reader comparing two printed sequences |
| 2 | **State the $O(5)$/$SO(5)$ step**: $-I$ acts on $\mathcal W_n$ by $(-1)^4=+1$, so at odd $n$ the two invariant rings agree in **every** degree. Put it in [conventions.md](../findings/conventions.md), where [L83](../findings/sym3-blocks.md)'s block needs it too | the displayed formula computes $SO(5)$ and the heading claims $O(5)$; the odd-degree entries have no bridge at all under the weaker reason |
| 3 | **Label the $14$ as measured**, naming the script as its sole upper bound, and cite [run_n5_sextic_basis.py](../scripts/runs/run_n5_sextic_basis.py) as the independent lower one | the record's labels are literal, and [L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) were audited today reading the $14$ as given |
| 4 | **Cite [ATTEMPTS.md](../ATTEMPTS.md) Result 2 from the multiplicity sentence**, and add the FFT spanning step its *"so"* omits | as written the inference does not follow, and the $n\ge6$ half points at nothing |
| 5 | **Drop *"parity-sensitive"*** for *"dimension-threshold"*, at [line 42](../findings/sym3-blocks.md#L42) and [07-gradedness-split.tex:892](../report/sections/07-gradedness-split.tex#L892) | this record uses *parity* for genuine even/odd effects fourteen lines away |
| 6 | **Narrow *"reproduces the Lovelock collapse"*** to the collapse's dimension count | the constant $2$ is not in the count, and [r598](REVIEW_r598.md) has to supply it separately |
| 7 | **Say that the degree sequence and the $14$ are one computation**, and that the degree-$3$ entry is the entry with an independent check ([L83](../findings/sym3-blocks.md)'s $(0,0)$ multiplicity) | a reader takes the sequence for corroboration of its own last entry |
| 8 | **Note the self-duality identification** $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}\cong(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ in [conventions.md](../findings/conventions.md) | L85 and [L89](../findings/sym3-blocks.md) state different objects and the record treats them as one |

**No repair on this list changes a number.** $14$, the sequence $1,1,4,5,14$, the $1\to2$ multiplicity jump and everything [L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) draw from them stand exactly as written.

## 10. What would need computation, and is therefore not done here

- **An independent upper bound $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}\le14$.** *What a run would decide:* whether the $14$ survives replication by a second method. A Molien/Haar route on $\mathcal W_5$, [c1_haar_moments.py](../scripts/reviewers/r239/c1_haar_moments.py)'s machinery at $n=5$ instead of the stable range, shares no code with the Laurent-polynomial route. **Agreement would make the $14$ two-sourced in both directions and retire item 3 above; disagreement would move [L59](../findings/sym3-blocks.md), [L62](../findings/sym3-blocks.md), [L89](../findings/sym3-blocks.md) and the certificate's identity step together.** *Blocked: analysis-only, and this is a decomposition run.*
- **The degree-$4$ and degree-$5$ entries, $4$ and $5$.** No hand check exists for either. *A run would decide whether the sequence's unchecked middle is right; nothing on the record currently consumes those two entries, so the stake is the credibility of the run that produced the $14$ rather than any result.* **Blocked, and lower priority than the first.**
- **The constant $2$ in $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$.** Fixed by the $720$-term expansion of the six-index delta, already done at [L50](../findings/bispectral.md#L118). *Not re-run.*
