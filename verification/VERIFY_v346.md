# Verifier v346, Lemma L113: the moment-analysis claim, its "pinned class", the "only sources" sentence, the F42 lineage, and the Lean files L113.lean and L113Statement.lean

Cold brief ([BRIEF_L113.md](BRIEF_L113.md)). No numerical work, no scripts written, no builds run. Every value below is exact and every witness is in closed form. The cited lines of [findings/bounds.md](../findings/bounds.md) (508, 526, 258-264, 562, 566), [findings/conventions.md](../findings/conventions.md) (50), [findings/fence-posts.md](../findings/fence-posts.md) (417, 419, 423) and [findings/bounds-relaxations.md](../findings/bounds-relaxations.md) (47, 51, 53) were printed at exactly those numbers and match the brief verbatim. Proposition 1.7 was read at source in [references/petersen-wink-2019-bochner-technique/notes.md](../references/petersen-wink-2019-bochner-technique/notes.md). Log: [agent_logs/verify-L113-v346.log](../agent_logs/verify-L113-v346.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's bolded sentence "Moment analysis of the $g$-distribution cannot leave the pinned class" is a proposition | GAP |
| 1' | Its sharpest defined reading: every inequality in $(\lambda,\theta)$ valid for all $g\ge0$ supported on the spectrum with $m_0=4(n-1)$, $m_1=-4\theta$ is implied by feasibility of that system | CONFIRMED AS ALGEBRA |
| 2 | "Positivity of $g$ and the support of its measure are consequences of the spectrum alone" | CONFIRMED (with a wording note) |
| 3 | Passage A carries a proof, and the `Lemma` label is supported | GAP |
| 4 | "Pinned class" is the object Passage D calls "pinned data" | GAP |
| 5 | L113 is "a theorem-shaped extension of post F42" | REFUTED AS STATED |
| 6 | "The only sources on the table are the Jacobi identity and first Bianchi acting on the $c$-tensor itself, before squaring to $T$" | REFUTED AS STATED |
| 7 | $g\ge0$, $\sum_kg_k=4(n-1)$, $\sum_k\lambda_kg_k=-4\theta$ is feasible exactly when $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ | CONFIRMED under $\theta\ge0$ and $\lambda_{\min}\le0\le\lambda_{\max}$, REFUTED AS STATED without $\theta\ge0$ |
| 8a | [L113.lean](../lean/HamiltonsCubic/Results/L113.lean) formalises L113 | REFUTED AS STATED |
| 8b | [L113Statement.lean](../lean/HamiltonsCubic/Results/L113Statement.lean) formalises reading 1' | CONFIRMED AS ALGEBRA (as read, compilation not checked) |
| 9 | Boundary cases ($\lVert W\rVert\ne1$, repeated and simple $\lambda_{\min}$, $\ker W\ne0$, $n=4$, odd $n$, $n=6+2\sqrt7$) | CONFIRMED for reading 1', with the scaling correction recorded |

**What the round should do:** restate L113 as the two-moment feasibility proposition that `feasible_iff_theta` already proves (a corollary of L107, with $\theta\ge0$ stated), strike the "only sources" and "single open door" sentences, which L109 refutes on the record, retire L113.lean as unrelated to the claim, and remove the F42 lineage, since F42 is withdrawn.

## 0. Conventions, fixed once

- $W\in\mathcal W_n$ is a symmetric operator on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=n(n-1)/2$, $\{v_k\}$ an orthonormal eigenbasis with eigenvalues $\lambda_k$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$, $T_{abc}=c_{abc}^2$, totally symmetric and $\ge0$.
- $g_k=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, $m_j=\sum_k\lambda_k^jg_k$, $G_2=m_2$.
- $\lambda_{\min}$, $\lambda_{\max}$ are the extreme eigenvalues and $\Delta=\lambda_{\max}-\lambda_{\min}$.
- An algebraic Weyl tensor is trace-free on $\Lambda^2$, so $\operatorname{tr}W=\sum_k\lambda_k=0$, which gives $\lambda_{\min}\le0\le\lambda_{\max}$, with both strict when $W\ne0$. $\mathcal W_n=0$ for $n\le3$, so the smallest admissible dimension is $n=4$, $N=6$.
- $\mathcal G(\lambda,c,s)=\{g\in\mathbb R^N:\ g\ge0,\ \sum_kg_k=c,\ \sum_k\lambda_kg_k=s\}$. At a unit critical point $c=4(n-1)$ and $s=-4\theta$.

## Hypothesis inventory

**Hypotheses the statement carries.** Passage A states none explicitly. Implicit in it: $W\in\mathcal W_n$, an orthonormal eigenbasis, $T=c^2$, and, through "pinned" and $\theta$, a critical point on the unit sphere.

**Imported results and their hypotheses, each checked against its object.**

| Import | Its hypotheses | Checked against | Used by Passage A's argument |
|---|---|---|---|
| $g_k\ge0$ | $g_k$ is a squared Frobenius norm (Proposition 1.7 identifies it with the $T$-sum) | holds at every $W$, no relation needed | yes |
| support of $g$ in the spectrum | $g$ is indexed by eigenvectors | holds by construction | yes |
| $m_0=4(n-1)\lVert W\rVert^2$ | (A), (B), total symmetry of $T$ | derived in section 2 | implicitly, through "pinned" |
| $m_1=-4P(W)$ | (B), the cubic identity $\langle W,W^\#\rangle=\tfrac12\sum\lambda_a\lambda_b\lambda_cT_{abc}$ | derived in section 2 | implicitly, through "pinned" |
| (A) | Killing normalisation of $\mathfrak{so}(n)$ in an orthonormal basis | holds for every $W$ | through $m_0$ |
| (B) | $W$ algebraic Weyl | holds for every $W\in\mathcal W_n$ | through $m_0$, $m_1$ |
| (C) | criticality | holds only at critical points | **unused** |
| criticality | $Q(W)=\theta W$ | used only to name $P(W)=\theta$ | **unused beyond naming** |
| L107 (given) | every $W\in\mathcal W_n$ per Passage C | its content is reading 1' | not cited, but it is what the claim reduces to |
| L109 (given) | $T\ge0$, row marginal (A) via L153, Proposition 1.7 | section 6: follows in one line | **not used, and it contradicts a sentence of the block** |
| post F42 | a census measurement | Passage D: conclusion withdrawn | cited as the result L113 extends |

**Findings from the inventory.** Criticality and (C) are unused. That is harmless because they are not stated as hypotheses, and it means reading 1' holds at every $W$ with $P(W)$ in place of $\theta$ and $4(n-1)\lVert W\rVert^2$ in place of $4(n-1)$. No step uses a hypothesis nobody stated, because no step is written (section 3).

**Quantifier order and scope.** The bolded sentence has no quantifiers. "Any pair of moment inequalities" quantifies over an undefined family ("built from them"). The implicit order is: for every spectrum and $\theta$, for every finite family of inequalities valid on the cone $\{g\ge0\text{ on the spectrum}\}$, the $m_2$-eliminated conclusion is implied by $\mathcal G\ne\emptyset$. Read in that order it is true (section 1). "Pair" is the wrong arity: once $m_2,m_3,\dots$ are all free, eliminating $k$ free moments needs families of size up to $k+1$ and beyond. The feasibility argument covers every finite family at once, so the correct quantifier is "every family", and "pair" is a needless restriction of a statement that is true in general.

## 1. The bolded sentence as a proposition

**Located.** Line 526: "Positivity of $g$ and the support of its measure are consequences of the spectrum alone, so *any* pair of moment inequalities built from them, however the free moment enters, can only return a pinned conclusion once the free moment is eliminated. **Moment analysis of the $g$-distribution cannot leave the pinned class.**"

**Undefined terms.** None of "moment inequalities built from them", "pinned conclusion" or "pinned class" is defined in Passages A to F. There are three candidate readings.

- **Reading P (pinned data).** A conclusion is pinned when it is a condition on $(\lambda,\theta)$ alone. After the free moment is eliminated, only $(\lambda,\theta,n)$ remain, so every conclusion is pinned by construction. The sentence is then true and vacuous. Under this reading the conjecture itself, a bound on $\theta$ in terms of $n$, is also pinned, so the reading cannot support the moral that staying pinned is a defect.
- **Reading 1' (two-moment feasibility).** A conclusion is pinned when it is implied by $\mathcal G(\lambda,4(n-1),-4\theta)\ne\emptyset$. Claim: every inequality $\Phi(\lambda,\theta)$ derived from a finite family of inequalities $F_i(\lambda,m_0,m_1,m_2,\dots)\ge0$, each valid for every $g\ge0$ supported on the spectrum, is implied by $\mathcal G\ne\emptyset$. Proof as algebra: if $\mathcal G\ne\emptyset$, pick $g\in\mathcal G$ and set $m_j=\sum\lambda_k^jg_k$. Every $F_i$ holds at this $g$, so the derived $\Phi$ holds. By section 7, $\mathcal G\ne\emptyset$ is exactly L107 (with $\theta\ge0$). This reading is true, it is the one L113Statement.lean formalises, and its content is a restatement of L107.
- **Reading L (the full linear pinned system).** A conclusion is pinned when it is implied by feasibility of $\{T\ge0\text{ totally symmetric},\ \text{(A), (B), (C) at every }k\}$. Moment analysis over that polytope stays inside it trivially, since every $m_j$ is linear in $T$ (moment_add, moment_smul). This reading is also true by construction, but it is strictly stronger than reading 1' (section 6), so readings 1' and L are different objects.

**Failure exhibited.** The sentence does not pick among P, 1' and L, and the three differ in content: P is vacuous, 1' is L107, and L contains the L109 caps, which 1' omits. No single proposition is asserted.

**Opposite argued.** The most charitable reading is 1', since the sentence names only "positivity" and "support", and under it the claim is proven. That rescues the mathematics, not the filing: the block states no reading, and its next sentence (section 6) needs reading L to make sense, where the claim of the previous sentence has a different content. **The finding stands as GAP**: the lemma must be restated as a proposition before it can be PROVEN, and reading 1' is the statement to adopt.

## 2. "Positivity of $g$ and the support of its measure are consequences of the spectrum alone"

Which ingredients give what:

- $g_k\ge0$: none of (A), (B), (C). It is a squared norm, and equally $T\ge0$ with $(\lambda_\alpha-\lambda_\beta)^2\ge0$. Holds at every $W$.
- Support in $\{\lambda_k\}$: none. The measure $\sum_kg_k\delta_{\lambda_k}$ is supported on the spectrum by definition.
- $m_0$: $\sum_{k\alpha\beta}(\lambda_\alpha^2-2\lambda_\alpha\lambda_\beta+\lambda_\beta^2)T_{k\alpha\beta}$. By total symmetry the two square terms are equal, and each is $\sum_\alpha\lambda_\alpha^2\sum_{k\beta}T_{\alpha k\beta}=2(n-2)\lVert W\rVert^2$ by (A). The cross term is $\sum_\alpha\lambda_\alpha\sum_{k\beta}\lambda_\beta T_{\alpha k\beta}=-2\lVert W\rVert^2$ by (B). So $m_0=4(n-2)\lVert W\rVert^2+4\lVert W\rVert^2=4(n-1)\lVert W\rVert^2$. Uses (A), (B), symmetry. Followed and confirmed.
- $m_1$: $2\sum\lambda_k\lambda_\alpha^2T_{k\alpha\beta}=2\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)=-4\operatorname{tr}W^3$ by (B), and $-2\sum\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}=-4\langle W,W^\#\rangle$ by the cubic identity. So $m_1=-4P(W)$. Uses (B) and the cubic identity. Confirmed as algebra under the record's normalisation of $\#$.
- (C) and criticality enter none of the four.

