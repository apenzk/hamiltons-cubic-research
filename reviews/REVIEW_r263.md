# REVIEW r263, Gate 2, the seed lemma

Reviewer 263. Commits under review: `e0b9cb0` (primary), `90ad8d9`, `f99e050`.
Primary file: [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py), and the final section of [findings/brauer-pairing.md](../findings/brauer-pairing.md). Supporting: [plan.md](../plan.md) section 2 item 1, [findings/INDEX.md](../findings/INDEX.md) line 40, [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py), [rui-brauer-semisimplicity/notes.md](../references/rui-brauer-semisimplicity/notes.md), [lehrer-zhang-sft-orthogonal/notes.md](../references/lehrer-zhang-sft-orthogonal/notes.md). Prior reviews read for their verdict tables: [REVIEW_r259.md](REVIEW_r259.md), [REVIEW_r260.md](REVIEW_r260.md), [REVIEW_r261.md](REVIEW_r261.md), [REVIEW_r262.md](REVIEW_r262.md).
Scripts: [scripts/reviewers/r263/](../scripts/reviewers/r263/). Reviewer 264 runs the identical brief concurrently and independently; I read none of its files.

Nothing below reuses the reviewed script. $\iota_\lambda$ is **built**, as image$(c_T)\cap\bigcap_{i<j}\ker C_{ij}$ inside $V^{\otimes|\lambda|}$, and $c_0$ is tested as a **map** rather than as one evaluated vector; the module it generates is closed under the **generators** $s_1,\dots,s_{f-1},e_1$ instead of by enumerating $(2f-1)!!$ matchings; $\dim\nu(B_f(n))$ is the rank of the span of the **actual operators** (no Gram, no $n^{\mathrm{loops}}$); and $\dim\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$ comes from the $\mathfrak{so}(n)$ generators plus the reflection $\mathrm{diag}(-1,1,\dots,1)$, with no diagram in it. The block table is read from the record's own [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl).

