# REVIEW r252 -- Gate 2, claims 3, 4, 5

Reviewer 252, on [brief31](../plan.md)'s claims 3, 4 and 5. Commits under review: 200d235, 1fe34e0, a380328. Reviewer 251 runs claims 1 and 2 concurrently. Status: **COMPLETE**.

| # | Claim | Verdict |
|---|---|---|
| 3 | The padding transfer needs a projector-free carrier | **WITNESS REPRODUCES, HYPOTHESIS IS SATISFIABLE** -- the record understates: projector-free carriers exist by construction |
| 4 | The retraction of the spanning-set lemma | **RETRACTION CORRECT, REPLACEMENT SHARP, RECORD ACCURATE** -- but r248's own repair does not repair, and the file is right to say so |
| 5 | Record sweep of [plan.md](../plan.md) and [fence-posts.md](../findings/fence-posts.md) | **SIX HITS, IN BOTH DIRECTIONS** -- a struck statement still standing, and a discharged task still open |

Scripts: [c3_carrier.py](../scripts/reviewers/r252/c3_carrier.py) with [output](../scripts/reviewers/r252/out_c3_carrier.txt).

---

## Claim 3 -- the counterexample is real, and it does NOT void the transfer

### The witness reproduces, exactly

Reproduced in two forms, both in [c3_carrier.py](../scripts/reviewers/r252/c3_carrier.py).

| form | result |
|---|---|
| structural analogue, $24\to7$, exact over $\mathbb Q$ | $J_1=I_1+I_2/n$, $J_2=I_1+I_2/7$: rank $2$ at $n=6$, rank $\mathbf 1$ at $n=7$, and $J_1=J_2$ on every sample |
| the real pair $(12,24)$ | $I_1=\mathrm{tr}\,M^3$, $I_2=\mathrm{tr}\,B^3$ at $n=12$: $2\times2$ minor $\ne0$ mod $p=1000003$, so independent over $\mathbb Q$; at $n=24$ the two coincide by substitution |

The mod-$p$ route is a certificate rather than a sample: the Weyl tensors are built over $\mathbb Z$ with denominators cleared, so a nonzero minor mod $p$ is a nonzero integer minor. **r250's counterexample stands as recorded.**

### But the hypothesis it forces is satisfiable, and the construction is two lines

The record leaves "the diagram carriers are still owed" reading as an open threat, since trace removal manufactures exactly the $1/n$ coefficients the witness exploits. That inference does not go through. **The projector can always be moved off the carrier and onto the test tensor, where it is the identity.**

Let $V_n\subseteq(\mathbb R^n)^{\otimes k}$ be the covariant's target -- $\mathcal W_n$, or any block -- with $P_n$ the *orthogonal* projector onto it, and suppose the covariant is $F_c=P_n\circ D_c$ with $D_c$ a projector-free diagram. For any $x\in\mathbb R^C$,

$$\sum_c x_cF_c=0 \iff \forall W:\ P_n\Bigl(\sum_c x_cD_c(W)\Bigr)=0 \iff \forall W,\ \forall U\in V_n:\ \sum_c x_c\langle D_c(W),U\rangle=0,$$

using only that $P_n$ is self-adjoint and $P_nU=U$ on $V_n$. So the covariants are independent **iff** the family

$$G_c(W,U):=\langle D_c(W),U\rangle$$

is independent as functions on $\mathcal W_n\times V_n$ -- and each $G_c$ is a **closed contraction diagram in $W,W,W,U$ carrying exactly the coefficients $D_c$ carries**, with no $1/n$ anywhere. The transfer then applies to $G$, and independence at $12$ gives independence at every $n\ge12$ with no exceptional set.

Checked at $n=5,6$ on six genuine degree-3 carriers, with the projector verified idempotent ($1.7\cdot10^{-16}$), self-adjoint ($1.1\cdot10^{-15}$) and fixing $\mathcal W_n$ ($1.4\cdot10^{-16}$):

