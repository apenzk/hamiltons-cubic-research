# Verifier v62, L61's equality clause, "with equality exactly on that orbit"

*Cold brief on the final clause of [Lemma L61](../results.md) alone. **No numerical work. Nothing was executed.** Every value below is exact and was carried out by hand from the definitions in [conventions.md](../findings/conventions.md) and the exact $n=5$ data in [INDEX-values.md](../findings/INDEX-values.md). [sym3-blocks.md](../findings/sym3-blocks.md) was not opened, per the brief; [ROUND_L61.md](ROUND_L61.md) was read once, to take the statement verbatim from its sources, and no verifier report was read. The sum-of-squares property of $F_5$, the vanishing of each summand on $O(5)\cdot W_0$, and the bound $\theta\le\sqrt{3/2}$ are taken as given and are not re-attacked here. Log: [agent_logs/verify-L61-v62.log](../agent_logs/verify-L61-v62.log).*

## The verdict table

| # | the clause, split | verdict | reason |
| --- | --- | --- | --- |
| 1 | every $W\in O(5)\cdot W_0$ attains $\theta=\sqrt{3/2}$ | **VALID AS WRITTEN** | $\theta$ is $O(5)$-invariant and $\theta(W_0)=3\mathop{\mathrm{tr}}(W_0^3)=3/\sqrt6=\sqrt{3/2}$ from the exact data at [INDEX-values.md:19](../findings/INDEX-values.md), though it is the evaluation, not the certificate, that supplies the sign |
| 2 | every $W$ attaining $\theta=\sqrt{3/2}$ lies on $O(5)\cdot W_0$ | **FAILS** | a sum of squares gives $Z(F_5)=\bigcap_iZ(c_i)\supseteq O(5)\cdot W_0$ and nothing in the other direction; the reverse inclusion is a statement about the real radical of $\langle c_1,\dots,c_N\rangle$ that no Gram matrix carries |
| 3 | the word "Hence", i.e. clause 2 as a consequence of the certificate | **FAILS, and unreachably** | $F_5$ is even and the $c_i$ are odd, so $Z(F_5)\supseteq O(5)\cdot(-W_0)$, a **distinct** orbit; any inference from "the summands vanish on the orbit" to "the zero set is the orbit" would prove the same for $-W_0$, where $\theta=-\sqrt{3/2}$ |
| 4 | "exactly on that orbit" read literally, without $\lVert W\rVert=1$ | **FAILS on scaling** | $\theta$ is invariant under $W\mapsto tW$, $t>0$, while $O(5)\cdot W_0$ is norm-preserving, so $2W_0$ attains equality off the orbit. [results.md:625](../results.md) says "for every unit $W$" and is safe; the [sym3-blocks.md:326](../findings/sym3-blocks.md) form quoted in [ROUND_L61.md](ROUND_L61.md) and [results.md:204](../results.md) do not |

**One-line summary.** The first direction holds and needs only the $O(5)$-invariance of $\theta$ together with one exact evaluation at $W_0$; the second direction does not follow from the certificate at all, a sum of squares certifies membership in the ideal of the orbit and positivity, which fixes one inclusion of zero sets, and $F_5$'s own evenness exhibits a second orbit inside $Z(F_5)$ in closed form, so the clause is not merely unproved but is unreachable by any argument of this shape.

## 0. What is fixed, quoted rather than restated

From [conventions.md](../findings/conventions.md):

- $P(W)$ ("the cubic form $\langle W,Q(W)\rangle$"; $\theta$), "$P(W)/\lVert W\rVert^3$".
- $M(n)$, "**the global maximum** of $P$ on the unit sphere of $\mathcal W_n$ … padded $W_{\mathbb{CP}^2}$ giving $M(n)\ge\sqrt{3/2}$".
- $W_0$, "the $n=5$ base point of the $\mathrm{Sym}^3$ machinery … the orbit $O(5)\cdot W_0$ being the zero set a certificate must vanish on. *Cubics are odd, so vanishing on $O(5)\cdot W_0$ forces vanishing on the orbit of $-W_0$ automatically.*"
- $\dim\mathcal W_5=\frac{5\cdot2\cdot6\cdot7}{12}=35$.

From [INDEX-values.md:19](../findings/INDEX-values.md), the exact $n=5$ base point: "$\Lambda^2$ spectrum $(2,-1,-1,0^7)/\sqrt6$, $\lVert W_0\rVert^2=1$, $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$".

