# VERIFY v55, L147-r2: the surviving $r_n\gtrsim n^{-3/2}$, the $\Theta(n^{-1})$ ceiling, the $\beta=0$ clause, and the $M=O(\rho)$ substitution

**Cold brief.** Read from [ROUND_L147r2.md](ROUND_L147r2.md)'s "brief as dispatched", checked against the live source at [findings/second-order.md](../findings/second-order.md):1163–1188. **No numerical work was done: no script was run, and every value below is an exact hand evaluation from the constants the entry itself names.** I was not told which passages are repairs. Log: [agent_logs/verify-L147r2-v55.log](../agent_logs/verify-L147r2-v55.log).

## Claim table

| # | claim, as the entry states it | verdict |
|---|---|---|
| C1 | The displayed $r_n\gtrsim n^{-3/2}$ on $\beta\in[0,\tfrac12]$ | **HOLDS AS AN ORDER**, with hypotheses supplied and conditional on D5 |
| C2 | "$\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant" | **REFUTED BY THE ENTRY'S OWN ALGEBRA**, D1 |
| C3 | The title, "the tube radius **tracks** $\sup\lvert P\rvert$ on $\beta\in[0,\tfrac12]$" | **REFUTED** (the surviving bound is $\beta$-free), D2 |
| C4 | "So the radius lives in $[n^{-3/2},n^{-1}]$" | **BROKEN** (a method ceiling written as a bound on the quantity), D3 |
| C5 | "A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$" | **REFUTED BY THE NEXT TWO SENTENCES OF ITS OWN BOX**, D4 |
| C6 | $M=O(\rho)$ from "$x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm" | **HYPOTHESIS-DEBT, LOAD-BEARING**, D5 |
| C7 | The LEMMA box as a citable statement | **BROKEN** (carries no hypothesis, and is false at an orbit-tangent direction), D6 |
| C8 | "$c(H)\gtrsim c_p+w^2$ ... uniformly in $w\in[0,1]$" | **GAP**, the un-repaired twin of a sentence [L149](../findings/second-order.md) marks unsafe at $n\in\{12,14\}$, D7 |
| C9 | The $\Theta(n^{-1})$ ceiling, proved by $c_p/S\le c_p/\theta_0=3/(n-2)$ | **PROVEN**, exactly as stated |
| C10 | "eight of [L27](../findings/nondegeneracy.md)'s ten", $\langle W\rangle$ and the orbit removed | **CONFIRMED**, and the two $S^2_0$ copies are correctly counted separately |
| C11 | $\ker W^*=0$ with witness $W_{\mathbb{CP}^2}$, $\dim\ker W=3$ | **CONFIRMED AS ARITHMETIC**, with a scope note, O2 |
| C12 | [results.md](../results.md) and this entry, the two forms | **DISCREPANCY IN THE CANON**, [results.md](../results.md):363 writes "at $u=\Theta(1)$" where $w$ belongs, D8 |

**One line the round can act on.** The displayed inequality survives, but the box that carries it also carries the refuted $n^{-1}$ value at $\beta=0$, a title asserting the removed $\beta$-dependence, a direction its own next sentence proves cannot exist, and no hypothesis at all, and the surviving inequality still rests on a real-symmetric fact applied under a complex supremum, which [ROUND_L147](ROUND_L147.md) filed as F6 and no round has adjudicated.

## 0. Conventions, fixed once

- $n=2m$, $W^*=S^m\times S^m$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$. At $n=12$: $\theta_0=\sqrt{220}/12=1.236033$.
- $c_p=3\theta_0/(n-2)$, the off-orbit margin on $S^2_0(\mathbb R^m)$; $\kappa:=nc_p=3\sqrt{2(n-1)/(n-2)}$, $4.4497$ at $n=12$.
- $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})=\Theta(1/n)$, the spectral gap at $W^*$.
- $\rho=\rho(H)$, the analyticity radius, $\Theta(\min(1,g_n/\lVert H\rVert_{op}))$; $A(z)=\mathrm{Alt}(W(z)_-)$ with $W(z)=W^*+zH$; $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$.
- $S:=\sup\lvert P\rvert=\Theta(n^\beta)$; $a:=$ the coefficient carrying $\lVert A''\rVert$ in branch 1; $u:=$ the defect's linear rate; $w:=\lVert H_r\rVert$, the weight outside **both** $S^2_0(\mathbb R^m)$ copies. $u\ne w$, the only relation on file being $u\le w$ ([ROUND_L147](ROUND_L147.md) F3).
- Branch 1 is $f(u)=(c_p+u^2)/(S+au)$.
- $\gtrsim$ means "$\ge$ an absolute positive constant times", uniformly in $n$ and in the direction.

## 1. The hypothesis inventory

### 1.1 What the statement carries

The LEMMA box carries **exactly one** hypothesis: $\sup\lvert P\rvert=\Theta(n^\beta)$ with $\beta\in[0,\tfrac12]$. It names no base point, no dimension, no direction constraint and no norm normalisation. Those four live in the HYPOTHESES box below the statement, which a citation does not read, see D6.

### 1.2 What the entry states below the statement

