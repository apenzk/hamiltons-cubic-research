# Review r599, Lemma L64, the transfer mechanism

**Verdict: GAP.** The conditional is correct (I re-derived both steps cold and could not break either) but it is a conditional with no known satisfiable instance, and the record does not say so where the block is read. Three separable defects: the provenance pointer is **false**; the hypothesis $n_0\ge k_B$ is **unsatisfiable at $n_0=12$**, the only dimension the programme wants, and no $n_0$ is known where it holds; and the Lemma transfers an **element of the invariant ring**, never an inequality, the record's own [post F31](../findings/fence-posts.md#L205) is the witness that the inequality fails.

Reviewer A of a pair on identical briefs. Result under audit: [findings/fence-posts.md#L227](../findings/fence-posts.md#L227). Conventions read first: [findings/conventions.md](../findings/conventions.md). **Analysis only**, no computation was run, and the two places where a run would decide something are named as such in §6.

---

## 1. The pointer is false, and the argument is in a script docstring

The block says *"the argument is post F32 in this file"*. [Post F32](../findings/fence-posts.md#L215) does not contain the argument. Its opening sentence **asserts** the mechanism ("The transfer mechanism is **proved**") and cites [run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py). Everything after that sentence is about $k_B\ge24$ and its correction. No step of the transfer proof appears anywhere in F32.

The argument actually lives in the **docstring** of [run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py), as a two-step theorem with proof, entered at commit `054e1e27` and audited by [r232](REVIEW_r232.md) at `bc2ef76d` / `3825267b`. A one-sentence compression of it is in the L64 block's own second sentence, so the block is closer to self-contained than its own note suggests, and the note points at the one adjacent section that does *not* carry it.

This makes **seven of seven** provenance notes audited in this programme that were false. The same false pointer is repeated a second time at [findings/sym3-stability.md#L50](../findings/sym3-stability.md#L50): *"proved in fence-posts.md under post F32"*.

**Two further pointer defects in the block.** It contains **no links at all**, "the first fundamental theorem" names no source and no group, and "Proposition 2.9" names no paper. A reader of [findings/fence-posts.md#L227](../findings/fence-posts.md#L227) alone cannot tell that Proposition 2.9 is [Levin–Chandrasekaran](../references/levin-chandrasekaran-dimension-free/notes.md)'s; the only link to those notes in the file is eight paragraphs earlier under [post F30](../findings/fence-posts.md#L197). Separately, the brief's flagged empty target is real and is not alone: `(#)` appears **seven** times in this file, lines 249, 314, 343, 357, 361, 395, 404.

## 2. The mathematics, derived cold

Fix $d$, let $U_n=\mathrm{Sym}^d(\mathcal W_n^*)$, let $\iota\colon\mathcal W_{n_0}\to\mathcal W_n$ be zero-padding and $P\colon U_n\to U_{n_0}$ be $f\mapsto f\circ\iota$.

**Step 0, padding lands in $\mathcal W_n$.** For $W\in\mathcal W_{n_0}$ the padded tensor has $\sum_{k=1}^{n}(\iota W)_{ikjk}=\sum_{k=1}^{n_0}W_{ikjk}=0$ when $i,j\le n_0$ and $0$ otherwise, and Bianchi is inherited slot-wise. So $\iota W\in\mathcal W_n$. ✓ (This is the record's standing padding fact, [conventions.md](../findings/conventions.md).)

**Step 1, an $O(n)$-invariant lift exists, unconditionally.** Take $u_{n_0}\in U_{n_0}^{O(n_0)}$. It extends $O(n_0)$-invariantly to the ambient $(\mathbb R^{n_0})^{\otimes4}$ as $u_{n_0}\circ\pi_{n_0}$, $\pi_{n_0}$ being the orthogonal projector onto $\mathcal W_{n_0}$, which is $O(n_0)$-equivariant because $\mathcal W_{n_0}$ is an orthogonal summand. Weyl's first fundamental theorem for $O(m)$ (spanning at **every** $m$, only linear independence needing a stable range) then writes $u_{n_0}=\sum_D c_Dq_D^{(n_0)}$ over complete-contraction diagrams in $d$ Weyl factors.

The load-bearing sub-step is that each $q_D$ is dimension-free. A degree-$d$ complete contraction has exactly $4d$ index **slots**, all of them on Weyl factors, and $D$ is a perfect matching of those slots. A factor of $n$ could only come from a $\delta$ both of whose endpoints lie on no tensor; there is no such slot, so no diagram carries one. A $\delta$ joining two slots of the *same* factor is a trace of $W$ and vanishes identically at every dimension. Hence $q_D^{(n)}\circ\iota=q_D^{(n_0)}$ exactly, and $w_n:=\sum_Dc_Dq_D^{(n)}$ is $O(n)$-invariant with $Pw_n=u_{n_0}$. **I attacked this step directly and it holds.**

*Note the projector is used only at level $n_0$, so its own $1/n_0$ trace-removal coefficients never enter $w_n$, which is what makes F32's closing caution about projector-carrying diagrams inapplicable here.* The block and both restatements in [results.md](../results.md#L210) omit this step entirely, writing the FFT as though it applied to $\mathcal W$ directly; [r232](REVIEW_r232.md) asked for a sentence on it and it was never added.

**Step 2, uniqueness on the $B$ side.** $w_n$ is $O(n)$-invariant hence $B_n$-invariant, and $u_{n_0}$ is $B_{n_0}$-invariant. Levin–Chandrasekaran's Proposition 2.9 makes $P\colon U_n^{B_n}\to U_{n_0}^{B_{n_0}}$ an isomorphism for $n\ge n_0\ge k_B$; injectivity forces $u_n=w_n$, which is $O(n)$-invariant. ∎

**So the conditional is right.** Note where the work sits: existence needs no presentation degree at all, and $k_B$ enters **only** to make the extension unique. If uniqueness fails, the conclusion fails outright rather than weakening, any $B_n$-invariant vanishing on the padded copy may be added, and such elements are abundant below the stable range, so "the" extension is then not a well-defined object and nothing about it is $O(n)$-invariant.

## 3. The hypotheses, one at a time

| clause | status |
| --- | --- |
| "where presentation degrees exist" | **Assumed, and the only cited route to it is closed in the same file.** The script's parenthetical grounds finiteness of $k_B$ on Levin–Chandrasekaran Theorem 2.11; [post F32](../findings/fence-posts.md#L215) itself states that Theorem 2.11's calculus "yields no $k_B$ here at all", its kernel clause needs $\mathrm{Ric}$ to commute with truncation and its sums clause needs the Ricci part padding-closed. [r232](REVIEW_r232.md) 1d puts it exactly: finiteness "is not refuted, it is simply not delivered by the theorem cited for it." **No finite $k_B$ is known to exist for this module.** |
| $k_B$ explicit? | **No upper bound anywhere on the record**, and a proved lower bound of $24$: $\mathrm{Sym}^6\mathcal W$ needs support $24$ (six Weyl blocks on disjoint $4$-subsets), and presentation degree is at least generation degree. [r237](REVIEW_r237.md) says of this, verbatim, *"That is correct and I do not dispute it."* |
| $n\ge n_0\ge k_B$ at $n_0=12$ | **Unsatisfiable.** $k_B\ge24>12$. |
| existence vs uniqueness | **Existence is unconditional** (step 1) and needs no $B_n$ at all; **uniqueness is the whole of the conditional content** and is exactly what is unavailable at 12. The block states them fused, so a reader cannot see that the free half is the useful one. |
| $B_n\subset O(n)$ upgrading | Derived in §2. The representation-stability input consumed is precisely Proposition 2.9's injectivity, i.e. a presentation degree for $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over the consistent sequence $\{B_n\}$, nothing else. |

**A statement defect, not just a gap.** $k_B$ is the presentation degree of the **module** $\{\mathrm{Sym}^d(\mathcal W_n^*)\}$ over $\{B_n\}$, and it depends on $d$, that dependence is the whole of the $24$-versus-$12$ question. The block writes "$k_B$" bare; [results.md#L608](../results.md#L608) is worse, calling it "the presentation degree of the sequence $\{B_n\}$", which attributes to a group sequence a quantity only a module has. Applying L64 to the degree-six certificate requires $k_B(\mathrm{Sym}^6)\le n_0$, and it is $k_B(\mathrm{Sym}^6)$ that is $\ge24$.

**On F32's correction, which is easy to misread.** [r237](REVIEW_r237.md) removes $24$ as a lower bound on the **base of the transfer route**, by showing $\dim(\mathrm{Sym}^6\mathcal W_n^*)^{B_n}$ is stationary at $339\,423$ from $n=12$. It does **not** lower $k_B$, and it does not make Proposition 2.9 available at 12, equal dimensions give an isomorphism only once the map is known injective or surjective, which r237 says explicitly. So L64's own hypothesis is untouched by the correction: **L64 remains inapplicable at $n_0=12$ by the route it is proved through.**

## 4. What it licenses, and what it does not

It transfers **one element of the invariant ring, as an identity**: the unique $B_n$-invariant extension *equals* the diagram lift $w_n$, and is therefore $O(n)$-invariant. That is all.

- **An inequality does not transfer, and the record carries the witness.** Positivity of $u_{n_0}$ on $\mathcal W_{n_0}$ constrains $w_n$ only on $\iota(\mathcal W_{n_0})$, a thin slice of $\mathcal W_n$. Concretely, for the certificate target $G_{\mu,n}=\Theta_n^2A-B+\mu(C-B)$ with $A,B,C$ each a fixed diagram, the lift of $G_{\mu,n_0}$ is $\Theta_{n_0}^2A-B+\mu(C-B)$, the constant is frozen at $n_0$. At the balanced sphere product at level $n$ (even $n$) one has $Q(W)=\theta W$, so $C=B$ and the lift evaluates to $\Theta_{n_0}^2-\Theta_n^2$ for **every** $\mu$. Since $\Theta_n^2=2(n-1)(n-2)/n^2$ has $d/dn=(6n-8)/n^3>0$, that is strictly negative. So the lift is $O(n)$-invariant and **not** nonnegative: the mechanism performs, and the inequality still dies. This is [post F31](../findings/fence-posts.md#L205), sitting immediately above the block that would be misread as licensing it.
- **Sharpness and equality cases do not transfer either**, for the same reason and more sharply: the equality locus of $u_{n_0}$ sits inside the padded slice, and $w_n$ has no reason to attain its extremum there. At the sharp target the record's own witness shows the lift is not merely non-sharp but violated at the new dimension's maximiser.
- **It is not the padding mechanism, and the two run in opposite directions.** Padding pushes *points* forward and preserves norm and $\theta$ because $\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra; its consequence is $M(n)\ge M(n_0)$, i.e. **lower** bounds move up and upper bounds do not. L64 pushes *functions* forward, and padding-compatibility is the datum it consumes ($q_D^{(n)}\circ\iota=q_D^{(n_0)}$), not the mechanism it is. **I find no place where the record conflates them**, [09-status.tex#L18](../report/sections/09-status.tex#L18) and [07-gradedness-split.tex#L938](../report/sections/07-gradedness-split.tex#L938) both state the certificate settles $n=12$ alone, and [diagram-closed.tex](../report/sections/diagram-closed.tex#L199) files the upward transfer as a closed route. The conflation is *available* to a reader of the block alone, and that is what wants fixing.

## 5. The direction of the transfer, the finding, in the brief's terms

**The mechanism transfers the invariant and not the inequality**, and this is now explicit. What the programme wants from a "transfer mechanism" is: a bound proved at $12$ holds at every $n\ge12$. What L64 delivers is: a *polynomial* defined at $12$ has a canonical $O(n)$-invariant continuation. The gap between them is the moving constant $\Theta_n$, and it is not a technicality, it is fatal by an exact witness at every even $n>n_0$.

The record is honest about this in the script docstring ("Equivariance was never the obstruction; the moving constant is") and in [09-status.tex#L18](../report/sections/09-status.tex#L18). It is **not** honest in two places:

1. **The block itself** ([fence-posts.md#L227](../findings/fence-posts.md#L227)) states the conditional with no applicability note whatever. Its neighbours F31 and F32 each carry a "what a new attempt must clear" paragraph; L64 carries none.
2. **The figures.** [diagram.tex#L87](../report/sections/diagram.tex#L87) and [diagram-closed.tex#L99](../report/sections/diagram-closed.tex#L99) print "**transfer proved** (L64)" in the *blue settled* box, beside two facts that genuinely are settled unconditionally ($\Theta_5=\sqrt{3/2}$; the block table stable from $12$). The figure caption defines blue as "settled". A conditional whose hypothesis provably fails at the only dimension in play is not in that category, and the figure is the one place a reader meets L64 without the surrounding text. **Recommended wording: "transfer mechanism proved, hypothesis unmet at $12$".**

[results.md#L608](../results.md#L608) is the mildest offender but still soft: "whether $k_B$ is small enough to reach $n=12$ is a separate, **open** question". It is not open, for the Proposition 2.9 route it is closed negatively, $k_B\ge24>12$.

## 6. What is owed, and it is reachable

**The $B_n$ detour is avoidable, and dropping it removes $k_B$ from the statement.** Step 1 is unconditional: restriction $U_n^{O(n)}\to U_{n_0}^{O(n_0)}$ is **surjective** for every $n\ge n_0$, with no stability hypothesis, no finite group and no presentation degree. So if the two sides have the same finite dimension, restriction is an isomorphism and the $O(n)$-invariant lift is unique among $O(n)$-invariants, which is the uniqueness the transfer route actually consumes.

And the record already proves that dimension equality in degree $3$, by an argument owing nothing to Levin–Chandrasekaran. [Lemma L63's stability paragraph](../report/sections/07-gradedness-split.tex#L932): $\mathcal W_n$ is the partition $(2,2)$, a Newell–Littlewood product of three has at most six rows, a partition labels an $O(n)$ irreducible exactly when $\lambda'_1+\lambda'_2\le n$, and across the constituents of $\mathrm{Sym}^3[2,2]$ the maximum of $\lambda'_1+\lambda'_2$ is $12$, at $(2,2,2,2,2,2)$. So no modification rule fires for $n\ge12$ and the $O(n)$ decomposition is constant there, the trivial multiplicity included.

**Hence, unconditionally and at the dimension wanted:** for $d=3$ and $n\ge n_0=12$, restriction $(\mathrm{Sym}^3\mathcal W_n^*)^{O(n)}\to(\mathrm{Sym}^3\mathcal W_{12}^*)^{O(12)}$ is an isomorphism, and every $O(12)$-invariant cubic has a unique $O(n)$-invariant continuation, namely its diagram lift. That is L64's conclusion for the SOS Gram side with the hypothesis discharged. It is worth recording as the repaired form; it costs nothing the record does not already own.

**Two things it does not do, stated so neither is over-read.**

- It does not open the route. The [F31](../findings/fence-posts.md#L205) obstruction is about *which* function the lift is, and is untouched by how uniqueness was obtained.
- It does not reach degree $6$ from $n=12$. The same row count applied to $\mathrm{Sym}^6[2,2]$ gives $\max(\lambda'_1+\lambda'_2)=24$, so L63's reason for stability at $12$ **stops at degree three**, and the $O$-side threshold for the sextics is $24$, independently reproducing the number that $k_B\ge24$ and $4\ell=24$ both give. *That the two routes agree on $24$ at degree six, from unrelated arguments, is the strongest evidence on the record that $24$ is the real threshold for the target and not an artefact of the $B_n$ framework, and it sits against [F32](../findings/fence-posts.md#L215)'s correction rather than with it, the correction's stationarity at $12$ is a statement about $B_n$-invariants, which see at most $2d$ coordinates by the sign-subgroup parity, whereas $O(n)$-invariants are not so constrained.*

**Where a run would decide something, named and not started** (analysis-only footing, no approval held):

1. **Is $\dim(\mathrm{Sym}^6\mathcal W_n^*)^{O(n)}$ stationary from $n=12$ or only from $n=24$?** A Weyl-character or Littlewood computation of the trivial multiplicity at $n=12,\dots,24$ decides it. *Stationary from $12$*: the repair of §6 extends to the target module and the invariance half of the transfer is discharged unconditionally at the dimension wanted, leaving F31 as the sole obstruction. *Moving between $12$ and $24$*: $24$ is confirmed as the true base for the whole route on the $O$ side as well, and F32's correction should be narrowed in the record to the $B_n$ statement it actually is.
2. **Does $k_B(\mathrm{Sym}^6\mathcal W)$ exist at all?** Only a finiteness proof settles this, and no computation can. It is named here because "where presentation degrees exist" is currently carrying it silently.

## 7. Checklist items, discharged

- **Hedging clauses.** "where presentation degrees exist", concealing that no finite $k_B$ is known to exist and the only cited route to one is closed. That is nine of nine hedges in this programme concealing something incomplete.
- **Does the file settle it above or below?** Yes, twice. [F30](../findings/fence-posts.md#L197) settles that the $O_n$ route is closed; [F31](../findings/fence-posts.md#L205) settles that the transferred inequality is false, with the exact witness. Fifteen.
- **The first fundamental theorem.** Correct theorem and correct group: Weyl's FFT for the **full** orthogonal group $O(m)$, whose invariants are spanned by $\delta$-contractions with no $\epsilon$-term, spanning at every $m$. Hypotheses hold. **A scope condition the block should carry:** the statement is false for $SO(n)$, a det-twisted degree-$d$ invariant carries an $\epsilon$ on $n$ slots, which is neither dimension-free nor padding-compatible, and the free-$\delta$-loop argument does not cover it. The record's own use is genuinely $O(12)$ (chiral $SO(12)$ pairs fused, $\mathrm{Pf}^2$ rather than $\mathrm{Pf}$ as the sixth separator), so nothing breaks, but [r237](REVIEW_r237.md)'s Rider 2 notes the record contemplates the $SO$ variant, and under it L64 does not hold.

## 8. Summary of what is owed on the block

1. Correct the provenance note here and at [sym3-stability.md#L50](../findings/sym3-stability.md#L50): the argument is [run_bn_transfer_theorem.py](../scripts/runs/run_bn_transfer_theorem.py)'s docstring, audited by [r232](REVIEW_r232.md), compressed into the block's own second sentence. Post F32 asserts it and does not prove it.
2. Add the applicability sentence: $k_B$ is the presentation degree of $\{\mathrm{Sym}^d\mathcal W_n^*\}$ over $\{B_n\}$, it depends on $d$, $k_B(\mathrm{Sym}^6)\ge24>12$, and no upper bound is known, so **the Lemma certifies no transfer the programme currently wants**.
3. Say what it transfers: an element, as an identity, never an inequality or an equality case, and point at [F31](../findings/fence-posts.md#L205) for the witness.
4. Split existence from uniqueness in the statement, since existence is unconditional and is the half that survives.
5. Cite Proposition 2.9 and the FFT; the block has no links at all.
6. Re-label the figures' blue box in [diagram.tex#L87](../report/sections/diagram.tex#L87) and [diagram-closed.tex#L99](../report/sections/diagram-closed.tex#L99).
7. Record the §6 repair for $d=3$, which is unconditional at $n_0=12$ and free.

*No consumer of L64 currently breaks*, the report and [sym3-stability.md](../findings/sym3-stability.md) both state that a certificate at $12$ settles $12$ alone, so no live inference lifts a bound through this Lemma. The exposure is that the block, read alone, invites exactly that inference, and it is the block a reader reaches from [INDEX-results.md](../findings/INDEX-results.md).
