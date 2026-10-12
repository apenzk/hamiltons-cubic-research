# REVIEW r656, Observation L103, the witness $W_1$ and its sharp constant

**Verdict: GAP, every number in the block is correct and all of them are now *derived*, but the one word carrying the block's weight, "sharp", is an unproved global maximisation.** $f$ has a closed form on the witness circle, $f(\varphi)=\cos^3\varphi+c_{12}\sin^3\varphi$ with $c_{12}=\sqrt{2/3}\,\theta_0(12)=\sqrt{330}/18=\sqrt{55/54}$, and that form reproduces the file's own independently-recorded $f(\pi/6)=0.7757$ to every digit printed. Both orthogonality claims are **exactly** zero for a two-line reason, so the reported residual $4.8\times10^{-16}$ measures a quantity that is identically zero. The witness exists at **every $n\ge12$ and at no $n\le11$**, not at $n=12$ alone. Reviewer r656, cold brief; [REVIEW_r655.md](REVIEW_r655.md) unread, and the concurrent L78 / L112 / L59 / L56 audits untouched. Analysis only: the two `python3` calls below are screens of closed forms I derived first, and no positive claim rests on them.

| attack | outcome |
| --- | --- |
| $f(\pi/2)=1.0092168>1$ | **CONFIRMED, and promoted from measurement to identity**: $f(\pi/2)=\sqrt{2/3}\,\theta_0(12)=\sqrt{330}/18=1.009216784699\ldots$ |
| $c_{12}=1.009216785$ | **CONFIRMED, same number as $f(\pi/2)$**, printed at nine figures instead of eight; $c_{12}^2=55/54$ exactly |
| a closed form exists | **YES**, and the whole of $f$ has one: $f(\varphi)=\cos^3\varphi+c_{12}\sin^3\varphi$ on the witness circle |
| $\pi/2$ is where $f$ is maximal | **CONFIRMED, derived**: $f'=3\sin\varphi\cos\varphi(c_{12}\sin\varphi-\cos\varphi)$, so the only interior critical point on $(0,\pi/2)$ is a **minimum** and $\max_{[0,\pi]}f=f(\pi/2)$ |
| $\langle W_1,W_{\mathbb{CP}^2}\rangle=0$ "exactly" | **CONFIRMED, and derivable in one line** from $\operatorname{tr}W_{\mathbb{CP}^2}=0$ |
| $\perp$ to the orbit tangent, residual $4.8\times10^{-16}$ | **CONFIRMED, and it is exactly $0$**: $[W_1,W_{\mathbb{CP}^2}]=0$, so the pairing with every orbit direction vanishes identically. A measured residual on an exact zero |
| $W_1\in\mathcal W_{12}$, Bianchi, trace-free | **CONFIRMED**, it is the Weyl part of an Einstein product metric; trace-freeness checks by hand, $30\cdot\tfrac6{11}-36\cdot\tfrac5{11}=0$ |
| "the one whose first factor *contains* the $\mathbb{CP}^2$ block" | **CONFIRMED load-bearing, and correctly placed**, but it constrains **admissibility**, never the value. $f(\pi/2)$ is split-independent; orthogonality is not |
| "sharp" | **UNPROVED**, it asserts $\sup P=\theta_0(12)$ over the $1603$-dimensional admissible complement, on ascent. It **follows from** Conjecture A at $n=12$, so the block leans a stated result on the programme's own open problem |
| "kills the $f\le1$ premise" | **CONFIRMED as quantified at $n\ge12$**, where Nienhaus does not state the theorem. Nothing of his is refuted; the heading omits the quantifier that the same file's correction 2 supplies |
| "no weaker *local to the curve* reading escapes" | **REFUTED under the $\varphi$-localisation reading**, $f\le1$ holds out to $85.40^\circ$ on this very witness, far past the $\pi/6$ the theorem needs. It is true for a different reason the block does not give |
| labelled `Observation`, names $n=12$ | **REACH UNDERSTATED**, the witness exists at exactly $n\ge12$; and with the closed form below the block is no longer a measurement |
| duplication under another number | **NONE.** One unnumbered mirror in [report/sections/90-appendix.tex:357](../report/sections/90-appendix.tex#L357), born in the same commit |
| what consumes L103 | **NOTHING.** Its one apparent citer is [L100](../findings/route-a.md)'s *"the same machinery"*, already on the record as resolving here by accident |

---

## 0. The reading I adopt, and what [conventions.md](../findings/conventions.md) does not carry

**Flag first: not one of this block's five central symbols is in [conventions.md](../findings/conventions.md).** $f$, $c_{12}$, $c_n$, $W_1$, $W_{\mathbb{CP}^2}$ and the admissible set all live outside [findings/](../findings/), in [references/nienhaus-2023-second-best-einstein/notes.md](../references/nienhaus-2023-second-best-einstein/notes.md). The file whose stated purpose is that *"definitions and conventions are quoted, never restated"* is being bypassed by the block that most needs it, and a reader of [route-a.md](../findings/route-a.md) alone cannot reconstruct what $f$ is.

The readings I take, each with its source:

- **$f$**, from Nienhaus Theorem 4.17 as quoted at [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md): $f(\varphi)=\sqrt{2/3}\,P(\cos\varphi\,W_{\mathbb{CP}^2}+\sin\varphi\,W)$ for unit $W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(n).W_{\mathbb{CP}^2})$. The normalisation is not free: $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$ forces $f(0)=1$, which is exactly why *"$f\le1$"* and *"$W_{\mathbb{CP}^2}$ is the global maximiser"* are the same sentence.
- **$c$**, the numerator constant capping $\gamma$ in 4.17's proof, with $\gamma=\sqrt{2/3}P(W)$ from Remark 4.18, quoted verbatim at [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md). So $\gamma=f(\pi/2)$ **identically**, a fact I use twice below.
- **$W_1$**, L103's own sense: the balanced $S^6\times S^6$ Weyl operator at $n=12$. **The letter carries three meanings inside [route-a.md](../findings/route-a.md)**, already recorded by [r465](REVIEW_r465.md) and [r466](REVIEW_r466.md) and still not tabled in [conventions.md](../findings/conventions.md).
- **the pairing**, [conventions.md](../findings/conventions.md)'s: plain Frobenius on operators of $\Lambda^2$ in the orthonormal pair basis $\{\varphi_{ab}\}_{a<b}$, the $\tfrac12$ sitting at the $\Lambda^2$ level. Nothing below depends on the choice: every step is either a trace identity or is normalised by the record's own $P(W_1)=\theta_0(12)$ and $P(W_{\mathbb{CP}^2})=\sqrt{3/2}$.
- **$\theta_0(12)$**, the closed form $\sqrt{2\cdot11\cdot10}/12=\sqrt{220}/12$, which at **even** $n$ is the balanced-product value, per the 2026-09-04 repair. $n=12$ is even, so the block is inside the repaired reading. $S_{XYZ}$ does not enter.

