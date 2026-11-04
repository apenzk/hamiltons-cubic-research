# Review r464, adversarial audit of Lemma L46's new proof and of the Lemma L20 canon entry

Two items, each written into the record on a single reviewer's word, neither independently checked. Both traced to their sources; both verdicts below.

| item | locus | verdict |
| --- | --- | --- |
| 1 | the three-step proof now standing in [Lemma L46](../findings/problem.md) | **CONFIRMED**, every step valid, two exposition gaps, one route repairable in a line |
| 2 | the repair to the canon's [Lemma L20](../results.md) entry | **SPLIT**, the L21 description **CONFIRMED**; the "unconditional" clause **REFUTED as unqualified**; the third description now standing **REFUTED** |

*Analysis only ([analysis-only.md](../.claude/rules/analysis-only.md)). Everything below is hand algebra; the two screens are marked as screens and are built from defining data (brackets, sectional curvatures), never from the closed form under test.*

---

## ITEM 1, the proof in Lemma L46. CONFIRMED

### Step A, $Q(R)=\lambda R$, and what pins the constant

**Valid, and the constant is pinned.** The brief's worry (homothety gives $\partial_tR=\mu R$ for *some* $\mu$), is answered by the flow itself, not by a choice. Ricci flow of an Einstein metric is $\partial_tg=-2\mathop{\mathrm{Ric}}=-2\lambda g$, so $g(t)=(1-2\lambda t)g_0$ with the rate **forced**; in the Uhlenbeck frame the curvature operator scales inversely, $R(t)=R_0/(1-2\lambda t)$, so $\partial_tR|_{t=0}=2\lambda R_0$. Against $\partial_tR=\Delta R+2Q(R)$ with $\Delta R=0$ this gives $Q(R_0)=\lambda R_0$, with $\mu=2\lambda$ and no freedom.

**Screen (defining data, not the closed form).** The unit round $S^n$ is locally symmetric Einstein with $R=I$ and $\mathop{\mathrm{Ric}}=(n-1)g$, so $\lambda=n-1$; Step A predicts $Q(I)=(n-1)I$, which is exactly the value Step B quotes from [Böhm–Wilking Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md). A convention in which the answer were $2\lambda R$ would read $Q(I)=2(n-1)I$ and contradict $I^\#=(n-2)I$. **The factor is right in the record's normalisation.**

**$\Delta$ is the rough Laplacian, which is the favourable reading.** Hamilton's evolution in the evolving frame carries the connection Laplacian; the curvature terms that separate it from $\Delta_L$ are precisely what $R^2+R^\#$ collects. $\nabla R=0$ kills the rough Laplacian outright. *Had it been $\Delta_L$, Step A would fail* ($\Delta_LR\ne0$ at a parallel $R$) so the distinction is load-bearing and it falls the right way.

**One real defect in the route, repairable in a line.** Invoking Ricci flow needs short-time existence, i.e. completeness with bounded curvature or compactness, the very hypothesis the block's closing paragraph says is *not* needed. The repair is on the record already: [Richard–Seshadri Lemma 4.1](../references/richard-seshadri-2013-noncoercive-cones/notes.md) proves the same statement from Brendle's **static** Einstein identity, with no flow, and their Remark 4.2 notes the equation is $O(n)$-invariant and hence algebraic. Alternatively Cartan supplies a complete simply connected model with the same curvature, on which the flow exists. **Cite one of the two and the hypothesis note becomes true as written.**

### Step B, the expansion and the cancellation, term by term

**The expansion is correct.** $\circ$ is defined in [conventions.md](../findings/conventions.md) by $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, so $Q(W+cI)=Q(W)+c^2Q(I)+2c\,(W\circ I)$ by bilinearity, and $Q(R)=\lambda R$ rearranges to the block's $Q(W)=\lambda W+\lambda cI-c^2(n-1)I-2c(W\circ I)$. ✔

**$c=\lambda/(n-1)$ is the right shift and kills the right term.** $I$ has $\mathop{\mathrm{Ric}}=(n-1)g$, so $cI$ carries the full Einstein Ricci and $W=R-cI$ is trace-free and scalar-free, i.e. pure Weyl. ✔ In the remainder $\lambda c-c^2(n-1)=c(\lambda-c(n-1))=0$. ✔