| $n$ | $\mathrm{rank}\{P_n\circ D_c\}$ | $\mathrm{rank}\{\langle D_c(\cdot),U\rangle\}$ |
|---|---|---|
| $5$ | $3$ | $3$ |
| $6$ | $3$ | $3$ |

Ranks agree at $3$ out of $6$ carriers, so the check is live: the family carries real relations and the two computations find the same ones. The sharp case is $D_6=g\owedge T(W)$, a pure Ricci-part image of size $\lVert D_6\rVert_\infty=9.8$: the projector kills it ($3.6\cdot10^{-15}$) and so does the pairing ($1.1\cdot10^{-14}$). And $G$ pads exactly -- $\langle D_3(W),U\rangle=-22463129/864$ at $n=5$ and the identical rational at $6$ and $7$ after padding both arguments.

### What is left owed, which is less than the record implies

- The construction needs $D_c$ **reduced** -- a free metric loop is a factor of $n$, which is an $n$-dependent coefficient by another name. That is A2's existing reducedness obligation, not a new one.
- It needs $V_\lambda$ padding-stable. Verified here for $\mathcal W_n$ (Riemann symmetries, first Bianchi and tracelessness all survive padding, exact at $5\to6,7$); owed for the other blocks, and cheap.
- It does not build the $184$ carriers. It removes the reason to think they cannot exist.

### And an $n$-dependent carrier would still cost only a finite set

Even if a carrier family did keep coefficients in $\mathbb Q(n)$: the level-$n$ family restricted to level $12$ is $M(n)=A(n)\pi$ for a fixed projection $\pi$ modulo the level-$12$ relation space, and $\mathrm{rank}\,M(12)=184$ forces some $184\times184$ minor to be a nonzero element of $\mathbb Q(n)$. Its numerator has finitely many roots, so **independence at $12$ gives independence at every $n\ge12$ outside an explicit finite root set** -- decidable by the same Sturm/root-isolation machinery A5 already carries. r250's witness is precisely the smallest instance: the carrier matrix $\begin{pmatrix}1&1/n\\1&1/24\end{pmatrix}$ has determinant $(n-24)/24n$, whose only root is $n=24$.

**Verdict.** The witness is exact and the hypothesis is correctly named. The record's framing -- that the missing carriers are what "stands between the lemma and the $184$ covariants" -- is an **understatement of the transfer's reach**: the projector obstruction dissolves under a self-adjointness move, and the residue is the reducedness debt already on the ledger.


---

## Claim 4 -- the retraction holds, and the record is more careful than the review it applies

Everything below is exact over $\mathbb Q$, in [c4_retraction.py](../scripts/reviewers/r252/c4_retraction.py) with [output](../scripts/reviewers/r252/out_c4_retraction.txt).

### The retraction is correct

$K=\begin{pmatrix}0&1\\1&0\end{pmatrix}$ with $S=\{e_1,e_2\}$: $e_1^{\mathsf T}Ke_1=e_2^{\mathsf T}Ke_2=0$, $S$ spans $\mathbb R^2$, $K\ne0$. **The lemma as written is false and the retraction is right.**

### The replacement condition is correct, and it is the sharp one

The file offers two: a spanning *subspace*, or the rank-one lifts $pp^{\mathsf T}$ spanning $\mathrm{Sym}$. Both are right, and the second is exactly right, because

$$\{K\in\mathrm{Sym}: p^{\mathsf T}Kp=0\ \forall p\in S\}=\mathrm{span}\{pp^{\mathsf T}:p\in S\}^{\perp}.$$

So the implication holds for every $K$ **iff** the lifts span. Measured:

| $S$ | linear rank | lift rank in $\mathrm{Sym}_2$ | annihilator | lemma |
|---|---|---|---|---|
| $\{e_1,e_2\}$ | $2/2$ | $2/3$ | $\dim1$ | **fails**, and the annihilator basis *is* $\begin{pmatrix}0&1\\1&0\end{pmatrix}$ |
| $\{e_1,e_2,e_1+e_2\}$ | $2/2$ | $3/3$ | $\dim0$ | holds |

