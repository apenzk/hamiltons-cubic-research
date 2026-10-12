# REVIEW r633, Lemma L62

**Target:** [Lemma L62](../findings/sym3-blocks.md), "$\dim\mathrm{ann}=1$, so the rank is $13$", [findings/sym3-blocks.md:187–191](../findings/sym3-blocks.md), the heading, the provenance note with its pointer, and the single argument paragraph. Index row at [findings/INDEX-results.md:76](../findings/INDEX-results.md), which records **"Gate 2: no verdict on the record."** Restated at [results.md:206](../results.md) and [results.md:598](../results.md), and tabled as **Proven** at [report/sections/09-status.tex:13](../report/sections/09-status.tex).

**Reviewer:** r633, cold, adversarial, **analysis-only footing**. No rank computation, sample, sweep, census or search was run, and none of the block's numerics was reproduced or extended, the sampled mod-$p$ rank is the reserved work and is treated throughout as testimony, never re-derived. Every derivation below was built from the definitions in [conventions.md](../findings/conventions.md), [Lemma L85](../findings/sym3-blocks.md), [Lemma L86](../findings/sym3-blocks.md) and [Lemma L59](../findings/sym3-blocks.md) before the block's own reasoning was read. **No screen was taken; none was needed.** Provenance was traced with `git log` and `git show` over the file's history, which is reading, not computation.

**VERDICT: GAP, and it is exactly the split the brief anticipates. The upper bound is a theorem; the lower bound is a measurement; and every consequence the record draws from L62 sits on the measured side.** The cap $\mathrm{rank}\le13$ is proved here in six lines from [L85](../findings/sym3-blocks.md) and the orbit constraint, and its unimprovability (the block's "order-$2$ vanishing shows the bound cannot be sharpened"), is *also* proved here, from [L86](../findings/sym3-blocks.md) at $\lambda=(2,2)$, which the record asserts and never derives. Both directional inequalities in the lower-bound half are stated **correctly**: a sampled rank does bound the true rank from below, reduction mod $p$ does only lower, and the squeeze closes. But the proved half yields only $\mathrm{ANN}\supseteq\mathbb R\,\mathcal A(W_0^6)$ and $F_5\perp\mathcal A(W_0^6)$, the latter automatic for *any* sextic vanishing at $W_0$, hence empty of content. **$\dim\mathrm{ANN}=1$, $\mathrm{rank}=13$, and "$F_5$ lies in the image" are the measured half, in their entirety.** So L62 is an `Observation` under the record's literal labels, and the derivable half deserves its own statement. Four further defects follow: the **pointer is FALSE**, by the identical mechanism and the identical commit as [L61](../findings/sym3-blocks.md) (§6); **"four primes" is unsupported**, the record names two, and the four primes near $2^{40}$ belong to a different computation (§7); the block's own file **contradicts it 54 lines above**, calling the same rank "open in $[1,13]$" (§8); and the block's inequality "a sampled rank is bounded above by the true one" **drops the hypothesis its own file supplies**, that the sample be built equivariantly, without which the file records a construction exceeding the cap (§4.3).

---

## 1, Conventions pinned, and where each object is actually defined

[conventions.md](../findings/conventions.md) is incomplete, as the brief warns. **None of its three named gaps touches L62**: the lemma mentions no $\mathfrak m$, no $S_{XYZ}$ and no $\theta_0$. The incompleteness that does bite is different and worse, **not one of the six objects L62's one-paragraph statement depends on appears in [conventions.md](../findings/conventions.md) at all.**

| object | reading adopted here | where it is actually pinned | in [conventions.md](../findings/conventions.md)? |
| --- | --- | --- | --- |
| $W_0$ | the zero-padding of $W_{\mathbb{CP}^2}$ into $\mathcal W_5$, unit norm | inferred from [sym3-blocks.md:60](../findings/sym3-blocks.md) and named at [sym3-blocks.md:184](../findings/sym3-blocks.md); spelled out only at [results.md:594](../results.md) | **no**, and [nondegeneracy.md:572](../findings/nondegeneracy.md) uses $W_0$ for an unrelated critical point |
| $K$ | the span of cubics on $\mathcal W_5$ cut out by the orbit constraint, i.e. $\{q\in\mathrm{Sym}^3\mathcal W_5^*: q\equiv0 \text{ on } O(5)\cdot W_0\}$ | [L59](../findings/sym3-blocks.md) names it; the mechanism is [L86](../findings/sym3-blocks.md) and [sym3-blocks.md:130](../findings/sym3-blocks.md) | **no** |
| "the $14$" | $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$ | [Lemma L85](../findings/sym3-blocks.md) | **no** |
| $\mathrm{ANN}$ | $\{F\in(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}:\mathrm{Cat}_F(K,K)=0\}$ | [L59](../findings/sym3-blocks.md) | **no** |
| $\mathrm{Cat}_F$ | the catalecticant of $F$, the invariant symmetric form $B\mapsto\langle F,\mu(B)\rangle$ | [L59](../findings/sym3-blocks.md), by the apolarity line only | **no** |
| $\mathcal A$ | the Reynolds projection onto $O(5)$-invariants, so $\mathcal A(W_0^6)$ is the invariant part of $\langle W_0,\cdot\rangle^{6}$ | **nowhere**, inferred here from the role it plays | **no** |

**D1, $\mathcal A$ is undefined and collides twice.** The letter carries [Lemma L79](../findings/isotropy-cap.md)'s operator $\mathcal A(W)=\sum_{g,h}W_{gh}\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)$ across [isotropy-cap.md](../findings/isotropy-cap.md), a numbered result with its own eigenvalue table. Worse, **L62's own sentence writes it as bare $A$** ("spanned by $A(W_0^6)$") and bare $A$ is used two ways inside the same file: [sym3-blocks.md:102](../findings/sym3-blocks.md) makes it *"the sampled coefficient matrix"*, and [conventions.md](../findings/conventions.md) tables $A=\lambda_1$ in the two-negative relaxation. The display at [sym3-blocks.md:123](../findings/sym3-blocks.md) writes $\mathcal A(W_0^6)$; the block 68 lines later writes $A(W_0^6)$; [results.md:206](../results.md) and [report/sections/07-gradedness-split.tex:903](../report/sections/07-gradedness-split.tex) both propagate the bare $A$. One symbol, four referents, no definition.

**D2, the heading and the body disagree on capitalisation of the same object.** The heading writes $\dim\mathrm{ann}$; the body, [L59](../findings/sym3-blocks.md), [results.md](../results.md) and [INDEX-results.md:76](../findings/INDEX-results.md) write $\mathrm{ANN}$. Cosmetic, and it is the kind of drift that later becomes two objects.

**D3, "restricted rank" never says restricted to what, and the file uses $\mu$ for two maps whose ranks are $14$ and $13$.** [Lemma L89](../findings/sym3-blocks.md) proves $\mathrm{rank}(\mu|_{\mathrm{inv}})=14$ for $\mu:\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5^*)\to\mathrm{Sym}^6\mathcal W_5^*$ on invariants. [Lemma L90](../findings/sym3-blocks.md) writes "$\mathrm{rank}\,\mu$" for the value $13$. Both are called $\mu$, 25 lines apart, and the reader must supply the restriction. **The space L62's rank is taken of is:**