**The block's sentence overclaims by one term.** $c=\lambda/(n-1)$ kills the two $I$-terms **and nothing else**; the $-2c(W\circ I)$ term is killed by Step C at every $c$. Written as "the choice that kills the remainder", the credit is misassigned.

**$W\circ I$ and $W\#I$ are NOT the same operation, and the block never bridges them.** From the definition, $X\circ Y=\tfrac12(XY+YX)+X\#Y$, so
$$W\circ I=W+W\#I,$$
and Step C's $W\#I=-W$ gives $W\circ I=0$. **The bridge is one line and the block omits it**, Step C proves a statement about $\#$ while Step B consumes a statement about $\circ$. It is a gap in exposition rather than an error: *the record already carries the bridge explicitly*, in the citation table of the same file, [problem.md](../findings/problem.md) line 52, as $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$. **Quote that line in the block and Step B closes.**

### Step C, $W\#I=-W$, and the trace consistency

**$W\#I=-W$ is CONFIRMED, derived here from conventions.md alone.** With $c_{\alpha\beta\gamma}$ totally antisymmetric and $A_\gamma=\mathop{\mathrm{ad}}(v_\gamma)$, the definition of $\#$ gives $I\#R=-\tfrac12\sum_\gamma A_\gamma RA_\gamma$, the block's own formula. Expanding the Casimir $C(R)=-\sum_\gamma[A_\gamma,[A_\gamma,R]]$ and using conventions.md's Killing normalisation $\sum_\gamma A_\gamma^2=-2(n-2)\mathrm{Id}$ (its $\kappa=2(n-2)$, equivalently the Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$):
$$R\#I=(n-2)R-\tfrac14C(R).$$
Casimir eigenvalues from $\langle\lambda,\lambda+2\rho\rangle$, normalised by the adjoint value $2(n-2)$: $0$ on $\mathbb R\cdot I$, $2n$ on $S^2_0$, $4n-4$ on $\mathcal W_n$, $4n-16$ on $\Lambda^4$. Hence $\#I$ acts by $n-2$, $\tfrac{n-4}2$, $\boxed{-1}$, $2$, **so $W\#I=-W$**, and $I\#I=(n-2)I$, whence $Q(I)=(n-1)I$ as Step B needs.

