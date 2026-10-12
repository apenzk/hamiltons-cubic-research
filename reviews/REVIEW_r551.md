# Review r551, Lemma L28 (the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$)

Reviewer r551, independent adversarial audit. Target: `#### Lemma L28` in [findings/nondegeneracy.md](../findings/nondegeneracy.md), restated in [results.md](../results.md) and cited in [findings/target.md](../findings/target.md).

Footing: analysis only. No sweeps, searches or censuses were run. Any arithmetic screen is labelled as a screen and is never offered as evidence for a positive claim.

Status: **complete**. Overall verdict: CONFIRMED, with one arithmetic repair and four editorial ones, see the Verdicts table.

## Verdicts

### Method, the route I used, sharing nothing with the block's

The block derives its decomposition from the $GL_n\subset O_{2n}$ branching rule, cited to Howe–Tan–Willenbring, and its eigenvalues from closed forms for $\sharp(P_\omega,\cdot)$ and $\sharp(P_{\mathfrak u},\cdot)$. I used neither. My route is

$$S^2(\Lambda^2V)=\mathcal W\oplus S^2_0(V)\oplus\mathbb R\oplus\Lambda^4V,$$

decomposing each of the four terms under $U(m)$ by the Cauchy formula and the Littlewood–Richardson rule for $V_{\alpha;\beta}$, then subtracting. The eigenvalue list I then tested against the trace identity $\operatorname{tr}_{\mathcal W_n}L_e=0$, which holds because $e\mapsto\operatorname{tr}L_e$ is an $O(n)$-invariant linear functional on the irreducible non-trivial $\mathcal W_n$.

Notation: $V_\mathbb C=E\oplus\bar E$ with $E$ the standard $U(m)$-module of charge $+1$; $V_{\alpha;\beta}$ the $GL_m$-module of highest weight $(\alpha_1,\alpha_2,\dots,-\beta_2,-\beta_1)$, charge $q=|\alpha|-|\beta|$.

### Finding 1, the decomposition has ten summands, and the *Argument* names nine. CONFIRMED as a defect, REPAIRED

Working charge by charge, with $L=\Lambda^2E$, $G=E\otimes\bar E$:

| charge | $S^2(\Lambda^2V_\mathbb C)$ | remove $S^2_0\oplus\mathbb C\oplus\Lambda^4$ | $\mathcal W_{2m}\otimes\mathbb C$ |
| --- | --- | --- | --- |
| $+4$ | $S_{(2,2)}E\oplus\Lambda^4E$ | $\Lambda^4E$ | $V_{(2,2);\varnothing}$ |
| $+2$ | $V_{(2,1);(1)}\oplus V_{(1,1,1);(1)}\oplus V_{(2);\varnothing}\oplus2V_{(1,1);\varnothing}$ | $V_{(2);\varnothing}$, $V_{(1,1,1);(1)}\oplus V_{(1,1);\varnothing}$ | $V_{(2,1);(1)}\oplus V_{(1,1);\varnothing}$ |
| $0$ | $V_{(2);(2)}\oplus2V_{(1,1);(1,1)}\oplus3V_{(1);(1)}\oplus3\mathbb C$ | $V_{(1);(1)}$, $\mathbb C$, $V_{(1,1);(1,1)}\oplus V_{(1);(1)}\oplus\mathbb C$ | $V_{(2);(2)}\oplus V_{(1,1);(1,1)}\oplus V_{(1);(1)}\oplus\mathbb C$ |
| $-2,-4$ | conjugates | conjugates | conjugates |

**Ten summands**, pairwise non-isomorphic, so multiplicity-free, and at $m=3$, $V_{(1,1);(1,1)}$ is absent, leaving **nine**. The block's count is right; its **enumeration is short by one**. The *Argument* names $\langle W\rangle$, $\mathfrak{su}(m)$, $\Lambda^2E$, $\Lambda^2\bar E$, $V_{(1,1);(1,1)}$, $V_{(2,2);\varnothing}$ and its conjugate (seven) and then says "$0$ on the remaining **two**". The remaining summands are **three**: $V_{(2);(2)}$, and the conjugate pair $V_{(2,1);(1)}\oplus V_{(1);(2,1)}$. They form **two isotypic classes** under conjugation, which is presumably what "two" meant, but as written the enumeration totals nine and contradicts the block's own "ten".

**Nothing about $E(\tfrac12)$ turns on it**: both remaining classes carry eigenvalue $0$ (Finding 3), and $0\ne\tfrac12$.

### Finding 2, the dimensions close, as a polynomial identity in $m$. The brief's $212$ is exactly the two unnamed summands

$$\dim_\mathbb C V_{(2);(2)}=\frac{m^2(m+3)(m-1)}4,\qquad \dim_\mathbb C V_{(2,1);(1)}=\frac{m^2(m-2)(m+2)}3,\qquad \dim_\mathbb C V_{(2,2);\varnothing}=\frac{m^2(m^2-1)}{12}.$$

Summing all ten,

$$1+(m^2-1)+m(m-1)+\frac{m^2(m+1)(m-3)}4+\frac{m^2(m^2-1)}6+\frac{m^2(m+3)(m-1)}4+\frac{2m^2(m^2-4)}3=\frac{m(4m^3-7m-3)}3,$$