$$\mu\big|_{\mathrm{Sym}^2(K)^{O(5)}}:\ \underbrace{\mathrm{Sym}^2(K)^{O(5)}}_{\dim=36}\ \longrightarrow\ \underbrace{(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}}_{\dim=14},$$

the $36$ being [L86](../findings/sym3-blocks.md)'s unknown count and, equivalently, the $36$ of [L59](../findings/sym3-blocks.md)'s split $65=36+29$ of [L88](../findings/sym3-blocks.md)'s invariant forms. [results.md:206](../results.md) is better than the block here (it says "restricted **catalecticant** rank" and opens "In the setting of Lemma L59") and **the block cites neither L59 nor L85 nor L86, though it consumes all three.**

---

## 2, The upper bound is a theorem, and here is the proof

Derived cold, from the definitions, before the block's bullet at [sym3-blocks.md:135](../findings/sym3-blocks.md) was read.

**Step 1, every cubic of $K$ vanishes at $W_0$.** By definition $K$ is cut out by the orbit constraint: $F_5$ vanishes on $O(5)\cdot W_0$, so every covariant entering a certificate must, and by equivariance that is the single condition $\sigma_\lambda(W_0)=0$ ([L86](../findings/sym3-blocks.md)). So $q(W_0)=0$ for every $q\in K$.

**Step 2, the image of the restricted $\mu$ lies in the kernel of evaluation at $W_0$.** Any $B\in\mathrm{Sym}^2(K)$ is a finite sum $\sum_i c_i\,q_i\odot q_i'$ with $q_i,q_i'\in K$, and $\mu$ is multiplication, so $\mu(B)=\sum_ic_i\,q_iq_i'$. Each summand is a product of two functions vanishing at $W_0$, hence

$$\mu(B)(W_0)=0\qquad\text{for every }B\in\mathrm{Sym}^2(K)^{O(5)}.$$

