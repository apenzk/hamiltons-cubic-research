# Review r313, Gate 2 audit of six claims

Reviewer 313, adversarial, cold brief. Everything below was recomputed from the mathematical definitions in a fresh library, [r313_lib.py](../scripts/reviewers/r313/r313_lib.py); no repository script is imported and no repository number was taken on trust. Calibration: the padded $\mathbb{CP}^2$ operator built by hand at $n=4$ returns $\lVert W\rVert^2=1$, $\mathop{\mathrm{tr}}W^3=0.4082483=1/\sqrt6$, $\langle W,W^\#\rangle=0.8164966=2/\sqrt6$ and $Q(W)-\theta W$ at $2.7\times10^{-16}$ with $\theta=\sqrt{3/2}$, which fixes the sharp normalisation against the record's own exact $n=5$ datum. $\dim\mathcal W_n$ reproduces $n(n+1)(n+2)(n-3)/12$ at $n=4,5,6,8,10,12,13$.

| claim | verdict |
| --- | --- |
| M1, Lemma L69 | **CONFIRMED as a statement; the proof's assembly is GAPPED and is repaired here** |
| M2, the B1 resolution | **CONFIRMED**, all three parts, to the digit |
| M3, the off-locus cushion | **CONFIRMED**; the push is **UNDECIDED** |
| M4, the endgame's positivity step | **REFUTED in its restricted form too**, by a witness at $\theta=\sqrt{3/2}$ exactly |
| M5, the two closed routes | **CONFIRMED closed**, but one of the two arguments for closing is itself **REFUTED** |
| M6, where the violation lives | **CONFIRMED at the recorded grading, and REFUTED as a property of the point** |

---

## M1, Lemma L69

### The arithmetic: CONFIRMED, and independently of the $\lVert W\rVert^2\le\tfrac16$ reformulation

With $f(m)=\tfrac m{8(m-1)}=\tfrac18\bigl(1+\tfrac1{m-1}\bigr)$, the condition $f(p)+f(q)-f(n)\le\tfrac16$ is $\tfrac18\bigl(1+X\bigr)\le\tfrac16$ with $X:=\tfrac1{p-1}+\tfrac1{q-1}-\tfrac1{n-1}$, i.e. $X\le\tfrac13$. Then $p=2$ gives $X>1$, $p=3$ gives $X>\tfrac12$, $p=4$ gives $X=\tfrac13+\tfrac1{q-1}-\tfrac1{n-1}>\tfrac13$ for every $n$ since $q-1=n-5<n-1$, and $p=5$ gives $\tfrac5{(n-6)(n-1)}\le\tfrac1{12}$, i.e. $n^2-7n-54\ge0$, i.e. $n\ge\tfrac{7+\sqrt{265}}2=11.639\ldots$, i.e. $n\ge12$. All four steps hold.

Rather than trust the reformulation, I tested the arithmetic against $\theta$ computed from my own $Q$. For every split at $n=8,\dots,18$ and $n=24$ I built the unique $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$-invariant Weyl tensor, checked $Q(W)=\theta W$ (residual $\le9\times10^{-16}$ throughout), and compared. **The equivalence $X\le\tfrac13\iff\theta\ge\sqrt{3/2}$ holds with zero disagreements over all 60 splits tested** ([r313_m1.py](../scripts/reviewers/r313/r313_m1.py)). At $n=12$ the survivors are exactly $(5,7)$ at $1.228239158$ and $(6,6)$ at $1.236033081$; at $n=11$ the best split $(5,6)$ sits at $1.217161239<\sqrt{3/2}$. So $n\ge12$ is exact, not merely sufficient.

### The assembly: the correspondence the proof invokes is NOT established

The proof's first sentence is *"an equivariant graded point is the Weyl operator of a compact symmetric space, so the recorded classification applies"*, and the lemma's own "what it inherits" paragraph names [Lemma L8](../findings/graded-half.md) as the supplier. That is circular in two ways.

- **Lemma L8 assumes the correspondence rather than supplying it.** Its content is a $\theta$ formula in terms of $(\dim\mathfrak k,\dim\mathfrak m)$ *given* that the point is indexed by a symmetric pair; it derives no such indexing from criticality plus equivariance.
- **The same file already records that the two indexings are different objects.** Correction 5 of the Reviewer 15 block says it outright: graded critical points here are indexed by symmetric pairs $(\mathfrak h,\mathfrak k)$ with $\mathfrak h\subseteq\mathfrak{so}(n)$, while the classification being cited is a classification of symmetric *spaces*, whose isotropy sits in $\mathfrak{so}(n)$ only under an extra hypothesis. Lemma L69 uses the arrow Correction 5 warns is not available, in the harder direction.