| hypothesis | stated | used in the written proof |
|---|---|---|
| $W^*=S^m\times S^m$ | yes | yes, every constant ($\theta_0$, $c_p$, $g_n$, [L27](../findings/nondegeneracy.md)'s decomposition) is that point's |
| $n=2m$ even | yes | yes, the balanced split is what makes $\lambda_m$ a scalar on two copies |
| $n\ge12$ | yes, "which the imports force through $n^2-12n+8>0$" | yes, [L149](../findings/second-order.md) needs $m\ge6$, [L146](../findings/second-order.md) and [L148](../findings/second-order.md) need $m\ge5$ for the word "margin" |
| $\ker W^*=0$ | yes | yes, for $g_n$, $\rho$, $M$ and branches 2–3, but see O2: at $W^*$ it is a **consequence** of the first hypothesis, not an independent one |

**The $n\ge12$ arithmetic reproduces exactly.** $n^2-12n+8>0\iff n>6+2\sqrt7=11.29150$, so $n\ge12$ among even $n$. The same inequality is $\theta_0(n)>\sqrt{3/2}$: $2(n-1)(n-2)/n^2>3/2\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$. So the floor is the positivity of $\lvert\kappa_n\rvert=9(\theta_0-\sqrt{3/2})$, and it is the pole of [L158](../findings/second-order.md)'s $\lambda=2/\sqrt{\lvert\kappa_n\rvert}$. **No finding.**

### 1.3 What the written proof uses and the entry does not state

| hypothesis | where used | stated? |
|---|---|---|
| $\lVert H\rVert_F=1$ | $M\le\rho\lVert H\rVert_F$ in the $M=O(\rho)$ step; the convex-combination form of $c(H)$ | **nowhere in L147** |
| $H\perp W^*$ | named in the quantifier box, to remove $\langle W\rangle$ | in a box, not in the statement |
| $H\perp T_{W^*}\mathcal O$ | named in the quantifier box, to remove the orbit summand | in a box, not in the statement |
| $A(0)=\mathrm{Alt}(W^*_-)=0$ | **required** for $M=O(\rho)$: $1$-Lipschitz alone gives only $M\le\lVert A(0)\rVert+\rho$ | not stated, not cited; it is on file at [L145](../findings/second-order.md)'s box (three Bianchi tensors, [r446](../reviews/REVIEW_r446.md)) |
| $\rho<g_n/2$ **strictly** | the analyticity of $W\mapsto W_-$ | not stated; [L145](../findings/second-order.md) step 2 records the strictness. L147 writes only $\rho=\Theta(g_n)$, which is compatible |
| $\rho(H)=\Theta(\min(1,g_n/\lVert H\rVert_{op}))$ | the step $O(1/\rho)=O(n^{1/2})$ | used without citation |

### 1.4 The imports, each checked against the object it is applied to

| import | its hypotheses | does the object satisfy them? |
|---|---|---|
| [L143](../findings/bounds.md), $\sup\lvert P\rvert\le1+\sqrt{n-2}$ | $\lVert W\rVert=1$; internally uses [L31](../findings/stratum-two-negative.md)'s pair cap and [L153](../findings/bounds.md)'s row mass, and that $\sup\lvert P\rvert$ is attained at a critical point | **yes.** It is what forces $\beta\le\tfrac12$. At $n=12$ it gives $1+\sqrt{10}=4.16228$ |
| [L27](../findings/nondegeneracy.md), the ten-summand decomposition | $p,q\ge3$, $(p,q)\ne(3,3)$ | **yes** at $p=q=m\ge6$ |
| [L146](../findings/second-order.md), $\lVert H\rVert_{op}$ on the summand | $m\ge3$; $m\ge5$ for the margin reading | **yes** at $m\ge6$. **But L146 prices ONE $S^2_0$ copy**, and L147 uses $\Theta(n^{-1/2})$ for $\lVert H_s\rVert_{op}$ on the **joint** two-copy eigenspace. [L149](../findings/second-order.md):1221 records that this needs the cross-plane branch check ($\sqrt{m-2}/m=0.333$ against $1/\sqrt{m-1}=0.447$ at $n=12$, [r716](../reviews/REVIEW_r716.md)). L147 imports it silently |
| [L148](../findings/second-order.md), the defect vanishes on $\Sigma$ | $m\ge3$, $m\ge5$ for "margin"; frame chosen **after** $H$ | **yes.** L147 cites it correctly, to say reason (b) is false |
| [L149](../findings/second-order.md) (uniformity in $w$ | $m\ge6$ | **yes**) but L149's own boxed statement carries an inline *"this clause does not follow and is owed"*, so C1 rests on an entry with an owed clause inside its box |
| [L145](../findings/second-order.md), $r_n=\Omega(n^{-3/2})$ | $\lVert H\rVert_F=1$, $H\perp W^*$, $H\perp T_{W^*}\mathcal O$, $n=2m\ge12$ | **yes.** L147 says its surviving value "is L145's own order and is untouched", correct |

**No finding on 1.2 or 1.4 beyond what is tabled.** The finding is 1.1 and 1.3: **six** hypotheses are used, four are stated in a box, and the citable statement carries none of them.

## 2. Pre-registered question 1, does the entry state one thing about its radius?

**No. Three passages still assert what the refutation removed, and one of them is inside the LEMMA box.**

### D1, the statement box's $\beta=0$ clause is refuted by the same entry, three paragraphs below

**Locate.** [findings/second-order.md](../findings/second-order.md):1169, inside the LEMMA box:

> ***$\beta=\tfrac12$ gives $n^{-3/2}$ and is confirmed, pinned by the $P$-side branch alone. $\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant.***

and the provenance line at :1165, *"the two values survive."*

**Exhibit the failure concretely.** The two values are exactly $n^{-1-\beta}$ read at the two endpoints: $n^{-3/2}$ at $\beta=\tfrac12$ and $n^{-1}$ at $\beta=0$. The entry's own refutation box at :1183 says of $n^{-1-\beta}$: *"the minimisation has now been done and it does not reach $n^{-1-\beta}$ ... **too large on all of $\beta\in[0,\tfrac12)$***." $\beta=0$ is in $[0,\tfrac12)$. So the statement box asserts at $\beta=0$ the value the refutation box removes at $\beta=0$.

The algebra is the entry's own and I reproduce it by hand. $f(u)=(c_p+u^2)/(S+au)$; $f'(u)=\big[2u(S+au)-a(c_p+u^2)\big]/(S+au)^2$, so $f'(0)=-ac_p/S^2<0$. The stationary condition is $au^2+2Su-ac_p=0$, giving $u^*=(\sqrt{S^2+a^2c_p}-S)/a$; substituting $c_p=u^{*2}+2Su^*/a$ gives $c_p+u^{*2}=(2u^*/a)(S+au^*)$, hence $f(u^*)=2u^*/a$ **exactly**. At $\beta=0$ with $S=\Theta(1)$, $c_p=\Theta(1/n)$ and $a=\Theta(n)$ (the entry's own $\lVert A''\rVert=\Theta(n)$ at $w=\Theta(1)$): $a^2c_p=\Theta(n)\gg S^2=\Theta(1)$, so $u^*=\Theta(\sqrt{c_p})=\Theta(n^{-1/2})$ and