Therefore $\mathrm{image}\big(\mu|_{\mathrm{Sym}^2(K)^{O(5)}}\big)\subseteq\ker\big(\mathrm{ev}_{W_0}\big)$, where $\mathrm{ev}_{W_0}$ is the linear functional $F\mapsto F(W_0)$ on the $14$.

**Step 3, $\mathrm{ev}_{W_0}$ is a nonzero functional on the $14$.** The degree-$2$ invariant of $\mathcal W_5$ is $\lVert W\rVert^2$, [L85](../findings/sym3-blocks.md)'s degree sequence beginning $1$ at degree $2$; its cube $\lVert W\rVert^6$ is therefore an $O(5)$-invariant sextic, an element of the $14$. And $\lVert W_0\rVert^6=1\ne0$, $W_0$ being a unit vector. So $\mathrm{ev}_{W_0}\ne0$, its kernel has dimension exactly $14-1=13$, and

$$\boxed{\ \mathrm{rank}\big(\mu|_{\mathrm{Sym}^2(K)^{O(5)}}\big)\ \le\ 13.\ }$$

**This is complete, hand-checkable, and needs no machine.** It caps the rank at $13$ rather than at $14$ precisely because Step 3 exhibits a witness (a single invariant sextic that does *not* vanish at $W_0$) which is the step the block compresses into the six words "evaluation there is a nonzero functional". The one input that is not hand-derived is the number $14$ itself, which [L85](../findings/sym3-blocks.md) obtains by exact Weyl integration in a script; that is a *certified symbolic* computation rather than a sampled one, a different class from the mod-$p$ rank, and I flag it only so the record does not read $14$ as given.

**Dually.** Under apolarity, $\mathrm{ev}_{W_0}$ is pairing against $\mathcal A(W_0^6)$, so Step 3 says exactly $\mathcal A(W_0^6)\ne0$ and Step 2 says $\mathcal A(W_0^6)\perp\mathrm{image}$. Hence

$$\mathrm{ANN}\ \supseteq\ \mathbb R\,\mathcal A(W_0^6),$$

with **$\supseteq$ proved and $=$ open.** That containment is the whole of what the vanishing argument delivers.

---

## 3, The "order $2$ is free" claim is also a theorem, and the record only asserts it

[sym3-blocks.md:135](../findings/sym3-blocks.md) says: *"What order-$2$ vanishing shows is that the bound **cannot be sharpened** by demanding more vanishing at the point, the extra condition being free."* The record states this and never argues it. **It is provable, from [L86](../findings/sym3-blocks.md), in four lines.**

The image of Step 2 vanishes to order $2$ at $W_0$, being spanned by products of two functions each vanishing there. So a priori the image is cut by $1+\dim\mathcal W_5=36$ conditions, not $1$, and the cap could in principle beat $13$. It does not:

1. Let $F$ be an $O(5)$-invariant sextic with $F(W_0)=0$, and $H=\mathrm{Stab}_{O(5)}(W_0)$. Differentiating $F(gW)=F(W)$ at $W=W_0$ for $g\in H$ gives $dF(W_0)\circ g=dF(W_0)$, so $dF(W_0)\in(\mathcal W_5^*)^H$.
2. $\mathcal W_5$ is the $O(5)$-irreducible $V_{(2,2)}$ ([sym3-blocks.md:7](../findings/sym3-blocks.md)), and $\lambda_2=2$ is **even**, so [L86](../findings/sym3-blocks.md)'s parity rule gives $\dim V_{(2,2)}^H=1$, a case that lemma lists among its own hand-checks. The invariant inner product identifies $\mathcal W_5^*\cong\mathcal W_5$ as $H$-modules, so $(\mathcal W_5^*)^H=\mathbb R\,\langle W_0,\cdot\rangle$, $W_0$ being $H$-fixed and nonzero.
3. Write $dF(W_0)=c\,\langle W_0,\cdot\rangle$. Euler's identity for a degree-$6$ homogeneous $F$ gives $dF(W_0)[W_0]=6F(W_0)=0$, so $c\lVert W_0\rVert^2=0$ and $c=0$.
4. Hence $dF(W_0)=0$ **automatically**. The order-$2$ conditions are implied by the order-$1$ one on the invariant sextics, they cut nothing, and $13$ is exactly the cap this method yields.

**So the two sentences of the block's proved half are both theorems, and the record carries a proof of neither.** Step 3 above is the reason the extra condition is free, and it is one application of a lemma sitting $75$ lines higher in the same file.

---

## 4, The lower bound: the directions are right, and the hypothesis is missing

