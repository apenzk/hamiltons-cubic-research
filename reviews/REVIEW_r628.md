# Reviewer 628, Lemma L101, the $SO(n)$-invariance identity and $P\equiv0$ on $V_{1/2}$, **GAP**

**Review number: 628.** Target: [findings/route-a.md](../findings/route-a.md), the block at line 410, together with the table of suprema at lines 397–408. Reviewer B of a pair on identical briefs; derived cold from the definitions in [conventions.md](../findings/conventions.md) and [README.md](../README.md), without using the block's own reasoning. **Analysis only**, no computation was run, and where a question needs one it is named and left open.

**Verdict in one line: the three-term identity, the exact off-diagonal law and the orthogonality $Q(x)\perp T_u(SO(n)\!\cdot\!u)$ all re-derive exactly and are CONFIRMED in every dimension with no criticality; the rider $P\equiv0$ on $V_{1/2}$ is TRUE but is a GAP as stated, because it silently consumes criticality of $u$ and the reverse inclusion $V_{1/2}\subseteq T_u\mathcal O$ (the one direction the record has only numerically) while the block's adjacent sentence says the argument uses no hypothesis and never uses criticality; and the table above the block attaches "exhaustively verified" to the three suprema, which the basis argument does not license.**

The most valuable outcome here is §6: **$\sqrt{5/6}$ is a closed form, $\sqrt{5/6}=\sqrt{1-\theta^{*2}/9}$**, and the derivation reduces the whole first table row to one clean statement, $\sup_{W_1}\lVert Q(W_1)\rVert=1$ on the unit sphere of $V_{1/3}$.

---

## 0. The readings I adopt, symbol by symbol

[conventions.md](../findings/conventions.md) is incomplete for this block, so every symbol is pinned before use. Where the record offers two senses I say which I take and what pins it.

| symbol | reading adopted | what pins it |
| --- | --- | --- |
| $Q$ | $Q(W)=W^2+W^\#$ on $\mathcal W_n$ | [conventions.md](../findings/conventions.md), objects table |
| $\circ$ | $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ | [conventions.md](../findings/conventions.md), last bullet of the structure-constants section |
| $P$ | $P(W)=\langle W,Q(W)\rangle$ | [conventions.md](../findings/conventions.md) |
| $T$ | $T(x,y,z)=\langle x\circ y,z\rangle$, **totally symmetric**, normalised so $T(x,x,x)=P(x)$ | forced by [route-a.md:99](../findings/route-a.md) ($T(u,u,V)=\theta^*\langle u,V\rangle$) and [route-a.md:397](../findings/route-a.md) ($T(W_1,W_1,W_2)=\langle Q(W_1),W_2\rangle$); independently pinned by [r20](REVIEW_r20.md), which measured $\langle A\circ B,C\rangle/T(A,B,C)=1$ to $10^{-15}$ |
| $u$ | $W_{\mathbb{CP}^2}$ zero-padded into $\mathcal W_n$, unit norm, $Q(u)=\theta^*u$ | [route-a.md:182](../findings/route-a.md) |
| $\theta^*$ | $P(u)=\sqrt{3/2}$ | [route-a.md:95](../findings/route-a.md) |
| $F_u$ | $F_u(h)=\tfrac12(uh+hu)+u\#h=u\circ h$, so $F_u=\theta^*L_e$ with $e=u/\theta^*$ | [route-a.md:101](../findings/route-a.md), identified with $u\circ(\cdot)$ at [route-a.md:197](../findings/route-a.md) |
| $V_\lambda$ | the $\lambda\theta^*$-eigenspace of $F_u$, i.e. the $\lambda$-eigenspace of $L_e$; $\lambda\in\{1,\tfrac12,\tfrac13,0,-\tfrac16,-\tfrac12,-1\}$ | forced by the record's own names $V_{1/3}$, $V_{1/2}$, $V_{\le0}$ and by the spectrum at [route-a.md:175](../findings/route-a.md) |
| $V_{1/2}$ | $=\ker B$ with $B=\tfrac{\theta}2\mathrm{Id}-L_W$ at $W=u$, $\theta=\theta^*$, the record's $A(\tfrac12)$ | [conventions.md](../findings/conventions.md), $B$ row; see the check below |
| $\rho(A)$ | the derivation $\Lambda^2\mathbb R^n\to\Lambda^2\mathbb R^n$ induced by $A\in\mathfrak{so}(n)$; $A\!\cdot\!X=[\rho(A),X]$ on operators | [route-a.md:418](../findings/route-a.md); $\mathrm{ad}_A$ in [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py) |
| $\langle\cdot,\cdot\rangle$ | the pairing under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal on $\Lambda^2$ and Frobenius on operators | [conventions.md](../findings/conventions.md), norms section |
| $\mathcal O$, $T_u\mathcal O$ | $SO(n)\!\cdot\!u$ and its tangent $\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$, $\dim=4n-14$ | [route-a.md:173](../findings/route-a.md) |