From [results.md:625](../results.md), the step this report inherits rather than checks: "$P(W)=3\mathop{\mathrm{tr}}(W^3)$" on $\mathcal W_5$.

The three arithmetic checks on the base point, by hand: $\tfrac{2-1-1}{\sqrt6}=0$; $\tfrac{4+1+1}{6}=1$; $\tfrac{8-1-1}{6\sqrt6}=\tfrac{1}{\sqrt6}$. The spectrum, the norm and the cube trace agree.

## 1. The identity the whole question turns on

With $P=3\mathop{\mathrm{tr}}(W^3)$ on $\mathcal W_5$ and $\theta=P/\lVert W\rVert^3$,

$$9\mathop{\mathrm{tr}}(W^3)^2=P(W)^2=\theta(W)^2\lVert W\rVert^6,\qquad\text{so}\qquad \boxed{\;F_5(W)=\lVert W\rVert^6\Big(\tfrac32-\theta(W)^2\Big).\;}$$

This is an identity on $\mathcal W_5\setminus\{0\}$, and it says exactly where the certificate's reach ends. $F_5\ge0$ is equivalent to $\lvert\theta\rvert\le\sqrt{3/2}$, and

$$Z(F_5)=\{0\}\;\sqcup\;\{W\ne0:\theta(W)=+\sqrt{3/2}\}\;\sqcup\;\{W\ne0:\theta(W)=-\sqrt{3/2}\}.$$

Write $\mathcal E_\pm$ for the two nonzero pieces. They are disjoint because $\sqrt{3/2}\ne0$, and $\mathcal E_-=-\mathcal E_+$ because $\theta$ is odd. **The equality clause is a claim about $\mathcal E_+$; the certificate is a statement about $Z(F_5)$, which is strictly larger whenever $\mathcal E_+$ is nonempty.** That is the whole of the defect, and everything below is that sentence made explicit.

## 2. Direction one, the orbit attains equality. VALID.

Three lines, and none of them is the certificate.