| # | Claim | Verdict |
|---|---|---|
| 1 | The seed lemma itself | **BOTH HALVES CORRECT, WITH A THIRD HYPOTHESIS THE LEMMA DOES NOT STATE, BINDING WITH ZERO SLACK AT $n=12$.** Equivariance holds and I verified it for the **full** $O(n)$, reflection included, at five non-trivial labels to $3\times10^{-15}$, the reflection is exactly what the $SO$-vs-$O$ gap of r261/r262 turns on. Nonvanishing holds, and the cap computation does prove *the map* nonzero, not merely some contraction: a nonzero composite forces a nonzero factor. It is also far more than needed, $\iota_\lambda\otimes\mathrm{cup}^{\otimes k}\ne0$ because a tensor product of nonzero vectors is nonzero. **Nonzero in $M_\lambda$ and nonzero as a map are the same statement**, $M_\lambda$ *being* $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$; the covariant space $e\,M_\lambda$ is then reached by linearity, already confirmed by r261 and r262. **The missing hypothesis is $O(n)$-admissibility**: *"nonzero for every positive $n$"* is false wherever $\lambda'_1+\lambda'_2>n$, since $\iota_\lambda$ does not exist there, witness $\lambda=(2,2)$ at $n=2,3$ and $\lambda=(2,1,1)$ at $n=3$, where my construction returns $V_\lambda=0$. At $n=12$ it holds for all $71$ blocks, and $\lambda=(2,2,2,2,2,2)$ sits at $\lambda'_1+\lambda'_2=12=n$, **zero slack** |
| 2 | The parity and range conditions | **ALL $71$ BLOCKS CLEAR THE HYPOTHESES; THE CONCLUSION'S WORDING FAILS AT $16$ OF THEM.** Reproduced from the record's own pickle: $77$ $\mathfrak{so}(12)$ weights, $6$ chiral pairs, $\mathbf{71}$ $O(12)$ labels and $\mathbf{184}$ multiplicities exactly. Every label has $\lvert\lambda\rvert$ even and $\le12$ and is admissible, so **zero blocks fail**, the enumeration is $16/22/16/10/5/1/1$ blocks at $\lvert\lambda\rvert=12/10/8/6/4/2/0$. **But $k=0$ at $16$ blocks** ($17$ of the $184$ multiplicities), where $c_0=\iota_\lambda$ and there is no cup at all, so *"every block has an explicit seed which is a **padding diagram**"* is wrong at $16$ of $71$ and the lemma's content there is that an inclusion is nonzero. Separately, [brauer-pairing.md](../findings/brauer-pairing.md) and [findings/INDEX.md](../findings/INDEX.md) say the $n^6$ ceiling is *"attained in the $19$ blocks with $\lvert\lambda\rvert=12$"*, **$19$ is the $SO(12)$ count in a record whose blocks are the $71$ $O(12)$ labels; the $O$ figure is $16$** |
| 3 | The verification | **UNREPRESENTATIVE AS THE BRIEF SUSPECTS, AND THE LEMMA SURVIVES BEING TESTED PROPERLY.** All eight cells use $\lambda=\varnothing$ or $(1)$ and the run never builds an $\iota_\lambda$. I built it for $(2),(1,1),(2,1),(2,2),(3,1)$ and tested $c_0$ as a map at **ten** cells: equivariant, nonzero, and generating **exactly** $m_\lambda(n)$ every time, including deep sub-threshold, $\lambda=(2)$ at $n=2$, $f=6$, generating $15$. Two further defects. *The odd-$f$ cells measure a **vector** orbit, not a map orbit*: `base = np.eye(n)[0]` is $e_0\in V$, not $\iota_{(1)}$. The numbers are right (I get $3,3,10,15$ both ways) but for a reason the run never states, that evaluation at $e_0$ is injective on $M_{(1)}$ because a nonzero equivariant $V\to V^{\otimes f}$ is injective. *`padded_seed` has no parity guard*: `k = (f - m) // 2` floors silently, so `padded_seed(4, 3, e_0)` returns a length-$27$ vector for an $f=4$ slot needing $81$. No tested cell trips it; any added cell of the wrong parity would compare a rank against $m_\lambda(n)$ meaninglessly. The `log(len)/log(n)` inference also divides by zero at $n=1$, the row both prior reviewers added to the sibling script |
| 4 | What the record claims is closed | **THE OVERREACH IS IN THE SCRIPT HEADER AND THE COMMIT SUBJECT; [plan.md](../plan.md) IS HONEST, AND NOTHING TRUE WAS DROPPED.** *"obligation (ii) closes structurally"* and *"The covariants are now **explicit** combinations of diagrams"* claim more than the theorem gives: the chain is seed $\to$ spanning set of $23!!=316{,}234{,}143{,}225$ elements $\to$ existence of a combination. **Exhibiting a given covariant needs the coefficients**, which needs $\dim e\,M_\lambda$ independent members of $\{e\,\nu(D)c_0\}$ found among $3.16\times10^{11}$ and then a change of basis against the constructed weight-space vectors, none of it done, none of it priced, and the file's own *"What stays open"* says so. So the lemma removes the search for a **seed** and leaves the search for an **expansion**. [plan.md](../plan.md) item (ii) is untouched by `e0b9cb0` and still carries the deliverable as owed; `e0b9cb0` is $+19/-0$ on the findings file, so no `ae44228` repeat. Two ledger gaps: [findings/INDEX.md](../findings/INDEX.md) was not updated at all, and its line $40$ still carries the $SO$ *"19 blocks"* |
| 5 | The corrections in `f99e050` and `90ad8d9` | **(a) CORRECT AND UNCONDITIONAL. (b) CIRCULAR AS WRITTEN, ONE WORD FROM SOUND. (c) BOTH APPLIED, AND ONE IS BETTER SOURCED THAN THE REVIEW IT CITES.** (a) Weyl's FFT for $O(n)$ gives surjectivity onto $\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$ at **every** $n\ge1$ in characteristic zero, with no condition, verified at nine cells including the sub-threshold $(4,2)$ at $35$ and $(5,2)$ at $126$, where $\dim\nu$, $\dim\mathop{\mathrm{End}}_{O(n)}$ and $\sum m_\lambda(n)^2$ all coincide; and the $SO$ contrast reproduces at $(f,n)=(2,4)$, $\dim\mathop{\mathrm{End}}_{SO}=4>3=\dim\nu$. (b) *"the upper bound comes from the identity $\dim\nu=\sum m_\lambda(n)^2$, asserted per cell below"* names the **conclusion** as the premise. What is free is the **containment** $\nu(B_f(n))\subseteq\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$ (every $\nu(D)$ is equivariant, no FFT needed), giving the **inequality** $\dim\nu\le\sum m_\lambda(n)^2$; that is what turns a modular lower bound attaining the prediction into a proof. All three quantities computed separately here. (c) The r244 hedge is restored verbatim at [plan.md:70](../plan.md) with r242's own $3\times3$ witness; and $24=\lvert\{2,3,4,5\}\times\{1..6\}\rvert$, $32=\lvert\{2,3,4,5\}\times\{1..8\}\rvert$, so the record's $32$ corrects r259's own *"all 40 pairs"* |
| 6 | Prior findings still unfixed | **THREE STAND.** *(i) r261 claim 1, last sentence*, *"both files still print the old conditional theorem box above the new unconditional paragraph"*. Still true: [brauer-pairing.md:47](../findings/brauer-pairing.md) heads its Theorem with *"$B_{12}(12)$ is semisimple over $\mathbb Q$"* and *"is the irreducible cell module $\Delta_\lambda$"*, and [run_diagram_realisation.py:21](../scripts/runs/run_diagram_realisation.py) with *"(i) B_12(12) is SEMISIMPLE over Q"*, both then called unnecessary two paragraphs below. This is r259's recommendation 1 and r261's recommendation 3, unapplied by three cycles. *(ii) r261 recommendation 6 / r262 claim 4(a)*, the Gram identity's **reason**, positive-definiteness of the Frobenius form. Zero occurrences of *"Frobenius"* or *"positive definite"* in either file. *(iii) r259 recommendation 5's $f=12$ row*, the record asserts *"at $f=12$ the two part company at every $n\le10$ and agree at every $n\ge11$"* and no committed script computes it; the reviewed sibling prints prose there. **It is true** (I computed it, the forms first agreeing at $n=11$ at $316{,}233{,}935{,}213$) and it costs no tensor. Everything else applied: the three stale docstring sentences, the ASWT $\to$ Weyl citation, the modular-rank non sequitur, the $\delta=-2n$ and $\delta_0=0$ note defects, the $r=12$/$r=6$ collision, the slack column, and the item's deliverable |

