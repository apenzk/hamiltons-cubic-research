# REVIEW r524, Lemma L43

**Target.** Lemma L43, "the criterion at $a=0$ demands exactly $\theta_0(n)$", [findings/problem.md:472](../findings/problem.md#L472), at the `#### Lemma L43` heading down to the next heading.

**Statement under audit.** On the slice $R_{\mathrm{ric}_0}=0$ the invariance criterion at $a=0$ collapses with no residue to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

**Phase plan.**
1. The pointer, does the named section exist, does its title match, does it contain the argument.
2. "Collapses with no residue", derive the collapse from the criterion.
3. Provenance of $\theta_0(n)$, check it is not imported from a sphere-product computation or from $\Theta_n$.
4. The slice $R_{\mathrm{ric}_0}=0$, what it is, what it excludes, attained or approached.
5. "Exactly", sufficiency and necessity separately.
6. The 7 citations, what each takes.
7. Cross-check [findings/](../findings/) and the later sections of [problem.md](../findings/problem.md).

**Standing rule.** Analysis only. No searches, sweeps, censuses. Screening only, labelled as screening.

VERDICT: **CONFIRMED**, see the verdict section at the end.

---

## Findings

(appended as found)

### 1. The pointer, GOOD, with a truncated title

The block says *"the argument is in this file under **The diagonal case: located in the literature, and it covers less than **"*. The real heading is [problem.md:13](../findings/problem.md#L13), **"The diagonal case: located in the literature, and it covers less than assumed"**, the pointer drops the last word and so breaks off mid-phrase, which is a copy defect and not a wrong target.

**The argument is genuinely there.** [problem.md:48–64](../findings/problem.md#L48), the paragraph *"$\theta_0(n)$ IS DERIVED, NOT POSITED, the criterion at $a=0$ produces the target constant exactly"*, carries the three-fact table, the collapse and the identification $c(n-1)=\theta_0(n)$. This is the third result audited this session whose pointer names a section titled for something else, and the **first whose section actually holds the proof**.

**This settles the standing suspicion.** [plan-verification.md:116](../plan-verification.md#L116) records a candidate concern that result 43's pointer "names a section about the literature's scope, while the result is a criterion at $a=0$". The observation about the title is right; the inference is wrong. The section is a scope section that ends with the derivation. **Candidate concern resolved negative.**

**One real defect in the block's own statement.** [problem.md:476](../findings/problem.md#L476) reads *"the invariance criterion \eqref{eq:criterion} at $a=0$"*. `eq:criterion` is defined **only** in [report/sections/05-landscape.tex:42](../report/sections/05-landscape.tex#L42); [problem.md](../findings/problem.md) contains no such label. The statement was lifted from the LaTeX and its one reference to *which criterion is meant* dangles for any reader of the findings file.

### 2. The collapse, DERIVED COLD, AND IT IS RESIDUE-FREE

I rebuilt it from the definitions rather than from the block.

**The criterion.** $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$ with $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$; invariance needs $G(R)=dF_R(\Phi(R))\le0$ on the boundary. The quotient rule gives $dF_R(S)=\tfrac2{\lVert\mathrm{ric}\rVert^2}\langle R,S\rangle-\tfrac{2\lVert R\rVert^2}{\lVert\mathrm{ric}\rVert^4}\langle\mathrm{ric}R,\mathrm{ric}S\rangle$, so dividing by the positive $2/\lVert\mathrm{ric}\rVert^2$,
$$G(R)\le0\iff\langle R,\Phi(R)\rangle\le F(R)\,\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle.$$
Matches [beitz notes](../references/beitz-2018-bianchi-convexity/notes.md) and the direction is right.

**Setting $R=cI+W$.** $\Phi$ is quadratic with polarisation $\Phi(A,B)=\tfrac12(AB+BA)+A\#B$, so $\Phi(cI+W)=c^2\Phi(I)+2c\Phi(I,W)+Q(W)$. Three inputs, each checked against an anchor:

| input | check |
|---|---|
| $\Phi(I)=(n-1)I$ | $I^2=\mathrm{Id}$ and $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the record's anchor |
| $\Phi(I,W)=W+W\#I=0$ | [BW08 Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md), $\langle W\rangle$ in the kernel, so $W\#I=-W$; cross-checked by $\mathop{\mathrm{tr}}W^\#=\langle W\#I,W\rangle=-1$ at unit norm |
| $\mathrm{scal}(Q(W))=0$ | $\mathrm{scal}(R^2+R^\#)=2\lVert\mathrm{ric}(R)\rVert^2$, Hamilton via [Beitz Example 2.3.5](../references/beitz-2018-bianchi-convexity/notes.md) |

**The two sides.** $\Phi(R)=c^2(n-1)I+Q(W)$. Then $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+c\mathop{\mathrm{tr}}Q(W)+c^2(n-1)\mathop{\mathrm{tr}}W+\langle W,Q(W)\rangle$, and the two middle terms vanish by tracelessness of $W$ and $\mathrm{scal}(Q(W))=0$. On the right $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ is **pure trace**, so $\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle=c^3(n-1)\lVert\mathrm{ric}(I)\rVert^2$, again by $\mathrm{scal}(Q(W))=0$ alone. With $F(R)=(c^2\lVert I\rVert^2+\lVert W\rVert^2)/(c^2\lVert\mathrm{ric}(I)\rVert^2)$ the $\lVert\mathrm{ric}(I)\rVert^2$ cancels and the criterion is
$$c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle\ \le\ c^3(n-1)\lVert I\rVert^2+c(n-1)\lVert W\rVert^2 .$$

**"No residue" is TRUE, and it is exact rather than approximate.** The $c^3(n-1)\lVert I\rVert^2$ term is identical on both sides and cancels; nothing else survives. Symbolic screen (sympy, seconds, on the objects above): LHS $-$ RHS simplifies to exactly $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$. **Confirmed.**

**The block understates its own economy, and is right where it counts.** The section's table lists [BW08](../references/boehm-wilking-2008-space-forms/notes.md) eq. (6) ("$\Phi$ preserves Weyl") as one of "three literature facts", and Reviewer 90's note adds first-Bianchi preservation as an unnamed input. **Neither is needed.** Because $\mathrm{ric}(R)$ is pure trace on the slice, only $\mathrm{scal}(Q(W))=0$ is used, never $\mathrm{ric}(Q(W))=0$. The later sentence *"the collapse needs only bilinearity, $\Phi(I,W)=0$ and $\mathrm{scal}(Q(W))=0$"* is the correct accounting; the table above it is stronger than the argument requires. No error, but the two paragraphs disagree about their own hypotheses.

### 3. The constant, NOT IMPORTED. The independence claim holds.

The pinning is: $\partial\Omega_0$ reads $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$, i.e. $c^2\lVert I\rVert^2=\tfrac{n-2}n\lVert W\rVert^2$; with $\lVert I\rVert^2=\dim\Lambda^2=\tfrac{n(n-1)}2$ and $\lVert W\rVert=1$ this gives $c=\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}}$ and $c(n-1)=\tfrac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$. Screened symbolically; and $\theta_0(6)=\sqrt{10}/3$, the record's anchor.

**Every ingredient is checked for sphere contamination and none of them carries any:**

| ingredient | source | sphere-derived? |
|---|---|---|
| $\Omega_a$ and the criterion $G\le0$ | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) (6.24)–(6.25), Lemma 2.3.4 | no |
| the decomposition form of $\partial\Omega_0$ | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96 | no |
| $W\#I=-W$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | [BW08 Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) | no |
| $\mathrm{scal}(Q(W))=0$ | Hamilton | no |
| $\lVert I\rVert^2=\binom n2$ | [conventions.md](../findings/conventions.md) | no |

**I re-derived Beitz's decomposition form independently rather than taking it.** $F\le\tfrac4{n-2+4a}$ expands, using $\lVert\mathrm{ric}\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, to coefficients $(4a-n)$, $4a$, $(n-2+4a)$ on $\lVert R_I\rVert^2,\lVert R_{\mathrm{ric}_0}\rVert^2,\lVert R_W\rVert^2$, exactly four times the displayed form. Independent cross-check: $F(I)=\tfrac{n(n-1)/2}{n(n-1)^2/4}=\tfrac2{n-1}$, matching $\tfrac4{n-2+4a}$ at $a=n/4$. **The chain closes on itself with no sphere product anywhere.** Not circular; the block's headline force stands.

### 4. FINDING, the sign of $c$ is an unstated hypothesis, and the record drops it in exactly the two places that define the cone

The collapse gives $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ with $c$ the **signed** coefficient of $I$. $F$ is even in $R$, so the sublevel set $F^{-1}((-\infty,t])$, the characterisation printed at [problem.md:38–46](../findings/problem.md#L38) and at [results.md:276](../results.md#L276), is a **double** cone: it contains $-cI+W$ whenever it contains $cI+W$. Running the same derivation on that branch gives
$$\langle W,Q(W)\rangle\ \le\ -\,c(n-1)\lVert W\rVert^2=-\theta_0(n)\lVert W\rVert^3,$$
which the balanced sphere product violates at **every** $n$, $\langle W,Q(W)\rangle=+\theta_0(n)>0$. On the printed characterisation the lemma is therefore false as stated, and $\Omega_0$ would be non-invariant at every $n$, collapsing Lemma L44 too.

**The hypothesis exists and is in this repo.** [Beitz's own definition](../references/beitz-2018-bianchi-convexity/notes.md), transcribed verbatim in the reference notes, is
$$\Omega_a:=\{R\in\mathcal A_n\mid(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2\ \textbf{ and }\ \mathrm{scal}(R)>0\},$$
and $\mathrm{scal}(R)>0$ on the slice is exactly $c>0$. It is also forced independently: the quadratic form has a single timelike direction $\langle I\rangle$, so the set is a Lorentz double cone whose **convex** nappe (convexity being what Hamilton's maximum principle requires), is $c>0$.

**So the lemma is true as intended.** But the $\mathrm{scal}>0$ clause is dropped in both of the record's own restatements of $\Omega_a$, and the argument the block points at takes a positive square root for $c$ without saying why. **Repair:** restore "and $\mathrm{scal}(R)>0$" to the $\Omega_a$ characterisation in [problem.md](../findings/problem.md) and [results.md:276](../results.md#L276), and state $c>0$ where $c$ is pinned.

### 5. The slice, it is the EINSTEIN slice, and the canon misnames it

$R_{\mathrm{ric}_0}=0$ kills the **trace-free** Ricci component only. $R=cI+W$ has $\mathrm{Ric}=c(n-1)g$, so the slice is $\{\text{Einstein}\}$, and by §4 it needs $c>0$, i.e. **positive** Einstein constant.

> **[results.md:276](../results.md#L276) opens *"Write $R=cI+W$ on the Ricci-flat slice"*. That is wrong, and wrong in the direction that matters.** Ricci-flat is $c=0$, where $\partial\Omega_0$ forces $\lVert W\rVert=0$ and the lemma is vacuous, and $c=0$ is excluded outright by $\mathrm{scal}>0$. The canonical statement of L43 names as its hypothesis the one value of $c$ the lemma cannot have. The block in [problem.md:476](../findings/problem.md#L476) says $R_{\mathrm{ric}_0}=0$ and is correct.

**What the slice excludes, and attainment.** It excludes all $R$ with nonzero trace-free Ricci, which at $a=0$ is unconstrained, so the slice is a genuine restriction and the section says so at [problem.md:94](../findings/problem.md#L94). $a=0$ is **attained**, not approached: Beitz's conjecture is stated on the closed interval $a\in[0,\tfrac n4]$ and $\Omega_0$ is a bona fide member. The table at [problem.md:44](../findings/problem.md#L44) writes that row as "$\to0$", which reads as a limit and is loose. Every unit Weyl $W$ occurs on $\partial\Omega_0\cap\{\text{slice}\}$ at the single ratio $c=\theta_0\lVert W\rVert/(n-1)$, so the demand is over all of $\mathcal W_n$.

### 6. "Exactly", both halves hold

- **$\theta_0(n)$ suffices:** the collapse is an equivalence, so $\langle W,Q(W)\rangle\le\theta_0\lVert W\rVert^3$ for all Weyl $W$ gives $G\le0$ everywhere on $\partial\Omega_0\cap\{R_{\mathrm{ric}_0}=0\}$.
- **Nothing larger survives:** $\partial\Omega_0$ meets the slice at exactly one ratio $c/\lVert W\rVert$, so each unit $W$ is tested against $\theta_0(n)$ and no other constant. A constant $>\theta_0$ would leave a violating boundary point. **The constant is forced, not merely sufficient.**

**One caveat the block's last sentence omits.** *"So the constant of Problem P is what cone invariance requires"*, the criterion demands $\theta_0(n)$ at every $n$, but $\theta_0$ is **attained** only at even $n$; at odd $n$ the true diagonal maximum is $\Theta_n<\theta_0(n)$ ([conventions.md](../findings/conventions.md), result 57). The section carries this at [problem.md:70](../findings/problem.md#L70) under "Sharpness at even $n$ only"; the block's closing sentence does not, and reads as though the criterion pins the maximum rather than a bound on it.

### 7. The citations

| site | what it takes | verdict |
|---|---|---|
| [results.md:37](../results.md#L37) | the constant + necessity | **sound** |
| [results.md:46](../results.md#L46) | the collapse | **two defects**, writes $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^{\mathbf2}$, degree-wrong (must be $\lVert W\rVert^3$, $\theta_0$ being a pure number); and chains *"so Conjecture A and the problem $P$ are one statement"* off the bridge, which [problem.md:94](../findings/problem.md#L94) explicitly disclaims |
| [results.md:100](../results.md#L100) | the collapse in $c$-form | **sound**, $c(n-1)\lVert W\rVert^2$ is homogeneous of degree 3 since $c$ scales with $\lVert W\rVert$ |
| [results.md:276](../results.md#L276) | canonical statement | **three defects**, "Ricci-flat slice" (§5); $\Omega_a$ printed without $\mathrm{scal}>0$ (§4); *"The cone has three endpoints"* for a closed interval $[0,\tfrac n4]$, which has two |
| [results.md:282](../results.md#L282), L44 | the collapse applied at padded $W_{\mathbb{CP}^2}$ | **sound.** $\theta=\sqrt{3/2}$ against $\theta_0(n)$ is exactly the collapsed criterion. It leans on the *necessity* direction (invariance $\Rightarrow G\le0$), which [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 supplies only in the converse, the section names this at [problem.md:80](../findings/problem.md#L80) and supplies it via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$. Dependency real, disclosed, adequate |
| [results.md:764](../results.md#L764), L0 | "$P$ and Conjecture A are the same statement, **through the cone bridge of Lemma L43**" | **REFUTED BY ITS OWN TARGET.** [problem.md:94](../findings/problem.md#L94): *"the full cone conjecture is strictly more than Conjecture A"* and *"What is settled is that the target constant is right, not that the two statements coincide."* Worse, [Lemma L0's own proof](../findings/problem.md#L453) is a compactness argument between two formulations of Conjecture A and **uses no cone bridge at all**. The attribution is wrong in both directions |
| [plan-verification.md:116](../plan-verification.md#L116) | flags the pointer as a candidate defect | **resolved negative** by §1, the section holds the argument |

Report side, for completeness: [05-landscape.tex:50–60](../report/sections/05-landscape.tex#L50) reproduces the block faithfully and is the only place `eq:criterion` resolves.

### 8. Cross-check of the record

- **No competing restatement of the collapse.** [target.md:693](../findings/target.md#L693) and [results.md:288](../results.md#L288) restate the *off-slice* expansion (L45) and agree with [problem.md:76–92](../findings/problem.md#L76) term for term, including $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. Setting $Y=0$ returns L43 exactly, the consistency check passes.
- **[INDEX-traps.md:62](../findings/INDEX-traps.md#L62)** records cone invariance as a closed route, "vacuous, $\mathbb R_+W^\ast$ satisfies it". That is [fence post F36](../findings/fence-posts.md#L285), about a *different* object (a $Q$-invariant cone inside $\mathcal W_n$ under $\dot W=Q(W)$) and it distinguishes Beitz's $\Omega_a$ by name. **No contradiction.**
- **Nothing below the block in [problem.md](../findings/problem.md) contradicts it.** [problem.md:94](../findings/problem.md#L94) and [problem.md:200](../findings/problem.md#L200) both agree with it; the disagreement is with [results.md:764](../results.md#L764), outside the file.
- **[INDEX-results.md:58](../findings/INDEX-results.md#L58)** carries "Gate 2: no verdict on the record", accurate before this review.

---

## VERDICT: CONFIRMED

**The mathematics holds and I rebuilt it cold.** The collapse is exact and residue-free, the $c^3(n-1)\lVert I\rVert^2$ term is common to both sides and $\lVert\mathrm{ric}(I)\rVert^2$ cancels between $F$ and the pairing, leaving $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ with nothing else. The pinning $c(n-1)=\theta_0(n)$ is arithmetic on $\partial\Omega_0$ and $\lVert I\rVert^2=\binom n2$. **The independence claim survives:** every ingredient traces to BW08 Lemma 2.1, BW08's Ricci identity, Hamilton's $\mathrm{scal}$ identity and Beitz's cone, none of which touches a sphere product. The block's force (that the constant is fixed from outside the sphere products), is real, and the pointer, unlike the two other pointers audited this session, resolves to a section that holds the proof.

**Five repairs owed, none touching the lemma's truth:**

1. **[results.md:276](../results.md#L276): "the Ricci-flat slice" → the Einstein slice $R_{\mathrm{ric}_0}=0$, $\mathrm{scal}>0$.** Ricci-flat means $c=0$, where the lemma is vacuous and the cone excludes the point.
2. **$\mathrm{scal}(R)>0$ restored to the $\Omega_a$ characterisation** in [problem.md](../findings/problem.md) and [results.md:276](../results.md#L276), with $c>0$ stated where $c$ is pinned. Without it the $F$-sublevel set is a double cone and the $c<0$ nappe collapses to $\langle W,Q(W)\rangle\le-\theta_0\lVert W\rVert^3$, false at every $n$.
3. **[results.md:764](../results.md#L764)**, drop "through the cone bridge of Lemma L43". L43 disclaims that identification and L0's proof does not use it.
4. **[results.md:46](../results.md#L46)**, $\lVert W\rVert^2\to\lVert W\rVert^3$, and cut the "so ... one statement" chain.
5. **[problem.md:472–478](../findings/problem.md#L472)**, complete the pointer's title ("...covers less than **assumed**") and replace the dangling `\eqref{eq:criterion}` with the criterion itself or a line link, since the label lives only in the LaTeX.

Minor, optional: [results.md:276](../results.md#L276)'s "three endpoints" for the interval $[0,\tfrac n4]$; the "$a\to0$" row in [problem.md:44](../findings/problem.md#L44) for a cone that is attained at $a=0$; and the block's closing sentence, which should carry the "sharp at even $n$ only" caveat its own section states 400 lines above.

**Analysis-only compliance.** One symbolic screen (sympy, seconds) on the cancellation identity and on $c(n-1)=\theta_0(n)$, constructed for that purpose. Reported as a screen. No searches, sweeps or censuses.
