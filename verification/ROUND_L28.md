# ROUND_L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `PROVEN, hypotheses corrected`, repaired, impact `CONTAINED`. **Verifiers:** v179, v180, v181 all died mid-round without filing; **v182, v183, v184 reserved for the redispatch.**

> **THE FIRST DISPATCH IS LOST.** All three reached late phases, *"dims/charges/Fox/e/L70 slack all verified by hand"*, *"verified by hand: dim sum identity, all 7"*, and Fox's hypotheses read at source, **and none filed a report or a commit**, going silent for fifty-five minutes after a mid-phase line. *Their v numbers are permanent addresses and are not reused.* **Nothing of their work survives**, which is what the incremental-write instruction exists to prevent and did not: none created its report file early. *The second dispatch is told to create the file as its **first action**, before reading anything, and to commit it as soon as it holds one section.*

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 439–445 |
| Landscape statement | [results.md](../results.md) line 142 |
| The block | [nondegeneracy.md](../findings/nondegeneracy.md) lines 512–546 |
| Brief | [BRIEF_L28.md](BRIEF_L28.md) |

## Findings from phase 0

**1. The landscape statement contradicts its own canonical entry.** It reads *"Only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty"*, while the block's table gives the orbit tangent $L_e=\tfrac12$ at **every** $m$, which is exactly what $\dim E(\tfrac12)=m(m-1)$ says. *The sentence wants "among the summands off the orbit", and read as written it denies the eigenvalue the lemma is about.*

**2. The table is duplicated.** The block says *"the same table stands at [second-order.md](../findings/second-order.md), with the explicit $c_S$ and $q_S$ and the $\sharp$ closed forms behind it"*, **and nothing keeps the two copies in step.** *This record has found three duplications this session whose provenance notes claimed they were resolved.*

**3. The block carries a repaired arithmetic error in the very column its conclusion once rested on.** The index records that *"the charge list named a summand that does not exist, $c_S+q_S^2=4m$ was a Casimir tabulated without its charge"*, and the table now carries $4(m+1)$ twice. **The round should check the repaired column, not the repair's account of itself.**

## What the verifiers are asked beyond the standing list

Whether the seven real dimensions sum to $\dim\mathcal W_{2m}$ identically in $m$; whether the branching rule gives ten complex summands falling into seven real classes; whether $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ is right and $c_S+q_S^2=2(m+1)$ is the exact condition for $\tfrac12$; whether $4(m-1)$ meets it at $m=3$ alone and whether that summand is genuinely absent there by the Young-diagram argument rather than by the dimension formula vanishing; and whether **both** Fox identities hold on the seven rows ($\operatorname{tr}L_e=0$ and $\operatorname{tr}(L_e^2)=\kappa_F(2m)\lVert e\rVert^2$) since the block leans on them as an independent check of the whole list.

**And the second route to $\lambda_{\max}$**: solving $\operatorname{tr}L_e=0$ for the $\mathfrak{su}(m)$ row against the other four. *The block says each remaining class is recovered uniquely the same way, which is a strong claim worth testing at one more row than the one it displays.*

## Clustering, all three in: two `PROVEN, hypotheses corrected`, one `HYPOTHESIS-DEBT`

**`PROVEN, hypotheses corrected`.** *The conclusion stands, and the repaired charge column survives an independent re-derivation at all seven rows*, each $c_S+q_S^2$ recomputed from the $GL(m)$ weight rather than read off, **including the two index positions easiest to get wrong**.

**Everything structural checked exactly**: ten summands as $4$ self-dual $+2\cdot3$; the dimension sum as a polynomial identity; each of the seven dimensions by the hook-content formula; all seven charges and eigenvalues; both Fox identities on both sides; $\operatorname{tr}e=0$ and $\lVert e\rVert^2=1/\theta^2$, tying four independent quantities; the [L70](../findings/bounds.md) slack $2(m-2)\theta$ **by three independent routes**; and the second route to $\lambda_{\max}$ tested at four rows, each recovered uniquely. **The duplicate table at [second-order.md](../findings/second-order.md) agrees row for row**, the first duplication this session that was actually in step.

