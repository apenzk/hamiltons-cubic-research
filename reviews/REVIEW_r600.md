# Review r600, Lemma L64, the transfer mechanism

**Reviewer B, review number 600.** Target: [findings/fence-posts.md](../findings/fence-posts.md), line 227, `#### Lemma L64, the transfer mechanism`. Derived cold from [Levin–Chandrasekaran](../references/levin-chandrasekaran-dimension-free/notes.md) and the definitions, not from the block's reasoning. Analysis only; no computation was run and none was needed.

## Verdict: **GAP**

The implication is **true and its proof is sound**, I rebuilt both steps independently and neither breaks. But four things are owed, and the second is the one that matters:

1. **The pointer is false.** The argument is not post F32 and has never been in [findings/](../findings/); it lives in a script docstring. Seventh false provenance note.
2. **The hypothesis $n_0\ge k_B$ names a constant with no established value for the module in play**, and the record's only route to one is refuted two paragraphs above the block, in [post F32](../findings/fence-posts.md) itself. The Lemma is therefore **inapplicable at every $n_0$**, which is a different failure from being false.
3. **The load-bearing half of the argument is unconditional** and needs neither $\{B_n\}$ nor $k_B$. The hypothesis buys only uniqueness. The record advertises the conditional half of an unconditional fact.
4. **It transfers an element of the invariant ring, not an inequality**, and the record's own [post F31](../findings/fence-posts.md) holds the witness that the inequality fails.

**And a repair is reachable and I give it below**: replacing Proposition 2.9 with Levin–Chandrasekaran's Proposition 2.3, run over $\{O_n\}$ directly, proves the whole statement with an **explicit** base $n_0\ge 4d$ ($24$ at the degree-six certificate), with $k_B$, $\{B_n\}$ and the presentation degree removed from the statement entirely. That route is immune to [post F30](../findings/fence-posts.md)'s infinite-index objection, because Proposition 2.3's proof never uses induction from a subgroup.

---

## 1. The pointer

**The provenance note is false, and git says so in the record's own commit message.**

The note reads: *"the mathematics has always been in this record, but it carried no block. The statement is below; **the argument is post F32 in this file**."*

