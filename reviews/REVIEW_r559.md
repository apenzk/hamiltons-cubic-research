# Review r559, Lemma L51 (the variation calculus is an identity along a critical orbit)

Reviewer r559, independent adversarial audit. Target: [Lemma L51](../findings/second-order.md#L185), the canonical statement in [second-order.md](../findings/second-order.md). Working from the definitions; the record is treated as unverified.

Analysis only: **no computation was run at all.** Every number below was derived by hand; the machine was used to read the record and to write this file.

## Status

Report opened before any mathematics. Verdicts appended below as they are reached.

## What the block is, and where its proof lives

The block is [second-order.md:185](../findings/second-order.md#L185), *"Lemma L51, the variation calculus is an identity along a critical orbit, the canonical statement"*. **Its Argument is present, inside the block**, and it is a genuine proof rather than a pointer, unlike the three blocks the brief warns about. The same content also appears twice more on the record, at [second-order.md:145](../findings/second-order.md#L145) (the derivation, in running text) and as [post F37](../findings/fence-posts.md#L289), and [results.md:246](../results.md#L246) carries the headline. The four copies agree on the mathematics.

## The rebuild, from the definitions

Everything below is derived from [conventions.md](../findings/conventions.md)'s $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ and the block's own hypotheses, by a route that shares with the block only the idea of differentiating equivariance.

**Setup, and the properties each step consumes.** $P(x)=T(x,x,x)$ with $T$ fully symmetric gives $\nabla P(x)=3\,x\circ x$, so a unit critical point of $P$ on the sphere satisfies $x\circ x=\theta x$ with $\theta=P(W)$, this is the block's $Q(W)=\theta W$, since $Q$ quadratic homogeneous makes $X\circ X=\tfrac12(Q(2X)-2Q(X))=Q(X)$. *Consumes: total symmetry of $T$ (for $\nabla P=3x\circ x$), $\lVert W\rVert=1$ (for $\theta=P(W)$).*

**Equivariance is derived, not assumed.** $P$ is $G$-invariant and $G$ acts orthogonally, so polarising $P$ gives $T(gx,gy,gz)=T(x,y,z)$, and orthogonality then gives $g(x\circ y)=(gx)\circ(gy)$, hence $Q(gx)=gQ(x)$. *Consumes: invariance of $P$, orthogonality of the action, characteristic zero for the polarisation. **Compactness of $G$ is never used**, it buys the orthogonal action, which is a separate hypothesis here, so the statement holds for any Lie group acting orthogonally and fixing $P$.*

**The two identities.** With $\gamma(t)=e^{tX}\!\cdot\!W$, $z=\dot\gamma(0)$, $u=\ddot\gamma(0)$, the curve satisfies $\gamma\circ\gamma=\theta\gamma$ identically. Differentiating once: $2W\circ z=\theta z$, i.e. $L_Wz=\tfrac\theta2z$. Twice: $2\,z\circ z+2L_Wu=\theta u$, i.e. $Bu=z\circ z$ with $B=\tfrac\theta2-L_W$. **Both reproduce the block exactly.** *Consumes: equivariance and criticality alone, no maximality, no positivity of $\theta$, no self-adjointness.*

**$z\perp W$**, since $X$ acts skew-symmetrically (derivative of a one-parameter orthogonal group), so $\langle X\!\cdot\!W,W\rangle=0$. Hence the orbit tangent lies in $\ker B\cap W^\perp=A(\tfrac12)$. *Consumes: orthogonality of the action.*

**$T(z,z,z)=0$ and the fusion rule.** $\langle z\circ z,y\rangle=\langle Bu,y\rangle=\langle u,By\rangle=0$ for $y\in\ker B$; take $y=z$ for the first and $y\in A(\tfrac12)$ for the second. *Consumes: $B=B^{\mathsf T}$, which is $\langle L_Wx,y\rangle=T(W,x,y)=\langle x,L_Wy\rangle$, i.e. the total symmetry of $T$, a stated hypothesis of this block, and legitimately available (see D5).*

**The jet, rederived without the block's algebra.** For $x(t)=W+tz+\tfrac{t^2}2w$ with $\lVert z\rVert=1$, $z\perp W$, and $w$ **allowed a radial part** $c=\langle w,W\rangle$:

$$[t^4]\,P(x/\lvert x\rvert)\;=\;-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac94\theta c(1+c)-\tfrac92(1+c)\langle L_Wz,z\rangle+\tfrac{15}8\theta(1+c)^2 .$$

More usefully, in the two specialisations the block uses. At $z\in A(\tfrac12)$ and $w\perp W$ it collapses to $-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$, **the block's formula, confirmed**. At $w=0$ and general $z$ it is $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$, **the block's "geodesic quartic", also confirmed as an identity**, though its name is wrong (D3). I checked the $c$-dependence independently: with $z\in A(\tfrac12)$ the correct coefficient is $-\tfrac38\theta(1+c)^2$, and the whole expression is then invariant under $w\mapsto w+cW$, as it must be since rescaling the curve cannot change a degree-zero function's jet. That invariance is a nontrivial cross-check on the printed formula and it passes.

**The supremum is $0$, and the arithmetic behind it.** For $w\perp W$ put $b=\Pi(z\circ z)$, $\Pi$ the orthogonal projection onto $W^\perp$. Then $\langle z\circ z,w\rangle=\langle b,w\rangle$ and $F(w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle b,w\rangle-\tfrac{3\theta}8$, stationary at $Bw=b$, with value $\tfrac34\langle b,B^+b\rangle-\tfrac38\theta$ there, so "supremum $0$" and "$\langle b,B^+b\rangle=\theta/2$" are the same statement, as the block says. The orbit supplies the solution: $\Pi$ applied to $Bu=z\circ z$ gives $B(\Pi u)=b$, because $B$ preserves $\mathbb RW\oplus W^\perp$. The $W$-components match too, $\langle z\circ z,W\rangle=T(z,z,W)=\langle L_Wz,z\rangle=\tfrac\theta2$ against $\langle Bu,W\rangle=\langle u,BW\rangle=-\tfrac\theta2\langle u,W\rangle=+\tfrac\theta2\lVert z\rVert^2$, using $\langle X^2W,W\rangle=-\lVert XW\rVert^2$. **The identity $Bu=z\circ z$ is therefore internally consistent in both components**, which is the strongest single check I ran on it.

**Verdict on the mathematics: CONFIRMED.** Both displayed identities, all three of the first consequences, and the fourth-order value are correct as stated, by a derivation independent of the block's.

## Defects

### D1, "$B\succeq0$" is unsatisfiable as written. CONFIRMED.

$L_WW=W\circ W=Q(W)=\theta W$, so $BW=\tfrac\theta2W-\theta W=-\tfrac\theta2W$. Under the Statement's own hypothesis $\theta>0$, **$B$ has a strictly negative eigenvalue in the direction $W$ at every critical point**, so the guard "where $B\succeq0$" names the empty set and the fourth clause is vacuously true rather than the theorem it is meant to be. The only reading that makes it a theorem is $B\vert_{W^\perp}\succeq0$.

- **The record's own Gate 2 source had it right and the write-up lost it.** [REVIEW_r287.md:58](REVIEW_r287.md#L58) writes *"With $B=\tfrac\theta2-L_W\succeq0$ **on $W^\perp$**"*, and the earlier running text of the file, at [second-order.md:133](../findings/second-order.md#L133), also states the min over $W^\perp$. The canonical Statement dropped the qualification.
- **The $\Pi$ in the Argument does carry the restriction**, since the stationarity condition is posed over $w\perp W$ and $\Pi$ is the projection onto $W^\perp$, so the Argument is right and only the Statement is wrong.
- **Where it propagates:** [second-order.md:147](../findings/second-order.md#L147), [second-order.md:195](../findings/second-order.md#L195), [results.md:706](../results.md#L706), [fence-posts.md:297](../findings/fence-posts.md#L297), four copies, all unqualified. The three-row table at [second-order.md:173](../findings/second-order.md#L173) has a column headed "$B\succeq0$" whose entries are computed on $W^\perp$ ($-9.5\times10^{-16}$ at $S^3\times S^3$), so the data are right and only the heading is loose.

**Repair:** write $B\vert_{W^\perp}\succeq0$ in all four places, or equivalently $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$.

### D2, three load-bearing symbols with no definition on the record, one of them colliding with a different object in the same file. CONFIRMED.

$\Pi$, $b$ and $B^+$ carry the fourth-order clause and **none is defined anywhere in [findings/](../findings/) or [results.md](../results.md)**. From [REVIEW_r287.md:58](REVIEW_r287.md#L58) and [REVIEW_r287.md:75](REVIEW_r287.md#L75) they are: $\Pi=P_{W^\perp}$, $b=\Pi(z\circ z)$, $B^+$ the Moore–Penrose pseudo-inverse. The definitions stayed in the review and never reached the record.

**And $b$ collides inside its own file.** [second-order.md:103](../findings/second-order.md#L103) defines $b=\langle W^{\#}W,W\rangle$, a **scalar**, and uses it in the third-moment formula; [second-order.md:147](../findings/second-order.md#L147) uses $b$ as a **vector** in $\langle b,B^+b\rangle$, forty-four lines below. This is the same class as the $B$, $M$ and $\mu$ collisions [conventions.md](../findings/conventions.md) already tables, and it is live.

### D3, "the geodesic quartic" is not the geodesic quartic. CONFIRMED, and harmless where used.

The block asserts at [second-order.md:141](../findings/second-order.md#L141) and again in the canonical block that *"the geodesic quartic is $-\tfrac92\langle L_Wz,z\rangle+\tfrac{15}8\theta$"*. Along the actual geodesic (the great circle $\gamma(\tau)=W\cos\tau+z\sin\tau$, unit $z\perp W$), the coefficient is

$$[\tau^4]\,P(\gamma)\;=\;\tfrac78\theta-\tfrac52\langle L_Wz,z\rangle ,$$

by $\cos^3\tau=\tfrac{3\cos\tau+\cos3\tau}4$ and $3\cos\tau\sin^2\tau=\tfrac34\cos\tau-\tfrac34\cos3\tau$. The printed expression is instead $[t^4]$ in the **chordal** parameter of $x(t)=W+tz$, whose normalisation traces the same great circle at $t=\tan\tau$. The two differ by exactly $2\langle Bz,z\rangle$, which the reparametrisation reproduces: $[\tau^4]=[t^4]+\tfrac23[t^2]$ and $[t^2]=-3\langle Bz,z\rangle$.

**So the number the block uses is right.** On the null cone $\langle Bz,z\rangle=0$ (the only place the block evaluates it), both readings give $-\tfrac{3\theta}8$, and the claim *"on the whole null cone, not only on eigenvectors"* is correct. The defect is the name: a consumer who takes the printed formula as the geodesic coefficient **off** the cone is wrong by $2\langle Bz,z\rangle$. I found no consumer that does.

**Repair:** call it the quartic coefficient along $x(t)=W+tz$, or print the great-circle form.

### D4, "satisfied by $u$" should be "$\Pi u$". CONFIRMED, presentational.

The jet's display is stated for $w\perp W$, and $\langle u,W\rangle=\langle X^2W,W\rangle=-\lVert XW\rVert^2=-\lVert z\rVert^2\ne0$, so $u$ is outside the domain of the expression it is offered to. The true statement is $B(\Pi u)=\Pi(z\circ z)$, from applying $\Pi$ to $Bu=z\circ z$ and using that $B$ preserves $\mathbb RW\oplus W^\perp$. [REVIEW_r287.md:75](REVIEW_r287.md#L75) states it in the correct form. This matters because the printed quartic is **not** invariant under $w\mapsto w+cW$ (the invariant expression carries $-\tfrac38\theta(1+c)^2$ in place of $-\tfrac38\theta$) so substituting $u$ into the printed display gives the wrong number by $-\tfrac38\theta$, while substituting $\Pi u$ gives $0$.

### D5, the fusion rule's use of self-adjointness is available and is stated. CONFIRMED SOUND.

$B=B^{\mathsf T}$ is immediate from the Statement's own hypothesis that $T$ is fully symmetric: $\langle L_Wx,y\rangle=T(W,x,y)=T(W,y,x)=\langle x,L_Wy\rangle$. The Argument says *"since $B$ is self-adjoint"*, so the use is visible. **The brief's contrast with [Lemma L66](../findings/support-dichotomy.md) no longer holds**: that file now states the same use explicitly (*"That step uses the **total** symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$"*), with the reduction to $\nabla P=3Q$ spelled out. Both blocks are in order on this point.

### D6, "None of this uses maximality" is TRUE, and the record under-claims what is proved. CONFIRMED, with a strengthening.

The brief asks whether the guard "$B\succeq0$" is what maximality buys, so that the sentence covers only the first three conclusions. Two independent answers, both saying no.

**(a) The guard is strictly weaker than maximality, by a witness computable by hand.** Take $V=\mathbb R^2$ and $P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ with $\alpha\ne0$, so $T_{111}=1$, $T_{122}=\tfrac12$, $T_{222}=\alpha$. At $W=(1,0)$: $\nabla P(W)=(3,0)$, so $W$ is a unit critical point with $\theta=P(W)=1$; $L_W=(T_{1jk})=\mathop{\mathrm{diag}}(1,\tfrac12)$, so $B\vert_{W^\perp}=\tfrac12-\tfrac12=0\succeq0$. Yet $P(\cos t,\sin t)=1+\alpha t^3+O(t^4)$, so $W$ is **not** a local maximum. So $B\vert_{W^\perp}\succeq0$ is the second-order necessary condition and nothing more, exactly [Lemma L24](../results.md)'s conclusion, which is necessary at a maximiser and not sufficient. The record carries the same separation at a real point: [second-order.md:173](../findings/second-order.md#L173)'s table gives $S^3\times S^3$ as $B\succeq0$ and not a local maximum, the third order killing it.

**Provenance of the witness.** At $\alpha=0$ this is the cubic [plan-maximizer.md](plan-maximizer.md) already carries as a fence post, where $(1,0)$ *is* the global maximum and the excess is $1$; the $\alpha y^3$ term is what separates the guard from maximality, and it is what makes the point a non-maximum while leaving $B\vert_{W^\perp}=0$ untouched.

**(b) The equality needs no guard at all.** $\langle b,B^+b\rangle=\theta/2$ on the orbit tangent follows from three facts, none of them positivity: $B(\Pi u)=b$; $b\perp\ker B$, which is the fusion rule already proved; and $[t^4]=0$ along the orbit, since $P$ is constant there. Hence $\langle b,B^+b\rangle=\langle b,\Pi u\rangle=\theta/2$ at **every** critical point with $\theta\ne0$. What $B\vert_{W^\perp}\succeq0$ buys is only the right to call the stationary value a *supremum* rather than a saddle value of the quadratic $F$.

**Consequence for the record.** [results.md:246](../results.md#L246)'s headline, *"forces the third-order condition, the fusion rule and the fourth-order inequality to hold **with equality** on the orbit tangent, with no maximality hypothesis"*, carries **no guard and is correct**, and is a sharper statement than the canonical block's guarded one. The two copies should be reconciled in the headline's direction: state the equality unconditionally, and attach $B\vert_{W^\perp}\succeq0$ only to the word *supremum*.

**No consumer takes the fourth clause outside its hypothesis.** [second-order.md:169](../findings/second-order.md#L169) explicitly declines to apply it at the $C_5$ blow-up *"the derivation assumes $B\succeq0$, which fails there"*; [second-order.md:181](../findings/second-order.md#L181) uses only the equality; [routes.md:24](../routes.md#L24), [plan.md:216](../plan.md#L216) and [fence-posts.md:195](../findings/fence-posts.md#L195) use the negative conclusion alone; [07-gradedness-split.tex:510](../report/sections/07-gradedness-split.tex#L510) uses only the $\tfrac12$-inclusion. **And every consumer instantiates $G=O(n)$ on $\mathcal W_n$, where $P$ is $O(n)$-invariant and $T$ is fully symmetric** by [Lemma L24](../findings/second-order.md#L50)'s argument, so both hypotheses of the abstract statement are discharged on the record.

### D7, "already a theorem at every one of those points" holds at three of the four. CONFIRMED defect, minor.

The scope note says *"Excess $=0$ is Morse–Bott nondegeneracy, already a theorem at every one of those points"*, the points being $S^4\times S^4$, $S^6\times S^6$, $S^5\times S^7$ and padded $W_{\mathbb{CP}^2}$ at $n=8,10,12$.

- **The identification is correct.** $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12)=-6B$ on $W^\perp$, so $\ker\mathrm{Hess}=A(\tfrac12)$ and excess $0$ is $\ker\mathrm{Hess}=T_W\mathcal O$, which is Morse–Bott nondegeneracy. Needs $\theta\ne0$.
- **The three sphere products are covered by a theorem**: [Lemma L27](../findings/nondegeneracy.md#L457) takes $p,q\ge3$ with $(p,q)\ne(3,3)$, and $(4,4)$, $(6,6)$, $(5,7)$ all qualify. L27 carries Gate 2 verdicts CONFIRMED from [r529](REVIEW_r529.md) and [r530](REVIEW_r530.md).
- **Padded $W_{\mathbb{CP}^2}$ is not covered by any theorem on the record.** [Lemma L28](../findings/nondegeneracy.md#L504) is the $\mathbb{CP}^m$ family at **$m\ge3$** inside $\mathrm{Weyl}_{2m}$; padded $W_{\mathbb{CP}^2}$ is $m=2$ and is a padding, so it falls outside the statement twice over. What the record has is a **measurement**, [nondegeneracy.md](../findings/nondegeneracy.md)'s RESULT 1, Reviewers 111 and 112, at $n=6,8,10$, and it does not reach $n=12$, which the scope note lists.

**Repair:** *"a theorem at the sphere products by [Lemma L27](../findings/nondegeneracy.md#L457), and measured at padded $W_{\mathbb{CP}^2}$"*. The negative conclusion of the block is unaffected: it needs only that the points on record carry excess $0$, however that is known.

### D8, adjacent to the block: one orbit dimension quoted for three dimensions. CONFIRMED defect, outside L51.

[second-order.md:243](../findings/second-order.md#L243) says padded $W_{\mathbb{CP}^2}$ *"is Morse–Bott nondegenerate at $n=8,10,12$ ($\dim E(\tfrac12)=\dim(\text{orbit})=18$)"*. The stabiliser of the padded tensor in $O(n)$ is $\mathrm{Stab}_{O(4)}(W_{\mathbb{CP}^2})\times O(n-4)$, a $g$ fixing $W$ preserves $\mathop{\mathrm{im}}W=\Lambda^+\subset\Lambda^2\mathbb R^4$ and hence $\mathbb R^4$, and $\mathrm{Stab}_{O(4)}$ is $\mathfrak u(2)$, of dimension $4$. So

$$\dim\mathcal O=\binom n2-4-\binom{n-4}2=4n-14,$$

giving $10,\,18,\,26,\,34$ at $n=6,8,10,12$. **The formula reproduces the record's own two independently measured values** ($10$ at $n=6$ and $18$ at $n=8$, both from RESULT 1) so $18$ is the $n=8$ entry alone and the parenthetical is wrong at $n=10$ and $n=12$. The excess-$0$ claim itself is untouched; only the printed dimension is.

### D9, a small gain the block's own number yields and the record states more weakly.

Along an orbit direction the second- and third-order coefficients vanish unconditionally, so at a **local** maximum the fourth must satisfy $-\tfrac38\theta\le0$, i.e. $\theta\ge0$. Since $\mathcal W_n$ carries no $O(n)$-invariant vector the orbit tangent is never zero, so **no critical point of $P$ with $\theta<0$ is a local maximum**. [Lemma L24](../findings/second-order.md#L50)'s Scope reaches this only for the *global* maximiser, by $P$ odd and $\max_SP\ge\sqrt{3/2}$, and then hypothesises a local maximiser with $\theta<0$ in the next sentence, a set this argument shows is empty. Offered as an addition, not a defect.

### D10, adjacent: "cancel identically" names the wrong reason. CONFIRMED defect, presentational.

The jet block at [second-order.md:139](../findings/second-order.md#L139) justifies truncating the curve at second order with *"the $t^3$ and $t^4$ terms of $x$ cancel identically between $P(x)$ and $\lvert x\rvert^{-3}$"*. Writing $x(t)=W+tz+\tfrac{t^2}2w+t^3v+\dots$ with $v\perp W$, the $t^3$ term contributes $6\langle L_Wz,v\rangle$ through $P(x)$ and $-3\theta\langle z,v\rangle$ through $\lvert x\rvert^{-3}$, summing to

$$-6\langle Bz,v\rangle ,$$

which vanishes **because $Bz=0$**, not identically. The same fact in coordinate-free form: $z$ is a null vector of $\mathrm{Hess}\,f$ at $W$, so $D^2f_W(z,\cdot)=0$ and no higher term of the curve can reach order $t^4$. The hypothesis $z\in A(\tfrac12)$ is in force in that block, so the conclusion is right; the stated reason would license the truncation for any $z$, and it does not.

## The quantifiers, checked one at a time

| hypothesis | where it is actually used | verdict |
| --- | --- | --- |
| $T$ fully symmetric | $\nabla P=3x\circ x$; $L_W$ self-adjoint, hence $T(z,z,z)=0$ and the fusion rule | **load-bearing** |
| $G$ acts orthogonally | $z\perp W$, and the equivariance of $\circ$ | **load-bearing** |
| $P$ is $G$-invariant | equivariance of $Q$ | **load-bearing** |
| $G$ **compact** | nowhere | **not used**, compactness would buy an invariant inner product, but the orthogonality of the action is hypothesised separately. Any Lie group acting orthogonally and fixing $P$ gives the same conclusions |
| $\theta>0$ | $\ker B\subseteq W^\perp$ and the $A(\tfrac12)$ label need $\theta\ne0$; the *sign* statements ($-\tfrac{3\theta}8<0$, and $B\succeq0$ being a restriction to $W^\perp$) need $\theta>0$ | **needed for the fourth clause and its sign, stronger than the first three need** |
| $W$ a critical point | both identities | **load-bearing** |
| maximality | nowhere | **not used**, and the block is right to say so, see D6 |

**Every critical point, then, and not only maximisers**, and the first three conclusions hold at $\theta<0$ as well, with $A(\tfrac12)$ read as $\ker B\cap W^\perp$. The block's closing paragraph asserts strictness "at $\theta>0$" and correctly flags the $\theta<0$ branch as the decisive one; that branch is where D9 lives.

## The norm

The block is abstract (a Euclidean space, $\lVert W\rVert=1$) and every identity in it is invariant under rescaling the inner product, since $\circ$ is defined from $T$ through that same pairing. Instantiated in $\mathcal W_n$ it inherits [conventions.md](../findings/conventions.md)'s pairing, under which $P(W)=\langle W,Q(W)\rangle$ and $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ are the record's own definitions, so $\langle X\circ Y,Z\rangle=T(X,Y,Z)$ holds with the record's $\tfrac12$-at-$\Lambda^2$ convention and no conversion is needed. **The block quotes no number that depends on the normalisation**, its only figures are the excess integers and the ratios $\lambda_{\max}/\theta$, both scale-free, so the $\sqrt2$ trap [conventions.md](../findings/conventions.md) warns of cannot reach it. No defect.

## The attribution

| claim in the block | source, read | verdict |
| --- | --- | --- |
| KT Proposition 6.6 is the second-order statement, and is this record's [Lemma L24](../results.md) | [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md) quotes 6.6 verbatim: $\sigma(c)\subset(-\infty,\tfrac12]$ with $1$ simple, for an extremal idempotent | **correct** |
| KT Proposition 6.7 is the third-order statement, the fusion rule | quoted verbatim: $\langle z^2;z\rangle=0$ for $z\in A_c(\tfrac12)$, i.e. $A_c(\tfrac12)A_c(\tfrac12)\subset A_c(\tfrac12)^\perp$ | **correct** |
| the fourth-derivative remark accompanies 6.7 and prints $\ge0$ | the notes record exactly that, with the warning to check the sign convention | **correct** |
| the sign is settled: $\partial^4f/\partial z^4\vert_c=-9\theta\lvert c\rvert^{-4}<0$ | **rederived here**: $f$ is degree-zero, so $f(c+sz)=f(W+\theta sz)$ with $\lvert c\rvert=1/\theta$; then $\partial_s^4=\theta^4\cdot4!\cdot(-\tfrac38\theta)=-9\theta^5=-9\theta\lvert c\rvert^{-4}$ | **correct, and now independently confirmed** |
| the identity $Bu=z\circ z$, the exact jet and the vacuity are new | KT's propositions are stated at an *extremal* idempotent; the orbit identity holds at every critical point and is not in the quoted material | **plausible and consistent with the notes** |

The block also credits Gate 2 to two reviewers on identical briefs. [REVIEW_r287.md](REVIEW_r287.md) is one of them and its content matches, including, as D1 and D4 record, two qualifications sharper than the ones that reached the record.

## Verdicts

| id | claim | verdict |
| --- | --- | --- |
| (| $L_Wz=\tfrac\theta2z$ and $Bu=z\circ z$ | **CONFIRMED**), rederived independently, and internally consistent in both the $W$ and $W^\perp$ components |
|, | orbit tangent $\subseteq A(\tfrac12)$; $T(z,z,z)=0$; the fusion rule | **CONFIRMED** |
|, | the jet $[t^3]=T(z,z,z)$, $[t^4]=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8$ | **CONFIRMED**, reproduced from scratch, including the radial-invariance check the printed form does not display |
|, | the fourth-order supremum is $0$, i.e. $\langle b,B^+b\rangle=\theta/2$ | **CONFIRMED**, and the equality is unconditional (D6) |
|, | "None of this uses maximality" | **CONFIRMED**, with the guard shown strictly weaker than maximality by a hand witness |
| (| the negative conclusion: a route must consume excess | **CONFIRMED**), with excess $0$, $A(\tfrac12)$ *is* the orbit tangent and every conclusion is an identity |
| D1 | the guard "$B\succeq0$" unqualified | **CONFIRMED defect**, unsatisfiable at $\theta>0$; must read $B\vert_{W^\perp}\succeq0$; four copies |
| D2 | $\Pi$, $b$, $B^+$ undefined; $b$ collides with a scalar in the same file | **CONFIRMED defect** |
| D3 | "the geodesic quartic" | **CONFIRMED defect, presentational**, the value used is right; the name is right only on the null cone |
| D4 | "satisfied by $u$" | **CONFIRMED defect, presentational**, the stationary corrector is $\Pi u$ |
| D5 | the fusion rule's self-adjointness | **CONFIRMED SOUND**, and the brief's contrast with [Lemma L66](../findings/support-dichotomy.md) is stale, that block now states the same use |
| D6 | the guard versus maximality | **CONFIRMED**, block under-claims |
| D7 | "already a theorem at every one of those points" | **CONFIRMED defect, minor**, a theorem at the three sphere products ([Lemma L27](../findings/nondegeneracy.md#L457)), a measurement at padded $W_{\mathbb{CP}^2}$, and the measurement does not reach $n=12$ |
| D8 | $\dim(\text{orbit})=18$ at $n=8,10,12$ | **CONFIRMED defect, adjacent**, the orbit is $4n-14$, so $18,26,34$ |
| D9 | no local maximum has $\theta<0$ | **addition**, not a defect |
| D10 | "cancel identically" | **CONFIRMED defect, presentational, adjacent**, the truncation is licensed by $Bz=0$, not by an identity |

**Overall: CONFIRMED.** The mathematics of Lemma L51 is correct and its proof is present, complete and independently reproducible. Every defect found is in the statement of a hypothesis or in a name, and none of them moves a number the record uses. The two that should be fixed before the next citation are **D1** (a guard that names the empty set, in four places) and **D2**, three undefined symbols carrying the fourth-order clause. Both repairs are one line each, and both were already correct in [REVIEW_r287.md](REVIEW_r287.md), the Gate 2 report the block is written from.

*Analysis only: no computation was run. Every number in this report was derived by hand, and each was checked a second time by an independent route, the great-circle quartic against the chordal one by reparametrisation and again on the explicit cubic $P(x,y)=x^3$, the orbit dimension against the record's own measured $10$ at $n=6$ and $18$ at $n=8$, and the identity $Bu=z\circ z$ against its own $W$-component.*
