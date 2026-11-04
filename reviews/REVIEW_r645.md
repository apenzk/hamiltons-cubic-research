# Review r645, Lemma L38, two families capped in closed form and strictly decreasing

**Reviewer A of an independent pair (companion takes r646). Target: [findings/ungraded-slack.md](../findings/ungraded-slack.md) line 244, `#### Lemma L38`, plus the section its provenance note names.**

**Standing rule observed: analysis only.** Everything below is derived by hand in exact arithmetic. One exact-rational screen was run over the finished formulas to catch transcription slips in my own algebra; it is reported as a screen and no positive claim rests on it.

## Verdict

**CONFIRMED on all three mathematical claims; GAP on scope and provenance.**

| claim | verdict |
| --- | --- |
| $\theta^2(\mathbb{CP}^m)=\dfrac{(m+1)(2m-1)}{3m(m-1)}$ | **CONFIRMED**, derived cold below from the Fubini–Study curvature operator, matching the record at two independent anchors |
| $\theta^2$ of $(\mathfrak{su}(m),\mathfrak{so}(m))\subset\mathfrak{so}(2m)$ $=\dfrac{m(m+1)}{(m-1)(m+2)}=\dfrac X{X-2}$ | **CONFIRMED**, reproduced from [L39](../findings/target.md)'s general symmetric-pair formula in its three-invariant reduction, with $c=2m$ derived independently |
| both strictly decreasing, maximum $\tfrac32$ at $m=2$ | **CONFIRMED**, on the range $m\ge2$, which the block does not state |
| the $m=2$ member of the second family is $W_{\mathbb{CP}^2}$ | **CONFIRMED**, and **proved on the record**, at [target.md](../findings/target.md) line 400, not in the block's own file |
| *"the mathematics has always been in this file … the argument is in this file under 'The subalgebra family'"* | **FALSE, twice over.** Neither derivation is in [ungraded-slack.md](../findings/ungraded-slack.md), and the named section derives a different family that **explicitly excludes $\mathbb{CP}^m$** |

## 0. My reading of the symbols, stated before deriving

[conventions.md](../findings/conventions.md) is treated as unreliable per the brief, so each is pinned to an anchor I can check.

| symbol | reading I use | why this one |
| --- | --- | --- |
| $\theta$ | $P(W)/\lVert W\rVert^3$ with $P(W)=\langle W,W^2+W^\#\rangle$, $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)$ over $\Lambda^2$ | the conventions table, and it is the reading under which $\theta_0(n)^2=2(n-1)(n-2)/n^2$ comes out at the balanced product |
| $P(W)$ in block coordinates | $P=\mathop{\mathrm{tr}}(W^3)+\tfrac12\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$, sum over **ordered** triples | **not assumed, calibrated in §1 below**, from the subalgebra-family theorem, two equations in one unknown |
| $S_{XYZ}$ | ordered-slot block contraction of $T$ | conventions.md's row adopted 2026-09-04; and it is the reading my §1 calibration independently forces, since the $1{:}3$ weight in [L39](../findings/target.md) is the multinomial $\binom31$ |
| $\mathfrak k$, $\mathfrak m$ | the **symmetric-pair** sense: $\mathfrak g=\mathfrak k\oplus\mathfrak m$, $[\mathfrak k,\mathfrak k]\subseteq\mathfrak k$, $[\mathfrak k,\mathfrak m]\subseteq\mathfrak m$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak k$ | forced by the block's own $p=\dim\mathfrak k=\binom m2=\dim\mathfrak{so}(m)$ and $q=\dim\mathfrak m$, $p+q=m^2-1=\dim\mathfrak{su}(m)$. **This is the third of the three senses conventions.md tables for $\mathfrak m$**, [target.md](../findings/target.md)'s odd part, and not the $E_{\min}$ sense |
| $p$, $q$ | $\dim\mathfrak k$, $\dim\mathfrak m$, as the block says |, |
| $c$ | the Killing constant of $\mathfrak g$ **in the induced $\Lambda^2\mathbb R^n$ inner product**: $\sum_{b\in\mathfrak g}\lVert[a,b]\rVert^2=c\lVert a\rVert^2$. It depends on the embedding $\rho$, not on the abstract pair | [target.md](../findings/target.md) line 355's correction, and it is the only reading under which $c(\mathfrak{so}(n),\text{standard})=2(n-2)$ |
| $\Theta_n$ | the diagonal maximum, $=\theta_0(n)$ at **even** $n$ only | conventions.md; $n=2m$ is even for every integer $m\ge2$, so the identification is legitimate here, **stated rather than assumed**, per the brief |