---

## 1. The constant, in closed form

**$c_{12}=\sqrt{2/3}\,\theta_0(12)=\dfrac{\sqrt{330}}{18}=\sqrt{\dfrac{55}{54}}$, and $f(\pi/2)$ is the same number.**

$$c_{12}=\sqrt{\tfrac23}\cdot\frac{\sqrt{220}}{12}=\frac{1}{12}\sqrt{\frac{440}{3}}=\frac{2}{12}\sqrt{\frac{110}{3}}=\frac{\sqrt{330}}{18},\qquad c_{12}^2=\frac{440}{432}=\frac{55}{54}.$$

Numerically $1.0092167846991638$. The block's $f(\pi/2)=1.0092168$ and $c_{12}=1.009216785$ are this one number rounded to eight and nine significant figures. **They are the same quantity and the block prints it twice** (once as a value of $f$ and once as a replacement constant), without saying so; a reader is entitled to think two independent computations agreed.

**The general form.** $c_n=\sqrt{2/3}\,\Theta_n$, so at even $n$

$$c_n^2=\tfrac23\theta_0(n)^2=\frac{4(n-1)(n-2)}{3n^2},$$

and $c_n>1\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915\ldots$, **the record's own crossover**, stated forty lines below the block at [route-a.md:109](../findings/route-a.md#L109) and derived independently in [r275](../scripts/reviewers/r275/out_c5.txt). At odd $n$ the balanced split undershoots and the attained value is $\Theta_n$, giving $c_n>1\iff n^2-13n+18>0\iff n>(13+\sqrt{97})/2=11.42\ldots$, hence odd $n\ge13$.