Linear spanning is identical in both rows; only the lift rank decides. The subspace clause is the special case $S=\mathbb R^d$ -- the lifts of a full subspace span $\mathrm{Sym}_d$, checked at $d=2,3,4$ ($3=3$, $6=6$, $10=10$). Calling the condition **quadratic** rather than linear is the right description.

And the claim that the theorem three paragraphs above needs only *linear* spanning checks out, for the reason the file gives: for $D=AA^{\mathsf T}$ psd, $p^{\mathsf T}Dp=\lVert A^{\mathsf T}p\rVert^2$, so $p^{\mathsf T}Dp=0\iff Dp=0$ -- $0$ violations in $400$ exact trials.

### r248's point is accurately recorded -- and it buys less than r248 claimed

The file's line ("it imposes $Dp=0$, the theorem's CONCLUSION, where the hypothesis is $p^{\mathsf T}Dp=0$") is a faithful transcription of [REVIEW_r248.md](REVIEW_r248.md). Two things about the point itself, both of which cut *toward* the file:

**1. The substitution cannot change a verdict.** By the collapse above, every psd element of the theorem's space $\{D:p^{\mathsf T}Dp=0\}$ already lies in the screen's space $\{D:Dp=0\}$. The two spaces have the **same psd part**, always. Measured on both branches of [run_a2pp_constant_t.py](../scripts/runs/run_a2pp_constant_t.py)'s own samples:

| branch | evaluations span $\mathbb R^3$ | $\{D:Dp=0\}$ | $\{D:p^{\mathsf T}Dp=0\}$ | psd part | verdict changes? |
|---|---|---|---|---|---|
| honest | $3/3$ | $\dim0$ | $\dim\mathbf0$ | $\{0\}$ | **no** |
| plant $p_2=2p_1$ | $2/3$ | $\dim1$ | $\dim3$ | $\begin{pmatrix}4&-2&0\\-2&1&0\\0&0&0\end{pmatrix}$, in both | **no** |

r248's own twisted-cubic data says the same: its psd witness $vv^{\mathsf T}$, $v=2e_0-e_4$, satisfies $v\cdot p=2p_0-p_4=0$ identically, so it sits in the $\dim1$ *linear* annihilator too, not only in the $\dim8$ $t$-space.

**2. So r248's recommendation 2 -- "that single substitution turns the screen from a tautology into a test, without undersampling and without breaking spanning" -- is FALSE for this miniature.** The honest branch's $t$-space is **still zero-dimensional** after the substitution, because the eight samples of $p(a,b)=(a+b,a-b,ab)$ have lifts of rank $6=\dim\mathrm{Sym}_3$. What makes r248's own screen work is not the substitution but the **change of evaluation map**, to a twisted cubic whose lifts fail to span $\mathrm{Sym}_4$ by $3$ dimensions. **[run_a2pp_constant_t.py](../scripts/runs/run_a2pp_constant_t.py) gets this right where r248 does not**: it says "248's construction is what tests the theorem, and porting it here is owed", rather than promising a one-word fix.

### Two small things in the retraction text

- *"the theorem's CONCLUSION"* mislabels $Dp=0$: in the proof it is an intermediate consequence of psd-ness, and the conclusion is $D=0$, hence $d=0$. Inherited verbatim from r248.
- *"the evaluations ... span LINEARLY, which the image of a cubic map does"* states as automatic exactly the hypothesis the file's own docstring marks as **not established** -- independence of the covariant family. It is false of cubic images in general; the plant row above is a cubic image of rank $2/3$. The sentence should read "which independence of the covariants is precisely the statement that it does".

**Verdict: CONFIRMED.** The retraction is correct, the replacement condition is correct and sharp, and the file's record of r248 is accurate.


---

## Claim 5 -- the sweep. Every hit is in [plan.md](../plan.md); [fence-posts.md](../findings/fence-posts.md) is clean

The pattern is uniform and worth naming before the list: **all three commits applied their reviewer to the file under review and to the fence post, and none of them carried the correction into [plan.md](../plan.md)** -- which is the file read forward. r248 already caught this shape twice ("a caveat living in the file and not in the plan"); it recurred three more times in the commits that applied r248.

