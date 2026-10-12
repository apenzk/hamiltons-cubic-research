# Review r90, the Böhm–Wilking cone bridge

**No numerical checking was used in this review.** Every verification below is hand algebra or exact symbolic/rational computation (sympy `Integer`/`Rational`/`symbols`). No floating point, no sampling, no solvers.

Reviewer 90, cold audit. Primary sources read first, author's write-up read last: [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) (Remarks 1.1.7, 1.1.11, 1.1.16, Lemma 1.1.14, Definition 1.1.17, Example 2.3.5, Remarks 6.3.10 and 6.3.15, Lemmas 6.3.13 and 6.3.16, eqs. (1.2)–(1.6), (2.4), (6.24)–(6.31)) and [boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187) (eqs. (2)–(7), Lemmas 2.1 and 2.2). Claims audited: [findings/problem.md](../findings/problem.md) lines 34–74, [notes.md](../references/beitz-2018-bianchi-convexity/notes.md), [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py).

## Verdicts at a glance

| # | Claim | Verdict |
|---|---|---|
| 1 | The bridge: $F=\lVert R\rVert^2/\lVert\mathrm{ric}\rVert^2$, $\Omega_a=F^{-1}((-\infty,\tfrac4{n-2+4a}])$, quotient-rule expansion | **CONFIRMED** |
| 2 | Cone decomposition and the three endpoints | **CONFIRMED** (all five sub-claims verbatim in Remark 6.3.10) |
| 3 | Beitz proved the $a\to n/4$ end; $\mathrm{Hess}_IG$ negative definite for every $n$; $n\ge12$ absent | **CONFIRMED** |
| 4 | The collapse to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$, including full symmetry of $T$ | **CONFIRMED** (symmetry is a theorem, not an assumption) |
| 5 | $\theta_0(n)$ derived, resting on $\lVert I\rVert^2=n(n-1)/2$ | **CONFIRMED**, and the "convention warning" attached to it is **REFUTED** |
| 6 | Scope: the cone conjecture is strictly more than Conjecture A | **CONFIRMED**, with two refinements |

One sentence in [findings/problem.md](../findings/problem.md) must be struck (claim 5). One literature input is missing from the write-up's table (claim 4). One consequence the write-up misses is recorded at the end.

---

## 1. The bridge, CONFIRMED

Every piece is Beitz's own, and each checks out.

- $F$ is that function: (6.24), $F:\mathrm{scal}^+\to\mathbb R$, $R\mapsto\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, defined on $\mathrm{scal}^+=\{\mathrm{scal}>0\}$ so $\mathrm{ric}\ne0$.
- The sublevel identification is Beitz's, stated one line below (6.24): "its sublevel sets are given by $\Omega_a=F^{-1}((-\infty,\tfrac4{n-2+4a}])$". Elementary: $(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}\rVert^2\iff F\le\tfrac4{n-2+4a}$, valid at $a=0$ as well.
- The quotient rule is (6.25). Re-derived: with $N=\lVert R\rVert^2$, $D=\lVert\mathrm{ric}R\rVert^2$ and $\mathrm{ric}$ linear, $dN(S)=2\langle R,S\rangle$ and $dD(S)=2\langle\mathrm{ric}R,\mathrm{ric}S\rangle$, so $dF_R(S)=\tfrac2{D}(\langle R,S\rangle-F(R)\langle\mathrm{ric}R,\mathrm{ric}S\rangle)$. Since $2/D>0$, $G(R)=dF_R(\Phi(R))\le0\iff\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}R,\mathrm{ric}\Phi(R)\rangle$.
- The ODE is (2.4), $R'=R^2+R^\#=\Phi(R)$, the author's $\Phi$ exactly.

**One step the write-up uses but does not state.** Beitz's Lemma 2.3.4 gives $G\le0\Rightarrow$ invariance. The bridge runs the *other* way (cone invariance $\Rightarrow$ $G\le0$ on $\partial\Omega_a$) and that direction needs its own argument. It holds: if $R_0\in\partial\Omega_a$ had $G(R_0)>0$ then $\tfrac{d}{dt}F(R(t))|_0>0$, so $F(R(t))>\tfrac4{n-2+4a}$ for small $t>0$; and $R(t)$ stays in $\mathrm{scal}^+$ because $\tfrac{d}{dt}\mathrm{scal}=\mathrm{scal}(\Phi(R))=2\lVert\mathrm{ric}R\rVert^2>0$ (Example 2.3.5, p. 29). Hence $R(t)\notin\Omega_a$ and invariance fails. The implication the bridge needs is therefore valid; adding the sentence would close a visible gap.