**$V_{1/2}=\ker B$ checks out, and the check is worth writing because $L_W$ has no definition in the table.** [conventions.md](../findings/conventions.md) gives $B=\tfrac\theta2\mathrm{Id}-L_W$ and, in the same row, $L_WW=\theta W$ and $BW=-\tfrac\theta2W$. Those two pin $L_W=W\circ(\cdot)=F_W$ rather than $L_e$: $L_WW=Q(W)=\theta W$ and $BW=\tfrac\theta2W-\theta W=-\tfrac\theta2W$, both as printed. Hence $Bx=0\iff F_ux=\tfrac{\theta^*}2x\iff L_ex=\tfrac12x$, so $\ker B=A(\tfrac12)=V_{1/2}$ in the sense above. **The symbol $L_W$ itself is defined nowhere on the record**, [conventions.md](../findings/conventions.md) defines only $L_e$, and it is recoverable only from the two consistency lines just used. That is one more entry for the incompleteness list the brief carries.

**One live collision inside the target file.** $V_\lambda$ at [route-a.md:118](../findings/route-a.md) and in the table at [route-a.md:166](../findings/route-a.md) is the *irreducible representation space* of the $SO(n-4)$-isotypic decomposition $\mathrm{Weyl}_n=\bigoplus_\lambda M_\lambda\otimes V_\lambda$, whose dimensions grow with $n$. $V_\lambda$ at [route-a.md:418](../findings/route-a.md) is an $F_u$-eigenspace. Same letter, same file, three hundred lines apart, and the $\lambda$ ranges even overlap in appearance. It belongs in [conventions.md](../findings/conventions.md) beside the $\Pi$, $B$, $M$ and $\mathfrak m$ collisions.

---

## 1. The invariance identity, CONFIRMED, and total symmetry is load-bearing in three places

$SO(n)$ acts on $\Lambda^2\mathbb R^n$ by $\rho$ and on operators by conjugation, $g\!\cdot\!X=\rho(g)X\rho(g)^{-1}$. $P$ is invariant under this action ([route-a.md:97](../findings/route-a.md) uses exactly that), hence so is its polarization $T$. Differentiating $T(g\!\cdot\!x,g\!\cdot\!y,g\!\cdot\!z)=T(x,y,z)$ along $g=\exp(tA)$ at $t=0$, with $\tfrac{d}{dt}\big|_0\exp(tA)\!\cdot\!X=[\rho(A),X]=:A\!\cdot\!X$, gives

$$T(A\!\cdot\!x,y,z)+T(x,A\!\cdot\!y,z)+T(x,y,A\!\cdot\!z)=0 .$$

**Confirmed.** It needs invariance and trilinearity only, not symmetry, not criticality, not a dimension. Two independent structural checks that the sign convention cannot slip: all three terms carry the same sign, so a global sign error in $\rho$ leaves the identity intact; and $A\mapsto$ the identity is linear in $A$, so it holds on $\mathfrak{so}(n)$ as soon as it holds on a generating set.

**$T$ is the invariant trilinear form of this record, and its total symmetry is a theorem, not a convention.** Write $T(x,y,z)=\langle x\circ y,z\rangle$ with $x\circ y=\tfrac12(xy+yx)+x\#y$. Then

- $\langle X,\tfrac12(YZ+ZY)\rangle=\tfrac12\big(\operatorname{tr}(XYZ)+\operatorname{tr}(XZY)\big)$ is invariant under all of $S_3$: $\operatorname{tr}(XYZ)$ is cyclic-invariant and the second term is the reversal, so the sum is the full symmetrisation;
- $\langle X,Y\#Z\rangle$ is totally symmetric because $\#$ is built from the structure constants $c_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$, which are totally antisymmetric ([conventions.md](../findings/conventions.md), normalisations), so the induced trilinear form is totally symmetric.

Hence $T$ is totally symmetric and $T(x,x,x)=\langle Q(x),x\rangle=P(x)$, which is the record's normalisation.

**Where total symmetry is used, since the block never says.** Three places, all off the diagonal, and each would fail without it:

1. $T(a,b,u)=\langle a\circ b,u\rangle=\langle a,u\circ b\rangle=\langle a,F_ub\rangle$, this is the move that turns the third slot into $F_u$ and is the whole engine of §2 and §3.
2. $\langle Q(W_1),u\rangle=T(W_1,W_1,u)=\langle F_uW_1,W_1\rangle=\tfrac13\theta^*$, the block's "$\langle u\rangle$ component is forced and nonzero at $\theta^*/3$", at [route-a.md:422](../findings/route-a.md).
3. The multinomial expansion of $P(\cos\beta\,W_1+\sin\beta\,K)$ with coefficients $1,3,3,1$ in §6.