| # | Where | Direction | What |
|---|---|---|---|
| 5a | [plan.md](../plan.md) §2.1, para 2 | **over** | the struck false statement is still standing |
| 5b | [plan.md](../plan.md) §2.1, last para | **under** | the "concrete next task" was built by r249, and the object it names was refuted |
| 5c | [plan.md](../plan.md) §2.1, para 1 | **over** | the padding step is stated without r250's load-bearing hypothesis |
| 5d | [plan.md](../plan.md) A2″ headline | **over** | still unconditional over three named open hypotheses -- r248's item 6, half-applied |
| 5e | [plan.md](../plan.md) Standing state | **under** | a confirmed result still listed as unaudited |
| 5f | [plan.md](../plan.md) §2.1, para 2 | **under** | r250's dependence certificate, which bears directly on the binding constraint, is absent |

### 5a -- the statement 200d235 says it struck is still in the plan (OVERSTATEMENT)

The commit message of 200d235 opens: *"'THE SECOND PAIRING IS NOT POLYNOMIAL' IS FALSE and is struck."* It was struck from [run_n12_diagram_independence.py](../scripts/runs/run_n12_diagram_independence.py). [plan.md](../plan.md) §2 item 1 still reads:

> the apolar-with-projector pairing is anisotropic but **not** polynomial, $\langle A,A\rangle=\dim\mathcal W_n$, a quartic.

It is self-refuting where it stands -- *not polynomial ... a quartic* -- and it is the single sentence r250 singled out as false. **This is the most serious hit: the record now contains a statement one of its own commits announces as removed.**

### 5b -- the binding constraint's next task was discharged, and points at a refuted object (UNDERSTATEMENT)

[plan.md](../plan.md) §2 item 1 closes: *"the gluing formula is unimplemented, 'the Weyl projector on eight indices is the missing piece' ... **Building that projector is the concrete next task.**"* Against [REVIEW_r249.md](REVIEW_r249.md), applied in 1fe34e0:

| the plan says | r249 established |
|---|---|
| the projector must be built | it **is** built: closed form $P=D\circ C\circ S$, one application at $n=12$ in $0.4$ ms, idempotence $2.7\cdot10^{-16}$, exact trace $1638=\dim\mathcal W_{12}$ |
| nothing about a basis | an orthonormal basis of $\mathcal W_{12}$, $1638$ tensors, built in six seconds, $\lVert Q^{\mathsf T}Q-I\rVert=3.3\cdot10^{-14}$ |
| *"the Weyl projector on eight indices"* is the object wanted | the 8-index dense form is **the wrong object** at $n=12$ -- $3.20$ GB, $>22$ GB exact, each contraction a $17.8$ Tflop matmul. $P$ must be a callable applied matrix-free |

So the plan understates what exists **and** aims the binding constraint at the object r249 refuted. The item's next task should now read: expand the matrix-free $P$ in the Brauer algebra $B_4(n)$ and emit diagrams rather than weight-space vectors.

### 5c -- the padding step, stated without its hypothesis (OVERSTATEMENT)

[plan.md](../plan.md) §2 item 1: *"**and padding then gives every $n\ge12$ free** (reviewer 247)"*. Two departures from the record:

- r250 named a **load-bearing hypothesis** -- the carrier must be a projector-free diagram -- and 200d235 put it in fence post F32. The plan sentence, which is the one the item's whole finiteness argument rests on, does not carry it. (My claim 3 finds the hypothesis satisfiable, which makes the sentence *recoverable*, not *already correct as printed*.)
- The attribution is to r247. The step was **confirmed** by [REVIEW_r250.md](REVIEW_r250.md), exactly, with the direction identified and the converse falsified.

### 5d -- A2″'s headline, half-corrected (OVERSTATEMENT, standing)