**So the block's headline is one inequality: $f(\pi/2)>1\iff\Theta_n>\sqrt{3/2}=P(W_{\mathbb{CP}^2})$**, i.e. exactly *"a sphere product has overtaken $W_{\mathbb{CP}^2}$"*. That is a standing fact of this record, not a discovery, and the witness is its restatement inside Nienhaus's proof.

> **The block does not carry a closed form and the record does, in a file the block does not cite.** [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) already writes *"the correct $c_n=\sqrt{2/3}\,\theta_0(n)>1$"*. Nine of L103's ten significant figures were therefore always derivable from a line the record possessed; the block presents them as an outcome of ascent instead. **One caveat on that line: $c_n=\sqrt{2/3}\,\theta_0(n)$ is right at even $n$ only**, after the 2026-09-04 repair of $\theta_0$, the odd-$n$ value is $\sqrt{2/3}\,\Theta_n$, and the file's own correction 4 ($1.248376$ at $n=13$) is $\Theta_{13}$, not $\theta_0(13)$.

---

## 2. The whole of $f$ is elementary, the block is a proof, not an observation

This is the review's main deliverable. **Both endpoints of the witness circle are critical points of $P$, and they are orthogonal. That kills both cross terms.**

Write $A=W_{\mathbb{CP}^2}$, $B=W_1$, both unit, $\langle A,B\rangle=0$. Let $T$ be the symmetric trilinear form with $T(X,X,X)=P(X)$, so that $T(X,X,Y)=\langle Q(X),Y\rangle$ by [conventions.md](../findings/conventions.md)'s $\circ$ and $Q$. Cubic expansion along the great circle:

$$P(\cos\varphi\,A+\sin\varphi\,B)=\cos^3\!\varphi\,P(A)+3\cos^2\!\varphi\sin\varphi\,T(A,A,B)+3\cos\varphi\sin^2\!\varphi\,T(A,B,B)+\sin^3\!\varphi\,P(B).$$

- $T(A,A,B)=\langle Q(A),B\rangle=\theta^*\langle A,B\rangle=0$, since $A$ is a critical point, $Q(A)=\theta^*A$ with $\theta^*=\sqrt{3/2}$.
- $T(A,B,B)=\langle A,Q(B)\rangle=\theta_0(12)\langle A,B\rangle=0$, since $B$ is **also** a critical point, $Q(B)=\theta_0(12)B$, sphere products are critical, which is what makes this witness different from a hunted one.

Hence, with $f=\sqrt{2/3}\,P$ and $\sqrt{2/3}\,P(A)=1$,

$$\boxed{\;f(\varphi)=\cos^3\varphi+c_{12}\sin^3\varphi,\qquad c_{12}=\sqrt{55/54}.\;}$$

**Three consequences, all of which the block states as measurements.**