---

## Claim 1, the seed lemma itself

Evidence: [r263_c1_nontrivial_seed.py](../scripts/reviewers/r263/r263_c1_nontrivial_seed.py), [out_c1.txt](../scripts/reviewers/r263/out_c1.txt).

### Equivariance

$c_0=\iota_\lambda\otimes\mathrm{cup}^{\otimes k}$ is equivariant because $\mathrm{cup}=\sum_a e_a\otimes e_a$ satisfies $(g\otimes g)\,\mathrm{cup}=\mathrm{cup}$ for $gg^{\mathsf T}=I$, and a tensor product of equivariant maps is equivariant. The record's *"closure of the tensor product under equivariant maps"* is the whole proof, and it is right.

**The half worth checking is the group.** $gg^{\mathsf T}=I$ is the defining relation of $O(n)$, not of $SO(n)$, and r261 and r262 both found that the $SO$/$O$ distinction decides the theorem one step later. I therefore tested the **reflection** $R=\mathrm{diag}(-1,1,\dots,1)$, $\det R=-1$, alongside the $\mathfrak{so}(n)$ generators:

| $\lambda$ | $n$ | $k$ | $f$ | $\dim V_\lambda$ | $\mathfrak{so}(n)$ error | reflection error |
|---|---|---|---|---|---|---|
| $(2)$ | 3 | 1 | 4 | 5 | $4.4\times10^{-16}$ | $3.3\times10^{-16}$ |
| $(1,1)$ | 3 | 1 | 4 | 3 | $2.2\times10^{-16}$ | $1.1\times10^{-16}$ |
| $(2,1)$ | 3 | 1 | 5 | 5 | $4.4\times10^{-16}$ | $4.4\times10^{-16}$ |
| $(2,2)$ | 4 | 0 | 4 | 10 | $3.4\times10^{-15}$ | $2.7\times10^{-15}$ |
| $(3,1)$ | 3 | 1 | 6 | 7 | $2.5\times10^{-15}$ | $2.2\times10^{-15}$ |
| $(2)$ | 2 | 2 | 6 | 2 | $1.0\times10^{-15}$ | $6.1\times10^{-16}$ |

Equivariance holds for the full $O(n)$ at every one.

### Nonvanishing, and whether it is the right nonvanishing

The lemma's argument (*"pairing the $k$ cups against $k$ caps returns $n^k\,\iota_\lambda$"*), does prove that **the map** is nonzero, not merely that some contraction of it is: if $\mathrm{cap}^{\otimes k}\circ c_0=n^k\iota_\lambda\ne0$ then $c_0\ne0$, because a composite through a zero map is zero. I confirmed the identity numerically at every case above.

**It also proves much less than it costs.** $c_0$ is a tensor product of two nonzero vectors over a field, so $c_0\ne0$ before any cap is drawn. The $n^k$ is decoration on a one-line fact, in a record that has twice been caught (r258, r260) letting decoration read as content.

**Does nonvanishing in $V^{\otimes12}$ suffice, or must it survive into the multiplicity space?** They are the same statement, and the reason is a definition: $M_\lambda$ **is** $\mathop{\mathrm{Hom}}_{O(n)}(V_\lambda,V^{\otimes12})$, and $c_0$ is an element of it. What is *not* the same statement, and what the theorem actually consumes, is that the seed reaches the **covariant** space $e\,M_\lambda$, and it does, by linearity: $\mathop{\mathrm{span}}\{\nu(D)c_0\}=M_\lambda$ by irreducibility over the image, so $\mathop{\mathrm{span}}\{e\,\nu(D)c_0\}=e\,M_\lambda$ even when $e\,c_0=0$. r261 exhibited that at $(6,4)$ with $\dim e\,M_\lambda=2$ and r262 at four dimensions; I confirm the first half, $\mathop{\mathrm{span}}\{\nu(D)c_0\}=M_\lambda$, at the non-trivial $\lambda$ neither of them had a seed for.

### The hypothesis the lemma does not state

*"IT IS NONZERO FOR EVERY POSITIVE $n$"* is stated with two hypotheses, $\lvert\lambda\rvert\le12$ and $\lvert\lambda\rvert\equiv12\bmod2$. There is a third: $V_\lambda$ must be an $O(n)$-irreducible at the $n$ in question, i.e. $\lambda'_1+\lambda'_2\le n$. Below that there is no $\iota_\lambda$ to pad. My construction finds this without being told, image$(c_T)$ intersected with the traceless kernel is $\{0\}$ at exactly the inadmissible pairs:

| $\lambda$ | $n$ | $\lambda'_1+\lambda'_2$ | $V_\lambda$ |
|---|---|---|---|
| $(2,2)$ | 3 | 4 | $0$ |
| $(2,2)$ | 2 | 4 | $0$ |
| $(2,1,1)$ | 3 | 4 | $0$ |

This is the same omission the record elsewhere insists on, *"at $n=6$ only $77$ of the $160$ labels are $O(n)$-admissible, so $83$ blocks do not exist there"* ([plan.md](../plan.md), [lehrer-zhang notes:43](../references/lehrer-zhang-sft-orthogonal/notes.md)); I reproduce $77$ of $160$ from the up–down recursion. **At $n=12$ the hypothesis holds for all $71$ blocks and is tight**: $\lambda=(2,2,2,2,2,2)$ has $\lambda'_1+\lambda'_2=6+6=12=n$. Zero slack, at the route's own $n$, on a hypothesis the lemma never writes down.

## Claim 2, the parity and range conditions, block by block

Evidence: [r263_c2_blocks.py](../scripts/reviewers/r263/r263_c2_blocks.py), [out_c2.txt](../scripts/reviewers/r263/out_c2.txt).

The record's [n12_sym3_blocks.pkl](../scripts/runs/n12_sym3_blocks.pkl) holds $77$ $\mathfrak{so}(12)$ highest weights summing to $191$ multiplicities. Six carry a negative last entry (the chiral halves of an $O(12)$ irreducible with $\lambda'_1=6=n/2$) and each has the same multiplicity as its partner, so merging gives $\mathbf{71}$ labels and $\mathbf{184}$ multiplicities, the record's own figures, recovered rather than assumed.

| $\lvert\lambda\rvert$ | 12 | 10 | 8 | 6 | 4 | 2 | 0 | total |
|---|---|---|---|---|---|---|---|---|
| $k=(12-\lvert\lambda\rvert)/2$ | **0** | 1 | 2 | 3 | 4 | 5 | 6 | |
| blocks | 16 | 22 | 16 | 10 | 5 | 1 | 1 | **71** |
| multiplicities | 17 | 41 | 60 | 41 | 20 | 3 | 2 | **184** |

**Every block clears every hypothesis.** $\lvert\lambda\rvert$ is even and at most $12$ at all $71$ (forced, since the blocks are labels of $V^{\otimes12}$) and $\lambda'_1+\lambda'_2\le12$ at all $71$, with equality only at $(2,2,2,2,2,2)$. So the construction produces a seed for every block of the table, and the answer to *"only some?"* is **all of them**. That is the claim's strong half and it stands.

### Where it fails is the word "padding"

$k=0$ at the $16$ blocks with $\lvert\lambda\rvert=12$: $(6,6)$, $(6,4,2)$, $(6,2,2,2)$, $(5,5,1,1)$, $(5,4,2,1)$, $(5,3,3,1)$, $(5,3,2,1,1)$, $(4,4,4)$, $(4,4,2,2)$, $(4,4,1,1,1,1)$, $(4,3,3,1,1)$, $(4,3,2,2,1)$, $(4,2,2,2,2)$, $(3,3,3,3)$, $(3,3,2,2,1,1)$, $(2,2,2,2,2,2)$, $17$ of the $184$ multiplicities. There $c_0=\iota_\lambda$, with **no cup anywhere in it**. The commit subject *"the seed is a padding diagram"* and the findings' *"every block has an explicit seed which is a **padding diagram**"* are therefore false at $16$ of $71$ blocks, and at the other $55$ the honest form is the one the script's own body already uses: *"$c_0$ is a diagram acting on $\iota_\lambda$"*. $\iota_\lambda$ is a Young symmetriser with the traces removed; it is not a Brauer diagram, and it is the common prefix of the whole spanning set.

### A counting collision inside the same file

[brauer-pairing.md](../findings/brauer-pairing.md) (*"the ceiling is $n^6$, attained only in the $19$ blocks with $\lvert\lambda\rvert=12$"*) and [FINDINGS.md:40](../findings/INDEX.md) repeat $19$. The $71$-block table has **16**. Nineteen is the count of $\mathfrak{so}(12)$ weights with $\lvert\lambda\rvert=12$: the $16$ $O$-labels, three of which ($ (4,4,1,1,1,1)$, $(3,3,2,2,1,1)$, $(2,2,2,2,2,2)$) split into $\pm$ pairs under $SO(12)$. So the same file counts blocks two ways one section apart (the $71/184$ $O$-count in the realisation section, the $19$ $SO$-count in the pairing section) which is the $77/191$ vs $71/184$ distinction r262 says the record's own numbers exist to make.

## Claim 3, the verification

Evidence: [r263_c1_nontrivial_seed.py](../scripts/reviewers/r263/r263_c1_nontrivial_seed.py), [out_c1.txt](../scripts/reviewers/r263/out_c1.txt), [r263_c3_script_audit.py](../scripts/reviewers/r263/r263_c3_script_audit.py), [out_c3.txt](../scripts/reviewers/r263/out_c3.txt).

