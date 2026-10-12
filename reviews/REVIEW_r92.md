# Reviewer 92, the cone bridge, the off-slice expansion, the parity argument, and fence posts 1–2

**NO NUMERICAL CHECKING WAS USED IN THIS REPORT.** Every computation below is exact: `fractions.Fraction` / `sympy.Rational` integer-and-rational arithmetic on curvature tensors, sympy symbolic algebra in $c,m,n$, and hand algebra. No floating point, no sampling, no solvers, no optimisation. Where an inequality between algebraic numbers had to be decided, it was decided by squaring to a rational comparison, not by evaluation. Scripts: `scratchpad/r92_exact.py`, `r92_triples.py`, `r92_fence.py`, `r92_final.py`.

Worked cold: Xu §2–§3, [BW08](../references/boehm-wilking-2008-space-forms/) §1–§2 and Beitz §6.3.2 were read and the algebra re-derived before [problem.md](../findings/problem.md) was opened.

---

## Verdicts at a glance

| # | Claim | Verdict |
|---|---|---|
| 1 | Five of ten triples survive; multiplicities; $3\langle W,\Phi(Y)\rangle=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$ | **CONFIRMED**, exactly |
| 2 | The expansion is Xu (2.34) term for term, incl. $\tfrac3{n-2}$ | **CONFIRMED**, and it is Huisken 1985, not Xu |
| 2a | The bridge $G\le0\iff P\le F\langle\mathrm{ric},\mathrm{ric}\,\Phi\rangle$ "had not been derived" | **REFUTED**, published twice: Beitz (6.25)+Lemma 6.3.16, Xu (3.1)–(3.4) |
| 2b | $a=0$ on the slice gives exactly $\theta\le\theta_0(n)$ | **CONFIRMED as algebra**; it is a three-line specialisation of Xu (3.5), and $\theta_0(n)$ is Jäger's published constant |
| 2c | $n\ge12$ necessary, by padded $W_{\mathbb{CP}^2}$ | **CONFIRMED as algebra** (and stronger than stated: it kills $4\le n\le11$); the *witness* is Nienhaus's published exception clause |
| 3 | The parity argument | **CONFIRMED** as valid, and it is a tautology whose effect Xu's proof already has |
| 4 | Fence post F1 | **CONFIRMED** (narrowed by Reviewer 91 mid-review; identity independently re-derived here), but it never covered the Tachibana route |
| 4 | Fence post F2 | Number **CONFIRMED**; stated **mechanism REFUTED**; conclusion survives for a different, provable reason |
| 5 | Cone-bridge prose | three further corrections below |

---

## 1. The off-slice expansion, CONFIRMED, exactly

Independent census, then an exact tensor witness.

**Census.** $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ is totally symmetric ([BW08](../references/boehm-wilking-2008-space-forms/) eq. (5) = Xu (2.33)), so there are exactly $\binom{3+2}{3}=10$ distinct triples on $\{I,Y,W\}$. Xu Prop 2.7 (1)–(5) plus orthogonality of the decomposition kill $IIY$ (Xu 1), $IIW$, $IYW$, $IWW$ (all Xu 3, $\Phi(I,W)=0$), and $YWW$ (Xu 4). Five survive: $III$, $IYY$, $YYY$, $YYW$, $WWW$. $YYW=\langle W,\Phi(Y)\rangle$ needs the block Xu's list omits, and [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.2 supplies it: $(Y^2+Y^\#)_W=\tfrac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$. **The author's 5/5 split is right, and the attribution of each vanishing is right.**

**Exact witness.** At $n=6$, $c=\tfrac37$, $Y$ built from an explicitly non-diagonal integer $\mathrm{Ric}_0$, and $W$ the zero-padded Weyl operator of $\mathbb{CP}^2$, the ten triples computed directly from Xu (2.24)/(2.25) in exact rationals are

| $III$ | $IIY$ | $IIW$ | $IYY$ | $IYW$ | $IWW$ | $YYY$ | $YYW$ | $YWW$ | $WWW$ |
|---|---|---|---|---|---|---|---|---|---|
| $\tfrac{2025}{343}$ | $0$ | $0$ | $\tfrac{129}7$ | $0$ | $0$ | $3$ | $-\tfrac{19}2$ | $0$ | $144$ |