## 1. Calibrating the cubic form before using it

The block coordinates need one constant fixed: $P=\mathop{\mathrm{tr}}(W^3)+\beta\sum T\lambda\lambda\lambda$. I fix $\beta$ from the subalgebra-family theorem ([ungraded-slack.md](../findings/ungraded-slack.md) line 73, Gate-2 passed), which is independent of everything L38 asserts.

Take $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, $t=r/N$, $u=c(1-t)$ on $\mathfrak h$, $v=-ct$ on $\mathfrak m$, $c=\sqrt{N/(r(N-r))}$. With that theorem's $S_{\mathfrak{hmm}}=2(n-1)r(N-r)/N$ and $S_{\mathfrak{mmm}}=(N-r)[2(n-2)-4(n-1)r/N]$, and $S_{\mathfrak{hhh}}=\kappa r-S_{\mathfrak{hmm}}$ with $\kappa=2(n-2)$:

$$\mathop{\mathrm{tr}}(W^3)=c^3Nt(1-t)(1-2t),\qquad \sum T\lambda\lambda\lambda=c^3Nt(1-t)\big[(2n+2)t-2\big],$$

the second after the $t^3$ and $t^2$ coefficients cancel identically. Since $c^3Nt(1-t)=\big(Nt(1-t)\big)^{-1/2}$,

$$P=\frac{(1-2t)+\beta\big[(2n+2)t-2\big]}{\sqrt{Nt(1-t)}},\qquad \theta=\frac2n\sqrt{\frac{Nt}{1-t}}\ \Longrightarrow\ (1-2t)+\beta\big[(2n+2)t-2\big]=(n-1)t .$$

Matching in $t$ gives **two** equations for the single unknown: the constant term forces $\beta=\tfrac12$, and the linear term then reads $-2+(n+1)=n-1$, which holds. **Two conditions, one unknown, both met, this is a check, not a fit.** So

$$\boxed{\,P(W)=\mathop{\mathrm{tr}}(W^3)+\tfrac12\textstyle\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\,}$$

in the ordered reading, agreeing with [L39](../findings/target.md)'s $\theta=\mathop{\mathrm{tr}}(W^3)+\tfrac12[a^3S_{\mathfrak{kkk}}+3ab^2S_{\mathfrak{kmm}}]$.

## 2. The $\mathbb{CP}^m$ closed form, DERIVED, CONFIRMED

**The spectrum.** Fubini–Study at holomorphic sectional curvature $4$ has $R_{ijkl}=g_{ik}g_{jl}-g_{il}g_{jk}+J_{ik}J_{jl}-J_{il}J_{jk}+2J_{ij}J_{kl}$. As an operator on $\Lambda^2\mathbb R^{2m}$ this is $R=\mathrm{Id}+A+\lVert J\rVert^2\Pi_J$ with $A(\alpha)=-J\alpha J$, which is $+1$ where $\alpha$ commutes with $J$ and $-1$ where it anticommutes. So $R$ has eigenvalues $0$ on $[\Lambda^{2,0}]$ (dimension $m(m-1)$), $2$ on $\Lambda^{1,1}_0\cong\mathfrak{su}(m)$ (dimension $m^2-1$), and $2m+2$ on $\mathbb R J$. Trace $2m(m+1)$, i.e. $\mathrm{scal}=4m(m+1)$, the right value for $\mathrm{Ric}=2(m+1)g$.

$\mathbb{CP}^m$ is Einstein, so $W=R-\frac{\mathrm{scal}}{n(n-1)}\mathrm{Id}=R-\frac{2(m+1)}{2m-1}\mathrm{Id}$:

| block | dimension | eigenvalue of $W$, times $(2m-1)$ |
| --- | --- | --- |
| $\mathfrak a=[\Lambda^{2,0}]$ | $m(m-1)$ | $-2(m+1)$ |
| $\mathfrak b=\mathfrak{su}(m)$ | $m^2-1$ | $2(m-2)$ |
| $\mathfrak c=\mathbb R J$ | $1$ | $4(m^2-1)$ |

Traceless exactly. **Two independent record anchors agree**: [L58](../findings/ungraded-slack.md)'s table gives $\mathbb{CP}^3$ three eigenvalues at multiplicities $6,8,1$ ✓, and [nondegeneracy.md](../findings/nondegeneracy.md) line 540 gives $e=W/\theta$ with ratios $-\tfrac1{2m-1}:\tfrac{m-2}{(m+1)(2m-1)}:\tfrac{2(m-1)}{2m-1}$ on the same three blocks, identical to mine after dividing by $-2(m+1)$.

**The bracket masses**, from the Killing marginal $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)=4(m-1)$ alone. $(\mathfrak{so}(2m),\mathfrak u(m))$ is a symmetric pair and $J$ is central in $\mathfrak u(m)$, so the only surviving patterns are $\mathfrak{aab}$, $\mathfrak{aac}$, $\mathfrak{bbb}$. Then

$$S_{\mathfrak{aac}}=4(m-1),\qquad 2S_{\mathfrak{aab}}+2S_{\mathfrak{aac}}=4(m-1)\cdot m(m-1)\ \Rightarrow\ S_{\mathfrak{aab}}=2(m-1)(m-2)(m+1),$$
$$S_{\mathfrak{bbb}}=4(m-1)(m^2-1)-S_{\mathfrak{aab}}=2m(m^2-1).$$

The last says $\mathfrak{su}(m)\subset\mathfrak{so}(2m)$ has Killing constant $c=2m$, **independently derived, and it is the value [target.md](../findings/target.md) line 355's table gets from $c=2h^\vee/I_\rho$**. Cross-check at $m=2$: $\mathfrak b$ is one $\mathfrak{su}(2)$ factor of $\mathfrak{so}(4)$, so $S_{\mathfrak{bbb}}=4\cdot3=12=2\cdot2\cdot3$ ✓, and $S_{\mathfrak{aab}}=0$ ✓ because the two factors commute.

**Assembly.** With $\mu=1/(2m-1)$:

$$\lVert W\rVert^2=\frac{12m(m^2-1)}{2m-1},\qquad \mathop{\mathrm{tr}}(W^3)=8\mu^3m(m^2-1)(8m^3-24m+11),$$
$$\sum T\lambda\lambda\lambda=16\mu^3m(m^2-1)(4m^3+15m-8),$$
$$P=8\mu^3m(m^2-1)\big(12m^3-9m+3\big)=24\mu^3m(m^2-1)(m+1)(2m-1)^2=\frac{24m(m^2-1)(m+1)}{2m-1},$$

using $4m^3-3m+1=(m+1)(2m-1)^2$. Hence

$$\theta^2=\frac{P^2}{\lVert W\rVert^6}=\frac{576\,m^2(m^2-1)^2(m+1)^2/(2m-1)^2}{1728\,m^3(m^2-1)^3/(2m-1)^3}=\boxed{\ \frac{(m+1)(2m-1)}{3m(m-1)}\ }$$

**exactly the block's form.** Two external anchors the derivation was not fitted to: $m=2$ gives $\tfrac32$, and conventions.md records $M(4)=\sqrt{3/2}$; $m=3$ gives $\tfrac{10}9=\theta_0(6)^2$, and [L58](../findings/ungraded-slack.md)'s table records $\mathbb{CP}^3$ at exactly $\theta_0(6)$.

**Range.** The formula needs $m\ge2$. At $m=1$, $\mathbb{CP}^1=S^2$, $n=2$, and there is no Weyl tensor at all; at $m=0$ the space is a point. Both are excluded by $3m(m-1)=0$ rather than by anything the block says, **and [results.md](../results.md) line 476 does carry "$m\ge2$" for this family, so the findings block lost a hypothesis its own canonical statement keeps.**

