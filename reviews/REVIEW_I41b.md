# REVIEW_I41b, the mixed summand, and the one fact that is not part (a)

*Gate 2 reviewer B on item I41, brief cold: I read [ROUND_L32.md](../verification/ROUND_L32.md), the L32 block of [isotropy-cap.md](../findings/isotropy-cap.md) and [conventions.md](../findings/conventions.md), and nothing else on the record. **No numerical work was done**, no script, no Sage, no evaluation; the six worked instances below are exact hand screens on objects I constructed for the purpose, and none of them is offered as evidence for a positive claim. Log: [agent_logs/gate2_I41-B.log](../agent_logs/gate2_I41-B.log).*

## Verdict

**`PROVEN, hypotheses corrected`.** Both parts hold and both are proved below in closed form. The correction is to the word *consequently*: **(b) is not a consequence of (a)**. Part (a) discharges the mixed summand at $\dim\ker x\ge2$ and gives nothing at $\dim\ker x=1$, where a different fact carries the case, that $\mathfrak c_V$ has trivial common kernel on $\mathop{\mathrm{im}}x$, which holds exactly when $\tfrac12\mathop{\mathrm{rank}}x\ge2$. **So the owed line as named on the record, *"which needs the standard representation of $\mathfrak{so}(k)$ to have no invariant vector for $k\ge2$"*, is one case short of the line the record needs**, and the missing case is corank $1$, which is the case [ROUND_L32](../verification/ROUND_L32.md) opened this item for.

**The sharp form of (b): for nonzero $x\in\mathfrak{so}(m)$, the mixed summand contributes nothing if and only if $m\ne3$.** Its unique failure locus is $\tfrac12\mathop{\mathrm{rank}}x=1$ with $\dim\ker x=1$, which is $m=3$ and the refuting witness of [r462](REVIEW_r462.md)/[r463](REVIEW_r463.md). *That is why $m\ne3$ is sharp: the hypothesis L32 needs and the hypothesis this one line needs are the same hypothesis.*

## Conventions, quoted

From [conventions.md](../findings/conventions.md):

> **A skew matrix's norm**, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)$, singular values in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_i s_i^2=1$.

> **A bivector's norm**, and the record runs in the first of these: $\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal.

> $\mathfrak c=\mathfrak z(x)\cap x^\perp$; $a$ the singular-value vector of $x$; **$p=\lfloor m/2\rfloor$, the torus rank**, *not $\tfrac12\mathop{\mathrm{rank}}x$, a second live reading under which the block's own hedge is false, a simple bivector in $\mathfrak{so}(12)$ having $p=1$*; $\mathfrak t$ the maximal torus of $x$'s coordinate $2$-planes.

**I write $r:=\tfrac12\mathop{\mathrm{rank}}x$ throughout and never $p$**, precisely because the table records that the two readings are live and differ off maximal rank; $a\in\mathbb R^r$ has all coordinates nonzero by construction, and $r=p$ exactly at corank $0$ and $1$.

## 1. The setting, fixed

**1.1.** Let $x\in\mathfrak{so}(m)$ be nonzero, $V:=\mathop{\mathrm{im}}x$, $K:=\ker x$. For skew $x$, $\langle xu,w\rangle=-\langle u,xw\rangle$ gives $\mathop{\mathrm{im}}x\perp\ker x$, and the dimensions add, so $\mathbb R^m=V\perp K$ is an orthogonal splitting. Put $\dim V=2r$ and $\dim K=k$, so $k\equiv m\pmod 2$ and $m=2r+k$.

**1.2. The decomposition.** $\mathfrak{so}(m)=\Lambda^2\mathbb R^m$ splits orthogonally along 1.1 as

$$\mathfrak{so}(m)=\underbrace{\Lambda^2V}_{\mathfrak{so}(V)}\ \oplus\ \underbrace{V\otimes K}_{\mathop{\mathrm{Hom}}(K,V)}\ \oplus\ \underbrace{\Lambda^2K}_{\mathfrak{so}(K)},$$

the middle summand being the block-off-diagonal skew matrices $\begin{pmatrix}0&A\\-A^{\mathsf T}&0\end{pmatrix}$ with $A\in\mathop{\mathrm{Hom}}(K,V)$. **So $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ is the middle summand $V\otimes K$**, of dimension $2rk$, and the metric identification $K\cong K^*$ makes $\mathop{\mathrm{Hom}}(K,V)$, $\mathop{\mathrm{Hom}}(V,K)$ and $V\otimes K$ one space. Orthogonality of the three summands is the orthogonality of $\{\varphi_{ab}\}_{a<b}$ quoted above, in a frame adapted to $V\perp K$.