### 4.1 The two inequalities, checked in the direction the brief warns about

Both hold as stated, and the block uses them the right way round.

- **A sampled rank is bounded above by the true one.** The sampled matrix has entries $M_{ij}=\mu(B_i)(x_j)$ over a basis $B_i$ of the $36$ and sample points $x_j$. Its row map factors as $B\mapsto\mu(B)\mapsto(\mu(B)(x_j))_j$, so its rank is at most $\mathrm{rank}(\mu|_{\text{restricted}})$. **Sampled $\le$ true.** Equivalently: a sampled rank of $13$ certifies $\text{true}\ge13$.
- **Reduction mod $p$ can only lower it.** For an integral matrix, $\mathrm{rank}_{\mathbb F_p}$ is the size of the largest minor nonzero mod $p$; such a minor is a nonzero integer, hence nonzero over $\mathbb Q$. So $\mathrm{rank}_{\mathbb F_p}\le\mathrm{rank}_{\mathbb Q}$, and the converse fails, $\mathrm{diag}(1,p)$ has rank $2$ over $\mathbb Q$ and $1$ over $\mathbb F_p$. **Mod $p$ $\le$ characteristic zero.**

Chaining: $13=\mathrm{rank}_{\mathbb F_p}(\text{sampled})\le\mathrm{rank}_{\mathbb Q}(\text{sampled})\le\mathrm{rank}(\mu|_{\text{restricted}})\le13$ by §2. **Every inequality points the same way and the squeeze closes.** The block's phrasing "bounded above by the true one" and [results.md:206](../results.md)'s "a sampled rank is a lower bound" are the same statement said from the two ends; **they agree, and neither is backwards.** This is the shape of argument the brief flags as easy to state in reverse, and I looked for the reversal specifically: it is not here.

The reduction step also silently needs the sampled entries to be $p$-integral, which the pipeline guards, [scripts/reviewers/r209/ranks.py:42](../scripts/reviewers/r209/ranks.py) prints *"cached coefficients vanishing mod P: … (must be 0)"*. Over $\mathbb Q(i)$ the reduction lands in $\mathbb F_p[i]$, a field exactly when $p\equiv3\bmod4$, which is why [sym3-blocks.md:121](../findings/sym3-blocks.md) records $p=1000003$ as chosen for that. Both guards are real and both are correct.

### 4.2 What is therefore established, and by what

| claim | status | ground |
| --- | --- | --- |
| $\mathrm{rank}\le13$ | **proved** | §2, from [L85](../findings/sym3-blocks.md) + the orbit constraint |
| the cap is unimprovable by higher vanishing at $W_0$ | **proved** | §3, from [L86](../findings/sym3-blocks.md) at $\lambda=(2,2)$ |
| $\mathrm{ANN}\supseteq\mathbb R\,\mathcal A(W_0^6)$ | **proved** | §2, dual form |
| $F_5\perp\mathcal A(W_0^6)$ | **proved, and vacuous** | $F_5(W_0)=0$; true of *every* sextic vanishing at $W_0$ |
| $\mathrm{rank}\ge13$ | **measured** | one sampled mod-$p$ rank at $40$ points |
| $\dim\mathrm{ANN}=1$ | **measured** | equivalent to the line above via [L59](../findings/sym3-blocks.md) |
| $F_5\perp\mathrm{ANN}$, i.e. $F_5$ lies in the image | **measured** | follows only once $\mathrm{ANN}$ is known to be that one line |

**The load-bearing reading of this table.** The proved half gives $F_5\perp\mathcal A(W_0^6)$, which is content-free: it says $F_5(W_0)=0$, which was the hypothesis defining $K$ in the first place. **Everything L62 exists to deliver, that $\mathrm{ANN}$ is *only* that line, hence that $F_5$ meets [L59](../findings/sym3-blocks.md)'s necessary condition, is the measured half.** So the split is not a labelling nicety; it is the difference between the lemma having a conclusion and not having one.

### 4.3 The missing hypothesis, which the block's own file supplies

"A sampled rank is bounded above by the true one" is true **only for a sample built from the genuine $\mu(B_i)$**, i.e. only when the copies of each block are identified equivariantly. The file says so itself, $56$ lines above the block, at [sym3-blocks.md:129](../findings/sym3-blocks.md): reviewer $209$ *"exhibited $S_3$ on $\mathbb R^3$ where giving one copy its own position list yields sampled rank $10$ against a cap of $7$"*, and the guard is the multi-probe Schur test, *"therefore load-bearing for the rank argument and … not described as such"*. [sym3-blocks.md:131](../findings/sym3-blocks.md) adds that *"a defect landing the rank exactly on the cap is invisible"*, the three wrong restrictions having been caught only by coming out **above** the cap.