**Wording note, candidate withdrawn.** Positivity is a consequence of the definition, not of the spectrum, and $m_1$ needs $P(W)$, which is not a spectral function at a general $W$. The sentence claims only positivity and support, and both hold with no data at all, so "the spectrum alone" is loose but not false. There is no failing object to exhibit, so the candidate is withdrawn.

## 3. Does Passage A carry a proof, and is the `Lemma` label supported

**Located.** Line 526 opens "**The moral**", and the whole argument is the single connective "so" in the sentence quoted in section 1.

**Failure exhibited.** No derivation is on file. What would have to be proved, under reading 1', is: for every spectrum $\lambda$ and every $\theta$, $\{(\lambda,\theta):\ \Phi\text{ derivable}\}\supseteq\{\mathcal G\ne\emptyset\}$ for every $\Phi$ obtained from cone-valid inequalities. The two-line argument in section 1 is that proof. It is not in the block. The block describes itself as a moral, and the brief records that L113 has no entry in [results.md](../results.md).

**Opposite argued.** The feasibility half of the proof is on file in Lean (`feasible_iff`, section 8), and the elimination half is immediate. So the missing argument is short and is not in doubt. It is still absent from the written record, and the Lean file proves the interval statement, not the elimination statement. GAP.

## 4. "Pinned class" against Passage D's "pinned data"