$$f(u^*)=2u^*/a=\Theta(n^{-1/2}/n)=\Theta(n^{-3/2})\;\ne\;\Theta(n^{-1}).$$

A factor $n^{1/2}$, at $n=12$, $\sqrt{12}=3.4641$, and [ROUND_L147](ROUND_L147.md)'s F4 records the same gap as $0.0858$ against $0.3$, a factor $3.498$.

**Argue the opposite.** The most charitable reading is that "$\beta=0$ gives $n^{-1}$" names the **ceiling** at $\beta=0$ rather than the radius: at $S=\Theta(1)$ the cap $c_p/S$ is indeed $\Theta(n^{-1})$. Two things defeat it. First, the parallel clause ("$\beta=\tfrac12$ gives $n^{-3/2}$ and is **confirmed**"), is unambiguously about the lower-bound value, and "gives" cannot switch referents inside one sentence. Second, under that reading the sentence would still be wrong: the proved ceiling is $c_p/S\le3/(n-2)$ **unconditionally in $\beta$** (:1181), so it is $\Theta(n^{-1})$ at every $\beta$, not specially at $\beta=0$. The clause is refuted under both readings. **Upheld.**

### D2, the title asserts a dependence the refutation removed

**Locate.** The heading at :1163: *"Lemma L147, the tube radius **tracks** $\sup\lvert P\rvert$ on $\beta\in[0,\tfrac12]$"*.

**Exhibit.** "Tracks $\sup\lvert P\rvert$" is the whole content of $r_n\gtrsim n^{-1-\beta}$: the radius moving with $\beta$. What survives is $r_n\gtrsim n^{-3/2}$, in which $\beta$ does not appear. By the entry's own $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, the second argument $\sqrt{c_p}/a=\Theta(n^{-3/2})$ is $\beta$-free and is the smaller one throughout $\beta\in[0,\tfrac12)$; $\beta$ enters only at the single endpoint $\beta=\tfrac12$, where the two coincide. So on all but one point of the stated interval the surviving bound does not track $\sup\lvert P\rvert$ at all.

**Argue the opposite.** The title could be read as naming the *subject matter*, the entry is about how the radius relates to $\sup\lvert P\rvert$, and the answer happens to be "it does not". Against it: every other title in this block states its conclusion ("the defect vanishes identically", "no direction is both low-margin and high-operator-norm"), and the record propagates headings as claims. **Upheld.**

### D3, the ceiling written as a bound on the radius

Answered in full under question 2, §3.

### O1, one passage exists only against the withdrawn formula

The paragraph at :1171 argues *"there is no region in which a ceiling above $n^{-1}$ could bind"* and lists $\beta\ge0$ as one of four reasons the "no ceiling" claim fails. A ceiling that "binds" is one that could conflict with a lower bound; a $\beta$-indexed "region" only exists if the lower bound is $\beta$-indexed. Against the proved ceiling (the fixed number $3/(n-2)$, independent of $\beta$), the whole paragraph is empty: there is nothing for $\beta\ge0$ to "empty". It is a consistency check for $n^{-1-\beta}$, kept after $n^{-1-\beta}$ was withdrawn. **Recorded as residue, not as an error**: every sentence in it is individually true.

### What is stated correctly

The refutation box at :1183 is correct, complete, and reproduces: $f'(0)<0$, infimum $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, "too large on all of $\beta\in[0,\tfrac12)$", surviving value $n^{-3/2}$ matching [L145](../findings/second-order.md). It also correctly records the closure as *by refutation rather than by payment*, matching [ROUND_L149F](ROUND_L149F.md)'s unanimous F12 (v46 and v47). **No finding: the note recording the debt is accurate.** The defect is that the claim it removes is still asserted above it.

## 3. Pre-registered question 2, is the $\Theta(n^{-1})$ ceiling a bound on the radius or on the method?