**L62 states the inequality unconditionally and mentions neither.** That is the single most consequential omission in the block: the measurement lands exactly on the cap, which is the one place a build error cannot announce itself, and the block does not tell the reader what stands between it and that error.

### 4.4 Is the lower bound derivable at all?

Not by anything on the record, and the record says so. [sym3-blocks.md:141](../findings/sym3-blocks.md) reduces it to one question, $\mathrm{ANN}$ is the intersection, inside the $65$, of $\mathrm{Cat}$'s copy of the $14$ with the $29$ forms killing $K\times K$; the generic intersection is $\max(0,14+29-65)=0$, it demonstrably contains one line, and *"$13$ holds unless a second coincidence occurs"*. **That is a genericity heuristic, not a proof**, and I could not improve on it: the $29$ decompose block by block as $\ell_\lambda\odot M_\lambda^*$ on even blocks and all of $\mathrm{Sym}^2M_\lambda$ on odd ones, and nothing in that description forces the intersection with $\mathrm{Cat}(\text{the }14)$ to be one-dimensional.

**Per the analysis-only rule, I name the run and stop.** The decisive computation is *not* the one the record ran. It is an **exact** rank over $\mathbb Q$ of the $14\times29$ pairing between $\mathrm{Cat}$'s image of the invariant sextics and the forms killing $K\times K$, inside the $65$, no sample points, no prime, no evaluation. Outcomes: intersection dimension $1$ confirms $\mathrm{rank}=13$ **without** the sampling step, the mod-$p$ step, or the equivariance guard of §4.3, collapsing three fragilities to zero and leaving only implementation error; dimension $\ge2$ refutes $\mathrm{rank}=13$, sends $F_5$'s membership in the image back to open, and falsifies the sampled figure. Either way the label stays `Observation` absent a structural argument, but the evidence class improves from "sampled, mod $p$, at the cap, guarded by a numerical test" to "exact linear algebra over $\mathbb Q$". **I have not run it and am not asking to; it is named so the record can decide.**

---

## 5, $\dim\mathrm{ann}=1$ and $\mathrm{rank}=13$ are the same claim, and the identification is sound

The brief asks whether the heading and the body state one thing. **They do, via [L59](../findings/sym3-blocks.md), and the block does not cite it.**

The brief's own gloss ("the annihilator is the kernel of the map whose rank is counted"), is the one thing to correct. $\mathrm{ANN}$ is **not** that kernel; it is the kernel of the **adjoint**, equivalently the orthogonal complement of the image inside the $14$. [L59](../findings/sym3-blocks.md)'s apolarity line $\langle F,\mu(B)\rangle=\langle\mathrm{Cat}_F,B\rangle$ is exactly the adjunction: $F\perp\mathrm{image}$ iff $\langle\mathrm{Cat}_F,B\rangle=0$ for all $B$ in the $36$, and since $\mathrm{Cat}_F$ is itself invariant and the projection onto invariants is orthogonal, that is iff $\mathrm{Cat}_F(K,K)=0$. So $\mathrm{ANN}=\mathrm{image}^\perp$ in a $14$-dimensional target, and

$$\mathrm{rank}=14-\dim\mathrm{ANN}$$

is rank–nullity for the adjoint. **The identification holds**, and it needs precisely the two things the brief names: the target is $14$-dimensional ([L85](../findings/sym3-blocks.md)), and the pairing is the apolarity one ([L59](../findings/sym3-blocks.md)). Note it does *not* need [L59](../findings/sym3-blocks.md)'s injectivity of $\mathrm{Cat}$ on the invariant sextics, that is used for the $65=36+29$ split, a separate step. **The defect is a citation gap, not a mathematical one**: L62's heading asserts a quantity whose equivalence to its body's quantity is a theorem stated $26$ lines above and never referenced.

---

## 6, The pointer is FALSE, and the same commit made it false as made L61's

L62's provenance note says the argument *"is in this file under '$\Theta_5=\sqrt{3/2}$, an exact rational SOS certificate'"*.