**Located.** Line 508 heading: "cannot leave the pinned class". Line 419: "pin a contraction $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ exactly when at least two of $p,q,r$ are $\le1$. Call that the *pinned data*".

**Failure exhibited.** Passage D defines a set of scalars (contractions of $T$). A statement about inequalities needs a set of conclusions, that is, a region in $(\lambda,\theta)$-space. The two are different types. The regions they could induce also differ: reading P is all of $(\lambda,\theta)$-space, reading 1' is $\{\theta\le(n-1)\lvert\lambda_{\min}\rvert\}$, and reading L is the LP projection, which is contained strictly in 1' whenever $\lambda_{\min}$ is simple (section 6). Passage D's withdrawal ("the pinned class is far stronger than this post claimed") uses "pinned class" in sense L. Passage A uses it for $g$-moment analysis, which needs sense 1'.

**Opposite argued.** Both usages might be taken to mean "whatever the pinned data determine", which is sense L. But then Passage A's premise (positivity and support only) does not reach sense L, because $g$-positivity and support lose the L109 caps. The two terms are not the same object, and a statement about inequalities needs sense 1'. GAP.

## 5. "A theorem-shaped extension of post F42"

**Located.** Line 526: "**The moral, and it is a theorem-shaped extension of [post F42](fence-posts.md).**" Line 423: "**THIS POST'S CONCLUSION IS WITHDRAWN IN BOTH DIRECTIONS.** ... *So the pinned class is far stronger than this post claimed, and "sharpening inside it cannot work" is unsupported.*"