**Both named traps answered.** *The Fox import is inverted rather than violated*: Theorem 1.3 is a theorem **about** the algebra by name, its only hypothesis is $\dim V\ge4$, and it **concludes** exactness, Fox's own text, *"an exact algebra is nonunital"*. The unital trap belongs to Tkachev's Theorem 1.2, which the record already bars. And **$\ker W=0$ at every $m\ge3$**, the middle eigenvalue vanishing precisely at $m=2$, *so the range restriction is the kernel condition.*

| id | finding | support |
|---|---|---|
| **O0**, **THE SHARPEST** | **multiplicity-freeness is unjustified at $m=3$, which is the one dimension the headline turns on.** [Howe–Tan–Willenbring](../references/howe-tan-willenbring-2005-stable-branching/notes.md)'s stable rule applies once $\lfloor m/2\rfloor\ge2$, that is **$m\ge4$**, and multiplicity-freeness is what lets Schur make $L_e$ a scalar on each summand, hence what makes each value an eigenvalue rather than a Rayleigh bound. *Without it at $m=3$ the argument falls back on numerical measurement.* **The repair exists and the block does not carry it**: [LEDGER.md](../findings/LEDGER.md) records *"multiplicity-freeness is now a theorem at every $m\ge3$"*, closing it by hand, at $m=3$ every mixed piece is a standard $\mathfrak{su}(3)$ tensor product and $\bar{\mathbf3}\otimes\mathbf3=\mathbf1\oplus\mathbf8$ produces no $V_{(1,1);(1,1)}$ | v182 |
| **O1** | **the $\kappa_F$ attribution is backwards, and it inverts what the second identity does.** $\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is credited to Fox and is **not his**, his Remark 1.4 explicitly leaves $\kappa$ uncomputed for $\dim V>4$, and the closed form is a numerical fit. *So $\operatorname{tr}(L_e^2)=\kappa_F(2m)\lVert e\rVert^2$ is that fit **read backwards**, not an independent check*, and the block leans on it as one of two | v182, v183 |
| **O2** | the landscape defect **confirmed**: *"Only $\tfrac2{m+1}$ reaches $\tfrac12$"*, the orbit row carries $\tfrac12$ at every $m$, so read literally it implies $E(\tfrac12)=0$, contradicting its own lemma four lines above. **Repair is three words** | v183 |
| **O3** | [second-order.md](../findings/second-order.md)'s trace argument **forces one linear relation between the two zero rows, not their vanishing**, it gives only $d_5y_5+d_6y_6=0$, exhibited with a closed-form one-parameter family. *The valid reason is the shared charge, and **L28's own block does not repeat the error***, so the defect is the sibling file's alone | v182, v183 |
| **O4** | three used-but-unstated hypotheses: **native dimension** (no padding), $\lVert W\rVert=1$, and [L24](../findings/second-order.md) behind the closing *"not a maximiser"* | v183 |
| **O5** | two overstatements: *"each remaining class recovered **uniquely**"* fails vacuously on row $4$ at $m=3$, the coefficient being zero where the summand is absent; and *"$\lambda_{\max}$ rests on more than the charge formula"*, **the solve consumes six other values, five of them from that formula** | v182 |
| **O6** | **the norm collision bites.** The block runs on $\operatorname{tr}(X^2)$ while [conventions.md](../findings/conventions.md) tables the halved $\mathfrak{so}(n)$ norm, *the halved reading would break the Fox check by a factor $2$* | v182 |