with $\langle R,\Phi(R)\rangle=\tfrac{123267}{686}$ reproduced both by $\sum_{\text{ordered}}$ and by the author's five terms. The surviving multiplicities are $1,3,1,3,1$; the general counts $1$ (for $XXX$), $3$ (for $XXY$), $6$ (for $IYW$) sum to $3^3=27$. The parenthetical "(1,3,3,6 for the various triple types)" is garbled but substantively right, note the only multiplicity-$6$ triple is one of the five that *vanish*.

Checked term by term against the claimed closed forms, all exact equalities:

- $T(I,I,I)=c^3(n-1)\lVert I\rVert^2$, since $\Phi(I)=(n-1)I$ and $\lVert I\rVert^2=\tfrac{n(n-1)}2$ (verified directly at $n=5$: $\lVert I\rVert^2=10$, $\langle I,\Phi(I)\rangle=40$).
- $3T(Y,Y,W)=\tfrac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$: both sides $=-\tfrac{57}2$.
- $\lVert R_{\mathrm{ric}_0}\rVert^2=\tfrac{|\mathrm{Ric}_0|^2}{n-2}$: both $\tfrac{43}2$, which is what pins the normalisation quoted from Beitz p. 96.

---

## 2. THE CLASSIFICATION CLAIM

### 2.0 The expansion *is* (2.34), CONFIRMED, and the attribution should go one step further back

Mapping, verified as exact rational identities at the witness above:

| author's term | Xu (2.34) term | check |
|---|---|---|
| $c^3(n-1)\lVert I\rVert^2$ | $\tfrac n{2(n-1)}\bar\lambda^3$ | $c=\tfrac{\bar\lambda}{n-1}$, $\lVert I\rVert^2=\tfrac{n(n-1)}2$; both $\tfrac{2025}{343}$ |
| $3c\langle I,\Phi(Y)\rangle$ | $\tfrac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2$ | both $\tfrac{387}7$ (and Xu assembles it as $1+2$ from (2.36)+(2.38)) |
| $\langle Y,\Phi(Y)\rangle$ | $-\tfrac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle$ | both $3$ |
| $3\langle W,\Phi(Y)\rangle$ | $\tfrac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$ | both $-\tfrac{57}2$ |
| $\langle W,Q(W)\rangle$ | $\langle Q(W),W\rangle$ | both $144$ |

Term for term, $\tfrac3{n-2}$ included. The author's classification is correct.

**One correction to the classification itself.** The file says the derivation is "corroboration of a published identity **by a second route**". It is not a second route. Xu's own proof of Lemma 2.8 runs (2.35)–(2.42) through exactly Prop 2.7 plus (2.31)/(2.32), i.e. through exactly Xu Prop 2.7 + BW08 Lemma 2.2, the same two inputs, in the same order. And Xu states plainly that the identity is **Huisken's**, from the proof of his Theorem 3.3, merely not written there as a lemma. So the correct provenance line is *Huisken 1985, transcribed by Xu 2024*, and this repo re-derived it by the published route.

### 2a. The bridge, REFUTED. It is published, twice, and the author is already reading one of the two papers that has it.

[problem.md](../findings/problem.md): *"That is the bridge, and it had not been derived."*

**Beitz 2018**, the very section the file cites for Lemma 6.3.16, contains it in full:

- (6.24) $F:\mathrm{scal}^+\to\mathbb R$, $R\mapsto\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, the same $F$;
- (6.25) $dF_R(S)=\tfrac2{\lVert\mathrm{ric}(R)\rVert^2}\big(\langle R,S\rangle-F(R)\langle\mathrm{ric}(R),\mathrm{ric}(S)\rangle\big)$, the same differential;
- Lemma 6.3.16 opens *"we consider the function $G:\mathrm{scal}^+\to\mathbb R:R\mapsto dF_R(\Phi(R))$, where $\Phi(R):=R^2+R^\#$"*, **the same $G$, the same $\Phi$, the same letters**;
- and it closes with the implication in both directions of use: $G(R_0)\le0\Rightarrow\tfrac d{dt}F(R(t))\le0\Rightarrow\Phi(R_0)\in T_{R_0}\Omega_a\Rightarrow$ invariance.