**Failure exhibited.** F42's conclusion ("no route through the pinned data can close the conjecture", line 417) is withdrawn. An extension of a withdrawn conclusion inherits no content from it. L113's moral, "That is now the single open door", needs F42's withdrawn half: it treats "cannot leave the pinned class" as fatal to a route, and that is exactly the "sharpening inside it cannot work" sentence that line 423 calls unsupported.

**Opposite argued.** Reading 1' is logically independent of F42 and borrows only the word "pinned". Its truth survives the withdrawal. The lineage claim and the "single open door" moral do not survive it. REFUTED AS STATED, and the fix is to delete the lineage and the moral, not the reading 1' statement.

## 6. "The only sources on the table are the Jacobi identity and first Bianchi acting on the $c$-tensor itself, before squaring to $T$"

**Located.** Line 526: "The free data $G_2$ helps only if realizability constrains it through something positivity and support do not see, and the only sources on the table are the **Jacobi identity and first Bianchi acting on the $c$-tensor itself**, before squaring to $T$."

**L109 read at its step.** Passage E: $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}\le\Delta^2\sum_{\alpha\beta}T_{\gamma\alpha\beta}=2(n-2)\Delta^2$, using $T\ge0$, $(\lambda_\alpha-\lambda_\beta)^2\le\Delta^2$ and (A). This follows. It acts after squaring to $T$ and uses no Jacobi and no Bianchi.

