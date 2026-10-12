# REVIEW_I41a, the mixed summand of a bivector's centraliser, and what actually deletes it

**Gate 2 reviewer A on item I41, cold brief.** I read [ROUND_L32.md](../verification/ROUND_L32.md), the [L32](../findings/isotropy-cap.md) block and [conventions.md](../findings/conventions.md) to learn what is claimed, and derived everything below from the definitions rather than from those files. **No numerical work was done**, no script, no Sage, no evaluation of any kind; the programme is on an analysis-only footing and this brief carried no per-task approval. Every case named below was settled by hand in closed form. Log: [agent_logs/gate2_I41-A.log](../agent_logs/gate2_I41-A.log).

## Verdict, `PROVEN, hypotheses corrected`

**Both parts are theorems and both are proved below in closed form.** Two corrections to the record's account of them:

- **(b) is false at $m=3$, and $m=3$ is the only place it fails.** There the mixed summand supplies $2$ of the $3$ dimensions of $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$. So $m\ne3$ (already L32's sharp hypothesis), is *also* exactly the hypothesis of (b), rather than a condition inherited from elsewhere.
- **(a) is not the fact that does the work.** It settles $\dim\ker x\ge2$ and gives nothing at $\dim\ker x=1$, where $\mathfrak{so}(\ker x)=0$. The corank-$1$ case runs on a second, independent fact, **$\mathfrak c_V$ has trivial common kernel on $\operatorname{im}x$**, which holds exactly when $\operatorname{rank}x\ge4$. The record's owed line, *"which needs the standard representation of $\mathfrak{so}(k)$ to have no invariant vector at $k\ge2$"*, is therefore a correct half of the reason and not the whole of it.

**And (b) delivers more than the record asked for.** With the mixed summand gone the degenerate case does not merely *resemble* the maximal-rank case inside the support, it *equals* it, as an identity of subspaces (§5). That is the exact form of the one-sentence degenerate branch L32 asserts without proof.

## 1. Conventions, quoted

From [conventions.md](../findings/conventions.md), *"A skew matrix's norm, in the form the stratum arguments use: $\langle X,X\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}X)$"*, and *"$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal"*.

From the same file's row for [isotropy-cap.md](../findings/isotropy-cap.md): *"$\mathfrak c=\mathfrak z(x)\cap x^\perp$; $a$ the singular-value vector of $x$; $p=\lfloor m/2\rfloor$, the torus rank; $\mathfrak t$ the maximal torus of $x$'s coordinate $2$-planes"*.

Two symbols this argument needs and the record does not carry, fixed here for the length of this report: $V:=\operatorname{im}x$ and $K:=\ker x$, with $k:=\dim K$ and $2r:=\dim V=\operatorname{rank}x$. I write $x_V\in\mathfrak{so}(V)$ for the restriction of $x$ to $V$, and $\mathfrak c_V:=\mathfrak z_{\mathfrak{so}(V)}(x_V)\cap x_V^{\perp}$ for the object $\mathfrak c$ becomes on the support. **All orthocomplements are taken inside the ambient algebra named by the subscript**, and $\perp_V$ marks one taken inside $\mathfrak{so}(V)$.

## 2. Part (a), at every $k$

**Proposition A.** *For $k\ge2$ the standard representation $\mathbb R^k$ of $\mathfrak{so}(k)$ carries no nonzero invariant vector: $(\mathbb R^k)^{\mathfrak{so}(k)}=0$.*

**Proof.** Let $v\in\mathbb R^k$ satisfy $Av=0$ for every $A\in\mathfrak{so}(k)$, and suppose $v\ne0$. Since $k\ge2$ the hyperplane $v^\perp$ is nonzero, so choose $w\in v^\perp$ with $w\ne0$. Put

$$A:=v\,w^{\mathsf T}-w\,v^{\mathsf T},$$

which is skew, hence in $\mathfrak{so}(k)$. Then $Aw=v\lVert w\rVert^2-w\langle v,w\rangle=\lVert w\rVert^2\,v\ne0$, so $A\ne0$; and $Av=v\langle w,v\rangle-w\lVert v\rVert^2=-\lVert v\rVert^2\,w\ne0$, contradicting invariance. Hence $v=0$. $\square$

**The proof is uniform in $k\ge2$ and needs no irreducibility.** That matters at $k=2$, where $\mathfrak{so}(2)$ is abelian and $\mathbb R^2$ is reducible over $\mathbb C$, an argument routed through "the standard representation is a nontrivial irreducible" has a case to check there and at $k=4$, where $\mathfrak{so}(4)$ is not simple. The displayed matrix dodges both.

**The two small $k$, stated positively.**

| $k$ | $\mathfrak{so}(k)$ | $(\mathbb R^k)^{\mathfrak{so}(k)}$ | status of (a) |
|---|---|---|---|
| $0$ | $0$ | $0$, the whole space being $0$ | **true, and empty of content** |
| $1$ | $0$ | $\mathbb R$, every vector is invariant | **false** |
| $\ge2$ | $\ne0$ | $0$ | **true**, Proposition A |

**So $k=1$ is where (a) is false rather than vacuous**, and $k=1$ is exactly corank $1$. Anything (b) gets there it must get from elsewhere.

## 3. The decomposition, and where $\mathfrak c$ sits in it

Since $x$ is skew, $\operatorname{im}(x)^\perp=\ker(x^{\mathsf T})=\ker(-x)=\ker x$, so $\mathbb R^m=V\oplus K$ **orthogonally**, and $\operatorname{rank}x=2r$ is even with $r\ge1$ because $x\ne0$. Writing every element of $\mathfrak{so}(m)$ in blocks against that splitting, in the order $(V,K)$,

$$\mathfrak{so}(m)\;=\;\underbrace{\mathfrak{so}(V)}_{\Lambda^2V}\;\oplus\;\underbrace{\Big\{\begin{pmatrix}0&C\\-C^{\mathsf T}&0\end{pmatrix}:C\in\operatorname{Hom}(K,V)\Big\}}_{V\otimes K}\;\oplus\;\underbrace{\mathfrak{so}(K)}_{\Lambda^2K},$$

and the three summands are mutually orthogonal for the half-trace pairing, block-diagonal and block-off-diagonal matrices having zero trace against one another. **The middle summand is the mixed one**: it is $\operatorname{Hom}(\ker x,\operatorname{im}x)$, written $V\otimes K$ in the decomposition and $V\wedge K$ at [ROUND_L32](../verification/ROUND_L32.md)'s finding J9. A single $C$ names it, the lower block being $-C^{\mathsf T}$ by skewness.

**Step 3.1, $\mathfrak z(x)$ has no mixed part.** With $x=\begin{pmatrix}x_V&0\\0&0\end{pmatrix}$ and $z=\begin{pmatrix}A&C\\-C^{\mathsf T}&B\end{pmatrix}$,

$$[x,z]=\begin{pmatrix}[x_V,A]&x_VC\\C^{\mathsf T}x_V&0\end{pmatrix}.$$

$x_V$ is invertible on $V$ by construction, so $x_VC=0$ forces $C=0$, and

$$\mathfrak z(x)=\mathfrak z_{\mathfrak{so}(V)}(x_V)\;\oplus\;0\;\oplus\;\mathfrak{so}(K).$$

**Step 3.2, hence $\mathfrak c$ splits.** $x$ lies in the first summand, so $x^\perp\supseteq V\otimes K\oplus\mathfrak{so}(K)$, and

$$\boxed{\ \mathfrak c\;=\;\mathfrak c_V\;\oplus\;0\;\oplus\;\mathfrak{so}(K),\qquad \mathfrak c^\perp\;=\;\mathfrak c_V^{\perp_V}\;\oplus\;(V\otimes K)\;\oplus\;0.\ }$$

**The mixed summand lies entirely inside $\mathfrak c^\perp$.** That is why it can only be killed by the centralising condition, and why no orthogonality argument reaches it, the point three verifiers were circling.

## 4. Part (b), the mixed summand contributes nothing

**Step 4.1, the condition on $C$, decoupled.** For $c=\begin{pmatrix}\alpha&0\\0&\beta\end{pmatrix}\in\mathfrak c$ with $\alpha\in\mathfrak c_V$ and $\beta\in\mathfrak{so}(K)$, and $z$ as above,

$$[c,z]=\begin{pmatrix}[\alpha,A]&\alpha C-C\beta\\ \ast&[\beta,B]\end{pmatrix},\qquad \ast=-(\alpha C-C\beta)^{\mathsf T},$$

so the lower block repeats the upper one and the three summands' conditions are independent. Because $\mathfrak c=\mathfrak c_V\oplus\mathfrak{so}(K)$ is a *direct* sum, $\alpha$ and $\beta$ range independently, and $z\in\mathfrak z(\mathfrak c)$ requires **both**

$$\textbf{(i)}\ \ \alpha C=0\ \ \text{for all }\alpha\in\mathfrak c_V, \qquad\qquad \textbf{(ii)}\ \ C\beta=0\ \ \text{for all }\beta\in\mathfrak{so}(K).$$

Equivalently, **(i)** says $\operatorname{im}C\subseteq\bigcap_{\alpha\in\mathfrak c_V}\ker\alpha$, and **(ii)** says $\ker C\supseteq\sum_{\beta\in\mathfrak{so}(K)}\operatorname{im}\beta$. *Either one alone can force $C=0$, and which one does depends on the corank.*

**Step 4.2, (ii) is exactly part (a), and settles $k\ge2$.** For skew $\beta$, $C\beta=0\iff\beta C^{\mathsf T}=0$, so (ii) says every column of $C^{\mathsf T}$, that is, **every row of $C$, read as a vector of $K$**, is an invariant vector of the standard representation of $\mathfrak{so}(K)$. Proposition A gives $C=0$ whenever $k\ge2$. *This is the record's named route, and it is correct on its own range.*

**Step 4.3, the fact that does the work at $k\le1$: $\mathfrak c_V$ has trivial common kernel when $r\ge2$.**

**Proposition B.** *Let $x_V\in\mathfrak{so}(V)$ be invertible with $\dim V=2r$ and $r\ge2$. Then $\bigcap_{\alpha\in\mathfrak c_V}\ker\alpha=0$.*

**Proof.** Split $V=P_1\oplus\dots\oplus P_r$ into the orthogonal coordinate $2$-planes of $x_V$, with $\varphi_i$ the unit bivector of $P_i$ and $x_V=\sum_ia_i\varphi_i$; **every $a_i\ne0$, because $V$ is the image of $x$ and $x_V$ is invertible on it.** The torus $\mathfrak t_V=\operatorname{span}\{\varphi_1,\dots,\varphi_r\}$ is abelian and contains $x_V$, so $\mathfrak t_V\subseteq\mathfrak z_{\mathfrak{so}(V)}(x_V)$ and therefore

$$\mathfrak c_V\;\supseteq\;\mathfrak t_V\cap x_V^{\perp}\;=\;\{\textstyle\sum_it_i\varphi_i:\ \sum_it_ia_i=0\}\;\cong\;a^\perp,$$

the identification using that $\{\varphi_i\}$ is orthonormal for the half-trace pairing. It suffices to kill the common kernel of $a^\perp$. An element $t=\sum_it_i\varphi_i$ acts on $P_i$ as $t_i$ times a rotation generator, so $\ker t=\bigoplus_{i:\,t_i=0}P_i$, and a vector $v=\sum_iv_i$ lies in every such kernel exactly when, for each $i$ with $v_i\ne0$, the coordinate functional $t\mapsto t_i$ vanishes identically on $a^\perp$. A coordinate functional vanishes on the hyperplane $a^\perp$ iff $e_i$ is proportional to $a$; with every $a_j\ne0$ and $r\ge2$ that never happens. Hence $v=0$. $\square$

**Proposition B is sharp at $r$.** At $r=1$ we have $\mathfrak{so}(V)=\mathbb R x_V$, so $\mathfrak c_V=0$ and the common kernel is all of $V$, condition (i) is then vacuous, not merely weak.

**Step 4.4, the case split closes, and it closes exactly on $m\ne3$.**

| $k=\dim\ker x$ | $r$ | what forces $C=0$ |
|---|---|---|
| $0$ | any $r\ge1$ | **nothing to force**, $\operatorname{Hom}(K,V)=0$, the mixed summand is absent |
| $1$ | $r\ge2$ | **(i) with Proposition B**, (a) is silent here, $\mathfrak{so}(1)=0$ |
| $1$ | $r=1$ | **neither**, and this is $m=2r+1=3$ |
| $\ge2$ | any $r\ge1$ | **(ii) with Proposition A** |

**Theorem (b).** *Let $m\ne3$ and let $x\in\mathfrak{so}(m)$ be nonzero, $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then every $z\in\mathfrak z(\mathfrak c)$ has vanishing component in $\operatorname{Hom}(\ker x,\operatorname{im}x)$; in particular the mixed summand contributes nothing to $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$.*

**Proof.** The table exhausts the possibilities, $r\ge1$ holding because $x\ne0$. The only row that fails to produce $C=0$ is $(k,r)=(1,1)$, which is $m=3$ and is excluded. $\square$

**And $m=3$ really is a failure of (b), not just of L32's conclusion.** At $x=\varphi_{12}\in\mathfrak{so}(3)$: $\mathfrak c_V=0$ and $\mathfrak{so}(K)=\mathfrak{so}(1)=0$, so $\mathfrak c=0$, $\mathfrak z(\mathfrak c)=\mathfrak{so}(3)$ and $\mathfrak c^\perp=\mathfrak{so}(3)$. The mixed summand $\operatorname{Hom}(K,V)=\operatorname{span}\{\varphi_{13},\varphi_{23}\}$ lies wholly inside $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ and **supplies two of that space's three dimensions**. So the hypothesis of (b) is sharp, and it is the same $m\ne3$ L32 already carries, *the owed line needs no hypothesis the statement does not already have.*

## 5. What (b) actually buys, the degenerate branch becomes an identity

**Corollary.** *For $m\ne3$ and $x\ne0$,*

$$\mathfrak z_{\mathfrak{so}(m)}(\mathfrak c)\cap\mathfrak c^\perp\;=\;\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\cap\mathfrak c_V^{\perp_V}.$$

**Proof.** Take $z=(A,C,B)\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$. Theorem (b) gives $C=0$. The $\mathfrak{so}(K)$ block of §4.1 gives $B\in\mathfrak z(\mathfrak{so}(K))$, but $\mathfrak{so}(K)\subseteq\mathfrak c$ by §3.2 while $z\perp\mathfrak c$, so $B=0$ outright, *no centre computation is needed, which is what saves the case $k=2$ where $\mathfrak z(\mathfrak{so}(2))=\mathfrak{so}(2)\ne0$.* The $\mathfrak{so}(V)$ block reads $A\in\mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)$, and $z\perp\mathfrak c$ restricted to that summand reads $A\perp_V\mathfrak c_V$. Conversely any such $A$, extended by $C=0,B=0$, commutes with $\mathfrak{so}(K)$ because the blocks are disjoint, and is orthogonal to $\mathfrak c$. $\square$

