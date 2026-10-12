# Reviewer 937: Lemma L219, the reflection split

Log: [agent_logs/review-r937.log](../agent_logs/review-r937.log)

| # | Claim | Verdict | Reason |
|---|---|---|---|
| 1 | Every $g\in O(n)$ acts on $\mathcal W_n$ by an isometric algebra automorphism, $\sigma_u^2=1$ | CONFIRMED | $\#$ is built from the bracket and the metric alone, and $\mathrm{Ad}_g$ preserves both at either determinant |
| 2 | The split $P(W)=P(b)+3\langle L_bc,c\rangle$, $P(c)=0$, $\langle b\circ b,c\rangle=0$ | CONFIRMED | six terms, three parity-odd, the rest joined by total symmetry, at every $W$ with criticality unused |
| 3 | The critical equations and both pairings | CONFIRMED | $Q$ maps $\mathcal W_n$ into itself, so the two equations hold in $\mathcal W_n$ with no projection, and in the projected reading as well |
| 4 | Diagonality iff every $\sigma_{e_k}$-odd part vanishes | CONFIRMED | the reflections generate the full sign group, whose fixed space is $\mathcal D_n$, and $n-1$ odd parts already suffice since $-I$ acts trivially |
| 5 | The block description for $u=e_n$ | CONFIRMED | $\sigma_{e_n}$ acts on $\chi_S$ by $-1$ exactly when $n\in S$, the subscripts being character sets, and a direct count agrees |
| 6 | H3 on the plane $\{b,c\}$ is an identity | CONFIRMED | it reduces to $\theta\ge0$ with slack $\tfrac\theta2s^4$, but the plane's global condition forces $s^2\le\tfrac34$, so "forces nothing" holds for H3 alone |
| 7 | Scope and priority on the record | CONFIRMED | no unstated hypothesis, but "$n$ applications" is $n-1$, the inductive sentence needs "some $u$ orthogonal", and the parity mechanism is L123's and L214's |

**Record L219 as Gate 2 CONFIRMED with five edits: cite L123 and L214 for the parity mechanism, write $n-1$ applications with some unit $u$ orthogonal to the frame part, restrict "forces nothing" to H3 and add $s^2\le\tfrac34$ at a global maximiser, label the blocks by character, and drop $\pi_{\mathcal W}$ from the Gate 1 line or name the screen's product.**

## 1. The automorphism

The claim is the preamble of the proof: $O(n)$ acts on $\mathcal W_n$ by isometric algebra automorphisms, $\sigma_u^2=1$, and the parity facts that follow.

1. **The action on $\Lambda^2$.** $g\in O(n)$ acts by $\Lambda^2g$, $x\wedge y\mapsto gx\wedge gy$, which is orthogonal for the induced inner product and is $\mathrm{Ad}_g$ on $\mathfrak{so}(n)$. The identity $g[X,Y]g^{\mathsf T}=[gXg^{\mathsf T},gYg^{\mathsf T}]$ uses only $g^{\mathsf T}=g^{-1}$, so it holds at determinant $-1$ exactly as at $+1$. On operators the action is $g\cdot W=(\Lambda^2g)W(\Lambda^2g)^{\mathsf T}$.
2. **It preserves $\mathcal W_n$.** First Bianchi is the kernel of the $GL(n)$-equivariant map to $\Lambda^4$, and the Ricci contraction uses the metric alone, so both are $O(n)$-equivariant and their common kernel is $O(n)$-stable.
3. **It commutes with $Q$.** $(g\cdot W)^2=g\cdot W^2$ is conjugation. For $\#$, [findings/conventions.md](../findings/conventions.md) fixes $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ with $c$ the structure constants of $\mathfrak{so}(n)$ in the orthonormal basis $\varphi_{ij}$. The tensor $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$ is invariant under every orthogonal Lie algebra automorphism, $\mathrm{Ad}_g$ at determinant $-1$ included, and $W^\#$ is a contraction of $c\otimes c\otimes W\otimes W$, so $(g\cdot W)^\#=g\cdot W^\#$. The volume form and the Hodge star, the only objects on which a reflection acts by a sign, appear nowhere in $Q$.
4. **Hence $\circ$, $P$ and $L$ are equivariant**, $\circ$ being the polarisation of $Q$, and the trace inner product is invariant. So $\sigma(x\circ y)=\sigma x\circ\sigma y$ and $\langle\sigma x,\sigma y\rangle=\langle x,y\rangle$ follow from the hypotheses.
5. **$\sigma_u^2=1$ on $\mathcal W_n$**, since $\Lambda^2(\sigma_u^2)=\Lambda^2(I)=I$. *Worth recording for item 4*: $-I\in O(n)$ acts trivially on $\Lambda^2$, so $\sigma_u$ and $-\sigma_u$ act identically on $\mathcal W_n$.
6. **The parity consequences.** $\langle b,c\rangle=\langle\sigma b,\sigma c\rangle=-\langle b,c\rangle$ gives orthogonality. $\sigma(b\circ b)=\sigma b\circ\sigma b=b\circ b$, $\sigma(c\circ c)=(-c)\circ(-c)=c\circ c$ and $\sigma(b\circ c)=b\circ(-c)=-b\circ c$ use bilinearity and the automorphism property. Each follows from the line above.