1. **$\pi/2$ is genuinely the maximiser, not a convenience.** $f'(\varphi)=3\sin\varphi\cos\varphi\,(c_{12}\sin\varphi-\cos\varphi)$. On $(0,\pi/2)$ the only zero is $\tan\varphi=1/c_{12}$, i.e. $\varphi=44.737^\circ$, and $f'<0$ before it and $>0$ after, so it is the **minimum** ($f=0.71034$). $f$ therefore attains its maximum on $[0,\pi/2]$ at an endpoint, $\max(1,c_{12})=c_{12}$; on $[\pi/2,\pi]$ the $\cos^3$ term is negative and $f<c_{12}$. So $\max_{[0,\pi]}f=f(\pi/2)=c_{12}$, exactly.
2. **The file's correction 2 falls out.** $f$ is strictly decreasing on $(0,44.737^\circ)\supset(0,\pi/6]$, and $f(\pi/6)=(\sqrt3/2)^3+c_{12}/8=0.6495190+0.1261521=0.7756712$, the block's independently recorded $0.7757$. **This is the strongest single check available**: a number written into the file by a different route, at a different $\varphi$, reproduced to all four printed digits by the closed form. It confirms simultaneously the form of $f$, the vanishing of both cross terms, $P(W_1)=\theta_0(12)$, and the normalisation.
3. **The `Observation` label is no longer the right one for the arithmetic.** Nothing above is numerical. What remains numerical is only the word "sharp", §3.

---

## 3. "Sharp" is the block's one unproved word, and what it needs is Conjecture A

Since $\gamma=\sqrt{2/3}P(W)$, the sharp replacement for $c=1$ is

$$c_{12}^{\mathrm{sharp}}=\sqrt{\tfrac23}\cdot\sup\Big\{P(W)\;:\;\lVert W\rVert=1,\;W\perp\mathbb RW_{\mathbb{CP}^2}\oplus T_{W_{\mathbb{CP}^2}}(SO(12).W_{\mathbb{CP}^2})\Big\}.$$

The witness gives $c_{12}^{\mathrm{sharp}}\ge\sqrt{330}/18$. **Equality is a global maximisation over a $1603$-dimensional sphere**, $\dim\mathcal W_{12}-1-(4n-14)=1638-1-34=1603$, the same complement the block's own line 28 sweeps, and the block's warrant for it is *"Ascent over the whole complement tops at the same value"*. An ascent certifies a local maximum and a lower bound. It cannot certify a supremum.

**And the statement it would need is a consequence of the programme's open problem.** If Conjecture A holds at $n=12$ then $M(12)=\Theta_{12}=\theta_0(12)$ (the global maximum is attained and is a critical point) so no admissible $W$ can exceed $\theta_0(12)$ and sharpness follows. The converse fails, the complement being a proper subset, so sharpness is strictly weaker than Conjecture A; but it is unproved on this record in either direction. **A `findings/` block should not be asserting, as a settled adjective, something implied by the conjecture the programme exists to prove.** The honest form is: *$c_{12}=\sqrt{330}/18$ is attained, and is sharp if Conjecture A holds at $n=12$*.

Two smaller notes on the same sentence.