**1.3.** Write $x=x_V\oplus0$ with $x_V\in\mathfrak{so}(V)$ **invertible**, and $Y=\begin{pmatrix}Y_V&A\\-A^{\mathsf T}&Y_K\end{pmatrix}$, $c=\begin{pmatrix}c_V&0\\0&c_K\end{pmatrix}$ for a block-diagonal $c$. Then

$$[c,Y]=\begin{pmatrix}[c_V,Y_V]&c_VA-Ac_K\\ \ast&[c_K,Y_K]\end{pmatrix}.\tag{1}$$

**1.4. $\mathfrak z(x)$ is block-diagonal.** Applying (1) with $c=x$, so $c_K=0$: the mixed block reads $x_VA=0$, and $x_V$ is invertible, so $A=0$. Hence

$$\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(V)}(x_V)\oplus0\oplus\mathfrak{so}(K).$$

**1.5. $\mathfrak c$ is block-diagonal, and contains all of $\mathfrak{so}(K)$.** Since $x\in\mathfrak{so}(V)$ and 1.2 is orthogonal, $x^\perp\supseteq(V\otimes K)\oplus\mathfrak{so}(K)$, so

$$\mathfrak c=\mathfrak z(x)\cap x^\perp=\mathfrak c_V\oplus0\oplus\mathfrak{so}(K),\qquad \mathfrak c_V:=\mathfrak z_{\mathfrak{so}(V)}(x_V)\cap x_V^{\perp_V}.\tag{2}$$

*This is what $\mathfrak c$ contains in each summand: everything of $\mathfrak{so}(K)$, the algebra $\mathfrak c_V$ of $\mathfrak{so}(V)$, and nothing mixed.* **The sum in (2) is direct**, so $c_V\in\mathfrak c_V$ and $c_K\in\mathfrak{so}(K)$ may be chosen independently, the step every later line turns on.

**1.6. What centralising $\mathfrak c$ forces on the mixed part.** By (1) and (2), $Y\in\mathfrak z(\mathfrak c)$ holds exactly when

$$Y_V\in\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V),\qquad Y_K\in\mathfrak z\big(\mathfrak{so}(K)\big),\qquad c_VA=Ac_K\ \ \forall\,(c_V,c_K)\in\mathfrak c_V\times\mathfrak{so}(K).$$

Independence gives the mixed condition in separated form:

$$c_VA=0\ \ \forall c_V\in\mathfrak c_V\qquad\text{and}\qquad Ac_K=0\ \ \forall c_K\in\mathfrak{so}(K).\tag{3}$$

**Statement (b) is exactly: (3) forces $A=0$.**

## 2. Part (a)

**2.1. Claim.** For $k\ge2$, the standard representation $\mathbb R^k$ of $\mathfrak{so}(k)$ carries no nonzero invariant vector.

**2.2. Proof.** Let $u\in\mathbb R^k$ satisfy $Zu=0$ for every $Z\in\mathfrak{so}(k)$, and suppose $u\ne0$. Since $k\ge2$, the hyperplane $u^\perp$ is nonzero; pick $w\in u^\perp$ with $w\ne0$. Then $Z:=uw^{\mathsf T}-wu^{\mathsf T}\in\mathfrak{so}(k)$ and

$$Zu=u\langle w,u\rangle-w\langle u,u\rangle=-\lVert u\rVert^2\,w\ \ne\ 0,$$

contradicting invariance. Hence $u=0$. $\square$

**2.3. The two small $k$, stated positively.** At $k=0$ the space $\mathbb R^0$ is zero and the claim is vacuously true. **At $k=1$ the claim is false**: $\mathfrak{so}(1)=0$, so every vector of $\mathbb R^1$ is invariant and the invariant subspace is the whole $1$-dimensional space. The proof locates the boundary exactly: the construction in 2.2 needs $u^\perp\ne0$, and $u^\perp=0$ is precisely $k=1$ with $u\ne0$.

**2.4. Equivalent form used below.** For $k\ge2$, $\{v\in K:\ \mathfrak{so}(K)v=0\}=0$; equivalently $\sum_{c_K\in\mathfrak{so}(K)}\mathop{\mathrm{im}}c_K=K$, the two being orthogonal complements of one another since each $c_K$ is skew.