**One step is used and left implicit**: the split exists and is unique. It does, as $b=\tfrac12(W+\sigma W)$ and $c=\tfrac12(W-\sigma W)$, both in $\mathcal W_n$ by step 2, with uniqueness from $\sigma^2=1$. The statement's "split $W$ as" presupposes this and the proof never says it. A clause suffices.

## 2. The split

1. **The expansion.** $\langle(b+c)\circ(b+c),b+c\rangle=\langle b\circ b,b\rangle+\langle b\circ b,c\rangle+2\langle b\circ c,b\rangle+2\langle b\circ c,c\rangle+\langle c\circ c,b\rangle+\langle c\circ c,c\rangle$, six terms, by bilinearity and symmetry of $\circ$. $P(W)=\langle W\circ W,W\rangle$ agrees with the record's $P(W)=\langle W,Q(W)\rangle$ because $W\circ W=\tfrac12(Q(2W)-2Q(W))=Q(W)$. Follows.
2. **The three vanishing terms.** $b\circ b$ is even and $c$ odd, $b\circ c$ is odd and $b$ even, $c\circ c$ is even and $c$ odd, and even and odd vectors are orthogonal by item 1. So $\langle b\circ b,c\rangle=\langle b\circ c,b\rangle=P(c)=0$. Follows. *A one-line direct proof of $P(c)=0$ also exists*: $P(c)=P(\sigma c)=P(-c)=-P(c)$.
3. **The survivors.** $\langle c\circ c,b\rangle=T(c,c,b)=T(b,c,c)=\langle b\circ c,c\rangle$ by total symmetry of $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, which [findings/conventions.md](../findings/conventions.md) tables with its reason (the symmetrised trace for $W^2$, two antisymmetric $c$ tensors for $\#$). So the survivors sum to $P(b)+3\langle b\circ c,c\rangle$, which is $P(b)+3\langle L_bc,c\rangle$ with $L_b=b\circ(\cdot)$. Follows.

**The first display holds at every $W\in\mathcal W_n$, criticality unused.** The title's "the odd part of a critical point has zero cubic" is narrower than what the proof shows, which is harmless. The kernel's `reflection_split` checks exactly this algebra over an abstract symmetric trilinear form invariant under $\sigma$, and items 1 and 2 above supply its two hypotheses (invariance of $T$ and the parity of $b$ and $c$) for the record's $T$.

## 3. The critical equations

**The convention first, since the brief asks which product $\circ$ is.** [findings/conventions.md](../findings/conventions.md) tables $Q$ as $W^2+W^\#$ "sending $\mathcal W_n$ to itself", and [findings/problem.md](../findings/problem.md) uses that $\Phi(W)$ is again Weyl. This is Böhm and Wilking's invariance of algebraic curvature operators under $R^2+R^\#$ together with the Ricci contraction of Hamilton's reaction term being linear in $\mathrm{Ric}(R)$, so zero at $\mathrm{Ric}=0$. A hand check at $n=4$ pins the normalisation: on $\Lambda^2_+$, with $W=\operatorname{diag}(A,0)$ and $A$ traceless, $\#$ acts as $\kappa\operatorname{adj}$, and $\mathrm{id}^\#=(n-2)\mathrm{id}=2\,\mathrm{id}$ forces $\kappa=2$. Then $\operatorname{tr}(A^2+\kappa\operatorname{adj}A)=\lvert A\rvert^2+\kappa e_2(A)=(1-\tfrac\kappa2)\lvert A\rvert^2$, which is zero exactly at the record's $\kappa=2$, so $Q(W)$ stays traceless and Weyl, and a mis-scaled $\#$ leaks out of $\mathcal W_4$. Consequently $b\circ c=\tfrac12(Q(b+c)-Q(b)-Q(c))$ lies in $\mathcal W_n$ whenever $b,c$ do, and **in the record's convention $\circ$ is a product on $\mathcal W_n$ with no projection**.

1. **$Q(W)=b\circ b+c\circ c+2\,b\circ c$.** Bilinearity and symmetry of $\circ$. Follows.
2. **Even part $b\circ b+c\circ c$, odd part $2\,b\circ c$.** Item 1, step 6. Follows.
3. **$Q(W)=\theta W$ splits into $b\circ b+c\circ c=\theta b$ and $2\,b\circ c=\theta c$.** Apply the projectors $\tfrac12(1\pm\sigma)$, which are well defined by $\sigma^2=1$, to both sides, with $\theta W$ having even part $\theta b$ and odd part $\theta c$. Follows, as equations in $\mathcal W_n$.
4. **Pairing the odd equation with $c$** gives $2\langle b\circ c,c\rangle=\theta\lVert c\rVert^2$, which is $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$. Follows.
5. **Pairing the even equation with $b$** gives $P(b)+\langle c\circ c,b\rangle=\theta\lVert b\rVert^2$, and $\langle c\circ c,b\rangle=\langle b\circ c,c\rangle$ is the total symmetry named in step 1 of the proof. Substituting step 4 gives $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$. Follows.
6. **Consistency.** $P(b)+3\langle L_bc,c\rangle=\theta(\lVert b\rVert^2+\lVert c\rVert^2)=\theta\lVert W\rVert^2$, which is the Euler identity $P(W)=\theta\lVert W\rVert^2$, so the four scalar results agree with each other.

**The projected reading gives the same lemma.** If $\circ$ were an ambient product and criticality read $\pi_{\mathcal W}Q(W)=\theta W$, the projection onto the $O(n)$-stable subspace $\mathcal W_n$ is equivariant for an invariant inner product, so it preserves parity, the two equations become $\pi_{\mathcal W}(b\circ b+c\circ c)=\theta b$ and $\pi_{\mathcal W}(2\,b\circ c)=\theta c$, and the pairings with $b,c\in\mathcal W_n$ are unchanged. The lemma holds in both readings and the two coincide on $\mathcal W_n$.

**The title's eigenvector clause.** $2\,b\circ c=\theta c$ is $L_bc=\tfrac\theta2c$, an eigenvector whenever $c\ne0$. And $b\ne0$ whenever $\theta\ne0$, since $b=0$ gives $\theta\lVert W\rVert^2=P(c)=0$.

**The Gate 1 line is inconsistent with the record's convention, and it is a screen, so the lemma does not rest on it.** It writes $\pi_{\mathcal W}(2b\circ c)=\theta c$, and the [sweep](2026-09-14b-LIT-step8-sweep.md) batch 3 says the projection "is needed, the ambient product leaving $\mathcal W_n$", with a residual of $0.4$ before projecting. Under the record's $Q$ that component is zero exactly, so the screen's product was some other map (the $n=4$ check above shows a $\#$ off the record's scale leaks), or its $b,c$ lay outside $\mathcal W_n$. Every identity in L219 holds for every $O(n)$-equivariant totally symmetric product, so such a screen still passes and cannot tell the two apart. The script is linked from neither the brief nor the block, so which of the two it was stays unread here. **The record should drop $\pi_{\mathcal W}$ from the Gate 1 line or name the product the screen used.** Separately, "the split to $5\times10^{-6}$" describes the screen's comparison of $P(b)+3\langle L_bc,c\rangle$ with the ascent's $\theta$, which mixes an identity exact at every $W$ with the ascent's criticality residual. The split itself is exact.

