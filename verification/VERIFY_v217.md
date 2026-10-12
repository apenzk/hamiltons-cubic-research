# VERIFY_v217, Lemma L71, cold read

**Cold read of [BRIEF_L71.md](BRIEF_L71.md), sections A–C, against [bounds.md](../findings/bounds.md), [conventions.md](../findings/conventions.md), [graded-half.md](../findings/graded-half.md) and [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md).** **No numerical work of any kind was done**, no script, no Sage, no evaluation; every number below that I touched at all was reconstructed in closed form by hand as a screen on a claim I was about to record, and is labelled as a screen. Log: [agent_logs/verify-L71-v217.log](../agent_logs/verify-L71-v217.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Saturation gives $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak r]=0$ | **CONFIRMED** |
| 2 | $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$ is a subalgebra | **CONFIRMED** |
| 3 | $\mathfrak r$ centralises $\mathfrak g'$ | **CONFIRMED** |
| 4 | $\mathfrak h$ normalises $\mathfrak g'$, by Jacobi from $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ alone | **CONFIRMED**, wording ambiguous |
| 5 | $\mathfrak g'$ is an ideal, hence $\mathfrak r=0$ and $\mathfrak h=[\mathfrak m,\mathfrak m]$ | **CONFIRMED** |
| 6 | "$W$ has exactly two eigenvalues" is derived, not assumed | **CONFIRMED, the rescue holds, no circularity** |
| 7 | $\mathfrak{so}(n)$ simple at every $n\ge3$ except $n=4$; $n=3$ excluded as vacuous | **CONFIRMED** |
| 8 | $n=4$ is the sole exception and $W_{\mathbb{CP}^2}$ realises it structurally | **CONFIRMED** |
| 9 | $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ from $\mathfrak h=[\mathfrak m,\mathfrak m]$ | **CONFIRMED**, and non-circular |
| 10 | $(n-2)\lambda_{\max}=n\lvert\lambda_{\min}\rvert$ from (A) and (B) at an $\mathfrak m$-row | **CONFIRMED**, one step unstated |
| 11 | $\dim\mathfrak h=n(n-2)/4$, $\dim\mathfrak m=n^2/4$, non-circular | **CONFIRMED** |
| 12 | $\theta=\theta_0(n)$ | **CONFIRMED** |
| 13 | No critical point saturates at odd $n\ge5$ | **CONFIRMED** |
| 14 | $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{n^2}4+t^2-\tfrac n2$ forces $t=0$; $\mathfrak u(n/2)$ excluded | **CONFIRMED** |
| 15 | Cartan is Aut-conjugacy, the lemma consumes $SO(n)$-conjugacy, the gap | **REAL, closed at $n\ne8$ by an uncited step; closed at $n=8$ by ONE of the block's two routes** |
| 16 | $n=8$: "determinant $+1$, so inner, so Cartan up to Aut already delivers $SO(8)$-conjugacy" | **DEFECT, the inference does not follow, and the block's own dimension-$16$ example refutes it** |
| 17 | $n=8$: the weight pattern $(1^4,(-1)^4)$ on $V$, $S^+$, $S^-$ | **CONFIRMED, this route is complete** |
| 18 | "by two independent routes" | **OVERSTATED**, the same species as the block's own defect (iii) |
| 19 | The $7\times10^{-16}$ residual is tautological | **CONFIRMED, and so is the whole "Verified structure" paragraph** |
| 20 | Final identification of $W$ as the Weyl tensor of $S^{n/2}\times S^{n/2}$ | **HYPOTHESIS-DEBT, asserted here and proved nowhere on the record** |

**Verdict: GAP.** The central question is answered in the block's favour, the two-eigenvalue conclusion is genuinely derived, the ideal argument removes the hypothesis, and nothing upstream of it smuggles $\mathfrak r=0$ back in. The classification half is where the block fails to establish what it asserts: its $n=8$ determinant sentence is an invalid inference refuted by its own dimension-$16$ example, and the step that makes Cartan usable at every even $n\ne8$ is never stated here at all.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), line 38:

> $\mathfrak m$, $\mathfrak h$, $\mathfrak r$, at a critical point, $\mathfrak m=E_{\min}$, $\mathfrak h=E_{\max}$ and $\mathfrak r$ everything else, kernel included. **$\mathfrak m$ carries three incompatible senses across the record**, this one, [L36](../findings/isotropy-cap.md)'s whole negative eigenspace, and [target.md](../findings/target.md)'s symmetric-pair odd part, so read it from context

And line 30:

> $\mathfrak h$ is the **isotropy** algebra here, where this table gives it as $E_{\max}$

And:

> $\theta$, $P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$

> $\theta_0(n)$, **the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.**

**On the collisions the brief names.** $\mathfrak h$, $\mathfrak m$, $\mathfrak r$ are used in the L71 block in the table's own sense throughout, and the block's opening sentence restates the definition rather than quoting it, a convention violation, but the sense is the tabled one and nothing turns on it. $\mathfrak g'$, $t$, $p$, $q$ are block-local and appear in no collision table; $t$ is used only in the $p=\tfrac n2+t$ parametrisation and does not collide inside the block. $E_{\max}$, $E_{\min}$ are used consistently. **No symbol collision does damage here.**

## 1. Hypothesis inventory

**A pass without this is not a pass.** Everything the block's chain consumes, and where.