**Read the named section.** It is the `##` heading at [sym3-blocks.md:104](../findings/sym3-blocks.md), and under the file's own heading convention it runs to the next heading, the `####` lemma block at [sym3-blocks.md:115](../findings/sym3-blocks.md). That convention is unambiguous throughout the file: every `####` lemma heading sits *immediately above* the `##` section carrying its proof ([L83](../findings/sym3-blocks.md) above "The 24 blocks", [L84](../findings/sym3-blocks.md) above "Separation of the blocks", [L85](../findings/sym3-blocks.md) above "The constraint count", [L86](../findings/sym3-blocks.md) above "The orbit constraint", [L89](../findings/sym3-blocks.md) above "The rank is a theorem on the full space"). So the section is **lines 104–113**: one paragraph about [n5_certificate.json](../scripts/runs/n5_certificate.json) and a **four-row table** whose rows are "the rows", "the family", "membership", "positive definiteness". It contains no rank, no $13$, no $14$, no $\mathrm{ANN}$, no $K$, and no vanishing condition. **None of L62's argument is there.**

Under the alternative reading, strict markdown nesting, the `##` running to the next `##` at [sym3-blocks.md:151](../findings/sym3-blocks.md), the named region is $47$ lines containing **four numbered lemmas** ([L90](../findings/sym3-blocks.md), [L91](../findings/sym3-blocks.md), [L92](../findings/sym3-blocks.md), and the unlabelled rank material). A pointer that resolves to a region holding four other results locates nothing. **The pointer fails under both readings**, and this is the same verdict [r597](REVIEW_r597.md) and [r598](REVIEW_r598.md) reached on [L61](../findings/sym3-blocks.md), which names the identical section.

**Where the argument actually lives: [sym3-blocks.md:121–135](../findings/sym3-blocks.md)**, the boxed display $\mathrm{rank}=13,\ \dim\mathrm{ANN}=1,\ \mathrm{ANN}=\mathbb R\mathcal A(W_0^6)$ at line 123, the three caveat bullets at 129–131, and the "Upper bound $13$, and it comes from order $1$" bullet at 135. **Under the file's heading convention that material belongs to [Lemma L90](../findings/sym3-blocks.md)'s block, not to L62's.** So the record does not bar the location (it is the canonical findings file, the right file) but it files L62's proof under a different numbered result's heading, which is why no pointer to it can be written without naming L90.

**Provenance, traced.** The vague form was introduced by commit `86621751` as *"the argument is the surrounding material in this file"*, imprecise and **true**. The next commit, `bbfa159b`, *"docs(findings): the 24 numbered-from-the-report blocks name where their proof is"*, narrowed all three notes at once into named sections, and gave **L61 and L62 the identical section name**. So this is not a second, independent error: **one repair produced both false pointers in one commit**, and today's audit of L61 caught one half of it. The third note, on [L59](../findings/sym3-blocks.md), was narrowed to *"The constraint count"* in the same commit, that one **resolves correctly**, [L85](../findings/sym3-blocks.md)'s section being where the $14$ and the counts live, though L59's $65=36+29$ split is argued in L59's own block rather than there.

---

## 7, "Four primes", and $\Theta_5$ against $M(5)$

### 7.1 The record names two primes, not four

L62 says *"It attains it, at four primes."* I could not find four, and the record's own evidence line names **two**:

- [sym3-blocks.md:121](../findings/sym3-blocks.md): *"$13$ at $40$ points mod $1000033$, and reviewer $209$ reproduced it independently at $p=1000003$"*, two primes, both near $10^6$.
- [scripts/reviewers/r209/ranks.py:2](../scripts/reviewers/r209/ranks.py) confirms one of them: *"own prime (1000003, 3 mod 4, so $\mathbb F_p[i]$ is a FIELD)"*. [scripts/reviewers/r208/ann_rank.py:35](../scripts/reviewers/r208/ann_rank.py) is floating point, not a prime run.
- The **four** primes on the record are at [sym3-blocks.md:110](../findings/sym3-blocks.md) and [report/sections/07-gradedness-split.tex:887](../report/sections/07-gradedness-split.tex): *"lifted from four primes near $2^{40}$, CRT and rational reconstruction"*, **the certificate's row lift, a different computation**, at a different magnitude, serving a different purpose.

**The most likely reading is that "four primes near $2^{40}$" migrated from the row-lift line into the rank line.** The figure is now repeated at five sites, [sym3-blocks.md:117](../findings/sym3-blocks.md), [sym3-blocks.md:191](../findings/sym3-blocks.md), [results.md:206](../results.md), [results.md:598](../results.md), [report/sections/09-status.tex:13](../report/sections/09-status.tex), and **not one of them names a prime.** Deciding it is reading, not computation: either two further prime runs exist and should be cited, or the number is two and five sites need correcting. **Until then the block overstates its own evidence by a factor of two.**

### 7.2 $\Theta_5=\sqrt{3/2}$ is false, and L62 does not depend on it, which is the point