**It is a bound on the method.** It is a cap on what the chain can output, and it is proved as such: the chain's output is bounded above by branch 1's value, which is bounded above by $f(0)=c_p/S\le c_p/\theta_0=3/(n-2)$. Nothing in it constrains the true tube radius. [L145](../findings/second-order.md):1104 states this in as many words, *"the only '$\le$' on file is L147's $\Theta(n^{-1})$ ceiling, **which caps what the route can prove rather than the radius**"*, and adds *"The chain cannot yield an upper bound at all, every ingredient bounds a denominator above or a numerator below, so it can only push $r_n$ up."* [L149](../findings/second-order.md):1234 writes it as *"the ceiling of the **method**"*, and :1263 as *"a limit on the method rather than on the problem"*.

**Where the distinction is drawn in L147 itself: nowhere.** The words "route" and "capped" appear; the distinction between capping a route and capping a quantity is never stated. And two uses do not respect it.

### D3, "the radius lives in $[n^{-3/2},n^{-1}]$"

**Locate.** :1171: *"So the radius lives in $[n^{-3/2},n^{-1}]$ and there is no region in which a ceiling above $n^{-1}$ could bind."*

**Exhibit the failure concretely.** "$r_n\le n^{-1}$" is an upper bound on the radius. The only argument on file for $n^{-1}$ is $c_p/S\le c_p/\theta_0=3/(n-2)$, which bounds $f(0)$, a term appearing inside a $\min$ on the **right-hand side** of $r_n\gtrsim\min(\cdot,\cdot,\cdot)$. An upper bound on a term inside the lower bound is an upper bound on the lower bound, not on $r_n$. Concretely: if the true tube radius were $\Theta(1)$, every inequality in the chain would still hold and the ceiling would still be $3/(n-2)$; so the ceiling is compatible with $r_n$ exceeding it by any factor, and cannot be a statement about $r_n$. [L145](../findings/second-order.md) says the same and adds that the chain's every ingredient runs one way.

**Argue the opposite.** "The radius" could be shorthand for "the radius this route delivers", an interval of provable values. That reading is available for the phrase in isolation. It fails against the sentence it is in: "there is no region in which a ceiling **could bind**" is about whether the ceiling constrains the quantity, which only makes sense if the ceiling is read as a constraint on the quantity. And the very next passage lists *"the validity cap $r_n\le\rho/2$"*, an inequality written with $r_n$ on the left, in the entry's own notation for the radius. **Upheld.** This is the entry's answer to question 2, and it is the wrong one.

### The two further uses

- *"$\beta=\tfrac12$ gives $n^{-3/2}$ and is **confirmed, pinned** by the $P$-side branch alone"* (:1169). "Pinned" claims two-sidedness. The $P$-side branch supplies $f(u^*)=\Theta(n^{-3/2})$ at $\beta=\tfrac12$, which is a **term in a lower bound**; it pins what the chain outputs, not $r_n$. Same category error as D3, at a second site.
- *"the validity cap $r_n\le\rho/2$ is $O(g_n)$"* (:1171). $r\le\rho/2$ is the condition under which the Cauchy estimate along the segment is valid; it caps the segment the estimate covers, not the tube.

### C9, the ceiling itself is proven

$c_p=3\theta_0/(n-2)$ gives $c_p/\theta_0=3/(n-2)$ **exactly**, and $S=\sup\lvert P\rvert\ge P(W^*)=\theta_0$ gives $c_p/S\le c_p/\theta_0$. Both steps are exact and neither uses $\beta$. $3/(n-2)=0.3$ at $n=12$; $3/(n-2)=\Theta(n^{-1})$. And $f(u^*)\le f(0)=c_p/S$ since $u^*$ is the minimiser, so the cap passes to the branch's infimum and hence to the $\min$. **PROVEN, exactly as the entry states it.**

*I considered re-raising [ROUND_L147](ROUND_L147.md)'s F5 (that the ceiling is proved only as $O(n^{-1})$, not $\Theta(n^{-1})$) and **withdraw it**. The cap is the single number $3/(n-2)$, and that number is $\Theta(n^{-1})$; "capped at $\Theta(n^{-1})$" reads as "capped at a quantity of order $n^{-1}$", which is exactly right.*

## 4. Quantifier order and scope

### D4, a direction the box asserts and its own next two sentences forbid

**Locate.** :1177, the box headed "AND IT WAS A QUANTIFIER ERROR", three consecutive sentences:

> *A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$.* **Both reviewers closed the sweep the lemma owed**: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ by the triangle inequality and $c(H)\gtrsim c_p+w^2$ since $L_e$ is scalar on each summand, uniformly in $w\in[0,1]$.

**Exhibit the failure concretely, from the two inputs stated in the same box.** Suppose margin $c(H)=\Theta(1/n)$. From $c(H)\ge c_p+Cw^2$ with $c_p=\Theta(1/n)$ and $C=\Theta(1)$, at $n=12$, $C=3\theta_0\frac{m-4}{2(m-1)}=3(1.236033)(0.2)=0.741620$, or $0.719043$ once the $\tfrac29\lvert\kappa_n\rvert=0.022577$ penalty is taken off, we get $Cw^2=O(1/n)$, so $w=O(n^{-1/2})$. Then from the first input, $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w=O(n^{-1/2})$. Then $\rho=\Theta(\min(1,g_n/\lVert H\rVert_{op}))=\Omega(n^{-1}/n^{-1/2})=\Omega(n^{-1/2})$, and the entry's own $\lVert A''\rVert=O(1/\rho)$ gives

$$\lVert A''\rVert=O(n^{1/2})\quad\text{whenever the margin is }\Theta(1/n),$$