## 3. The Kähler family, CONFIRMED, and the three-invariant check agrees

**The reduction the brief supplies is algebraically the same object as [L39](../findings/target.md).** With $S_{\mathfrak{kmm}}=cq/2$ and $S_{\mathfrak{kkk}}=c(p-q/2)$ ([r636](REVIEW_r636.md)), L39's numerator factors:

$$S_{\mathfrak{kkk}}q^2+3S_{\mathfrak{kmm}}p^2-2p^3+2pq^2=\tfrac{p+q}2\big[cq(3p-q)-4p(p-q)\big],$$

so $\theta^2=\dfrac{\big(cq(3p-q)-4p(p-q)\big)^2}{16\,p^3q(p+q)}$, **the brief's form, confirmed as a consequence rather than a separate claim.**

**A caveat on "since $p$ and $q$ are given".** $p$ and $q$ alone do **not** determine $\theta$; $c$ is a third input and it depends on the embedding $\rho$, not on the abstract pair. That is exactly [r81](REVIEW_r81.md)'s $(\mathfrak{su}(2),\mathfrak u(1))$ witness, where $(p,q)=(1,2)$ is fixed while $\theta^2$ runs $\tfrac32,\tfrac23,\tfrac{25}{54}$ over one, two and three copies of $\mathbb C^2$. **So the block's "inside $\mathfrak{so}(2m)$" is load-bearing and correctly present.** Here $c=2m$, which I derived in §2 from the Killing marginal in $\mathfrak{so}(2m)$; it agrees with target.md's table and with $S_{\mathfrak{kmm}}=cq/2=mq$, target.md's independently stated value. **Three routes to $c=2m$.**

**Evaluation.** $p=\tfrac{m(m-1)}2$, $q=\tfrac{(m-1)(m+2)}2$, $p+q=m^2-1$, and

$$3p-q=(m-1)^2,\qquad p-q=-(m-1),$$
$$cq(3p-q)-4p(p-q)=m(m+2)(m-1)^3+2m(m-1)^2=m^2(m+1)(m-1)^2,$$
$$16p^3q(p+q)=m^3(m-1)^5(m+1)(m+2)\ \Longrightarrow\ \theta^2=\frac{m^4(m+1)^2(m-1)^4}{m^3(m-1)^5(m+1)(m+2)}=\boxed{\ \frac{m(m+1)}{(m-1)(m+2)}\ }$$

**exactly the block's form**, and $=X/(X-2)$ since $X-2=m^2+m-2=(m-1)(m+2)$. A further consistency check falls out: $S_{\mathfrak{kkk}}=c(p-q/2)=\tfrac{m(m-1)(m-2)}2=(m-2)p$, which is target.md's independently stated value. ✓

**Range.** $m\ge2$: at $m=1$ both $\mathfrak{su}(1)$ and $\mathfrak{so}(1)$ are zero and $X=2$ is the pole. The block states no range, and **the record has already been bitten here**, target.md records that an earlier version "silently started the family at $m=3$ and never said why", which is precisely how the cap came out wrong.

## 4. Strictly decreasing, CONFIRMED, both, on $m\ge2$

**Kähler family.** $X=m(m+1)$ is strictly increasing on $m\ge1$ and $X/(X-2)=1+\frac2{X-2}$ is strictly decreasing in $X$ for $X>2$, i.e. for $m\ge2$. Limit $1$.

**$\mathbb{CP}^m$ family**, which needs real work. Write $f(m)=\frac{2m^2+m-1}{3m^2-3m}$. Then

$$f'(m)=\frac{(4m+1)(3m^2-3m)-(2m^2+m-1)(6m-3)}{(3m^2-3m)^2}=\frac{-9m^2+6m-3}{(3m^2-3m)^2},$$

and $-9m^2+6m-3=-3(3m^2-2m+1)$ has discriminant $4-12<0$ with negative leading coefficient, so it is **negative for every real $m$**. Hence $f'<0$ on all of $m>1$, strictly, and a fortiori at the integers $m\ge2$. Limit $\tfrac23$.