Putting $S=\Phi(R)$ in (6.25) and dividing by the positive factor $\tfrac2{\lVert\mathrm{ric}\rVert^2}$ *is* the claimed equivalence. There is nothing left to derive.

**Xu 2024** has it again and even more explicitly: §3.1 defines the same $F$, observes $\partial\Omega(a)=F^{-1}\big(\tfrac1{n-2+4a}\big)$, writes (3.1)/(3.2) for $dF_R$ and $dF_R(Q(R))$, reduces invariance to (3.3) $dF_R(Q(R))\le0$, and states the criterion as (3.4)
$$\langle R,Q(R)\rangle-F(R)\langle\mathrm{Ric}(R),\mathrm{Ric}(Q(R))\rangle\le0,\qquad\forall R\in\partial\Omega(a),$$
which is the author's display with the sides exchanged.

The file's own preceding paragraph quotes Beitz's Lemma 6.3.16 *by its statement about $G(R)=dF_R(\Phi(R))$*, so the notation was copied from the source that already contains the result, and then the result was recorded as underived. **This is the third time in this chain that published material has been logged as new** (the first two being the expansion, self-corrected, and the $\tfrac3{n-2}$ coefficient). The sentence must go.

Minor consequence: *"$P$ **is** the left-hand side of Böhm–Wilking's criterion."* [BW08](../references/boehm-wilking-2008-space-forms/) define $P(R)=\tfrac13\mathrm{tr}(R^3+R\,R^\#)=\tfrac16\mathrm{tri}(R,R,R)=\tfrac13\langle R,Q(R)\rangle$, as the *potential whose gradient flow is the ODE*. This repo's $P$ is $\langle R,Q(R)\rangle$, three times theirs, and with a different job. The name collision should be flagged wherever the two are compared.

### 2b. The $a=0$ slice criterion, CONFIRMED as algebra; not new as mathematics

The collapse is exact and I reproduce it with no constraint used at all. With $R=cI+W$: $\Phi(I,W)=0$ (verified as a tensor identity, every entry zero, at $n=6$), $\mathrm{Ric}(\Phi(W))=0$ (likewise), so

$$\mathrm{LHS}-\mathrm{RHS}=\Big[c^3(n-1)\tfrac{n(n-1)}2+\langle W,Q(W)\rangle\Big]-\frac{c^2\tfrac{n(n-1)}2+\lVert W\rVert^2}{c^2(n-1)^2n}\,c^3(n-1)^3n=\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2 .$$

The $c^3$ terms cancel **identically in $c$**, verified symbolically in $c$ at $n=6$, where both sides return $144-120c$. On $\partial\Omega_0$, $\tfrac{n-2}n\lVert W\rVert^2=c^2\tfrac{n(n-1)}2$ gives $c(n-1)=\theta_0(n)\lVert W\rVert$ (at $n=6$: $c=\tfrac{4\sqrt{15}}{15}$, $c(n-1)=\tfrac{4\sqrt{15}}3=\theta_0(6)\lVert W\rVert$ exactly). So the criterion is exactly $P(W)\le\theta_0(n)\lVert W\rVert^3$. **The author's "no residue at all" is literally right.**

But: this is Xu (3.5) with $a=0$ and $\mathrm{Ric}_0=0$ substituted. Xu's coefficient of $n\bar\lambda^3$ is $\tfrac{4a-n}{2(n-1)(n-2+4a)}$, which at $a=0$ is $-\tfrac n{2(n-1)(n-2)}$, and every other term in (3.5) carries a factor $\mathrm{Ric}_0$; the residue is $\langle Q(W),W\rangle-\tfrac{n^2\bar\lambda^3}{2(n-1)(n-2)}$, which is the display above. Xu never writes it only because he says *"Fix $a>0$"* before doing signs. And the constant is Jäger's: Theorem A of the 2016 thesis is stated for $\theta\ge\theta_0(n)=\tfrac{\sqrt{2(n-1)(n-2)}}n$, and it equals Nienhaus Prop 2.25's $\theta_{n/2,n/2}$. So *"the constant is not a guess read off the sphere products"* is true of this repo's internal logic and misleading as a statement about the literature, the closed form was in hand from Jäger before this derivation ran.

### 2c. $n\ge12$ necessary, CONFIRMED as algebra, understated in range, and the witness is published

Verified exactly, no floats:

- $\theta(W_{\mathbb{CP}^2})^2=\tfrac32$ exactly, from the Fubini–Study tensor $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$ built from scratch ($\lVert W\rVert^2=24$, $P=144$, $\theta^2=\tfrac{144^2}{24^3}=\tfrac32$).
- Zero-padding is exactly invariant: at $n=5$ and $n=6$, $\mathrm{Ric}(W_{\rm pad})=0$ identically, $\lVert W_{\rm pad}\rVert^2=24$, $P(W_{\rm pad})=144$. So $W_{\rm pad}\in\langle W\rangle_n$ and $\theta$ is unchanged at every $n\ge4$.
- $\theta_0(n)^2-\tfrac32=\tfrac{-(n^2-12n+8)}{2n^2}$, roots $6\pm2\sqrt7$; negative for $n\le11$ ($n=11$: $-\tfrac3{242}$), positive from $n=12$ ($+\tfrac1{36}$).
- End to end at $n=6$: $\mathrm{LHS}-\mathrm{RHS}=144-32\sqrt{15}$, and $144^2=20736>15360=(32\sqrt{15})^2$, so $G>0$ **strictly** at a point of $\partial\Omega_0$. With $dF_R\ne0$ off $\mathbb R_{>0}I$ (Beitz Lemma 6.3.12), $F$ strictly increases along the ODE and $\Omega_0$ is not invariant.

Two remarks.

1. **The range is written smaller than what is proved.** The text says $\Omega_0$ is *"provably non-invariant for $8\le n\le11$"*, then concedes parenthetically that the inequality fails from $n=4$. The witness exists at every $n\ge4$ and the sign test fails at every $n\le11$; the claim is $4\le n\le11$. The "$8$" is inherited from Nienhaus's phrasing, where it means something else.
2. **The witness is not this repo's.** Nienhaus 2023 states Conjecture A *with the $\mathbb{CP}^2$ exception carried explicitly at $8\le n\le11$ and dropped at $n\ge12$*, i.e. the published statement already asserts that $W_{\mathbb{CP}^2}$ beats the bound exactly below the crossover. This repo also already derived $n^2-12n+8=0$ from Fox's algebra ([ATTEMPTS.md](../ATTEMPTS.md), Step 3). What claim 2c adds is the *transfer* of a published witness across a *published* bridge, a two-line corollary. The heading "$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT" oversells it; the honest heading is that the conjecture's own dimension hypothesis is now visible on the cone side too.

**Answer to the question the author did not ask:** of the three items, (a) is fully published (twice), (c) is a corollary of two published facts, and (b) is a three-line specialisation of a published equation to a value of $a$ its author explicitly set aside. Nothing in the chain from "Conjecture A" to "$\theta\le\theta_0(n)$ at $a=0$" is new mathematics. What is genuinely this repo's is the *bookkeeping*, that the $a=0$ slice of the Böhm–Wilking cone family and the $P$-maximisation statement are the same statement, written down explicitly with its constant. That is worth having and should be labelled as such.

---

## 3. The parity argument, CONFIRMED valid, and near-vacuous

Every step checks.

| step | status |
|---|---|
| $\tfrac{n-2}n\lVert W\rVert^2\le\lVert R_I\rVert^2$ depends only on $\lVert W\rVert$, and $\mathrm{scal}$ only on $R_I$ | correct; $cI+Y-W\in\overline{\Omega_0}$, and $\partial\Omega_0$ is an equality in $\lVert W\rVert^2$, so the involution preserves the boundary too |
| $\mathrm{ric}(R)$ is $W$-independent | correct, $\mathrm{Ric}(W)=0$ |
| $F(R)$ is $W$-even | correct, $\lVert R\rVert^2$ is orthogonal-block-additive |
| only $W$-dependent piece of $\mathrm{ric}(\Phi(R))$ is $2\Phi(Y,W)$ | correct: $\Phi(I,W)=0$ (Xu 3), $\mathrm{Ric}(\Phi(W,W))=0$ (Xu 4 + Xu (2.26)); both verified as exact tensor identities |
| $\Phi(Y,W)\in\langle\mathrm{Ric}_0\rangle$, $W$-odd | correct, Xu 2.7(5) |
| $\mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle$ | correct, and this needs the triple census, since $T(I,W,W)$ and $T(Y,W,W)$ (which would be $W$-*even*) both vanish |
| $|\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}|\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$ | correct, and it is an *equivalence*, not a weakening |