This is the same pattern the brief flags from a neighbouring audit: total symmetry inert on the diagonal, load-bearing the moment the arguments differ. **It should be stated once in the block.**

---

## 2. The specialisation, the algebra is right; the letter $\lambda$ carries two senses four lines apart

### The vanishing case, re-derived

Put $y=x$, $z=u$. The first two terms coincide by symmetry of $T$ in its first two slots, so

$$2\,T(A\!\cdot\!x,x,u)+T(x,x,[\rho(A),u])=0 .$$

By move 1 above, $T(A\!\cdot\!x,x,u)=\langle A\!\cdot\!x,F_ux\rangle$. If $F_ux=\lambda_{\mathrm{abs}}x$ this is $\lambda_{\mathrm{abs}}\langle A\!\cdot\!x,x\rangle$, and $\langle[\rho(A),x],x\rangle=\operatorname{tr}(x\rho(A)x)-\operatorname{tr}(\rho(A)x^2)=0$ by cyclicity of the trace. So

$$T(x,x,[\rho(A),u])=\langle Q(x),[\rho(A),u]\rangle=0 .$$

**Two notes on the justification the block gives.** It cites skewness of $X\mapsto[\rho(A),X]$; skewness is *sufficient* but the cyclicity argument above needs nothing about $\rho(A)$ at all, which [r20](REVIEW_r20.md) also observed. Skewness is nevertheless genuinely needed, but one step later, in the off-diagonal law, and the block uses it there without saying so.

### The off-diagonal law, derived from scratch

Take $x\in V_\lambda$, $y\in V_\mu$, so $F_ux=\lambda\theta^*x$ and $F_uy=\mu\theta^*y$. Put $z=u$ in the three-term identity:

$$T(x,y,[\rho(A),u])=-T(A\!\cdot\!x,y,u)-T(x,A\!\cdot\!y,u)=-\langle A\!\cdot\!x,F_uy\rangle-\langle F_ux,A\!\cdot\!y\rangle .$$

The first is $-\mu\theta^*\langle A\!\cdot\!x,y\rangle$. For the second, **skewness of the derivation** ($\rho(A)$ skew, $x$ symmetric) gives $\langle x,A\!\cdot\!y\rangle=-\langle A\!\cdot\!x,y\rangle$, so it is $+\lambda\theta^*\langle A\!\cdot\!x,y\rangle$. Hence

$$\boxed{\,T(x,y,[\rho(A),u])=(\lambda-\mu)\,\theta^*\,\langle A\!\cdot\!x,y\rangle\,}$$

**exactly as displayed. CONFIRMED**, with the factor $\theta^*$ correct and no constant slipped.

### The hypothesis, and where it is missing

The display at [route-a.md:418](../findings/route-a.md) **does** carry $(x\in V_\lambda,\;y\in V_\mu)$, the brief's supposition that the display omits it is not borne out. **The heading omits it**: [route-a.md:410](../findings/route-a.md) states the formula bare, and the heading is what [INDEX-results.md:116](../findings/INDEX-results.md) and any downstream quotation will carry. As written the headline formula is false for generic $x,y$, [r20](REVIEW_r20.md) measured the failure at $0.33$ for generic $x$. **The heading needs "for eigenvectors $x\in V_\lambda$, $y\in V_\mu$ of $F_u$".**

### The two senses of $\lambda$

- Line 414: "since $F_u$ is symmetric with $F_ux=\lambda x$", $\lambda$ is the **absolute** $F_u$-eigenvalue.
- Line 418: $(\lambda-\mu)\theta^*$ with $x\in V_\lambda$, $\lambda$ is the eigenvalue **in units of $\theta^*$**, i.e. of $L_e$.

Four lines apart, the same letter, and the two differ by $\theta^*=1.2247$. Neither line is wrong on its own reading and the block's conclusion is unaffected (the first display evaluates to $0$ either way), but a reader who fixes $\lambda$ from line 414 and substitutes into line 418 gets an identity too large by $\theta^*$. Given that this record already carries $\mu$ in three senses, $B$ in three, $M$ in two and $\mathfrak m$ in three, **this one is worth fixing in place**: write $F_ux=\lambda\theta^*x$ at line 414.

### The polarization warning at line 407, which is off by two in the direction it warns about

The parenthetical reads: *"The polarization $\tfrac12(Q(x+y)-Q(x-y))$ equals $2T(x,y,\cdot)$, so recovering $T$ from it needs division by four."*