## 4. Diagonality

1. **The reflections generate $\Gamma$.** $\sigma_{e_k}$ is $\operatorname{diag}(1,\dots,1,-1,1,\dots,1)$ with $-1$ in slot $k$, and $\operatorname{diag}(\varepsilon)=\prod_{k:\varepsilon_k=-1}\sigma_{e_k}$. So the generated group is the full $\Gamma\cong(\mathbb Z/2)^n$, which contains elements of determinant $-1$ at every $n$. L120's box warns about $\Gamma\cap SO(n)$, and the generated group strictly contains it. Follows.
2. **The determinant at either parity.** $\Gamma$ acts on $\mathcal W_n$ through $\Gamma/\{\pm I\}$. At odd $n$, $-I\notin SO(n)$ and $\Gamma=(\Gamma\cap SO(n))\times\{\pm I\}$, so even the determinant-one subgroup has the full image on $\mathcal W_n$, which is why L120's fusions occur only at even $n$. At even $n$ the reflections generate all of $\Gamma$ in any case. Neither parity needs separate treatment.
3. **$\mathcal D_n$ is exactly the $\Gamma$-fixed subspace (Given 1).** The entry $\langle W\varphi_{ij},\varphi_{kl}\rangle$ transforms by $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l=\chi_S(\varepsilon)$ with $S=\{i,j\}\triangle\{k,l\}$, and on the full group $\chi_S$ is trivial exactly when $S=\varnothing$, that is $\{i,j\}=\{k,l\}$. A fixed $W$ is therefore zero off the pair diagonal, and every pair-diagonal $W$ is fixed. The Weyl conditions are $\Gamma$-stable, so the fixed subspace of $\mathcal W_n$ is $\mathcal D_n$. Given 1's sentence holds as quoted. Follows.
4. **Fixed by $\Gamma$ iff fixed by each generator**, and the $\sigma_{e_k}$-odd part $\tfrac12(W-\sigma_{e_k}W)$ vanishes exactly when $\sigma_{e_k}W=W$. Follows.