**This is the degenerate branch, in the form it was owed.** L32's one sentence, *"for $x$ of lower rank the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$"*, asserts a resemblance; the Corollary is an equality, and it reduces every corank to the invertible problem on $V$, where the block's root-line argument applies with $a$ having no zero coordinate by construction. **The clause the block offers is one of the two ingredients (it is (ii)) and is empty at $k=1$, where (i) carries the case instead.**

Two consequences worth having on the record, both immediate:

- **$r=1$ at any $m\ne3$ gives $\mathbb Rx$.** Then $\mathfrak c_V=0$ and $\mathfrak z_{\mathfrak{so}(V)}(0)\cap 0^{\perp_V}=\mathfrak{so}(V)=\mathbb R x_V=\mathbb Rx$, since $\dim V=2$. *So a simple bivector padded into any $\mathfrak{so}(m)$ needs no root argument at all*, the case [conventions.md](../findings/conventions.md) flags as making the second reading of $p$ false.
- **The exception is $r=2$ with $a\propto(1,1)$, at every corank.** There $\mathfrak z_{\mathfrak{so}(V)}(x_V)=\mathfrak u(2)$ of dimension $4$, $\mathfrak c_V=\mathfrak u(2)\cap x_V^{\perp_V}$ is the $\mathfrak{su}(2)$ that is one of the two chiral ideals of $\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$ (the one *not* containing $x_V$) and its centraliser in $\mathfrak{so}(4)$ is the other ideal, which is also its orthocomplement. So the answer is that ideal: a $3$-dimensional $\mathfrak{su}(2)$, containing $x$. **The Corollary is what makes this a statement about $x$ of rank $4$ in any $\mathfrak{so}(m)$ rather than about $\mathfrak{so}(4)$**, which is the content of the block's *"a rank-$4$ complex structure padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"*.