Nothing fails. $-W$ is admissible, $\mathrm{scal}>0$ survives, and the conclusion is two-sided.

**But the significance is overstated.** Two points.

1. It is the tautology "$e+o\le0$ and $e-o\le0$ iff $|o|\le-e$" applied to a decomposition the census already gave. It supplies no bound; the file's own closing note concedes this (*"what a general-$R_{\mathrm{ric}_0}$ proof still owes is a bound on $\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$"*).
2. Its *effect* is already in Xu. Xu (3.6) drops the $\mathrm{Ric}_0$-cubic, the $\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$ and the $\langle Q(W),W\rangle$ terms to their absolute values, and his supporting lemmas are stated sign-blind, Lemma 2.14 is literally $|\langle Q(W),W\rangle|\le\cdots$. Sign-blindness in $W$ is exactly what parity forces, so Xu's proof pays the parity cost already. "The parity argument on top of it is not in Xu" is true as a matter of text and misleading as a matter of content.

---

## 4. Fence posts 1 and 2

### Fence post F1, the fact is right; the post was narrowed by Reviewer 91 mid-review, and my identity confirms it independently

The factual core is exactly true, and I can put a rate on it. For $S^m\times S^m$ ($n=2m$), the Weyl spectrum on $\Lambda^2$ is $\sigma=\tfrac m{2m-1}$ with multiplicity $m(m-1)$ and $\sigma-1$ with multiplicity $m^2$, giving in closed form