**A redundancy that the statement and What it gives both carry.** $\sigma_{e_1}\cdots\sigma_{e_n}=-I$ acts trivially on $\mathcal W_n$, so $\sigma_{e_n}W=\sigma_{e_1}\cdots\sigma_{e_{n-1}}W$ and the first $n-1$ conditions imply the last. The equivalence is true as written, and $n-1$ vanishing odd parts already suffice. This carries into item 7.

## 5. The block description

1. $\sigma_{e_n}\in\Gamma$ acts on the $\chi_S$-isotypic summand by the scalar $\chi_S(\sigma_{e_n})$, which is $-1$ exactly when $n\in S$.
2. By L120's proof, $\mathcal D_n$ carries $S=\varnothing$, the pair block $V_{jk}$ (spanned before its Ricci cut by $\varphi_{ij}\odot\varphi_{ik}$, $i\notin\{j,k\}$) carries $S=\{j,k\}$, and the four-set block $V_Q$ carries $S=Q$.
3. $\mathcal W_n$ is the orthogonal sum of these summands, so the $+1$ eigenspace is $\mathcal D_n\oplus\bigoplus_{j,k<n}V_{jk}\oplus\bigoplus_{n\notin Q}V_Q$ and the $-1$ eigenspace is $\bigoplus_{j<n}V_{jn}\oplus\bigoplus_{n\in Q}V_Q$, as the block says. Follows.

**A reading hazard, which one phrase removes.** The subscripts are character sets, which differ from index supports. $V_{jk}$ with $j,k<n$ contains $\varphi_{nj}\odot\varphi_{nk}$, which carries the index $n$ twice and is even. A reader sorting basis tensors by whether they contain $n$ misfiles it. **The block should say "indexed by character".**