The gap is real but the statement survives, by a route that never mentions symmetric spaces.

### The repair: classify the gradings, not the spaces

A grading is a $\mathbb Z_2$-grading of $\mathfrak{so}(n)$, so $\mathfrak p$ is the fixed algebra of an involution, and for $n\ne8$ those are classified without residue: $\mathfrak p=\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ with $k+l=n$, or $\mathfrak p=\mathfrak u(n/2)$ for $n$ even. There are **no exceptional pairs to exclude**, the exceptional symmetric spaces never enter, because they are not gradings of $\mathfrak{so}(n)$. Triality supplies extra involutions only at $n=8$, which is below the threshold.

The load-bearing computation is then this: **for every one of those gradings the space of $\mathrm{ad}(\mathfrak p)$-invariant Weyl tensors is exactly one-dimensional.** Since $Q$ is $SO(n)$-equivariant and maps $\mathcal W_n$ into itself, $Q(W)$ lies in that same line, so *every* unit invariant Weyl tensor is automatically critical, and there is exactly one up to sign. Measured ([r313_m1b.py](../scripts/reviewers/r313/r313_m1b.py), [r313_m1c.py](../scripts/reviewers/r313/r313_m1c.py)):

| $n$ | $\mathfrak p$ | $\dim\mathrm{Inv}(\mathcal W_n)$ | $\theta$ of the generator | criticality residual |
| --- | --- | --- | --- | --- |
| 12 | $\mathfrak{so}(1)\oplus\mathfrak{so}(11)$ | $0$ | (|), |
| 12 | $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ | $1$ | $1.228239158$ | $9.1\times10^{-15}$ |
| 12 | $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$ | $1$ | $1.236033081$ | $1.1\times10^{-14}$ |
| 12 | $\mathfrak u(6)$ | $1$ | $0.924962462=\sqrt{77/90}$ | $2.9\times10^{-15}$ |
| 13 | $\mathfrak{so}(5)\oplus\mathfrak{so}(8)$ | $1$ | $1.235828761$ | $8.4\times10^{-15}$ |
| 13 | $\mathfrak{so}(6)\oplus\mathfrak{so}(7)$ | $1$ | $1.248375568$ | $8.1\times10^{-15}$ |

with the same answer at every split at $n=8,10,12,13$. The $\mathfrak u(m)$ generator reproduces the $\mathbb{CP}^m$ closed form $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$ at $m=4,5,6$, confirming [Correction 2](../findings/graded-half.md) that this family is $\mathbb{CP}^m$ and not $SO(2m)/U(m)$.

For $\mathfrak{so}(k)\oplus\mathfrak{so}(l)$ the one-dimensionality is provable in one line at every $n$, and worth recording: $\mathrm{ad}(\mathfrak p)$-invariant symmetric operators on $\Lambda^2$ are $a\Pi_{\mathfrak{so}(k)}+b\Pi_{\mathfrak{so}(l)}+g\Pi_{\mathfrak m}$, which is a **diagonal** operator, so first Bianchi is automatic and Ricci-flatness is the two row-sum equations $(k-1)a+lg=0$ and $(l-1)b+kg=0$, three parameters, two independent conditions, one dimension. (At $k=4$ the adjoint of $\mathfrak{so}(4)$ splits and there are four parameters, but the extra one is exactly the $\Lambda^4(\mathbb R^4)$ direction that first Bianchi kills, so the count is unchanged; at $k=1$ the system forces $W=0$, which is the $\dim=0$ row above.)

### What this settles about the brief's four sub-questions