Warning **W5** in [conventions.md](../findings/conventions.md) stands: $\Theta_n$ is the diagonal maximum, $M(n)$ the global one, and $\Theta_5=2\sqrt2/3=0.9428$ while the object equal to $\sqrt{3/2}$ is $M(5)$. The section title L62 points at asserts the false identity, and [L61](../findings/sym3-blocks.md)'s block already carries the verdict.

**L62's own statement is immune, and I checked each of its objects against the mis-naming.** $K$, $W_0$, $\mathrm{ANN}$, $\mathrm{Cat}$, the $13$ and the $14$ are all defined without reference to any maximum: the $14$ is [L85](../findings/sym3-blocks.md)'s invariant-sextic count, $W_0$ is the padded $W_{\mathbb{CP}^2}$, and $K$ is cut out by vanishing on its orbit. **Neither the $14$ nor the $13$ is counted in a space defined by that section**, the section defines no space at all, holding only the exactness table. So W5 costs L62 nothing mathematically, and costs it exactly one thing editorially: **the only place the mis-named constant enters L62 is inside the false pointer**, giving the record two independent reasons to remove that string from this block.

---

## 8, The block's own file contradicts it, $54$ lines above

The checklist item that has repeatedly paid pays again.

- [sym3-blocks.md:121](../findings/sym3-blocks.md): *"**THE RESTRICTED RANK IS $13$, AND THE NECESSARY CONDITION IS A THEOREM.**"*
- [sym3-blocks.md:133](../findings/sym3-blocks.md), twelve lines later: *"On the restricted space the argument does not carry, and **the rank is open in $[1,13]$**."*
- [sym3-blocks.md:139](../findings/sym3-blocks.md), [Lemma L91](../findings/sym3-blocks.md): *"**Lower bound $1$, unconditionally.**"*
- [sym3-blocks.md:141](../findings/sym3-blocks.md): *"**Tightness is open**, reduced to one question … So $13$ holds unless a second coincidence occurs."*
- [sym3-blocks.md:191](../findings/sym3-blocks.md), L62: $\mathrm{rank}=13$, asserted flat.

**Line 133 and Lemma L91's bullets are stale against line 121 and against L62**, a numbered lemma, [L91](../findings/sym3-blocks.md), currently states an unconditional lower bound of $1$ for a quantity two other numbered results in the same file assert is exactly $13$. **And line 141 is not stale but exactly right**, and is the sentence that decides the label: *tightness is open* is the correct description of the analytic status, and it stands $50$ lines above a block that presents the same number as settled. The file therefore already contains the split this review recommends; it just does not connect the two ends.

---

## 9, The label, and the split I propose

Under the record's literal labels, *"**Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated"* ([INDEX-results.md:5](../findings/INDEX-results.md)), and under [update-report/SKILL.md:27](../.claude/skills/update-report/SKILL.md)'s stricter rule, *"A machine computation goes in a `Verification` block that names its arithmetic, alongside the proof and never inside it"*:

**L62 as written is an `Observation`.** Its machine computation is not alongside the proof, it *is* the proof of the half that carries the conclusion. [report/sections/09-status.tex:13](../report/sections/09-status.tex) currently tables it as **Proven**, which is the strongest overstatement of the set and should move first.

**The derivable half does deserve its own statement, and it is more than a fragment.** Proposed split:

> **Lemma (proved).** Let $K$ be the cubics on $\mathcal W_5$ vanishing on $O(5)\cdot W_0$ and let $\mu$ be multiplication restricted to $\mathrm{Sym}^2(K)^{O(5)}$, of dimension $36$, into the $14$-dimensional $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$. Then $\mathrm{rank}\,\mu\le13$ and $\mathrm{ANN}\supseteq\mathbb R\,\mathcal A(W_0^6)$. Moreover every invariant sextic vanishing at $W_0$ vanishes there to order $2$, so the cap is not improved by any higher-order vanishing condition at $W_0$ and $13$ is exact for the method. *Proof: §2 and §3 of this review, from [L85](../findings/sym3-blocks.md), [L86](../findings/sym3-blocks.md) and [L59](../findings/sym3-blocks.md).*

> **Observation (measured).** $\mathrm{rank}\,\mu=13$, hence $\dim\mathrm{ANN}=1$ with $\mathrm{ANN}=\mathbb R\,\mathcal A(W_0^6)$, hence $F_5\perp\mathrm{ANN}$ and $F_5$ lies in the image. *Evidence: a sampled rank of $13$ at $40$ points over $\mathbb F_{1000033}$, reproduced at $\mathbb F_{1000003}$ with independent code, points and construction. Sampling and reduction are one-sided, so the figure is a rigorous lower bound rather than an estimate, conditional on the sample being built equivariantly, which the multi-probe Schur test guards and §4.3 explains cannot be checked by the value landing on the cap.*