**Cross-check against a table the record computed independently.** [isotropy-cap.md](../findings/isotropy-cap.md) line 33 records $T(A)=-\sum_k\mathop{\mathrm{ad}}(f_k)A\mathop{\mathrm{ad}}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$ (which is $T=2(\,\cdot\,\#I)$, my identity times two) and line 62 gives its spectrum as $2n-4,\ n-4,\ -2,\ 4$. My four eigenvalues, doubled, are $2n-4,\ n-4,\ -2,\ 4$. **Exact agreement on all four summands.** The block's citation of "the $-2$ eigenvalue" is therefore correct and the factor works out: $T|_{\mathcal W}=-2\Rightarrow\#I|_{\mathcal W}=-1$.

**The trace consistency claim is CONFIRMED, and the step the brief flags is legitimate.** $\mathop{\mathrm{tr}}(W^\#)=\langle W^\#,I\rangle$ under the record's pairing $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$; moving $I$ across needs $\mathop{\mathrm{tri}}(A,B,C)=\langle A\#B,C\rangle$ to be totally symmetric, and it is, writing it out, $\mathop{\mathrm{tri}}=\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}C_{\alpha\beta}A_{\gamma\epsilon}B_{\delta\zeta}$, each of the two structure constants contributes exactly one index to each of $A,B,C$ in the same slot order, so any permutation of the three arguments signs both $c$'s identically and the signs cancel. Hence $\mathop{\mathrm{tr}}(W^\#)=\mathop{\mathrm{tri}}(W,W,I)=\mathop{\mathrm{tri}}(W,I,W)=\langle W\#I,W\rangle=-\lVert W\rVert^2$. ✔ ([target.md](../findings/target.md) line 31 gives the same three-step move.)

### Screens, the lemma verified end to end at two spaces, from brackets and sectional curvatures

*Both are screens on objects built from defining data. The closed form under test is never re-evaluated.*

- **$\mathbb{CP}^2$, decisive.** Fubini–Study with $\mathop{\mathrm{Ric}}=6g$: self-duality ($W_-=0$) forces $R|_{\Lambda^2_-}=\tfrac s{12}\mathrm{Id}=2\,\mathrm{Id}$, $R(\omega)=6\omega$, and $\mathop{\mathrm{tr}}R=s/2=12$ closes the last entry at $0$, giving $\mathop{\mathrm{spec}}R=(6,0,0,2,2,2)$. With $c=\lambda/(n-1)=2$, $W=R-2I$ has $\mathop{\mathrm{spec}}W=(4,-2,-2,0,0,0)$. In an $\mathfrak{su}(2)_+\oplus\mathfrak{su}(2)_-$ basis the Killing marginal $2(n-2)=4$ forces $\lVert[u_i,u_j]\rVert^2=2$, and then $(W^\#)_{11}=2\lambda_2\lambda_3=8$, $(W^\#)_{22}=(W^\#)_{33}=2\lambda_1\lambda_{3,2}=-16$, $W^\#|_{\Lambda^2_-}=0$. So $Q(W)=W^2+W^\#$ has entries $16+8=24$, $4-16=-12$, $0$, that is **$Q(W)=6W=\lambda W$ exactly**, on the nose. Independently $\mathop{\mathrm{tr}}(W^\#)=8-16-16=-24=-\lVert W\rVert^2$, confirming Step C's consistency line at a real space.
- **$S^2\times S^2$.** Unit factors, $\lambda=1$, $\mathop{\mathrm{spec}}R=(1,1,0,0,0,0)$, $c=\tfrac13$, $\mathop{\mathrm{spec}}W=(\tfrac23,\tfrac23,-\tfrac13,-\tfrac13,-\tfrac13,-\tfrac13)$, $\lVert W\rVert^2=\tfrac43$. The lemma's $\theta=\lambda/\lVert W\rVert$ then gives $\sqrt3/2=\theta_0(4)$, the record's own value, reached without touching the closed form.

### The hypotheses the block attaches

- **$\lambda\ne0$, the Cartan claim is CONFIRMED for *locally* symmetric, not merely symmetric.** A locally symmetric space is locally isometric to a complete simply connected symmetric space (Cartan–Ambrose–Hicks), which splits as Euclidean $\times$ compact type $\times$ noncompact type; Ricci is positive definite on the compact factors and negative definite on the noncompact ones, so $\mathop{\mathrm{Ric}}=0$ admits neither, leaving the flat factor and $R=0$ pointwise. The conclusion transfers to the original because curvature is local. So Ricci-flat locally symmetric $\Rightarrow$ flat $\Rightarrow W=0$ and $\theta$ undefined. ✔ *The attribution to "Cartan" is loose (the decomposition is de Rham's and the local-to-global step is Cartan–Ambrose–Hicks) but the statement is what the block needs and it is true as stated.*
- **$\lambda<0$ harmless** ✔, the identity is algebraic in $R$, and $\theta=\lambda/\lVert W\rVert<0$ is a critical point in the record's sense ($Q(W)=\theta W$), harmless for an upper bound.
- **Compactness not needed** ✔ *once Step A is routed off the flow* (see above). As Step A currently stands the block needs completeness with bounded curvature, so this hypothesis note and this proof are in tension until the citation is added.

### The block's preamble is false, the argument WAS on the record, twice

The italic preamble says the argument "is not there, nor anywhere on the record". Both halves of that are wrong about the wider record:

- **[graded-half.md](../findings/graded-half.md) line 146** carries the box "*This is [Lemma L46](problem.md) … the four-line argument below is its proof*", followed by a four-line proof attributed to Gate 2 reviewers 85 and 86. **A reviewer reporting that a proof exists nowhere should have found this**; it is the file the canon's $\theta$-quadratic consequence is drawn from.
- **[richard-seshadri-2013-noncoercive-cones/notes.md](../references/richard-seshadri-2013-noncoercive-cones/notes.md)** transcribes the lemma verbatim as **published Lemma 4.1**, with proof, and says in terms "which is how the record states [Lemma 46]". [LIT-srg-forward.md](LIT-srg-forward.md) rows 2 and 3 say the same. **L46 is not this programme's result and its block cites neither source.**

### Collateral defects found while auditing Item 1

1. **[graded-half.md](../findings/graded-half.md) line 148 has a factor-2 error.** It writes "$R\#I=2\lambda I-2R$ gives $R\circ I=\lambda I$". The truth is $R\#I=\lambda I-R$ at an Einstein $R$: from BW Lemma 2.1, $R+R\#I=\mathop{\mathrm{Ric}}(R)\wedge\mathrm{id}$, checked at $R=I$ where $I\#I=(n-2)I$ against the file's formula's $2(n-2)I$. The stated implication is also internally broken (its own formula gives $R\circ I=2\lambda I-R$, not $\lambda I$) while the correct one gives $R\circ I=R+\lambda I-R=\lambda I$ as claimed. **The conclusion is right and the displayed identity is wrong by two.** *(Cross-checked against the shift: $R\#I=c(n-2)I-W$ and $\lambda I-R=(\lambda-c)I-W$ agree because $\lambda-c=c(n-2)$.)*
2. **[isotropy-cap.md](../findings/isotropy-cap.md) line 292 mislabels which operator has the $-2$.** It reads "'$\mathrm{Weyl}_n$ is $\mathcal A$'s $-2$ eigenspace' IS $W\#I=-W$". By [Lemma L131](../findings/isotropy-cap.md) $\mathcal A=-2(\,\cdot\,\#I)$, so $\mathcal A|_{\mathcal W}=+2$, as [Lemma L79](../findings/isotropy-cap.md)'s own table says. The $-2$ belongs to $T=2(\,\cdot\,\#I)$, the operator of lines 33, 37 and 62. The sentence is right about the *content* and wrong about the *letter*.
3. **The reference note's quoted Richard–Seshadri derivation is internally inconsistent.** Its transcribed proof reads "$\Delta_{g_0}R_{g_0}+2Q(R_{g_0})=\lambda R$ … This proves that $Q(R_{g_0})=\lambda R_{g_0}$", which drops a factor $2$. At $R=I$, $\lambda=n-1$, the displayed equation says $2(n-1)I=(n-1)I$, contradicting the **same file's** quoted Lemma 3.1, $Q(I)=(n-1)I$. So the displayed intermediate is mis-transcribed (or carries Brendle's $\lambda$), while the conclusion (the one the record uses), is correct. **Fixing the quote matters because a future reader deriving from the displayed line gets $\theta$ too small by two.**

### Item 1 verdict, **CONFIRMED**

Steps A, B and C are each valid, the hypotheses are each correct, and the lemma is verified end to end at $\mathbb{CP}^2$ from brackets alone. **Three repairs are owed, none of them to the mathematics**: cite [Richard–Seshadri](../references/richard-seshadri-2013-noncoercive-cones/notes.md) (or Cartan completeness) so that Step A does not need the flow it says it does not need; add the one-line bridge $W\circ I=W+W\#I$ from [problem.md](../findings/problem.md) line 52; and withdraw the preamble's claim that the argument is nowhere on the record.

---

## ITEM 2, the Lemma L20 canon entry

### What L20's proof genuinely consumes

Read from [route-a.md](../findings/route-a.md), the canonical block, line by line:

| input | status |
| --- | --- |
| $m=\sqrt{2/3}\max P$ attained (compactness) | proved |
| $V\perp u$ and $V\perp T_u\mathcal O$, by first variation at the nearest orbit point | proved |
| exact cubic expansion with no linear term, from $Q(u)=\theta^*u$ | proved, and it is [Lemma L46](../findings/problem.md) that supplies the criticality of $W_{\mathbb{CP}^2}$ |
| $\alpha=\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$ | **the one external input**, block cites "Nienhaus Theorem 4.14(c), valid for $n\ge9$ and reverified here from scratch" |
| $\gamma_V\le m$, since $V$ is a unit Weyl operator | proved, trivially |
| $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)\le1$ on $[0,0.5748]$ | elementary one-variable calculus |
| $\theta_0(n)>\theta^*$ at every $n\ge12$, both parities | arithmetic |

**Screens on the two numerical-looking steps.** $\psi(\pi/8)=0.92388/0.94396=0.9787$ and $\psi(0.574826)=0.83926/0.83924\approx1$, the endpoint being the root of $\sin^3\varphi=1-\cos\varphi$, both reproduce the block's numbers, and $\psi\le1$ is a genuine calculus fact rather than a fit. $\theta_0(12)=1.236033>\sqrt{3/2}$; at odd $n$ the unbalanced products give $1.248376$ at $n=13$ and $1.270978$ at $n=15$, and $\theta_0(n)^2=2(1-3/n+2/n^2)$ increases in $n$. The algebra closes: $m\le\cos^3\varphi+\cos\varphi\sin^2\varphi+m\sin^3\varphi=\cos\varphi+m\sin^3\varphi$, so $m\le\psi\le1$ against $m\ge\sqrt{2/3}\,\theta_0(12)=1.00922$. ✔

### Is the replacement description right?

**Yes, the L21 version is right in substance, and it was the best of the three.** L20's proof consumes exactly two things beyond calculus: $\alpha\le\tfrac13$ and $\gamma_V\le m$. And $\alpha\le\tfrac13$ **is Lemma L21's statement verbatim**, L21 is titled "the eigenvalue bound $\alpha\le1/3$ holds in every dimension", its first line reads "*Lemma L20 rests on one external input: that the largest eigenvalue of $F_u$ transverse to $\mathbb Ru$ and the orbit is $\tfrac13\theta^*$*", and the section that proves it closes "*This removes the last external dependency of Lemma L20*". **The record states the dependency in its own words, twice.** That the block cites Nienhaus's theorem rather than L21's number is a citation fact, not a dependency fact.

**The third description, now standing, is a second wrong one, and its error is worse than the citation gap it fixed.**

- *"the multiplicity-free orbit decomposition"* **inverts L21's content.** L21 exists precisely because Nienhaus's Schur argument needs multiplicity-freeness and that hypothesis is unverified at large $n$; L21's mechanism is stated as "**with no multiplicity-free hypothesis**, since multiplicities are exactly what the spaces $M_\lambda$ absorb". The adjective names the flaw as if it were the method.
- **The decomposition named is not multiplicity-free either.** As $SO(n-4)$-representations, $\mathfrak{so}(4)\oplus(\mathbb R^4\otimes\mathbb R^{n-4})\oplus\mathfrak{so}(n-4)$ is $6\cdot(\text{trivial})\oplus4\cdot(\text{vector})\oplus\Lambda^2$, multiplicities $6$, $4$, $1$.
- **That decomposition alone does not give $\alpha\le\tfrac13$.** It identifies $T_u\mathcal O$ with the $\tfrac12\theta^*$-eigenspace; the bound needs the four $F_\lambda$ spectra on the multiplicity spaces of dimensions $20,20,6,10$.

### Does L20 depend on L22, directly or indirectly? **No.**

L22's proof is nowhere in L20's chain, and neither is [Observation L102](../findings/route-a.md), L22's load-bearing input. L21's proof runs on the $SO(n-4)$-isotypic decomposition and four fixed matrices; it touches neither. **[r463](REVIEW_r463.md)'s original correction stands: the L22 naming was false, and removing it was right.**

### Is L20 unconditional? **Not in the sense of "every input traced to a proved statement."**

The chain reaches an Observation-grade input at exactly one place, and **the record says so itself, in the same file**:

- [route-a.md](../findings/route-a.md) line 102: "*The remaining formal obligation is a proof that the stable range begins at $n-4\ge8$ rather than a check at two dimensions.*"
- [route-a.md](../findings/route-a.md) line 147: "*What the record proves is that the four blocks exhaust the nonzero eigenvalues under the $SO(n-4)$ action, **with the spectra tabulated at $n=10,12,14$ and asserted stable beyond**; a reader wanting (a) unconditionally at every $n$ should treat that stability as the one external input, **exactly as Lemma L20 does**.*"

So $\alpha\le\tfrac13$ decomposes into a proved half and an unproved half. **Proved:** the $\tfrac12\theta^*$-eigenspace equals $T_u\mathcal O$, by the block-by-block count $2+4(n-4)=4n-14$ at every $n$, plus the exact finite-field verification at $n=6,8,10$. **Unproved:** that the four $F_\lambda$ matrices, and hence the top eigenvalue $\tfrac13\theta^*$ on the complement, do not vary with $n$, a table computed at three dimensions. *The types and multiplicities are genuinely stable for $n-4\ge8$ by the stable range for $O(m)$ tensor representations, $k\le4$ factors; what is asserted rather than proved is that the restricted matrices themselves are constant.*

**The two senses of "unconditional" must be separated, because the entry runs them together.**

| sense | verdict |
| --- | --- |
| Does not assume Conjecture A; does not use the a priori cap $P\le\theta^*$ that makes Nienhaus's Theorem 4.17 circular past $n=11$; does not use L22 or Observation L102 | **TRUE**, this is the entry's real content and it survives intact |
| Every input traced to a proved statement at every $n\ge12$ | **FALSE**, $\alpha\le\tfrac13$ rests on a tabulated spectrum plus an unproved $n$-stability, so L20 is a Lemma at the checked dimensions and an Observation-backed claim at $n\ge16$ |

**Consequence for the canon.** Both the glance entry and the detail entry assert "Proven unconditionally" with no qualifier, while route-a.md states the qualifier twice. **The canon is the file a reader trusts, and it is the one that omits it.** The honest form: *unconditional in that it consumes no cap on $\max P$ and no conditional lemma; its one external input is the $n$-stability of L21's four block spectra, checked at $n=10,12,14$.*

### Item 2 verdict, **SPLIT**

- The repair naming **Lemma L21's eigenvalue bound and the self-bootstrap $\gamma_V\le m$: CONFIRMED.** It is an accurate description of what L20's proof consumes, and the record twice names L21 as L20's dependency.
- The **"multiplicity-free" description now standing: REFUTED.** It inverts L21's central point, the decomposition it names is not multiplicity-free, and that decomposition alone does not yield the bound. *The over-correction was the mistake, not the correction.*
- The unqualified **"the theorem is unconditional": REFUTED as stated, CONFIRMED in the anti-circularity sense.** L20 is free of every conditional input in the programme, and rests on one unproved stability assertion that the canon does not record.

---

## What this leaves owed

| # | owed | file |
| --- | --- | --- |
| 1 | Step A cites [Richard–Seshadri Lemma 4.1](../references/richard-seshadri-2013-noncoercive-cones/notes.md) (flow-free), so the "compactness not needed" note stops contradicting its own proof | [problem.md](../findings/problem.md) |
| 2 | the bridge $W\circ I=W+W\#I$, already in the same file at line 52, quoted into Step B | [problem.md](../findings/problem.md) |
| 3 | the preamble's "nor anywhere on the record" withdrawn, [graded-half.md](../findings/graded-half.md) line 146 and the RS notes both carry it | [problem.md](../findings/problem.md) |
| 4 | $R\#I=2\lambda I-2R$ corrected to $R\#I=\lambda I-R$ | [graded-half.md](../findings/graded-half.md) line 148 |
| 5 | the $-2$ attributed to $T$, not to $\mathcal A$ (whose Weyl eigenvalue is $+2$) | [isotropy-cap.md](../findings/isotropy-cap.md) line 292 |
| 6 | the mis-transcribed "$\Delta R+2Q(R)=\lambda R$", inconsistent with the same file's $Q(I)=(n-1)I$ | [richard-seshadri notes](../references/richard-seshadri-2013-noncoercive-cones/notes.md) |
| 7 | the L20 entry's third description replaced by the L21 one, and "unconditional" qualified by L21's $n$-stability input | [results.md](../results.md) lines 232, 660 |
