# Verifier v383, L20-r2 step G6: the witness sphere product lies outside the tube, and this follows from Lemma L20's conclusion

Cold brief ([ADJ_L20r2_G6.md](ADJ_L20r2_G6.md)). No numerical work, no scripts written, every value exact. Log: [agent_logs/verify-L20-v383.log](../agent_logs/verify-L20-v383.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Lemma L20's conclusion (every maximizer has $\varphi>0.5748$) implies that the witness sphere product has $\varphi>0.5748$ | REFUTED AS STATED |
| 2 | The proof of L20, rerun at the sphere product instead of at the maximizer, yields $\varphi_S>0.5748$ | REFUTED |
| 3 | The proof of L20, rerun at the maximizer of $P$ over the closed tube, yields $\max_{\text{tube}}P\le\theta^*$ | REFUTED AS STATED |
| 4 | For every $n\ge12$ the witness sphere product lies at angular distance greater than $0.5748$ from $SO(n).W_{\mathbb{CP}^2}$ (the location claim on its own) | CONFIRMED, under hypothesis H_S, by a separate route |
| 5 | $\lvert\langle W,u_E\rangle\rvert\le\tfrac{\sqrt6}2\max(a,b)$ and the closed form for $\lVert W\rVert^2$ of a product of round spheres | CONFIRMED AS ALGEBRA |

**Summary: the location claim is true for the near-balanced product, but it does not follow from Passage A, whose bootstrap $\gamma_V\le m$ closes only when the expanded point is the maximizer itself, so step G6 FAILS as an inference.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of Weyl operators, self-adjoint maps on $\Lambda^2\mathbb R^n$, with the Frobenius inner product $\langle A,B\rangle=\operatorname{tr}(AB)$. It is irreducible under $O(n)$ for $n\ge5$, so every invariant inner product is a multiple of this one and angles are canonical.
- $d$ is geodesic angular distance on the unit sphere, $\cos d(X,Y)=\langle X,Y\rangle/(\lVert X\rVert\lVert Y\rVert)$, as Passage A fixes it. $d(X,\mathcal O)=\min_{g}d(X,g.u)$, attained because the orbit $\mathcal O=SO(n).u$ is compact.
- $u=W_{\mathbb{CP}^2}$ padded, $\lVert u\rVert=1$. Every orbit point $g.u$ is a unit Weyl operator on $\mathbb R^4$ carried to a 4-plane $E=g\mathbb R^4$ and extended by zero, written $u_E$. It is supported on $\Lambda^2E$ and traceless.
- $m=\sqrt{2/3}\max P$ on the unit sphere, $p(W)=\sqrt{2/3}P(W)$ for unit $W$, $p_S=\sqrt{2/3}\,\Theta_n$ for the witness.
- $\pi_1,\pi_2$ are the orthogonal projections of $\Lambda^2\mathbb R^n$ onto $\Lambda^2V_1,\Lambda^2V_2$ for an orthogonal splitting $\mathbb R^n=V_1\oplus V_2$, $\dim V_1=p$, $\dim V_2=q$, $N_1=p(p-1)/2$, $N_2=q(q-1)/2$, $N=n(n-1)/2$.
- For symmetric $h$ on $\mathbb R^n$, $D_h$ is its derivation extension, $D_h(x\wedge y)=hx\wedge y+x\wedge hy$ (the operator of the Kulkarni–Nomizu product $h\owedge g$).

## 1. Hypothesis inventory

- **H1 (Passage A's own inputs)**: $d$ is $SO(n)$-invariant, the orbit is a compact embedded submanifold, first variation holds at a nearest point, $\alpha\le\tfrac13$ on $u^\perp\cap T_u\mathcal O^\perp$ (Lemma L21, a given), $\gamma_V\le m$.
- **H2 (Passage A's conclusion)**: every unit $W^*$ with $p(W^*)=m$ has $d(W^*,\mathcal O)>0.5748$, at every $n\ge12$.
- **H_S (identity of the witness)**: the witness of value $\Theta_n$ is $\pm W_S/\lVert W_S\rVert$, where $W_S$ is the Weyl part of the curvature operator $R=a\pi_1+b\pi_2$ of a Riemannian product $S^p\times S^q$ of round spheres of curvatures $a,b\ge0$, not both zero, with $p=\lfloor n/2\rfloor$, $q=\lceil n/2\rceil$. The radii are left free. The brief names the even witness "balanced" and the odd one "the best split" without stating the split, so the split is a hypothesis here.
- **H_M (not available)**: the witness is itself a maximizer, $p_S=m$.

## 2. Where the inference sits in Passage A

The step is the closing clause of Passage A: "Note that the contradiction is with the *value*, not the location, nothing is assumed about where the sphere product sits, and that it too lies outside the tube follows afterwards." The brief states it as: the witness lies at distance greater than $0.5748$ from the orbit at every $n\ge12$, and this follows from Passage A's conclusion.

Passage A's proof expands the maximizer $W^*=\cos\varphi\,u+\sin\varphi\,V$ and obtains $m\le\cos\varphi+m\sin^3\varphi$. The quantity on the left and the bound on $\gamma_V$ on the right are the same number $m$. That coincidence is what turns the inequality into $m\le\psi(\varphi)$ and then $m\le1$.

## 3. Claim 1: the conclusion about maximizers says nothing about a non-maximal point

H2 is a statement about the set $\{W:p(W)=m\}$. The witness belongs to that set only under H_M, and nothing in the passages supplies H_M. Its value $p_S>1$ gives $m\ge p_S$, a lower bound on $m$, never equality. So H2 constrains the location of the maximizers and is silent on the location of any other unit Weyl operator. Under H_M the step would follow in one line, but H_M is the kind of statement the localization lemma is built to approach, so assuming it is circular.

**Arguing the opposite.** One might read "follows afterwards" as: since every maximizer lies outside the tube, and the witness has a value above $\theta^*$, the witness is outside too. That reading needs the implication "$p(W)>1\Rightarrow d(W,\mathcal O)>0.5748$" for all unit $W$, which is a statement about the whole superlevel set $\{p>1\}$. H2 covers only its top level. Section 4 shows the passages do not give the superlevel statement either.

## 4. Claim 2: rerunning the proof at the witness reaches no contradiction

Take any unit $W$ with nearest orbit point rotated to $u$, $\varphi=d(W,\mathcal O)\in(0,0.5748]$, $W=\cos\varphi\,u+\sin\varphi\,V$. First variation and the cubic expansion hold for any $W$ with a nearest point, maximal or not, so H1 gives

$$p(W)=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V\le\cos\varphi+m\sin^3\varphi.$$

The right side carries $m$, not $p(W)$. The passages give $m\ge p_S$ and no upper bound on $m$. The inequality contradicts $p(W)=p_S$ only if $m<(p_S-\cos\varphi)/\sin^3\varphi$, which nothing on the record supplies.

**Exhibited in closed form.** The following real numbers satisfy every relation the passages make available at the witness, with the witness inside the tube. Take $\varphi=\pi/6$, which lies in $(0,0.5748]$ because $\pi<3.4488$. Then $\sin\varphi=\tfrac12$, $\cos\varphi=\tfrac{\sqrt3}2$, $\sin^3\varphi=\tfrac18$. Take any $p_S>1$ (at $n=12$, $p_S^2=\tfrac23\cdot\tfrac{55}{36}=\tfrac{55}{54}$), $\alpha=\tfrac13$, $\gamma_V=8\bigl(p_S-\tfrac{\sqrt3}2\bigr)=8p_S-4\sqrt3$, and $m=\max(p_S,\gamma_V)$. The expansion holds exactly: $\tfrac{3\sqrt3}8+\tfrac{\sqrt3}8+\tfrac18(8p_S-4\sqrt3)=p_S$. Also $\alpha\le\tfrac13$, $\gamma_V\le m$, $m\ge p_S>1$, and H2 is untouched since the maximizer is a different point. So the relations of Passage A, applied to a non-maximal point, are consistent with that point lying in the tube. In the notation of Passage D, the Lean theorem tube_exclusion needs the hypotheses hexp and hγ to carry the same variable m, and the witness supplies hexp with $p_S$ and hγ with $m$, two different variables.

The expansion identity alone does not bound $m$ from above, and a bound would need $\gamma_V\le M$ for some explicit $M$ with $\cos\varphi+M\sin^3\varphi<p_S$ throughout $[0,0.5748]$. No such $M$ is on the record, so the rerun fails.

## 5. Claim 3: the maximum over the tube does not bootstrap either

A second candidate reading: let $m_T$ be the maximum of $p$ over the compact closed tube $\{d(W,\mathcal O)\le0.5748\}$, attained at $W_T$, and rerun the proof there. The expansion gives $m_T\le\cos\varphi+\sin^3\varphi\,\gamma_V$. Replacing $\gamma_V$ by $m_T$ needs the normal direction $V$ itself to lie in the tube. $V$ is a unit Weyl operator orthogonal to $u$ and to $T_u\mathcal O$, and nothing places it within $0.5748$ of the orbit. Only $\gamma_V\le m$ is available, and Section 4 applies unchanged. The reading closes only with an added hypothesis that the normal directions at the tube maximizer lie in the tube, which the passages do not state.

## 6. Claims 4 and 5: the location claim by a separate route, under H_S

The location claim is still true, by a direct bound on the overlap. None of this uses Passage A.

**6.1. The overlap bound.** The decomposition of an algebraic curvature operator into Weyl, traceless Ricci and scalar parts is $O(n)$-equivariant into pairwise non-isomorphic irreducibles, so it is orthogonal and $W_S$ is the orthogonal projection of $R$ onto $\mathcal W_n$. Since $u_E\in\mathcal W_n$, $\langle W_S,u_E\rangle=\langle R,u_E\rangle$. Let $P_E$ project onto $\Lambda^2E$ and $C=P_ERP_E$ on $\Lambda^2E$. Since $u_E=P_Eu_EP_E$, $\langle R,u_E\rangle=\operatorname{tr}(Cu)$. With $M=\max(a,b)$ and $\pi_1\pi_2=0$, $0\le R\le M\,\mathrm{Id}$, hence $0\le C\le M\,\mathrm{Id}_{\Lambda^2E}$. The operator $u$ is traceless, so $\operatorname{tr}(Cu)=\operatorname{tr}\bigl((C-\tfrac M2\mathrm{Id})u\bigr)$, and Cauchy–Schwarz with six eigenvalues in $[-\tfrac M2,\tfrac M2]$ gives

$$\lvert\langle W_S,u_E\rangle\rvert\le\tfrac{\sqrt6}2\,M\quad\text{for every 4-plane }E\text{ and every orbit point.}$$

**6.2. The norm of $W_S$.** Three exact facts. First, $\operatorname{tr}(D_hD_k)=(n-2)\operatorname{tr}(hk)+\operatorname{tr}h\operatorname{tr}k$, checked on commuting diagonal $h,k$ and extended because an invariant bilinear form on $\mathrm{Sym}^2$ has the shape $c_1\operatorname{tr}(hk)+c_2\operatorname{tr}h\operatorname{tr}k$. Second, $\operatorname{tr}(\pi_1D_h)=\sum_{i<j\in V_1}(h_{ii}+h_{jj})=(p-1)\operatorname{tr}(P_1h)$, so $\langle R,D_h\rangle=\operatorname{tr}(hK)$ with $K=a(p-1)P_1+b(q-1)P_2$. Third, $\operatorname{tr}D_h=(n-1)\operatorname{tr}h$, so $D_h\perp\mathrm{Id}$ for traceless $h$. The scalar part of $R$ has squared norm $(\operatorname{tr}R)^2/N$ with $\operatorname{tr}R=aN_1+bN_2$, and the traceless Ricci part is $D_{K_0/(n-2)}$ with squared norm $\lVert K_0\rVert^2/(n-2)$, where $\lVert K_0\rVert^2=a^2p(p-1)^2+b^2q(q-1)^2-4(aN_1+bN_2)^2/n$. Using $p(p-1)^2=2N_1(p-1)$, $1-\tfrac{2(p-1)}{n-2}=\tfrac{q-p}{n-2}$, and $\tfrac4{n(n-2)}-\tfrac2{n(n-1)}=\tfrac2{(n-1)(n-2)}$,

$$\lVert W_S\rVert^2=\frac{(q-p)(a^2N_1-b^2N_2)}{n-2}+\frac{2(aN_1+bN_2)^2}{(n-1)(n-2)}.$$

Check: $p=n-1$, $q=1$, $a=1$ gives $-N_1+N_1=0$, the conformally flat $S^{n-1}\times\mathbb R$.

**6.3. Even $n=2p\ge12$.** Here $q=p$, so $\lVert W_S\rVert^2=2N_1^2(a+b)^2/((2p-1)(2p-2))$. Normalise $M=1$, which leaves angles unchanged, so $(a+b)^2\ge1$ and $\lVert W_S\rVert^2\ge p^2(p-1)/(4(2p-1))$. With 6.1,

$$\cos^2d(W_S,\mathcal O)\le\frac32\cdot\frac{4(2p-1)}{p^2(p-1)}\le\frac{12}{p(p-1)}\le\frac{12}{30}=\frac25\qquad(p\ge6).$$

**6.4. Odd $n=2p+1\ge13$.** Here $q=p+1$, $n-2=2p-1$. With $x=a(p-1)$, $y=b(p+1)$, one has $aN_1+bN_2=\tfrac p2(x+y)$ and

$$\lVert W_S\rVert^2=\frac{p}{4(2p-1)}\Bigl[(x+y)^2+\frac{2x^2}{p-1}-\frac{2y^2}{p+1}\Bigr]\ge\frac{p}{4(2p-1)}\Bigl[x^2+\frac{p-1}{p+1}y^2\Bigr],$$

using $x,y\ge0$. With $M=1$, either $a=1$ and the bracket is at least $(p-1)^2$, or $b=1$ and it is at least $(p-1)(p+1)\ge(p-1)^2$. So $\lVert W_S\rVert^2\ge p(p-1)^2/(4(2p-1))$ and

$$\cos^2d(W_S,\mathcal O)\le\frac32\cdot\frac{4(2p-1)}{p(p-1)^2}\le\frac{12}{(p-1)^2}\le\frac{12}{25}\qquad(p\ge6).$$

**6.5. Comparison with the radius.** $\cos x\ge1-x^2/2$ for all real $x$, and $0.5748\le\tfrac35$, so $\cos(0.5748)\ge\tfrac{41}{50}>0$ and $\cos^2(0.5748)\ge\tfrac{1681}{2500}$. Both bounds above are at most $\tfrac{12}{25}=\tfrac{1200}{2500}<\tfrac{1681}{2500}$. Hence $\cos d(W_S,\mathcal O)\le\lvert\cos d\rvert<\cos(0.5748)$, and $\cos$ is strictly decreasing on $[0,\pi]$, so $d(W_S,\mathcal O)>0.5748$ at every $n\ge12$. The sign of the witness is immaterial since 6.1 bounds the absolute overlap.

**Arguing the opposite.** The bound fails for lopsided splits: at $p=2$, $a=0$, the formula gives $\lVert W_S\rVert^2=(n-3)/(n-1)$ and 6.1 then bounds $\cos^2d$ only by a number above $1$. So the route needs H_S's near-balanced split. If the odd witness were a different split, the deciding quantity would be $\max_E\lvert\langle W_S,u_E\rangle\rvert/\lVert W_S\rVert$ for that split, compared with $\cos(0.5748)$.

## 7. Verdict

**Step G6 FAILS as written.** The location of the witness does not follow from Passage A's conclusion or from its argument. H2 concerns only points with $p=m$, and at any other point the expansion gives $p\le\cos\varphi+m\sin^3\varphi$ with $m$ unbounded above on the record. Section 4 exhibits an exact assignment satisfying every available relation with the witness inside the tube. The VALID reading of the inference needs H_M (the witness is a maximizer), which is circular for a localization lemma.

**The conclusion of the step is nonetheless true** under H_S, by the independent overlap bound of Section 6: $\cos^2d(W_S,\mathcal O)\le\tfrac25$ at even $n\ge12$ and $\le\tfrac{12}{25}$ at odd $n\ge13$, both below $\cos^2(0.5748)$. The repair is to replace "follows afterwards" with that argument, or to delete the clause, since L20's proof uses only the witness's value.