a factor $n^{1/2}$ below the asserted $\Theta(n)$. **The asserted direction does not exist.** [L149](../findings/second-order.md):1217 states the same conclusion verbatim, *"So [r451](../reviews/REVIEW_r451.md)'s counterexample direction, margin $\Theta(1/n)$ with $\lVert A''\rVert=\Theta(n)$ (does not exist"*) and :1213 says L149 was written precisely to *"remove the quantifier error that refuted Lemma L147's mechanism"*. So the object L149 exists to kill is still asserted in L147, in the present tense.

**Argue the opposite.** The sentence could be read as reporting r451's counterexample **as it stood before the sweep**, with the following sentence supplying the correction. That is the most charitable reading the words support, and it is a real possibility. It fails on this entry's own conventions: every superseded claim in L147 carries an explicit marker (*"The first version claimed"*, *"The first version argued"*, *"The first version wrote"*) and this sentence carries none, is in the present tense, and is joined to what follows by "Both reviewers closed the sweep", which reads as corroboration rather than as contradiction. **Upheld.** A reader taking the box at its word carries a direction the block has proved absent.

### C10, eight of ten, and singular against plural

**CONFIRMED, and this is where the block's plural failure mode was correctly avoided.** [L27](../findings/nondegeneracy.md)'s decomposition is
$$\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p),$$
ten summands. $H\perp W^*$ removes $\langle W\rangle$; $H\perp T_{W^*}\mathcal O$ removes $\mathbb R^p\otimes\mathbb R^q$, which [L27](../findings/nondegeneracy.md) identifies with the orbit tangent ($L_e=\tfrac12$ there, $\dim=pq=\dim\mathcal O$). $10-2=8$. **And the two $S^2_0(\mathbb R^m)$ copies appear separately in the list**, so the count of eight already carries the plural that [L148](../findings/second-order.md) and [L149](../findings/second-order.md) were each repaired for. **No finding.**

The parenthetical *"at ten the margin floor would be $-\tfrac32\theta_0$"* also reproduces: $L_e=1$ on $\langle W\rangle$, and the margin is $3\theta_0(\tfrac12-\lambda)$, so $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0=-1.854$ at $n=12$. Matches [L145](../findings/second-order.md)'s $-1.854$ at $H=W^*$.

### D7, one variable's coefficient corrected in [L149](../findings/second-order.md) and not here

**Locate.** :1177: *"$c(H)\gtrsim c_p+w^2$ since $L_e$ is scalar on each summand, uniformly in $w\in[0,1]$."*

**Exhibit.** [L149](../findings/second-order.md):1224 carries the correction to this exact sentence: *"The bound once written here, $c(H)\gtrsim c_p+w^2$, is **a lower bound stated upward** at the dimensions that matter: the coefficient is $0.7416$ at $n=12$ and $0.9463$ at $n=14$, reaching $1$ only from $n=16$ ... **It is unsafe exactly on $n\in\{12,14\}$**."* Both numerals reproduce by hand. At $n=12$ ($m=6$): $3\theta_0\frac{m-4}{2(m-1)}=3\cdot1.236033\cdot\frac{2}{10}=0.741620$. At $n=14$ ($m=7$): $\theta_0(14)=\sqrt{2\cdot13\cdot12}/14=\sqrt{312}/14=17.66352/14=1.261680$; $3\cdot1.261680\cdot\frac{3}{12}=0.946260$. Both agree with the record to four places. $n=12$ is L147's **smallest admissible dimension**, so the flagged-unsafe case is the edge of L147's own range.

**Argue the opposite.** Under strict $\gtrsim$ semantics ("$\ge$ an absolute constant times"), the sentence is **true**, with constant $0.719$, and [ROUND_L149F](ROUND_L149F.md) itself records that the correction "is a constant and not an order". That reading is legitimate and I record it. What defeats it as a repair is that [L149](../findings/second-order.md) marks the identical string, with the identical $\gtrsim$, as unsafe, and repairs it in place; L147 carries the un-repaired twin with no constant attached. This is the block's documented failure mode (a correction written in one file and not its neighbours) and here the two files are 47 lines apart. **Upheld as a GAP, not as a falsehood.**

### The silent plural in the operator-norm input

*"$\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ by the triangle inequality"* imports [L146](../findings/second-order.md), which is stated for a **single** $h\in S^2_0(\mathbb R^m)$, and applies it to the **joint** two-copy eigenspace. [L149](../findings/second-order.md):1221 records exactly this and discharges it, the two images being Hilbert–Schmidt orthogonal, and the cross-plane branch reaching only $\sqrt{m-2}/m=\sqrt4/6=0.3333$ against $1/\sqrt{m-1}=1/\sqrt5=0.4472$ at $n=12$ ([r716](../reviews/REVIEW_r716.md)). Both numerals reproduce. **No finding, the step is discharged on the record.** L147 imports it without the citation, which is a provenance gap rather than a mathematical one.

## 5. The edge of every range

### The smallest admissible dimension, $n=12$

Reproduces (§1.2). **But it is the dimension at which D7's coefficient is furthest below $1$** ($0.7416$, or $0.7190$ after the penalty), and D1's factor is smallest there ($\sqrt{12}=3.46$) yet still an order.

### $\beta=0$

**REFUTED**, D1. The clause asserts $n^{-1}$; the entry's own $f(u^*)=2u^*/a$ gives $\Theta(n^{-3/2})$.

### $\beta=\tfrac12$