Expanding, $Q(x\pm y)=Q(x)\pm2\,x\circ y+Q(y)$, so $Q(x+y)-Q(x-y)=4\,x\circ y$ and $\tfrac12\big(Q(x+y)-Q(x-y)\big)=2\,x\circ y=2\,T(x,y,\cdot)$. **The stated equality is correct.** But "recovering $T$ from **it**" (from the half-difference the sentence has just named and equated to $2T$), needs division by **two**. Division by four is right for the un-halved difference $Q(x+y)-Q(x-y)$, which the sentence does not name. Read literally the instruction returns $T/2$: a factor-two error, of exactly the class the sentence exists to prevent, in the opposite direction. The arithmetic of the second sentence is sound: $2\sqrt{5/6}=1.825742$.

**And the block does not commit the error it warns about.** The only places $\sqrt{5/6}$ and $2/3$ are consumed are the closed-form bound at [route-a.md:437](../findings/route-a.md); checking it against the multinomial expansion of $P$ at $W=\cos\beta\,W_1+\sin\beta\,K$ with $c^2=1-3\varepsilon$, $s^2=3\varepsilon$:

$$P(W)=c^3P(W_1)+3c^2s\,T(W_1,W_1,K)+3cs^2\,T(W_1,K,K)+s^3P(K),$$

term by term, $3(1-3\varepsilon)\sqrt{3\varepsilon}\cdot\sqrt{5/6}$ matches $3c^2sA$ with $A=\sqrt{5/6}$, and $2(1-3\varepsilon)^{1/2}(3\varepsilon)$ matches $3cs^2B$ with $B=2/3$ since $3\cdot\tfrac23=2$. Both constants appear **once each with the correct multinomial coefficient**. No doubling. [r20](REVIEW_r20.md) reaches the same conclusion by a different route, locating the factor-two trap in $\mathrm dQ_u=2F_u$ instead, and that is where it lives: $DQ_u(h)=2\,u\circ h$, so $F_u$ is *half* the differential.

*(Third term: the bound substitutes $\theta_0(n)$ for $P(K)$, which is Conjecture A's asserted maximum. That circularity is outside this brief and is already recorded in the file's own box at [route-a.md:493](../findings/route-a.md).)*

---

## 3. The orthogonality "in every dimension", CONFIRMED, and stronger than the block states

**Claim.** $Q(x)\perp T_u(SO(n)\!\cdot\!u)$ for every $F_u$-eigenvector $x$, in every $n$.

**Proof.** $T_u\mathcal O=\{[\rho(A),u]:A\in\mathfrak{so}(n)\}$ by definition, and $\langle Q(x),[\rho(A),u]\rangle=T(x,x,[\rho(A),u])=0$ by §2. $\square$

**CONFIRMED.** Nothing in the derivation mentions $n$, so it is dimension-free, and I find no witness against it, a witness would have to break either the $SO(n)$-invariance of $P$ or the total symmetry of $T$, both of which are structural.

### Which $u$, exactly

**Arbitrary.** The derivation uses only that $x$ is an eigenvector of $F_u$ and that $T$ is invariant and totally symmetric. It does **not** use $Q(u)=\theta^*u$, nor maximality, nor that $u$ is the $\mathbb{CP}^2$ competitor. [r20](REVIEW_r20.md) confirms this empirically at a random non-critical base point. The block's "the argument never uses criticality of $u$" is **correct for this claim**, and the statement is therefore stronger than the record realises: it holds at every base point of $\mathcal W_n$, for every eigenvector of that point's own $F$.

The one thing criticality supplies is the *label*: writing the eigenvalues as $\lambda\theta^*$ presupposes $F_uu=\theta^*u$, which is criticality. Read with absolute eigenvalues, the law is base-point-free.

### The degenerate case $\lambda=\mu$ is the content, not a vacuum

Far from being vacuous, $\lambda=\mu$ is where the theorem lives: every one of the block's conclusions is the $\lambda=\mu$ case. And it is strictly stronger than what the block states in words. The block records the diagonal $x=y$ case ("$Q(x)\perp T_u\mathcal O$"); its own display gives the **polarized** statement free:

$$x,y\in V_\lambda\ \Longrightarrow\ \Pi_{T_u\mathcal O}\big(x\circ y\big)=0,\qquad\text{i.e.}\qquad V_\lambda\circ V_\lambda\ \perp\ T_u\mathcal O\ \ \text{for every }\lambda .$$

That subspace form is what [r20](REVIEW_r20.md) wrote as $\Pi_{V_{1/2}}Q(V_\lambda)=0$ and is the form the file should carry, since it is the one that composes with anything downstream. **Owed: one line in the block promoting the conclusion from $Q(x)$ to $V_\lambda\circ V_\lambda$.**

*One caveat that costs nothing analytically but matters to any run.* The vanishing is exactly $(\lambda-\mu)=0$; it degrades linearly in an eigenvalue split. $F_u$'s spectrum is seven exact rational multiples of $\theta^*$ with large multiplicities, so analytically there is no issue, but [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py) groups eigenspaces by a $10^{-7}$ ratio tolerance, a mis-grouped pair would report a nonzero residual that is not a counterexample.

---