### The test is not representative, and the lemma passes the representative one

The run's eight cells use $\lambda=\varnothing$ (even $f$) and $\lambda=(1)$ (odd $f$), the two labels for which no $\iota_\lambda$ has to be built, one being a scalar and the other the identity of $V$. A lemma quantified over $\lvert\lambda\rvert\le12$ is not tested by its two smallest instances, and $16$ of the $71$ blocks it must cover have six rows.

I built $V_\lambda=\mathrm{im}(c_T)\cap\bigcap_{i<j}\ker C_{ij}$ and closed the module under $s_1,\dots,s_{f-1},e_1$, in the space of **maps** $V_\lambda\to V^{\otimes f}$:

| $\lambda$ | $n$ | $k$ | $f$ | $n\ge f-1$ | $\dim\mathop{\mathrm{span}}\{\nu(D)c_0\}$ | $m_\lambda(n)$ |
|---|---|---|---|---|---|---|
| $(2)$ | 3 | 0 | 2 | yes | 1 | 1 |
| $(2)$ | 3 | 1 | 4 | yes | 6 | 6 |
| $(1,1)$ | 3 | 1 | 4 | yes | 6 | 6 |
| $(1,1)$ | 2 | 1 | 4 | **no** | 3 | 3 |
| $(2,1)$ | 3 | 0 | 3 | yes | 2 | 2 |
| $(2,1)$ | 3 | 1 | 5 | **no** | 15 | 15 |
| $(2,2)$ | 4 | 0 | 4 | yes | 2 | 2 |
| $(3,1)$ | 3 | 0 | 4 | yes | 3 | 3 |
| $(3,1)$ | 3 | 1 | 6 | **no** | 29 | 29 |
| $(2)$ | 2 | 2 | 6 | **no** | 15 | 15 |

Ten cells over five non-trivial labels, four of them sub-threshold, four of them with $k=0$ so that the seed is $\iota_\lambda$ bare. **The lemma survives the test it was missing**, and the sub-threshold rows extend the record's evidence (which was $\lambda=\varnothing$ and $\lambda=(1)$ only), to labels with two and three rows.

### The odd-$f$ cells test a different object

`base = np.eye(n)[0]` is $e_0\in V$. The lemma's $c_0$ for $\lambda=(1)$ is $\mathrm{id}_V\otimes\mathrm{cup}^{\otimes k}$, a map; the run measures $\mathop{\mathrm{span}}\{\nu(D)(e_0\otimes\mathrm{cup}^{\otimes k})\}$, a span of **vectors** in $V^{\otimes f}$. Computing both:

| $f$ | $n$ | run's vector orbit | lemma's map orbit | $m_{(1)}(n)$ |
|---|---|---|---|---|
| 3 | 3 | 3 | 3 | 3 |
| 3 | 2 | 3 | 3 | 3 |
| 5 | 2 | 10 | 10 | 10 |
| 5 | 3 | 15 | 15 | 15 |

**The run's numbers are right.** They are right because evaluation at $e_0$ is injective on $M_{(1)}$: a nonzero equivariant $V\to V^{\otimes f}$ is injective since $V$ is irreducible, so no nonzero combination of the $\nu(D)c_0$ kills $e_0$. That argument is nowhere in the file, and it is special to $\lambda=(1)$, for a general $\lambda$ the base would have to be a spanning set of $V_\lambda$, not one weight vector, which is exactly the step the run avoids by never leaving the two smallest labels.

### Two latent defects in `padded_seed`

```
m = int(round(np.log(len(base)) / np.log(n))) if len(base) > 1 else 0
k = (f - m) // 2
```

- **No parity guard.** `padded_seed(4, 3, e_0)` gives $m=1$, $k=1$, and returns a length-$27$ vector where $n^f=81$; `padded_seed(3, 3, [1.0])` returns length $9$ where $n^f=27$. Both silent. The eight tested cells all have $f-m$ even so nothing trips, but an added cell of the wrong parity would rank a shorter vector against $m_\lambda(n)$ and the assert would fire on an artefact rather than on the mathematics.
- **`log(n)` at $n=1$.** A division by zero. $n=1$ is precisely the row r259 and r260 both added to [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py)'s sweep, so it is the natural next cell for this one too.

Both are one line each: assert `(f - m) % 2 == 0` and pass $m$ in rather than inferring it from a float.

## Claim 4, what the record now claims is closed

Evidence: `git show e0b9cb0 --stat`, [plan.md](../plan.md) item 1, [FINDINGS.md:40](../findings/INDEX.md).

### The chain, and where it stops

1. **Lemma**, an explicit nonzero $c_0\in M_\lambda$, per block. *Delivered, at all $71$ blocks (claim 2).*
2. **Realisation theorem**, $\{e\,\nu(D)c_0:D\}$ **spans** $e\,M_\lambda$. *Delivered, confirmed by r259–r262 and again here.*
3. **Obligation (ii)**, *"each of the $184$ constructed covariants is **exhibited** as an explicit combination of Brauer diagrams"*. *Not delivered.*