$$\lVert W\rVert^2=\frac{m^2(m-1)}{2m-1},\qquad \mathrm{tr}(W^3)=\frac{m^2(m-1)}{(2m-1)^2},\qquad \frac{\mathrm{tr}(W^3)}{\lVert W\rVert^3}=\frac1{m\sqrt{(m-1)(2m-1)}},$$

(both checked against the from-scratch tensor at $m=3,4$), so

$$\boxed{\ \frac{\mathrm{tr}(W^3)}{P(W)}\Big|_{S^{n/2}\times S^{n/2}}=\frac2{(n-1)(n-2)}\ }$$

exactly, $\tfrac1{55}$ at $n=12$, $O(n^{-2})$, limit $0$. So "asymptotically negligible" is right and quantified, and "essentially all of $P$'s value comes from $\langle W^\#,W\rangle$" is right.

**Status note.** While this review was running, [fence-posts.md](../findings/fence-posts.md) post F1 was rewritten by Reviewer 91, dropping the false headline "eigenvalue-only inequalities can never be sharp" and narrowing to the split, quoting exactly the identity $\operatorname{tr}(W^3)/P=\frac2{(n-1)(n-2)}$. **I derived that identity independently and by a different route** (closed-form Weyl spectrum of $S^m\times S^m$, then $B_\#/\theta_0=1-\frac2{(n-1)(n-2)}$ symbolically in $n$), and it is correct. The narrowed post is right and I confirm it.

**One thing the narrowed post still leaves loose**, and it is the reason the Tachibana route was dropped. The new wording ("a bound that reaches $P$ only through $\operatorname{tr}(W^3)$ cannot close the gap"), is correct, but it is not what Xu's Lemma 2.14 is. That lemma does not reach $P$ through $\operatorname{tr}(W^3)$ at all; it bounds $\langle Q(W),W\rangle$ **whole**, which the post explicitly says it says nothing about. Xu's Lemma 2.14 builds the test bivectors $\xi^{ijkl}$ out of $W$ itself and uses the first Bianchi identity twice ((2.50)–(2.53)); all of that is alignment-aware. Exactly **one** step is eigenvalue-only, (2.55), the Rayleigh bound $\langle W\xi,\xi\rangle/\langle\xi,\xi\rangle\le\sqrt{(N-1)/N}\,\lVert W\rVert$, and that is where the whole loss occurs. [ATTEMPTS.md](../ATTEMPTS.md) states this correctly ("replacing the pointwise-(2.44)-plus-Cauchy–Schwarz step *inside* the proof of Lemma 2.14"). So **sharpening (2.55) inside an otherwise alignment-aware argument is excluded by neither the old post nor the new one**, and the record should say so positively rather than leaving the Tachibana route filed under a post that does not reach it. That route was abandoned on a fence post that never covered it.

### Fence post F2, the number is right, the stated mechanism is wrong, the conclusion survives on better grounds

**The number: CONFIRMED, exactly, at every $n$ from 6 to 100.** With $B_\#(n)=\tfrac{\sqrt2(n-3)}{\sqrt{(n-1)(n-2)}}$ (the repo's vertex bound) and $B_{\mathrm{tr}}(n)=\tfrac{N-2}{\sqrt{N(N-1)}}$, $N=\tfrac{n(n-1)}2$ (Huisken/Xu (2.45) on $\Lambda^2$), the decision $1.7\,\theta_0(n)<B_\#+B_{\mathrm{tr}}<1.8\,\theta_0(n)$ was made by rational squaring for every integer $n\in[6,100]$ and holds at all $95$ of them. No exception.

**The mechanism: REFUTED.** The post says the overshoot arises "because the two extremal eigenvalue profiles do not coincide, the vertex matrix $\Lambda$ and the full operator $W$ cannot both sit at their individual extremes". $\Lambda$ *does* sit at its individual extreme. I get the exact identity

$$\frac{B_\#(n)}{\theta_0(n)}=1-\frac2{(n-1)(n-2)}=\frac{\langle W^\#,W\rangle}{P(W)}\Big|_{S^{n/2}\times S^{n/2}},$$

i.e. $B_\#$ is **saturated** at the balanced sphere product (checked symbolically in $m$, and exactly at $n=8$: both sides $\tfrac5{\sqrt{21}}$). Hence

$$\big(B_\#+B_{\mathrm{tr}}\big)-\theta_0=B_{\mathrm{tr}}-\frac{\mathrm{tr}(W^3)}{\lVert W\rVert^3}\Big|_{S^{n/2}\times S^{n/2}},$$

so **100% of the overshoot is slack in the $\mathrm{tr}(W^3)$ bound alone.** And that slack is enormous because Huisken's (2.45) is sharp for arbitrary trace-free symmetric $N\times N$ operators, whose extremal profile (one large eigenvalue, $N-1$ equal small ones) is not a Weyl curvature operator at all: the ratio $B_{\mathrm{tr}}/\mathrm{tr}(W^3)$ at the maximiser is $\tfrac{52}3\approx17$ at $n=8$, $\tfrac{64\sqrt{78}}{13}\approx43$ at $n=12$, and grows. Quoting an off-class bound as "the sharp Tachibana/Huisken bound" is the error.

**The conclusion survives, and here is a proof of it that needs no bound at all.** Use only *attained* values. $B_\#$ is attained (above). And $\mathrm{tr}(W^3)/\lVert W\rVert^3=\tfrac{\sqrt6}6$ is attained by the zero-padded $W_{\mathbb{CP}^2}$ at every $n\ge4$ (exactly: $\mathrm{tr}(W^3)=48$, $\lVert W\rVert^2=24$, both padding-invariant). So *any* valid pair of separate bounds obeys

$$B_1+B_2\ \ge\ \frac{\sqrt6}6+B_\#(n)\ =\ \theta_0(n)\Big[1-\frac2{(n-1)(n-2)}+\frac{n\sqrt3}{6\sqrt{(n-1)(n-2)}}\Big],$$

and the bracket is $\tfrac{54}{55}+\tfrac{\sqrt{330}}{55}$ at $n=12$, decreasing to $1+\tfrac{\sqrt3}6\approx1.2887$ as $n\to\infty$. **Every term-by-term route overshoots by at least ~$1.29\times$, unconditionally, at every $n$.** So the post's conclusion (a joint bound is needed), is correct and now proved rather than measured.

**Net.** The fence post did not wrongly close a live route: term-by-term is genuinely dead. But it closed it with a number inflated by ~$35\%$ and a diagnosis pointing at the wrong term, and that diagnosis is what would mislead the next attempt, it says "find compatible extremal profiles", when what the algebra says is "the $\langle W^\#,W\rangle$ half is already exactly sharp; the entire problem is that $\mathrm{tr}(W^3)$ has no bound that is sharp *on the Weyl cone*, and even a Weyl-sharp one would not suffice because $\sqrt6/6\gg\tfrac{2\theta_0}{(n-1)(n-2)}$."

---

## 5. Other cone-bridge material

1. **"That is the bridge, and it had not been derived"**, remove, see 2a.
2. **"corroboration of a published identity by a second route"**, it is the same route; and the identity is Huisken's, not Xu's. See 2.0.
3. **"$\Omega_0$ provably non-invariant for $8\le n\le11$"**, the proof gives $4\le n\le11$; the parenthetical already knows this. See 2c.
4. **"$P$ is the left-hand side of Böhm–Wilking's criterion"**, [BW08](../references/boehm-wilking-2008-space-forms/)'s $P$ is $\tfrac13\langle R,Q(R)\rangle$ and is their gradient-flow potential. Factor $3$, different role.
5. **"the bridge needs invariance $\Rightarrow G\le0$ … it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$"**, the scalar-curvature fact is not what supplies that direction. $G(R_0)>0$ at $R_0\in\partial\Omega_a\cap\mathrm{scal}^+$ gives $\tfrac d{dt}F(R(t))|_0>0$ directly, and $R(t)\in\mathrm{scal}^+$ for small $t$ by continuity alone. The $\mathrm{scal}$ evolution is needed for Beitz's global statement that $\mathrm{scal}^+$ is ODE-invariant, not for this step. Correct conclusion, wrong reason.
6. **Convention audit, re-checked and CONFIRMED.** Beitz's $\mathrm{ric}=\tfrac12\mathrm{Ric}$ (her $\Omega_a$ reads $\lVert\mathrm{ric}\rVert^2$ where Xu's reads $\tfrac14\lvert\mathrm{Ric}\rvert^2$), so $F_{\rm Beitz}=4F_{\rm Xu}$, $F_{\rm Beitz}(I)=\tfrac2{n-1}$ against $F_{\rm Xu}(I)=\tfrac1{2(n-1)}$; the product $F\langle\mathrm{ric},\mathrm{ric}\,\Phi\rangle$ is invariant, so the bridge is convention-free. $\lVert I\rVert^2=\tfrac{n(n-1)}2$ in both, as the file says. **No error here.**
7. **Sharpness at odd $n$, CONFIRMED.** Nienhaus $\theta_{k,l}^2$ at $(k,l)=(\tfrac{n-1}2,\tfrac{n+1}2)$ simplifies exactly to $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$, giving $\tfrac{40}{27},\tfrac{120}{77},\tfrac{21}{13}$ at $n=11,13,15$.
8. **[b_cone_offslice.py](../scripts/route-b/b_cone_offslice.py) is bookkeeping, not verification.** Its `PHI` table *asserts* the block supports from Xu 2.7 + BW08 2.2 and then reads off which triples survive; it never touches a tensor, so it cannot catch an error in the table itself. The table is right (I verified all ten triples on real tensors) but the script should not be cited as having checked it. `float()` appears in [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) at lines 89–90 for display only; the identities there are symbolic.

---

## Closing

The mathematics in this section is correct essentially everywhere I could test it, the census, the multiplicities, the $\tfrac3{n-2}$ coefficient, the residue-free collapse at $a=0$, $\theta_0(n)$, the $\mathbb{CP}^2$ sign test, and the parity involution all survive exact checking. What does not survive is the novelty accounting. The bridge is Beitz 2018 §6.3.2 and Xu 2024 §3.1; the five-term expansion is Huisken 1985; the constant is Jäger 2016; the $\mathbb{CP}^2$ exception is Nienhaus 2023. The one item that is genuinely this repo's, that the $a=0$ face of the Böhm–Wilking cone family *is* the $P$-maximisation statement, with its constant, is a specialisation of a published equation to the one value of $a$ its author skipped, and is worth exactly that much. The parity argument is a valid tautology whose effect Xu's estimates already have.

The most useful correction here is in fence post F2: $B_\#$ is exactly saturated at the maximiser, the whole overshoot lives in the $\mathrm{tr}(W^3)$ bound, and the unconditional floor for any term-by-term route is $\approx1.29\times$, not $1.7$–$1.8\times$. The route stays closed; the reason on file was wrong.

*Reviewer 92. Exact rational and symbolic arithmetic only; no numerical checking was used.*