## 4. $P\equiv0$ on $V_{1/2}$, TRUE, but a GAP as stated

### The derivation, and the two hypotheses it consumes

Let $x\in V_{1/2}$. To reach $P(x)=\langle Q(x),x\rangle=0$ from §3 one needs $x\in T_u\mathcal O$, i.e.

$$V_{1/2}\ \subseteq\ T_u\mathcal O . \tag{$\star$}$$

Given $(\star)$: $x$ is an $F_u$-eigenvector, so $Q(x)\perp T_u\mathcal O\ni x$, so $P(x)=0$. And polarizing, $V_{1/2}\circ V_{1/2}\perp V_{1/2}$, again stronger than $P\equiv0$.

**So it is a consequence of the identity above, not a separate argument**, the block's *"a fifth, separate statement"* means fifth relative to the four vanishings the repair rests on, which is a fair use of the word; it is not separate from the identity.

**But $(\star)$ is the hard direction, and the block cites nothing for it.** The two inclusions are not on the same footing:

| direction | status |
| --- | --- |
| $T_u\mathcal O\subseteq V_{1/2}$ | **a theorem, in every $n$.** Differentiate the equivariance $Q(g\!\cdot\!W)=g\!\cdot\!Q(W)$ along $\exp(tA)$ at $W=u$: $DQ_u(A\!\cdot\!u)=A\!\cdot\!Q(u)=\theta^*(A\!\cdot\!u)$, and $DQ_u=2F_u$, so $F_u(A\!\cdot\!u)=\tfrac12\theta^*(A\!\cdot\!u)$. **This step uses $Q(u)=\theta^*u$**, i.e. criticality. Same derivation in [r487](REVIEW_r487.md), and [r20](REVIEW_r20.md) calls it "proven dimension-free" |
| $V_{1/2}\subseteq T_u\mathcal O$, which is $(\star)$ | **not proved in the block.** Available on the record two ways: numerically, $\lVert\Pi_E-\Pi_T\rVert_2\le1.4\times10^{-14}$ at $n=8,10,12,14$ and exactly over a finite field at $n=6,8,10$ ([route-a.md:24,26](../findings/route-a.md)); and, for every $n$, from the $SO(n-4)$ four-block reduction at [route-a.md:173](../findings/route-a.md), where the multiplicity spaces have dimensions $20,20,6,10$ with $n$-independent spectra and $\mathrm{mult}(\tfrac12\theta^*)=4n-14=\dim\mathcal O$ |

**The gap, precisely.** The block's sentence *"for every eigenvector $x$ of $F_u$, in every dimension, **with no hypothesis**, and the argument never uses criticality of $u$"* is followed four lines later by *"It also gives $P\equiv0$ on $V_{1/2}$"*, inside the same scope. The rider inherits neither property:

- it **uses criticality**, through the equivariance step above, at a non-critical base point $T_u\mathcal O$ need not lie in any single eigenspace of $F_u$, since $F_u(A\!\cdot\!u)=\tfrac12 A\!\cdot\!Q(u)$ and $A\!\cdot\!Q(u)$ is a multiple of $A\!\cdot\!u$ only when $Q(u)\parallel u$;
- it **is not hypothesis-free**: it needs $(\star)$.

This is inherited verbatim from [r20](REVIEW_r20.md), whose closing line puts both facts in one sentence (*"The argument never uses criticality of $u$ … and it does prove $P\equiv0$ on $V_{1/2}$"*) as two findings of the same kind. They are not of the same kind, and the block copied the pairing.

**What is owed, and it is reachable.** Either state the conclusion on the space where it is unconditional, or cite $(\star)$:

> **At every critical point $W$ of $P$ on the unit sphere, in every dimension: $P\equiv0$ on $T_W(SO(n)\!\cdot\!W)$, and indeed $\Pi_{T_W\mathcal O}\big(x\circ y\big)=0$ for every $x,y$ in a common $F_W$-eigenspace.**

That form is a theorem with the hypotheses visible, it holds at every critical point rather than at $u$ alone (the derivation never mentions $W_{\mathbb{CP}^2}$) and by $T_W\mathcal O\subseteq A(\tfrac12)=\ker B$ it says the orbit tangent is a $(4n-14)$-dimensional totally $P$-null subspace sitting inside $\ker B$. **This is a strict generalisation of the block's claim and costs one sentence.** With $(\star)$ cited from [route-a.md:173](../findings/route-a.md) it upgrades to the block's own $V_{1/2}$ form.

### What it buys, the "does not tighten" hedge holds

**Confirmed inert for the repair.** In the Remark 4.18 subdivision, $W$ is decomposed as $\cos\beta\,W_1+\sin\beta\,W_2$ with $W_1\in V_{1/3}$ and $W_2\in V_{\le0}$, both inside $(\mathbb Ru\oplus T_u\mathcal O)^\perp$ ([route-a.md:391](../findings/route-a.md)). $P$ is therefore never evaluated on any vector with a $V_{1/2}$ component, so a statement about $P|_{V_{1/2}}$ cannot enter the bound. The hedge is honest.