and $\dim\mathcal W_{2m}=\frac{2m(2m-3)(2m+1)(2m+2)}{12}=\frac{m(m+1)(2m-3)(2m+1)}3$ with $(m+1)(2m-3)(2m+1)=4m^3-7m-3$. **Identical.** At $m=4$ the ten dimensions are $1,15,6,6,20,20,20,84,64,64$, summing to $300=\dim\mathcal W_8$; the brief's $212$ unaccounted is exactly $84+128$. At $m=3$ they are $1,8,3,3,6,6,27,15,15$, summing to $84=\dim\mathcal W_6$.

So the decomposition **is** a decomposition, and no summand is missing that could carry $\tfrac12$. **Multiplicity-freeness, which the block concedes it cites rather than derives, is derived here** for every $m\ge3$: the ten highest weights are pairwise distinct.

### Finding 3, the two paragraphs disagree; the *Argument* is right and the **charge table's $4m$ is the error**. REPAIRED

The brief presumed the table and read the *Argument* as the loose one. The opposite holds.

**Recovering the normalisation.** Fit $c_S+q_S^2$ against the $\mathfrak{gl}_m$ highest weight $\lambda$ of each summand with $q_S=|\lambda|$ and $c_S=\sum_i\lambda_i(\lambda_i+m+1-2i)$, the Casimir in the normalisation $|\theta|^2=2$, plus its $U(1)$ part:

| summand | weight $\lambda$ | $c_S$ | $q_S$ | $c_S+q_S^2$ | table |
| --- | --- | --- | --- | --- | --- |
| $\mathbb C$ | $0$ | $0$ | $0$ | $0$ | $0$ |
| $V_{(1);(1)}$ | $(1,0,\dots,0,-1)$ | $2m$ | $0$ | $2m$ | $2m$ |
| $V_{(1,1);\varnothing}$ | $(1,1,0,\dots)$ | $2m-2$ | $2$ | $2(m+1)$ | $2(m+1)$ |
| $V_{(1,1);(1,1)}$ | $(1,1,0,\dots,-1,-1)$ | $4m-4$ | $0$ | $4(m-1)$ | $4(m-1)$ |
| $V_{(2);(2)}$ | $(2,0,\dots,0,-2)$ | $4m+4$ | $0$ | $4(m+1)$ | $4(m+1)$ |
| $V_{(2,2);\varnothing}$ | $(2,2,0,\dots)$ | $4m$ | $4$ | $4(m+4)$ | $4(m+4)$ |
| $V_{(2,1);(1)}$ | $(2,1,0,\dots,0,-1)$ | $4m$ | $2$ | $\mathbf{4(m+1)}$ | $\mathbf{4m}$ |

Six of seven land on a table entry exactly, which pins the normalisation beyond coincidence. The seventh does not: $V_{(2,1);(1)}$ gives $4(m+1)$, so **$4(m+1)$ occurs twice and the value $4m$ belongs to no summand of $\mathcal W_{2m}$**. The correct eigenvalue list is

$$1,\quad \frac{m+2}{2(m+1)},\quad \tfrac12,\quad \frac2{m+1},\quad -\frac3{m+1},\quad 0,\quad 0,$$

which is precisely what the *Argument* paragraph says, "$0$ on the remaining two".

**Independent confirmation, by a route using no Casimir at all.** $\mathcal W_n$ is $O(n)$-irreducible and non-trivial and $e\mapsto\operatorname{tr}L_e$ is a linear $O(n)$-invariant functional on it, so $\operatorname{tr}_{\mathcal W_n}L_e=0$ at every $e$. Writing $x$ for the unknown value on $V_{(2,1);(1)}\oplus\mathrm{conj}$ and using the dimensions of Finding 2,

$$1+\frac{(m-1)(m+2)}2+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2+0+\frac{2m^2(m^2-4)}3x=\frac{2m^2(m^2-4)}3x,$$

because the five leading terms cancel identically: $(m^2+m-2)+(m^2-m)+(m^3-3m^2)-(m^3-m^2)=-2$, and $1-\tfrac22=0$. Hence $x=0$ **identically in $m$**, and the alternative $x=\frac1{m+1}$ implied by the table's $4m$ leaves a trace of $\frac{2m^2(m^2-4)}{3(m+1)}\ne0$ at every $m\ge3$. The same identity, applied instead to $V_{(2);(2)}$, confirms its $0$.

That the other five values cancel to $0$ identically in $m$ is a non-trivial polynomial check on the whole list, passed.

**The conclusion is untouched either way.** $\frac1{m+1}=\tfrac12$ needs $m=1$ and $0=\tfrac12$ never, so no reading puts a second summand at $\tfrac12$; and $\frac{m+2}{2(m+1)}>\frac{4}{2(m+1)}=\frac2{m+1}$ for $m>2$, so $\lambda_{\max}=\frac{m+2}{2(m+1)}$ under either reading.

**Repair.** In the *How the eigenvalues are obtained* paragraph, the seven quantities should read $0,\;2m,\;2(m+1),\;4(m-1),\;4(m+1),\;4(m+1),\;4(m+4)$, six distinct values across seven isotypic classes, with $V_{(2);(2)}$ and $V_{(2,1);(1)}\oplus\mathrm{conj}$ coinciding at $4(m+1)$. The phrase "across the seven summands" should read "across the seven isotypic classes", since the summands number ten.

### Finding 4, $\theta^2$ and the projector coefficients: CONFIRMED, by two checks the block does not run