- **Multi-factor products are excluded before any $\theta$ estimate.** The isotropy of $S^{n_1}\times S^{n_2}\times S^{n_3}$ is not a symmetric subalgebra of $\mathfrak{so}(n)$; for the coarser grading $\mathfrak{so}(n_1+n_2)\oplus\mathfrak{so}(n_3)$ that does contain it, Schur kills equivariance, since $W$ restricted to $\mathfrak{so}(n_1+n_2)$ is $a\Pi_1+b\Pi_2$ and the adjoint of $\mathfrak{so}(n_1+n_2)$ is irreducible. So multi-factor products are graded and never equivariant.
- **Non-sphere factors likewise.** $\mathbb{CP}^a\times\mathbb{CP}^b$ and friends fail the same Schur test. The proof's reducible step, which argues them away through $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$, is correct as far as it goes, $B>0$ strictly for every partition with $k\ge2$, so a single non-spherical irreducible factor pushes the total past $\tfrac16$, but it is not the reason those points are absent.
- **Exceptional pairs do not exist** in the grading classification, so nothing is owed there.
- **Odd $n$ behaves better, not worse.** $\mathfrak u(n/2)$ requires $n$ even, so at odd $n$ the equivariant graded points are exactly the sphere products, and the same arithmetic gives $p,q\ge5$ and $n\ge12$. Verified at $n=13,15,17$: the smallest surviving $p$ is $5$ at each, with $(4,n-4)$ failing at $X=0.375000$, $0.361905$, $0.354167$ against $\tfrac13$.

**Verdict M1: the statement is CONFIRMED, and the "new step" arithmetic is CONFIRMED independently. The proof as written rests on an unestablished correspondence that its own file elsewhere warns against; the repair above proves the same conclusion without it and should replace the first sentence of the proof.**

---

## M2, the B1 resolution

I rebuilt the $C_5$ blow-up from scratch at $n=10$ by solving the block-constant criticality equation $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$ on the three classes (same block / adjacent / non-adjacent) with zero row sums: $x=0.29814240$, $y=-0.14907120$, $z=0.07453560$, $\theta=0.670820393250=\sqrt{0.45}$, criticality residual $1.0\times10^{-15}$ ([r313_m2.py](../scripts/reviewers/r313/r313_m2.py)). Its full-space $\lambda_{\max}(L_e\vert_{W^\perp})=1.206011330$.

**(a) CONFIRMED.** With $D_A$ the anticommutator action $X\mapsto AX+XA$ on $\Lambda^2$ and $H_A=D_AW+WD_A$, **all 54 directions of $\mathrm{Sym}_0(\mathbb R^{10})$ leave $\mathcal W_{10}$**, by $7.62\%$ to $50.00\%$ of norm with median $31.62\%$, the record's $7.6\%$ to $50\%$, median $32\%$, on the nose.

**(b) CONFIRMED exactly.** Projecting each $H_A$ back, stripping the radial component and compressing $L_e$ onto the image reproduces the recorded table with the recorded multiplicities:

$$0^{\times10},\quad 0.412281^{\times20},\quad 0.441754^{\times2},\quad \tfrac23^{\times20},\quad 0.820541^{\times2}.$$

The $T^5$-invariant part of $\mathrm{Sym}_0$ is **four**-dimensional (the five block indicators sum to $I$), and its compression carries exactly $\{0.441754^{\times2},\,0.820541^{\times2}\}$. The fifth direction $A=I$ gives $H_I=4W$ **exactly** with Rayleigh quotient $1$, the radial direction Lemma L24 excludes. Every element of the record's account here is right.

**(c) CONFIRMED.** $\lVert(I-\Pi)L_e\Pi\rVert=1.244736$ on the projected image, against the record's $1.245$. The image is not $L_e$-invariant, so the five numbers are **compression Rayleigh quotients and not eigenvalues of $L_e$**.

**The consequence, settled.** Any statement of the form "$L_e$ has one eigenvalue on each isotype of this image" is wrong as stated, and the mechanism is visible: $A\mapsto\Pi_{\mathcal W}H_A$ is equivariant for the isotropy of $W$, so the image is a submodule, but where an isotype of $\mathcal W_n$ has multiplicity above one the image is a *proper* submodule of it, and $L_e$ moves vectors out of the image while staying inside the isotype. The record's own $\mathrm{Sym}_0(\mathbb R^8)$ observation (a single isotype of multiplicity $35$ on which $L_e$ takes eight distinct values), is the same phenomenon.