**Two further confirmations.** *The $m=3$ absence is sound on stronger grounds than the block gives*: $\ell(\mu^+)+\ell(\mu^-)=4>3$, or concretely $\Lambda^2E\otimes\Lambda^2\bar E$ is $9$-dimensional at $m=3$ against a $9$-dimensional trace part, **and the block's epistemic caveat about analytic continuation is correct**, the same polynomial going *negative* at $m=2$. *And $m=2$ breaks four separate ways*, negative dimension, $\ker W\ne0$, $\lambda_{\max}$ truly $\tfrac12$ rather than $\tfrac23$, and zero slack, **so the $n=4$ Fox anchor is unusable and $m\ge3$ is necessary rather than conventional.**

## Adjudication

**Verdict `PROVEN, hypotheses corrected`, repaired. Impact `CONTAINED`.** *No verifier found an error anywhere in the block, the repaired charge column included.* All three recomputed the seven charges from the $GL(m)$ weights rather than reading them off, derived the dimension sum as a polynomial identity, checked both Fox identities on both sides, and confirmed the [L70](../findings/bounds.md) slack, one of them by three independent routes. **The conclusion stands and the arithmetic is flawless.**

### What the round actually found: all three independent checks are weaker than claimed

**The block offers three supports beyond the charge formula, and each is less than it says.**

1. **Multiplicity-freeness**, which carries the Schur step *and* the orbit identification, comes from a stable rule that starts at $m\ge4$, **and $m=3$ is the one dimension the "no exception" headline is decided at.**
2. **The two Fox identities** are polynomial identities in $m$ and **both pass at $m=2$, where the row list carries a negative dimension of $-3$ and is known refuted.** *They certify the list's internal arithmetic and say nothing about whether it is the right decomposition.*
3. **The second route to $\lambda_{\max}$** consumes six values of which **five are charge-formula outputs**, so perturbing a row moves the answer, by $-\tfrac{m^2}6\epsilon(m)$ at row $7$. It is a second route to the value, not independence from the formula.

*Each was recorded as an independent confirmation. Together they were the reason a reader could trust the table beyond one computation, and that reason is thinner than the block states.*

**And the repair for the worst of them was already on the record.** [LEDGER.md](../findings/LEDGER.md) closes $m=3$ by hand, every mixed piece a standard $\mathfrak{su}(3)$ tensor product, $\bar{\mathbf3}\otimes\mathbf3=\mathbf1\oplus\mathbf8$ producing no $V_{(1,1);(1,1)}$, **and the block cited nothing at all there.**

### The trap answered, at source, three times

**The unitality import does not fire.** Fox's Theorem 1.3 asks only for a Euclidean space of dimension at least $4$, met at $n=2m\ge6$, and **writes "an exact algebra is nonunital"**, the absence of a unit is the theorem's *conclusion*, not a bar to citing it. *The trap belongs to Tkachev's Theorem 1.2, which the record already bars.*

### The repairs, all applied

| finding | what changed |
|---|---|
| O0 | multiplicity-freeness stated as load-bearing twice, the stable rule's $m\ge4$ range given, and [LEDGER.md](../findings/LEDGER.md)'s hand proof brought into the block |
| O1, and v184's | the two identities recorded for what they check (arithmetic, not decomposition), **with the $m=2$ demonstration that they pass on a refuted list**, and $\kappa_F$ named as a fit the second identity derives |
| O5 | the independence claim replaced by what the solve actually gives, with the row-$7$ sensitivity; *"each uniquely"* qualified at $m=3$ |
| O2 | the landscape line reads *"besides the orbit tangent, which carries $\tfrac12$ at every $m$"* |
| O3 | [second-order.md](../findings/second-order.md)'s trace argument corrected, the identity forces one linear relation, **the shared charge is the reason** |
| O4, O6 | native dimension, unit norm and [L24](../findings/second-order.md) stated; the unhalved norm named, with what the halved reading would do to the Fox check |

### Queued to [plan.md](../plan.md)

**I50, the charge formula $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ is checked at eighteen values and not proved.** *With multiplicity-freeness now sourced and the two identities demoted to arithmetic checks, it is the one support under the table that has no derivation anywhere*, and the table is what the lemma is.