## 6. Every corank, at both parities, checked by hand

$m=2r+k$ with $\dim V=2r$, so **$k$ and $m$ have the same parity**; corank $0$ and $2$ live at even $m$, corank $1$ and $3$ at odd $m$. Nothing below was computed.

| corank $k$ | $m$ | which fact kills $C$ | (b) | worked instance |
|---|---|---|---|---|
| $0$ | even, $\ge2$ | mixed summand is $0$ | **holds, vacuously** | $x=\varphi_{12}+\varphi_{34}$ in $\mathfrak{so}(4)$: $K=0$; answer $\Lambda^2_+$, the exception |
| $1$, $r=1$ | $3$ | **neither** | **fails** | $x=\varphi_{12}$ in $\mathfrak{so}(3)$: mixed part gives $2$ of the $3$ dimensions |
| $1$, $r=2$ | $5$ | (i), Proposition B | holds | $x=\varphi_{12}+\varphi_{34}$ in $\mathfrak{so}(5)$: $a^\perp=\mathbb R(\varphi_1-\varphi_2)$ is invertible on $V$; answer $\Lambda^2_+$, **the exception is live at $m=5$ under the maximal-rank reading** |
| $1$, $r\ge3$ | odd, $\ge7$ | (i), Proposition B | holds | $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ in $\mathfrak{so}(7)$: $a=(1,2,3)$ is on no coordinate axis; answer $\mathbb Rx$ |
| $2$ | even, $\ge4$ | (ii), Proposition A at $k=2$ | holds | $x=\varphi_{12}$ in $\mathfrak{so}(4)$: $\mathfrak{so}(2)$ acts on $K$ with trivial kernel; answer $\mathbb Rx$ |
| $\ge3$ | either | (ii), Proposition A | holds | $x=\varphi_{12}$ in $\mathfrak{so}(6)$: $\mathfrak c=\mathfrak{so}(4)$, answer $\mathbb R\varphi_{12}=\mathbb Rx$ |