**And the certificate use is unaffected.** $L_e$ is self-adjoint on $\mathcal W_n$ and $\lambda_{\max}(L_e\vert_{W^\perp})=\max\{\langle v,L_ev\rangle:\lVert v\rVert=1,\ v\perp W\}$, so *any* Rayleigh quotient of a vector in $W^\perp$ is a lower bound, whether or not the subspace it comes from is invariant. A compression eigenvalue is the Rayleigh quotient of an actual vector, so **a compression value above $\tfrac12$ does bound $\lambda_{\max}$ from below and does certify failure of Lemma L24's condition.** Here $0.820541\le1.206011$, as it must be.

---

## M3, the off-locus cushion

All four r305 files were re-verified from definitions ([r313_m3.py](../scripts/reviewers/r313/r313_m3.py)), then re-polished with a hand-written Gauss–Newton on `numpy.lstsq`.

| point | $\lVert W\rVert^2$ | dist to $\mathcal W_8$ | $\theta$ | residual as stored | residual after my polish | $\Delta$ | $\lambda_{\max}(L_e)$ | $\dim\ker T$ | simple-eigenvector ranks |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| witness (seed 9015) | $1.000000000000$ | $6.2\times10^{-16}$ | $1.088948052505$ | $1.5\times10^{-11}$ | $4.1\times10^{-16}$ | $1.512230534$ | $0.608885447$ | $0$ | $[4]$ |
| seed 9018 | $1.000000000000$ | $5.8\times10^{-16}$ | $1.081549248013$ | $1.1\times10^{-11}$ | $4.8\times10^{-16}$ | $2.400930266$ | $0.562754632$ | $0$ | $[2,4,6]$ |
| seed 9033 | $1.000000000000$ | $5.5\times10^{-16}$ | $1.079758865610$ | $1.2\times10^{-11}$ | $6.8\times10^{-16}$ | $2.762849577$ | $0.553480567$ | $0$ | $[2,6]$ |
| ratio_lt1 | $1.000000000000$ | $5.6\times10^{-16}$ | $1.079098984360$ | $7.7\times10^{-16}$ |, | $1.239250302$ | $0.555212538$ | $\mathbf1$ | $[6]$ |

Every recorded figure is reproduced. Two things the table settles beyond the brief:

- **The two new points are no longer provisional.** Polishing moves them by $\sim10^{-4}$ in norm and lands at residual $5\times10^{-16}$; $\theta$, $\Delta$ and $\lambda_{\max}$ are unchanged to nine digits. The margins $0.562755/0.5=1.1255$ and $0.553481/0.5=1.1070$ stand at machine precision, so **the off-locus cushion is $1.1070\times$ and the record's caveat can be dropped.**
- **The padding exclusion is right and the certificate is the right one.** The frame-independent test is the support operator $T_{ip}=\sum_{jkl}W_{ijkl}W_{pjkl}$, which transforms as a symmetric $2$-tensor, so $\ker T\ne0$ is an $O(n)$-invariant statement of "this is a padding of a lower-dimensional tensor". It is $0$-dimensional at the three genuine points and **exactly one-dimensional at `ratio_lt1`**, whose $\Lambda^2$ spectrum carries the seven zeros a padding from $\mathbb R^7$ must have. Non-diagonality is certified frame-independently too, by the rank of a bivector spanning a multiplicity-one eigenspace: rank $4$ at the witness, ranks $4$ and $6$ at 9018, rank $6$ at 9033.
- A useful control that also passes: $\sum_\gamma g_\gamma=28=4(n-1)$ exactly at all four points.

**The push: UNDECIDED.** I found no non-diagonal $\Delta>0$ critical point with $\lambda_{\max}(L_e)\le\tfrac12$, and my search is too weak to be evidence. Gauss–Newton from unbiased random starts at $n=8$ fails to converge (residual $\sim0.45$ after 60 steps); prefacing it with the power iteration $W\mapsto Q(W)/\lVert Q(W)\rVert$ converges reliably but only to *attracting* critical points, and all $30$ hits were $\Delta=0$: $27$ landings on padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$ with $\lambda_{\max}=\tfrac12$ exactly, and $3$ on a support-$6$ point at $\theta=1.095445115$. **A hunt for V3 counterexamples must not use a method whose fixed points are the stable ones**, since V3 asserts precisely that $\Delta>0$ points are unstable, the method cannot reach the class it is meant to test. That is a methodological note the record's own hunts should carry.

---

## M4, the endgame's positivity step

### The $SO(10)$-conjugate: numbers CONFIRMED, mechanism REFUTED