**A count by a second route agrees**, and like L120's own dimension identity it is transcription insurance. By blocks the odd part has dimension $(n-1)(n-3)+2\binom{n-1}3=\tfrac13(n+1)(n-1)(n-3)$. Directly, the odd components are those carrying $n$ exactly once, $R_{nijk}$ with $i,j,k<n$ and $jk$ antisymmetric, $(n-1)\binom{n-1}2$ of them, cut by one Bianchi relation per $3$-subset of $[n-1]$ and by the $n-1$ Ricci conditions $\mathrm{Ric}_{nk}=0$, every other Weyl condition involving even components only. That gives $(n-1)\binom{n-1}2-\binom{n-1}3-(n-1)=\tfrac13(n+1)(n-1)(n-3)$. At $n=4$ it is $5=\tfrac12\dim\mathcal W_4$, as it must be for a reflection exchanging $\mathcal W_+$ and $\mathcal W_-$.

## 6. H3 on the plane $\{b,c\}$

Take $W$ a unit critical point with $\theta>0$, $s^2=\lVert c\rVert^2\in(0,1)$ and $t=1-s^2=\lVert b\rVert^2$. H3 is $L_W\le\tfrac\theta2$ on $W^\perp$, L24 in $L_W$ units as L214 quotes it.

1. **The test direction.** The plane meets $W^\perp$ in the line of $X=s^2b-t\,c$, since $\langle X,W\rangle=s^2t-ts^2=0$, and $\lVert X\rVert^2=s^4t+t^2s^2=s^2t$.
2. **The form.** $W\circ X=s^2\,b\circ b+(s^2-t)\,b\circ c-t\,c\circ c$. Pairing with $X$ and dropping $\langle b\circ b,c\rangle=\langle b\circ c,b\rangle=P(c)=0$ leaves $\langle L_WX,X\rangle=s^4P(b)-t(3s^2-1)\,a$ with $a=\langle L_bc,c\rangle$.
3. **The relations.** $P(b)=\tfrac\theta2(2-3s^2)$ and $a=\tfrac\theta2s^2$ give $\langle L_WX,X\rangle=\tfrac\theta2s^2(1-2s^2)$.
4. **The inequality.** $\tfrac\theta2s^2(1-2s^2)\le\tfrac\theta2s^2(1-s^2)$ is $-\tfrac\theta2s^4\le0$, which is $\theta\ge0$.

**So the H3 inequality on the plane holds at every critical point with $\theta\ge0$, with slack $\tfrac\theta2s^4$.** "Identity" is right in the sense "holds identically" and would be wrong read as an equality, since the slack is positive whenever $c\ne0$. The sweep's "$s^4\le s^2$" is another tautology in an unstated normalisation. **For the second-order condition the claim is CONFIRMED.**

**The reason given proves too much, and the global condition on the same plane carries information.** On the unit circle of the plane, with $\hat b=b/\sqrt t$, $\hat c=c/s$ and $x^2+y^2=1$, the relations give
$$P(x\hat b+y\hat c)=x^3P(\hat b)+3xy^2\langle L_{\hat b}\hat c,\hat c\rangle=\frac{\theta}{2t^{3/2}}\,x\,(3t-x^2).$$
On $(-1,1)$ its critical points are $x=\pm\sqrt t$, and $x=\sqrt t$ is $W$ at value $\theta$. The endpoint $x=-1$ is the point $-\hat b$, at value $\theta(1-3t)/(2t^{3/2})$. At a global maximiser $P\le\theta$ on the whole unit sphere, so $1-3t\le2t^{3/2}$, that is $(\sqrt t+1)^2(2\sqrt t-1)\ge0$, that is $t\ge\tfrac14$:
$$\lVert c_u\rVert^2\le\tfrac34\lVert W\rVert^2\qquad\text{for every unit }u,\text{ at every global maximiser},$$
with equality exactly when $-\hat b$ is itself a maximiser. This is $\lvert P(b)\rvert\le\theta\lVert b\rVert^3$ read through $P(b)=\theta(1-\tfrac32s^2)$, so it is elementary and far from the $c=0$ that [I102](../plan.md) needs. It still shows that "the two relations determine $P$ there, so the lemma alone forces nothing" holds for H3 and fails for H1. **The sentence should read "H3 on the plane is automatic, with slack $\tfrac\theta2s^4$", and the plane's global condition gives $s^2\le\tfrac34$.**