Step 3 needs the coefficients of a **given** covariant against that spanning set. The set has $23!!=316{,}234{,}143{,}225$ members (I reproduce the figure as $\sum_\lambda(\dim\Delta_\lambda)^2$ at $f=12$), living in a $12^{12}$-dimensional ambient. What is left over after the theorem is: build $\iota_\lambda$ for $71$ labels; find $\dim e\,M_\lambda$ diagrams whose $e\,\nu(D)c_0$ are independent; solve the small system; and match the result against the constructed weight-space vectors, which are a *different* spanning family of the same space. None of that is done and none of it is priced, which is the *"no coefficient bound"* r260 recorded and this file repeats in its own **What stays open**.

**So the header overshoots the body.** *"obligation (ii) closes structurally"* and *"The covariants are now **explicit** combinations of diagrams"* assert exhibition; the theorem gives existence. The lemma's real achievement is narrower and worth stating positively: **it removes the search for a seed, and leaves the search for an expansion.**

### The other direction: nothing true was dropped

`e0b9cb0` is $+19/-0$ on [findings/brauer-pairing.md](../findings/brauer-pairing.md) and adds one new script. It touches neither [plan.md](../plan.md) nor [findings/INDEX.md](../findings/INDEX.md), so the `ae44228` failure mode (a rewrite deleting a live deliverable), does not recur. [plan.md](../plan.md) item (ii) still reads *"BUILD THE COVARIANTS, the item's deliverable"* with the deliverable sentence intact and the structure-theorem qualifier beneath it, and item (i) and the coefficient bound are both still open there. **The plan is the honest document; the overreach is confined to the script header and the commit subject.**

Two gaps in the ledger rather than errors: [findings/INDEX.md](../findings/INDEX.md) has no seed-lemma entry at all, so the index does not carry the cycle's own result; and its line $40$ still carries the $SO$ *"19 blocks"* of claim 2.

## Claim 5, the corrections in `f99e050` and `90ad8d9`

Evidence: [r263_c5_fft.py](../scripts/reviewers/r263/r263_c5_fft.py), [out_c5.txt](../scripts/reviewers/r263/out_c5.txt).

### (a) The FFT is now Weyl's, and Weyl's is unconditional

The record now says *"the classical **First** Fundamental Theorem for $O(n)$, holding at every $n$, with no threshold"*, with ASWT 3.17(b) demoted to a wrong clause. **That attribution is correct.** Weyl's FFT for $O(n)$ in characteristic zero says the $O(n)$-invariants of a system of vectors are generated by the inner products; the tensor form, $\mathrm{Inv}_{O(n)}(V^{\otimes2f})$ spanned by the $\gamma_D$, equivalently $\nu(B_f(n))=\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$, carries **no condition on $n$**. Only *injectivity* of $\nu$ acquires one, $n\ge f$, and the theorem does not use it.

I checked surjectivity three ways per cell, with the commutant computed from $\mathfrak{so}(n)$ generators and one reflection so that no diagram enters it:

| $f$ | $n$ | $n\ge f-1$ | $\dim\nu(B_f(n))$ | $\dim\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$ | $\sum_\lambda m_\lambda(n)^2$ |
|---|---|---|---|---|---|
| 3 | 2 | yes | 10 | 10 | 10 |
| 3 | 3 | yes | 15 | 15 | 15 |
| 4 | 2 | **no** | 35 | 35 | 35 |
| 5 | 2 | **no** | 126 | 126 | 126 |

(with $f=2$, $n=2\ldots6$ all at $3$). Surjectivity holds at the sub-threshold cells, so there is no hidden condition. **And the group matters**: at $(f,n)=(2,4)$, $\dim\mathop{\mathrm{End}}_{SO(4)}(V^{\otimes2})=4$ against $\dim\nu=3$, the same one-dimension gap r261 exhibited from the $\varepsilon$ side, and the reason ASWT's $SO$ statement could never have carried this step.

### (b) The rank certificate is circular as written

[run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) prints:

> *"so agreement among primes is NOT a certificate; the upper bound comes from the identity $\dim\nu=\sum m_\lambda(n)^2$, asserted per cell below."*

and then asserts `got == uni` at all $24$ cells. Read literally that is the defect the same file names two paragraphs earlier: the identity is what the run is testing, so it cannot also be the premise that licenses the test. At $f=5$, where no exact rank is computed, `got` is a modular **lower** bound and the only thing standing between it and the conclusion is the upper bound.

**The repair is a single word, and the sound statement is available for free.** Every $\nu(D)$ is an $O(n)$-equivariant endomorphism (that is immediate from the definition and needs no FFT) so

$$\nu(B_f(n))\subseteq\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f}),\qquad\text{hence}\qquad \dim\nu\;\le\;\sum_\lambda m_\lambda(n)^2,$$