I rebuilt the conjugate at three independent random $g\in SO(10)$ ([r313_m4.py](../scripts/reviewers/r313/r313_m4.py)):

| object | $\theta$ | residual | $\dim\mathfrak m$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{mpp}}=S_{\mathfrak{hhm}}$ | $S_{\mathfrak{hmm}}$ | $S_{\mathfrak{hhh}}$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| the $C_5$ blow-up itself | $0.670820393$ | $1.3\times10^{-16}$ | $20$ | $0$ | $80.000000$ | $120$ | $120$ |
| conjugate, seed 11 | $0.670820393$ | $3.0\times10^{-16}$ | $20$ | $4.8\times10^{-29}$ | $80.000000$ | $120$ | $120$ |
| conjugate, seed 22 | $0.670820393$ | $2.7\times10^{-16}$ | $20$ | $6.2\times10^{-29}$ | $80.000000$ | $120$ | $120$ |
| conjugate, seed 33 | $0.670820393$ | $3.0\times10^{-16}$ | $20$ | $6.4\times10^{-29}$ | $80.000000$ | $120$ | $120$ |

with $\dim\mathfrak m=20<\lfloor n^2/4\rfloor=25$. Every recorded number is right. **But the conjugation does no work.** $S_{\mathfrak{mmm}}$ and $S_{\mathfrak{hhm}}$ are built from the spectral splitting and the structure tensor, both $O(n)$-equivariant, so they are $O(n)$-invariants of $W$; the row above shows the undisturbed diagonal blow-up already carrying the same three numbers. The counterexample is simpler than the record presents it, and "generic conjugate" should be struck.

### The two senses of "graded" are being mixed, and the counterexample only works in one of them

Under the brief's definition ($\mathfrak{so}(n)=\mathfrak p\oplus\mathfrak m$ a symmetric-pair grading preserved by $W$), **the $C_5$ blow-up is graded**: it is diagonal, so $\Lambda^2(g)$ is diagonal for every $g=\mathop{\mathrm{diag}}(\pm1)$ and commutes with it. I count **511** coordinate involutions commuting with it, one for every split. Since gradedness is $O(n)$-invariant, its conjugates are graded too. So the point refutes "ungraded $\Rightarrow S>0$" only under the *spectral* reading of ungraded, $S_{\mathfrak{hhm}}\ne0$ with $\mathfrak h=E_{\ge0}$, which is a different predicate from the one Lemma L69 and [C3](../plan.md) are stated over. **Every ungraded/graded claim in the record needs to say which predicate it means**, and the two are not interchangeable: diagonality implies graded in the grading sense and implies nothing in the spectral sense.

### The restricted premise is FALSE as well, and the witness is already on the record

The record leaves open: *every ungraded critical point with $\theta\ge\sqrt{3/2}$ has $S>0$.* On the record's own spectral reading of both words, **it is false**, and the witness is the padded $\mathbb{CP}^2$ operator, which [nondegeneracy.md](../findings/nondegeneracy.md) already carries as an "$S=0$ yet ungraded" example without the connection being drawn:

| $n$ | $\theta$ | criticality residual | $\dim\mathfrak m$ | $S_{\mathfrak{mmm}}$ | $S_{\mathfrak{hhm}}$ |
| --- | --- | --- | --- | --- | --- |
| 8 | $1.224744871392$ | $2.7\times10^{-16}$ | $2$ | $0$ exactly | $16=4(n-4)$ |
| 10 | $1.224744871392$ | $2.7\times10^{-16}$ | $2$ | $0$ exactly | $24$ |
| 12 | $1.224744871392$ | $2.7\times10^{-16}$ | $2$ | $0$ exactly | $32$ |
| 14 | $1.224744871392$ | $2.7\times10^{-16}$ | $2$ | $0$ exactly | $40$ |

$\theta=\sqrt{3/2}$ **exactly**, so the point lies in $\{\theta\ge\sqrt{3/2}\}\cap\mathrm{Crit}$ (the set is closed at its own boundary, which is where the counterexample sits) and $\inf S=0$ there. The route's constant $c$ is $0$ and the chain yields nothing. Rescuing it needs $t>\sqrt{3/2}$ strictly, which is a different and unmotivated hypothesis, since $\sqrt{3/2}$ is exactly the threshold the programme is trying to reach.

### A second hole in the same step