*(The block's own reason for inertness ("$W_2$ … has no $V_{1/2}$ component by construction"), again quietly uses $(\star)$: $W_2\perp T_u\mathcal O$ gives no $V_{1/2}$ component only if $V_{1/2}\subseteq T_u\mathcal O$. The conclusion survives regardless, because $W_2\in V_{\le0}$ excludes $V_{1/2}$ outright.)*

**What it does establish**, stated positively: a large linear subspace on which the cubic vanishes identically, at every critical point and in every dimension; in particular every unit direction in $T_W\mathcal O$ has $\theta=0$, so the orbit tangent contains no critical direction, and $L_e$'s $\tfrac12$-eigenspace, the flat directions of $\mathrm{Hess}(P|_S)$ by [Lemma L24](../findings/second-order.md), is also $P$-null. That is a structural fact about the second-order apparatus, not about this bound.

---

## 5. The block's accounting of "the four vanishings", one mis-pointer, one off-by-one

**"It proves none of the four vanishings above."** Only **three** are above. The table at [route-a.md:399–408](../findings/route-a.md) carries three near-zero rows; the fourth vanishing is $\lVert\Pi_{V_{1/3}}Q(W_2)\rVert=0$ at the $\lambda_1$-maximiser, which appears **below**, as [Observation L102](../findings/route-a.md). The four-item list lives in [plan.md](../plan.md) P0(1b) and in [ATTEMPTS.md:1616](../ATTEMPTS.md). *This is the brief's warned failure mode (a directional pointer invalidated by the file split) and it is the same word "above" that r465 and r466 had to unpick one block down.* Fix: "none of the four vanishings the repair rests on (three tabled above, the fourth at [Observation L102](../findings/route-a.md))".

**"Six explanations are now dead"** against [ATTEMPTS.md:1702](../ATTEMPTS.md)'s *"Five explanations are now dead"* and [plan.md](../plan.md)'s five as rewritten in the very same commit, `8a9f7b06`. The block splits $\mathrm{Stab}^0$-invariance out as its own row; the sibling files fold it into the $\mathbb Z_2$ bullet. Both counts are defensible readings of the same six-row table; **they should not disagree across three files written in one commit.** The report copy at [report/sections/90-appendix.tex:398](../report/sections/90-appendix.tex) says six, so the record is 2–2.

**"Three cycles were spent on it without movement", CHECKED AND TRUE.** [ATTEMPTS.md:1708](../ATTEMPTS.md) records two cycles "one short of the stop condition"; commit `8a9f7b06` is the third and its message reads *"mark P0(1b) blocked after three cycles"*, with plan.md rewritten in the same commit to *"Three cycles spent … the stop condition has fired."* The stop condition itself is [research-loop/SKILL.md:200](../.claude/skills/research-loop/SKILL.md), "three cycles without a deliverable". **The self-historical claim is supported**, one of the minority that survives this check.

**Which of the containment's five components the identity supplies.** The containment $Q(V_{1/3})\subseteq\ker F_u\oplus\langle u\rangle$ needs the components in $V_{1/2},V_{1/3},V_{-1/6},V_{-1/2},V_{-1}$ to vanish. L101 kills exactly the $V_{1/2}$ one; table row 4 ($P$ on $V_{1/3}$) kills the $V_{1/3}$ one; table row 2 ($T(W_1,W_1',N)$, every negative eigenspace) kills the remaining three. **So the block's "a single column … whereas five components must vanish" is exactly right, and L101 is a proved sibling of the measured rows rather than a consequence of them.** Worth recording that way: the containment is *one theorem plus two measurements*, not four measurements.

**"Reaching $0.91$ off it", unsupported as written, and I cannot decide it.** The cited script [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py) computes only the diagonal quantity $\lVert\Pi_{\mathcal O}Q(x)\rVert/\lVert Q(x)\rVert$ over eigenspaces; it never evaluates the off-diagonal law. The number's provenance is [r20](REVIEW_r20.md), which states it with no normalisation for $A$, no dimension, and no script. It is within rounding of $\sqrt{5/6}=0.912871$, which sits twelve lines above it in the same file under an unrelated meaning, so a transcription cannot be excluded. **Deciding it needs computation, which this brief does not authorise.** The run: evaluate $\max\{T(x,y,[\rho(A),u])\}$ over unit $x\in V_\lambda$, $y\in V_\mu$, $\lambda\ne\mu$, with $\lVert[\rho(A),u]\rVert=1$, at $n=8,10$. If it returns $\sqrt{5/6}$ the number is a coincidence to be stated as such and the normalisation written down; if it returns anything else, the block carries a stray constant; if it returns a value depending on $n$, the sentence is dimension-dependent and should say so. Either way the number needs its normalisation printed beside it, since as stated it is not a well-posed quantity.