Take the block's closed form at face value,
$$e=-\frac1{2m-1}P_{\mathfrak m}+\frac{m-2}{(m+1)(2m-1)}P_{\mathfrak{su}(m)}+\frac{2(m-1)}{2m-1}P_\omega,$$
with $\operatorname{rank}P_{\mathfrak m}=m(m-1)$, $\operatorname{rank}P_{\mathfrak{su}(m)}=m^2-1$, $\operatorname{rank}P_\omega=1$.

**Trace-free.** A Weyl operator is totally trace-free, so $\operatorname{tr}_{\Lambda^2}e=0$ is a necessary condition:
$$\frac1{2m-1}\Big[-m(m-1)+\frac{(m-2)(m^2-1)}{m+1}+2(m-1)\Big]=\frac{m-1}{2m-1}\big[-m+(m-2)+2\big]=0 .$$
Passes identically in $m$.

**Norm.** [conventions.md](../findings/conventions.md) puts the $\tfrac12$ at the $\Lambda^2$ level and not at the operator level, so for an operator on $\Lambda^2$ the norm is $\lVert W\rVert^2=\operatorname{tr}(W^2)$. Then
$$\lVert e\rVert^2=\frac{m-1}{(2m-1)^2(m+1)}\big[m(m+1)+(m-2)^2+4(m-1)(m+1)\big]=\frac{(m-1)\cdot3m(2m-1)}{(2m-1)^2(m+1)}=\frac{3m(m-1)}{(m+1)(2m-1)} .$$
Since $e=W/\theta$ at $\lVert W\rVert=1$, this says $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, **the block's value, recovered from its own projector coefficients and the record's norm convention.**

**External anchor.** At $m=2$ the formula gives $\theta^2=\frac{3\cdot3}{3\cdot2\cdot1}=\tfrac32$, and the record has $W_{\mathbb{CP}^2}$ critical at $\theta=\sqrt{3/2}$ exactly, twelve digits, at $n=4,8,10,12,14$ ([nondegeneracy.md](../findings/nondegeneracy.md), the padded-$\mathbb{CP}^2$ paragraph). The family formula extrapolates correctly to a value the record measured independently. **The norm is right and the $\sqrt2$ trap is not tripped**: had the $\tfrac12$ been applied at the operator level, $\theta$ would come out $\sqrt3$ at $m=2$.

### Finding 5, the orbit dimension, and the stronger claim the block needs. CONFIRMED

$\dim SO(2m)-\dim U(m)=m(2m-1)-m^2=m(m-1)$, so **if** the stabiliser is $U(m)$ the orbit has dimension $m(m-1)$. The stabiliser is $U(m)$, and the argument does not require knowing $W$ explicitly:

- $\mathfrak{stab}=\{X\in\mathfrak{so}(2m):X\cdot W=0\}$ is $\mathrm{Ad}(U(m))$-invariant, because $W$ is $U(m)$-invariant.
- $\mathfrak{so}(2m)=\mathfrak u(m)\oplus\mathfrak m$ with $\mathfrak m$ the real form of $\Lambda^2E\oplus\Lambda^2\bar E$, which is $U(m)$-irreducible as a real module (its complexification is a sum of two non-isomorphic conjugate irreducibles).
- $\mathfrak u(m)\subseteq\mathfrak{stab}$ by hypothesis. So $\mathfrak{stab}$ is $\mathfrak u(m)$ or all of $\mathfrak{so}(2m)$, and the latter forces $W=0$ since $\mathcal W_{2m}$ carries no $SO(2m)$-invariant vector.

Hence $\dim(\text{orbit})=m(m-1)$ exactly.

**Orbit versus eigenspace, the distinction the brief asks for.** The orbit tangent is *contained* in $E(\tfrac12)$ for the reason that holds at every critical point: differentiating $Q(W_t)=\theta W_t$ along the orbit, where $\theta$ is constant, gives $2W\circ\dot W=\theta\dot W$, i.e. $L_e\dot W=\tfrac12\dot W$. Containment plus **equality of dimensions** $m(m-1)=m(m-1)$ upgrades it to $E(\tfrac12)=T(\text{orbit})$, which is the Morse–Bott condition. The block asserts the equality of the two numbers; the containment that makes the equality mean something is left implicit. It is true, and it is worth one line in the block.

**Two more of the block's values are structural rather than computed, and this is a strength.** $L_eW=e\circ W=\tfrac1\theta Q(W)=W$, so $\lambda=1$ on $\langle W\rangle$ at *any* critical point; and $\lambda=\tfrac12$ on the orbit summand likewise. Only $\frac{m+2}{2(m+1)}$, $\frac2{m+1}$, $-\frac3{m+1}$ and the two zeros are genuinely computed, and those five are constrained by one exact linear relation, the trace identity of Finding 3, which they satisfy identically in $m$.

### Finding 3, corroborated a third way, the record's own reference notes already carry the correct table

[references/howe-tan-willenbring-2005-stable-branching/notes.md](../references/howe-tan-willenbring-2005-stable-branching/notes.md) prints the seven real summands with their dimensions and $L_e$ values, and its last two rows are

| $GL(m)$ highest weight | real dimension | $L_e$ |
| --- | --- | --- |
| $(2,1,0^{m-3},-1)\oplus$ dual | $\frac{2m^2(m^2-4)}3$ | $0$ |
| $(2,0^{m-2},-2)$ | $\frac{m^2(m-1)(m+3)}4$ | $0$ |