**Maxima.** Both are strictly decreasing from $m=2$, so both attain $\tfrac32$ there. **The block's "$\tfrac32$" is $\theta^2$, not $\theta$**, the display immediately above it is $\theta^2$, and $\theta=\sqrt{3/2}=1.2247$. The block never says so; [results.md](../results.md) line 476 disambiguates it by adding "so neither family exceeds $\sqrt{3/2}$ anywhere". A reader of the findings block alone can misread the record's most-cited constant.

**Where the two agree.** Setting the forms equal and cancelling $(m+1)/(m-1)>0$ gives $(2m-1)(m+2)=3m^2$, i.e. $m^2-3m+2=0$, i.e. $m\in\{1,2\}$. **So they agree at $m=2$ and nowhere else in range**, one intersection, and it is the shared point $W_{\mathbb{CP}^2}$. (A coincidence worth naming so nobody reads it as a second intersection: $\theta^2$ takes the value $\tfrac{10}9$ at $\mathbb{CP}^3$ and at the Kähler $m=4$ member, same value, different $m$, different $n$.)

## 5. What the caps are worth

**$\Theta_{2m}=\theta_0(2m)$ is legitimate here**, because $n=2m$ is even for every integer $m\ge2$; conventions.md restricts the identity to even $n$ and the restriction is met, so this is stated rather than assumed.

**$\mathbb{CP}^m$ against $\theta_0(2m)$.** Dividing both squares by $2m-1>0$ and cross-multiplying by $3m^2(m-1)>0$:

$$\theta^2(\mathbb{CP}^m)-\theta_0(2m)^2\ \propto\ m(m+1)-3(m-1)^2=-(2m-1)(m-3).$$

So $\mathbb{CP}^m$ is **above** $\theta_0$ at $m=2$, **tied** at $m=3$, and **strictly below for every $m\ge4$**. **This is exactly the companion audit's result, reached from a different starting point.** ✓

**Kähler family against $\theta_0(2m)$.** $m^3(m+1)-(2m-1)(m-1)^2(m+2)=-m^4+2m^3+6m^2-7m+2$, which is $+8$ at $m=3$ and $-58$ at $m=4$. So this family is **strictly above** $\theta_0(2m)$ at $m=2$ **and at $m=3$** (no tie) and below for $m\ge4$.

**A caution the block invites and does not give.** The $m=3$ member is $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $\theta^2=\tfrac65$, i.e. $\theta=1.0954$, sitting at $n=6$ where $\Theta_6=1.0541$. **"Capped" here does not mean "capped below the target": at $n=6$ this family contains a critical point strictly above the diagonal maximum**, consistent with conventions.md's $M(6)=\sqrt{3/2}>\Theta_6$ but flatly against a reading of L38 as a separation result at its own $n$.

**What the caps do license at $n\ge12$.** Padding preserves $\theta$, so every member persists as a witness at every larger $n$ and the supremum over the padded closure of both families is $\sqrt{3/2}$, attained at $W_{\mathbb{CP}^2}$. Since $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0\iff n\ge6+2\sqrt7=11.29$, we get: **at every $n\ge12$, no member of either family (padded or not), reaches $\Theta_n$, with strict margin.** What they do **not** license: anything at $n<12$, where padded $W_{\mathbb{CP}^2}$ is above $\Theta_n$; anything about points outside the two families, $\mathbb{HP}^m$ and the Grassmannians included; and any statement about non-two-eigenvalue symmetric pairs, since the family's own realisation as an L39 point is the two-eigenvalue ansatz only.

## 6. The $m=2$ identification, CONFIRMED, and proved elsewhere on the record

**Dimensions.** $p=\binom22=1=\dim\mathfrak{so}(2)$, $q=\binom32-1=2$, $p+q=3=\dim\mathfrak{su}(2)$, inside $\mathfrak{so}(4)$ where $N=6$, so $W$ carries a $3$-dimensional kernel. **Consistent.**