## 7. Scope and priority

**Hypotheses.** Every hypothesis the proof uses is stated. $n\ge4$ is implicit, $\mathcal W_n$ being zero below it. Unit norm goes unused: every formula is homogeneous of matching degree and holds for any $W$ with $Q(W)=\theta W$, while the record defines "critical point" on the unit sphere ([findings/conventions.md](../findings/conventions.md)), so the lemma is slightly wider than its wording. The Lean section takes $\langle b,c\rangle=0$ as a hypothesis, and item 1 supplies it.

**Claims beyond the proof, all in What it gives.**

1. **"$n$ applications" is $n-1$.** By item 4, evenness under $\sigma_{e_1},\dots,\sigma_{e_{n-1}}$ for orthonormal $e_i$ forces evenness under $\sigma_{e_n}$. The same count appears as "applied $n$ times" in [plan.md](../plan.md) I102.
2. **The inductive sentence needs its quantifier.** "A maximiser on the fixed subalgebra of some reflections of a frame is even under one more", read with the frame fixed in advance, is false. Take the single reflection $\sigma_{e_1}$. The maximisers of $P$ on the unit sphere of $\mathrm{Fix}(\sigma_{e_1})$ form a set stable under $O(n-1)$ acting on $e_1^\perp$, which commutes with $\sigma_{e_1}$. If every one were $\sigma_{e_2}$-even, each would be $\sigma_v$-even for every unit $v\perp e_1$ and $\sigma_{e_1}$-even, hence fixed by $O(1)\times O(n-1)$. That fixed space in $\mathcal W_n$ is zero: invariance kills $R_{1ijk}$ and forces $R_{1i1j}=s\,\delta_{ij}$ and $R_{ijkl}=r(\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk})$ for $i,j,k,l\ge2$, and then $\mathrm{Ric}_{11}=(n-1)s=0$ and $\mathrm{Ric}_{jj}=s+(n-2)r=0$ give $s=r=0$. A unit maximiser is nonzero, a contradiction. **The true form is [plan.md](../plan.md) I102's, "even under $\sigma_u$ for some unit $u$ orthogonal to that part"**, and What it gives should carry both the existential and the orthogonality.

**Priority.** A search of [findings/](../findings/) by object (a product landing in the product character, a cubic vanishing by parity, a split of a critical point along a subgroup's fixed space) finds the mechanism twice and the statement nowhere else.

- [L123](../findings/second-order.md#lemma-l123-a-zero-diagonal-operator-contributes-nothing-to-a-single-character-rayleigh-quotient) proves that $\circ$ maps the $\chi$ and $\chi'$ character spaces into the $\chi\chi'$ space and that distinct characters are orthogonal. Any unit $u$ completes to a frame with $\sigma_u=\sigma_{e_n}\in\Gamma$, and the reflection split is that mechanism on the two-class coarsening by $\chi_S(\sigma_{e_n})$, which is why every even-even-odd and odd-odd-odd pairing dies.
- [L214](../findings/second-order.md#lemma-l214-the-frame-split-two-exact-relations-in-every-frame-and-one-inequality-under-the-second-order-cap) is the same split for the whole of $\Gamma$. Its non-trivial part $N$ keeps a cubic $P(N)$ because three nontrivial characters can multiply to the trivial one. With $D\mapsto b$, $N\mapsto c$ and $P(N)\mapsto0$ its two relations become exactly L219's $\theta\lVert b\rVert^2=P(b)+a$ and $\theta\lVert c\rVert^2=2a$.
- The sweep's "grep finds nothing" searched words. **The proof should cite L123 for the parity step and L214 for the shape.** The statement itself, one reflection with $P(c)=0$ and $L_bc=\tfrac\theta2c$, is new to the record as far as this search reaches.
