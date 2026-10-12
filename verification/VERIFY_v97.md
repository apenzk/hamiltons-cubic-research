# VERIFY v97, Lemma L2: the crossover $6+2\sqrt7$, the integer cutoff $12$ in both directions, and the odd-parity companion

**Cold brief, analysis only.** No script was run and no numerical work was done; every value below is an exact hand evaluation over $\mathbb Q$ or an exact statement about a surd. Log: [agent_logs/verify-L02-v97.log](../agent_logs/verify-L02-v97.log). Forms read: the block at [findings/problem.md](../findings/problem.md):160–175, the two rows at [results.md](../results.md):112 and [results.md](../results.md):300–304, [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) with its row at [lean/INDEX.md](../lean/INDEX.md):278 and the owed-list at [lean/INDEX.md](../lean/INDEX.md):368–378, and a fourth form the brief does not name, the ledger row at [findings/INDEX-results.md](../findings/INDEX-results.md):17. Sources read rather than recalled: [references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md), and the two reports the block cites, [REVIEW_r505.md](../reviews/REVIEW_r505.md) and [REVIEW_r506.md](../reviews/REVIEW_r506.md).

## Claim table

| # | claim, and where it is written | verdict |
| --- | --- | --- |
| 1 | $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ is the $p=q=n/2$ case of $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, [problem.md](../findings/problem.md):166 | **CORRECT**, reproved in §2.1 |
| 2 | the general sphere-product closed form itself | **CITATION, and the block cites nothing**, it is [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25 verbatim, in a read source, and independently derived at [Lemma L57](../findings/problem.md):554 |
| 3 | "The balanced product has $\theta_0(n)^2=\dots$" as written, with no parity clause | **HYPOTHESIS MISSING, $n$ even.** [conventions.md](../findings/conventions.md) names this exact gloss as what regrew a refuted constant |
| 4 | the competitor has $\theta^2=\tfrac32$ at every $n\ge4$, the padding half | **PROOF**, one sentence and complete; reproved in §3.2 |
| 5 | the same claim, the base value at $n=4$ | **CITATION with no pointer in the block**; the value is in a read source ([Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(a)) and derived twice on file |
| 6 | $\theta_0(n)^2-\tfrac32=\frac{n^2-12n+8}{2n^2}$, [problem.md](../findings/problem.md):168 | **CORRECT**, reproved in §4.1 |
| 7 | numerator $-3$ at $n=11$ | **CORRECT ARITHMETIC, WRONG OBJECT.** $n=11$ is odd; nothing attains $\theta_0(11)$. The attained excess is $-\tfrac1{54}$, not $-\tfrac3{242}$ |
| 8 | numerator $+8$ at $n=12$, root $6+2\sqrt7$, root irrational | **CORRECT** |
| 9 | integer cutoff $12$, both directions | **CORRECT over $4\le n$**; the range $n\ge4$ is used and never stated in the sign argument |
| 10 | at the irrational root itself | **NO EQUALITY CASE, AND NONE IS POSSIBLE**, reproved at both parities in §5.3, where the block proves only the even half |
| 11 | odd companion: $\Theta_n^2\ge\tfrac32$ is $n^2-13n+18\ge0$, root $\frac{13+\sqrt{97}}2$, [problem.md](../findings/problem.md):172 | **TRUE, UNPROVED AS WRITTEN.** $\Theta_n$ is never defined in the block, its closed form never stated, the reduction never performed |
| 12 | "the integer threshold $12$ survives at both parities" | **CORRECT**; the least odd witness is $13$, not $12$ |
| 13 | "derived three independent ways", [results.md](../results.md):302, and "by three independent derivations", [results.md](../results.md):112, and "confirmed three independent ways", [problem.md](../findings/problem.md):144 | **REFUTED AND LIVE IN THREE CITABLE SITES.** Withdrawn at [findings/INDEX-results.md](../findings/INDEX-results.md):17 and in the block's own callout, and nowhere else |
| 14 | "Still imported" list, [lean/INDEX.md](../lean/INDEX.md):376 | **INCOMPLETE**: the odd companion's input $\Theta_n^2$ is a third import and is not listed |
| 15 | [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) docstring, "proving them needs `𝒲ₙ` and `Q`, which do not exist yet" | **STALE**: [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) proves the competitor's value at $n=4$, as the row at [lean/INDEX.md](../lean/INDEX.md):278 records |
| 16 | W5 row, "$\Theta_n^2<3/2$ is $n^2-12n+8<0$", [lean/INDEX.md](../lean/INDEX.md):273 | **MISATTRIBUTED POLYNOMIAL, CONCLUSION UNHARMED**: at odd $n$ the excess is governed by $n^2-13n+18$; the two integer solution sets coincide on $n\ge4$ |
| 17 | the two constants are commensurable, same normalisation | **NO FINDING, and it self-certifies**: §3.3 shows $\theta^2=\tfrac34$ would give the threshold $n\ge4$, so only $\tfrac32$ produces $n^2-12n+8$ |
| 18 | quantifier order, $\ker W\ne0$, smallest admissible dimension | **NO FINDING** on $\ker W$ (§6.3); scope notes only on the other two |

**Verdict: PROVEN, hypotheses corrected.** The crossover, the cutoff and the odd companion are all true and I reproved every one of them by hand; the corrections owed are that the displayed proof is an even-$n$ argument that never says so, that its $n=11$ endpoint reads a value nothing attains, and that the withdrawn "three independent ways" claim is still standing in the two rows a consumer would cite.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated from memory.

- $\mathcal W_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$, of dimension $\frac{n(n-3)(n+1)(n+2)}{12}$, so $0$ at $n=3$ and $10$ at $n=4$, which fixes $n\ge4$ as the smallest admissible dimension.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$.
- $\theta_0(n)$ is **"the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more"**. The file adds, in bold: *"The gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant"*, and states the value is the balanced sphere product's **at even $n$ only**.
- $\Theta_n$ is the diagonal maximum: $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$, attained at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$.
- The gap between them at odd $n$ is $\theta_0^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}$.

## 1. The hypothesis inventory

**Hypotheses the block carries in its own words.** $n\ge4$, stated once and only inside the competitor sentence ("at every $n\ge4$"). Nothing else. In particular the block never writes "$n$ even", never writes "$n$ integral", and never restricts the polynomial's sign argument to $n\ge4$.

**Hypotheses the block's objects require.**

| object | hypothesis it carries | does the block state it? | is the block's use inside it? |
| --- | --- | --- | --- |
| $\theta(S^p\times S^q)$ closed form | $p+q=n$, $p,q\ge2$ | no | yes |
| the balanced product $S^{n/2}\times S^{n/2}$ | **$n$ even** | **no** | **no**, the proof evaluates at $n=11$ |
| $\Theta_n$ (odd branch) | $n$ odd, $n\ge5$ | no, the symbol is undefined in the block | yes |
| padded $W_{\mathbb{CP}^2}$ / Fox's $\mathcal S^4(\alpha)$ | $n\ge4$; $\mathfrak{su}(2)_+\subset\mathfrak{so}(n)$ a subalgebra | yes, both | yes |
| $\mathcal W_n\ne0$ | $n\ge4$ | partially | yes |
| the sign statement "cutoff $12$" | $4\le n$, $n\in\mathbb Z$ | no | yes |

**Hypotheses of imported results.** The block imports two values and names no result for either, so it inherits no hypothesis by citation, it inherits them by object instead, and they are the rows above. Where the record does name a source, the hypotheses match: [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25 is stated for every split $k+l=n$, and Theorem 4.14 for $n\ge9$, the latter irrelevant here, since the block consumes only the value at $n=4$ and carries it up by its own padding argument.

**Which of these the written proof actually uses.** The subalgebra hypothesis, load-bearing, and used correctly. The $n\ge4$ range, load-bearing at three separate points and stated at one. The even-$n$ hypothesis, load-bearing on the whole first sentence and stated nowhere. No hypothesis is used that the statement omits in any other direction: no criticality of a third object, no $\ker W=0$, no gradedness, no diagonality.

*Silence answered: the proof uses no hypothesis the statement omits, except the parity one, which is §5.*

## 2. Input A, the balanced value

### 2.1 The specialisation, in full

With $p=q=n/2$:

$$(p-1)(q-1)=\Big(\frac{n-2}2\Big)^2=\frac{(n-2)^2}4,\qquad pq=\frac{n^2}4,$$

$$\theta(S^{n/2}\times S^{n/2})^2=\frac{2(n-1)\cdot\frac{(n-2)^2}4}{(n-2)\cdot\frac{n^2}4}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

Correct. It needs $n\ne0$ and $n\ne2$ to divide, both free at $n\ge4$; and it needs $n$ even for the left-hand side to name a manifold.

### 2.2 Is the general formula proved, or cited?

**Cited, and the block cites nobody.** The formula stands bare in [problem.md](../findings/problem.md):166 with no pointer. Following the record rather than the block: [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25, quoted verbatim in the reference notes from the extraction at line L1483, reads $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}$, whose square is $\frac{2(n-1)(k-1)(l-1)}{kl(n-2)}$, the block's formula, symbol for symbol. That source is in [references/](../references/) and I read the notes file. The record also derives it independently at [Lemma L57](../findings/problem.md):554, "from criticality with $\lambda_V=1-n$ independent of the split", contributed by [r500](../reviews/REVIEW_r500.md).

**An independent cross-check I ran by hand, on the record's own second route.** [problem.md](../findings/problem.md):156 item 12 gives, for the two-eigenvalue subalgebra family, $P/\lVert W\rVert^3=\frac2n\sqrt{rN/(N-r)}$ with $r=\dim\mathfrak h$ and $N=\binom n2$. At the balanced product $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, so $r=2\binom{n/2}2=\frac{n(n-2)}4$ and

$$N-r=\frac{n(n-1)}2-\frac{n(n-2)}4=\frac{n^2}4,\qquad \frac{rN}{N-r}=\frac{\frac{n(n-2)}4\cdot\frac{n(n-1)}2}{\frac{n^2}4}=\frac{(n-1)(n-2)}2,$$

whence $\left(\frac2n\right)^2\cdot\frac{(n-1)(n-2)}2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. Two routes on the record meet exactly.

## 3. Input B, the competitor's value

### 3.1 What the block argues, and what it asserts

The sentence is: *"The competitor has $\theta^2=\frac32$ at every $n\ge4$, since $\mathfrak{su}(2)_+$ is a subalgebra and $W^\#$ therefore stays inside $\Lambda^+$ under padding."* The "since" clause supplies the **extension** and says nothing about the **base value**. So the block proves half of this claim and asserts the other half.

### 3.2 The padding half is a proof, and it is correct

$W_{\mathbb{CP}^2}$ is supported on $\Lambda^+(\mathbb R^4)\cong\mathfrak{su}(2)_+$. Structure constants $c_{\alpha\gamma\delta}=\langle[v_\gamma,v_\delta],v_\alpha\rangle$ of $\mathfrak{so}(n)$ vanish unless $\alpha\in\Lambda^+$ whenever $\gamma,\delta\in\Lambda^+$, because $[\Lambda^+,\Lambda^+]\subseteq\Lambda^+$. Since $W^\#_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$ has every $W$-index inside the support, $W^\#$ is supported on $\Lambda^+\times\Lambda^+$ and is literally the same matrix at every $n$. $W^2$ likewise. $\lVert W\rVert$ is unchanged by adjoining zeros. Hence $\theta=\langle W,Q(W)\rangle/\lVert W\rVert^3$ is unchanged, exactly, at every $n\ge4$. Ricci-flatness in $\mathbb R^4$ gives Ricci-flatness in $\mathbb R^n$, so the padded operator stays in $\mathcal W_n$. This is [r505](../reviews/REVIEW_r505.md):52's argument and [r506](../reviews/REVIEW_r506.md):64's, and it survives my reading.

### 3.3 The base value is imported, and the record holds it, in a read source and twice more

The block gives no derivation and no pointer for $\theta^2=\tfrac32$ at $n=4$. Following the record instead:

- **A read source.** [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Theorem 4.14(a), quoted verbatim in the notes: *"$W\in\langle W_{\mathbb{CP}^2}\rangle$ is an eigenvector of eigenvalue $\sqrt{3/2}$."*
- **[r506](../reviews/REVIEW_r506.md) F2, input B.** From the record's own $n=4$ closed form $P=9(\det W^++\det W^-)$: maximising $9\det W^+$ over trace-free $(a,b,c)$ with $a^2+b^2+c^2=1$ gives $a=b=-t$, $c=2t$, $6t^2=1$, hence $P=18t^3=18/6^{3/2}=3/\sqrt6=\sqrt{3/2}$, with realising spectrum $(0,0,0,-1,-1,2)/\sqrt6$.
- **[r505](../reviews/REVIEW_r505.md) §1.2.** $\operatorname{tr}(W^3)=1/\sqrt6$ and $\langle W^\#,W\rangle=3\gamma^2w_1w_2w_3=2/\sqrt6$ from the bracket $[a_1,a_2]=-\sqrt2\,a_3$, summing to $3/\sqrt6=\sqrt{3/2}$.
- **In Lean.** [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) proves `Pcubic WCP2 ^ 2 * 2 = 3 * ((WCP2ᵀ * WCP2).trace) ^ 3`, by `native_decide`, so it is compiler-trusted rather than kernel-checked, and the file says so.

**My own check, independent of all four.** Take $W$ supported on $\Lambda^+$ with spectrum $t(2,-1,-1)$ and write $W^\#=\kappa\cdot(\lambda_2\lambda_3,\lambda_3\lambda_1,\lambda_1\lambda_2)$ for the convention constant $\kappa$ of the $\mathfrak{su}(2)$ brackets. Then $Q(W)=t^2(4+\kappa,\ 1-2\kappa,\ 1-2\kappa)$, and idempotency $Q(W)=\theta W$ forces $-(4+\kappa)=2(1-2\kappa)$, i.e. $\kappa=2$. At $\kappa=2$, $Q(W)=3t^2(2,-1,-1)=3t\,W$, and $\lVert W\rVert^2=6t^2$ normalises $t=1/\sqrt6$, giving $\theta=3/\sqrt6=\sqrt{3/2}$. **The value is forced by idempotency alone, with no convention input**, which is why the two sides of the crossing cannot be in mismatched normalisations.

### 3.4 The normalisation trap, tested rather than assumed

The named carried-in trap is a constant that agrees at even $n$ and differs at odd $n$; the older trap on this block is $\sqrt{3/2}$ against $\sqrt3/2$. Both are checkable here without any external input, because **the polynomial certifies its own normalisation**. Take the deflated $\theta^2=\tfrac34$ instead of $\tfrac32$:

$$\frac{2(n-1)(n-2)}{n^2}\ge\frac34\iff 8(n-1)(n-2)\ge3n^2\iff 5n^2-24n+16\ge0,$$

whose roots are $\frac{24\pm16}{10}=\{0.8,\ 4\}$, a threshold of $n\ge4$, nothing resembling $12$. So $n^2-12n+8$ can only have come from $\tfrac32$. The block is on the right side of the trap and could not have been on the wrong one while stating that polynomial.

**Parity dependence of every constant in the block, checked one by one.** $\tfrac32$: none, it is the value of a fixed $4$-dimensional object carried up by padding, and $\S3.2$ shows the carrying is exact at every integer $n$. $\theta_0(n)$: **rationally $n$-uniform, geometrically even-$n$ only**, and this is the block's live parity issue (§5). $\Theta_n$: parity-split by definition. $6+2\sqrt7$ and $\frac{13+\sqrt{97}}2$: the even and odd roots respectively. **Which constant the block's argument actually uses: $\theta_0(n)$, at both parities, including at the odd integer $n=11$ where it is attained by nothing.**

## 4. The threshold arithmetic

### 4.1 The identity

$$\theta_0(n)^2-\frac32=\frac{2(n-1)(n-2)}{n^2}-\frac32=\frac{4(n-1)(n-2)-3n^2}{2n^2}=\frac{4n^2-12n+8-3n^2}{2n^2}=\frac{n^2-12n+8}{2n^2}.$$

Correct.

### 4.2 The endpoints, exactly

| $n$ | $n^2-12n+8$ | $\theta_0(n)^2$ | $\theta_0(n)^2-\tfrac32$ |
| --- | --- | --- | --- |
| $11$ | $121-132+8=-3$ | $\tfrac{180}{121}$ | $-\tfrac3{242}$ |
| $12$ | $144-144+8=+8$ | $\tfrac{55}{36}$ | $+\tfrac1{36}$ |

### 4.3 The root and its irrationality

$n=\frac{12\pm\sqrt{144-32}}2=6\pm\frac{\sqrt{112}}2=6\pm2\sqrt7$, and $6+2\sqrt7=11.2915\ldots$ Since $7$ is not a perfect square, $\sqrt7\notin\mathbb Q$, hence $6+2\sqrt7\notin\mathbb Q$ and no integer is a root. Correct, and matching [crossover_root](../lean/HamiltonsCubic/Results/L2.lean) and [crossover_irrational](../lean/HamiltonsCubic/Results/L2.lean).

### 4.4 Both directions of the cutoff

Over the integers with $4\le n$: the parabola is negative strictly between its roots $6-2\sqrt7=0.7085\ldots$ and $6+2\sqrt7=11.2915\ldots$, so it is negative on $\{4,\dots,11\}$ and positive from $12$ on. **Sufficiency and insufficiency are separately checked and both hold.** The lower root is what makes $n\ge4$ load-bearing: without it, $n=0$ gives $+8$ and "cutoff at $12$" is false. [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) carries `4 ≤ n` in `cutoff_is_twelve` and its two sign lemmas; the prose does not.

## 5. The parity question, the carried-in trap, live in the proof body

### 5.1 Locate it exactly

[problem.md](../findings/problem.md):166, first sentence of the proof:

> **Proof.** The balanced product has $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$, the special case $p=q=n/2$ of $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$.

and [problem.md](../findings/problem.md):170, the sentence that carries the "insufficient" direction:

> whose numerator is $-3$ at $n=11$ and $+8$ at $n=12$, with root $6+2\sqrt7$.

### 5.2 Exhibit the failure concretely, at a named dimension

At $n=11$ there is no balanced sphere product: $p=q=11/2$ is not a manifold. The largest sphere-product value at $n=11$ is at $S^5\times S^6$:

$$\Theta_{11}^2=\frac{2\cdot10\cdot4\cdot5}{9\cdot5\cdot6}=\frac{400}{270}=\frac{40}{27},\qquad \Theta_{11}^2-\frac32=\frac{80-81}{54}=-\frac1{54},$$

against the block's $-\frac3{242}$. The two differ by $\frac{180}{121}-\frac{40}{27}=\frac{4860-4840}{3267}=\frac{20}{3267}$, which is exactly [conventions.md](../findings/conventions.md)'s $\frac{8(n-1)}{n^2(n+1)(n-2)}=\frac{80}{13068}$ at $n=11$. **So the number the proof reads at its own load-bearing endpoint is the value of no object in dimension 11**, and [conventions.md](../findings/conventions.md) names this exact gloss ("the value at the balanced sphere product") as the one that regrew a refuted constant, and forbids it.

### 5.3 Argue the opposite, the most charitable reading

The charitable reading is available and it is strong: **the statement L2 makes is about the formal continuation, not about a manifold at $n=11$.** The headline says the crossover is $6+2\sqrt7\approx11.29$, a non-integer, so the object crossing there is by construction the continued rational function, and $\theta_0$ is defined in [conventions.md](../findings/conventions.md) as "the closed form … and nothing more". Under that reading the $n=11$ evaluation is a legitimate evaluation of a rational function, the block's own next paragraph draws the distinction explicitly ("**Two things are exact here and they are different**"), and the conclusion is unaffected because both readings give a negative excess at $n=11$.

**What survives the charity.** The reading rescues the sentence at [problem.md](../findings/problem.md):170 but not the one at :166, which attributes the closed form to "the balanced product" with no parity clause, the forbidden gloss, in the sentence a consumer reads first. And it does not rescue the *use*: the insufficiency direction is only interesting because it says nothing in dimension $11$ beats the competitor, and that statement needs $\Theta_{11}$, not $\theta_0(11)$. **The candidate stands as a hypothesis correction, not as a break**: insert "$n$ even" at :166 and re-base the $n=11$ endpoint on $\Theta_{11}^2-\tfrac32=-\tfrac1{54}$.

### 5.4 The odd companion, checked and found unproved as written

The block asserts, after the $\square$: *"$\Theta_n^2\ge\frac32$ is $n^2-13n+18\ge0$, root $\frac{13+\sqrt{97}}2=11.4244$."* True, here is the derivation the block does not give. At odd $n$, $p=\frac{n-1}2$, $q=\frac{n+1}2$:

$$(p-1)(q-1)=\frac{(n-3)(n-1)}4,\quad pq=\frac{n^2-1}4,\quad \Theta_n^2=\frac{2(n-1)^2(n-3)}{(n-2)(n-1)(n+1)}=\frac{2(n-1)(n-3)}{(n-2)(n+1)},$$

$$\Theta_n^2-\frac32=\frac{4(n-1)(n-3)-3(n-2)(n+1)}{2(n-2)(n+1)}=\frac{(4n^2-16n+12)-(3n^2-3n-6)}{2(n-2)(n+1)}=\frac{n^2-13n+18}{2(n-2)(n+1)}.$$

Roots $\frac{13\pm\sqrt{169-72}}2=\frac{13\pm\sqrt{97}}2$, and $\frac{13+\sqrt{97}}2=11.42442\ldots$ Since $97$ is prime, $\sqrt{97}$ is irrational and no integer attains this root either, **so there is no equality case at either parity, and the block proves that only for the even one.** Endpoints: $n=11$ gives $-4$ and $\Theta_{11}^2-\tfrac32=-\tfrac4{216}=-\tfrac1{54}$, agreeing with §5.2; $n=13$ gives $+18$ and $\Theta_{13}^2=\frac{2\cdot12\cdot10}{11\cdot14}=\frac{120}{77}$, excess $+\frac9{154}$.

**What the block owes on this paragraph.** $\Theta_n$ is used and never defined in the block; its odd closed form is never written; the reduction above is never performed; irrationality is never claimed. All four are on the record, the definition at [conventions.md](../findings/conventions.md), the closed form at [Lemma L57](../findings/problem.md):554, the reduction at [problem.md](../findings/problem.md):204 and again inside [Lemma L20](../findings/problem.md):454, and none of them is pointed at from here. **Read alone, as a consumer would, the odd companion is a bare assertion.**

**"The integer threshold $12$ survives at both parities", correct, with one nuance worth stating.** For odd $n\ge13$ the excess is positive and for odd $4\le n\le11$ it is negative, so $n\ge12$ is a valid bound at both parities. But the least odd witness is $13$: at odd parity the bound $12$ is not attained by any dimension, it is merely valid. Both [r505](../reviews/REVIEW_r505.md):68 and [problem.md](../findings/problem.md):454 say this correctly.

## 6. Scope, quantifiers and edges

### 6.1 Quantifier order

The headline quantifies over a real parameter ("$n=6+2\sqrt7$ is exactly where") and the cutoff over integers. The block never separates them syntactically; its own next paragraph does. The correct pair of statements is: *for real $x\ge4$, $\theta_0(x)^2-\tfrac32$ has a unique zero, at $x=6+2\sqrt7$, negative below and positive above*; and *for integers $n\ge4$, $\Theta_n>\sqrt{3/2}$ iff $n\ge12$*. The uniqueness clause needs $x\ge4$ to exclude the second root $6-2\sqrt7$; the block states no range for the polynomial.

### 6.2 The smallest admissible dimension

$n=4$: $\dim\mathcal W_4=10>0$, $\dim\mathcal W_3=0$, so $n\ge4$ is right and the block's one range statement is at the right place. At $n=4$ the two values are $\theta_0(4)^2=\tfrac34$ against $\tfrac32$, the competitor wins by the largest margin on the range, and $\sqrt3/2=0.866$ is $\theta_0(4)$ rather than a deflated $\sqrt{3/2}$, a collision [r506](../reviews/REVIEW_r506.md):99 already tabled.

### 6.3 $\ker W\ne0$

**No finding.** The competitor is a maximal-kernel point by construction, padded $W_{\mathbb{CP}^2}$ has spectrum $(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2(\mathbb R^4)$ and zero on all $\binom n2-6$ remaining directions, so $\dim\ker W=\binom n2-3$. No step of L2 invokes a result whose hypothesis excludes that: the padding argument is a statement about the support, not the kernel; nothing here uses the gradedness slack $S(W)$, which [trap W4](../findings/INDEX-traps.md) records as vacuous when $\ker W\ne0$; nothing uses $\Delta$, whose equivariance certificate needs $\ker W=0$. **The proof is safe on the one edge where the record most often is not.**

### 6.4 Odd $n$, see §5. Even $n$, no finding.

## 7. Comparing the four forms

I checked four, one more than the brief names.

| form | what it carries that the others do not | what it lacks |
| --- | --- | --- |
| [problem.md](../findings/problem.md):160–175 | the only derivation; the parity remark; the callout withdrawing "three independent ways" | any pointer to either input; the even-$n$ hypothesis in the proof body |
| [results.md](../results.md):300–304 and :112 | nothing mathematical, both are summaries | **carries the withdrawn "derived three independent ways"; carries no parity clause**; the parity clause is 200 lines away at [results.md](../results.md):88 |
| [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) + row at [lean/INDEX.md](../lean/INDEX.md):278 | the arithmetic machine-checked, with `4 ≤ n` explicit where the prose leaves it implicit, and the odd polynomial's root and signs | the two geometric inputs; a stale docstring; and the row's owed-list omits the odd input |
| [findings/INDEX-results.md](../findings/INDEX-results.md):17 | **the withdrawal, in full**, plus the odd crossover and the both-parities statement | it is a ledger row, so nobody cites it as the result |

**What [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) proves, read line by line.** `sphereProductSq_balanced` (§2.1's algebra, with `n ≠ 0`, `n ≠ 2`), `theta0Sq_sub_three_halves` (§4.1), `crossover_root` and `crossover_irrational` (§4.3), `threshold_neg` / `threshold_pos` / `threshold_at_eleven` / `threshold_at_twelve` / `cutoff_is_twelve` (§4.2, §4.4, both directions, over `4 ≤ n`), and `odd_crossover_root` / `odd_threshold_neg` / `odd_threshold_pos` (§5.4's polynomial, its root, and its signs). **Every one of these is a statement about a real or integer polynomial.** The bridge from each polynomial to the geometric quantity it is about ($\theta_0(n)^2$ to the balanced product, $n^2-13n+18$ to $\Theta_n$), is imported in both cases. The row at [lean/INDEX.md](../lean/INDEX.md):278 says the first import plainly. The owed-list at [lean/INDEX.md](../lean/INDEX.md):376 lists $\theta_0(n)^2$ and the competitor above $n=4$ and stops; **the odd branch's $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ is a third import and appears in neither.**

## 8. The named trap: each citable claim read alone

### 8.1 Locate it exactly

[results.md](../results.md):302, the canonical row, ending in "**Proof:** [problem.md](../findings/problem.md)":

> $n=6+2\sqrt7\approx11.29$ is exactly where the balanced sphere-product overtakes the $\mathbb{CP}^2$-type competitor (Fox's $\mathcal S^4(\alpha)$), **derived three independent ways**. Reproduces the $n\geq12$ threshold exactly, not just approximately.

[results.md](../results.md):112, the headline bullet:

> The two named competitors swap ranks at $n=6+2\sqrt7\approx11.29$, in closed form and **by three independent derivations**.

[problem.md](../findings/problem.md):144, item 1, thirty lines above the block that withdraws it:

> **The exact crossover is $n = 6+2\sqrt7 \approx 11.29$, confirmed three independent ways.**

### 8.2 Exhibit the failure concretely

The claim is withdrawn twice on the record, in the block's own callout at [problem.md](../findings/problem.md):174 and at [findings/INDEX-results.md](../findings/INDEX-results.md):17, which says in bold *"'Derived three independent ways' is withdrawn"*. The substance of the withdrawal, from [r506](../reviews/REVIEW_r506.md):100 and :117, is concrete and I confirmed it against the cited text: route 2, the Tachibana-trick computation, **never computes the competitor at all** (its own entry concedes it "was not checked for the $\mathbb{CP}^2$-type tensor") so it cannot produce $n^2-12n+8=0$; route 3's absolute $P$ is $2\times$ Fox's, so it pins only the ratio; and stage 3, the rearrangement, has no independent versions at all. **[r506](../reviews/REVIEW_r506.md):201 recommended exactly this repair to [results.md](../results.md) and the repair was applied to [problem.md](../findings/problem.md) and the ledger instead.** A consumer citing L2 from [results.md](../results.md), the file that ends the row with "**Proof:** problem.md", so the file a reader starts from, repeats a claim the record has retracted.

### 8.3 Argue the opposite

The most charitable reading is that "derived three independent ways" was always meant of the two *objects* rather than of the threshold, which is [r506](../reviews/REVIEW_r506.md):117's own conclusion, *"true of the constructions of the two objects and false of the derivation of the threshold, which is single"*. On that reading the sentence is careless rather than false. **It does not survive**, for one reason: the sentence's grammatical subject is the crossover, not the objects, and one of the three routes does not construct the competitor either, so even the charitable count is two rather than three for the object that matters. **The candidate stands.**

### 8.4 The second inherited defect, same mechanism

[results.md](../results.md):302 has no parity clause; the parity correction lives at [results.md](../results.md):88, two hundred lines earlier, in a paragraph about the problem statement. A consumer reading the L2 row alone takes "the balanced sphere-product" as an object existing at every $n$, which is the [L0](../findings/problem.md) failure that [conventions.md](../findings/conventions.md) records the price of.

## 9. What is proven, what is used, and what a consumer may cite

| | |
| --- | --- |
| **proven, here and on the record** | for real $x\ge4$: $\theta_0(x)^2>\tfrac32$ iff $x>6+2\sqrt7$, with the root irrational. For integers $n\ge4$: $\Theta_n>\sqrt{3/2}$ iff $n\ge12$, strictly at both parities, by $n^2-12n+8$ at even $n$ and $n^2-13n+18$ at odd $n$ |
| **used, and imported** | $\theta(S^p\times S^q)^2$, cited, published ([Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Prop. 2.25) and independently derived at [L57](../findings/problem.md). $\theta(\mathcal S^4(\alpha))^2=\tfrac32$ at $n=4$, cited, published ([Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Thm. 4.14(a)) and derived twice on file |
| **argued in the block** | only the padding extension, and the threshold arithmetic |
| **a consumer may cite** | "$\theta_0(n)$ crosses $\sqrt{3/2}$ at $n=6+2\sqrt7$" ([results.md](../results.md):37, exact and clean); "for every integer $n\ge12$ the best sphere product beats the $\mathbb{CP}^2$-type competitor, and for $4\le n\le11$ it does not" |
| **a consumer may NOT cite** | "derived three independent ways", in any of its three forms; "the balanced sphere product's value is $\theta_0(n)$" without "$n$ even"; and (the direction the record is careful about elsewhere and the row is not), **sufficiency**. L2 gives $n\ge12$ as *necessary* for Conjecture A: below it the competitor beats the sphere product outright. That $n\ge12$ *suffices* is the open conjecture, and [results.md](../results.md):302's "Reproduces the $n\ge12$ threshold exactly" does not say which direction it means |

## 10. What would break it, and what I did to look

**The object that would falsify the statement.** A Weyl operator in $\mathcal W_n$ for some $4\le n\le11$ with $P/\lVert W\rVert^3\ge\sqrt{3/2}$ that is a sphere product (which would break the insufficiency direction) or, more damagingly, a corrected value for $\theta(\mathcal S^4(\alpha))$ different from $\sqrt{3/2}$, which is the single point of failure the record names and which would move the polynomial and hence the threshold.

**What I did to look.** For the first: the sphere-product value is maximised over splits at the most balanced one, since $(1-\tfrac1p)(1-\tfrac1q)$ increases as $p$ and $q$ even out, so the whole family at a given $n$ is capped by $\Theta_n$; I evaluated $\Theta_n^2-\tfrac32$ in exact rationals at both parities and it is negative on every integer of $[4,11]$, $-\tfrac1{54}$ at the largest, $n=11$. No such object exists among sphere products. For the second: I re-derived $\sqrt{3/2}$ from idempotency alone (§3.3), which fixes the bracket normalisation rather than assuming it; I checked the deflated alternative $\tfrac34$ and found it produces the threshold $n\ge4$ rather than $12$ (§3.4), so the recorded polynomial is incompatible with the one substitution this record has actually made; and I read the value in a source that is in [references/](../references/) rather than recalling it. **I found no falsifier and no candidate for one.**

**Not looked for, and named as such.** Whether some *non*-sphere-product operator at $n\le11$ exceeds $\sqrt{3/2}$ is outside L2, L2 compares two named objects, and [results.md](../results.md):112 is careful to say "of the two". Deciding it is the low-dimensional half of Conjecture A.

## Verdict

**PROVEN, hypotheses corrected.**

The crossover $6+2\sqrt7$, the integer cutoff $12$ in both directions, and the odd companion $\frac{13+\sqrt{97}}2$ are all true; I reproved each by hand in exact arithmetic, and both of the block's imported values sit in a source that is in [references/](../references/) and are independently derived on file by the two reports the block cites. The corrections owed:

1. **Insert "$n$ even" at [problem.md](../findings/problem.md):166** and re-base the $n=11$ endpoint at :170 on $\Theta_{11}^2-\tfrac32=-\tfrac1{54}$ rather than $\theta_0(11)^2-\tfrac32=-\tfrac3{242}$.
2. **Strike "derived three independent ways" from [results.md](../results.md):302 and "by three independent derivations" from [results.md](../results.md):112**, and the same phrase from [problem.md](../findings/problem.md):144, withdrawn at [findings/INDEX-results.md](../findings/INDEX-results.md):17 and still standing in the three places a consumer reads.
3. **Give the odd companion its input**: define $\Theta_n$ or point at [conventions.md](../findings/conventions.md), state $\Theta_n^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$, and note that $97$ is prime so the odd root is irrational too.
4. **Point at the two inputs**, [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Prop. 2.25 and Thm. 4.14(a), and [Lemma L57](../findings/problem.md), which the block does not do and which [r506](../reviews/REVIEW_r506.md):201 asked for.
5. **In [lean/](../lean/), for whoever owns it**: add the odd input to the owed-list at [lean/INDEX.md](../lean/INDEX.md):376; refresh the stale [L2.lean](../lean/HamiltonsCubic/Results/L2.lean) docstring, which says `𝒲ₙ` and `Q` "do not exist yet" while [Base/CP2.lean](../lean/HamiltonsCubic/Base/CP2.lean) uses them; and correct the W5 row at [lean/INDEX.md](../lean/INDEX.md):273, whose "$\Theta_n^2<3/2$ is $n^2-12n+8<0$" attributes the even polynomial to $\Theta_n$ at both parities, the two integer solution sets on $n\ge4$ coincide, so the row's conclusion is unharmed and only its reason is wrong.