The **value** is right: $c_p/S=\Theta(n^{-1}/n^{1/2})=\Theta(n^{-3/2})$ and $\sqrt{c_p}/a=\Theta(n^{-3/2})$ coincide, so $f(u^*)=\Theta(n^{-3/2})$ and the endpoint is where $n^{-1-\beta}$ and the surviving bound agree. The word **"pinned"** overclaims, §3.

### $\ker W\ne0$, at $W_{\mathbb{CP}^2}$ with $\dim\ker W=3$

**The arithmetic is right and the consequence is right.** [results.md](../results.md)'s [L7](../results.md) block records $W_{\mathbb{CP}^2}$ at $n=4$ with $\dim E_+=1$, $\dim E_-=2$, $\dim\ker W=3$; it is Morse–Bott nondegenerate by [L28](../findings/nondegeneracy.md). With a kernel the negative spectral part is not separated from $0$, so no Riesz contour isolates it, $W\mapsto W_-$ is not analytic, and $g_n$, $\rho$, $M$ and branches 2–3 have no definition. Branch 1 does survive, needing only $c_p$ and $S$, consistent with [L148](../findings/second-order.md):1193, *"Branch 1 is present there and equals $c_p/S$"*. And $W_{\mathbb{CP}^2}$'s $\delta^2=\tfrac19\ne0$ is consistent with [L148](../findings/second-order.md):1195.

**O2, a scope note, recorded and not raised as a discrepancy.** $W_{\mathbb{CP}^2}$ sits at $n=4$, below L147's own floor of $n\ge12$, so it cannot exhibit a failure *inside* the entry's range. And at the entry's base point $W^*=S^m\times S^m$ the spectrum is two-valued with no kernel ([L145](../findings/second-order.md) step 1, confirmed twice), so $\ker W^*=0$ is a **consequence** of the first hypothesis rather than a fourth independent one; "all four used" over-counts by one. The charitable reading is that the witness prices the obstruction for a successor moving the base point, which is how [L158](../findings/second-order.md):1296 reads it. **Withdrawn as a discrepancy on that reading; recorded because the pre-registered question asks.**

## 6. The gap between what is proven and what is used, $M=O(\rho)$

### D5, a real-symmetric fact under a complex supremum, load-bearing for the surviving claim

**Locate.** :1173:

> $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$

**Exhibit the failure concretely.** The supremum is over $\lvert z\rvert=\rho$ with $z$ **complex**, it has to be, because the whole point of $M$ is to feed $\lVert A''\rVert=O(M/\rho^2)$, which is Cauchy's estimate on a contour. For complex $z$, $W(z)=W^*+zH$ is complex symmetric and **not Hermitian**, and $W(z)_-$ is defined by the Riesz projection $-\tfrac1{2\pi i}\oint_\Gamma\zeta(W-\zeta)^{-1}d\zeta$ ([second-order.md](../findings/second-order.md):1471). The $1$-Lipschitz property is a theorem about the metric projection onto the closed convex cone of negative semidefinite **Hermitian** matrices; a Riesz projection of a non-normal operator is not an orthogonal projection, is not a metric projection onto a convex set, and has no nonexpansiveness. **The entry's own source says so and the entry drops it**: [r450](../reviews/REVIEW_r450.md):28 writes *"$x\mapsto x_-$ $1$-Lipschitz in Frobenius norm **on Hermitian operators**"*; L147 quotes the clause with that restriction removed.

**It is load-bearing for the surviving $n^{-3/2}$, not only for the refuted headline.** Branch 1's infimum is $2u^*/a$, decreasing in $a=\lVert A''\rVert$, so a **lower** bound on $r_n$ needs an **upper** bound on $a$, which is what $M=O(\rho)$ supplies. Replace $M=O(\rho)$ by the bound available without it, $M=O(1)$: then $\lVert A''\rVert=O(M/\rho^2)=O(1/\rho^2)$, and on the directions where $\lVert H\rVert_{op}=\Theta(1)$ and $\rho=\Theta(g_n)=\Theta(1/n)$ this is $O(n^2)$ rather than $O(n)$. With $a=\Theta(n^2)$, $c_p=\Theta(1/n)$ and $S=\Theta(1)$: $a^2c_p=\Theta(n^3)\gg S^2$, so $u^*=\Theta(\sqrt{c_p})=\Theta(n^{-1/2})$ and

$$f(u^*)=2u^*/a=\Theta(n^{-1/2}/n^2)=\Theta(n^{-5/2}),$$

which is below branch 3's $\rho/2=\Theta(n^{-1})$, so it binds the $\min$ and **the headline drops from $n^{-3/2}$ to $n^{-5/2}$**. The step is not decorative.

**Argue the opposite.** Three closures are available and none is on file in L147. (i) On $\Sigma$ the operator is diagonal in a real orthonormal basis, hence normal over $\mathbb C$ with orthogonal Riesz projections, [L148](../findings/second-order.md):1203 says exactly this, and there $A\equiv0$ anyway, so $M=0$ and the step is not needed. (ii) The identity theorem: $A$ is holomorphic on the disc and vanishes on the real diameter, hence vanishes identically, [v51](VERIFY_v51.md) F4 names it. (iii) A resolvent estimate bounding $\lVert W(z)_--W^*_-\rVert$ by $\lVert zH\rVert$ times a condition number, which would give $M=O(\rho)$ with a constant. **Every one of them is about $\Sigma$ or is unwritten**, and [L148](../findings/second-order.md):1207 says so in the entry's own file: *"[L147](../findings/second-order.md) justifies $M=O(\rho)$ by '$x\mapsto x_-$ is 1-Lipschitz in Frobenius norm', **a real-cone fact with no complex counterpart**, and it holds on the mixed directions rather than on $\Sigma$. A prior reader recorded this and L147 does not cite it."* The mixed directions are where L147's own chain lives.