**Failure exhibited, in closed form.** Take any unit $W\in\mathcal W_n$, $n\ge4$, whose $\lambda_{\min}$ is simple, at index $k_0$. Put $\theta_*=(n-1)\lvert\lambda_{\min}\rvert$ and $g^*=4(n-1)e_{k_0}$.

- $g^*\ge0$, it is supported on the spectrum, $\sum_kg^*_k=4(n-1)$ and $\sum_k\lambda_kg^*_k=4(n-1)\lambda_{\min}=-4\theta_*$. So $g^*$ satisfies everything positivity and support see, at the L107 extreme.
- Since $\lambda_{\max}\ge0\ge\lambda_{\min}$ are distinct eigenvalues, $\Delta^2\le2(\lambda_{\max}^2+\lambda_{\min}^2)\le2\sum_k\lambda_k^2=2$. So the L109 cap is $U=2(n-2)\Delta^2\le4(n-2)<4(n-1)=g^*_{k_0}$. Hence $g^*$ violates L109.
- The cap changes the conclusion. Under $0\le g_k\le U$, the $\lambda_{\min}$ coordinate carries at most $U$, and the remaining mass $4(n-1)-U>0$ sits on eigenvalues $\ge\lambda_2>\lambda_{\min}$, where $\lambda_2$ is the second smallest eigenvalue. So $\sum_k\lambda_kg_k\ge U\lambda_{\min}+(4(n-1)-U)\lambda_2>4(n-1)\lambda_{\min}$, which gives $\theta<(n-1)\lvert\lambda_{\min}\rvert$ strictly.

So a relation after squaring, (A) with $T\ge0$, constrains the $g$-distribution beyond positivity and support, and it moves the conclusion strictly inside the L107 region. The sentence's list of sources omits it.