**Two rows are the ones the record's account misses.** The $(1,r\ge2)$ rows are carried by Proposition B alone, the record's named fact is silent there, $\mathfrak{so}(1)=0$. And the $k=2$ row is where a centre computation would have to be made and is not, the orthogonality of §5 doing it instead.

**The refuted corank-$1$ reading is not rebuilt anywhere above.** Proposition B settles corank $1$ from the common kernel of the torus slice, and never asks whether a root of $B_p$ is proportional to $a$; the $m=7$ row agrees with [ROUND_L32](../verification/ROUND_L32.md)'s adjudication that that instance closes at $\mathbb Rx$.

## 7. What would falsify each part, and what I did to look for it

**Part (a) falsifies** on a single nonzero $v\in\mathbb R^k$, $k\ge2$, annihilated by all of $\mathfrak{so}(k)$. The proof exhibits an annihilator's own killer explicitly, so a falsifier would have to be a $k\ge2$ at which $v^\perp=0$, impossible by dimension. **I looked at the two places a uniform proof usually breaks**: $k=2$, where $\mathfrak{so}(2)$ is abelian and the representation is $\mathbb C$-reducible, and $k=4$, where $\mathfrak{so}(4)$ is not simple. Both pass, because the displayed matrix $v\,w^{\mathsf T}-w\,v^{\mathsf T}$ needs neither property. **The genuine boundary is $k=1$**, where (a) is *false* ($\mathbb R$ is entirely invariant) and I state it that way rather than as vacuity, since a reader who records it as vacuous will believe it extends.