**On file and unpaid.** [ROUND_L147](ROUND_L147.md) filed this as **F6**, raised by two verifiers; the round dispatched no adjudication, on the ground that "F5 and F6 concern a stated justification rather than a conclusion". The r2 text is **verbatim identical** to the r1 text at this passage. **Verdict on C6: `HYPOTHESIS-DEBT`.** What would have to be proved: *for $H$ outside $\Sigma$ and $\lvert z\rvert=\rho$, $\lVert\mathrm{Alt}(W(z)_-)-\mathrm{Alt}(W^*_-)\rVert\le C\lvert z\rvert\lVert H\rVert_F$ with $C$ absolute*, i.e. a Lipschitz bound for the Riesz negative part of a non-Hermitian complex-symmetric perturbation, uniform over the disc.

**A second, smaller omission at the same step.** The Lipschitz bound alone gives $M\le\lVert A(0)\rVert+\rho$. The step needs $A(0)=\mathrm{Alt}(W^*_-)=0$, which is on file at [L145](../findings/second-order.md)'s box ($W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$, three Bianchi tensors, [r446](../reviews/REVIEW_r446.md)) and is neither stated nor cited in L147.

### The rest of the chain, checked

$\lVert A''(0)\rVert\le2M/\rho^2$ is Cauchy at order $2$ and is right. $O(M/\rho^2)=O(\rho/\rho^2)=O(1/\rho)$ is right. On the margin summand [L146](../findings/second-order.md) gives $\lVert H\rVert_{op}=O(n^{-1/2})$, so $\rho=\Omega(g_n/n^{-1/2})=\Omega(n^{-1/2})$ and $O(1/\rho)=O(n^{1/2})$, **the displayed value reproduces**. And at $\rho=\Theta(g_n)=\Theta(1/n)$ it returns $O(n)$, "as it must", also right. **No finding on the arithmetic; the finding is on the hypothesis under it.**

## 7. D6, the statement box carries no hypothesis, and is false as written

**Locate.** :1167–1169, the whole of the LEMMA box.

**Exhibit the failure concretely.** Read as it stands, "$r_n\gtrsim n^{-3/2}$" quantifies over nothing. Take $H\in T_{W^*}\mathcal O$, a unit orbit-tangent direction. The functional is constant along the orbit, so $c(H)=0$, so $\inf_Hc(H)/C(H)=0$ and the displayed quantity is $0$, not $\Omega(n^{-3/2})$. Take $H=W^*$: the margin is $3\theta_0(\tfrac12-1)=-\tfrac32\theta_0=-1.854$ at $n=12$, negative. **This is the identical defect [L145](../findings/second-order.md):1106 records against its own box** (*"THREE HYPOTHESES WERE USED AND NONE STATED, AND WITHOUT THEM THE DISPLAYED OBJECT IS ZERO"*) and the identical defect [L148](../findings/second-order.md) was repaired for at [ROUND_L148-r2](ROUND_L148r2.md), whose repair note reads *"THE SCOPE CORRECTIONS ARE IN THE STATEMENT ABOVE, **WHICH IS WHERE A CITATION READS THEM**. They had been written into the boxes around it and not into it."* L147's corrections are in the boxes around it and not into it.

**Argue the opposite.** $r_n$ is a defined symbol whose definition, the tube radius about $SO(n)\cdot W^*$ over directions in $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, carries the constraints, so the box inherits them by the meaning of its symbol. That reading is genuinely available and is how a reader inside the block will take it. It fails for the reader the record says matters: $W^*$, $n$, $m$ and $H$ appear nowhere in the box, so nothing in the box says **which** orbit or **which** dimension floor, and $n\ge12$ is not recoverable from the symbol $r_n$ at all. The record has ruled on precisely this reading, twice, against it. **Upheld.**

## 8. The two forms, [results.md](../results.md)

**[results.md](../results.md) carries no canonical L147**, and no L145, L146, L148 or L149 either; its second-order block runs L24, L50–L54, L66, L67, L133, L140 at a glance, and L154–L158 in detail. [ROUND_L147](ROUND_L147.md) already records the absence.

**The absence is correct as far as it goes**, a headline under refutation and repair should not be propagated to the canon, and nothing in [results.md](../results.md) carries $n^{-1-\beta}$. **But the canon is not clean**, because [results.md](../results.md) carries [L158](../results.md), which restates L147's minimisation.

### D8, the canon substitutes $u$ for $w$ at the minimiser

**Locate.** [results.md](../results.md):363, inside the L158 entry:

> $f'(0)=-ac_p/S^2<0$, so $u=0$ is never its minimum, and $f(u^*)=2u^*/a$ is $\Theta(n^{-3/2})$ **at $u=\Theta(1)$**

against [findings/second-order.md](../findings/second-order.md):1183 and :1233, which both write **"at $w=\Theta(1)$"**.

**Exhibit the failure concretely.** $u^*=(\sqrt{S^2+a^2c_p}-S)/a\le(S+a\sqrt{c_p}-S)/a=\sqrt{c_p}$, using $\sqrt{x+y}\le\sqrt x+\sqrt y$. So $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ **always**, and $u=\Theta(1)$ is never the minimiser. Worse, the value stated there is wrong at the location stated: at $u=1$ with $a=\Theta(n)$, $c_p=\Theta(1/n)$, $S=\Theta(1)$,