**both zero**, matching my Casimir computation and my trace-identity computation row for row, and matching every dimension in Finding 2. The notes also state, independently, that the seven dimensions sum to $\frac{m(m+1)(2m+1)(2m-3)}3$ identically in $m$ and that $\operatorname{tr}L_e=0$ identically in $m$.

**So the record already holds the correct list, and [findings/nondegeneracy.md](../findings/nondegeneracy.md)'s charge table disagrees with it.** The defect is confined to the findings block; the value $4m$ appears nowhere else and belongs to no summand.

**And this reframes Finding 1.** The reference notes count *seven real* summands, "ten complex ones, three of them conjugate pairs". Read that way, the *Argument*'s enumeration, $\langle W\rangle$, $\mathfrak{su}(m)$, $\Lambda^2E\oplus\Lambda^2\bar E$ as one real summand, $V_{(1,1);(1,1)}$, $V_{(2,2);\varnothing}\oplus\mathrm{conj}$ as one, and "the remaining two", is **exactly seven and exactly right**. The defect is therefore not an omission but a **switch of convention inside one paragraph**: the sentence opens with the complex count ("ten summands, nine at $m=3$") and then enumerates in real summands, splitting $\Lambda^2E$ from $\Lambda^2\bar E$ in the prose while counting $V_{(2,2);\varnothing}\oplus\mathrm{conj}$ as one. Any reader who counts the named objects gets nine and cannot reconcile it.

**Repair for Finding 1:** say "ten complex summands, seven real, nine and six at $m=3$", and enumerate consistently in one of the two.

### Finding 4a, the $\theta$ closed form is not a leaf of this lemma, and the record proves it elsewhere