---

## 6. The table of suprema, $\sqrt{5/6}$ IS a closed form

### The derivation

All three suprema are, by total symmetry alone, norms of projections of $Q$:

$$\sup T(W_1,W_1,K)=\sup_{W_1}\lVert\Pi_{\ker F_u}Q(W_1)\rVert,\quad \sup T(W_1,K,K)=\sup_K\lVert\Pi_{V_{1/3}}Q(K)\rVert,\quad \sup T(W_1,N,N)=\sup_N\lVert\Pi_{V_{1/3}}Q(N)\rVert .$$

Take the first. For unit $W_1\in V_{1/3}$ two components of $Q(W_1)$ are known **exactly and analytically**:

- $\langle Q(W_1),u\rangle=T(W_1,W_1,u)=\langle F_uW_1,W_1\rangle=\tfrac13\theta^*$, total symmetry, §1 move 2;
- $\Pi_{V_{1/2}}Q(W_1)=0$, **Lemma L101 itself**, §3.

The containment $Q(V_{1/3})\subseteq\ker F_u\oplus\langle u\rangle$ (table rows 2 and 4, plus L101) says these are the only two components outside $\ker F_u$. Pythagoras then gives, for every unit $W_1\in V_{1/3}$,

$$\lVert\Pi_{\ker F_u}Q(W_1)\rVert^2=\lVert Q(W_1)\rVert^2-\frac{\theta^{*2}}9=\lVert Q(W_1)\rVert^2-\frac16 .$$

Therefore

$$\boxed{\ \sup T(W_1,W_1,K)=\sqrt{\ \sup_{\lVert W_1\rVert=1,\,W_1\in V_{1/3}}\lVert Q(W_1)\rVert^2-\tfrac16\ }\ }$$

and the recorded $\sqrt{5/6}$ says exactly one thing:

$$\sup_{W_1\in V_{1/3},\ \lVert W_1\rVert=1}\lVert Q(W_1)\rVert\;=\;1\;=\;\lVert W_1\rVert^2 .$$

**Check: $1-\theta^{*2}/9=1-\tfrac16=\tfrac56$, and $\sqrt{5/6}=0.9128709$, matching the table's $0.912871$ to every printed digit.** The agreement to $6.7\times10^{-16}$ the table already reports is then not a numerical coincidence but the statement that $Q$ is norm-preserving on the unit sphere of $V_{1/3}$.

**What this converts.** A measured supremum over a $78$-dimensional sphere becomes a closed form $\sqrt{1-\theta^{*2}/9}$ resting on one clean statement, $\lVert Q\rVert=1$ on the unit sphere of $V_{1/3}$, a *quartic* identity, checkable on a basis by polarization exactly as the vanishings are, and one whose $n$-independence is testable in the four-block picture. **It also explains why $\sqrt{5/6}$ is $n$-independent**, which the table asserts and never accounts for. The residual obligation is honest: the derivation is conditional on the containment, which is measured, and on $\sup\lVert Q\rVert=1$, which is what the table's own number asserts. It is nonetheless a strictly better statement of the same fact, and it is the natural target for a seventh attempt alongside the bilinear identity the block names.

**The other two.** The same move reduces them to $\sup\lVert\Pi_{V_{1/3}}Q(\cdot)\rVert$ on $\ker F_u$ and on the strictly negative part, and L101 removes the $V_{1/2}$ component from both, and $\langle Q(K),u\rangle=\langle F_uK,K\rangle=0$ removes the $\langle u\rangle$ component from the second. I do not reach closed forms for $2/3$ and $\sqrt{2/3}$ without the containment analogues, which are not on the record. Two arithmetic relations worth recording as leads rather than results: $\sqrt{2/3}=\tfrac23\theta^*=2\langle Q(W_1),u\rangle$, and $\big(\sqrt{2/3}\big)^2=2/3$ is the third constant exactly. **Deciding whether those are structure or coincidence needs computation and is not authorised here.**

### The near-zero rows: a vanishing is a theorem or it is nothing

**None of the three follows from the invariance identity**, and the block is right to say so. The identity reaches $T(x,y,z)$ only when $z\in T_u\mathcal O=V_{1/2}$; the third slots in the table are $N\in V_{<0}$, $K\in V_0$ and $W_1''\in V_{1/3}$. The identity's column and the table's rows are disjoint. **They are not corollaries and the table does not become one.**

**But their status is better than "measurement" and the table hides it.** A trilinear form vanishing on all triples of a basis vanishes identically, so an exhaustive basis sweep at fixed $n$ is a machine-checked *theorem at that $n$*, [r465](REVIEW_r465.md) makes this point and it is correct. Three near-zero rows at $n=10$ are therefore theorems at $n=10$, and what is missing is only the $n$-uniformity.