The compactness argument needs $S$ **continuous** on $\{\theta\ge t\}\cap\mathrm{Crit}$ to attain its minimum. $S_{\mathfrak{mmm}}$ is built from $\mathfrak m=\mathop{\mathrm{span}}\{v_\alpha:\lambda_\alpha<0\}$, which jumps in dimension wherever an eigenvalue of $W$ crosses zero, the record's own tolerance episode ($\dim\mathfrak m$ ranging over $\{3,\dots,9\}$ with $S_{\mathfrak{mmm}}$ over $[0,19]$ on one matrix) is that discontinuity showing up numerically. **So the step needs either a continuity proof on the relevant stratum or a continuous surrogate for $S$**, and neither is on the record.

**Verdict M4: the recorded counterexample is CONFIRMED and simplifies; the premise the record leaves open is REFUTED at $\theta=\sqrt{3/2}$; and the compactness step carries a second, unstated continuity hypothesis. The route is dead as written.**

---

## M5, the two closed routes

### (i) The mass route stays closed, but the argument for closing it is wrong in its key step

The equivariant closed form and its Cauchy–Schwarz reading check out exactly at $S^3\times S^5$: $\lVert A\rVert^2=0.619048=13/21=\dim\mathfrak p/\binom{n-1}2$, block traces $1.195229$ on both factors, floor $1.195229^2/3+1.195229^2/10=0.476190+0.142857=0.619048$, saturated.

**The refuted step.** [graded-half.md](../findings/graded-half.md) states that the witness's positive eigenspace is not closed under bracket, "at the witness they are $3.6\times10^{-1}$, $2.0\times10^{-1}$, $1.4\times10^{-1}$", and concludes that $0.624926$ is a spectral split rather than a grading block, overturning Reviewer 308. **It is closed.** With $\mathfrak h=E_+$ ($\dim13$, no zero eigenvalues at this point) and $\mathfrak m=E_-$ ($\dim15$), computed twice, once through the structure tensor and once through raw matrix commutators,

$$S_{\mathfrak{hhm}}=7.06\times10^{-29},\qquad S_{\mathfrak{mmm}}=6.23\times10^{-29},\qquad S_{\mathfrak{hhh}}=66,\qquad S_{\mathfrak{hmm}}=90,$$

with the marginal identity $S_{\mathfrak{mmm}}+3S_{\mathfrak{hmm}}+3S_{\mathfrak{hhm}}+S_{\mathfrak{hhh}}=336=2N(n-2)$ exact. So $E_+$ **is** a symmetric-pair grading of $\mathfrak{so}(8)$ of type $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, and I locate it directly: among the gradings I find, one has $\lVert\Pi_{\mathfrak p}-\Pi_{E_+}\rVert=0.000000$ and $\lVert W\vert_{\mathfrak p}\rVert^2=0.624926=\sum_{\lambda>0}\lambda^2$. **Reviewer 308 was right on this point and the record's rebuttal should be withdrawn.**

**The closure survives for a stronger reason.** The witness does not have *a* grading; it has many. Scanning $\mathrm{Gr}(3,8)$ for $g$ with $[\Lambda^2(g),W]=0$ ([r313_gradscan.py](../scripts/reviewers/r313/r313_gradscan.py)) returns at least **eight** inequivalent $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$ gradings, and the quantities the mass route wants to compare are different on each:

| $\lVert A\rVert^2$ | $\mathop{\mathrm{tr}}A\vert_{\mathfrak{so}(3)}$ | $\lVert \mathfrak p\text{-cross}\rVert^2$ |
| --- | --- | --- |
| $0.319349$ | $-0.043202$ | $0.020715$ |
| $0.332496$ | $-0.214821$ | $0.020715$ |
| $0.494478$ | $-0.080453$ | $0.082859$ |
| $0.494632$ | $0.206114$ | $0.082859$ |
| $0.623201$ | $-0.143261$ | $0$ |
| $0.624926$ ($=E_+$) | $1.082996$ | $0$ |
| $0.651065$ | $0.453193$ | $0.082859$ |
| $0.808897$ | $0.199975$ | $0$ |

The witness has $\dim\mathfrak k(W)=5$, so each of these is a whole continuous family. The equivariant value $0.619048$ sits **inside** this range, with four gradings below it and three above. **So no inequality $\lVert A\rVert^2\ge\lVert A_{\mathrm{equiv}}\rVert^2$ can hold, for any choice of grading convention**, the record's conclusion, reached by a firmer route than "the block traces are not invariants of the pair". **CONFIRMED closed.**