the second step being Schur plus complete reducibility. That is an **inequality**, independent of the FFT, and it closes the sandwich: $\mathrm{rank}_p\le\dim\nu\le\sum m_\lambda(n)^2$, so a modular rank *attaining* $\sum m_\lambda(n)^2$ forces equality throughout, which is also then a **proof of the FFT at that cell**, the run's real content. The table above separates the three quantities and confirms $A\le B$ and $B=C$ at every cell, so the file's numbers are right; what is wrong is the sentence certifying them. r261's recommendation 6 asked for exactly this sandwich and the application wrote it with an equals sign where the inequality belongs.

### (c) The r244 hedge and the pair counts

- **The hedge is back**, verbatim: [plan.md:70](../plan.md) now reads *"r244 prices **the same shape of obligation** at order $\sim89$ … that figure is r244's pricing of $\xi(n)$, the A2′ pivot minor, not of $\det\mathrm{Gram}_S$ itself, whose own r242 witness is a $3\times3$ Gram"*. This is r260's wording plus the correction both r261 and r262 asked for.
- **The counts are right, and better sourced than the review they cite.** The script's sweep is $f\in\{2,3,4,5\}\times n\in\{1,\dots,6\}=\mathbf{24}$; r259's stated grid is $2\le f\le5$, $1\le n\le8=\mathbf{32}$. r259's own prose says *"all 40 pairs"*, which its grid contradicts. So *"$24$ in the script, and independently $32$ in r259's sweep"* corrects the reviewer as well as the record. The Rui note's separate *"all $32$ pairs"* is the **Dickson** sweep over the same grid, a different computation that happens to share the shape, the two $32$s are not the same number, and neither file says which is which.

## Claim 6, prior findings still unfixed

Evidence: [r263_c6_f12row.py](../scripts/reviewers/r263/r263_c6_f12row.py), [out_c6.txt](../scripts/reviewers/r263/out_c6.txt), plus greps recorded below.

### Still standing

**(i) The conditional theorem box.** r259 recommendation 1 (*"restate step (ii) as two sentences"*), r261 recommendation 3 (*"rewrite the theorem box rather than appending below it"*), and r261's verdict line *"both files still print the old conditional theorem box above the new unconditional paragraph"*. Three cycles later:

| file | line | text |
|---|---|---|
| [findings/brauer-pairing.md](../findings/brauer-pairing.md) | 47–49 | *"1. $B_{12}(12)$ is semisimple over $\mathbb{Q}$; 2. … is the irreducible cell module $\Delta_\lambda$ over $B_{12}(n)$"* |
| [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) | 21–23 | *"(i) B_12(12) is SEMISIMPLE over Q; (ii) … is the IRREDUCIBLE cell module Delta_lambda"* |

Both files then say, below, that (i) is not used and that Rui's threshold governs only the cell-module identification. A reader who stops at the box takes away a theorem conditional on $n\ge11$, which is the claim two reviewers refuted.

**(ii) The Gram identity's reason.** r261 recommendation 6 and r262 claim 4(a): the identity $\langle\nu(D),\nu(E)\rangle=n^{\mathrm{loops}(D,E)}$ holds because $n^{\mathrm{loops}}$ is the Frobenius pairing and that form is positive definite. `grep -c 'Frobenius\|positive definite'` over [brauer-pairing.md](../findings/brauer-pairing.md), [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) and [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py) returns **zero**. Both reviewers stated the reason; neither statement reached the record.

**(iii) The $f=12$ row, asserted without a run.** r259 recommendation 5 asked for it and said it costs nothing. [brauer-pairing.md](../findings/brauer-pairing.md) states the conclusion (*"At $f=12$ the two part company at every $n\le10$ and agree at every $n\ge11$"*) and [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) prints two lines of prose at $f=12$ and computes nothing. Both counts are pure combinatorics, so I ran it:

| $n$ | $\sum_\lambda m_\lambda(n)^2$ | $\sum_\lambda(\dim\Delta_\lambda)^2$ |
|---|---|---|
| 8 | 312,896,731,836 | 315,108,918,207 |
| 9 | 315,957,071,241 | 316,125,326,381 |
| 10 | 316,222,167,677 | 316,229,719,418 |
| **11** | **316,233,935,213** | **316,233,935,213** |
| 12 | 316,234,143,225 | 316,234,143,225 |

**The record's claim is true**, first agreement at $n=11$, and both forms reach $23!!=316{,}234{,}143{,}225$ from $n=12$, but nothing in the tree computed it before now. The same script also reproduces $77$ of $160$ labels admissible at $n=6$.

### Applied, and verified applied