$$f(1)=\frac{c_p+1}{S+a}=\frac{\Theta(1)}{\Theta(n)}=\Theta(n^{-1})\;\ne\;\Theta(n^{-3/2}),$$

off by $n^{1/2}$. No admissible regime rescues it: $f(u^*)=2u^*/a=\Theta(n^{-3/2})$ with $u^*=\Theta(1)$ would need $a=\Theta(n^{3/2})$, and the chain's own $\lVert A''\rVert=O(n^{1/2}+nw)$ caps $a$ at $O(n)$.

**Argue the opposite.** A reader could take "$u=\Theta(1)$" as a typo for $w$, since $w=\Theta(1)$ is what both source lines say and the surrounding sentence is otherwise correct. That is very likely what happened. It is still a finding, and a sharp one: [ROUND_L147](ROUND_L147.md)'s F3 exists **because** $u$ and $w$ were being conflated across this block, and the one place the correction had to land (the canon, which is what a reader outside the block cites), is the place that carries the substitution. **Upheld.** The repair is one character.

## 9. What would falsify the statement, and what I did to look for it

**The object that would break C1.** A unit direction $H\in T_{W^*}S\cap T_{W^*}\mathcal O^\perp$ at some even $n\ge12$ with

$$\frac{c(H)+u(H)^2}{S+\lVert A''\rVert u(H)}\;=\;o(n^{-3/2}),$$

i.e. either margin $c(H)=o(1/n)$ at bounded $\lVert A''\rVert$, or $\lVert A''\rVert=\omega(n)$ at margin $O(1/n)$.

**What I did to look for it, by hand and in closed form.**

- **The margin route is closed by [L27](../findings/nondegeneracy.md).** The margin is $3\theta_0(\tfrac12-\lambda)$ with $\lambda$ ranging over $L_e$'s ten scalars, and on $\lVert H\rVert_F=1$ it is a convex combination of them; the two negative-or-zero entries ($\lambda=1$ on $\langle W\rangle$, $\lambda=\tfrac12$ on the orbit) are removed by the two orthogonality hypotheses, and the smallest survivor is $+\mu$ on $\Lambda^2\otimes\Lambda^2$ with $\mu=1/(m-1)$, giving $3\theta_0\frac{m-3}{2(m-1)}\ge\tfrac34\theta_0$ for $m\ge5$. **So $c(H)\ge c_p=\Theta(1/n)$ with no direction below it.** No falsifier there.
- **The operator-norm route is closed by the same two inputs**, as computed in D4: margin $O(1/n)$ forces $w=O(n^{-1/2})$, forces $\lVert H\rVert_{op}=O(n^{-1/2})$, forces $\rho=\Omega(n^{-1/2})$, forces $\lVert A''\rVert=O(n^{1/2})$. No falsifier there **provided $M=O(\rho)$ holds**.
- **The one live opening is D5.** If $M=O(\rho)$ fails on the mixed directions, then on the $\lVert H\rVert_{op}=\Theta(1)$ directions $\lVert A''\rVert=O(1/\rho^2)=O(n^2)$ and $f(u^*)=\Theta(n^{-5/2})$, a falsifier of C1, exhibited in closed form and waiting only on whether the Riesz negative part of a complex-symmetric perturbation is Lipschitz. **That is why D5 is a debt and not a note.**
- I looked for a direction realising it and **did not construct one**: doing so requires a non-normal $W(z)$ with a resolvent condition number growing like $1/\rho$, which is a construction rather than a hand evaluation, and the analysis-only footing forbids the sweep that would screen it.

## Verdict

**`BROKEN`.**

The displayed inequality $r_n\gtrsim n^{-3/2}$ is the part that survives, as an order, with the six hypotheses of §1 supplied, and conditional on D5. Everything else the box says about the radius does not:

- the box's own bold clause asserts $n^{-1}$ at $\beta=0$, which the entry refutes fourteen lines below it (**D1**);
- the title asserts the $\beta$-dependence the refutation removed (**D2**);
- the ceiling is written as a bound on the radius at two sites, against [L145](../findings/second-order.md)'s explicit ruling that it caps the route (**D3**, and question 2's answer);
- a direction is asserted that the same box's next two sentences prove cannot exist (**D4**);
- the statement is false at an orbit-tangent direction, carrying no hypothesis at all (**D6**);
- $M=O(\rho)$ quotes [r450](../reviews/REVIEW_r450.md) with "on Hermitian operators" deleted, under a supremum over a complex circle, and the surviving headline needs it (**D5**, `HYPOTHESIS-DEBT` in isolation);
- $c(H)\gtrsim c_p+w^2$ is the un-repaired twin of a sentence [L149](../findings/second-order.md) marks unsafe at $n\in\{12,14\}$ (**D7**, `GAP`);
- and [results.md](../results.md):363 states the minimiser at $u=\Theta(1)$, where $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ always and $f=\Theta(n^{-1})$ (**D8**).

**Every numeral the entry names reproduced by hand**: $\theta_0(12)=1.236033$, $-\tfrac32\theta_0=-1.854$, $c_p/\theta_0=3/(n-2)=0.3$, $n^2-12n+8>0\iff n>6+2\sqrt7=11.2915$, $1+\sqrt{n-2}=4.16228$, $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$, and the neighbours' $0.741620$, $0.946260$, $0.719043$, $0.101595$, $0.3333$, $0.4472$. **The one thing I could not reproduce is D5's premise**, which is not a numeral but a theorem about non-Hermitian perturbations, and which no file on this record states.
