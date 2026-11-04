# Review r672, Lemma L85, $\dim(\mathrm{Sym}^6\mathcal W_5)^{O(5)}=14$

**GAP.** Every number in the block is right and I reproduce all of them cold by a route that shares no step with the record's script, $1,1,4,5,14$ at degrees $2$ through $6$, and $0$ at degree $1$. **One sentence of the block is false with a one-character witness**, the support is a machine dimension count presented under a commit titled *derived*, and the $O(5)$-versus-$SO(5)$ step that licenses the odd entries of the sequence appears only inside the script. **[L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) may rest on the $14$ exactly as they do**; the dependency is real, correct and acyclic.

*Reviewer B of an independent pair on identical briefs. I have not read r671, its log, or any other reviewer's work on L85.*

## Standing rule

Analysis-only footing, inherited from the brief and from [analysis-only.md](../.claude/rules/analysis-only.md). Everything below marked **screen** is seconds of compute on objects I constructed for the purpose, reported as a screen and never as the ground of a positive claim. The positive claims are the derivations; the screens are what I ran before recording them. No sweep, census or plethysm was opened.

## Readings I adopt, since [conventions.md](../findings/conventions.md) carries none of them

| symbol | reading taken | where it comes from |
| --- | --- | --- |
| $\mathcal W_5$ | the $O(5)$-irreducible $[2,2]$ inside $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)$, $\dim35$, highest weight $2e_1+2e_2$ | [sym3-blocks.md](../findings/sym3-blocks.md) header; [conventions.md](../findings/conventions.md) gives only $\dim\mathcal W_n$ |
| $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$ | the space of $O(5)$-invariant **sextic forms** on $\mathcal W_5$, i.e. $(\mathrm{Sym}^6\mathcal W_5^*)^{O(5)}$ | forced by the consumers; equal to the block's object because $\mathcal W_5$ carries an invariant inner product, so $\mathcal W_5\cong\mathcal W_5^*$. **The block writes the module, its consumers need the dual, and nothing says they agree** |
| $\langle\cdot,\cdot\rangle$ on $\Lambda^2$ | $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal | [conventions.md](../findings/conventions.md), *Norms and pairings* |
| $W^\#$ | $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}W_{\gamma\delta}W_{\varepsilon\zeta}$, the normalisation with $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ | **not on the record anywhere.** Pinned below, because the constant $2$ moves without it |
| $\alpha,\beta$ | $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$, $\beta=W_{tspq}W_{tjpl}W_{sjql}$ | [bispectral.md](../findings/bispectral.md), [Lemma L50](../findings/bispectral.md) |

## 1. Is the $14$ derived, imported or measured?, **MEASURED, honestly cited, and labelled *derived* in its own commit**

**Measured.** The block's display $\dim V^G=\tfrac1{|W|}\mathrm{CT}[\chi\prod_\alpha(1-t^\alpha)]$ is the Weyl integration formula and is correctly stated (the product runs over all eight roots of $B_2$, $|W(B_2)|=8$) but a formula is not a value. The value comes out of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py), which is where the constant-term extraction actually happens.

**It does *not* have the shape of support the brief warns about, and this is worth saying plainly.** I read the script line by line. It builds $\chi_{(2,2)}$ by alternant division in the Weyl character formula, forms $\mathrm{Sym}^k$ characters from power sums by Newton, multiplies by $\prod_\alpha(1-t^\alpha)$ and divides the constant term by $8$. **Nothing is hardcoded**, the only assertion is `sum(CHI.values()) == 35`, a check rather than an answer. This is the opposite of the neighbouring case where the cited script hardcoded the multiplicity column it was said to establish.

**But the label is still wrong twice over.**

- The originating commit `d2da0b0c` is titled *"the 14 constraints **derived**"* and carries `Deliverable: derivation`, while its own first bullet says *"computed by Weyl integration in exact Laurent polynomials, and it comes out 14"*. **The body is honest and the title is not**, and the title is what the record inherited.
- The block itself says *"**the answer is $14$**"* with a script link and no word for what kind of support that is. Compare [L84](../findings/sym3-blocks.md) three lines above, which says *"forced rather than measured"* about its own claim. **L85 makes no such statement, so a reader ranks it with L84 by default.**