## 2. The cone endpoints, CONFIRMED

Remark 6.3.10 (p. 97) states the decomposition display verbatim, and all three endpoint claims verbatim: empty for $a>\tfrac n4$; $\Omega_{n/4}=\mathbb R_{>0}\cdot I$; and $\Omega_0=\{\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2,\ \mathrm{tr}(R)>0\}$ with $R_{\mathrm{ric}_0}$ absent from the condition.

Re-derived independently from (1.3)–(1.5) rather than trusted. Beitz's (1.3) gives $\lVert R_I\rVert^2=\tfrac2{n(n-1)}\mathrm{scal}^2$ and $\lVert R_{\mathrm{ric}_0}\rVert^2=\tfrac4{n-2}\lVert\mathrm{ric}_0\rVert^2$; (1.4) gives $\lVert\mathrm{ric}\rVert^2=\lVert\mathrm{ric}_0\rVert^2+\tfrac1n\mathrm{scal}^2$. Substituting,

$$\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2,$$

which is the author's "pinned normalisation", **CONFIRMED**. Feeding it into $(\tfrac{n-2}4+a)(\lVert R_I\rVert^2+\lVert R_{\mathrm{ric}_0}\rVert^2+\lVert R_W\rVert^2)\le\lVert\mathrm{ric}\rVert^2$ gives coefficients $\tfrac{n-2}4+a-\tfrac{n-1}2=\tfrac{4a-n}4$, then $a$, then $\tfrac{n-2}4+a$, the display, exactly.

Consistency anchor: at $R=I$, $\mathrm{scal}(I)=\tfrac{n(n-1)}2$ gives $\lVert I\rVert^2=\tfrac{n(n-1)}2$ from (1.3), and $\tfrac{n-1}2\lVert I\rVert^2=\tfrac{n(n-1)^2}4=\lVert\tfrac{n-1}2\mathrm{id}\rVert^2=\lVert\mathrm{ric}(I)\rVert^2$. The whole system closes on itself.

## 3. Which end Beitz proved, CONFIRMED

Lemma 6.3.16 reads, verbatim: "There is some $\varepsilon>0$ such that $\Omega_a$ respectively $\overline{\Omega_a}$ are invariant under the ordinary differential equation (2.4) for $a\in[\tfrac n4-\varepsilon,\tfrac n4]$." That is the endpoint at which $\Omega_{n/4}$ degenerates to a ray, and at that endpoint invariance is indeed immediate from $\Phi(cI)=c^2(n-1)I$ being tangent to $\mathbb R_{>0}I$.

The Hessian is quoted correctly to the character. Re-derived from scratch:

- $dF_I=0$ and $F(I)=\tfrac2{n-1}$, so (6.26) reduces to $\mathrm{Hess}_IF(S,S)=\tfrac{8}{n(n-1)^2}(\lVert S\rVert^2-\tfrac2{n-1}\lVert\mathrm{ric}S\rVert^2)$, using $\lVert\mathrm{ric}(I)\rVert^2=\tfrac{n(n-1)^2}4$.
- Weyl part: $\mathrm{ric}(R_W)=0$, so $\mathrm{Hess}_IF(R_W,R_W)=\tfrac8{n(n-1)^2}\lVert R_W\rVert^2$, (6.30).
- Traceless-Ricci part: $\lVert\mathrm{ric}_0\rVert^2=\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$ gives factor $1-\tfrac{n-2}{2(n-1)}=\tfrac n{2(n-1)}$, hence $\tfrac4{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2$, (6.31).
- Scale invariance gives $\mathrm{Hess}_{(1+(n-1)s)I}F=(1+(n-1)s)^{-2}\mathrm{Hess}_IF$, so the $s$-derivative contributes $-2(n-1)\mathrm{Hess}_IF(R,R)$; (6.29) contributes $+2(n-2)\mathrm{Hess}_IF(R_{\mathrm{ric}_0},R_{\mathrm{ric}_0})$. Summing, $\mathrm{Hess}_IG(R,R)=-2\mathrm{Hess}_IF(R_{\mathrm{ric}_0},\cdot)-2(n-1)\mathrm{Hess}_IF(R_W,\cdot)=-\tfrac8{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2-\tfrac{16}{n(n-1)}\lVert R_W\rVert^2$.

Both coefficients are negative for every $n\ge4$, so the form is negative definite on $I^\perp=\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ at every dimension. **The proof of Lemma 6.3.16 contains no dimension restriction beyond $n\ge4$** (needed only for the decomposition (1.2) to have a Weyl summand). The author's reading is right: $n\ge12$ appears in the thesis only inside the *statement* of Remark 6.3.15 and in the conditional theorems that quote it.

One fairness note on wording: the lemma covers a neighbourhood $[\tfrac n4-\varepsilon,\tfrac n4]$, not the single ray, so its content (that $I$ is a strict local maximum of $G$), is a real computation. "Covers the degenerate end" is accurate; "invariance is trivial" is accurate only at $a=\tfrac n4$ exactly, which is how the table cell is scoped. No objection.

## 4. The collapse, CONFIRMED, with one missing input

**(a) $\Phi(I,W)=0$.** BW08 Lemma 2.1 reads $R+R\#I=(n-1)R_I+\tfrac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$, and its proof establishes that $\langle W\rangle$ lies in the kernel of $R\mapsto R+R\#I$ (verified directly at $n=4$, then transported by the natural embedding). So $W\#I=-W$, and the polarization $\Phi(B,C)=\tfrac12(BC+CB)+B\#C$ gives $\Phi(I,W)=W+W\#I=0$. Verified independently in exact integer arithmetic at $n=4$ from BW's eq. (4) with the orthonormal basis $b_{ij}=E_{ij}-E_{ji}$ of $\mathfrak{so}(4)$: $I\#I=(n-2)I$ and $W\#I+W=0$ both return exactly zero.

**(b) $\Phi$ preserves Weyl.** BW08 eq. (6), $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$ in an eigenbasis of $\mathrm{Ric}$; for $\mathrm{Ric}(W)=0$ every basis is an eigenbasis and all $\mathrm{Ric}_{kk}=0$, so $\mathrm{Ric}(\Phi(W))=0$. BW draw the same conclusion themselves in the proof of their Theorem 2. Verified exactly at $n=4$ on a Ricci-flat Bianchi operator: $\mathrm{Ric}(Q(W))=0$ and $\mathrm{tr}\,Q(W)=0$.

*Missing input.* Concluding $\Phi(W)\in\langle W\rangle$ needs one more fact than $\mathrm{Ric}(\Phi(W))=0$: that $\Phi$ maps $S^2_B(\mathfrak{so}(n))$ into itself, i.e. preserves the first Bianchi identity. Without it, $\Phi(W)$ could a priori carry a $\Lambda^4(\mathbb R^n)$ component, which is Ricci-free but is not a Weyl operator. This is Hamilton's standard fact, it is what makes ODE (2.4) well posed on $\mathcal A_n$ at all, and BW rely on it, but it is a fourth literature input and the table in [findings/problem.md](../findings/problem.md) lists only three. Add it.

**(c) Full symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$, this is a theorem, not an assumption.** The brief flags it as assumed without proof; it is in fact proved in the source. BW08 eq. (5) defines $\mathrm{tri}(R_1,R_2,R_3)=\mathrm{tr}((R_1R_2+R_2R_1+2R_1\#R_2)R_3)=2T(R_3,R_1,R_2)$ and states "The authors learned from Huisken that $\mathrm{tri}$ is symmetric in all three components", with the proof: $\mathrm{tr}(2(R_1\#R_2)R_3)=\sum_{\alpha\beta\gamma}\langle[R_1b_\alpha,R_2b_\beta],R_3b_\gamma\rangle\langle[b_\alpha,b_\beta],b_\gamma\rangle$, manifestly symmetric.

Re-derived from structure constants rather than trusted. Writing $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$ (totally antisymmetric) and $K(T,R,S)=\sum c_{\alpha\gamma\varepsilon}c_{\beta\delta\zeta}T_{\alpha\beta}R_{\gamma\delta}S_{\varepsilon\zeta}$, each $c$ carries exactly one index from each of the three symmetric pairs. Cyclic permutation of the three roles relabels each $c$ cyclically and $c$ is cyclic; a transposition relabels each $c$ by one swap, contributing $(-1)^2=+1$. So $K$ is invariant under all six permutations, and Beitz's Definition 1.1.17 gives $\langle R\#S,T\rangle=K/2$. Separately $\langle A,\tfrac12(BC+CB)\rangle=\tfrac12(\mathrm{tr}(ABC)+\mathrm{tr}(ACB))$ sums both cyclic classes and so is fully symmetric. Confirmed a third time by exact integer computation at $n=4$: $\mathrm{tri}$ takes one common value across all six permutations of three fixed integer symmetric matrices.

Step (c) does not actually lean on the symmetry, both cross terms die for independent reasons, $T(I,I,W)=(n-1)\langle W,I\rangle=0$ by orthogonality of the decomposition and $T(I,W,W)=\mathrm{tr}(Q(W))=0$ by Ricci-flatness, but the symmetry is available and sound either way.

**(d) The collapse.** With $R=cI+W$, $\Phi(R)=c^2(n-1)I+Q(W)$ and $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)$, so

$$\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle,\qquad F(R)\langle\mathrm{ric}R,\mathrm{ric}\Phi R\rangle=\frac{c^2\lVert I\rVert^2+\lVert W\rVert^2}{c^2\lVert\mathrm{ric}I\rVert^2}\cdot c^3(n-1)\lVert\mathrm{ric}I\rVert^2 = c(n-1)(c^2\lVert I\rVert^2+\lVert W\rVert^2).$$

$\lVert\mathrm{ric}(I)\rVert^2$ cancels, $c^3(n-1)\lVert I\rVert^2$ cancels, and the criterion is $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$. Confirmed symbolically. Worth stressing: **$\lVert I\rVert^2$ drops out of this step entirely**, it re-enters only through the $\partial\Omega_0$ constraint in claim 5.

## 5. $\theta_0(n)$ is genuinely derived, CONFIRMED. The convention warning attached to it is REFUTED.

The derivation is right. On $\partial\Omega_0$ the slice constraint is $\tfrac{n-2}n\lVert W\rVert^2=c^2\lVert I\rVert^2$; at $\lVert W\rVert=1$ and $\lVert I\rVert^2=\tfrac{n(n-1)}2$ this gives $c^2=\tfrac{2(n-2)}{n^2(n-1)}$, hence $c(n-1)=\tfrac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n)$. Verified symbolically: $(c(n-1))^2-\theta_0^2$ simplifies to $0$ identically in $n$.

**But the write-up's justification for $\lVert I\rVert^2$ is false, and it is the one sentence in the file that a reader should not believe.** [findings/problem.md](../findings/problem.md) says:

> Beitz uses $\lVert I\rVert^2=n(n-1)$ (thesis p. 93), differing by a factor $2$ and shifting the constant by $\sqrt2$.

and [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) repeats it in its docstring. Beitz uses $\lVert I\rVert^2=\tfrac{n(n-1)}2$, the project's value, not a competing one. Three independent confirmations:

1. **Definitional, and airtight.** Beitz Remark 1.1.7 (p. 12): "$\langle R,S\rangle=\mathrm{tr}(R\circ S)$, if $R$ and $S$ are considered as self-adjoint endomorphisms on $\Lambda^2V$", and Lemma 1.1.13 fixes $I$ as "the identity in $S^2_B(\Lambda^2V^*)$". Therefore $\lVert I\rVert^2=\mathrm{tr}(I)=\dim\Lambda^2\mathbb R^n=\tfrac{n(n-1)}2$. There is no room for a factor 2.
2. **The thesis says so on the page cited.** The passage is on **p. 98**, not p. 93 (between the page-98 and page-99 headers of the text extraction) and reads "$F(I)=\tfrac2{n-1}$, since $\lVert I\rVert^2=\tfrac{n(n-1)}2$ and $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$".
3. **It is forced by $\Omega_{n/4}=\mathbb R_{>0}I$.** That endpoint requires $F(I)=\tfrac4{n-2+n}=\tfrac2{n-1}$, hence $\lVert\mathrm{ric}I\rVert^2=\tfrac{n-1}2\lVert I\rVert^2$. With $\lVert I\rVert^2=\tfrac{n(n-1)}2$ this is $\lVert\tfrac{n-1}2\mathrm{id}\rVert^2$ exactly; with $n(n-1)$ it would demand $\mathrm{ric}(I)=\tfrac{n-1}{\sqrt2}\mathrm{id}$, which is not a value any convention produces.

The likely origin is a text-extraction artefact: fractions in [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) split across lines with inconsistent ordering, so "$\lVert I\rVert^2=n(n-1)$" on line 5531 with a lone "2" on line 5532 can be read either way. The same trap sits three lines above in Remark 6.3.10, whose extracted $\arctan\sqrt{\tfrac{n-2}n}$ must be $\arctan\sqrt{\tfrac n{n-2}}$ for the stated equivalence with $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$ to hold. **Fractions in this extraction are not trustworthy; the definitions are.**

**Is the match reverse-engineered? No.** Three separate reasons, each sufficient:

- $\lVert I\rVert^2=\dim\Lambda^2$ is forced by the definition of the inner product, in Beitz's convention and BW's alike, with no freedom to choose. It is also what the project's own code computes: [curvature_operator.py](../scripts/curvature_operator.py) builds $\mathfrak{so}(n)$ basis matrices with a single $\pm1$ pair, orthonormal under $\langle X,Y\rangle=\tfrac12\mathrm{tr}(X^\top Y)$, so operator matrices carry $\langle R,S\rangle=\mathrm{tr}(RS)$ and $\lVert I\rVert^2=N=\tfrac{n(n-1)}2$. Verified exactly at $n=4$: $\mathrm{tr}(I)=6$.
- The closed form $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ entered this repository in commit `718f5c8` on **2026-08-19**, seven days before the bridge script `6455cbe` on **2026-08-26**. The constant is older than the derivation that is now said to produce it.
- It is quoted from an independent source: Jäger's Theorem A, transcribed in [findings/problem.md](../findings/problem.md) line 19, uses $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ verbatim.

The match is genuine. The bridge takes a constant already fixed by two outside sources and shows that cone invariance at $a=0$ demands precisely that number.

**The real convention hazard, which the warning misidentifies.** Beitz's Ricci tensor carries an explicit factor $\tfrac12$ relative to BW and Hamilton, Definition 1.1.10: "$\mathrm{ric}(R)(v,w)=\tfrac12\mathrm{tr}(R(v\wedge\cdot,w\wedge\cdot))$ ... Notice, that here we use a different convention for the Ricci tensor ... than e.g. in [BW08]". Consequences: $\mathrm{ric}(I)=\tfrac{n-1}2\mathrm{id}$ rather than $(n-1)\mathrm{id}$; $\lVert\mathrm{ric}\rVert^2$ is a quarter of BW's; the identity in claim 2 reads $\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$ in Beitz's convention and $2(n-1)\lVert R_I\rVert^2+(n-2)\lVert R_{\mathrm{ric}_0}\rVert^2$ in BW's; and the *definition* of $\Omega_a$ is Beitz-specific, since $(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}\rVert^2$ becomes $\le\tfrac14\lVert\mathrm{ric}_{BW}\rVert^2$ if the other Ricci is used.

The derivation survives this untouched, for a reason worth writing down: $F(R)\langle\mathrm{ric}R,\mathrm{ric}\Phi R\rangle$ is invariant under rescaling $\mathrm{ric}$ by any constant, because $F\propto\lVert\mathrm{ric}\rVert^{-2}$ absorbs exactly the square that the pairing introduces. Both the criterion and the decomposed cone condition are convention-free; only the intermediate quantities are not. So the warning paragraph is right that a convention bites here, it names the wrong one, and attributes to Beitz a value he does not use.

**Required edits.** Strike the sentence "Beitz uses $\lVert I\rVert^2=n(n-1)$ (thesis p. 93), differing by a factor $2$ and shifting the constant by $\sqrt2$" from [findings/problem.md](../findings/problem.md), strike the matching line from the [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) docstring, and replace both with the Ricci-factor warning. Left standing, the claim invites exactly the suspicion this review was sent to test, and it does so on the strength of an OCR misreading.

## 6. Scope, CONFIRMED, with two refinements

The characterisation is right, and the unconstrained $R_{\mathrm{ric}_0}$ breaks nothing. Restricting a "for all boundary points" condition to a subset of the boundary is always a valid necessary condition, and the slice $\{cI+W:\ \tfrac{n-2}n\lVert W\rVert^2=c^2\lVert I\rVert^2,\ c>0\}$ genuinely sits inside $\partial\Omega_0$, equality in the defining inequality, and $\mathrm{scal}=c\,\mathrm{scal}(I)>0$. So the $a=0$ cone conjecture implies the slice bound, and the slice bound is $P(W)\le\theta_0(n)$ on unit Weyl operators. The write-up's own hedge ("What is settled is that the target constant is right, not that the two statements coincide"), is the correct level of claim.

Two refinements:

- **The slice delivers the inequality, not the classification.** Conjecture A as recorded in [findings/problem.md](../findings/problem.md) asserts both $\max P=\theta_0(n)$ *and* that the maximizer is the balanced sphere product. The slice yields the upper bound only; equality and rigidity need the sphere product's value from outside. "Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice" is a shade strong, the *bound* is the slice.
- **"Strictly more" is scope, not a proved strictness.** Boundary points with $R_{\mathrm{ric}_0}\ne0$ impose further conditions; whether any of them fails to follow from the slice bound is untested here. The phrasing "strictly more than Conjecture A" reads as proved separation. "Contains Conjecture A's bound as one slice" would be exact.

## Consequence the write-up misses: the bridge explains $n\ge12$, and shows it is sharp at $a=0$

Beitz records $n\ge12$ as part of Remark 6.3.15's statement, and [notes.md](../references/beitz-2018-bianchi-convexity/notes.md) concludes "Whatever forces $n\ge12$ lives elsewhere". The bridge locates it. Zero-padding the $\mathbb{CP}^2$ Weyl operator gives a unit Weyl operator with $P=\sqrt{3/2}$ at every $n$ (recorded in [findings/problem.md](../findings/problem.md) line 132). Running it through the slice, $R=cI+W_{\mathbb{CP}^2}$ is a point of $\partial\Omega_0$ with $G(R)>0$ whenever $\sqrt{3/2}>\theta_0(n)$, and

$$\theta_0(n)>\sqrt{3/2}\iff\frac{2(n-1)(n-2)}{n^2}>\frac32\iff n^2-12n+8>0\iff n>6+2\sqrt7 .$$

At $n=11$, $121-132+8=-3<0$; at $n=12$, $144-144+8=8>0$. So $\Omega_0$ **fails** to be invariant for $8\le n\le11$, and the threshold in the Böhm–Wilking conjecture is not a proof artefact at $a=0$, it is exactly where the $\mathbb{CP}^2$ obstruction clears. That is a stronger statement than the write-up currently makes and follows from material already in the file.

## Minor corrections

| Where | Says | Should say |
|---|---|---|
| [findings/problem.md](../findings/problem.md) input table | "Beitz p. 96" for $\partial\Omega_0$ | p. 97 (Remark 6.3.10) |
| [findings/problem.md](../findings/problem.md) convention warning | "thesis p. 93" | p. 98, and the claim itself is wrong (claim 5) |
| [notes.md](../references/beitz-2018-bianchi-convexity/notes.md) | Remark 6.3.15 "p. 100" | p. 99 |
| [notes.md](../references/beitz-2018-bianchi-convexity/notes.md) | "A Weyl tensor has $\mathrm{ric}=0$, which is where $F$ blows up: Weyl tensors are the extremal directions of the cone family" | A pure Weyl operator has $\mathrm{scal}=0$, so it lies outside $\mathrm{scal}^+=\mathrm{dom}(F)$ and is not a point of any $\Omega_a$. The precise statement is the one the bridge proves: the extremal boundary points of $\Omega_0$ in the $R_{\mathrm{ric}_0}=0$ slice are $cI+W$ with $c>0$, and the Weyl part is what the criterion bounds there. |

## What was checked exactly, and how

Exact rational computation at $n=4$ from BW08 eq. (4) with $b_{ij}=E_{ij}-E_{ji}$ and $\langle A,B\rangle=-\tfrac12\mathrm{tr}(AB)$, all entries integer:

| Check | Result |
|---|---|
| $\lVert I\rVert^2=\mathrm{tr}(I)$ | $6=\tfrac{n(n-1)}2$ |
| $I\#I-(n-2)I$ | zero matrix |
| $W\#I+W$ for Ricci-flat Bianchi $W$ | zero matrix |
| $\Phi(I,W)=\tfrac12(IW+WI)+W\#I$ | zero matrix |
| $\mathrm{Ric}(Q(W))$, $\langle I,Q(W)\rangle$ | zero, zero |
| $\mathrm{tri}$ over all six permutations of three fixed integer symmetric matrices | one common value |

Symbolic in $n$: the criterion difference reduces to $c(n-1)\lVert W\rVert^2-\langle W,Q(W)\rangle$, and $(c(n-1))^2-\theta_0(n)^2=0$ identically.

---

**Bottom line.** The bridge is sound and the derivation of $\theta_0(n)$ stands, every load-bearing step is either verbatim in the sources or re-derived here, and the constant was fixed by two independent routes before this derivation existed. The suspicion the brief raised is answerable in the author's favour, but the sentence that raised it is itself an error and has to go: Beitz uses the same $\lVert I\rVert^2=\tfrac{n(n-1)}2$ the project does, and the convention that actually differs between the two sources is the Ricci factor $\tfrac12$, which the criterion is invariant under.