### (ii) The cross-block route: CONFIRMED closed

Reproduced exactly at the grading the record used: $\mathfrak p$-internal cross-block mass $0.020715$, **$57.7\%$ of it outside $\mathcal W_8$** ($1/\sqrt3$ to six digits, and the same $57.7\%$ in every grading and at both new points, so it is structural rather than incidental), and repaired Rayleigh quotient $-0.290085$ against the $\tfrac12$ a certificate needs.

The route is worse than the record says, not better. The repaired quotient is also grading-dependent, $-0.290085$ on the two gradings with cross-mass $0.020715$, $+0.429036$ on the three with cross-mass $0.082859$, undefined on the three where the cross-block vanishes identically, and the largest value it ever reaches, $0.429036$, is still below $\tfrac12$. **So the closure holds across every grading, and the single number $-0.290085$ understates how the route fails: the direction is inadmissible ($57.7\%$ outside $\mathcal W_n$) *and* its best repaired value over all gradings misses the bound.**

**Is a repaired version available?** Nothing I found separates the loci by a mass or a block. What does separate them cleanly, and is already proved above, is dimensional: $\Delta=0$ at the equivariant point and $\Delta=1.512231$, $2.400930$, $2.762850$ at the three non-equivariant ones, and $\Delta$ is a genuine $O(n)$-invariant with a fixed total $\sum_\gamma g_\gamma=4(n-1)$. A successor should be built on $\Delta$ or on $\mathfrak k(W)$, both of which are invariants of the point, rather than on any quantity that requires naming a grading.

---

## M6, where the violation lives

**At the witness, in the grading the record used, the table is exact.** Locating the grading with $\lVert A\rVert^2=0.332496$ and decomposing the $\lambda_{\max}$ eigenvector (multiplicity one, $\lambda_{\max}=0.608885447$):

| block | recorded | recomputed |
| --- | --- | --- |
| $\mathfrak m\times\mathfrak m$ | $0.7074$ | $0.7074$ |
| $\mathfrak{so}(5)$ | $0.1853$ | $0.1853$ |
| cross $\mathfrak p_1\times\mathfrak p_2$ | $0.0856$ | $0.0856$ |
| $\mathfrak{so}(3)$ | $0.0217$ | $0.0217$ |
| $\mathfrak p\times\mathfrak m$ | $0.0000$ | $0.0000$ |

**But the table is a property of the grading, not of the point.** On the other gradings of the same critical point the same eigenvector decomposes as

| grading | $\mathfrak m\times\mathfrak m$ | $\mathfrak{so}(5)$ | cross | $\mathfrak{so}(3)$ | $\mathfrak p\times\mathfrak m$ |
| --- | --- | --- | --- | --- | --- |
| $\lVert A\rVert^2=0.332496$ | $0.7074$ | $0.1853$ | $0.0856$ | $0.0217$ | $0.0000$ |
| $\lVert A\rVert^2=0.808897$ | $0.1704$ | $0.7934$ | $0.0000$ | $0.0362$ | $0.0000$ |
| $\lVert A\rVert^2=0.494478$ | $0.4549$ | $0.1173$ | $0.3425$ | $0.0853$ | $0.0000$ |
| $\lVert A\rVert^2=0.624926$ ($=E_+$) | $0.3355$ | $0.1432$ | $0.3425$ | $0.1788$ | $0.0000$ |

The $\mathfrak m$-share runs from $0.17$ to $0.71$ and the $\mathfrak{so}(5)$-share from $0.12$ to $0.79$ on **one** eigenvector of **one** point. **So "the violation is concentrated on $\mathfrak m$" is not a fact about the witness; it is a fact about one of at least eight gradings of it, and the record picks that one without saying so.**

**At the other two $\Delta>0$ points it does not hold.** Taking every grading my invariant-based enumeration finds at 9018 and 9033:

| point | grading | $\mathfrak m\times\mathfrak m$ | $\mathfrak{so}(5)$ | cross | $\mathfrak{so}(3)$ | $\mathfrak p\times\mathfrak m$ |
| --- | --- | --- | --- | --- | --- | --- |
| 9018 | $\lVert A\rVert^2=0.631385$ | $0.2950$ | $0.3363$ | $0.3267$ | $0.0420$ | $0.0000$ |
| 9018 | $\lVert A\rVert^2=0.405368$ | $0.5375$ | $0.1892$ | $0.2535$ | $0.0198$ | $0.0000$ |
| 9018 | $\lVert A\rVert^2=0.622350$ | $0.3677$ | $0.1638$ | $0.3267$ | $0.1418$ | $0.0000$ |
| 9033 | $\lVert A\rVert^2=0.503429$ | $0.2609$ | $0.6568$ | $0.0108$ | $0.0715$ | $0.0000$ |
| 9033 | $\lVert A\rVert^2=0.434294$ | $0.4336$ | $0.1290$ | $0.3402$ | $0.0973$ | $0.0000$ |
| 9033 | $\lVert A\rVert^2=0.624010$ | $0.3385$ | $0.1585$ | $0.3459$ | $0.1571$ | $0.0000$ |

At 9018 the $\mathfrak m$-share drops to $0.2950$ with $\mathfrak{so}(5)$ ahead of it at $0.3363$; at 9033 it drops to $0.2609$ with $\mathfrak{so}(5)$ at $0.6568$. **The cross-block, which the record measures at $0.0856$ and dismisses, reaches $0.35$ at both new points.** So the route choice "a successor should deform $B=W\vert_{\mathfrak m}$ rather than anything inside $\mathfrak p$" is not supported by the evidence once more than one point and more than one grading are looked at.

**What IS invariant, and is worth keeping.** In every grading of every one of the three points, the $\mathfrak p\times\mathfrak m$ mass of the $\lambda_{\max}$ eigenvector is $0.0000$, **the violating direction is itself graded, at all three points and for all gradings tested**. That part of the record's reading survives as stated, and it is the part a successor can lean on. The rest of the table should be labelled with its grading or withdrawn.

---

## Things the brief did not ask about

- **The record's own "$\Delta=0\iff\mathrm{ad}(\mathfrak p)$-equivariant on a graded point" is grading-sensitive.** Padded $W_{\mathbb{CP}^2}$ is graded for $\mathfrak p=\mathfrak{so}(4)\oplus\mathfrak{so}(n-4)$, has $\Delta=1.2\times10^{-32}$, and has $\mathrm{ad}(\mathfrak p)$-equivariance defect $6.000000$, so it is a graded, $\Delta=0$, non-equivariant point at $\theta=\sqrt{3/2}$ with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ exactly. The equivalence is a tautology when $\mathfrak p$ is read as $E_+$ (which is what $\Delta$ is defined over) and false when $\mathfrak p$ is read as the grading. Lemma L69 needs the second reading, and [C3](../plan.md)'s split of the graded half into "equivariant, where Lemma L69 applies" and "non-equivariant, i.e. $\Delta>0$" **inherits this ambiguity and is not a partition as written**.
- **Every diagonal Weyl tensor is graded** in the brief's sense, for every split, since $\Lambda^2(\mathop{\mathrm{diag}}(\pm1))$ is diagonal. The graded/ungraded split therefore does no work at all on the diagonal locus (which is exactly the locus the problem statement grants) and any statement combining "graded" with "diagonal" should be re-read with that in mind.
- **All three non-diagonal $\Delta>0$ points are graded, in the grading sense**, each for several inequivalent gradings, with $\dim\mathfrak k(W)=5$ at the witness and $2$ at 9018 and 9033. Nothing on the record says the non-diagonal $\Delta>0$ population is graded; if it is, [C3](../plan.md)'s restricted V3 is the whole of V3 on the points that exist.
- **The one-dimensionality of $\mathrm{Inv}_{\mathfrak p}(\mathcal W_n)$ is worth promoting to a lemma.** It gives "equivariant graded $\Rightarrow$ critical" for free, replaces the whole $\mathbb{CP}^m$/Wolf/Grassmannian family programme with a two-line classification, and is the honest form of the half-recorded sentence "each $W$ is the unique unit $\mathfrak h$-invariant Weyl tensor for its $\mathfrak h$".

---

*Scripts: [scripts/reviewers/r313/](../scripts/reviewers/r313/). Log: [agent_logs/r313-cycle-audit.log](../agent_logs/r313-cycle-audit.log).*