Post F32 does not contain the argument. What F32 contains is one assertion (*"The transfer mechanism is **proved**"*), followed by a link to [run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py), and then three paragraphs about the **hypothesis** ($k_B\ge24$, Theorem 2.11's failure, and the CORRECTED retraction). No step of the transfer proof appears in it.

The argument is the docstring of [run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py), added by [054e1e27](../scripts/runs/run_bn_transfer_theorem.py) on 2026-08-30. It has never appeared in [findings/](../findings/).

**The history, which is worse than the note.**

| commit | date | what it did |
| --- | --- | --- |
| `054e1e27` | 2026-08-30 | created the script; the proof exists here and nowhere else |
| `86621751` | 2026-08-31 | created the L64 block in [sym3-stability.md](../findings/sym3-stability.md), with the note *"the mathematics has always been in **this file** … the argument is elsewhere in this file, under its own descriptive heading"*, false; that file is 63 lines and holds no such heading |
| `93472f0d` | 2026-08-31 | moved the block to [fence-posts.md](../findings/fence-posts.md), its own message conceding *"nothing outside its own block there supports it"*, and **kept the clause**, editing "this file" to "this record" and repointing "elsewhere in this file" to "post 32" |

So the note has been wrong twice, at two different targets, and the second edit repaired the address without rechecking that the argument was at the new one. **"The mathematics has always been in this record" is true only of the script**, one day before the block, and the same sentence's companion clause was known false when it was rewritten.

**Where the argument actually lives:** [scripts/runs/run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py), lines 1–45 of the docstring. It should be moved into a findings block; a proof that exists only inside a Python comment is not on the record in the sense the programme uses.

**Related pointer defects in the same file.** The brief flags one empty link target. There are **seven**, at lines 249, 314, 343, 357, 361, 395 and 404 of [fence-posts.md](../findings/fence-posts.md), `[post F28](#)`, `[B2](#)`, `[post F34](#)`, `[post F39](#)`, `[post F38](#)`, `[post F10](#)`, `[Post F10](#)`. All resolve to the page top.

---

## 2. The argument, rebuilt cold

Write $U_n=\mathrm{Sym}^d(\mathcal W_n^*)$, $\iota\colon\mathcal W_{n_0}\hookrightarrow\mathcal W_n$ the zero-padding, and $P=\iota^*$ the restriction of a form to padded tensors. Two steps.

### Step 1, an $O(n)$-invariant lift exists, at every $n\ge n_0$, with no hypothesis at all

By the first fundamental theorem for $O(m)$ acting on $(\mathbb R^m)^{\otimes 4d}$, the space of invariants is **spanned** by the complete contractions $q_D$, one per perfect matching $D$ of the $4d$ slots. Spanning holds at every $m$; only linear **independence** of the matchings needs the stable range $m\ge 4d$. Since $\mathcal W_m$ is an $O(m)$-summand of $(\mathbb R^m)^{\otimes4}$ and $O(m)$ is compact, restriction is surjective on invariants, so

$$u_{n_0}=\sum_D c_D\,q_D^{(n_0)}.$$

Each matching $D$ is a combinatorial object independent of dimension, so it defines $q_D^{(n)}$ at every $n$, and $w_n:=\sum_D c_D\,q_D^{(n)}$ is $O(n)$-invariant.

**The padding collapse, which is the one genuinely load-bearing computation, and it is correct.** Evaluate $q_D^{(n)}$ at $\iota W$. Every one of the $4d$ slots sits on a Weyl factor, and the matching pairs slots to slots, so no $\delta$ has both ends free and no closed $\delta$-loop contributing a factor $n$ can occur. Each index of the sum therefore appears on at least one Weyl factor, and $(\iota W)_{ijkl}=0$ whenever any index exceeds $n_0$. So every term with an index $>n_0$ vanishes and the sum collapses to the $n_0$ range:

$$q_D^{(n)}(\iota W)=q_D^{(n_0)}(W)\quad\text{for all }W\in\mathcal W_{n_0},\qquad\text{hence}\qquad P\,w_n=u_{n_0}.$$

**This step is unconditional.** It uses no presentation degree, no $\{B_n\}$, no Levin–Chandrasekaran, and no stable range. It is the whole of the existence claim, and it holds at every $n\ge n_0\ge 1$.

### Step 2, the $\{B_n\}$ side supplies uniqueness, and only uniqueness

$w_n$ is $O(n)$-invariant, hence $B_n$-invariant, so it is *a* $B_n$-invariant lift. Proposition 2.9 says $P\colon U_{n+1}^{B_{n+1}}\to U_n^{B_n}$ is an isomorphism for $n\ge k_B$; composing across steps, at most one $B_n$-invariant restricts to $u_{n_0}$. Hence the unique $B_n$-invariant extension $u_n$ equals $w_n$, which is $O(n)$-invariant. $\square$

**The logic is valid.** I checked Proposition 2.9's own proof and Definition 2.7 in [the paper text](https://arxiv.org/abs/2307.04230) (lines 923–978); nothing is misquoted.

### What the upgrade actually consumes, the brief's question

**$B_n$-invariance does not upgrade to $O(n)$-invariance, and the block does not claim it does, but its phrasing invites the reading.** $B_n$ is a finite subgroup, $B_n$-invariance is strictly weaker, and the record's own [c4_equivalence.py](../scripts/reviewers/r231/c4_equivalence.py) notes that *"$B_n$-invariant non-$O(n)$-invariant extensions exist"*. What happens is a **pigeonhole**, not an upgrade:

- the $O(n)$ side supplies **existence** of a lift, from the FFT, which is invariant theory, **not** representation stability;
- the $B_n$ side supplies **uniqueness** of the lift, from Proposition 2.9, which is the only representation-stability input in the whole argument;
- the two lifts must then coincide, because one of them is unique and the other is one of them.

So the representation-stability input the upgrade consumes is exactly one fact: *the restriction map on $B_n$-invariants is injective from $n_0$ upward.* Nothing else.

**And uniqueness is doing real work**, which is why the hypothesis is not decorative. At $n_0<4d$ the matchings $q_D^{(n_0)}$ are linearly **dependent**, so distinct coefficient vectors $\{c_D\}$ represent the same $u_{n_0}$ and may give **different** $w_n$. Without a uniqueness statement, "the extension" is not a well-defined function of $u_{n_0}$ at all. The block's phrase *"forces the unique extension to **be** that lift"* is the right emphasis.

---

## 3. The hypotheses, one at a time

### "where presentation degrees exist", the hedge, and it conceals the whole failure

**Presentation degree is a property of a $V$-module, and for the module in play it has no established value.** Levin–Chandrasekaran Definition 2.7 defines it through Definition 2.6's induction, requiring an algebraically free $V$-module $F$ with a surjection $F\to U$ whose kernel is generated in degree $r$.

For $\{B_n\}$ the base sequence $\{\mathbb R^n\}$ is algebraically free and presented in degree $1$ (Example 2.8), and Example 2.12 gives $(\mathbb R^n)^{\otimes k}$ presented in degree $k$. So tensor powers are fine. **The module in play is not a tensor power.** $\mathcal W_n$ is the trace-free Bianchi-symmetric part of $(\mathbb R^n)^{\otimes4}$, obtained as the kernel of a contraction, and the only clause of Theorem 2.11 that produces a presentation degree for a kernel is (Images and kernels), which requires the sequence of **adjoints** $\{A_n^*\}$ to be a morphism.

**I checked that requirement independently and it fails.** Let $A_n\colon(\mathbb R^n)^{\otimes4}\to\mathrm{Sym}^2(\mathbb R^n)$ be the Ricci contraction $A_n(T)_{jl}=\sum_i T_{ijil}$.

- $\{A_n\}$ **is** a morphism: for $j,l\le n$, $A_{n+1}(\phi T)_{jl}=\sum_{i\le n+1}(\phi T)_{ijil}=\sum_{i\le n}T_{ijil}=A_n(T)_{jl}$, the $i=n+1$ term vanishing; and it is zero when $j$ or $l$ equals $n+1$.
- $\{A_n^*\}$ **is not**: $A_n^*(h)_{ijkl}=\delta_{ik}h_{jl}$, so $A_{n+1}^*(\psi h)_{n+1,j,n+1,l}=h_{jl}\ne0$ in general, while $\phi(A_n^*h)$ vanishes at any index $n+1$. Hence $A_{n+1}^*\psi\ne\phi A_n^*$.

**The obstruction is $\delta$ itself.** The identity matrix is the one tensor that is *not* padding-compatible: $\phi(\delta^{(n)})=\delta^{(n+1)}-e_{n+1}\otimes e_{n+1}$. Every appearance of a trace in the construction of $\mathcal W_n$ carries this, which is why the trace-free condition and not the Bianchi condition is what breaks the clause. This is precisely [post F32](../findings/fence-posts.md)'s *"$\mathrm{Ric}$ commuting with **truncation**, which it does not"*, and **F32 is right**.

**Consequence.** Two paragraphs above the L64 block, the same file states that Theorem 2.11 *"yields no $k_B$ here at all"*. The hedge "where presentation degrees exist" is therefore not a formality, it is the Lemma quietly conceding that **its own hypothesis has no known instance for $\mathcal W_n$**, and the concession is contradicted by the script that carries the proof, which asserts $k_B$ is *"finite: $B_n$ is one of Levin–Chandrasekaran's classical Weyl-group sequences, Theorem 2.11"*. **The script's justification for the hypothesis is refuted by the very post the block points at as its argument.**

*What is not settled either way:* the module category for $\{B_n\}$ is Noetherian in the FI-module sense, so a finite $k_B$ very likely **exists**; the record has no such argument, and even with it the degree would be non-effective. That distinction matters here, an existence proof for $k_B$ leaves the Lemma still unable to certify any particular $n_0$.

### "$n\ge n_0\ge k_B$", the bound is not explicit, so the Lemma certifies no transfer

$k_B$ has no value on the record. [Post F32](../findings/fence-posts.md)'s $k_B\ge24$ was a **lower** bound, and its own CORRECTED paragraph withdraws even that as a bound on the base. A lower bound on $k_B$ can never license an application; only an **upper** bound can, and none exists. **As stated, the Lemma certifies no transfer at any dimension.**

### A statement defect: $k_B$ is misdefined, and its dependence on $d$ is suppressed

[results.md](../results.md) line 610 reads *"with $k_B$ the presentation degree of the sequence $\{B_n\}$ of signed permutation groups"*. That is not a thing. Definition 2.7 attaches a presentation degree to a **$V$-module $U$** over a base sequence, never to a sequence of groups. What is meant is $k_B=k\big(\mathrm{Sym}^d(\mathcal W_n^*)\big)$ over the $\{\mathbb R^n\}/\{B_n\}$ base.

**And the degree is suppressed.** By Theorem 2.11's (Sym) clause, $\mathrm{Sym}^\ell W$ is presented in degree $(\ell-1)d_W+k_W$, so $k_B$ **grows with $d$**, at least linearly, since presentation degree dominates generation degree and $\mathrm{Sym}^d\mathcal W_n$ is generated in degree $4d$. The block writes a bare $k_B$ as though it were one absolute constant. It is a function of the certificate's degree, and the statement has a quantifier defect until it says so. Neither the block, [results.md](../results.md), nor [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) names the module or the degree.

### "the unique $B_n$-invariant extension", existence and uniqueness

Both are established **granted $n_0\ge k_B$**, and by the same Proposition 2.9, which gives an isomorphism and so supplies both at once. Under the hedge, neither is. **If the extension were non-unique the Lemma collapses entirely**, since step 2's pigeonhole is the only thing connecting $u_n$ to $w_n$, a second $B_n$-invariant lift need have no relation to $w_n$ and no reason to be $O(n)$-invariant.

### The first fundamental theorem, the right one, and its hypotheses hold

The block's second sentence invokes the FFT. It is the correct one: Weyl's FFT for the **orthogonal** group $O(m)$ on tensors, giving the complete contractions as a **spanning** set. The two things to get right are both got right:

- **spanning at every $m$**, with only independence requiring $m\ge$ the stable range, stated explicitly in the script and true;
- the group is $O$, not $SO$. This matters: for $SO(m)$ the FFT admits an extra $\varepsilon$-tensor generator, and an $\varepsilon$ diagram would **not** restrict correctly under padding, since $\varepsilon^{(n)}$ is not the padding of $\varepsilon^{(n_0)}$. The Lemma is stated for $O$ throughout, so the trap is avoided, but silently, and it is worth stating, because the record's block table at [L63](../results.md) works with $O(12)$ blocks obtained by **fusing** chiral $SO(12)$ pairs, so a certificate written in $SO$ terms would break this step.

---

## 4. The repair: $k_B$ can be removed from the statement entirely

**This is the most useful thing in this review, and it is a derivation, not a suggestion.** The presentation degree enters at exactly one point, step 2, to get injectivity of $P$ on invariants. Levin–Chandrasekaran supply that injectivity from the **generation** degree alone.

**Proposition 2.3** (paper lines 869–884): if $V=\{(V_n,\phi_n)\}$ is a consistent sequence of $\{G_n\}$-representations generated in degree $d$, then $\phi_n^*|_{V_{n+1}^{G_{n+1}}}\colon V_{n+1}^{G_{n+1}}\to V_n^{G_n}$ is **injective for all $n\ge d$**.

I read its proof. It uses only two things: $V_{n+1}=\mathbb R[G_{n+1}]\phi_n(V_n)$, which is generation, and the orthogonality $\langle v,g\phi_n(u)\rangle=\langle\phi_n^*v,u\rangle$ for $G_{n+1}$-invariant $v$. **It uses no induction from a subgroup and no finite-index hypothesis.** So [post F30](../findings/fence-posts.md)'s objection, which attaches to Definitions 2.6 and 2.7, **does not reach Proposition 2.3**, and Proposition 2.3 may be run over $\{O_n\}$ directly.

**Claim.** $\{U_n\}=\{\mathrm{Sym}^d(\mathcal W_n^*)\}$ is generated in degree $\le 4d$ over $\{O_n\}$.

*Proof.* Identify $\mathcal W_n^*\cong\mathcal W_n$ by the metric, so $U_n\cong\mathrm{Sym}^d(\mathcal W_n)$ with the padding embeddings. $\mathcal W_n$ is an irreducible $O(n)$-module and $\iota\mathcal W_4\ne0$, so $\mathbb R[O_n]\,\iota\mathcal W_4=\mathcal W_n$, generation degree $4$. Hence $\mathrm{Sym}^d(\mathcal W_n)$ is spanned by products $X_1\odot\cdots\odot X_d$ with each $X_i=g_i\,\iota(Y_i)$, $Y_i\in\mathcal W_4$. Each $X_i$ is supported on the $4$-dimensional subspace $g_i(\mathbb R^4)$, so the **union** of the supports spans a subspace of dimension $\le4d$, and a single $g\in O(n)$ carries it into the first $4d$ coordinates. Then $g^{-1}\cdot(X_1\odot\cdots\odot X_d)\in\iota\big(\mathrm{Sym}^d\mathcal W_{4d}\big)$. $\square$

**Corollary (L64, repaired).** *Let $n\ge n_0\ge 4d$ and let $u_{n_0}\in\mathrm{Sym}^d(\mathcal W_{n_0}^*)^{O(n_0)}$. Then $u_{n_0}$ has a **unique** $O(n)$-invariant extension, namely $w_n=\sum_D c_D\,q_D^{(n)}$.*

*Proof.* Existence is step 1, unconditionally. Uniqueness: by the Claim and Proposition 2.3 over $\{O_n\}$, $P\colon U_{m+1}^{O(m+1)}\to U_m^{O(m)}$ is injective for every $m\ge4d$; composing from $n$ down to $n_0$ gives an injection, so a lift of $u_{n_0}$ is unique. $\square$

**What this buys and what it does not.**

| | as stated | repaired |
| --- | --- | --- |
| hypothesis | $n_0\ge k_B$, value unknown, existence unproven | $n_0\ge 4d$, **explicit** |
| base at $d=6$ | none certifiable | $n_0\ge24$ |
| machinery | Prop 2.9 + Def 2.7 + $\{B_n\}$ + Thm 2.11 | Prop 2.3 alone |
| exposure to [F30](../findings/fence-posts.md) | none (runs over $B_n$) | none (Prop 2.3 needs no induction) |
| exposure to [F32](../findings/fence-posts.md)'s Thm 2.11 failure | **fatal** | none |
| certifies $n_0=12$? | no | **no**, $4d=24$ |

So the repair converts an inapplicable Lemma into an applicable one with an explicit base, and **confirms the base at $24$ rather than $12$**, agreeing with F32's original headline by an argument F32's own CORRECTED paragraph does not touch, since that paragraph is about the dimension of the space of **invariants**, while $4d$ is the generation degree of the **module**. Those are different quantities and the record treats them as competing. They are not.

**It does not rescue the route.** [Post F31](../findings/fence-posts.md) kills the sharp target at any $n_0$, so a repaired mechanism with base $24$ still transfers nothing the programme wants. The repair is worth making because it removes a false-looking hypothesis from a true theorem, not because it opens anything.

*This derivation should be independently checked before it is folded in, in particular the claim that $\mathcal W_4\neq0$ suffices for degree-$4$ generation over $\{O_n\}$, and that the metric identification is $O(n)$-equivariant and isometric, which it is.*

---

## 5. What it licenses, and what it does not

**It transfers an element of the invariant ring. It transfers no inequality, and no sharpness.**

Given $F$ established at $n_0$, the Lemma returns an $O(n)$-invariant $w_n\in\mathrm{Sym}^d(\mathcal W_n^*)$ with $w_n\circ\iota=F$. That is an **identity on the padded copy** $\iota(\mathcal W_{n_0})\subset\mathcal W_n$, a subvariety of dimension $\dim\mathcal W_{n_0}$ inside a space of dimension $\dim\mathcal W_n$, $10$ inside $1638$ at $n_0=4$, $1638$ inside $\dim\mathcal W_{24}$.

- **Identity: yes**, on the padded copy only.
- **Membership in the invariant ring: yes**, that is exactly the conclusion.
- **Inequality: no.** $F\ge0$ on $\mathcal W_{n_0}$ constrains $w_n$ nowhere off $\iota(\mathcal W_{n_0})$. Nothing in either step touches a sign.
- **Sharpness or equality cases: no**, for the same reason, and worse, the equality locus of $w_n$ can only grow, never be controlled.

**And the failure is not hypothetical; the record already holds the witness.** [Post F31](../findings/fence-posts.md) computes the lift of the sharp target $\Theta_{n_0}^2A-B+\mu(C-B)$ and finds it **negative at the balanced sphere product at level $n$, for every $\mu$**, because $\Theta_n^2$ is strictly increasing while the extension carries $\Theta_{n_0}^2$ unchanged, and $C-B$ vanishes exactly at that point. So the description set is empty. **The one inequality the programme wanted transferred is the one that demonstrably does not transfer**, and the script's own closing paragraph says so: *"the extension exists, is invariant, and certifies the WRONG constant above $n_0$."*

**So: the mechanism transfers the invariant and not the inequality, and that is the finding the brief's §4 asks for.** It is the correct reading of the Lemma, the Lemma is a statement about equivariance, and the record is right that *"equivariance was never the obstruction"*. The defect is not that the record carries a transfer it cannot perform; it is that the record **names** this a transfer mechanism while the thing it transfers is not what a transfer needs.

### Is this the same mechanism as padding?

**No, and the record does not conflate them.** They are adjoint to each other and license opposite directions.

| | padding | L64 |
| --- | --- | --- |
| moves | **points** $\iota\colon\mathcal W_{n_0}\to\mathcal W_n$ | **forms** $u_{n_0}\mapsto w_n$, with $\iota^*w_n=u_{n_0}$ |
| why it works | $\Lambda^2U=\mathfrak{so}(U)$ is a Lie subalgebra, so $W^\#$ stays inside; norm and $\theta$ preserved | $\iota^*q_D^{(n)}=q_D^{(n_0)}$, no free $\delta$-loop |
| licenses | $M(n)\ge M(n_0)$ (a **lower** bound at larger $n$ | an invariant form agreeing on the padded copy), **no** bound |

Both rest on the same embedding, which is why step 1's collapse and the $\theta$-preservation of padding are the same fact seen from the two sides of the pairing. Neither yields an **upper** bound at larger $n$, which is the only direction Conjecture A needs. [conventions.md](../findings/conventions.md) keeps padding's clause clean (*"Padding commutes with $Q$, and preserves both the norm and $\theta$"*), and no block I found substitutes one for the other.

---

## 6. Uses that break, and what does not

**On the current record, nothing derives from L64 mathematically.** I grepped every `.md`, `.py` and `.tex`. The complete citation set is:

| site | what it says | status |
| --- | --- | --- |
| [findings/INDEX-results.md](../findings/INDEX-results.md) row 64 | *"Gate 2: no verdict on the record"* | accurate |
| [findings/sym3-stability.md](../findings/sym3-stability.md) line 50 | *"proved in fence-posts.md under post F32"* | **false pointer**, same defect as §1 |
| [results.md](../results.md) line 210 | statement + FFT sketch, no caveat | drops the $k_B$ caveat that line 610 carries |
| [results.md](../results.md) line 610 | statement, plus *"whether $k_B$ is small enough to reach $n=12$ is a separate, open question"* | **the most honest statement of L64 on the record**, but misdefines $k_B$ as a property of $\{B_n\}$ |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) L940 | Lemma 64, immediately followed by $k_B\ge24$ and the F30 closure | accurate |
| [report/sections/09-status.tex](../report/sections/09-status.tex) L18 | *"**Proven**. Equivariance was never the obstruction. **But** $k_B\ge24$…"* | accurate |
| [report/sections/diagram.tex](../report/sections/diagram.tex) L87, [diagram-closed.tex](../report/sections/diagram-closed.tex) L99 | *"**transfer proved** (L64)"* in a **blue "settled"** box headed *"the machinery"* | **over-claims**; the caption mitigates but the box does not |