## 3. Part (b), corank by corank

Throughout, $A\in\mathop{\mathrm{Hom}}(K,V)$ satisfies (3).

**3.1. Corank $0$ ($k=0$, $m=2r$ even).** $V\otimes K=0$. There is nothing to kill and $A=0$ trivially.

**3.2. Corank $k\ge2$ (both parities: $k\ge2$ even at even $m$, $k\ge3$ odd at odd $m$).** The second half of (3) says $Ac_K=0$ for all $c_K\in\mathfrak{so}(K)$; transposing, $c_KA^{\mathsf T}=0$ for all $c_K$, so every vector in $\mathop{\mathrm{im}}A^{\mathsf T}\subseteq K$ is an invariant vector of the standard representation of $\mathfrak{so}(k)$. **By 2.1 that space is zero**, so $A^{\mathsf T}=0$ and $A=0$. *This is the case part (a) governs, and it governs it alone, the first half of (3) is never used, so no property of $\mathfrak c_V$ enters at $k\ge2$.*

**3.3. Corank $1$ ($k=1$, $m=2r+1$ odd).** Here $\mathfrak{so}(K)=0$ and the second half of (3) is empty, as is the $\mathfrak{so}(\ker x)$ clause the L32 block offers for degenerate $x$. Part (a) is unavailable and false at $k=1$ by 2.3. What remains is the first half of (3), and with $\dim K=1$ the map $A$ is the single vector $v:=A(1)\in V$, so (3) reads

$$c_Vv=0\ \ \text{for every } c_V\in\mathfrak c_V,\qquad\text{i.e.}\qquad v\in\bigcap_{c\in\mathfrak c_V}\ker c\ \subseteq V.$$

**So at corank $1$ the fact that does the work is: $\mathfrak c_V$ has trivial common kernel on $V$.** I prove it for $r\ge2$.

**3.4. The torus inclusion.** Choose an orthonormal frame of $V$ in which $x_V=\sum_{i=1}^ra_i\varphi_i$, $\varphi_i:=\varphi_{2i-1,2i}$ the coordinate $2$-plane bivectors of $V$ and $a_i>0$ for every $i$, all nonzero because $x_V$ is invertible on $V$. Let $\mathfrak t_V:=\mathop{\mathrm{span}}\{\varphi_1,\dots,\varphi_r\}$. Every element of $\mathfrak t_V$ commutes with $x_V$, and by the quoted orthonormality of $\{\varphi_{ab}\}$,

$$\Big\langle\textstyle\sum_it_i\varphi_i,\ \sum_ja_j\varphi_j\Big\rangle=\sum_it_ia_i,$$

so $\mathfrak t_V\cap x_V^{\perp}=a^\perp$ and therefore $a^\perp\subseteq\mathfrak c_V$, of dimension $r-1$.

**3.5. The common kernel of $a^\perp$ is zero when $r\ge2$.** For $t\in\mathbb R^r$, $\ker\big(\sum_it_i\varphi_i\big)=\bigoplus_{i:\,t_i=0}P_i$ with $P_i$ the $i$-th coordinate $2$-plane, each $\varphi_i$ being invertible on its own plane. Hence

$$\bigcap_{t\in a^\perp}\ker\Big(\sum_it_i\varphi_i\Big)=\bigoplus_{i\in S}P_i,\qquad S=\{i:\ t_i=0\ \text{for all }t\in a^\perp\}.$$

The index $i$ lies in $S$ exactly when the coordinate functional $t\mapsto t_i$ vanishes on the hyperplane $a^\perp$, i.e. exactly when $e_i\in(a^\perp)^\perp=\mathbb Ra$, i.e. exactly when $a$ is a multiple of $e_i$. With every $a_j>0$ that happens only at $r=1$. **So for $r\ge2$, $S=\varnothing$ and the common kernel is $0$**; a fortiori $\bigcap_{c\in\mathfrak c_V}\ker c=0$, since $\mathfrak c_V\supseteq a^\perp$ and enlarging the family only shrinks the intersection. By 3.3, $v=0$ and $A=0$. $\square$