1. **$\theta$ is $O(5)$-invariant.** $g\in O(5)$ acts on curvature operators by $W\mapsto(\Lambda^2g)\,W\,(\Lambda^2g)^{-1}$ with $\Lambda^2g$ orthogonal on $\Lambda^2\mathbb R^5$. Conjugation by an orthogonal map preserves $\lVert\cdot\rVert$ and commutes with $Q$ ($Q$ is $O(n)$-equivariant, being built from $W^2$ and $W^\#$), so it preserves $P$ and hence $\theta$.
2. **$\theta(W_0)=+\sqrt{3/2}$.** From $\mathop{\mathrm{tr}}(W_0^3)=1/\sqrt6$ and $\lVert W_0\rVert=1$: $\theta(W_0)=3/\sqrt6=\sqrt{9/6}=\sqrt{3/2}$.
3. Therefore $\theta\equiv\sqrt{3/2}$ on $O(5)\cdot W_0$, i.e. $O(5)\cdot W_0\subseteq\mathcal E_+$.

**A note on provenance, since the clause is offered as a consequence of the certificate.** The certificate alone yields only $O(5)\cdot W_0\subseteq Z(F_5)$, hence $\theta^2=3/2$ on the orbit, hence $\theta=\pm\sqrt{3/2}$ there. It cannot choose the sign: $F_5$ does not see it. The sign comes from step 2, an evaluation, which is on the record independently at [INDEX-values.md:19](../findings/INDEX-values.md) and in $M(n)\ge\sqrt{3/2}$ at [conventions.md](../findings/conventions.md). So direction one is valid, with one named input outside the certificate.

## 3. Direction two, equality forces the orbit. FAILS.

### 3a. What a sum of squares determines about a zero set

Let $F=\sum_{i=1}^Nc_i^2$ with $c_i$ real forms. Then $F(W)=0\iff c_i(W)=0$ for every $i$, so

$$Z(F)=\bigcap_{i=1}^NZ(c_i)=\mathcal V_{\mathbb R}\big(\langle c_1,\dots,c_N\rangle\big).$$

The hypothesis granted is "each $c_i$ vanishes on $O(5)\cdot W_0$", i.e. $c_i\in I(O(5)\cdot W_0)$ for every $i$, i.e. $\langle c_1,\dots,c_N\rangle\subseteq I(O(5)\cdot W_0)$. Applying $\mathcal V_{\mathbb R}$ reverses the inclusion and gives

$$Z(F_5)\;\supseteq\;\mathcal V_{\mathbb R}\big(I(O(5)\cdot W_0)\big)\;=\;O(5)\cdot W_0 .$$

**One inclusion, and it is the one direction one already has.** The reverse, $Z(F_5)\subseteq O(5)\cdot W_0$, asserts that the ideal generated by the certificate's summands has the orbit as its full real variety, equivalently that its real radical is $I(O(5)\cdot W_0)$. That is a computation about the ideal, of a kind no positive-semidefinite Gram matrix performs and no positivity statement implies. The certificate's data, read in full at [n5_certificate.json](../scripts/runs/n5_certificate.json), is $47$ rationals, $36$ real-symmetric and $11$ imaginary across $16$ blocks of shapes $[3,3,2,1,2,1,2,1,2,2,1,1,1,1,1,1]$, together with the block labels and a common denominator. **There is no variety, ideal, radical or equality-case datum in the file, and none is derivable from a Gram matrix.**

The gap is not exotic. In two variables, $F(x,y)=(x^2-y^2)^2$ is a sum of one square of a quadratic vanishing on the line $S=\{x=y\}$; the hypothesis "SOS, summands vanish on $S$" holds verbatim, and $Z(F)=\{x=y\}\cup\{x=-y\}\supsetneq S$. **The $n=5$ situation is that example**, as §3b shows.

### 3b. The parity witness, in closed form

$F_5$ is even: $\lVert-W\rVert=\lVert W\rVert$ and $\mathop{\mathrm{tr}}((-W)^3)^2=\mathop{\mathrm{tr}}(W^3)^2$, so $F_5(-W)=F_5(W)$. The summands are homogeneous of degree $3$, hence odd: $c_i(-W)=-c_i(W)$. So $c_i$ vanishing on $O(5)\cdot W_0$ forces $c_i$ vanishing on $-O(5)\cdot W_0=O(5)\cdot(-W_0)$, and

$$Z(F_5)\;\supseteq\;O(5)\cdot W_0\;\cup\;O(5)\cdot(-W_0).$$

**These are two distinct orbits.** $\mathop{\mathrm{tr}}(W^3)$ is $O(5)$-invariant (§2, step 1) and takes the value $+1/\sqrt6$ at $W_0$ and $-1/\sqrt6$ at $-W_0$; the values differ, so no $g\in O(5)$ carries one to the other. Equivalently, the $\Lambda^2$ spectra $(2,-1,-1,0^7)/\sqrt6$ and $(-2,1,1,0^7)/\sqrt6$ are different multisets and the action is by orthogonal conjugation. Closed form, no computation.

**What this does and does not exhibit.** $-W_0$ has $\theta=-\sqrt{3/2}$, so it is a minimiser, not a point of equality in $\theta\le\sqrt{3/2}$: it is a zero of $F_5$ off the orbit, not a counterexample to the $\theta$-clause itself. Its force is against the **inference**. Every property the certificate establishes of $O(5)\cdot W_0$, membership in the zero locus of every summand, membership in $Z(F_5)$, saturation of the bound $F_5\ge0$, holds verbatim of $O(5)\cdot(-W_0)$. So no argument that reads "the summands vanish on the orbit, therefore equality holds exactly there" can be sound: run it at $-W_0$ and it concludes $\theta(-W_0)=\sqrt{3/2}$, which is false. **The certificate cannot separate $\mathcal E_+$ from $\mathcal E_-$, and the equality clause is a statement about $\mathcal E_+$ alone.**

This is the same phenomenon the record has already met and stated correctly elsewhere: [result 124](../findings/INDEX-results.md) records a rigidity on the half-flat four-set family as "$\theta^2\le\Sigma\le\tfrac32\rho^2$ with equality exactly at $\pm W_{\mathbb{CP}^2}$", an even inequality, with the $\pm$ kept. L61's clause drops it.

### 3c. The homogeneity witness

$F_5$ is homogeneous of degree $6$, so $Z(F_5)$ is a cone: $F_5(tW)=t^6F_5(W)$. Hence $0\in Z(F_5)$ and $tW_0\in Z(F_5)$ for every $t\in\mathbb R$, while $O(5)\cdot W_0$ is norm-preserving and contains neither $0$ nor $2W_0$. So $Z(F_5)\ne O(5)\cdot W_0$ for reasons of scaling alone, before parity is invoked.

This bites the clause itself, and not only the inference, under the form of the statement that omits the normalisation: $\theta(2W_0)=\theta(W_0)=\sqrt{3/2}$ and $2W_0\notin O(5)\cdot W_0$, so "equality exactly on that orbit" is false as a sentence about $\mathcal W_5$. [results.md:625](../results.md) quantifies over "every unit $W$" and escapes this; the two forms without the normalisation do not. The honest object is $\mathbb R_{>0}\cdot(O(5)\cdot W_0)$, or the orbit intersected with the unit sphere.

### 3d. Nothing weaker rescues it, and the conclusion is not obviously true

What the reverse inclusion would assert is a rigidity theorem: that $\mathcal E_+\cap\{\lVert W\rVert=1\}$, a compact $O(5)$-invariant set containing the orbit, is exactly one orbit. Two observations on whether it is cheap.

- **Spectra do not force it.** Equality is $\mathop{\mathrm{tr}}(W^3)=1/\sqrt6$ at $\mathop{\mathrm{tr}}(W^2)=1$, $\mathop{\mathrm{tr}}(W)=0$ on $\Lambda^2\mathbb R^5$, which is $10$-dimensional. The maximum of the cube trace under those two constraints alone is $8/\sqrt{90}$, attained at $(9,-1^9)/\sqrt{90}$, and $64/90>1/6$, so $1/\sqrt6$ is an interior value of the spectral range and $\{\mathop{\mathrm{tr}}(W^3)=1/\sqrt6\}$ is a hypersurface in spectrum space, not a point. Whatever pins the equality set to one orbit is the Weyl condition, not the spectrum, and the certificate is silent on which of its zeros are Weyl-rigid.
- **The record carries no such rigidity that I may read.** No file among those the brief permits states uniqueness of the $n=5$ maximiser. Per the standing rule I do not supply the argument. I note only that the clause's stated ground (the word "Hence"), is the certificate, and §3a–§3b show that ground cannot bear it; whether some independent argument exists in [sym3-blocks.md](../findings/sym3-blocks.md), which this brief excludes, I make no claim about, except that it would have to be an argument of a different kind.

## 4. What does follow

Stated positively, so the repair is visible without an argument being supplied:

- $O(5)\cdot W_0\subseteq\{W:\lVert W\rVert=1,\ \theta(W)=\sqrt{3/2}\}$, direction one, valid.
- $Z(F_5)\supseteq\mathbb R\cdot\big(O(5)\cdot W_0\big)$, and by parity $\supseteq\mathbb R\cdot\big(O(5)\cdot W_0\cup O(5)\cdot(-W_0)\big)$, from the certificate.
- $\theta\le\sqrt{3/2}$ on $\mathcal W_5\setminus\{0\}$, attained, granted, and the attainment is what makes $M(5)=\sqrt{3/2}$.
- The equality set is a nonempty compact $O(5)$-invariant subset of the unit sphere containing $O(5)\cdot W_0$. **That it equals the orbit is open on the material this brief covers.**

## 5. Verdict

**FAILS as written.** The clause is two statements and they part company:

| direction | verdict |
| --- | --- |
| orbit $\Rightarrow$ equality | **VALID**, from the $O(5)$-invariance of $\theta$ and the exact evaluation $\theta(W_0)=3/\sqrt6=\sqrt{3/2}$, the certificate supplies $\theta^2=3/2$ on the orbit and cannot supply the sign |
| equality $\Rightarrow$ orbit | **FAILS**. A sum of squares fixes $Z(F_5)=\bigcap_iZ(c_i)$ and the hypothesis places the orbit inside it; the reverse inclusion is a real-radical statement absent from the certificate, whose file holds $47$ rationals and no variety data. The evenness of $F_5$ against the oddness of the cubics puts the distinct orbit $O(5)\cdot(-W_0)$ in $Z(F_5)$, so the inference proves too much; homogeneity puts $0$ and every $tW_0$ there as well |

The word carrying the defect is **"Hence"**. The bound $\theta\le\sqrt{3/2}$ does follow from the certificate; the identification of its equality set does not, and cannot from a certificate of this shape.