The same $\theta^2$ appears at [algebra.md:29](../findings/algebra.md#L29) with an **independent derivation** ("it supplies the proof of the closed form that the measurement lacked"), listing $3/2,\ 10/9,\ 35/36,\ 9/10,\ 77/90,\ 52/63$ at $r=2m=4,\dots,14$, every one of which the formula reproduces. It appears again at [graded-half.md:420](../findings/graded-half.md#L420) and [graded-half.md:446](../findings/graded-half.md#L446) inside [Lemma L10](../findings/graded-half.md), at [INDEX-values.md:49](../findings/INDEX-values.md#L49), and in [LEDGER.md](../findings/LEDGER.md) row 10 as **CONFIRMED (numbers)** with both reviewers rebuilding it independently. [graded-half.md:168](../findings/graded-half.md#L168) carries $\lVert W\rVert^2_{\mathbb{CP}^m}=\frac{3m(m-1)}{4(m+1)(2m-1)}$, which is my $\lVert e\rVert^2$ divided by $4$, the $\lvert W\rvert^2=4\lVert W\rVert_F^2$ conversion of [conventions.md](../findings/conventions.md), so the two agree.

### Finding 5a, the Statement's three numbers are independently corroborated inside the record, at $m=3$ and $m=4$

[target.md:579](../findings/target.md#L579) tabulates $\mathbb{CP}^3,\mathbb{CP}^4$ with $\lambda_{\max}=0.625,\ 0.600$ and $\dim E(\tfrac12)=6,\ 12$ against orbit $6,\ 12$, excess $0$; [target.md:560](../findings/target.md#L560) repeats $0.62500000$ at $\mathbb{CP}^3$; [target.md:538](../findings/target.md#L538) records $\dim\mathfrak m=6,12$. These are $\frac{m+2}{2(m+1)}=\tfrac58,\tfrac35$ and $m(m-1)=6,12$ exactly. **The whole Statement is measured elsewhere in the record and agrees.**

### Finding 6, the trace identity determines each computed value from the other four. CONFIRMS the row that carries the conclusion

Only two of the seven values are structural: $\lambda=1$ on $\langle W\rangle$ and $\lambda=\tfrac12$ on the orbit, both following from criticality alone (Finding 5). The other five are computed, and the block attests them by the charge formula plus, for the orbit row, three further routes, **which is the one row that needed no attestation.** The row that carries the "not a maximiser" conclusion, $\frac{m+2}{2(m+1)}$ on $\mathfrak{su}(m)$, has none.

The trace identity supplies one. Holding the other values fixed and solving $\operatorname{tr}L_e=0$ for the unknown $y$ on $\mathfrak{su}(m)$:

$$(m^2-1)y=\frac{m(m+1)}2-1=\frac{(m+2)(m-1)}2\quad\Longrightarrow\quad y=\frac{m+2}{2(m+1)} .$$

The same solve returns $\frac2{m+1}$ on $V_{(1,1);(1,1)}$, $-\frac3{m+1}$ on $V_{(2,2);\varnothing}\oplus\mathrm{conj}$, and $0$ on each remaining class, each uniquely from the other four. **One exact linear relation, five computed unknowns: it pins any one given the rest, and it is satisfied identically in $m$ by the full list.** That is a real check and not a proof of all five at once, and the block should say so.

### Finding 3, settled, a fourth confirmation, and the error's provenance

[second-order.md:285](../findings/second-order.md#L285) defines the two quantities explicitly:

$$\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)},\qquad c_S=\sum_i\nu_i(\nu_i+m+1-2i),\qquad q_S=\sum_i\nu_i,$$

with $\nu$ the $GL(m)$ highest weight, **verbatim the normalisation I reverse-engineered in Finding 3 before reading this file.** Under it, $V_{(2,1);(1)}$ at $\nu=(2,1,0^{m-3},-1)$ has $c_S=2(m+1)+(m-2)+m=4m$ and $q_S=2$, so $c_S+q_S^2=4(m+1)$.

**The provenance of the defect is now visible.** $V_{(2,2);\varnothing}$ and $V_{(2,1);(1)}$ share $c_S=4m$; the list's entry $4m$ is $V_{(2,1);(1)}$'s **$c_S$ with $q_S^2$ never added**. One row of the table was tabulated in the wrong column.

**And the same defective list appears in both files**, [nondegeneracy.md](../findings/nondegeneracy.md) and [second-order.md:288](../findings/second-order.md#L288), while **both files' summand tables carry the correct $0$** on that row. So the record disagrees with itself twice over, in the same way, three lines apart.

Confirmations of $4(m+1)$, by four routes sharing nothing: my Casimir computation; the trace identity; [references/howe-tan-willenbring-2005-stable-branching/notes.md](../references/howe-tan-willenbring-2005-stable-branching/notes.md); and [second-order.md:266](../findings/second-order.md#L266)'s own table.

### Finding 7, the canonical block is the weaker of two copies of the same proof. STRUCTURAL DEFECT

[second-order.md:262](../findings/second-order.md#L262) carries a block headed "The $\mathbb{CP}^m$ family: nondegenerate at every $m\ge3$" which is a **fuller proof of L28 than L28's own canonical block**, and it is not cross-linked from it. It carries, and [nondegeneracy.md](../findings/nondegeneracy.md) does not:

- the full seven-row summand table with dimensions and eigenvalues;
- the explicit definition of $c_S$ and $q_S$, without which the charge formula cannot be checked at all;
- the $\sharp$ closed forms $\sharp(vv^\top,X)=-\tfrac12D(v)XD(v)$, $\sharp(P_\omega,X)=-\tfrac1{2m}D(J)XD(J)$, $\sharp(P_{\mathfrak u},X)=-\tfrac14[\mathrm{Cas}(X)+C_2X+XC_2]$;
- the scope of what is proved: "Bianchi, Ricci-flatness and $\theta^2$ are proved symbolically for all $m$; **the six $\sharp$ closed forms behind them are exact in GF(p) at $m=3\ldots20$**";
- a caveat that materially qualifies L28's argument (**"$\sharp(P_{\mathfrak u},\cdot)$ does not preserve $\mathrm{Weyl}_n$), $28$–$46\%$ of the image leaves, so per-summand values of the individual pieces are exact as Rayleigh quotients with eigen-residuals of order $1$. Only the assembled $L_e$ preserves $\mathrm{Weyl}_n$"**;
- the $m=2$ anchor, and three recorded traps.

**A block headed "canonical statement and proof" that is a lossy copy of an uncited sibling is not canonical.** The two should be merged, with the fuller text at the canonical site.

### Finding 8, the "What is not proved" concession is INCOMPLETE

It concedes two things: multiplicity-freeness is cited, and a fourth route has three underived columns. Three further dependencies go unflagged, all of them recoverable from [second-order.md](../findings/second-order.md):

1. **The $\sharp$ closed forms are checked in $\mathrm{GF}(p)$ at $m=3\ldots20$, not proved for all $m$.** They are the machinery the whole charge collapse runs on.
2. **$\sharp(P_{\mathfrak u},\cdot)$ leaves $\mathcal W_n$**, so the intermediate per-summand numbers are Rayleigh quotients and only the assembled $L_e$ is an operator on $\mathcal W_n$. A reader of the canonical block would not know this.
3. **The three attestations are spent on the row that needs none.** "The critical row was obtained three independent ways" attests $\tfrac12$ on the orbit, which follows from criticality alone in one line (Finding 5), at every critical point of every kind. The row carrying the conclusion, $\frac{m+2}{2(m+1)}$ on $\mathfrak{su}(m)$, is attested by the charge formula alone in the block. Finding 6 supplies a second route; the record supplies a third at [target.md:560](../findings/target.md#L560), where $\mathbb{CP}^3$'s violating subspace is measured at **dimension $8=m^2-1$**, naming the $\mathfrak{su}(3)$ adjoint as the carrier.

Two things the concession did **not** need to say, and can now drop: multiplicity-freeness is derived in Finding 2 for every $m\ge3$; and the $m=3$ case, which [the HTW notes](../references/howe-tan-willenbring-2005-stable-branching/notes.md) reach only by numerical agreement because the stable rule needs $\lfloor m/2\rfloor\ge2$, is derived analytically in Finding 2, the nine complex summands at $m=3$ have dimensions $1,8,3,3,6,6,27,15,15$ and sum to $84$.

### Finding 9, "the summand's dimension vanishes" at $m=3$: the accurate statement is that the summand is ABSENT

At $m=3$, $\Lambda^2E\otimes\Lambda^2\bar E$ is nine-dimensional and exhausted by $\mathfrak{su}(3)\oplus\mathbb C$; the branching produces no $V_{(1,1);(1,1)}$ at all, and its weight $(1,1,0^{m-4},-1,-1)$ is not even dominant for $GL_3$. That $\frac{m^2(m+1)(m-3)}4$ vanishes there is a consistency of the formula rather than the presence of a zero-dimensional object, and the distinction matters: as written the block reads as evaluating an eigenvalue on an object at the point where it degenerates. **[results.md:142](../results.md#L142) already uses the right word ("where that summand is empty") and [nondegeneracy.md](../findings/nondegeneracy.md) and [second-order.md](../findings/second-order.md) should adopt it.**

**The quantifier is right and $m\ge4$ is needed nowhere.** $m=3$ is fully covered, analytically. $m=2$ is genuinely outside: $\frac{m^2(m+1)(m-3)}4=-3$ there, $\mathcal W_4$ splits as $\mathcal W^+\oplus\mathcal W^-$ under $SO(4)$, and $\lambda_{\max}(L_e\vert_{W^\perp})=1$ at $W_{\mathbb{CP}^2}$ by [Lemma L24](../findings/second-order.md)'s own box. [LEDGER.md:378](../findings/LEDGER.md#L378) already records this, and it is right. That $m\ge3$ means $n\ge6$, below the conjecture's $n\ge12$, costs nothing: the lemma is a statement about a family, and the members below $12$ are the ones the record uses as controls.

### Finding 10, $n=6$: consistent, and the block should say why. The tension is REAL as a gap in the writing, not in the mathematics

The three facts are all true at once:

| | |
| --- | --- |
| $\theta(\mathbb{CP}^3)^2=\frac{4\cdot5}{3\cdot3\cdot2}=\tfrac{10}9$ | $=\theta_0(6)^2=\frac{2\cdot5\cdot4}{36}$, and $\Theta_6=\theta_0(6)$ at even $n$ |
| $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac58>\tfrac12$ at $\mathbb{CP}^3$ | so it is **not** a maximiser, by [Lemma L24](../findings/second-order.md) |
| $S^3\times S^3$ is **degenerate**, $\dim E(\tfrac12)=18$ against orbit $9$ | [Lemma L27](../findings/nondegeneracy.md), $(p-2)(q-2)-1=0$ at $(3,3)$ |

**The resolution is that the maximum at $n=6$ strictly exceeds $\Theta_6$, and there are two independent witnesses on the record.** $\Theta_n$ is the *diagonal* maximum, and both witnesses are non-diagonal:

- **Padded $W_{\mathbb{CP}^2}$.** Padding commutes with $Q$ and preserves the norm and $\theta$ ([conventions.md](../findings/conventions.md)), so $\mathbb R^4\subset\mathbb R^6$ carries the $n=4$ point to a critical point of $\mathcal W_6$ at $\theta=\sqrt{3/2}=1.2247>1.0541$. The record verifies criticality of this padding at $n=4,8,10,12,14$, and the mechanism is dimension-free.
- **The $(\mathfrak{su}(3),\mathfrak{so}(3))$ point**, at $\theta=1.0954$ ([target.md:440](../findings/target.md#L440)), also above $\Theta_6$.

So no maximiser at $n=6$ has $\theta=\theta_0(6)$, and L24's bound is violated at $\mathbb{CP}^3$ precisely as it should be. **There is no contradiction.** What is missing is one sentence in the block saying so, as written, "$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$" and "not a maximiser" sit three lines apart with nothing to tell a reader that the first equals $\Theta_6$ at $m=3$ and that this is harmless.

**Coincident critical values at $n=6$ are recorded elsewhere and read correctly there.** [target.md:568](../findings/target.md#L568), "$\mathbb{CP}^3$ and $S^3\times S^3$ share $\theta=1.054093$ exactly and land on opposite sides, so this is genuinely new information"; [graded-half.md:209](../findings/graded-half.md#L209), the two "share $\theta=\sqrt{10}/3$ exactly, **which is how they were confused**", a confusion that produced a false "third-order saddle" description of $\mathbb{CP}^3$, since withdrawn. So the record knows the coincidence and knows it is a trap. **L28's block is the one place that carries the number without the warning.**

**Neither point is covered by the "nondegenerate graded set" picture at $n=6$, and the file says so.** $S^3\times S^3$ is the one degenerate graded point on record, and the section after L28 downgrades route R2 to a **value-localised** hypothesis for exactly that reason. That disclosure is adequate.

### Finding 11, the closing note about the slice corrector. Outside the block, already retracted, and no threat

The note, "a slice corrector drove the criticality residual to $1.9\times10^{-13}$ at transverse distance $0.2$ with $\theta$ unchanged to nine digits, **the wrong direction for an isolated orbit**", sits in "What survives, and what to do", **after** L28's Sources line, so it is not part of the lemma. And the same file retracts it three subsections later: *"Reviewer 16's 'slice corrector reached residual $1.9\times10^{-13}$ at transverse distance $0.2$ with $\theta$ unchanged' has no script in the tree; given the above it was almost certainly measuring orbit motion, and it must be re-measured against the orbit before being reused."*

**Compatible with the isolated-orbit claim, and the mechanism is the file's own standing rule.** At $\mathbb{CP}^3$ the orbit is $m(m-1)=6$-dimensional, so an ungauged corrector slides along it; "distance to a critical point is not distance to its orbit" is recorded in the same file as a standing rule, with the gauge-fixed measure $\min_g\lVert gW'g^{\mathsf T}-W_0\rVert$. **And the logical direction runs the other way:** L28 *proves* $E(\tfrac12)=T(\text{orbit})$, and a nondegenerate orbit is isolated in $\mathrm{Crit}(P)$; a numerical observation contradicting that would be evidence against the measurement, not against the lemma.

**One editorial defect stands.** The note reads as live where it sits, under its own heading, and the retraction forty lines below does not point back to it.

### Finding 12, consumers, and one that steps outside the hypotheses

| site | use | verdict |
| --- | --- | --- |
| [results.md:402](../results.md#L402) | full restatement | **matches the block verbatim** |
| [results.md:142](../results.md#L142) | landscape summary, "$\frac2{m+1}$ reaches $\tfrac12$ at $m=3$, where that summand is **empty**" | **correct, and better worded than the block** |
| [results.md:382](../results.md#L382) | "$\mathbb{CP}^m$ at $m\ge3$" fails the L24 bound | inside hypotheses |
| [second-order.md:255](../findings/second-order.md#L255) | $\mathfrak u(m)\subset\mathfrak{so}(2m)$ at $\frac{m+2}{2(m+1)}$ violates L24, "including $W_{\mathbb{CP}^3}$, which is graded and sits at $\theta_0(6)$ exactly while failing to be a local maximizer" | inside hypotheses, **and it is the only site that states the $n=6$ coincidence alongside the conclusion** |
| [target.md:423](../findings/target.md#L423) | "maximality still rests on Lemma L28's closed form plus the census" | the closed form is used across the whole family including $m=2$ |
| [target.md:466](../findings/target.md#L466) | "exactly Lemma L28's $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, **maximised at $m=2$ at exactly $\tfrac32$**" | **outside the hypotheses.** L28 is stated for $m\ge3$ |
| [target.md:526](../findings/target.md#L526) | $\dim\mathfrak m=m(m-1)$, and "the next $L_e$ eigenvalue being $0.625$ and $0.600$" | inside hypotheses; independently derived there |
| [graded-half.md:207](../findings/graded-half.md#L207) | $\mathbb{CP}^3$ an ordinary saddle, excess $0$ | inside hypotheses |
| [REVIEW_r526.md:59](REVIEW_r526.md), [REVIEW_r373.md:88](REVIEW_r373.md), [ELIM-secondorder.md:187](ELIM-secondorder.md) | L28 as the control for "nondegenerate and not a maximiser"; the openness preamble; the arithmetic condition | inside hypotheses |

**The one defect.** [target.md:466](../findings/target.md#L466) evaluates L28's closed form at $m=2$, which L28 does not assert. The *value* is right, $\theta^2=\tfrac32$, and my own norm computation reproduces it from the projector form, whose $P_{\mathfrak{su}}$ coefficient vanishes at $m=2$, but the citation should be [Lemma L10](../findings/graded-half.md), whose $\theta^2$ block explicitly covers $m=2$ and is where [algebra.md:29](../findings/algebra.md#L29)'s independent derivation lands. The distinction is live because $m=2$ is exactly where L28's *decomposition* breaks: $\frac{m^2(m+1)(m-3)}4=-3$ there.

### Finding 13, the heading's promise, and the norm

**"Canonical statement and proof."** The block carries a **Statement**, an **Argument** closing with $\square$, a **How the eigenvalues are obtained** paragraph closing with $\square$, a **What is not proved**, and **Sources**. It is a proof modulo cited inputs, and it is not one of the blocks that promise a proof and deliver assertion. What it is **not** is *canonical*, for the reason in Finding 7: a fuller and more careful version of the same proof lives at [second-order.md:262](../findings/second-order.md#L262), uncited from here.

**The norm.** Checked against [conventions.md](../findings/conventions.md) rather than the block's usage. The $\tfrac12$ goes at the $\Lambda^2$ level and the operator norm on $\Lambda^2$ is $\lVert W\rVert^2=\operatorname{tr}(W^2)$. Finding 4 computes $\lVert e\rVert^2=\frac{3m(m-1)}{(m+1)(2m-1)}$ under exactly that convention and recovers the block's $\theta^2$; the $\sqrt2$-inflation trap is not tripped, and the $m=2$ anchor $\theta=\sqrt{3/2}$ (rather than $\sqrt3$), settles it independently. [graded-half.md:168](../findings/graded-half.md#L168)'s $\lVert W\rVert^2_{\mathbb{CP}^m}=\frac{3m(m-1)}{4(m+1)(2m-1)}$ is the same number under the $\lvert W\rvert^2=4\lVert W\rVert_F^2$ conversion, so the two files agree. **Clean.**

---

## Verdicts

| # | defect | verdict |
| --- | --- | --- |
| 1 | ten summands against an enumeration of nine | **REPAIRED**, the count is right; the paragraph switches from the complex count to the real enumeration mid-sentence. Ten complex, seven real, nine and six at $m=3$ |
| 2 | the dimensions do not close | **REFUTED as a defect**, they close as a polynomial identity in $m$, once $V_{(2);(2)}$ and $V_{(2,1);(1)}\oplus\mathrm{conj}$ are named. The brief's $212$ at $m=4$ is exactly $84+128$ |
| 3 | the two paragraphs give different eigenvalues | **REPAIRED, against the brief's presumption.** The *Argument* is right; **the charge table's $4m$ is the error and should be $4(m+1)$**. Confirmed four ways, and the provenance identified: it is $V_{(2,1);(1)}$'s $c_S$ with $q_S^2$ never added. The same defective list stands in [second-order.md:288](../findings/second-order.md#L288) |
| 4 | $\theta^2$, the projector coefficients, the norm | **CONFIRMED**, trace-freeness and $\lVert e\rVert^2$ both recovered from the coefficients; $m=2$ gives $\sqrt{3/2}$, the record's measured value |
| 5 | $\dim(\text{orbit})=m(m-1)$, and orbit versus $E(\tfrac12)$ | **CONFIRMED**, stabiliser is $\mathfrak u(m)$ by a two-line irreducibility argument; containment plus equal dimensions gives $E(\tfrac12)=T(\text{orbit})$, which is the Morse–Bott condition. The containment step is missing from the block and is worth a line |
| 6 | $\lambda_{\max}=\frac{m+2}{2(m+1)}$, the row carrying the conclusion | **CONFIRMED**, forced by $\operatorname{tr}L_e=0$ given the other values, and measured independently at [target.md:560](../findings/target.md#L560) with the violating subspace at dimension $8=m^2-1$, naming $\mathfrak{su}(3)$ as its carrier |
| 7 | the canonical block is a lossy copy of an uncited fuller one | **CONFIRMED, structural** |
| 8 | "What is not proved" is incomplete | **CONFIRMED**, three unflagged dependencies; two of its two concessions can now be discharged |
| 9 | "where its summand's dimension vanishes" at $m=3$ | **REPAIRED**, the summand is **absent**, not zero-dimensional. [results.md:142](../results.md#L142) already says "empty" |
| 10 | $n=6$: $\theta(\mathbb{CP}^3)=\Theta_6$ against $\lambda_{\max}>\tfrac12$ | **CONFIRMED consistent.** The maximum at $n=6$ exceeds $\Theta_6$, padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$, and $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $1.0954$, because $\Theta_n$ is only the diagonal maximum. **The block never says so, and it is the one site carrying the number without the warning the rest of the record carries** |
| 11 | the slice-corrector note | **REFUTED as a threat**, outside the block, already retracted in the same file, and explained by ungauged motion along a $6$-dimensional orbit. Editorial defect: it reads as live where it stands |
| 12 | consumers | **one outside the hypotheses**, [target.md:466](../findings/target.md#L466) evaluates L28's closed form at $m=2$; cite [Lemma L10](../findings/graded-half.md) there |
| 13 | heading, and the norm | heading **kept** as statement-and-proof, **failed** as canonical; norm **CONFIRMED** |

## Overall

**CONFIRMED, with one arithmetic repair and four editorial ones. The Statement is correct as written, at every $m\ge3$.**

$$\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)},\qquad \dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)} ,$$

and Morse–Bott nondegeneracy, and non-maximality, all hold. Rebuilt here from the definitions by a route sharing nothing with the block's: the complement $\mathcal W=S^2(\Lambda^2V)\ominus S^2_0\ominus\mathbb R\ominus\Lambda^4$ decomposed by Cauchy and Littlewood–Richardson, and $\operatorname{tr}_{\mathcal W_n}L_e=0$ from $O(n)$-irreducibility. Every dimension and every eigenvalue reproduces.

**Two things the audit adds to the record.** Multiplicity-freeness is now **derived** rather than cited, for every $m\ge3$ including the $m=3$ case that the stable branching rule does not reach. And $\frac{m+2}{2(m+1)}$, the value the whole "not a maximiser" conclusion rests on, and the one row the block's three attestations do not cover, is forced by the trace identity from the rest of the list.

## The repairs, as exact text

The record is left unedited: a second reviewer works this brief independently and simultaneously, and two agents editing the same lines is worse than one reconciliation afterwards.

1. **[nondegeneracy.md](../findings/nondegeneracy.md), the charge list**, and the identical list at [second-order.md:288](../findings/second-order.md#L288). Replace "$0$, $2m$, $2(m+1)$, $4(m-1)$, $4m$, $4(m+1)$, $4(m+4)$" with "$0$, $2m$, $2(m+1)$, $4(m-1)$, $4(m+1)$, $4(m+1)$, $4(m+4)$", and "across the seven summands" with "across the seven isotypic classes, $V_{(2);(2)}$ and $V_{(2,1);(1)}\oplus\mathrm{conj}$ coinciding at $4(m+1)$".
2. **[nondegeneracy.md](../findings/nondegeneracy.md), the *Argument*'s count.** "ten summands, nine at $m=3$" becomes "ten complex summands, seven real, and nine and six at $m=3$", with the enumeration in real summands throughout, $\Lambda^2E\oplus\Lambda^2\bar E$ as one, as it already is.
3. **Both files, the $m=3$ clause.** "precisely where its summand's dimension vanishes" becomes "precisely where the branching produces no such summand", matching [results.md:142](../results.md#L142)'s "empty".
4. **[nondegeneracy.md](../findings/nondegeneracy.md), one sentence after the Statement.** That $\theta(\mathbb{CP}^3)=\theta_0(6)=\Theta_6$ exactly, that $\Theta_n$ is the diagonal maximum only, and that $n=6$ carries points above it (padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$) so "not a maximiser" at $m=3$ is consistent with the value.
5. **[nondegeneracy.md](../findings/nondegeneracy.md), a cross-link** to [second-order.md:262](../findings/second-order.md#L262), or a merge of the two blocks with the fuller text at the canonical site; and **"What is not proved"** extended by the $\mathrm{GF}(p)$ scope of the $\sharp$ closed forms and the fact that $\sharp(P_{\mathfrak u},\cdot)$ leaves $\mathcal W_n$, and shortened by dropping the multiplicity-freeness concession.
6. **[target.md:466](../findings/target.md#L466)** cites [Lemma L10](../findings/graded-half.md) for $\theta^2$ at $m=2$ in place of L28.

*No computation was run. Every number here is derived by hand from the definitions in [conventions.md](../findings/conventions.md).*