[REVIEW_r248.md](REVIEW_r248.md)'s "what to change" item 6 asked for two fixes to A2″: restore the parametrisation-relativity note, and give the headline its three hypotheses. a380328 applied the first. The headline still reads *"the negative side is finitely certifiable"* unconditionally, over a body naming independence, nullity-constancy and separation as open. r248 graded that "one notch softer than the 'decidable' headline r246 refuted, and the same shape". **It is the third consecutive cycle in which this headline has been corrected and has stayed too strong.**

### 5e -- a confirmed result filed as unaudited (UNDERSTATEMENT)

[plan.md](../plan.md) Standing state: *"**Unaudited, marked:** independence-transfers-upward; the covariant no-free-loop question; ..."*

- **independence-transfers-upward** is r250's claim 3, **CONFIRMED** with exact checks (padding lands in $\mathcal W_n$ for $5\to6,7,9$ and $6\to8$; reduced diagram values identical; free loops rescale by $(n/m)^L$). It is audited, and this review re-derives it.
- **the covariant no-free-loop question** is still unaudited as a lemma, but r250 showed it is **not a hypothesis of the step that cites it** -- a free loop contributes a nonzero scalar. A debt that blocks nothing should say so.

### 5f -- the dependence certificate is missing where it is useful (UNDERSTATEMENT)

200d235 records in the script that a rank-deficient projector-free Gram **certifies dependence** on $\mathcal W_n$ -- sound one way, cheap, and needing no projector at all. [plan.md](../plan.md) §2 item 1 keeps only the negative half ("lives on the ambient tensor space"). Since item 1 is the binding constraint and is precisely an independence question, a sound and cheap *dependence* pruner belongs in it. (The certificate claim itself is reviewer 251's claim 1; I record only that the plan omits it.)

### What is clean

[findings/fence-posts.md](../findings/fence-posts.md) post F32's edit is **faithful** to [REVIEW_r250.md](REVIEW_r250.md) on both points -- the step-1 non sequitur and the projector-free carrier hypothesis -- and neither overstates nor understates it. One cosmetic defect: the sentence now carries r250's findings and still closes *"Reviewer 232."*


---

## Summary

**Claim 3.** r250's counterexample reproduces exactly, and the hypothesis it forces is **satisfiable**. If a covariant is $P_n\circ D_c$ for a projector-free $D_c$, then pairing with a test tensor $U\in V_n$ kills the projector by self-adjointness, and $\langle D_c(W),U\rangle$ is a projector-free closed diagram in $W,W,W,U$ with the same coefficients -- checked at $n=5,6$ on six real carriers, including the sharp one the projector annihilates, and shown to pad exactly. The record's framing of the missing carriers as what stands between the lemma and the $184$ covariants **understates the transfer's reach**; the residue is the reducedness debt already on the ledger. And even a genuinely $n$-dependent carrier costs only a finite computable root set, of which r250's witness is the one-point instance $(n-24)/24n$.

**Claim 4.** The retraction is correct, the replacement condition (rank-one lifts spanning $\mathrm{Sym}$) is correct and **sharp**, and the file's record of r248 is accurate. Two corrections run against **r248**, not against the file: the $Dp=0\to p^{\mathsf T}Dp=0$ substitution cannot change any psd verdict, because psd-ness makes the two conditions identical; and r248's "single substitution turns the screen from a tautology into a test" is false here -- the honest branch's space stays $0$-dimensional, since those samples' lifts already span $\mathrm{Sym}_3$. What r248's own screen needed was the change of evaluation map, and [run_a2pp_constant_t.py](../scripts/runs/run_a2pp_constant_t.py) says so where r248 does not.

**Claim 5.** Six hits, all in [plan.md](../plan.md), three each way. The worst are 5a -- the "not polynomial" statement that 200d235's message announces as struck is still standing, self-refuting, in the plan -- and 5b, where the binding constraint's *"concrete next task"* was discharged by r249 and the object it names was refuted by the same review. [fence-posts.md](../findings/fence-posts.md) is faithful.

**One structural observation.** All six hits share a mechanism: the corrections landed in the file under review and in the fence post, and none reached the plan. That is the failure mode r248 named, recurring inside the commits that applied r248. A cheap guard: whenever a commit strikes a statement, grep the repository for it before closing.
