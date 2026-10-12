# Reviewer 91, the off-slice expansion, the classification claim, the parity argument, fence posts 1–2

**No numerical checking was used anywhere in this report.** Every verification is exact symbolic algebra (sympy `Rational`/`Symbol`, no floating point, no sampling, no solvers) or hand algebra. Where a magnitude is quoted it is quoted as an exact surd or rational.

Worked cold: [Xu](https://arxiv.org/abs/2412.13633) Sections 2–3, [Böhm–Wilking](https://arxiv.org/abs/math/0606187) Section 1–2, [Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) Section 6.3.2 and [Nienhaus](https://arxiv.org/abs/2311.02404) Chapters 1–2 were read and the algebra redone before opening [problem.md](../findings/problem.md).

---

## Verdicts at a glance

| # | Claim | Verdict |
|---|---|---|
| 1 | Exactly five of ten triples survive; multiplicities 1/3/3/6; new coupling $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ | **CONFIRMED**, exactly |
| 2 | The expansion is Xu (2.34) term for term, coefficient included | **CONFIRMED**, exactly |
| 2a | "That is the bridge, and it had not been derived" | **REFUTED**, published in *both* [Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) (6.24)–(6.25) + Lemma 6.3.16 and [Xu](https://arxiv.org/abs/2412.13633) (3.1)–(3.4) |
| 2b | The $a=0$ slice criterion is exactly $\theta\le\theta_0(n)$ | Algebra **CONFIRMED**; novelty **REFUTED in substance**, two-line specialisation of Xu (3.5), constant and threshold are [Nienhaus](https://arxiv.org/abs/2311.02404) Definition 2.28 |
| 2c | $n\ge12$ necessary, via padded $W_{\mathbb{CP}^2}$ | Mathematics **CONFIRMED**; novelty **overstated**, the polynomial is Nienhaus's $\alpha_n$ vs $\beta_n$, which I re-derived from his two displayed $\cos^2$ formulas |
| 3 | The two-sided parity conclusion | **CONFIRMED** step by step; but it is a rewriting that extracts no information |
| 4 | Fence post F2 (overshoot $1.7$–$1.8\times$) | **CONFIRMED**, exactly, and strengthenable |
| 4 | Fence post F1 (eigenvalue-only inequalities can never be sharp) | **OVERSTATED**, false as literally written; the [ATTEMPTS.md](../ATTEMPTS.md) version is correct |
| 4 | The two posts rule out a Tachibana-bound route | **REFUTED**, they rule out one additive combination, not the method |

---

## 1. The off-slice expansion, CONFIRMED, exactly

Set $R=cI+Y+W$ with $c=\bar\lambda/(n-1)$, $Y=R_{\mathrm{ric}_0}$. Since $\Phi$ is quadratic and $\mathrm{tri}$ is fully symmetric ([BW08](https://arxiv.org/abs/math/0606187) eq. (5)),

$$\langle\Phi(R),R\rangle=\tfrac12\mathrm{tri}(R,R,R)=\sum_a\langle\Phi(X_a),X_a\rangle+3\sum_{a\ne b}\langle\Phi(X_a),X_b\rangle+6\langle\Phi(X_1,X_2),X_3\rangle,$$

so the multinomial multiplicities are $1$ on $(aaa)$, $3$ on each of $(aab)$ and $(abb)$ separately, $6$ on $(abc)$, ten distinct triples, and **the stated $1,3,3,6$ pattern is right**.

Triple by triple, using [Xu](https://arxiv.org/abs/2412.13633) Proposition 2.7 and the symmetry of $\mathrm{tri}$ to move the pairing onto the convenient slot:

| triple | mult. | value | why |
|---|---|---|---|
| $(I,I,I)$ | 1 | $c^3(n-1)\lVert I\rVert^2$ | $\Phi(I)=(n-1)I$ from BW08 Lemma 2.1 |
| $(I,I,Y)$ | 3 | $0$ | $\Phi(I)\in\langle I\rangle\perp Y$, Xu (1) |
| $(I,I,W)$ | 3 | $0$ | $\mathrm{tri}(I,I,W)=2\langle\Phi(I,W),I\rangle=0$, Xu (3) |
| $(I,Y,Y)$ | 3 | $3c\langle I,\Phi(Y)\rangle$ | Xu (2.38) |
| $(I,Y,W)$ | 6 | $0$ | $\mathrm{tri}(I,Y,W)=2\langle\Phi(I,W),Y\rangle=0$, Xu (3) |
| $(I,W,W)$ | 3 | $0$ | $\mathrm{tri}(I,W,W)=2\langle\Phi(I,W),W\rangle=0$, Xu (3) |
| $(Y,Y,Y)$ | 1 | $\langle Y,\Phi(Y)\rangle$ | Xu (2.39) |
| $(Y,Y,W)$ | 3 | $\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ | Xu (2.31)/(2.40) |
| $(Y,W,W)$ | 3 | $0$ | $\Phi(W)\in\langle W\rangle\perp Y$, Xu (4) |
| $(W,W,W)$ | 1 | $\langle W,\Phi(W)\rangle$ |, |

Five survive, five vanish, and the surviving list is exactly the author's. The parenthetical "the five that vanish include every $I$–$W$ pairing, by Xu (3)" is correct as an inclusion: $(I,I,Y)$ and $(Y,W,W)$ die by (1) and (4) instead.

**One phrasing correction.** [problem.md](../findings/problem.md) says BW08 Lemma 2.2 "supplies the block Xu's list omits". Xu's *Proposition 2.7* omits it; Xu's *paper* does not, it is his own (2.31) (his Lemma 2.6 restates BW08 Lemma 2.2 verbatim) and he uses it at (2.40) for exactly this term. As written the sentence invites the reader to think the $\tfrac1{n-2}$ block was unavailable in Xu.

---

## 2. The classification claim, and what else in the chain is already published

### 2.0 The agreement with Xu (2.34), CONFIRMED

[Xu](https://arxiv.org/abs/2412.13633) Lemma 2.8 eq. (2.34) maps term for term onto the five survivors, with the first term checked as an identity rather than a shape match:

| Xu (2.34) | author's term | check |
|---|---|---|
| $\frac n{2(n-1)}\bar\lambda^3$ | $c^3(n-1)\lVert I\rVert^2$ | $c=\frac{\bar\lambda}{n-1}$, $\lVert I\rVert^2=\frac{n(n-1)}2\Rightarrow c^3(n-1)\lVert I\rVert^2=\frac{n\bar\lambda^3}{2(n-1)}$ ✓ |
| $\frac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2$ | $3c\langle I,\Phi(Y)\rangle$ | Xu (2.38) gives $\langle\Phi(Y),R_I\rangle=\frac{\bar\lambda\lvert\mathrm{Ric}_0\rvert^2}{2(n-1)}$ ✓ |
| $\frac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$ | $3\langle W,\Phi(Y)\rangle$ | Xu (2.40) ✓, **coefficient matches** |
| $-\frac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle$ | $\langle Y,\Phi(Y)\rangle$ | Xu (2.39) ✓ |
| $\langle Q(W),W\rangle$ | $\langle W,Q(W)\rangle$ | ✓ |

The ordering claimed in [problem.md](../findings/problem.md) ($(I,I,I),(I,Y,Y),(Y,Y,W),(Y,Y,Y),(W,W,W)$), is Xu's display order. The classification as "agreement, not new" is correct, and Xu's own attribution to Huisken's proof of his Theorem 3.3 is accurate.

### 2a. The bridge, REFUTED as new. It is published twice, in the author's own local sources.

[problem.md](../findings/problem.md) states: *"That is the bridge, and it had not been derived."* It had.

**[Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf), p. 97–99.** She defines $F:\mathrm{scal}^+\to\mathbb R$, $R\mapsto\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ at (6.24), computes at (6.25)

$$dF_R(S)=\frac2{\lVert\mathrm{ric}(R)\rVert^2}\Big(\langle R,S\rangle-F(R)\langle\mathrm{ric}(R),\mathrm{ric}(S)\rangle\Big),$$

notes $\Omega_a=F^{-1}((-\infty,\tfrac4{n-2+4a}])$, and then opens the proof of Lemma 6.3.16 with *"we consider the function $G:\mathrm{scal}^+\to\mathbb R:R\mapsto dF_R(\Phi(R))$, where $\Phi(R):=R^2+R^\#$, and show that restricted to $\Omega_a$ it is non-positive."* Substituting $S=\Phi(R)$ into (6.25) **is** $G(R)\le0\iff\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$. The letter $G$, the function $F$, and the equivalence are all hers.

**[Xu](https://arxiv.org/abs/2412.13633), Section 3.1.** Same $F$, differential at (3.1), substitution $S=Q(R)$ at (3.2), and then (3.3)–(3.4) stated as *"the main task is to look for all the possible $a$ such that $\langle R,Q(R)\rangle-F(R)\langle\mathrm{Ric}(R),\mathrm{Ric}(Q(R))\rangle\le0$, $\forall R\in\partial\Omega(a)$."* That is the bridge as a displayed equation.

**This is the third time on record that a published item has been booked as new** (the file itself already carries two retractions of the same kind, at Theorem 4.19 and at the $S^4\times S^{n-4}$ "new closed form"). The pattern is not accidental: in each case the author derived correctly, then searched only for the *identity* and not for the *framework* it sits in.

**Downstream corrections.** The note that *"the bridge needs invariance $\Rightarrow G\le0$, where Beitz Lemma 2.3.4 supplies only the converse; it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$"* is superfluous and misattributed. [Xu](https://arxiv.org/abs/2412.13633) Proposition 2.2 states the **iff**, *"a closed convex $O(n)$-invariant subset $C$ is invariant under the Hamilton ODE if and only if for all $R\in\partial C$ we have $Q(R)\in T_I8$"*, attributed to Hamilton. The necessity direction is therefore in hand from the same paper, and the scalar-curvature argument is not needed (nor does it, as written, establish necessity; the working argument is that $dF_R(Q(R))>0$ makes $F$ increase, so the flow exits the sublevel set).

### 2b. The $a=0$ slice criterion, algebra CONFIRMED, novelty refuted in substance

I redid the collapse from scratch in Xu's convention ($\mathrm{Ric}(I)=(n-1)\,\mathrm{id}$), with $\lVert W\rVert=1$:

$$\mathrm{LHS}=c^3\tfrac{n(n-1)^2}2+P(W),\qquad \mathrm{RHS}=\frac{c^2\frac{n(n-1)}2+1}{c^2(n-1)^2n}\cdot c^3(n-1)^3n=c^3\tfrac{n(n-1)^2}2+c(n-1),$$

so $\mathrm{RHS}-\mathrm{LHS}=c(n-1)-P(W)$ **identically**, the "no residue at all" claim is exact, verified symbolically. On $\partial\Omega_0$, $\tfrac{n-2}n=c^2\tfrac{n(n-1)}2$ gives $c^2(n-1)^2=\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, checked as an exact zero. **The derivation is right.**

What it is *not* is new content. Three points, in increasing order of severity.

1. **It is a two-line specialisation of Xu (3.5).** Xu's (3.5) is the fully general expansion of the bridge's two sides for arbitrary $R\in\partial\Omega(a)$. Put $\mathrm{Ric}_0=0$ and $a=0$ (so $F(R)=\tfrac1{n-2}$) and three of its four terms vanish, leaving $\big(\tfrac1{2(n-1)}-\tfrac1{n-2}\big)n\bar\lambda^3+\langle Q(W),W\rangle\le0$, i.e. $\langle Q(W),W\rangle\le\tfrac{n^2\bar\lambda^3}{2(n-1)(n-2)}$, which on $\partial\Omega_0$ is $\bar\lambda=\theta_0(n)$. Xu never takes $a=0$ because his theorem lives at the other end of the interval, but the identity he needed and displayed is the same one.
2. **The constant and its threshold role are [Nienhaus](https://arxiv.org/abs/2311.02404) Definition 2.28.** He calls $\lambda$ *intermediate* when $\lambda\in\big[\tfrac1n\sqrt{2(n-1)(n-2)},\sqrt{3/2}\,\big]$ for $n$ even, and $\lambda\in\big[\sqrt2\sqrt{\tfrac{(n-1)(n-3)}{(n+1)(n-2)}},\sqrt{3/2}\,\big]$ for $n$ odd. The even endpoint is $\theta_0(n)$ verbatim; the odd endpoint squared is $\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}$, which is exactly the number the "Sharpness at even $n$ only" paragraph (Reviewer 89) reports as reproducing "the partition argument's values". Both parities are already in print in a source in this repo.
3. **$\partial\Omega_0$ *is* Nienhaus's angle $\beta_n$.** He computes $\cos^2\sphericalangle(R_{\lambda,n},\mathrm{Id}_n)=\tfrac{\lambda^2n}{\lambda^2n+2(n-1)}$ and $\cos^2\sphericalangle(R^{\mathrm{crit}}_{\mathrm{sym},n},\mathrm{Id}_n)=\tfrac{n-2}{2(n-1)}$ at even $n$. I checked symbolically that substituting $\lambda=\theta_0(n)$ into the first returns $\tfrac{n-2}{2(n-1)}$ identically, and that $\tan^2\beta_n=\tfrac n{n-2}$, which is Beitz's $\Omega_0$ condition $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$ restated. So "the $a=0$ cone boundary" and "the angle of the balanced sphere product" are the same locus, and the translation is one substitution into a formula Nienhaus displays.

**Verdict.** The claim *"$\theta_0(n)$ IS DERIVED, NOT POSITED"* is true and the derivation is clean. The implicit claim that this was unavailable is false: the constant, its two-parity form, and its status as the boundary between the sphere-product regime and the $\mathbb{CP}^2$ regime are all in [Nienhaus](https://arxiv.org/abs/2311.02404), and the identity that converts the cone criterion into it is Xu (3.5).

**One gap the write-up does not name.** The bridge at slice points of $\partial\Omega_0$ demands $P(W)\le\theta_0(n)$ for *every* unit Weyl $W$, whereas Nienhaus's Conjecture A assumes $W$ critical. The two are equivalent only because $P$ attains its maximum on the compact unit sphere and the maximiser is automatically critical. That is a one-line argument, but it is the step that makes "the criterion at $a=0$ is Conjecture A" a true sentence rather than a near-miss, and it is absent.

### 2c. $n\ge12$ necessary, mathematics CONFIRMED, novelty overstated

The chain checks out. Padded $W_{\mathbb{CP}^2}$ is Ricci-flat in $\mathbb R^n$ for every $n\ge4$ with $P(W)=\sqrt{3/2}$ (this is [Nienhaus](https://arxiv.org/abs/2311.02404)'s own normalisation: $R^{\mathrm{crit}}_{\mathbb{CP}^2}=\tfrac{\sqrt{3/2}}{n-1}\mathrm{Id}_n+W_{\mathbb{CP}^2}$ is critical precisely because $Q(W)=\sqrt{3/2}\,W$, so the sign is positive and the violation is real, not an artefact of orientation). Setting $c=\theta_0(n)/(n-1)$ puts $R=cI+W$ on $\partial\Omega_0$ with $\mathrm{scal}=cn(n-1)>0$; $dF_R\ne0$ there by Beitz Lemma 6.3.12, so the tangent cone is the half-space $\{dF_R\le0\}$ and $dF_R(Q(R))>0$ contradicts Xu Proposition 2.2. $\Omega_0$ is non-invariant exactly when $\theta_0(n)<\sqrt{3/2}$, i.e. $n^2-12n+8<0$, i.e. $4\le n\le11$. **Correct.**

But the polynomial is not new here, and neither is the witness. Computing Nienhaus's own two displayed quantities,

$$\cos^2\alpha_n-\cos^2\beta_n=\frac{3n}{7n-4}-\frac{n-2}{2(n-1)}\quad\text{has numerator}\quad -(n-1)(n^2-12n+8),$$

verified as an exact factorisation. That is his introduction's sentence *"a simple computation shows that $\alpha_n<\beta_n$ for $n\le11$, while for $n\ge12$ the inequality turns around"*, the same polynomial, from the same witness, in print. His Conjecture A already carries the explicit exception $W\in SO(n).W_{\mathbb{CP}^2}$ for $8\le n\le11$. And [problem.md](../findings/problem.md) itself, forty lines earlier, calls $n=6+2\sqrt7$ "the documented integer threshold, confirmed three independent ways".

What is genuinely added is the *implication direction*: nobody in the three sources says "hence $\Omega_0$ fails to be ODE-invariant below $n=12$". That is real but it is a two-line corollary, and the heading *"$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT, and it is the same polynomial a fifth time"* is a fifth sighting of a published inequality dressed as a discovery. Its own subtitle concedes as much.

---

## 3. The parity argument, CONFIRMED, every step, but it extracts nothing

Each premise checks out.

- **$-W$ is admissible.** $-W$ satisfies the first Bianchi identity and is Ricci-flat, so $cI+Y-W\in S^2_B(\mathfrak{so}(n))$. The $\Omega_a$ constraint in Beitz's Remark 6.3.10 form, $\tfrac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\big(\tfrac{n-2}4+a\big)\lVert R_W\rVert^2\le0$, depends on $W$ only through $\lVert W\rVert^2$. **This holds for every $a$, not only $a=0$**, the write-up restricts to $a=0$ unnecessarily.
- **$\mathrm{scal}>0$ survives.** $\mathrm{Ric}(W)=0$, so $\mathrm{scal}$ is $W$-independent. No failure here.
- **$\mathrm{ric}(R)$ is $W$-free** ✓, **$F(R)$ is $W$-even** ✓ (numerator $c^2\lVert I\rVert^2+\lVert Y\rVert^2+\lVert W\rVert^2$, denominator $W$-free).
- **Only $2\Phi(Y,W)$ is $W$-odd in $\mathrm{ric}(\Phi(R))$.** Expanding $\Phi(cI+Y+W)$ into six pieces: $\Phi(cI,W)=0$ by Xu (3); $\Phi(W)\in\langle W\rangle$ by Xu (4), hence $\mathrm{Ric}(\Phi(W))=0$; $2\Phi(Y,W)\in\langle\mathrm{Ric}_0\rangle$ by Xu (5) and is linear in $W$. ✓ The paragraph in [problem.md](../findings/problem.md) cites only Xu (5) and leaves the other two implicit; they are stated elsewhere in the file, so this is a write-up gap, not an error.
- **The two-sided conclusion.** Adding and subtracting the criteria at $\pm W$ gives $\mathrm{LHS}_e\le\mathrm{RHS}_e$ and $\lvert\mathrm{LHS}_o-\mathrm{RHS}_o\rvert\le\mathrm{RHS}_e-\mathrm{LHS}_e$. ✓ Valid.
- **The $Y=0$ consistency check.** It returns $\lvert P(W)\rvert\le\theta_0(n)$, the two-sided form of the bridge, which is correct and equivalent, since $-W$ is admissible whenever $W$ is.

**Where I part company with the write-up.** The conclusion carries no information beyond "the criterion holds at both $\pm W$", which is already contained in "the criterion holds at every point of $\partial\Omega_0$", the hypothesis being used. The whole content is the single observation that the constraint set is $W$-even; the even/odd split is bookkeeping on top of it. Calling it "the part not in Xu" is literally true, and it is also true of any rearrangement of an equation. It should be labelled as presentation, not as a result.

---

## 4. Fence posts 1 and 2

Everything below is exact algebra at the balanced sphere product $S^p\times S^p$, $n=2p$, Einstein-normalised. With $\mu=\tfrac1{2p-1}$, the coordinate-diagonal Weyl eigenvalues are $a=\tfrac1{p-1}-\mu$ within a block and $-\mu$ across, giving

$$\lVert W\rVert^2=\frac{p^2}{(p-1)(2p-1)},\qquad \mathrm{tr}(W^3)=\frac{p^2}{(p-1)^2(2p-1)^2},\qquad \langle Q(W),W\rangle=\lVert W\rVert^2 .$$

### Fence post F2, CONFIRMED, exactly, and it is stronger than stated

Write $B_1=\sqrt2\tfrac{n-3}{\sqrt{(n-1)(n-2)}}$ (the vertex-matrix bound on $\langle W^\#,W\rangle$), $B_2=\tfrac{N-2}{\sqrt{N(N-1)}}$ with $N=\tfrac{n(n-1)}2$ (Huisken (2.45) applied to $W$ on $\Lambda^2$), and $\theta_0=\tfrac{\sqrt{2(n-1)(n-2)}}n$.

Verified as exact zeros: $P^2/\lVert W\rVert^6=\theta_0^2$ and $\langle W^\#,W\rangle^2/\lVert W\rVert^6=B_1^2$ identically in $p$. **So $B_1$ is saturated exactly at every even $n$, a theorem in $p$, not a scan.** Consequently

$$\frac{B_1}{\theta_0}=\frac{n(n-3)}{(n-1)(n-2)}=1-\frac2{(n-1)(n-2)},\qquad \frac{\mathrm{tr}(W^3)}{P(W)}=\frac2{(n-1)(n-2)} .$$

The sum ratio has the exact closed form $\tfrac{n(n-3)}{(n-1)(n-2)}+\tfrac{(N-2)n}{\sqrt{2N(N-1)(n-1)(n-2)}}$, with

$$\lim_{n\to\infty}\frac{B_1+B_2}{\theta_0}=1+\frac{\sqrt2}2=\frac{2+\sqrt2}2,$$

and exact values $\tfrac9{10}+\tfrac{13\sqrt{21}}{70}$ at $n=6$, $\tfrac{54}{55}+\tfrac{64\sqrt{78}}{715}$ at $n=12$, $\tfrac{170}{171}+\tfrac{188\sqrt{210}}{3591}$ at $n=20$, $\tfrac{4850}{4851}+\tfrac{24740\sqrt{202}}{489951}$ at $n=100$, all in $(1.70,1.78)$, peaking near $n=12$. **The $1.7$–$1.8\times$ figure is exactly right.**

The post is in fact stronger than it claims, and the stronger form is cleaner: since $B_1$ alone already equals $\theta_0\big(1-\tfrac2{(n-1)(n-2)}\big)$, **any** nonnegative bound on $\lvert\mathrm{tr}(W^3)\rvert$ that is not itself saturated at the balanced sphere product makes the sum overshoot. Additivity fails not because two bounds are individually loose but because they cannot be jointly saturated. The stated reason, *"the vertex matrix $\Lambda$ and the full operator $W$ cannot both sit at their individual extremes"*, is the right diagnosis; at the maximiser $\Lambda$ **is** at Huisken's extremal profile, which is precisely why $W$ on $\Lambda^2$ is nowhere near it, and $B_2$ overshoots the true $\mathrm{tr}(W^3)$ there by the factor $\tfrac{(N-2)\,n\sqrt{(n-1)(n-2)}}{2\sqrt2\,\sqrt{N(N-1)}}$, of order $n^2$.

### Fence post F1, OVERSTATED as written

*"Eigenvalue-only inequalities can never be sharp"* is false as a sentence. The target inequality $P(W)\le\theta_0(n)\lVert W\rVert^3$ depends on nothing but $\lVert W\rVert$ (the crudest possible spectral functional) and it is sharp at even $n$. What is true is the [ATTEMPTS.md](../ATTEMPTS.md) version: *no inequality of Tachibana/Lemma-2.10 type can be sharp for $\langle W^\#,W\rangle$, because $W^\#$ is not a function of $W$'s spectrum.* The fence-post compression dropped the qualifier "of Lemma-2.10 type ... for $\langle W^\#,W\rangle$" and turned a correct statement about *proof techniques* into a false statement about *inequalities*.

Two further inaccuracies in the same two lines. *"Existing Tachibana/Hölder estimates bound $\mathrm{tr}(W^3)$ sharply"* is sharp-in-class only, sharp over trace-free symmetric operators on $\Lambda^2$, and off by order $n^2$ over Weyl operators, per the factor above. And the fence-post file's own header calls these entries "proven or machine-verified negatives"; post F1 is neither, it is a heuristic.

### Do posts 1 and 2 rule out the Tachibana route?, REFUTED

They do not, and the evidence in this repo points the other way.

- **What the posts actually kill** is one additive combination: bound $\langle W^\#,W\rangle$ and $\mathrm{tr}(W^3)$ separately, then add. That is dead, unconditionally, by the sharper form above.
- **The published Tachibana bound is not that combination.** [Xu](https://arxiv.org/abs/2412.13633) Lemma 2.14 bounds the *whole* $\lvert\langle Q(W),W\rangle\rvert$ in one shot via the auxiliary two-forms $\xi_{ijkl}$, the identity $\sum\langle W(\xi),\xi\rangle=-16\langle Q(W),W\rangle$, and $\sum\lVert\xi\rVert^2=16(n-1)\lVert W\rVert^2$. It never splits into the two pieces the fence posts talk about. Neither post applies to it.
- **Its lossiness is localised to one step, and is exactly quantifiable.** I computed $\big(\text{Xu Lemma 2.14}/\theta_0\big)^2=\tfrac{n(n+1)}2$ exactly. So the published bound overshoots the conjectured maximum by $\sqrt{n(n+1)/2}$, a factor $\sqrt{78}$ at $n=12$, growing like $n$. Every bit of that loss enters at (2.55), the Rayleigh estimate $\langle W(\xi),\xi\rangle/\lVert\xi\rVert^2\le\sqrt{(N-1)/N}\,\lVert W\rVert$, which discards all structure of $\xi$ and of $W$'s eigenspaces. Replacing that one step is untouched by post F1 (which is about splitting into two terms) and by post F2 (which is about adding two bounds).
- **The trend is favourable, not fatal.** The published bound is off by $\Theta(n)$; the vertex-matrix refinement recorded in this repo already brought the additive route down to a *constant* $1.77$. A route whose gap fell from $\Theta(n)$ to a fixed factor under $2$ is not a route a fence post should be closing.

**Blunt version:** posts 1 and 2 justify abandoning the sum $B_1+B_2$. If they were used to abandon the Tachibana $\xi$-machinery itself, that was a mistake, and the cheapest test of it is to re-derive Lemma 2.14 with (2.55) replaced by anything that sees the eigenspace alignment $\xi$ carries.

---

## 5. Other cone-bridge material

**Correct, checked independently:** BW08 Lemma 2.1 and the kernel statement $W+W^\#I=0$ (also [Nienhaus](https://arxiv.org/abs/2311.02404) states it), hence $\Phi(I,W)=\tfrac12(IW+WI)+W^\#I=W-W=0$; BW08 eq. (6) and the cleaner $\mathrm{Ric}(Q(R))=\mathring R(\mathrm{Ric})$ of Xu (2.26), giving that $\Phi$ preserves Weyl; the symmetry of $\mathrm{tri}$ as BW08 eq. (5) with its attribution to Huisken; the $\Omega_a$ table (empty above $n/4$, the single ray at $n/4$, $R_{\mathrm{ric}_0}$ unconstrained at $0$); the reading of Lemma 6.3.16 as covering the degenerate end; the "Scope, stated plainly" paragraph, which is honest and right.

**The convention discussion is correct**, and I re-derived it rather than trusting it: Beitz states $\lVert I\rVert^2=\tfrac{n(n-1)}2$ and $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$ in her own text, which gives $F(I)=\tfrac2{n-1}$ and confirms both that the norm agrees with this project's and that her $\mathrm{ric}$ is half BW08's $\mathrm{Ric}$. The earlier factor-2 warning was rightly withdrawn.

**A genuine typo in Beitz, worth flagging so nobody propagates it.** Her displayed second form of $\Omega_0$ reads $\sphericalangle(R_I+R_W,I)\le\arctan\sqrt{\tfrac{n-2}n}$. Her own first form, $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, gives $\tan\sphericalangle=\tfrac{\lVert R_W\rVert}{\lVert R_I\rVert}\le\sqrt{\tfrac n{n-2}}$, the reciprocal. Independent confirmation from a second source: Nienhaus's $\cos^2\beta_n=\tfrac{n-2}{2(n-1)}$ gives $\tan^2\beta_n=\tfrac n{n-2}$. [problem.md](../findings/problem.md) quotes only the inequality form, so nothing here is contaminated, but the angle form should never be quoted from that page.

**Overstatements to fix in [problem.md](../findings/problem.md):**

1. *"That is the bridge, and it had not been derived"*, delete, and cite Beitz (6.24)–(6.25) with Lemma 6.3.16, and Xu (3.1)–(3.4).
2. *"the earlier note that the thesis gives the conjecture 'not [in] the $P(W)$-maximization formulation' is right about the wording and wrong about the content"*, the earlier note was right about the wording *and* the thesis does not do the $P$-maximisation; what the thesis does have is the bridge, which is a different object. The sentence takes credit for closing a gap that was closed by reading two more pages of a source already transcribed.
3. *"$\theta_0(n)$ IS DERIVED, NOT POSITED"*, keep the derivation, drop the implied priority; add the Nienhaus Definition 2.28 citation for both parities.
4. *"$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT"*, keep, but state it as a corollary of the published $\alpha_n$ vs $\beta_n$ comparison rather than as a discovery, and note that the exact factorisation $\cos^2\alpha_n-\cos^2\beta_n\propto-(n-1)(n^2-12n+8)$ falls straight out of Nienhaus's two displayed formulas.
5. *"BW08 Lemma 2.2 ... supplies the block Xu's list omits"*, say "Xu's Proposition 2.7 omits"; Xu's (2.31) has it.
6. *"the bridge needs invariance $\Rightarrow G\le0$, where Beitz Lemma 2.3.4 supplies only the converse"*, Xu Proposition 2.2 supplies the iff.
7. The parity paragraph should say that it is a rewriting of the criterion at two points, not an additional constraint.

**Nothing in the cone-bridge material is mathematically wrong.** Every displayed identity I checked came out exact. The defect is entirely one of attribution and of proportion in the headings, and it is the same defect three times over.

---

## Standing summary

The mathematics in this chain is sound: the five-term expansion, its agreement with Xu (2.34), the zero-residue collapse at $a=0$, the value $\theta_0(n)$, the $n\le11$ failure, and the parity split are all exactly as claimed, and I verified each symbolically. What is not sound is the accounting. The bridge is published twice in sources already sitting in this repo; the constant and its two-parity form are published in a third; the $n\ge12$ polynomial is published in the same third source in one line. The one part correctly labelled new (the parity argument), is the one part that carries no information. And fence post F1, which was used to close a route, is false as written.