| finding | where | status |
|---|---|---|
| r261/r262: three stale docstring sentences (*"Independence is settled"*, *"e itself to be a diagram element"*, *"the SURJECTIVITY half of the SFT"*) | [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py) | fixed by `f99e050` |
| r261/r262: ASWT 3.17(b) is the wrong clause at $n=12$, type $D_6$ | script and [brauer-pairing.md](../findings/brauer-pairing.md) | fixed, Weyl's FFT for $O(n)$, with the $SO(4)$ witness beside it |
| r261/r262: two agreeing primes are a lower bound only | script | fixed, with the $34/353/602$ vs $603$ witness in the output |
| r262: *"all 40 pairs tested"* matches no source | [brauer-pairing.md](../findings/brauer-pairing.md) | fixed to $24$ and $32$, and the $32$ corrects r259 |
| r261/r262: *"r244 prices it"* | [plan.md:70](../plan.md) | fixed, hedge and r242 witness restored |
| r262: rui note ranks after denying that ranking is meaningful | [rui notes:28](../references/rui-brauer-semisimplicity/notes.md) | fixed, *"Both are decoration"* |
| r259: $\delta=-2n$ gives $f\le2n+1$; the *iff* excepts $\delta_0=0$, $d\in\{1,3,5\}$ | [rui notes](../references/rui-brauer-semisimplicity/notes.md) | fixed, both named as corrections |
| r260: $r=12$ and $r=6$ for one object in one file | [lehrer-zhang notes:21](../references/lehrer-zhang-sft-orthogonal/notes.md) | fixed, with the collision recorded |
| r259: drop the slack column, add $r=6+\lvert\lambda\rvert/2$ | [brauer-pairing.md](../findings/brauer-pairing.md), [plan.md](../plan.md) | fixed |
| r259: extend $n$ to $1$ and $f$ to $5$ | script | fixed, six sub-threshold failures |
| r261/r262: item 1's deliverable, and the audit's conclusion (c) | [plan.md](../plan.md) item (ii) | fixed |

One residue, and it is now defensible: [plan.md:55](../plan.md) still reads *"A3 cannot start without it"*, the sentence r262 quoted as carrying the conflation. `90ad8d9` did not touch it. With item (ii) now stating *"A3 consumes the objects, not the theorem"* the preamble's *"it"* reads as the item's product rather than its theorem, so the substance is repaired even though the sentence r262 named is unchanged.

---

## Verdict

**The lemma is true, it covers every block, and it is oversold by exactly one word in two places.**

The mathematics survives every attack I could bring. Equivariance holds for the full $O(n)$, reflection included, at five non-trivial labels the record had never built a seed for; nonvanishing holds and the cap argument proves the right thing; the seed generates all of $m_\lambda(n)$ at ten cells, four of them sub-threshold and three with no padding at all; and the hypotheses clear at all $71$ blocks of the $n=12$ table, reproduced with its $184$ multiplicities from the record's own pickle.

**What is wrong is smaller than the lemma and worth fixing anyway.** *"A padding diagram"* is not what the seed is at the $16$ blocks with $\lvert\lambda\rvert=12$, where there is no padding; at the other $55$ it is a padding diagram acting on $\iota_\lambda$, which is a Young symmetriser with the traces removed and not a diagram. *"Obligation (ii) closes structurally"* claims exhibition where the theorem gives existence over a $3.16\times10^{11}$-element spanning set, the plan file says so and the script header does not. And a third hypothesis, $O(n)$-admissibility, goes unstated in a lemma whose *"for every positive $n$"* is false without it and which binds with **zero slack** at $n=12$.

**The verification is the weakest part.** Eight cells at the two smallest labels, an odd-$f$ branch that measures a vector orbit while the lemma is about a map orbit, and a `padded_seed` that floors an odd leg count in silence. All three are cheap to repair, and the lemma passes when they are.

**What to change.**

1. Add the third hypothesis: $\lambda'_1+\lambda'_2\le n$, tight at $(2^6)$ when $n=12$. Without it *"nonzero at every positive $n$"* is false, and the record already carries the fact three files away.
2. Say *"a padding diagram acting on $\iota_\lambda$"*, and note the $16$ blocks at $\lvert\lambda\rvert=12$ where $k=0$ and the seed is $\iota_\lambda$ bare.
3. Retitle the script and the finding to what is proved: the search for a **seed** is removed; the search for an **expansion** is not. Leave *"obligation (ii) closes"* out until the coefficients exist.
4. Add one non-trivial $\lambda$ to the run ($(2)$ at $n=3$, $f=4$ costs $81\times5$) and pass $m$ into `padded_seed` with a parity assert instead of inferring it from `log(len)/log(n)`.
5. In [run_diagram_realisation.py](../scripts/runs/run_diagram_realisation.py), change *"the upper bound comes from the identity $\dim\nu=\sum m_\lambda^2$"* to the containment $\nu(B_f(n))\subseteq\mathop{\mathrm{End}}_{O(n)}(V^{\otimes f})$ and the **inequality** it gives. The identity is the conclusion.
6. Correct *"the $19$ blocks with $\lvert\lambda\rvert=12$"* to $16$ in [brauer-pairing.md](../findings/brauer-pairing.md) and [FINDINGS.md:40](../findings/INDEX.md), or mark it as the $SO(12)$ count.
7. Apply the three findings still standing from r259 and r261: rewrite the theorem box, state the Frobenius/positive-definiteness reason for the Gram identity, and commit the $f=12$ row, it is five lines of up–down recursion and the record already asserts its answer.