**What is human-checkable, and it is three rungs of five.** Degree $1$ is $0$ and degree $2$ is $1$ because $\mathcal W_5$ is $O(5)$-irreducible and non-trivial, that is Schur, in one line each, at *every* $n\ge5$. Degree $3$ being $1$ has an independent derivation on the record ([L50](../findings/bispectral.md), fence post 2g). **Degrees $4$, $5$ and $6$ (including the $14$ itself), have no support on the record beyond that one script.**

### Screen: the $14$ reproduces by a route sharing no step with the record's

I rebuilt the count three ways-apart from the script and got the same column.

- $\chi_{\mathcal W_5}$ from the **vector** representation's five weights, via $\mathrm{Sym}^2(\Lambda^2\mathbb R^5)=\mathcal W_5\oplus\Lambda^4\oplus\mathrm{Sym}^2_0\oplus\mathbb R$, so $\chi_{\mathcal W}=\chi_{\mathrm{Sym}^2\Lambda^2}-\chi_{\Lambda^4}-\chi_{\mathrm{Sym}^2 V}$ and $55-5-15=35$. *(The script uses the Weyl character formula and alternant division.)*
- $\mathrm{Sym}^k$ weight multiplicities by direct multiset dynamic programming over the $35$ weights, checked against $\binom{34+k}k$ at every degree. *(The script uses Newton's identities on power sums.)*
- The trivial multiplicity by Brauer–Klimyk, $n_0=\sum_{w\in W}\det(w)\,m(\rho-w\rho)$, which at $B_2$ is $m(0,0)-m(1,0)-m(3,0)-m(1,1)+2m(2,1)+m(3,1)-m(2,2)$. *(The script uses $\prod_\alpha(1-t^\alpha)$ and a constant term.)*

| degree | $1$ | $2$ | $3$ | $4$ | $5$ | $6$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\dim(\mathrm{Sym}^k\mathcal W_5)^{SO(5)}$ | $0$ | $1$ | $1$ | $4$ | $5$ | $\mathbf{14}$ |

The intermediate $\chi_{\mathcal W_5}$ is $W(B_2)$-invariant with highest weight $(2,2)$ at multiplicity $1$ and $m(0,0)=3$, which is $V_{(2,2)}$ and agrees with $\tfrac16(2a{+}3)(2b{+}1)(a{-}b{+}1)(a{+}b{+}2)=35$. **The $14$ and the whole sequence are right.**

## 2. The Lovelock collapse, **derived, and the two arguments are not circular, but only because each has a leg the blocks that use them never cite**

**The identity.** With $\alpha,\beta$ as above, $\beta-\tfrac\alpha2=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}$ ([fence post 2g](../findings/fence-posts.md), [L50](../findings/bispectral.md)). The generalised Kronecker delta is a full antisymmetrisation over six indices, so **at $n\le5$ six indices drawn from a five-element set must repeat and it vanishes identically**, that half is a theorem in one sentence, and it is the whole of "why $n\le5$". The dictionary $\alpha=8\mathop{\mathrm{tr}}(M^3)$, $\beta=2\langle M^\#,M\rangle$ then gives $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$.

**Why it fails at $n\ge6$ is two statements, and only the first is a theorem.** The delta is nonzero from $n=6$, necessary, not sufficient. That the *contraction* against three Weyl tensors is also nonzero is a separate non-vacuous fact, and the record establishes it by measurement ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py), and 2g's "the ratio wanders at $n=6$").

**Screen.** On algebraic Weyl tensors I built from the definitions (random, Bianchi-projected, Ricci-removed; residual traces and Bianchi at $10^{-15}$), $\beta/\alpha$ is $0.50000000$ at $n=4$ and $n=5$, $0.47502304$ at $n=6$ and $0.32965222$ at $n=7$. A padded $\mathcal W_4$ tensor sitting inside $n=6$ still returns exactly $0.50000000$, **so padding preserves both contractions**, which is the step that carries a single $n=6$ witness up to every $n\ge6$.