**Opposite argued.** The author may mean "sources that leave reading L", and the L109 cap stays inside L. Under that reading the sentence says that every constraint on $T$ beyond (A), (B), (C) and $T\ge0$ comes from Jacobi or Bianchi on $c$. That claim has no argument on file. What would have to be proved: every relation that realizability as $\mathfrak{so}(n)$ structure constants in a $W$-eigenbasis imposes on $T$ is a consequence of (A) to (C), $T\ge0$, the Jacobi identity and first Bianchi. A candidate further source is the off-diagonal Killing relation $\sum_{bc}c_{abc}c_{a'bc}=0$ for $a\ne a'$, which acts on $c$ before squaring and is neither identity. I record it as a question, not a finding, because I cannot exhibit that it constrains $G_2$ without building an argument of my own. Under the literal reading, which contrasts with "positivity and support", the sentence is refuted by the record's own L109. Under the charitable reading it is an unproved completeness claim. REFUTED AS STATED.

## 7. The complete consequence: feasibility of $\mathcal G(\lambda,4(n-1),-4\theta)$

**Algebra followed.** For $c>0$, $\mathcal G(\lambda,c,s)\ne\emptyset$ iff $c\lambda_{\min}\le s\le c\lambda_{\max}$. Necessity: $\lambda_{\min}\sum g\le\sum\lambda g\le\lambda_{\max}\sum g$ for $g\ge0$. Sufficiency: the two-atom witness $t=(s-c\lambda_{\min})/\Delta\in[0,c]$ on $\lambda_{\max}$ and $c-t$ on $\lambda_{\min}$, or a single atom when $\Delta=0$. With $c=4(n-1)$ and $s=-4\theta$: feasible iff $-(n-1)\lambda_{\max}\le\theta\le(n-1)\lvert\lambda_{\min}\rvert$, using $\lambda_{\min}\le0$ for the absolute value.

**Sign conditions used.**

- $n\ge2$ gives $c>0$.
- $\lambda_{\min}\le0$ gives $-\lambda_{\min}=\lvert\lambda_{\min}\rvert$.
- $\theta\ge0$ together with $\lambda_{\max}\ge0$ makes the lower inequality automatic.

**Failure exhibited without $\theta\ge0$.** Take any spectrum with $\lambda_{\max}>0$ and $\theta=-(n-1)\lambda_{\max}-1$. Then $\theta<0\le(n-1)\lvert\lambda_{\min}\rvert$, so the one-sided condition holds, but $s=-4\theta=4(n-1)\lambda_{\max}+4>c\lambda_{\max}$, so the system is infeasible.

**Opposite argued.** Negative $\theta$ does occur at critical points: $Q(-W)=Q(W)=\theta W=(-\theta)(-W)$, so $-W$ is critical with $-\theta$ and a negated spectrum. For $-W$ the lower inequality reads $-\theta\ge-(n-1)\lvert\lambda_{\min}(W)\rvert$, which is L107 at $W$. So at real critical points the lower side is never binding beyond L107, and the equivalence is correct as a statement about critical points once both signs of $W$ are admitted. As a statement about the linear system in $(\lambda,\theta)$ it needs $\theta\ge0$, which `feasible_iff_theta` carries. Passage C's L107 is consistent with this: it is the upper side, and it holds at every $W$ with $P(W)$ and $\lVert W\rVert^2$.

## 8. The Lean files against the claim

**L113.lean.** Each declaration read as stated:

| Declaration | What it states | Relation to L113 |
|---|---|---|
| `moment_of_combination` | for $m:\mathbb R\to\mathbb R$ with the two-term linearity law, $m(\alpha T_1+(1-\alpha)T_2)=\alpha m(T_1)+(1-\alpha)m(T_2)$ | an instance of its own hypothesis. $T_i$ are reals, not tensors |
| `constraints_convex` | two reals $\ge0$ and both equal to $c$ have a convex combination $\ge0$ and equal to $c$ | scalar triviality |
| `reachable_convex` | linearity applied to a convex combination | `hα`, `hα'` are unused by the proof |
| `unused_hypothesis` | $(A\to B\to C_0)\to(A\to B\to C\to C_0)$ | a propositional tautology, unrelated |
| `closure_with_content` | $\exists S\subseteq\mathbb N,\ 0\in S\wedge1\notin S$ | unrelated |

No declaration mentions a spectrum, $g$, a moment of $g$, a pinned class or an elimination. **Located** in Passage F, **exhibited** by the table, **opposite argued**: these may be scaffolding for the convexity idea, but none types it. REFUTED AS STATED as a formalisation of L113.

**"A convex image cannot separate a non-convex class from its complement".** This sentence appears in no declaration quoted in Passage F (docstrings were removed), so it is not typed. As mathematics it needs a definition of "separate". Under its natural reading, the image of a convex set under a linear map is convex, so a test that factors through such an image cannot distinguish the realizable $T$ from other points of their convex hull. That is true and is the principle behind reading L. It does not imply reading 1', and it is not proved anywhere in the files.

**L113Statement.lean.**

- `Feasible lam c s`: $\exists g\ge0$ with $\sum g=c$ and $\sum\lambda g=s$. This is $\mathcal G\ne\emptyset$.
- `feasible_iff`: for nonempty index set and $c>0$, `Feasible` iff $c\lambda_{\min}\le s\le c\lambda_{\max}$. The binders, direction and types match section 7. The proof's witnesses are those of section 7.
- `feasible_iff_theta`: for $2\le n$, $0\le\theta$, $\lambda_{\min}\le0\le\lambda_{\max}$, `Feasible lam (4(n-1)) (-4θ)` iff $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. All four hypotheses are used: `hn` for $c>0$, `hmin` for the absolute value, and `hθ` with `hmax` for the lower side in the reverse direction. $N$ and $n$ are unlinked ($N=n(n-1)/2$ is not imposed), which is harmless because the statement holds for every $N$. The normalisation $\lVert W\rVert=1$ is built into the constant $4(n-1)$.
- `moment`, `moment_add`, `moment_smul`: $\sum_k\lambda_k^j\sum_{ab}(\lambda_a-\lambda_b)^2T_{kab}=m_j$ is linear in $T$. True, and it supports reading L's triviality, not an elimination theorem.
- `example`: a two-point feasibility instance.

The file formalises section 7, the content of reading 1', and not the elimination step (section 3). Whether it compiles was not checked, because building is outside this loop's no-computation rule. CONFIRMED AS ALGEBRA as read.

## 9. Boundaries

- **$\lVert W\rVert\ne1$.** $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$, so reading 1' becomes $P(W)\le(n-1)\lVert W\rVert^2\lvert\lambda_{\min}\rvert$, which is homogeneous of degree 3 on both sides. `feasible_iff` covers every $c>0$, and `feasible_iff_theta` covers only $c=4(n-1)$. At $W=0$, $c=0$ falls outside `feasible_iff`, and the statement is trivial there.
- **Repeated eigenvalues.** Feasibility depends only on $\lambda_{\min},\lambda_{\max}$, so multiplicities are irrelevant to reading 1'. The degenerate branch $\lambda_{\min}=\lambda_{\max}$ of `feasible_iff` is unreachable for unit trace-free $W$ and harmless.
- **Simple $\lambda_{\min}$.** This is where readings 1' and L separate (section 6). The L107 extreme requires all the mass on one coordinate, and the L109 cap forbids that.
- **$\ker W\ne0$ (padded objects).** Zero eigenvalues lie in $[\lambda_{\min},\lambda_{\max}]$ and do not change the feasibility interval. For $W\oplus0$ padded from $\mathbb R^m$ to $\mathbb R^n$, $\Delta$ is unchanged and $\Delta^2\le2$ still holds, so section 6's witness works at every $n\ge4$.
- **$n=4$ and odd $n$.** No step uses a parity or a dimension threshold beyond $n\ge2$ (Lean) and $n\ge4$ (non-trivial $\mathcal W_n$). Section 6 needs $4(n-2)<4(n-1)$, which holds for all $n$.
- **$n=6+2\sqrt7$.** No quantity in L113 or in readings 1', L or P changes behaviour at the crossover. Nothing happens there.

## Withdrawn candidates

- **"Spectrum alone" is false because $m_1$ needs $\theta$** (section 2). Withdrawn: the sentence asserts only positivity and support, and those need nothing.
- **Criticality is a used-but-unstated hypothesis.** Withdrawn: no step uses it. It is unused, and reading 1' holds at every $W$.
- **`positivity` cannot close `0 ≤ c - t` in `feasible_iff`, so the file does not compile.** Withdrawn: I cannot exhibit the failure without building, and tactic behaviour with local hypotheses in scope is not something to assert cold. The mathematics of the step is correct (`htc`).
- **The off-diagonal Killing relation is a third source beyond Jacobi and Bianchi** (section 6). Withdrawn as a finding: I have no closed-form object showing that it constrains $G_2$. It is kept only as a question for the "what would have to be proved" clause.

## The falsifying object

Reading 1' is falsified by a pair $(\lambda,\theta)$ with $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, $\theta\ge0$, together with a cone-valid inequality family whose eliminated conclusion fails at $(\lambda,\theta)$. None exists: the explicit $g$ of section 7 satisfies every cone-valid inequality. Reading L's "only sources" completeness is falsified by a constraint on $T$ that follows from realizability and is not a consequence of (A) to (C), $T\ge0$, Jacobi and Bianchi. The literal sentence is already falsified by the point mass $g^*=4(n-1)e_{k_0}$ at a simple $\lambda_{\min}$, which positivity and support admit and L109 excludes. To look for an object against reading 1', I tested the diagonal, padded and simple-$\lambda_{\min}$ cases and the $\theta<0$ side against the interval proof, and none fails. Sphere products and $\mathbb{CP}^m$ enter only through their spectra, which the interval statement treats uniformly.

## Overall verdict

**GAP.** Lemma L113 as filed asserts no defined proposition and carries no proof. Its best reading (1') is a two-line corollary of the feasibility interval proved in `feasible_iff_theta`, so the mathematics is recoverable. The block's load-bearing moral is not recoverable: its "only sources on the table" sentence is contradicted by L109, a constraint from (A) with $T\ge0$ acting after squaring, and its F42 lineage points at a withdrawn conclusion. L113.lean formalises nothing in the claim.