| hypothesis | stated in the block? | where consumed |
| --- | --- | --- |
| $W$ a critical point, $Q(W)=\theta W$ | yes | relation (C), i.e. the saturation equation itself |
| $\lVert W\rVert=1$ | **no** | [L70](../findings/bounds.md)'s identity is scale-dependent by its own text; and $\theta=\theta_0(n)$ needs it |
| $W\in\mathcal W_n$, first Bianchi and Ricci-flatness | **no** | relation (B); and $\operatorname{tr}W=0$, which gives $\lambda_{\min}<0<\lambda_{\max}$ |
| $n\ge5$ | yes | simplicity of $\mathfrak{so}(n)$; and excluding the vacuous $n=3$ |
| saturation $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ | yes | the three bracket relations |
| $\mathfrak m\ne0$ | yes | $\mathfrak g'\ne0$, so the ideal is everything |
| $T_{abc}$ totally symmetric | **no** | the "mass splitting evenly across the support" step in §6 |
| $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ for $n\ge5$, $n\ne8$ | **no**, it is on the record at [graded-half.md](../findings/graded-half.md) line 414 and uncited from here | the whole $n\ne8$ half of the Cartan step |
| $\mathrm{Int}(\mathfrak{so}(8))=\mathrm{Ad}(SO(8))$, and the inner-involution list | **no** | what the $n=8$ determinant sentence would need to be valid |
| the two-eigenvalue operator at the balanced split **is** the Weyl tensor of $S^{n/2}\times S^{n/2}$ | **no**, and I found it proved nowhere on the record | the final sentence of the conclusion |

**A hypothesis stated but never used**: none found. The sub-result "$(\mathfrak g',[\mathfrak m,\mathfrak m])$ is a symmetric pair with odd part $\mathfrak m$" is *derived and then never consumed* (once $\mathfrak g'=\mathfrak{so}(n)$ it is subsumed by the global statement) but it is a conclusion, not a hypothesis, and the subalgebra half of it is load-bearing.

**A step using a hypothesis never stated**: four, all in the table above with "no" in the middle column. The two that matter are the last three rows; the first three are standing conventions a reader can recover.

## 2. Saturation to the three bracket relations, derived in full

[L70](../findings/bounds.md)'s identity is

$$\theta=\lambda_{\min}+(n-2)\lambda_{\max}-\frac{D(v)}{\lvert\lambda_{\min}\rvert},\qquad D(v)=\tfrac12\sum_{a,b}\big(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}\big)c_{vab}^2 ,$$

for every unit $v\in E_{\min}$, so the scalar hypothesis $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ is exactly $D(v)=0$ for every such $v$.

**Every summand is a nonnegative weight against a nonnegative factor**, so $D(v)=0$ forces $c_{vab}=0$ whenever $\lambda_a\lambda_b>\lambda_{\min}\lambda_{\max}$. **The equality set of the factor is exactly the corner pairs.** Take $x,y\in[\lambda_{\min},\lambda_{\max}]$ with $\lambda_{\min}<0<\lambda_{\max}$, strict, from $\operatorname{tr}W=0$ at $W\ne0$, which the L70 block itself supplies. If $xy=\lambda_{\min}\lambda_{\max}<0$ then one of them is negative, say $x<0<y$; then $xy\ge\lambda_{\min}y\ge\lambda_{\min}\lambda_{\max}$, the first step because $x\ge\lambda_{\min}$ and $y>0$, the second because $\lambda_{\min}<0$ and $y\le\lambda_{\max}$. Equality in both forces $x=\lambda_{\min}$ and $y=\lambda_{\max}$. **So $c_{vab}=0$ unless one of $a,b$ lies in $\mathfrak m$ and the other in $\mathfrak h$**, the block's "$\mathrm{ad}(v)$ supported on $E_{\min}\otimes E_{\max}$".

Reading $c_{vab}=\langle[v,e_a],e_b\rangle$ off that, for every $v\in\mathfrak m$ (linearity in $v$ extends the unit-vector statement to all of $\mathfrak m$):