- **The ascent may not be the one described.** [route-a.md:28](../findings/route-a.md#L28) records two ascents at $n=12$: a *global* one from 40 starts topping at $\theta_0(12)$, and a *fixed-$\varphi$* sweep over the $1603$-dimensional complement giving $\max f=0.9147$ at $\varphi=0.5748$. Neither is an ascent over the complement at $\varphi=\pi/2$, and I found no script performing one. The block's clause reads as the global ascent of line 28 restated as a complement ascent.
- **The value is available without any ascent at all**, from [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md)'s closed form. The measurement in the block is doing no work that the identity does not already do.

---

## 4. The construction: what depends on the split, and what does not

Write $V_1=\operatorname{span}(e_0,\dots,e_5)$, $V_2=\operatorname{span}(e_6,\dots,e_{11})$. The balanced $S^6\times S^6$ Einstein product has curvature operator $\kappa$ on each $\Lambda^2V_i$ and $0$ on the mixed planes $V_1\otimes V_2$; subtracting the constant-curvature part $\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{Id}=\tfrac{60\kappa}{132}\mathrm{Id}$ of the Einstein metric leaves

$$W_1=\kappa(\Pi_1+\Pi_2)-\tfrac{5\kappa}{11}\mathrm{Id}_{\Lambda^2},$$

with $\Pi_i$ the projection onto $\Lambda^2V_i$. Its spectrum is $\tfrac{6\kappa}{11}$ with multiplicity $30$ and $-\tfrac{5\kappa}{11}$ with multiplicity $36$.

- **Weyl.** $\operatorname{tr}W_1=30\cdot\tfrac6{11}\kappa-36\cdot\tfrac5{11}\kappa=\tfrac{180-180}{11}\kappa=0$, so it is trace-free; first Bianchi holds because the full curvature operator of a Riemannian metric satisfies it and the subtracted constant-curvature tensor does too. So $W_1\in\mathcal W_{12}$. **This is a genuine Weyl tensor, not an operator that merely looks like one**, the failure mode the brief warns of does not occur here.
- **$\langle W_1,W_{\mathbb{CP}^2}\rangle=0$, exactly, in one line.** $W_{\mathbb{CP}^2}$ is padded onto $\Lambda^2(\operatorname{span}(e_0,\dots,e_3))\subset\Lambda^2V_1$, so $\Pi_1W_{\mathbb{CP}^2}=W_{\mathbb{CP}^2}$ and $\Pi_2W_{\mathbb{CP}^2}=0$. Hence $\langle W_1,W_{\mathbb{CP}^2}\rangle=\big(\kappa-\tfrac{5\kappa}{11}\big)\operatorname{tr}W_{\mathbb{CP}^2}=\tfrac{6\kappa}{11}\cdot0=0$. **The only input is that $W_{\mathbb{CP}^2}$ is trace-free**, which every Weyl tensor is.
- **$\perp$ to the orbit tangent, exactly.** Orbit directions are $[\rho_*(X),W_{\mathbb{CP}^2}]$, $X\in\mathfrak{so}(12)$, and $\langle W_1,[\rho_*(X),W_{\mathbb{CP}^2}]\rangle=\operatorname{tr}\!\big(\rho_*(X)\,[W_{\mathbb{CP}^2},W_1]\big)$. From the two projector identities above, $W_{\mathbb{CP}^2}$ commutes with $\Pi_1$, $\Pi_2$ and $\mathrm{Id}$, hence **$[W_1,W_{\mathbb{CP}^2}]=0$** and the pairing vanishes for every $X$. *The block's $4.8\times10^{-16}$ is floating-point noise around an exact zero, reported as if it were the best available answer.* Given the neighbouring line already writes $\langle W_1,W_{\mathbb{CP}^2}\rangle=0$ "**exactly**", the asymmetry invites a reader to think the second orthogonality is only approximate.

**Now the brief's structural question. The value is split-independent; the admissibility is not.** $P$ is $SO(12)$-invariant, so $P(W_1)=\theta_0(12)$ for *every* split, hence $f(\pi/2)=\sqrt{2/3}P(W_1)$ is the same number for every conjugate split, and $f$ is a function of the operator alone, exactly as $SO(n)$-invariance demands. What the split changes is whether $W_1$ lies in Theorem 4.17's hypothesis set. If the $\mathbb{CP}^2$ block straddles the split, $W_1$ is no longer scalar on the six coordinate planes of $\operatorname{span}(e_0,\dots,e_3)$, it is $\tfrac{6\kappa}{11}$ on those inside a factor and $-\tfrac{5\kappa}{11}$ on the mixed ones, and $\langle W_1,W_{\mathbb{CP}^2}\rangle=\kappa\sum_{\text{planes inside }V_1}(W_{\mathbb{CP}^2})_{\alpha\alpha}$, generically nonzero (with $W_{\mathbb{CP}^2}$ coordinate-diagonal as $\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$, a straddle carrying $\{0,0,-1\}$ inside $V_1$ gives $-\kappa/\sqrt6\ne0$).

**So *"the one whose first factor contains the $\mathbb{CP}^2$ block"* is correct, is load-bearing, and is doing a job the block never names.** It is not selecting a value, every split gives $1.0092168$, it is selecting the splits under which $W_1$ is an **admissible competitor**. A reader who takes it as pinning the constant would conclude, wrongly, that $f$ depends on more than the operator.

---

## 5. What is refuted, and at which $n$

**The premise, quoted.** [references/nienhaus-2023-second-best-einstein/README.md:23](../references/nienhaus-2023-second-best-einstein/README.md#L23): *"**Theorem 4.17** ($10\le n\le11$), its proof caps $\gamma$ with numerator $c=1$, justified by '$f\le1$ on $[0,\pi]$', i.e. by $W_{\mathbb{CP}^2}$ being the global maximizer. That is available only for $n\le11$."*

**It is refuted-as-quantified, and the quantifier matters.** Theorem 4.17 is *stated* for $10\le n\le11$, where $\Theta_{10}=1.2$ and $\Theta_{11}=1.21716$ both sit below $\sqrt{3/2}=1.22474$ and the premise holds. The witness lives at $n=12$, outside the theorem. **So nothing of Nienhaus's is contradicted**: what dies is the *extension* of his proof past $n=11$, and only the $c=1$ step of it. The file's correction 2 says exactly this (*"Claim 2 must say Nienhaus's **proof** does not extend, never that his theorem fails"*) but L103's own heading and its lead sentence *"The witness that kills the $f\le1$ premise"* carry no quantifier, and the block sits **two lines below** the correction that supplies it. A reader arriving at the heading from [INDEX-results.md](../findings/INDEX-results.md) sees the unqualified form.

**The reach is wider than $n=12$, and it is exactly $n\ge12$.** Every ingredient generalises, the split, the padded $\mathbb{CP}^2$ block, and the two orthogonality arguments of §4, which use only $\operatorname{tr}W_{\mathbb{CP}^2}=0$ and $\mathbb R^4\subset V_1$. So an admissible witness exists at every $n$ with $\Theta_n>\sqrt{3/2}$:

| parity | condition | threshold | first $n$ |
| --- | --- | --- | --- |
| even | $4(n-1)(n-2)>3n^2$ | $n>6+2\sqrt7=11.2915$ | $12$ |
| odd | $4(n-1)(n-3)>3(n+1)(n-2)$ | $n>(13+\sqrt{97})/2=11.4244$ | $13$ |

**Combined: the witness exists if and only if $n\ge12$**, with $c_{13}=\sqrt{2/3}\,\Theta_{13}=1.0192944$ and $c_{15}=1.0377490$, the file's own correction 4 values $1.248376$ and $1.270978$ carried through $\sqrt{2/3}$. The block names $n=12$ only, so **the recorded refutation is narrower than the true one**, and the odd-$n$ half needs the repaired $\Theta_n$ rather than $\theta_0(n)$.

**One sentence does not survive.** *"No weaker 'local to the curve' reading escapes"* is **false** if read as localising in $\varphi$: on this very witness $f\le1$ holds on $[0,85.397^\circ]$ (solving $\cos^3\varphi+c_{12}\sin^3\varphi=1$) which contains $(0,\pi/6]$, the entire interval Theorem 4.17's conclusion concerns, with $55^\circ$ to spare. Someone trying to save the proof by weakening the premise to the interval it uses would find the witness silent. **What actually blocks the escape is that $\gamma=f(\pi/2)$ by definition** (Remark 4.18), so the constant the proof needs is the endpoint value however local the conclusion is. The claim is right; the reason is not in the block, and the reason a reader would supply is wrong.

---

## 6. Consumers, pointers and provenance

- **Nothing consumes L103.** [INDEX-results.md:118](../findings/INDEX-results.md#L118) carries it as *"Gate 2: no verdict on the record"*, one of the twenty-five on the debt ledger from the 2026-09-02 numbering pass. No [findings/](../findings/) file cites it.
- **The one pointer that resolves here does so by accident, and it is already recorded.** [L100](../findings/route-a.md)'s *"the same machinery"*, whose nearest antecedent in file order is L103; [r619](REVIEW_r619.md) and [r620](REVIEW_r620.md) both refuted it, the real antecedent being [Lemma L20](../findings/route-a.md)'s proof below. **This audit confirms the negative from the other side**: L103 yields a competitor and a constant, no dichotomy and no machinery, so nothing in L100 can be resting on it.
- **A live broken link, found in passing.** [LEDGER.md:1479](../findings/LEDGER.md#L1479) lists L103 among *"the other Observations carrying Lemmas"* and links it to [diagonal-half.md](../findings/diagonal-half.md). **L103 is in [route-a.md](../findings/route-a.md); the string `L103` does not occur in diagonal-half.md at all.** And the edge itself is the L100 scanner artefact just described, the same class of false edge the surrounding LEDGER passage is diagnosing. *Two defects in one table cell.*
- **Provenance is clean.** `git log -S` on *"whose first factor"*, *"Ascent over the whole complement"* and *"1.009216785"* all bottom out at `ca236478` (2026-08-20), *feat(conjecture-a): prove no maximizer lies near the CP^2 orbit for n >= 12*; the prose was born whole and has moved twice since, through the `51ab61f8` file split and the `05e3efd0` review-index refactor, without alteration. The block makes no self-historical claim to check.
- **Duplication: none under another number.** $1.236033081$ appears in six [findings/](../findings/) files, always as $\theta_0(12)$ and never as a restatement of this witness. The one near-verbatim copy is [report/sections/90-appendix.tex:357](../report/sections/90-appendix.tex#L357), born in the same commit, an expected mirror, but **a fix to L103 must land in both places**, and the appendix copy repeats *"The sharp replacement constant is $c_{12}=1.009216785$"* with no hedge at all.
- **The last sentence checks out.** $\gamma_{\max}(c{=}1)=(1+\alpha)\sqrt{1-2\alpha}$ against the pdftotext reading $\sqrt{1-2\alpha(1+\alpha)}$: [r275's own output](../scripts/reviewers/r275/out_c5.txt) agrees with the first to nine decimals at $\alpha=0.05,0.15,0.25,\tfrac13$ and disagrees with the second at every one, and at $\alpha=\tfrac13$ the value is $4/(3\sqrt3)=0.769800358919501$ exactly. The stationarity equation $(1-\alpha)k^2-ck+\alpha=0$ is derived symbolically there. **One word is loose**: *"verified symbolically"* covers the stationarity equation; the $\gamma_{\max}$ identity was checked numerically at four values of $\alpha$.

---

## 7. What I would change

1. **Put the closed form in the block.** $f(\varphi)=\cos^3\varphi+c_{12}\sin^3\varphi$ with $c_{12}=\sqrt{2/3}\,\theta_0(12)=\sqrt{330}/18$, $c_{12}^2=55/54$, together with the two-line reason both cross terms vanish. That converts every number in L103 into an identity and makes $f(\pi/6)=0.7757$ and *"strictly decreasing on $(0,\pi/6)$"* consequences rather than measurements.
2. **Hedge "sharp", or drop it.** *"attained, and sharp given Conjecture A at $n=12$"* is the true statement. As written it rests on an ascent over $1603$ dimensions.
3. **Replace $4.8\times10^{-16}$ with the commutator argument**, and say both orthogonalities are exact.
4. **Quantify the heading** (*"kills the $f\le1$ premise at every $n\ge12$"*) and state the reach: the witness exists iff $n\ge12$, by $\Theta_n>\sqrt{3/2}$, threshold $6+2\sqrt7$ at even $n$ and $(13+\sqrt{97})/2$ at odd.
5. **Say what the split does**: it fixes admissibility, not the value.
6. **Fix [LEDGER.md:1479](../findings/LEDGER.md#L1479)**, wrong file, and the edge is the known L100 artefact.
7. **Table $f$, $c_n$, $W_1$ and $W_{\mathbb{CP}^2}$ in [conventions.md](../findings/conventions.md)**, with the $W_1$ collision [r465](REVIEW_r465.md) and [r466](REVIEW_r466.md) asked for a session ago.
8. **Reconsider the label.** With item 1 applied the block is analytic apart from item 2; `Lemma` would be defensible for the $f(\pi/2)>1$ half once a Gate 2 verdict exists, with "sharp" carried separately as the conditional claim it is.