**The inversion.** [route-a.md:397](../findings/route-a.md) attaches the exhaustiveness to the wrong half of its own table: *"**Three constants** are exhaustively verified at $n=10$ by building the full $770\times770$ matrix of $F_{W_1}$ for **all 78** basis vectors of $V_{1/3}$."* The three constants are the three **suprema**, and a supremum of a trilinear form over a $78$-dimensional sphere is **not** determined by its values at $78$ basis vectors, the basis argument that licenses the vanishings gives nothing here. As stated, the three suprema are sampled at $78$ points, hence lower bounds, not exhaustive values. *Unless* $\lVert Q\rVert$ is constant on the unit sphere of $V_{1/3}$, which is precisely §6's statement, in which case the first row genuinely is determined by a single evaluation and the sentence becomes true for that row. **The claim and its own justification therefore stand or fall with the closed form, and neither is currently written down.** r465 and r466 both audited this table and neither separated the suprema from the vanishings on this point.

**Formatting, since it affects what a reader sees.** The parenthetical at [route-a.md:407](../findings/route-a.md) is inserted between table rows, terminating the table at line 405 and orphaning `| $\sup T(W_1,N,N)$ | $\sqrt{2/3}=0.816497$ |` at line 408, which renders as literal text or a stray one-row table. Move the parenthetical below line 408.

---

## 7. Pointers and provenance

| item | resolves? |
| --- | --- |
| [p0_invariance_vanishing.py](../scripts/pipelines/p0_invariance_vanishing.py) | **yes**, exists, and its docstring is the block's prose almost verbatim. It verifies the diagonal vanishing only |
| the block's own links | **there are none.** No script, no reviewer, no source is cited anywhere in the L101 block; the provenance chain to [r20](REVIEW_r20.md) is recoverable only by phrase grep |
| [INDEX-results.md:116](../findings/INDEX-results.md) | resolves; records "Gate 2: no verdict on the record" for L101, which is accurate, [r20](REVIEW_r20.md) is a Gate 2 on the *original* claim and its verdict is on the consequence, not the identity |
| "three cycles", "six explanations" | checked against `git log`/`git show`, three cycles **true**; six **disagrees with two sibling files written in the same commit** (§5) |
| "reaching $0.91$" | traced to [r20](REVIEW_r20.md); **no run supports it** and the cited script does not compute it (§5) |
| the four vanishings "above" | **mis-points**, three above, one below (§5) |
| $M_{W_1}$, $L_W$, $V_\lambda$ | $M_{W_1}$ undefined (already flagged by r465); $L_W$ undefined; $V_\lambda$ collides with the isotypic irrep in the same file (§0) |

---

## 8. What is owed, in the order I would fix it

1. **Restate the rider with its hypotheses**, in the general form: *$P\equiv0$ on $T_W\mathcal O$ at every critical point in every dimension*, with $T_W\mathcal O\subseteq\ker B$ proved from equivariance plus criticality, and $(\star)$ cited to [route-a.md:173](../findings/route-a.md) where the $V_{1/2}$ form is wanted. Strictly stronger than what is there; one paragraph. **Reachable now, no computation.**
2. **Promote the conclusion from $Q(x)$ to $V_\lambda\circ V_\lambda\perp T_u\mathcal O$**, the polarized form is already in the block's own display and is the form that composes. **One line.**
3. **Record the closed form $\sqrt{5/6}=\sqrt{1-\theta^{*2}/9}$** and the statement it is equivalent to, $\lVert Q\rVert\equiv1$ on the unit sphere of $V_{1/3}$, with the conditionality on the containment stated. **§6, no computation.**
4. **Fix the three local defects**: $\lambda$'s two senses at lines 414/418; "division by four" at line 407; the table split at 407–408.
5. **Repair the pointers**: "the four vanishings above" → three above and [Observation L102](../findings/route-a.md) below; add the missing hypothesis to the heading at line 410; reconcile five-versus-six across [ATTEMPTS.md](../ATTEMPTS.md), [plan.md](../plan.md) and [report/sections/90-appendix.tex](../report/sections/90-appendix.tex).
6. **Split "exhaustively verified"** in the sentence at line 397: exhaustive for the three vanishings by multilinearity, sampled at $78$ points for the three suprema, unless item 3 lands, which makes the first row exhaustive after all.
7. **Blocked on computation, named**: the normalisation and value of "$0.91$" (§5), and whether $2/3$ and $\sqrt{2/3}$ have closed forms of the §6 shape (§6).

**Nothing here refutes the lemma.** The identity, the exact law and the orthogonality are theorems as stated, dimension-free and base-point-free, and they re-derived from the definitions without reference to the block. The gap is entirely in the rider's advertised hypotheses and in the table's account of its own evidence.