**3.6. The one remaining cell, $r=1$ and $k=1$, which is $m=3$.** There $\mathfrak{so}(V)=\mathbb Rx$, so $\mathfrak c_V=\mathbb Rx\cap x^\perp=0$ and by (2) $\mathfrak c=0$. Condition (3) is empty and **every** $A\in\mathop{\mathrm{Hom}}(K,V)$ survives: the mixed summand contributes its whole $2$ dimensions, $\mathop{\mathrm{span}}(\varphi_{13},\varphi_{23})$ at $x=\varphi_{12}$, and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{so}(3)$. *This is the [r462](REVIEW_r462.md)/[r463](REVIEW_r463.md) witness, recovered as the unique failure of the mixed-summand step.*

**3.7. Part (b), assembled.** Let $x\in\mathfrak{so}(m)$ be nonzero. **The mixed summand $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ meets $\mathfrak z(\mathfrak c)$ in $0$ if and only if $m\ne3$.** Forward: 3.1 at $k=0$, 3.2 at $k\ge2$, 3.3–3.5 at $k=1$ with $r\ge2$; the cells are exhaustive because $k=1$ with $r=1$ is $m=3$. Converse: 3.6. $\square$

**3.8. Which fact does the work, named.** Part (a) is the whole of the argument at $k\ge2$ and none of it at $k=1$; triviality of the common kernel of $\mathfrak c_V$ is the whole of the argument at $k=1$ and is not needed at $k\ge2$. **Neither fact covers both cells**, and $k\in\{0,1\}$ is where the record's one-sentence debt runs out.

## 4. What (b) buys L32

**4.1. The reduction, now exact.** With the mixed part gone, 1.6 gives $\mathfrak z(\mathfrak c)=\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\oplus0\oplus\mathfrak z(\mathfrak{so}(K))$, while (2) gives $\mathfrak c^\perp=\mathfrak c_V^{\perp_V}\oplus(V\otimes K)\oplus0$. **The $\mathfrak{so}(K)$ term dies against $\mathfrak c^\perp$**, $\mathfrak z(\mathfrak{so}(K))\subseteq\mathfrak{so}(K)\subseteq\mathfrak c$ by 1.5, so

$$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\ =\ \mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\cap\mathfrak c_V^{\perp_V}.\tag{4}$$

*That is the block's "the same argument runs inside the support", turned from a hand wave into an identity.* **The clause "with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$" describes a term that contributes nothing either way**: at $k=2$ it is the nonzero line $\mathbb R\varphi_K$ and at every other $k$ it is $0$, and in both cases it lies inside $\mathfrak c$. What $\mathfrak{so}(K)$ actually does for the proof is kill the mixed part at $k\ge2$, which is a different service from the one the clause advertises.

**4.2. The short-root question disappears.** The right-hand side of (4) lives in $\mathfrak{so}(V)=\mathfrak{so}(2r)$, of type $D_r$, **at both parities of $m$**, the odd part of $m$ having been absorbed into $K$. So after (4) no $B_p$ short root is ever in play. *The block's repaired sentence, that the short roots are excluded by the same hypothesis as the long ones, is true and, under this reduction, unnecessary.*

**4.3. Every corank, with (4) in hand.** $r\ge3$: every $D_r$ root $\pm e_i\pm e_j$ has $r-2\ge1$ zero coordinates while $a$ has none, so no root is proportional to $a$, $\mathfrak z_{\mathfrak{so}(V)}(a^\perp)=\mathfrak t_V$, and (4) is contained in $\mathfrak t_V\cap(a^\perp)^{\perp}=\mathbb Rx$. $r=2$: the roots $\pm e_1\pm e_2$ have no zero coordinate, $e_1-e_2\propto a$ is impossible for $a_1,a_2>0$, and $e_1+e_2\propto a$ is $a_1=a_2$, the complex structure on a $4$-plane, where $\mathfrak c_V=\Lambda^2_-$ and (4) reads $\Lambda^2_+$, of dimension $3$. $r=1$: $\mathfrak c_V=0$, so (4) reads $\mathfrak{so}(V)=\mathbb Rx$. **These three cells are independent of $k$**, so the corank enters L32 only through part (b), which is why the exception is "rank $4$ with equal singular values at every $m\ge4$ and every corank", and why the failure at $m=3$ is a failure of (b) and not of the root count.

**4.4. Scope of this report.** Item I41 is (a) and (b); 4.1–4.3 record what (b) buys and are not offered as a re-audit of L32's root-system branch, which [ROUND_L32](../verification/ROUND_L32.md) settled.

## 5. Screens

**Exact hand computations on objects constructed for this report, seconds of arithmetic each, offered as screens.** All are consistent with §3 and none is evidence for it.