**The constant $2$ is convention-bound, and the convention is nowhere on the record.** Screening the sharp against its own anchors: taking $(W^\#)_{\alpha\beta}=\sum c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}W_{\gamma\delta}W_{\varepsilon\zeta}$ with [conventions.md](../findings/conventions.md)'s $c_{abc}=\langle[v_a,v_b],v_c\rangle$ and its ordered-sum default gives $\langle W^\#,W\rangle/\mathop{\mathrm{tr}}(W^3)=\mathbf4$, not $2$; under plain Frobenius on $\Lambda^2$ it gives $\mathbf{16}$. The reading that returns $2$ is the one with the extra $\tfrac12$, pinned by $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, I get $2,3,4,5$ at $n=4,5,6,7$ under it and $4,6,8,10$ without. **So the sentence's "$2$" is right in the record's own pairing and only under a normalisation of $\#$ that [conventions.md](../findings/conventions.md) does not carry**, the file tables $Q(W)=W^2+W^\#$ and the $\circ$ product and never defines $\#$ itself. *[bispectral.md](../findings/bispectral.md) says its $M^\#$ is "with respect to the **unnormalised** $\varphi_{ij}=E_{ij}-E_{ji}$" in the same sentence as $\alpha=8\mathop{\mathrm{tr}}(M^3)$, which is the half-trace reading, two normalisations named in one line.*

**Circularity: none, and here is the audit.** Two directions are in play and they are supported by different things.

| direction | asserted where | its leg |
| --- | --- | --- |
| identity $\Rightarrow$ cubic invariants are $1$-dimensional | [sym3-blocks.md](../findings/sym3-blocks.md) line 42 | Lovelock's $\delta^{[6]}$, via [L50](../findings/bispectral.md) / 2g, **no dimension count enters** |
| $1$-dimensionality $\Rightarrow$ identity, with $c=2$ by one evaluation | [L61](../findings/sym3-blocks.md)'s note, and the companion audit the brief names | L85's Weyl integration, **no contraction enters** |

Each leg is independent of the other's conclusion, so the pair is **not** circular. But **neither block cites its leg**, and a reader who takes line 42 and L61's note together and looks no further is reading a loop.

**One step is genuinely missing at line 42.** *"$\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$, **so** the cubic invariant space is one-dimensional"* needs two things the record never states: that the $O(5)$-invariant cubics on $\mathcal W_5$ are **spanned** by $\alpha$ and $\beta$ (a first-fundamental-theorem plus normal-form count, cited nowhere in [findings/](../findings/)), and that $\alpha\not\equiv0$. Without the spanning statement the "so" does not follow. **Nothing downstream breaks**, because L85's Weyl integration reaches the same conclusion without it, which is precisely the value of having the second method.

## 3. The degree sequence, **it is one column of one loop, and the block's summary sentence about it is FALSE**

**What it is a sequence of:** $\dim(\mathrm{Sym}^k\mathcal W_5)^{O(5)}$ for $k=2,3,4,5,6$.

**How it reconciles to the $14$:** it does not sum to it. **The $14$ *is* the last entry.** The heading states one number twice.

**And the sequence is not an independent check on the $14$.** The script's `for k in range(1, K+1)` prints all six degrees from one call; the $14$ is the last line of that loop. **The sequence and the total are two views of one computation**, the same pattern the brief flags next door, in its mild form: reading five lines of one column checks the transcription and never the column. *The one entry that is genuinely cross-checked is degree $3$, against Lovelock; degrees $2$ and $1$ are checkable by Schur; degrees $4$, $5$ and $6$ are not checked by anything on the record.*

> ### REFUTED, with the witness: **"Every entry is strictly smaller" is false at the first entry.**
>
> The block writes: *"The sequence at $n=5$ is $1,1,4,5,14$ for degrees $2$ through $6$, against the stable-range $1,2,7,19,89$. **Every entry is strictly smaller**, which is the syzygies."*
>
> **Degree $2$: $1$ against $1$.** Equal, not strictly smaller. Four of the five entries are strictly smaller; the first is not.
>
> **And it cannot be made true by moving a number.** $\mathcal W_n$ is $O(n)$-irreducible at every $n\ge5$, so by Schur the degree-$2$ invariant count is exactly $1$ at every dimension, $\lVert W\rVert^2$ and nothing else. **There is no $n$ at which the degree-$2$ entry falls below the stable value**, so no syzygy can act there. The clause *"which is the syzygies"* is correct for degrees $3$ through $6$ and vacuous at degree $2$, which is exactly where the sentence over-reaches. *Screened: my own count returns degree $2=1$ at $n=5,6,7,8,9$ alike.*
>
> Repair, and it is one word: **"Every entry from degree $3$ on is strictly smaller."**

**A second over-reach in the same sentence.** *"degree $3$ being $1$ **reproduces the Lovelock collapse**"*, it reproduces the collapse's *consequence*, one-dimensionality. It does not reproduce the *identity*: a dimension count gives $\langle W^\#,W\rangle=c\mathop{\mathrm{tr}}(W^3)$ for **some** $c$, and pinning $c=2$ needs one evaluation on top. *The rest of the clause ("by a method sharing nothing with the contraction identity that first gave it"), is true, and my screen is a third such method.*

## 4. $O(5)$ against $SO(5)$, **the block never states it, and the reason it needs is stronger than the standard one**

**The block says $O(5)$ five times and justifies it nowhere.** The only statement of the step in the whole chain is a `print` inside [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py): *"this is the SO(5) integration; O(5) = SO(5) x {+-Id} and -Id acts trivially on Weyl_5, so the two agree here."* **The script has it right, and the record does not carry it.**

**The step, stated properly.** $\det(-I)=(-1)^5=-1$, so $-I\notin SO(5)$ and, being central, $O(5)=SO(5)\times\{\pm I\}$. Then $-I$ acts on $\Lambda^2\mathbb R^5$ by $(-e_a)\wedge(-e_b)=e_a\wedge e_b$, i.e. **trivially**, hence trivially on $\mathcal W_5\subset\mathrm{Sym}^2(\Lambda^2)$ and on every $\mathrm{Sym}^k\mathcal W_5$. So the $O(5)$- and $SO(5)$-invariants coincide **in every degree**. At even $n$ the whole step fails: $-I\in SO(n)$ and the second component is a reflection acting non-trivially.

**And the weaker form of the step, which the record's neighbouring audit note carries, does not cover this block.** *"Even-degree invariants coincide"* would license degree $6$ and leave **degrees $3$ and $5$ of the block's own sequence unjustified as $O(5)$ counts.* The trivial action of $-I$ is what licenses the odd entries, and it is the sharper fact. **This is the one place where the neighbouring block's stated reason is not good enough for L85.**

## 5. Scope, $n=5$ only, and the $n\ge6$ half is asserted in the block and supported elsewhere

**What it licenses.** The number of linear equations an $O(5)$-invariant SOS certificate for $F_5$ must satisfy on $\mathcal W_5$, and nothing about $\mathcal W_n$ for any other $n$. Everything in the derivation is $B_2$-specific: the root system, $|W|=8$, $\rho=(3/2,1/2)$, the $35$ weights.

**What it does not license.** No transfer up or down. The file says so itself at line 167 (*"It does not lift"*) and my screen agrees for a reason the record does not give: **degree $4$ at $n=6$ is $6$, not the stable-range $7$.** So $n=6$ is not stable at degree $4$ either, and $1,2,7,19,89$ is a large-$n$ limit rather than the $n=6$ row. *A reader who takes "against the stable-range" as "against $n=6$" gets the degree-$3$ entry right and the degree-$4$ entry wrong.*

**The $n\ge6$ half of the multiplicity sentence.** *"The trivial multiplicity is $1$ here and $2$ from $n\ge6$"* is **asserted in the block with no support at all**, no script, no pointer, no reviewer. It is supported elsewhere on the record, by 2g's measurement that the Lovelock ratio wanders at $n=6$.

**Screen**, since I was about to record that it holds: the cubic count is $1$ at $n=5$ and $\mathbf 2$ at $n=6,7,8,9$, by the same independent route ($B_m$ for odd $n$, $D_m$ for even, Weyl group orders $8,24,48,192,384$ as they should be, $\dim\mathcal W_n=35,84,168,300,495$ matching $\tfrac{n(n-3)(n+1)(n+2)}{12}$). At odd $n=7,9$ this **is** the $O(n)$ count by the $-I$ argument above; at even $n=6,8$ it caps $O(n)$ at $2$, and $\alpha,\beta$ are both $O(n)$-invariant and independent there by the $\beta/\alpha\ne\tfrac12$ screen, so the $O(n)$ count is exactly $2$.

**What remains asserted:** the upper bound $\le2$ at $n\ge10$. It follows from the first fundamental theorem plus a normal-form count of the complete contractions of $W\otimes W\otimes W$, which is standard and **cited nowhere on this record**. *The lower bound $\ge2$ at every $n\ge6$ is clean: one $n=6$ witness, padded up, both contractions preserved.*

## Checklist

**Provenance, clean, and rare here.** `git log -L 54,60` on the file returns three commits: `b432dfd7` (the file's creation, carrying the text over from [plan.md](../plan.md)), `8d869d2c` (headings), `fe85b5bd` (the `L` prefix). **The text of the body has not changed one character since it was written.** `8d869d2c`'s *"headings only: no statement, proof or ordering is altered"* holds for L85 as it did for L83, I diffed it. **The commit that narrowed several pointers into falsehoods elsewhere in this file did not touch L85**, which has no pointer to narrow.

**Hedging clauses.** *"the answer is $14$"*, true, and silent about what kind of answer. *"which is the syzygies"*, attached to a sentence that is false at its first entry, and vacuous there in any case. *"reproduces the Lovelock collapse"*, reproduces its consequence, not the identity. *"sharing nothing with the contraction identity"*, **true**, and I confirm it with a third such method. *"here"*, in the line-42 sentence, means $n=5$ and is unambiguous.

**Duplication.** The $14$ and the sequence are **not** duplicated as a numbered result: the sequence string appears once in [findings/](../findings/). The $14$ is **consumed uncited** at [L59](../findings/sym3-blocks.md), [L62](../findings/sym3-blocks.md), [L89](../findings/sym3-blocks.md) and at [results.md](../results.md) lines 202, 586 and 598, plus [07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). *The canon's copy at [results.md](../results.md) line 598 names the object correctly ("the $14$ invariant sextics") where L85's heading names $\mathrm{Sym}^6$ of the module.* The **degree-$3$** claim, by contrast, is on the record at least six times: L83's table row $(0,0)_1$, [sym3-blocks.md](../findings/sym3-blocks.md) lines 42, 60 and 167, [bispectral.md](../findings/bispectral.md), [fence post 2g](../findings/fence-posts.md).

**Does the file settle it above or below?** For degree $3$, four times over, the $(0,0)_1$ row of L83's own table twelve lines above L85 **is** the statement that the cubic invariants are one-dimensional. For the $14$, no: [L89](../findings/sym3-blocks.md) restates it and imports it.

**Pointers.** [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) resolves and does what the sentence says. **L85 has no prose pointer, so the `##`-boundary ambiguity recorded on [L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) does not reach it.**

**One live mis-anchor, elsewhere.** [r664](REVIEW_r664.md) cites *"[L85](../findings/sym3-blocks.md#L42)'s degree sequence"*. **Line 42 is the trivial-multiplicity sentence inside L83's section**; L85's heading is at line 54 and its degree sequence at line 60. Under either reading of the `##` boundary, `#L42` is not L85.

**One structural note.** The [INDEX-results.md](../findings/INDEX-results.md) row for **85** ends mid-clause: *"with the degree sequence"*, with no values. *I have not edited it; the brief confines me to this file and my log.*

## The dependency, stated explicitly

**[L59](../findings/sym3-blocks.md) and [L62](../findings/sym3-blocks.md) may rest on the $14$ exactly as they do.**

- **The number is right.** Reproduced here by a route sharing no step with the record's.
- **It is the right object for both.** Both need the dimension of the space of $O(5)$-invariant sextic *forms* on $\mathcal W_5$. L85 states the dimension of $(\mathrm{Sym}^6\mathcal W_5)^{O(5)}$; these agree because $\mathcal W_5$ carries an invariant inner product. **That identification is used at both consumers and stated at neither.**
- **[L62](../findings/sym3-blocks.md)'s cap is untouched.** $\mathop{\mathrm{rank}}\le14-1=13$ needs only that evaluation at $W_0$ is a nonzero functional on the $14$, which holds because $\lVert W\rVert^6$ is an invariant sextic with $\lVert W_0\rVert^6=1$. **Nothing in that six-line proof touches the sequence, the syzygies or the false sentence.**
- **[L59](../findings/sym3-blocks.md)'s $\mathop{\mathrm{rank}}=14-\dim\mathrm{ANN}$ is untouched**, for the same reason: it uses the $14$ as the target of $\mu|_{\mathrm{inv}}$, which is that same space.
- **Acyclic.** L85's support is a character computation on $\mathcal W_5$. It touches no cubic, no $K$, no $W_0$, no orbit, no prime and no Gram matrix, none of the objects L59, L62, L87 or L90 are built from. **There is no path back.**

**The one qualification the two audits should carry.** L59 and L62 were audited as resting on a *Lemma*. What they rest on is a **machine dimension count** whose only human-checkable rungs are degrees $1$, $2$ and $3$. That does not weaken either result (I have now reproduced the count independently) but the record should say which kind of thing the $14$ is, because [L62](../findings/sym3-blocks.md)'s own audit split it into a proved half and a measured half on exactly this distinction, and **the $14$ sits on the measured side of a lemma nobody split.**

## What I would change, smallest first

1. **"Every entry is strictly smaller" $\to$ "Every entry from degree $3$ on is strictly smaller."** One clause; the sentence is false as written.
2. **Say what kind of support the $14$ has.** One word in the block, *computed*, as [L84](../findings/sym3-blocks.md) says *forced*, and the commit title's *derived* stops propagating.
3. **State the $O(5)=SO(5)$ step in the block**, in the strong form: $-I$ acts trivially on $\mathcal W_5$, so the two agree at **every** degree. Without it the odd entries of the sequence are unlicensed. It exists only inside the script.
4. **Say that the sequence and the $14$ are one computation**, and that degree $3$ is the only entry with a second method.
5. **Define $W^\#$ in [conventions.md](../findings/conventions.md)**, with the anchor $\mathrm{Id}^\#=(n-2)\mathrm{Id}$. The constant $2$ in the collapse reads $4$ or $16$ under the two neighbouring conventions, one of which is that file's own stated default for $c_{abc}$ and ordered sums.
6. **Give line 42 its missing step or its citation.** Either the spanning statement for the cubic invariants, or a pointer to [L50](../findings/bispectral.md), which is where the mechanism actually lives.
7. **Fix [r664](REVIEW_r664.md)'s `#L42` anchor and finish the [INDEX-results.md](../findings/INDEX-results.md) row for 85.**

## Compute run, declared

Four screens, all on objects constructed here, all seconds: the $B_2$ invariant column by weights and Brauer–Klimyk; the same for $n=6,7,8,9$ at degrees $\le3$; $\beta/\alpha$ on Weyl tensors built from the definitions at $n=4,5,6,7$ and on a padded one; and the sharp's normalisation against $\mathrm{Id}^\#=(n-2)\mathrm{Id}$. **No sweep, census, optimisation, falsifier hunt or plethysm was opened.** Each screen was run before recording the claim it screens, and none of them is offered as the ground of a positive claim, the arguments above are.