**The operator.** $ap+bq=0$ and $a^2p+b^2q=1$ give $a=2/\sqrt6$, $b=-1/\sqrt6$, so the spectrum is $(0.816497,-0.408248,-0.408248,0,0,0)$. From §2 at $m=2$, $W_{\mathbb{CP}^2}$ has eigenvalues $(4,-2,-2)$ on one chirality and $0$ on the other, with $\lVert W\rVert^2=24$, normalised, $(4,-2,-2)/\sqrt{24}=(2,-1,-1)/\sqrt6$. **The same operator.** [target.md](../findings/target.md) line 400 states the identification with exactly these eigenvalues and exhibits $\mathfrak k=\mathrm{span}\{e_{01}+e_{23}\}$ and $\mathfrak m=\mathrm{span}\{e_{02}-e_{13},e_{03}+e_{12}\}$.

**One structural point worth recording, because it looks like a contradiction and is not.** The $\mathfrak{su}(2)$ that carries $W_{\mathbb{CP}^2}$ is the chirality containing the Kähler form $J$, whereas $\Lambda^{1,1}_0\cong\mathfrak{su}(m)$ for that same $J$ is the **other** chirality. Both $\Lambda^\pm$ are copies of $\mathfrak{su}(2)$ acting on $\mathbb R^4=\mathbb C^2$ (for $\Lambda^+$ the complex structure lies in $\Lambda^-$) so both are legitimate "$\mathfrak{su}(m)$ inside $\mathfrak{so}(2m)$" embeddings, and $\mathfrak k=\mathbb R J$ is a Cartan of the one that carries $W$. The identification survives; it just is not the naive "same $J$".

**Proved or asserted?** **Proved on the record, asserted in the block.** The block gives the sentence with no argument, no eigenvalues and no $\mathfrak k$; the proof is in a different file.

## 7. Provenance, the note is FALSE, and was already half-false at birth

**Reading used:** a `####` block runs to the next heading of level $\le4$. Under that reading the named section "The subalgebra family: $\theta$ from $\dim\mathfrak h$ alone, and Conjecture A proved on it" is [ungraded-slack.md](../findings/ungraded-slack.md) lines 73–91. The wider reading (everything under the enclosing `##`), does not help: the CP$^m$ derivation is in another file either way.

**(a) The named section is about a different family, and excludes $\mathbb{CP}^m$ by name.** It derives the two-eigenvalue Casimir $W_{\mathfrak h}=c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with $\theta=\tfrac2n\sqrt{rN/(N-r)}$, and its own paragraph "What it does not reach" says: *"the unbalanced products, $\mathbb{CP}^m$, $\mathbb{HP}^m$, the complex Grassmannians and every generic ungraded point sit outside."* $\mathbb{CP}^m$ has three eigenvalues, so it cannot be a $W_{\mathfrak h}$; and L38's Kähler point has eigenvalues $a,b,0$, so it is not one either. **The pointer resolves to a section that proves neither of L38's claims and disowns one of them.**

**(b) "The mathematics has always been in this file" is false for ungraded-slack.md.** Neither closed form is derived anywhere in it. `grep` finds the $\mathbb{CP}^m$ form at line 250 and the Kähler form at line 254, **both inside the L38 block itself and nowhere else in the file.**

**(c) The git history, and the note was already half-false when written.** The block was created by `86621751` (*"number the 24 results that only the report had numbered"*, 2026-08-31 20:50), **in [graded-half.md](../findings/graded-half.md)**, where the note read "the argument is the surrounding material in this file". At that commit's parent graded-half.md **did** carry the $\mathbb{CP}^m$ form (it still does, at lines 444 and 470), **but it never carried the Kähler form**, which lived then and lives now in [target.md](../findings/target.md) (lines 347 and 391). *So the boilerplate was false for the second family from the moment it was stamped.* Commit `7ad0455d` (21:25 the same evening) then split the file and moved the block to ungraded-slack.md, **leaving both derivations behind**, and the note was rewritten to name a heading that had followed it into the new file, the wrong one.

**(d) Where the arguments actually are.**

| claim | derivation | character |
| --- | --- | --- |
| $\mathbb{CP}^m$ closed form | [algebra.md](../findings/algebra.md) line 29, from Fox's Lemma 10.1 and (10.4) | **derived**; the same file says so explicitly, *"supplies the proof of the closed form that the measurement lacked"* |
| $\mathbb{CP}^m$ closed form, in graded-half.md | lines 444 and 470 | **measured, then fitted**: *"the four rows collapse to a closed form"*, confirmed at $m=8$. A fitted-and-checked identity, not a proof |
| Kähler closed form | [target.md](../findings/target.md) line 389 | **derived symbolically in $m$**, the file saying so against an earlier pattern-matched version |
| $m=2$ identification | [target.md](../findings/target.md) line 400 | **proved**, by exhibiting the eigenvalues and the two subspaces |