**One structural gain the split exposes, which the file does not use.** [Lemma L90](../findings/sym3-blocks.md) needs $\mathrm{rank}(\mathrm{ev}\circ\mu)=\mathrm{rank}\,\mu$. With the §2 cap in hand, the chain $13\le\mathrm{rank}(\mathrm{ev}\circ\mu)\le\mathrm{rank}\,\mu\le13$ closes on **one** measured number and forces both equalities. So the proved upper bound plus a single measurement yields L90 *and* L62, and L62's rank becomes a corollary of L90's rather than an input to it. **The file presents these as two results resting on separate measurements; they rest on one, and stating that would make the certificate's dependency visible in one line.**

---

## 10, Impact, if the measured half were wrong

Recorded because the number sits exactly on the cap, where §4.3 says a defect is invisible.

| consumer | what it takes from L62 | what fails |
| --- | --- | --- |
| [Lemma L90](../findings/sym3-blocks.md) | $\mathrm{rank}(\mathrm{ev}\circ\mu)=13=\mathrm{rank}\,\mu$ | evaluation is no longer injective on the image, so the $40$ equations give agreement at $40$ places rather than an identity |
| [Lemma L59](../findings/sym3-blocks.md)'s necessary condition | $F_5\perp\mathrm{ANN}$ | the condition reverts to open; the route's own stated death clause at [sym3-blocks.md:140](../findings/sym3-blocks.md) applies |
| [Lemma L61](../findings/sym3-blocks.md) | via L90, that the exhibited Gram maps to $F_5$ | the SOS certificate stops certifying $F_5$; the bound $\theta\le\sqrt{3/2}$ on $\mathcal W_5$ loses its only support |
| the $23$-dimensional affine family ([sym3-blocks.md:125](../findings/sym3-blocks.md)) | $36-13$ | the dimension moves |

**So the single sampled number carries the $n=5$ certificate.** That is the strongest argument for §4.4's exact-intersection run, and the strongest argument against the `Lemma` label.

---

## 11, Repairs, in order of cost

1. **[report/sections/09-status.tex:13](../report/sections/09-status.tex): change "Proven" to the split of §9.** One word, and it is the record's most exposed overstatement of L62.
2. **Relabel row 62 in [INDEX-results.md:76](../findings/INDEX-results.md) as `Observation`**, and add the proved Lemma of §9 as its own numbered result. The two halves are cleanly separable and the proved one is genuinely useful.
3. **Delete the false pointer** from L62's provenance note and from [L61](../findings/sym3-blocks.md)'s, and replace with the true location: *"the argument is at [sym3-blocks.md:121–135](../findings/sym3-blocks.md), under [Lemma L90](../findings/sym3-blocks.md)'s heading"*. Both were made false by `bbfa159b` in one edit and should be repaired in one.
4. **Fold §2 and §3 into the block as the proof.** Neither is on the record and both are short; §3 in particular turns an assertion into a corollary of [L86](../findings/sym3-blocks.md).
5. **Cite [L59](../findings/sym3-blocks.md), [L85](../findings/sym3-blocks.md) and [L86](../findings/sym3-blocks.md) from L62**, which currently consumes all three silently, and state the restriction explicitly as $\mathrm{Sym}^2(K)^{O(5)}\to(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$.
6. **Resolve "four primes"** (§7.1): name them or correct all five sites to two.
7. **Add the equivariance hypothesis** to the sampled-rank inequality, citing [sym3-blocks.md:129](../findings/sym3-blocks.md) and [sym3-blocks.md:131](../findings/sym3-blocks.md), the block is the one place in the file where the caveat is absent and the only place a reader meets the inequality bare.
8. **Reconcile [sym3-blocks.md:133](../findings/sym3-blocks.md) and [Lemma L91](../findings/sym3-blocks.md) with L62** (§8): "open in $[1,13]$" and "lower bound $1$, unconditionally" are stale, while "tightness is open" at [sym3-blocks.md:141](../findings/sym3-blocks.md) is correct and should become L62's own status line.
9. **Define $\mathcal A$**, in [conventions.md](../findings/conventions.md), and fix the bare $A$ at [sym3-blocks.md:191](../findings/sym3-blocks.md), [results.md:206](../results.md) and [report/sections/07-gradedness-split.tex:903](../report/sections/07-gradedness-split.tex); table $W_0$ there too, which no file defines.
10. **Consider the exact-intersection run of §4.4**, named, costed and not run here.