- $e_a\in\mathfrak m$: the only admissible $b$ are in $\mathfrak h$, so $[v,e_a]\in\mathfrak h$. **$[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$.**
- $e_a\in\mathfrak h$: the only admissible $b$ are in $\mathfrak m$, so $[v,e_a]\in\mathfrak m$. **$[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$.**
- $e_a\in\mathfrak r$: $a$ is neither a $\lambda_{\min}$ nor a $\lambda_{\max}$ index, so no pair containing it is admissible and $c_{vab}=0$ for every $b$. **$[\mathfrak m,\mathfrak r]=0$.**

**All three CONFIRMED.** Note the third covers $\ker W$ without a separate argument, because [conventions.md](../findings/conventions.md) puts the kernel inside $\mathfrak r$ and $0$ is neither $\lambda_{\min}$ nor $\lambda_{\max}$ under the strict sign.

**One scope point the block does not make and should.** L70's own blockquote warns that the boxed bound is the *weakened* member of its family and that its equality case characterises saturation of the weakened bound. That is precisely the hypothesis L71 takes, so **L71 is unaffected**, the sharp bound is a different, stronger statement and L71 never claims to saturate it. The blockquote's hedge "the two agree whenever $\lambda_{\min}$ has multiplicity $\ge2$" is not needed by L71 at all.

## 3. Subalgebra, then ideal, the central question

**Subalgebra.** $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]$, and since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ with $\mathfrak h\perp\mathfrak m$ (distinct eigenspaces of the symmetric $W$), the sum is direct.

- $[\mathfrak m,\mathfrak m]\subseteq\mathfrak g'$ by construction.
- $[[\mathfrak m,\mathfrak m],\mathfrak m]\subseteq[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$. **CONFIRMED.**
- $[[\mathfrak m,\mathfrak m],[\mathfrak m,\mathfrak m]]$: for $x,y\in\mathfrak m$ and $z\in[\mathfrak m,\mathfrak m]$, Jacobi gives $[[x,y],z]=[x,[y,z]]-[y,[x,z]]$, and $[y,z]\in[\mathfrak m,[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak h]\subseteq\mathfrak m$, so each term lies in $[\mathfrak m,\mathfrak m]$. **CONFIRMED.** The block writes this as a single chain $\subseteq[\mathfrak m,[\mathfrak m,[\mathfrak m,\mathfrak m]]]$, which is loose (Jacobi produces a *sum* of two such terms) but the content is right.

**$\mathfrak r$ centralises $\mathfrak g'$.** $[\mathfrak r,\mathfrak m]=0$ is the third relation; $[\mathfrak r,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak r,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak r,\mathfrak m]]=0$. **CONFIRMED.**

**$\mathfrak h$ normalises $\mathfrak g'$.** $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m\subseteq\mathfrak g'$ is the second relation. And

$$[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[[\mathfrak h,\mathfrak m],\mathfrak m]+[\mathfrak m,[\mathfrak h,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]+[\mathfrak m,\mathfrak m]=[\mathfrak m,\mathfrak m] .$$

**The containment is correct and Jacobi does give it outright from $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ alone.** No use is made of $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, which is the point that keeps §5 from being circular.

**Wording defect.** The block reads "using only $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, **which the Jacobi identity proves outright**". The antecedent of "which" is ambiguous. Under the intended reading (Jacobi proves the *displayed containment*), the sentence is true. Under the nearer-antecedent reading (Jacobi proves $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$), it is **false**: that inclusion is a consequence of L70's equality case and of nothing else. Worth a rewrite; not a mathematical defect.

**Ideal.** $\mathfrak{so}(n)=\mathfrak m\oplus\mathfrak h\oplus\mathfrak r$ orthogonally, and each summand carries $\mathfrak g'$ into itself: $\mathfrak m$ because $\mathfrak g'$ is a subalgebra containing it, $\mathfrak h$ by the normalisation, $\mathfrak r$ by the centralisation. **So $[\mathfrak{so}(n),\mathfrak g']\subseteq\mathfrak g'$. CONFIRMED.**

### The answer to the round's question

**The two-eigenvalue conclusion is DERIVED. The ideal argument really does remove the hypothesis, and $\mathfrak r=0$ enters nowhere upstream of it.**

Trace what each step consumes: §2 consumes only $D(v)=0$ and the strict sign of the extreme eigenvalues; the subalgebra, centralisation and normalisation steps consume only the three relations of §2 plus Jacobi. **Not one of them refers to $\mathfrak r$ except as a set on which brackets with $\mathfrak m$ vanish**, and that vanishing is a *conclusion* of §2, not an assumption that $\mathfrak r$ is empty. Simplicity then gives $\mathfrak g'=\mathfrak{so}(n)$, and since $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$,

$$\mathfrak m\oplus\mathfrak h\oplus\mathfrak r=\mathfrak g'=\mathfrak m\oplus[\mathfrak m,\mathfrak m]\ \Longrightarrow\ \mathfrak h\oplus\mathfrak r\subseteq[\mathfrak m,\mathfrak m]\subseteq\mathfrak h\ \Longrightarrow\ \mathfrak r=0,\ \ \mathfrak h=[\mathfrak m,\mathfrak m].$$

$\mathfrak r=0$ says $W$ has no eigenvalue other than $\lambda_{\min}$ and $\lambda_{\max}$ and no kernel; these are distinct because $\lambda_{\min}<0<\lambda_{\max}$. **Exactly two eigenvalues, and the derivation had no two-eigenvalue input.** The audit blockquote's defect (i) is correctly diagnosed and correctly repaired.

**Degenerate branches, checked.** If $[\mathfrak m,\mathfrak m]=0$ the argument still runs, $\mathfrak g'=\mathfrak m$ is an ideal, so $\mathfrak{so}(n)=\mathfrak m$ is abelian, false for $n\ge3$. If $\mathfrak h=0$ the same display fails at $\lambda_{\max}>0$. Neither branch is exercised, and neither is a hole.

## 4. $\mathfrak r=0$ needs simplicity, the boundary of the range

**"$\mathfrak{so}(n)$ simple at every $n\ge3$ except $n=4$" is CORRECT.** $\mathfrak{so}(3)\cong\mathfrak{su}(2)$ simple; $\mathfrak{so}(4)\cong\mathfrak{su}(2)\oplus\mathfrak{su}(2)$ not; $\mathfrak{so}(n)$ simple for every $n\ge5$. The range starts at $3$ because $\mathfrak{so}(2)$ is abelian, and the block's phrasing "every $n\ge3$" is right on that count.

**$n=3$: the block's reason is CORRECT.** $\dim\mathcal W_n=\tfrac{n(n-3)(n+1)(n+2)}{12}$ ([conventions.md](../findings/conventions.md)) vanishes at $n=3$, so there is no unit $W$ and no critical point. The statement's $n\ge5$ therefore excludes $n=3$ for vacuity and not for a failure of simplicity, exactly as written.

**$n=4$: the sole exception, and structurally so. CONFIRMED, and I checked the witness by hand.** $W_{\mathbb{CP}^2}$ has $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ with $W$ acting as $(2,-1,-1)\kappa$ on $\Lambda^+$ and $0$ on $\Lambda^-$. So $\mathfrak h=E_{\max}$ is one-dimensional, $\mathfrak m=E_{\min}$ two-dimensional, $\mathfrak r=\Lambda^-$ three-dimensional. Then $\mathfrak g'=\mathfrak m+[\mathfrak m,\mathfrak m]=\Lambda^+\cong\mathfrak{so}(3)$ and $\mathfrak r=\Lambda^-\cong\mathfrak{so}(3)$, which centralises it. **The block's "$\mathfrak g'$ is one $\mathfrak{so}(3)$ factor, $\mathfrak r$ the other" is exactly right**, and it is the one place a non-simple $\mathfrak{so}(n)$ lets a nonzero $\mathfrak r$ survive. It also confirms L70's separate claim that $\dim E_{\min}\ge n/2$ and $\dim E_{\max}\ge(n-2)/2$ are attained here at $2$ and $1$.

**Screen, closed form.** $\lVert W\rVert^2=6\kappa^2=1$ gives $\kappa=1/\sqrt6$, so $\lambda_{\max}=2/\sqrt6$, $\lambda_{\min}=-1/\sqrt6$, and saturation reads $\lambda_{\min}+2\lambda_{\max}=3/\sqrt6=\sqrt{3/2}$, so $\theta=\sqrt{3/2}=1.224744871$, which is the block's own defect figure for $-W_{\mathbb{CP}^2}$, as it must be, since $Q(-W)=Q(W)$ makes $-W$ critical at $-\theta$ while the right-hand side $\lambda_{\min}+(n-2)\lambda_{\max}$ becomes $-2\kappa+2\kappa=0$. **Saturation is genuinely not sign-invariant and the block's correction is right.** The same screen at the balanced $n=4$ product gives $\theta=\sqrt3/2=0.866025404$ and defect $\sqrt3/2$ for its negative, both of the block's $n=4$ figures reproduced in closed form.

## 5. The symmetric pair

$[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ and $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$ are §2's relations. The third leg:

$$[\mathfrak h,\mathfrak h]=[\mathfrak h,[\mathfrak m,\mathfrak m]]\subseteq[\mathfrak m,\mathfrak m]=\mathfrak h ,$$

using $\mathfrak h=[\mathfrak m,\mathfrak m]$ from §3 and the normalisation from §3. **CONFIRMED, and not circular**, the normalisation was proved without $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, so the order $\text{ideal}\to\mathfrak h=[\mathfrak m,\mathfrak m]\to[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$ is sound. The audit blockquote's defect (ii) is correctly diagnosed and correctly repaired.

**An unstated step.** The block goes from "symmetric pair" to "Cartan's classification" without constructing the object Cartan classifies. What is needed, and is immediate: define $\sigma=+1$ on $\mathfrak h$, $-1$ on $\mathfrak m$; the three inclusions make $\sigma$ an automorphism, $\sigma^2=1$, and $\mathfrak{so}(n)^\sigma=\mathfrak h$. **This is the hypothesis-check the import demands and the block does not print it.** Named here rather than supplied as a repair.

## 6. $\dim\mathfrak h=n(n-2)/4$

Write $h=\lambda_{\max}>0$, $m=\lvert\lambda_{\min}\rvert>0$. Relations (A) and (B) of [bounds.md](../findings/bounds.md), at a row $k=a$ with $e_a\in\mathfrak m$:

$$\text{(A)}\ \sum_{\beta\gamma}T_{a\beta\gamma}=2(n-2),\qquad \text{(B)}\ \sum_{\beta\gamma}\lambda_\beta T_{a\beta\gamma}=-2\lambda_a=2m .$$

At saturation $T_{a\beta\gamma}=c_{a\beta\gamma}^2$ is supported on ordered pairs with one index in $\mathfrak m$ and the other in $\mathfrak h$. **$T$ is totally symmetric**, so the two orientations carry equal mass: with $S=\sum_{\beta\in\mathfrak m,\gamma\in\mathfrak h}T_{a\beta\gamma}$, (A) gives $2S=2(n-2)$, so $S=n-2$. **This is the block's "with $T$'s mass splitting evenly across the support", and it is forced by total symmetry rather than assumed, the block does not say so, which is the one unstated step here.** Then (B) reads

$$(\lambda_{\min}+\lambda_{\max})S=2m\ \Longrightarrow\ (h-m)(n-2)=2m\ \Longrightarrow\ (n-2)h=nm .$$

**CONFIRMED.** Independent cross-check by relation (C) at the same row: $\sum\lambda_\beta\lambda_\gamma T_{a\beta\gamma}=2S\lambda_{\min}\lambda_{\max}=-2(n-2)mh$, against $2\lambda_a(\theta-\lambda_a)=-2m(\theta+m)$, giving $\theta=(n-2)h-m$, **which is the saturation equation itself.** So (C) at an $\mathfrak m$-row *is* the hypothesis, and (A) and (B) are the two independent inputs. Combining, $\theta=nm-m=(n-1)m$, reproducing [L117](../findings/bounds.md)'s converse $\theta=(n-1)\lvert\lambda_{\min}\rvert$ from a different direction.

**Then, and only then, tracelessness.** With $\mathfrak r=0$ there are exactly two eigenvalues and $\operatorname{tr}W=0$ reads $\dim\mathfrak h\cdot h=\dim\mathfrak m\cdot m$. With $h/m=n/(n-2)$ and $\dim\mathfrak h+\dim\mathfrak m=N=\tfrac{n(n-1)}2$:

$$\dim\mathfrak h\Big(1+\frac{n}{n-2}\Big)=\frac{n(n-1)}2\ \Longrightarrow\ \dim\mathfrak h=\frac{n(n-2)}4,\qquad \dim\mathfrak m=\frac{n^2}4 .$$

**CONFIRMED, and NOT circular.** The ratio is derived from (A), (B) and the support condition alone, all of which are available while $\mathfrak r$ is still unknown; only the passage from ratio to dimensions consumes $\mathfrak r=0$, and $\mathfrak r=0$ was proved in §3 without any dimension input. **The block's "only after $\mathfrak r=0$" is the right caveat in the right place.**

**The block's own control is correct.** At $W_{\mathbb{CP}^2}$, $n=4$: $(n-2)h=2\cdot2\kappa=4\kappa$ and $nm=4\kappa$, so the ratio holds; while $\dim\mathfrak h=1\ne n(n-2)/4=2$, so the dimension formula correctly fails, exactly because $\mathfrak r\ne0$ there.

**And $\theta=\theta_0(n)$ follows.** $\lVert W\rVert^2=\tfrac{n(n-2)}4h^2+\tfrac{n^2}4m^2$ with $h=nm/(n-2)$ equals $\tfrac{n^2m^2(n-1)}{2(n-2)}$; setting it to $1$ gives $m^2=\tfrac{2(n-2)}{n^2(n-1)}$, and $\theta=(n-1)m$ gives $\theta^2=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$. **CONFIRMED**, and it matches [conventions.md](../findings/conventions.md)'s closed form exactly, including the file's warning that $\theta_0$ is the balanced value *at even $n$ only*, which is consistent, because §7 shows there is nothing to evaluate at odd $n$.

## 7. Parity, what the lemma says at odd $n\ge5$

At odd $n\ge5$ the chain runs unchanged through §3 and §6: $\mathfrak{so}(n)$ is simple, so $\mathfrak r=0$, so $\dim\mathfrak m=n^2/4$. **$n$ odd makes $n^2$ odd, so $n^2/4\notin\mathbb Z$ and no saturating critical point exists. CONFIRMED.**

**So at odd $n\ge5$ the lemma is a conditional with an empty antecedent**, and its clauses, including "$W$ is the Weyl tensor of $S^{n/2}\times S^{n/2}$", whose subject is not a manifold when $n$ is odd, are vacuously true. That is logically sound and mildly ugly; the boxed statement already puts the odd-$n$ conclusion in the same sentence, so a reader is not misled. **No defect.** The landscape line at [results.md](../results.md) line 196 says "no critical point saturates at odd $n$" without the $n\ge5$ qualifier while the canonical entry has it; at $n=3$ the unqualified form is still true, vacuously, so this is a harmless looseness rather than an error.

## 8. Uniqueness, and the Cartan import

**The dimension identity.** $\dim(\mathfrak{so}(p)\oplus\mathfrak{so}(q))=\tfrac{p^2+q^2-(p+q)}2$; with $p=\tfrac n2+t$, $q=\tfrac n2-t$ this is $\tfrac{n^2/2+2t^2-n}2=\tfrac{n^2}4+t^2-\tfrac n2$. **CONFIRMED.** The target $\tfrac{n(n-2)}4=\tfrac{n^2}4-\tfrac n2$, so equality forces $t^2=0$, hence $t=0$, at every even $n$ with no case list. **CONFIRMED, defect (iv) is correctly repaired.**

**$\mathfrak u(n/2)$.** $\dim\mathfrak u(m)=m^2$, so $\dim\mathfrak u(n/2)=n^2/4>n^2/4-n/2$ for every $n\ge1$. **Excluded on dimension. CONFIRMED.**

**Completeness of the list.** Cartan's classification for the compact $\mathfrak{so}(n)$ gives exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ with $p+q=n$, and $\mathfrak u(n/2)$ at even $n$. **This is on file**, [CARTAN-SEARCH.md](../references/CARTAN-SEARCH.md) records fact 1 as sourced twice, by [Holland–Ion](../references/holland-ion-2012-symmetric-spaces/) Chapter 8 for the compact form and by [Etingof](../references/etingof-2024-real-forms-involutions/) §41.4 for the complex form with the determinant of each realising element. I read the Etingof extract at source: items 5 and 6 enumerate the involutions of $\mathfrak{so}(2n)$ as $\mathrm{Ad}(g)$ with $g\in O(2n)$, splitting on $\det g$ and on $g^2=\pm1$, and give $\mathfrak k=\mathfrak{so}_{2p}\oplus\mathfrak{so}_{2q}$, $\mathfrak{gl}_n(\mathbb C)$ and $\mathfrak{so}_{2p+1}\oplus\mathfrak{so}_{2q-1}$. **The list is right.**

### 8.1 Is the Aut-versus-$SO(n)$ gap real?

**Real, and it is closed, but at $n\ne8$ by a step this block never states, and at $n=8$ by only one of the two routes it offers.**

**At $n\ge5$, $n\ne8$.** Every automorphism of $\mathfrak{so}(n)$ is $\mathrm{Ad}(g)$ for some $g\in O(n)$, so Aut-conjugacy of involutions *is* $O(n)$-conjugacy of the gradings, and $O(n)$-conjugacy is all the lemma needs, the Weyl tensor of $S^{n/2}\times S^{n/2}$ read in a reflected frame is still the Weyl tensor of $S^{n/2}\times S^{n/2}$. **This step is load-bearing at every even $n$ and appears nowhere in the L71 block.** It is on the record, [graded-half.md](../findings/graded-half.md) line 414, "$\mathrm{Aut}(\mathfrak{so}(n))=PO(n)$ for $n\ge5$ with $n=8$ the sole exception", corroborated at line 534 to [Ziller](../references/ziller-2010-lie-groups-symmetric-spaces/) Prop. 4.43 and Ex. 4.45, and uncited from L71. **Reported as a missing citation of a load-bearing hypothesis, not as a hole in the mathematics.**

**At $n=8$ the gap is genuine**, because $\mathrm{Aut}(\mathfrak{so}(8))/\mathrm{Int}\cong S_3$ and two of the three outer cosets contain involutions not realised in $O(8)$ at all. The record's own witness is right and I checked its arithmetic: $\dim(\mathfrak{sp}(1)\oplus\mathfrak{sp}(2))=3+10=13=3+10=\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(5))$, the first acting irreducibly on $\mathbb R^8$ and so in no $O(8)$-class of the second ([graded-half.md](../findings/graded-half.md) lines 420–423). **So dimension alone does not decide the class, and the block's withdrawal of the "$\dim\mathfrak g^\theta$ is an Aut-invariant" sentence is correct**, that sentence answers list-completeness, which was never the question.

### 8.2 The determinant sentence, DEFECT

The block asserts:

> its determinant is $+1$, so $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is inner and Cartan's classification up to $\mathrm{Aut}$ already delivers $SO(8)$-conjugacy

**Located**: [bounds.md](../findings/bounds.md) line 44 and again verbatim at line 54; and in the canonical entry at [results.md](../results.md) line 617.

**The premise is true and the inference is not.** $\mathrm{diag}(-1_4,1_4)$ has determinant $(-1)^4=+1$, lies in $SO(8)$, and its $\mathrm{Ad}$ is inner. But **being inner does not make an Int-class Aut-stable**, and the block's own next clause exhibits the counterexample: $\mathrm{Ad}(J)$ for a complex structure $J$ is inner ($\det J=+1$) with fixed algebra $\mathfrak u(4)$, and $\mathrm{Ad}(\mathrm{diag}(-1_2,1_6))$ is inner with fixed algebra $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$; both have fixed dimension $16$, both are inner, and the block itself calls them a triality "swap". **So "inner" is exactly the hypothesis that fails to separate the block's own dimension-$16$ pair, and it is offered as the reason the dimension-$12$ class is separated.** The inference does not follow.

**Discrepancy protocol, all three cleared.** *Located*: the two lines above. *Exhibited concretely, in closed form*: the pair $\mathrm{Ad}(J)$ and $\mathrm{Ad}(\mathrm{diag}(-1_2,1_6))$, both inner involutions of $\mathfrak{so}(8)$ with $16$-dimensional fixed algebras and non-$O(8)$-conjugate fixed subalgebras, $\mathfrak u(4)$ acts irreducibly on $\mathbb R^8$ while $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ preserves a $2$-plane. *Argued the opposite*: the charitable reading is that the block means "the balanced Int-class is triality-stable, and inner-ness is one input to that". Under that reading the sentence is still incomplete, because the second input (that the dimension-$12$ inner class is the unique one), is never printed; and the reading cannot be recovered from the text, which says "so ... already delivers".

**What would have to be proved to repair it**, named and not supplied: *(a)* no outer involution of $\mathfrak{so}(8)$ has a $12$-dimensional fixed algebra, and *(b)* $\mathrm{Ad}(\mathrm{diag}(-1_4,1_4))$ is the unique inner involution class of $\mathfrak{so}(8)$ with $12$-dimensional fixed algebra. **Both are true and the record holds material for both**, the $n=8$ table at [graded-half.md](../findings/graded-half.md) lines 420–421 lists the two extra triality classes at dimensions $21$ and $13$ only, and Etingof's items 5 and 6 give the inner list, but the block prints neither, and [graded-half.md](../findings/graded-half.md) line 538 explicitly records the number of $O(8)$-classes as **open**. **So the repair cannot simply be cited from inside the record either.**

### 8.3 The weight sentence, CONFIRMED, and this route carries the step

> its weight pattern $(1^4,(-1)^4)$ agrees on $V$, $S^+$ and $S^-$

**This is correct and it is complete.** $g=\mathrm{diag}(-1_4,1_4)$ is the rotation by $\pi$ in the $(12)$- and $(34)$-planes, so a $\mathrm{Spin}(8)$ lift acts on a half-spin weight $(a_1,a_2,a_3,a_4)$, $a_i=\pm\tfrac12$, by $e^{i\pi(a_1+a_2)}$. That is $+1$ exactly when $a_1+a_2=0$, which on $S^+$ (even sign count) admits $2\times2=4$ of the $8$ weights, and likewise on $S^-$; on $V$ the pattern is $(-1)^4,(+1)^4$ by construction. **All three $8$-dimensional representations see the same eigenvalue multiset**, so a triality image of the lift has on $V$ the multiset the lift has on $S^\pm$, hence is $O(8)$-conjugate to $g$, and $SO(8)$-conjugate because the $-1$-eigenspace has even dimension. **The balanced involution's Int-class is triality-stable, which is exactly what the argument consumes.**

The sanity check attached to it, that the same test separates $\mathfrak u(4)$ from $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$, whose realising elements have $V$-patterns $(\pm i)^4$ and $(-1)^2,(+1)^6$, is correct as a statement that the test is not vacuous.

**One overstatement.** Calling it "the $\mathfrak u(4)\leftrightarrow\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ **swap**" asserts that triality does swap them, while [graded-half.md](../findings/graded-half.md) line 538 records that question as open and needing a branching no source on file supplies. **The block and graded-half.md disagree about the status of the same fact.** Nothing downstream depends on it; the test's usefulness needs only that the two are distinguished, not that they are exchanged.

### 8.4 "By two independent routes"

**Overstated.** One route (weights) closes the step; the other (determinant) does not close it as written. This is the same species of overclaim the block's own defect (iii) corrects two paragraphs earlier (where "routes (i) and (ii) are not independent" was the finding) so the block corrects one instance of the pattern and commits another in the sentence that follows.

### 8.5 The final identification, HYPOTHESIS-DEBT

"Hence $W$ is the Weyl tensor of $S^{n/2}\times S^{n/2}$" needs one more step the block does not print. With $\mathfrak r=0$ and $\mathfrak h$ the balanced split, $W$ is pinned up to scale as $\Pi_{\mathfrak h}-\tfrac rN I$ and its scale is fixed by $\lVert W\rVert=1$; **what is still owed is that this operator is the Weyl tensor of $S^{n/2}\times S^{n/2}$.**

**I looked for that claim's home and did not find one.** [L23](../findings/ungraded-slack.md) constructs the subalgebra family $W\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ and caps its dimension, and [INDEX-results.md](../findings/INDEX-results.md) row 105 says of the neighbouring result, in the record's own words, that "identifying the balanced product is [L71](../findings/bounds.md)'s conclusion, not this one's". Grepping "is the Weyl tensor of" across [findings/](../findings/) and [results.md](../results.md) returns only L71's own two statements. **So the identification is asserted by L71 and proved by nothing.**

**Consistency screen**: the operator has eigenvalue ratio $h/m=(N-r)/r=\dim\mathfrak m/\dim\mathfrak h=n/(n-2)$, matching §6 exactly, so nothing here is *inconsistent*. **What is missing is an argument, and the finding is that there is none on file**, not a repair. What would have to be proved: that the Weyl tensor of the balanced product, normalised, equals $\Pi_{\mathfrak h}-\tfrac rN I$ up to positive scale at $\mathfrak h=\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$.

## 9. The named traps, each answered

- **$\ker W\ne0$ and padded objects.** Handled correctly. The kernel sits inside $\mathfrak r$ by [conventions.md](../findings/conventions.md), the relation $[\mathfrak m,\mathfrak r]=0$ covers it with no separate case, and $\ker W=0$ falls out of $\mathfrak r=0$ as a corollary, which the block says, and correctly says is **false at $n=4$**, where $W_{\mathbb{CP}^2}$ has a $3$-dimensional kernel. **The deleted "$\mathfrak r\subseteq\ker W$ conjecture" blockquote is right to delete it.** *Padded $W_{\mathbb{CP}^2}$*: I screened the block's figure. Padding is critical in $\mathcal W_n$ (its Ricci vanishes; $W^\#$ stays supported on $\mathfrak{so}(4)$ since $[\mathfrak{so}(4),\mathfrak{so}(4)]=\mathfrak{so}(4)$), so $\theta=\sqrt{3/2}$ is unchanged, while the Killing marginal grows with $n$. The slack is $\lambda_{\min}+(n-2)\lambda_{\max}-\theta=(2n-8)/\sqrt6$, so $D(v)=\lvert\lambda_{\min}\rvert\cdot(2n-8)/\sqrt6=(n-4)/6\cdot2=(n-4)/3$. **The block's $(n-4)/3$ is exact, vanishes at $n=4$ as it must, and is the one figure in the block I could reproduce in closed form.**
- **The boundary of every stated range.** $n=3$, vacuous, correctly excluded for the right reason (§4). $n=4$, the sole exception, structurally, with the witness verified (§4). $n=5$, inside the range, and the odd-$n$ argument disposes of it (§7). Odd $n$, vacuous conditional, sound (§7). $n=8$, the one dimension where Aut-conjugacy is strictly coarser, and the block's handling is half-complete (§8.2, §8.3). **$n=6+2\sqrt7$**, [fence post F7](../findings/fence-posts.md)'s crossover is a threshold for *which* point maximises $\theta$, and L71 is an equality classification that is uniform in $n$ and makes no comparison between families. **It has no boundary there and needs none**; the block correctly makes no claim near it, and its closing sentence (that L71 "serves as no step of a proof of the conjecture"), is what keeps the two apart.
- **A claim proven on a subfamily and used in general.** L70's block contains exactly such a reduction, "on Lemma L23's two-eigenvalue family this reduces to a Lie-theoretic condition". **L71 does not use it.** §2 derives the three relations from the general equality case with no family restriction. **Trap avoided.**
- **A hypothesis stated but never used, and a step using one never stated.** The first: none, per §1. The second: four, per §1, of which the load-bearing ones are $\mathrm{Aut}(\mathfrak{so}(n))=\mathrm{Ad}(O(n))$ at $n\ne8$, the $n=8$ inner enumeration, and [L23](../findings/ungraded-slack.md). **The two-eigenvalue circularity that this trap names was real in the predecessor and is now genuinely gone**, see §3.
- **A universal claim with no witness.** The lemma's universal claim is over saturating critical points, and at even $n\ge6$ the witness is the balanced product itself, which the record holds. At odd $n$ the class is empty by proof, not by failure to find a witness. **No un-witnessed universal.**
- **An imported theorem whose hypotheses were never checked.** Cartan is the import. Its hypotheses (a compact simple Lie algebra and an involutive automorphism), **are** met: simplicity is §4, and the involution is constructed from the grading in one line. **But the block never constructs it** (§5), and it never states the equivalence relation Cartan uses versus the one it consumes (§8.1) beyond flagging that they differ. **The unital-algebra failure mode the brief names (a cited theorem assuming something the object lacks), does not recur here; what recurs is the weaker form, an import whose hypothesis-check is left to the reader.**
- **Symbol collisions.** Checked against [conventions.md](../findings/conventions.md); see §0. None does damage.

## 10. Numbers in this block

**The disowning of $7\times10^{-16}$ is correct, and it does not go far enough.** The block measures $[\mathfrak h,[\mathfrak m,\mathfrak m]]$ off $[\mathfrak m,\mathfrak m]$ at the theorem's own output points, where $\mathfrak h=[\mathfrak m,\mathfrak m]$ already holds, so the residual is the noise of a tautology. **Every other figure in the "Verified structure at the saturating points" paragraph is of exactly that kind**, and the block does not say so:

- **$\dim\mathfrak r=0$**, measured at points where $\mathfrak r=0$ is the defining property.
- **$[\mathfrak m,\mathfrak m]=\mathfrak h$ exactly, dimensions $6,12,20,30$ at $n=6,8,10,12$**, these are $n(n-2)/4$ evaluated at $6,8,10,12$, which the theorem outputs. Arithmetic, not measurement.
- **$\dim\mathfrak m+\dim[\mathfrak m,\mathfrak m]=N$**, the strongest case: $\tfrac{n^2}4+\tfrac{n(n-2)}4=\tfrac{n(n-1)}2$ is an identity in $n$. **There is no proposition here that could have come out false.**

**What is NOT of that kind**, and is legitimate corroboration: the controls off the family, the maximal tori putting $82\%$–$89\%$ of $[\mathfrak m,\mathfrak m]$ outside $\mathfrak h$, and padded $W_{\mathbb{CP}^2}$'s $\lVert[\mathfrak m,\mathfrak r]\rVert=2.8$ with deficiency $(n-4)/3$, since those are measured where the conclusion fails. Of these I verified $(n-4)/3$ in closed form (§9) and did not verify $2.8$, $82\%$ or $89\%$, which are numerical and outside this loop.

**The searches are a third category.** "~$200$ critical points at $n=4$–$8$ and $92$ at $n=5$, none saturating off the family" is a search for a falsifier of a statement the block proves, so it is neither tautological nor evidence, it can only fail to refute. **The block presents it under "Searches found no saturating point outside the balanced products", which reads as support and is not.** The smallest off-family defect $0.866$ is the $n=4$ closed form $\sqrt3/2$ I reproduced in §4, so at least that endpoint of the search is exact.

## 11. What would break it

**The falsifier**: a critical unit $W\in\mathcal W_n$, $n\ge5$, with $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$ that is not the Weyl tensor of $S^{n/2}\times S^{n/2}$ in any orthogonal frame.

By §2–§7 such an object must have $n$ even and $E_{\max}$ a symmetric subalgebra of $\mathfrak{so}(n)$ of dimension exactly $n(n-2)/4$, in an $O(n)$-class other than the balanced split. **So the entire falsifier space is one question: at which even $n$ does a second $O(n)$-class of $\tfrac{n(n-2)}4$-dimensional symmetric subalgebras exist?**

**What I did to look for one.** At $n\ne8$ I checked that Aut-conjugacy coincides with $O(n)$-conjugacy, which collapses the question into Cartan's list, and read that list at source in [Etingof](../references/etingof-2024-real-forms-involutions/) §41.4 items 3, 5 and 6 as transcribed in the record's notes: the fixed algebras are $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(n/2)$, and §8's identity kills every one of them but the balanced split. At $n=8$ I enumerated the inner involutions by hand, $\mathrm{Ad}(g)$ with $g\in SO(8)$ and $g^2=\pm I$, giving the $-1$-eigenspace dimensions $2$ and $4$ and the complex-structure case, with fixed dimensions $16$, $12$ and $16$, and the outer ones by their fixed dimensions $21$ and $13$ together with their triality images, which have the same dimensions because $\dim\mathfrak g^\tau$ is Aut-invariant. **No second class at dimension $12$ appears.** I ran no search, no sweep and no computation of any kind. **The falsifier is absent for a reason the record can state but the L71 block does not.**

## Verdict

**GAP.**

**What is proven.** Everything from the saturation hypothesis through $\mathfrak r=0$, $\mathfrak h=[\mathfrak m,\mathfrak m]$, the symmetric pair, the exactly-two-eigenvalue conclusion, $\dim\mathfrak h=n(n-2)/4$, $\theta=\theta_0(n)$ and the odd-$n$ emptiness. **The round's central question resolves in the block's favour: the two-eigenvalue conclusion is derived, the ideal argument is what makes it a derivation, and no step upstream of it needs $\mathfrak r=0$.** The three prior audit defects (i), (ii) and (iv) are correctly diagnosed and correctly repaired.

**What is not established as written.** The uniqueness half. The $n=8$ determinant inference is invalid and is refuted by the block's own dimension-$16$ example; the step that makes Cartan's Aut-classification deliver the conclusion at every even $n\ne8$ is never stated in the block; the involution Cartan classifies is never constructed; and the final identification of $W$ with the balanced product's Weyl tensor is asserted here and proved nowhere on the record. **The weight argument at $n=8$ is complete and correct, so the Lie-theoretic conclusion is not in doubt. The geometric conclusion carries one hypothesis-debt: the last sentence of the lemma names an object the record never connects to the algebra it has just pinned.**