**(e) Boilerplate census.** `grep -ro "the mathematics has always been in this file" findings/` returns **15** copies today, over nine files, [bispectral.md](../findings/bispectral.md) 3, [ungraded-slack.md](../findings/ungraded-slack.md) 3, [problem.md](../findings/problem.md) 2, [target.md](../findings/target.md) 2, and one each in [brauer-pairing.md](../findings/brauer-pairing.md), [diagonal-half.md](../findings/diagonal-half.md), [stratum-two-negative.md](../findings/stratum-two-negative.md), [sym3-blocks.md](../findings/sym3-blocks.md), [support-dichotomy.md](../findings/support-dichotomy.md). **The brief's figure of 17 is stale by two**, presumably from today's earlier fixes. L38's is one of the false ones.

## 8. Hedging clauses, pointers, and the broken LaTeX

| clause | verdict |
| --- | --- |
| "strictly decreasing" (first family) | **true**, and needs the derivative argument of §4, the sign of $-3(3m^2-2m+1)$ |
| "again strictly decreasing" (second) | **true**, and here "again" is fair: $X/(X-2)$ makes it one line |
| "with maximum $\tfrac32$ at $m=2$", both | **true as $\theta^2$**; the block never says it is $\theta^2$, and $\sqrt{3/2}$ is the constant the record actually quotes |
| "is $W_{\mathbb{CP}^2}$ **itself**" | **true**, up to the choice of chirality, which is an $O(4)$ conjugation and preserves $\theta$; **asserted here, proved in target.md** |
| the block's last sentence | **BROKEN LaTeX, confirmed**, at [ungraded-slack.md](../findings/ungraded-slack.md) line 258: `**The $m=2$ member of the second family is $W_{\CP^2**$ itself.}`, the `**` closes inside the subscript and the `}` lands outside the math. It has been wrong since `86621751` created the block; the same malformation is in that commit's diff. **[results.md](../results.md) line 476 renders the same sentence correctly**, so the fix is a transcription from there. |
| does the block's own file settle it? | **No**, and that is the finding. This is one of the cases where the answer was **not** in the same file: both derivations are in other files, and the section the block points at is the wrong one. |

## 9. Screen (reported as a screen)

An exact-rational evaluation of the two closed forms, $\theta_0(2m)^2$, the strict-decrease comparisons to $m=300$, the equal-value solve to $m=200$, the three-invariant formula against the claimed Kähler form to $m=60$, and my §2 spectrum-plus-$P$ assembly against the claimed $\mathbb{CP}^m$ form to $m=40$. Every comparison agreed with the derivations above. **No positive claim in this report rests on it**, each is proved in exact arithmetic in its own section; the screen exists to catch a slip in my own transcription, and caught none.

## Summary of what should change

1. **Fix the provenance note.** Point the $\mathbb{CP}^m$ form at [algebra.md](../findings/algebra.md) line 29 and the Kähler form at [target.md](../findings/target.md) line 389, and drop "the mathematics has always been in this file". The current pointer names a section that proves neither claim and explicitly excludes $\mathbb{CP}^m$.
2. **State the range $m\ge2$ for both families.** [results.md](../results.md) already carries it for the first; the record has been bitten once by a silently-started range in the second.
3. **Fix the LaTeX at line 258**, from the correct sentence at [results.md](../results.md) line 476.
4. **Say that $\tfrac32$ is $\theta^2$**, so the block does not read as a bound of $1.5$ on $\theta$.
5. **Optionally, add what §5 establishes**: the caps bite only from $m\ge4$ at their own $n$ (at $n=6$ the second family sits above $\Theta_6$) and what they license is a $\sqrt{3/2}$ ceiling on the padded closure, strictly under $\Theta_n$ for every $n\ge12$.