| instance | $r$, $k$ | mixed part of $\mathfrak z(\mathfrak c)$ | $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ |
|---|---|---|---|
| $x=\varphi_{12}\in\mathfrak{so}(3)$ | $1,1$ | $\mathop{\mathrm{span}}(\varphi_{13},\varphi_{23})$, dimension $2$ | $\mathfrak{so}(3)$, dimension $3$ |
| $x=\varphi_{12}\in\mathfrak{so}(4)$ | $1,2$ | $0$ ($c_K=\varphi_{34}$ invertible on $K$) | $\mathbb R\varphi_{12}=\mathbb Rx$ |
| $x=\varphi_{12}\in\mathfrak{so}(5)$ | $1,3$ | $0$; $\mathfrak c=\mathfrak{so}(3)$ and $\mathbb R^5$ is $2$ trivials plus the standard | $\mathbb Rx$ |
| $x=\varphi_{12}+2\varphi_{34}\in\mathfrak{so}(5)$ | $2,1$ | $0$; $\mathfrak c=\mathbb R(2\varphi_{12}-\varphi_{34})$, invertible on $V$ | $\mathbb Rx$ |
| $x=\varphi_{12}+\varphi_{34}\in\mathfrak{so}(5)$ | $2,1$ | $0$; $a^\perp=\mathbb R(\varphi_{12}-\varphi_{34})$, invertible on $V$ | $\Lambda^2_+(V)$, dimension $3$ |
| $x=\varphi_{12}+\varphi_{34}+\varphi_{56}\in\mathfrak{so}(7)$ | $3,1$ | $0$; $\ker(\varphi_{12}-\varphi_{34})\cap\ker(\varphi_{34}-\varphi_{56})=P_3\cap P_1=0$ | $\mathbb Rx$ |

*The fourth and sixth rows are corank $1$ at odd $m$ (the cell part (a) cannot reach) and both close through 3.5. The fifth shows the exception surviving at odd $m$ and corank $1$.*

## 6. What would falsify each part, and what I did to look for it

**Part (a).** A falsifier is a $k\ge2$ and a nonzero $u\in\mathbb R^k$ annihilated by every element of $\mathfrak{so}(k)$. **None exists, and 2.2 is constructive**: for each candidate $u$ it exhibits an explicit annihilator-breaker $uw^{\mathsf T}-wu^{\mathsf T}$, so the search space is empty by construction rather than by exhaustion. I looked for the boundary instead and found it: the construction consumes exactly one hypothesis, $u^\perp\ne0$, which fails only at $k=1$ with $u\ne0$, and there the claim is genuinely false, $\mathfrak{so}(1)$ being zero. I checked $k=2$ by hand separately, the one $k\ge2$ where $\mathfrak{so}(k)$ is abelian and a reader might expect trouble: its generator is invertible, so the case is if anything easier.

**Part (b).** A falsifier is a nonzero $A\in\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ with $c_VA=Ac_K$ for all $c\in\mathfrak c$. I split the space of instances by $(r,k)$, the only invariants (3) sees, since $a$ enters solely through 3.5 and $k$ solely through 3.2, and ran each cell to a decision: $k=0$ empty, $k\ge2$ closed by (a) with no dependence on $a$ or $r$, $k=1$ closed by 3.5 whenever $r\ge2$, and $k=1$ with $r=1$ **open and in fact false**, which is 3.6. So the falsifier set is nonempty and is exactly $\{m=3\}$, which the hypothesis of L32 excludes. **What would falsify the corank-$1$ argument specifically** is a maximal-rank $x$ at odd $m\ge5$ whose $\mathfrak c_V$ has a nonzero common kernel in $V$; 3.5 rules that out from $a^\perp$ alone, using only that $a$ has $r\ge2$ strictly positive coordinates, and I screened it against $a=(1,2)$, $a=(1,1)$ and $a=(1,1,1)$, including the repeated-singular-value patterns, where $\mathfrak c_V$ is largest and the common kernel would be smallest, and the equal-value pattern that triggers the exception.

**What I did not do.** No sweep, no census, no search over multiplicity partitions. *[ROUND_L32](../verification/ROUND_L32.md)'s own finding J10 is that the $29$-partition sweep covered the branch that already had a proof; the cell at issue here is $(r,k)=(r,1)$, which no partition sweep reaches, and the argument for it is four lines of linear algebra.*