**Part (b) falsifies** on a triple $(m,x,z)$ with $m\ne3$, $x\ne0$, $z\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ and mixed component $C\ne0$. By §4.1 such a $C$ must satisfy (i) and (ii) simultaneously, so **a falsifier needs both $\bigcap_{\alpha\in\mathfrak c_V}\ker\alpha\ne0$ and $\mathfrak{so}(K)$ acting with a common invariant vector**, that is $r=1$ and $k\le1$ together, hence $m\in\{2,3\}$, and $m=2$ has no mixed summand. **I hunted the falsifier where the two facts are individually weakest**: at $k=1$, where (ii) is empty, and at $r=1$, where (i) is empty. Each such point survives on the *other* fact, and the single point where both are empty is $m=3$, which I then confirmed by hand is a real failure of (b) and not merely of L32's conclusion, the mixed summand there carrying two of three dimensions. **That $m=3$ is both the unique failure of (b) and L32's own sharp hypothesis is the report's main structural finding.**

**What I did not do.** No sweep over multiplicity patterns, no search over singular-value relations, no evaluation of any kind, [ROUND_L32](../verification/ROUND_L32.md)'s finding J10 records that the Gate 2 sweep which passed L32 covered only the branch that already had a proof, and a second sweep would have covered the same ground. Every case in §6 is a closed-form instance constructed to test a specific row of the §4.4 split, and none of it is offered as evidence for a positive claim; the positive claims are Propositions A and B and the Theorem, each proved from the definitions.

**One thing I could not check and am not claiming.** Whether L32's *maximal-rank* branch is itself correct is outside this brief. The Corollary of §5 reduces every corank to that branch, so **if the root argument on $V$ has a defect, this report hands it every case rather than repairing it**, the reduction is sound either way, but the record should not read §5 as certifying what it reduces to.