**So the brief's premise that this is "load-bearing well beyond its own block" is not borne out.** No result lifts a small-$n$ computation using L64; the degree-six certificate it would serve **does not exist** ([07-gradedness-split.tex](../report/sections/07-gradedness-split.tex): *"none is built"*). The blast radius of the defect is the two diagram boxes and two pointers.

That is the good news and it is also the shape of the risk: **L64 is a mechanism waiting for a consumer**, and the consumer that arrives will want the inequality, which the Lemma does not carry.

---

## 7. What is owed

1. **Move the proof into [findings/](../findings/)** and correct the provenance note in [fence-posts.md](../findings/fence-posts.md) line 229 and the pointer in [sym3-stability.md](../findings/sym3-stability.md) line 50. Neither may say the argument is post F32. *Reachable now; it is a transcription.*
2. **State the hypothesis honestly.** Either adopt the §4 repair, which gives the explicit base $n_0\ge4d$ and deletes $k_B$; or keep $k_B$ and record that the record's only route to it is refuted by the post the block sits under, so the Lemma is inapplicable at every dimension. *Reachable now; the repair is derived above and needs one independent check.*
3. **Fix the $k_B$ misdefinition** in [results.md](../results.md) line 610 (presentation degree belongs to a module, not to a group sequence) and name the module and the degree $d$ it depends on. *Reachable now.*
4. **Add the direction clause to the statement**, in both [findings/](../findings/) and [results.md](../results.md): the Lemma transfers an invariant form and an identity on the padded copy, and transfers **neither** an inequality nor sharpness, with [post F31](../findings/fence-posts.md) cited as the witness. *Reachable now.*
5. **Repaint the diagram box.** *"Transfer proved"* in the settled colour, in a box headed *"the machinery"*, states as machinery in hand a Lemma whose hypothesis has no established instance. *Reachable now.*
6. **Fix the seven empty link targets** in [fence-posts.md](../findings/fence-posts.md) (lines 249, 314, 343, 357, 361, 395, 404). *Reachable now.*

**Nothing here requires computation**, and none was run.

## Summary in one paragraph

The theorem is true and its proof is correct, I rebuilt both steps cold and neither breaks, and the padding collapse in particular is exactly right. What is wrong is everything around it: the argument is not where the block says it is and never has been in [findings/](../findings/); the hypothesis names a constant whose only route to a value is refuted two paragraphs above the block; the load-bearing half of the proof is unconditional and does not need that constant at all; and the thing transferred is an invariant form rather than the inequality every use would want, with the record's own [post F31](../findings/fence-posts.md) supplying the witness that the inequality fails. **The statement is true, and weaker than the name "transfer mechanism" claims.** A repair that removes the bad hypothesis is derived in §4 and gives an explicit base of $24$.
