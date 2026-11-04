# The isotropy cap, and the rank-3 question

$S=0$ makes $\mathfrak m$ isotropic for the Cartan 3-form, capping $\dim\mathfrak m$ at $\lfloor n^2/4\rfloor$ - a continuous Mantel theorem - plus the B0 rank-3 answer.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open.

---

### The geometric content of $S=0$: $\mathfrak m$ is isotropic for the Cartan 3-form

#### $S=0$ says exactly that $\langle[u,v],w\rangle=0$ for all $u,v,w$ in the negative eigenspace

that $\mathfrak m$ is *isotropic for the Cartan 3-form* $\omega(x,y,z)=\langle[x,y],z\rangle$ of $\mathfrak{so}(n)$. This is the channel fence post F17 says an argument must use, since the 3-form sees which eigenvectors bracket into which while the marginals $R_{\alpha\beta}$ only see norms.

*The dimension cap is [Lemma L36](#lemma-l36-s0-caps-the-negative-eigenspace-at-lfloor-n24rfloor-canonical-statement-and-proof) below, Gate 2 landed by [r65](../reviews/INDEX.md) and [r66](../reviews/INDEX.md) independently, by different routes.*

#### Lemma L36, $S=0$ caps the negative eigenspace at $\lfloor n^2/4\rfloor$, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Needed because the residual's non-diagonal half is governed by $\{S=0\}$, and nothing on
record constrained that locus structurally, only value measurements at named points.

**Statement.** Let $\mathfrak m\subseteq\mathfrak{so}(n)$ satisfy $\langle[u,v],w\rangle=0$ for all
$u,v,w\in\mathfrak m$, *isotropic*. **The bridging clause needs two things the statement omitted**: the vanishing quantity is $S_{\mathfrak{mmm}}$, not the analytic slack $S(W)$ that [conventions.md](conventions.md) resolves unsubscripted $S$ to; and $W$ must be **critical**, the decomposition $S=T_1+2T_2+T_3$ being stated at critical points and $S\ge0$ documented as failing off that set. *Under $S_{\mathfrak{mmm}}=0$ the bridge is a one-line tautology; under $S(W)=0$ it needs two further facts and $\ker W=0$.*
Then $\dim\mathfrak m\le\lfloor n^2/4\rfloor$, **with equality attained by the mixed planes
$\mathfrak m\cong\mathbb R^p\otimes\mathbb R^q$ at $p=\lceil n/2\rceil$**, of dimension $pq$, which is
$n^2/4$ at even $n$ and $\frac{n^2-1}4$ at the odd split, so **sharpness holds at both parities**.
Sharp, every $n\ge3$, no genericity hypothesis.

> **THE FIRST VERSION NAMED $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ AS THE MAXIMISER, AND THAT IS FALSE TWICE OVER.** It is $\mathfrak m^\perp$ rather than $\mathfrak m$; its dimension $\frac{n(n-2)}4$ falls short of the cap by $n/2$ at every $n$, $6$ against $9$ at $n=6$; and **it is not admissible at all**, since an isotropic subalgebra is abelian, and at $n=6$ already $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1\ne0$ inside the first $\mathfrak{so}(3)$. It also left odd $n$ with a maximiser that does not exist there, which the mixed planes supply. *This file states the correct object 190 lines below.*
>
> **AND THE "EQUIVALENTLY" WAS A CONVERSE, NOT A RESTATEMENT.** Every $S=0$ negative eigenspace is isotropic; **the reverse fails at $n=3$**, where $\dim\mathcal W_3=0$ so no Weyl operator has a negative eigenspace, while isotropic $2$-planes in $\mathfrak{so}(3)$ exist and meet the cap. *Gate 2, [r517](../reviews/REVIEW_r517.md) and [r518](../reviews/REVIEW_r518.md) on identical briefs, both REFUTED as stated, agreeing on both witnesses; the cap itself each re-derived from scratch.*

**Proof.** Write $\mu(\mathfrak m)=\sum_{a,b}\|[e_a,e_b]\|^2$ over an orthonormal basis, $d=\dim\mathfrak m$,
and $\gamma$ for the $\mathfrak h\mathfrak h\mathfrak m$ mass, the failure of $\mathfrak m^\perp$ to be a
subalgebra, a sum of squares and so $\ge0$ by inspection. *Naming $\gamma$ here is what makes the next step
an argument: read instead as the residual $2(n-2)d-2\mu$, the identity is a tautology and $\gamma\ge0$
restates the conclusion.* Isotropy is consumed by the **identity**, not by the inequality: it makes $\lVert P^\perp[e_a,e_b]\rVert^2=\lVert[e_a,e_b]\rVert^2$, and then
$\mu\le(n-2)d$ follows from the Killing block identity $2\mu+\gamma=2(n-2)d$, which is **[Lemma L153](bounds.md)** summed over the $d$ rows of $\mathfrak m$. And
**every** $d$-dimensional subspace satisfies $\mu\ge4d^2/n-2d$, because $\mu=\langle T(P),P\rangle$
with $P$ the orthogonal projection onto $\mathfrak m$ and
$T(A)=-\sum_k\mathrm{ad}(f_k)\,A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$, whose
spectrum on $\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$, **at $n\ge4$; at $n=3$ the $\mathrm{Weyl}$ summand is absent and the least eigenvalue is $n-4=-1$, which only strengthens the cap to $d\le2=\lfloor9/4\rfloor$**, is
$2n-4,\ n-4,\ -2,\ 4$. Chaining the two gives $4d^2/n-2d\le(n-2)d$, i.e. $d\le n^2/4$. $\square$

**The whole content is one eigenvalue**, and it is the Weyl space's: $-2$ is $T$'s only negative
eigenvalue, and its eigenspace is exactly $\mathrm{Weyl}_n$, multiplicities $10,35,84,168$ at
$n=4,\dots,7$.

**It is Mantel's theorem in continuous form.** In the $\varphi_{ij}$ basis the Cartan 3-form is
supported exactly on the triangles of $K_n$, so a coordinate subspace is isotropic precisely when its
graph is triangle-free; $\lfloor n^2/4\rfloor$ with the complete bipartite extremiser is then Mantel,
and the content of the lemma is that no non-coordinate subspace beats it.

**What it does not reach.** Equality forces $\gamma=0$, hence $\mathfrak m^\perp$ a subalgebra, hence a
symmetric pair, and Cartan then leaves only the balanced split, but that argument is complete only
for **even** $n$; odd $n$ needs $\gamma=0$ forced at $d=(n^2-1)/4$ and is open. Gate 2 passed by two
reviewers on identical briefs who proved the bound independently, one representation-theoretically and
one by centraliser induction.

#### It is the continuous analogue of Mantel's theorem

On coordinate subspaces isotropy *is* triangle-freeness of the corresponding graph (checked exhaustively over all $2^N$ coordinate subspaces at $n=4,5,6$ with zero mismatches) so $\lfloor n^2/4\rfloor$ with the complete bipartite extremiser is exactly the symmetric pair. The theorem's content is that no non-coordinate subspace beats Mantel.

#### The proof, in two steps (Reviewer 65's route)

*Step 1*: isotropy gives $\mu(\mathfrak m)=\sum_{a,b}\|[e_a,e_b]\|^2\le(n-2)d$, which is the Killing block identity $2\mu+\gamma=2(n-2)d$ with $\gamma\ge0$, **[Lemma L153](bounds.md)** summed over the $d$ rows of $\mathfrak m$. *Step 2*: **every** $d$-dimensional subspace has $\mu\ge4d^2/n-2d$, because $\mu=\langle T(P),P\rangle$ for $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)=2(n-2)\mathrm{Id}-\tfrac12\mathrm{Cas}$. Chaining, $4d^2/n-2d\le(n-2)d$ gives $d\le n^2/4$. $\square$

#### The whole content is one eigenvalue

$T$ acts on $\mathrm{Sym}(\mathfrak{so}(n))=\mathbb R\oplus\mathrm{Sym}^2_0\oplus\mathrm{Weyl}_n\oplus\Lambda^4$ by $2n-4$, $n-4$, $-2$, $4$, verified here with multiplicities matching to the digit at $n=4,5,6,7$, the $-2$ eigenspace having dimension $10,35,84,168=\dim\mathrm{Weyl}_n$. **So the Weyl tensors are exactly the $-2$ eigenspace of $T$**, and $-2$ being its only negative eigenvalue **at $n\ge4$** is what the cap rests on. *At $n=3$ that is false ($\mathcal W_3=0$ there and the least eigenvalue is $-1$ on $S^2_0$) and the cap survives, that eigenvalue giving $d\le2=\lfloor9/4\rfloor$.*

#### Lemma L32, a bivector's centraliser collapses to a line, canonical statement and proof

*Machine-checked as repaired: `L32` and `L32_exception` in [L32.lean](../lean/HamiltonsCubic/Results/L32.lean), from L81's proof. The exception is typed as its dimension, $3$; its identification with an $\mathfrak{su}(2)$ is by reading.*

> **REFUTED AS STATED: A HYPOTHESIS IS MISSING.** *[r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md), independently, with the same witness.* Take $x=e_{12}$ in $\mathfrak{so}(3)$: then $\mathfrak c=\mathfrak z(x)\cap x^\perp=\{0\}$, so $\mathfrak z(\mathfrak c)=\mathfrak{so}(3)$ and $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ is all of $\mathfrak{so}(3)$, of dimension $3$ rather than the line $\mathbb Rx$. **The stated exception does not cover it**, $\mathfrak{so}(3)$ has no $4$-plane, so $x$ is no complex structure on one.

> **WHAT IT NEEDS IS $m\ne3$**, which is sharp; $\mathfrak c\ne0$ is sound and conservative by one case, the two parting at $m=2$. *The one use on the record, in [stratum-two-negative.md](stratum-two-negative.md), is **checked and holds unconditionally at every $m\ge4$**, since $\mathcal W_m=0$ below that.*

*Moved here from [results.md](../results.md) on 2026-08-31. **The claim once made here, that results.md held the only copy, is false against the commit before the move**: this file already carried a block for this result.*

Needed because the two defining conditions of a Weyl tensor, taken together, constrain the *centralisers*
of its eigenvectors rather than their eigenvalues, and that constrains anything only if the centraliser of
a centraliser is small.

**Statement.** Let $m\ne3$, let $x\in\mathfrak{so}(m)$ be nonzero and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then
$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$, except when $x$ is a multiple of a complex
structure on a $4$-dimensional subspace, where it is a $3$-dimensional $\mathfrak{su}(2)$.

**$m\ne3$ is the sharp hypothesis.** From $\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2$, the failure $\mathfrak c=0$ happens exactly at $m\in\{2,3\}$ with $\mathop{\mathrm{rank}}x=2$, *and at $m=2$ the conclusion holds*, $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathfrak{so}(2)=\mathbb Rx$. **So $\mathfrak c\ne0$ is sound and conservative by one case**, and the unrestricted form is false. *At $m=3$ the answer is itself a $3$-dimensional $\mathfrak{su}(2)$, so the witness disagrees with the exception's trigger rather than its value, which is why it was easy to miss.*

**Proof, for $x$ of maximal rank.** Let $\mathfrak t$ be the maximal torus spanned by $x$'s $p=\lfloor m/2\rfloor$ coordinate
$2$-planes and $a=(a_1,\dots,a_p)$ its singular values, **all nonzero, which is what maximal rank means, and which covers $\mathop{\mathrm{corank}}0$ at even $m$ and $\mathop{\mathrm{corank}}1$ at odd $m$ alike.** Then $\mathfrak t\subseteq\mathfrak z(x)$,
so $\mathfrak c\supseteq\mathfrak t\cap x^\perp=a^\perp$, and therefore

$$\mathfrak z(\mathfrak c)\ \subseteq\ \mathfrak z(a^\perp)\ =\ \mathfrak t\oplus\bigoplus\{\mathfrak g_\beta:\beta\propto a\}.$$

**Every root of $\mathfrak{so}(m)$ has at least $p-2$ zero coordinates** ($\pm e_i\pm e_j$ at either parity, and the short roots $\pm e_i$ at odd $m$, which have $p-1$) while $a$ has none. For $p\ge3$
that forces $\mathfrak z(\mathfrak c)\subseteq\mathfrak t$, whence
$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\subseteq\mathfrak t\cap(a^\perp)^\perp=\mathbb Rx$. **The short roots are excluded by the same hypothesis as the long ones**, so odd $m$ needs no separate treatment at maximal rank. For
$p=2$ the roots have no zero coordinate and $a\propto(1,1)$ is admissible, exactly the complex-structure
case, where the answer is $\Lambda^2_+$, of dimension $3$. **$p=1$ is $m\in\{2,3\}$: at $m=2$ the conclusion holds and at $m=3$ it fails, which is the hypothesis.** For $x$ of lower rank the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$
additionally centralising $\mathfrak{so}(\ker x)$, **which is nonzero exactly when $\dim\ker x\ge2$.** $\square$

#### Lemma L160, the mixed summand dies, and every corank reduces to the maximal-rank branch

*Derived to discharge the one step [L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof) owed, which three verifiers named and none wrote. **Gate 2, two reviewers on identical briefs**, [REVIEW_I41a](../reviews/REVIEW_I41a.md) and [REVIEW_I41b](../reviews/REVIEW_I41b.md), agreeing on every case and each reaching the corank-$1$ correction independently.*

> **LEMMA L160.** *Let $x\in\mathfrak{so}(m)$ be nonzero, $V=\mathop{\mathrm{im}}x$, $K=\ker x$, and $\mathfrak c=\mathfrak z(x)\cap x^\perp$. Then the mixed summand $\mathop{\mathrm{Hom}}(K,V)$ contributes nothing to $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ **if and only if $m\ne3$**, and*
> $$\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp\ =\ \mathfrak z_{\mathfrak{so}(V)}(\mathfrak c_V)\cap\mathfrak c_V^{\perp_V}.$$

**The two conditions on the mixed block decouple.** Writing a candidate $z$'s mixed component as $C\in\mathop{\mathrm{Hom}}(K,V)$, centralising $\mathfrak c=\mathfrak c_V\oplus\mathfrak{so}(K)$ forces $\alpha C=0$ for every $\alpha\in\mathfrak c_V$ **and** $C\beta=0$ for every $\beta\in\mathfrak{so}(K)$, independently. **They are killed by two different facts, and the record's owed line named only one of them.**

**At $k=\dim K\ge2$ the second condition suffices**, each row of $C$ being an $\mathfrak{so}(K)$-invariant vector of the standard representation, of which there are none: *if $u\ne0$ were invariant, take nonzero $w\in u^\perp$ and $uw^{\mathsf T}-wu^{\mathsf T}$ sends $u$ to $-\lVert u\rVert^2w\ne0$.* **That consumes exactly one hypothesis, $u^\perp\ne0$, so it is true at $k\ge2$, vacuous at $k=0$, and FALSE at $k=1$**, which is why recording it as vacuous there would invite a reader to extend it.

**At $k=1$ the first condition carries it**, and needs a fact about $\mathfrak c_V$ rather than about $K$: **$\mathfrak c_V$ has trivial common kernel on $V$ exactly when $\mathop{\mathrm{rank}}x\ge4$.** *This is the case the record's owed line could not reach, and it is the case [L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof) was thought to fail at.*

**The two are jointly empty only at $(r,k)=(1,1)$, which is $m=3$**, where the mixed part supplies both of the two dimensions beyond $\mathbb Rx$, recovering [r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md)'s witness. **So the owed step's sharp hypothesis and [L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof)'s are the same hypothesis, $m\ne3$**, and neither is inherited from the other.

**What this buys beyond closing the hole.** The displayed identity turns L32's one-sentence degenerate branch into a **reduction of every corank onto the maximal-rank branch**, rather than a resemblance to it. *Two corollaries fall out free*: at $r=1$ the answer is $\mathbb Rx$ at every $m\ne3$ **with no root argument at all**, and the $\mathfrak{su}(2)$ exception is exactly $r=2$ with $a\propto(1,1)$, **at every corank**. **And the short-root question disappears**: after the reduction the surviving algebra is $\mathfrak{so}(V)$, type $D_r$, at *both* parities of $m$, so no $B_p$ root is ever in play, *the sentence about short roots in the branch above is true and now unnecessary.*

**What the $\mathfrak{so}(\ker x)$ clause actually does.** L32's branch offers it as centralising a term; that term lies inside $\mathfrak c$ and dies against $\mathfrak c^\perp$ at every $k$. **Its real service is killing the mixed part at $k\ge2$**, a different job from the advertised one, and no job at all at $k=1$. $\square$

*Machine-checked: `L160` in [L160.lean](../lean/HamiltonsCubic/Results/L160.lean) proves the iff at every $m$, with `L160_support` placing $\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$ inside $\mathfrak{so}(V)$ at $m\ne3$ and `cc_three` giving $\mathfrak c=0$ at every nonzero $x\in\mathfrak{so}(3)$. The displayed identity at $m\ne3$ is `L160_identity` in [L160Identity.lean](../lean/HamiltonsCubic/Results/L160Identity.lean).*

*This lemma certifies the reduction and not what it reduces to: whether the maximal-rank root argument is itself sound is [L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof)'s own question, and this hands it every case.*

**Scope, stated.** The criterion is the singular-value vector being proportional to a **long** root $\pm e_i\pm e_j$, which is
*rank $4$ with equal singular values*, so **maximal rank is sufficient and not necessary at $m\ge6$**. *The claim fails at $m=4$; at $m=5$ it is vacuous, no skew matrix on $\mathbb R^5$ being invertible, which is why "nondegenerate" must be read as maximal rank throughout and not as invertible.* And the
degenerate case is not vacuous: a rank-$4$ complex structure padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$
returns $3$ every time. Gate 2 passed, both reviewers independently, at all $29$ multiplicity partitions to
$m=12$ and at $m=14,16$ on the hard patterns, under adversarial singular-value relations. The two reviewers
disagreed on whether a case split on the number of blocks is needed; it is not, and the disagreement was
settled by checking $\mathfrak t\cap x^\perp\subseteq\mathfrak c$ directly at every pattern.


#### Lemma L77, under isotropy, $\gamma=2S_{\mathfrak{mhh}}$, so $\gamma=0$ iff $\mathfrak m^\perp$ is a subalgebra

*Gate 2, [r609](../reviews/REVIEW_r609.md) and [r610](../reviews/REVIEW_r610.md) on identical briefs, **both REFUTED as stated and both for the same reason: the statement omitted the hypothesis it needs**. The mathematics is right; everything the rigidity chain draws from it survives.*

> **ISOTROPY IS A HYPOTHESIS, NOT A SETTING, AND WITHOUT IT BOTH HALVES FAIL.** In general the identity carries a second term in $S_{\mathfrak{mmm}}$, which isotropy kills. **Two independent hand witnesses, in three and four dimensions.** At $n=3$ with $\mathfrak m=\mathfrak{so}(3)$, $\mathfrak h=\{0\}$ **is** a subalgebra while $\gamma=-6$. At $n=4$ with $\mathfrak m=\mathfrak{so}(3)$, $d=3$: $\mu=6$ and $\gamma=0$, yet $S_{\mathfrak{mhh}}=3$ and $\mathfrak m^\perp=\mathop{\mathrm{span}}(\varphi_{14},\varphi_{24},\varphi_{34})$ **is not a subalgebra**. *`git` shows the identity was recorded unconditional in 2026-08, that Reviewer 67 filed exactly this correction the same day into another file, and that the numbered heading was retrofitted ten days later still unconditional, **L77 has no statement-and-proof block of its own, which is why the hypothesis had nowhere to land**.*

> **THE TWO REVIEWERS DISAGREE ON THE FACTOR, AND THE SECOND DIAGNOSES WHY.** [r609](../reviews/REVIEW_r609.md) derives $\gamma=S_{\mathfrak{mhh}}$ and reads the $2$ as a defect, noting [Lemma L36](isotropy-cap.md) 138 lines above writes $2\mu+\gamma=2(n-2)d$ **incompatibly with the factor and correctly**. [r610](../reviews/REVIEW_r610.md) derives $\gamma=2S_{\mathfrak{mhh}}-6S_{\mathfrak{mmm}}$ and traces the discrepancy to **a live cross-file normalisation collision in $S_{XYZ}$, which [conventions.md](conventions.md) does not carry**: [bounds-relaxations.md](bounds-relaxations.md) counts *unordered* triples, giving $\gamma=2S_{\mathfrak{mhh}}$, while [nondegeneracy.md](nondegeneracy.md) counts *ordered* slots, giving $\gamma=S_{\mathfrak{mhh}}$. **Each rule is right in its own reading and false in the other's.** r610 settles which is which by the padded $W_{\mathbb{CP}^2}$, where $\gamma=4n-16$: bounds-relaxations' series $4,8,12,16$ is $\gamma/2$ and nondegeneracy's $8$ at $n=6$ is $\gamma$ itself. **Fixing $S_{XYZ}$ in [conventions.md](conventions.md) is what closes this, and it is owed.**

> **THE LOAD-BEARING ARROW HOLDS, AND THE BLOCK NEVER SAYS WHY.** The brief's suspicion (a $\mathbb Z_2$-grading needs *three* bracket relations while only two masses are killed), **resolves in the block's favour, and both reviewers reached it independently**: by total antisymmetry of $c$, $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$ is *the same* structure constants as $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$. **Two conditions, both directions, "exactly" earned.**

> **THE ISOTYPIC TABLE IS A CLOSED FORM PRESENTED AS A MEASUREMENT.** $\lVert P_0\rVert^2=d-d^2/N$ and $\lVert P_s\rVert^2=\frac{d(n^2-4d)}{n(n-2)}$ reproduce **every** entry exactly, and *"at even $n$ the traceless part lies entirely in $\mathrm{Weyl}_n$"* is a **theorem** (Ricci row sums are constant iff $p=q$), derivable at every even $n$, where the table offers one even row. The exact slack is $\gamma=\frac{2d(n^2-4d)}n-2(n-2)\lVert P_s\rVert^2-12\lVert P_\lambda\rVert^2$.

> **THE ODD-$n$ DEBT, SHARPENED, AND IT IS HARDER THAN THE EVEN CASE.** What is owed is not an inequality but an **equality to be forced**: $\gamma=0\iff(n-2)\lVert P_s\rVert^2+6\lVert P_\lambda\rVert^2=\frac{n^2-1}{4n}$. Equivalently, no isotropic $\mathfrak m$ at the odd cap carries a $\mathrm{Sym}^2_0$ component above $d/(n(n-2))$, **an extremal question about $P_0$'s isotypic profile rather than about $\gamma$.**

> **THE CARTAN GAP IS CLOSED AND $n=8$ IS UNAFFECTED.** DIII is on the list and was never eliminated; the triality extras have $\dim\mathfrak m=7,15\ne16$, so the cap dimension is a singleton orbit and inner-ness with dimension bridges $\mathrm{Aut}(\mathfrak g)$ to $SO(n)$-conjugacy. *The record already proves this in [INDEX-traps.md](INDEX-traps.md) and [bounds.md](bounds.md), cited from neither.*

> **SMALLER DEFECTS.** The $\gamma$-allowance $(n^2-1)/(2n)$ is attached below to $S_{\mathfrak{mhh}}$, which is half it. $\mathfrak h=\mathfrak m^\perp$ is assumed here and contradicted by [conventions.md](conventions.md), where $\mathfrak h=E_{\max}$. **The parity gloss is false**: $\theta_0(n)$ is non-integral at *every* $n$, since $n^2-6n+4=0$ has no integer root, so the stated asymmetry does not exist. And the $10^{-14}$ measurement re-measures the known case, isotropic subspaces at the cap being conjugate to the symmetric pair where $\gamma=0$ is a theorem.

#### The odd-$n$ gap, stated sharply

Rigidity at the cap follows from $\gamma=0$, where $\gamma=2(n-2)d-2\mu$ and $\mu=\sum_{a,b}\|[e_a,e_b]\|^2$. Chaining the two lemmas gives $\gamma\le2d(n^2-4d)/n$: at even $n$ the cap $d=n^2/4$ makes this **zero**, forcing $\gamma=0$; at odd $n$, $d=(n^2-1)/4$ leaves $n^2-4d=1$ and the allowance $(n^2-1)/(2n)$, $2.4$ at $n=5$, $3.4286$ at $n=7$. **Measured, $\gamma=0$ anyway**: at the cap the symmetric pair $((n-1)/2,(n+1)/2)$ has $\mu=(n-2)d$ exactly ($18=3\cdot6$ at $n=5$, $60=5\cdot12$ at $n=7$) and ten random isotropic subspaces at each give $|\gamma|\le3\times10^{-14}$. *And $\gamma=0$ is not automatic from isotropy*: below the cap it is strictly positive, at $n=6$, $\mu=0.94,2.77,6.49$ at $d=2,3,4$ against $(n-2)d=8,12,16$, so it is a genuine equality condition rather than an identity. **And $\gamma$ has a structural meaning, which makes the whole chain legible.** The Killing marginal gives $\mu+X=2(n-2)d$ with $X$ the $\mathfrak m$-to-$\mathfrak m^\perp$ bracket mass, so $\gamma=X-\mu$; counting triples by type gives $\mu=2S_{\mathfrak{mmh}}$ and $X=2S_{\mathfrak{mmh}}+2S_{\mathfrak{mhh}}$, whence

$$\gamma=2S_{\mathfrak{mhh}},\qquad\text{so}\qquad \gamma=0\iff[\mathfrak h,\mathfrak h]\subseteq\mathfrak h\iff\mathfrak m^\perp\ \text{is a subalgebra}.$$

Verified where it discriminates rather than only where both sides vanish: on isotropic subspaces below the cap both sides are large and agree, $18.8959$ and $19.9337$ at $n=6$, $d=3,4$, to $10^{-14}$ and $10^{-10}$, while on random **non**-isotropic subspaces it correctly fails ($14.20$ against $16.84$), the discrepancy being the $S_{\mathfrak{mmm}}$ that isotropy kills. *Checking it only at the symmetric pairs would have proved nothing: both sides are zero there.*

#### So the rigidity chain reads: isotropy kills $S_{\mathfrak{mmm}}$, the cap kills $S_{\mathfrak{mhh}}$, and the two together are exactly a $\mathbb Z_2$-grading

hence a symmetric pair, hence Cartan's list, hence the balanced split. **What is owed for odd $n$ is that the cap forces $S_{\mathfrak{mhh}}=0$ there too**, where the counting allows it to be as large as $(n^2-1)/(2n)$.

#### And the parity split has a visible cause

Step 2's bound is tight exactly when $P_0=P-\tfrac dN\mathrm{Id}$ lies in the $-2$ eigenspace, which is $\mathrm{Weyl}_n$. Decomposing $P_0$ isotypically at the cap:

| $n$ | $d$ | $\|P_0\|^2$ | $\mathrm{Sym}^2_0$ | $\mathrm{Weyl}_n$ | $\Lambda^4$ |
|---|---|---|---|---|---|
| $5$ | $6$ | $2.4000$ | $0.4000$ | $2.0000$ | $0$ |
| $6$ | $9$ | $3.6000$ | $\mathbf 0$ | $3.6000$ | $0$ |
| $7$ | $12$ | $5.1429$ | $0.3429$ | $4.8000$ | $0$ |
| $9$ | $20$ | $8.8889$ | $0.3175$ | $8.5714$ | $0$ |

At even $n$ the traceless part lies **entirely in $\mathrm{Weyl}_n$**, so Step 2 is tight and $\gamma=0$ is forced. At odd $n$ a small $\mathrm{Sym}^2_0$ component survives, sitting at eigenvalue $n-4>-2$, and that is precisely the slack: $\mu$ exceeds the Lemma-2 bound by exactly its contribution. The $\Lambda^4$ component vanishes at both parities. **So the odd-$n$ debt is to show that $\mathrm{Sym}^2_0$ component cannot be traded for a larger $\mathfrak m$**, the unbalanced split $\big(\tfrac{n-1}2,\tfrac{n+1}2\big)$ cannot be Ricci-isotropic the way a balanced one is, which is the same parity asymmetry that makes $\theta_0(n)$ non-integral at odd $n$.

#### Lemma L78, the residual floor $\alpha\ge(2d/n)(4d-n^2)$ for the 3-form mass at dimension $d$

*Gate 2, [r647](../reviews/REVIEW_r647.md) and [r648](../reviews/REVIEW_r648.md) on identical briefs, **both CONFIRMED the floor as a theorem and both proved the attainment the block only inferred**, reaching the same extremiser independently.*

> **THE FLOOR IS A THEOREM, AT EVERY $d$-SUBSPACE OF $\mathfrak{so}(n)$, $n\ge4$.** It follows from the hypothesis-free block-form Killing identity $\alpha+2S_{\mathfrak{mmh}}+S_{\mathfrak{mhh}}=2(n-2)d$, **which is [L36](isotropy-cap.md)'s own boxed identity with $\alpha$ put back**, together with $\mu\ge4d^2/n-2d$. **No isotropy, no genericity.** *Structurally it is twice the failure of L36's sandwich past the cap.*

> **THE REINTERPRETATION IS NOW A THEOREM, NOT A COINCIDENCE, AND BOTH REVIEWERS FOUND THE SAME MINIMISER.** The floor is attained iff $\gamma=P_s=P_\lambda=0$ jointly, and at $n=5$ the extremiser is **the orthocomplement of the principal $\mathfrak{so}(3)\subset\mathfrak{so}(5)$**, the $V_7$ isotypic piece of $\Lambda^2V_5$, of dimension $7$, giving $\alpha=42/5=8.4$ **exactly**. *Equality holds because $\mathop{\mathrm{Sym}}^2_0(\mathbb R^5)=V_9\oplus V_5$ and $\Lambda^4\mathbb R^5\cong V_5$ carry no trivial summand; the three $\mathfrak{su}(2)$ classes in $\mathfrak{so}(5)$ give $8.4$, $18$ and $30$, so the principal one is the unique minimiser.* **Floor plus matching point is a certificate: the search did find the true global minimum, and that is now proved rather than inferred.** The general criterion is $\mathfrak h$ a subalgebra with $(\mathop{\mathrm{Sym}}^2_0\mathbb R^n)^{\mathfrak h}=(\Lambda^4\mathbb R^n)^{\mathfrak h}=0$.

> **THE COMPANION FIGURE $16.6$ IS CERTIFIED BY NOTHING, AND THE BLOCK PAIRS IT WITH $8.4$ AS THOUGH IT WERE.** At $n=6,d=10$ the floor is $13.\overline3$, so $16.6$ **exceeds its own floor by $24\%$**, and at $n=6$ the floor is **structurally unattainable**, since a minimiser there would need $\mathfrak m^\perp$ a five-dimensional subalgebra and every such in $\mathfrak{so}(6)$ gives $\alpha=24$. *The source review carried a four-row table marking one row attained and three loose by $24\%$, $58\%$ and $41\%$; **the record kept the headline and dropped the table**.*

> **"SYMMETRIC-PAIR SUBSPACES REALISE $6,9,12,16$" IS FALSE AS QUANTIFIED, AND THIS FILE CONTAINS THE COUNTEREXAMPLES.** DIII $\mathfrak{so}(6)/\mathfrak u(3)$ gives $6$, $\mathfrak{so}(8)/\mathfrak u(4)$ gives $12$, and $\mathfrak{so}(2)\oplus\mathfrak{so}(4)$ gives $8$, **all three stated in this same file.** The repair is the word **balanced**, after which it is a two-line corollary of [L76](isotropy-cap.md). *Two further tightness families exist, $d=N$ at every $n$, and $d=n^2/4$ at even $n$, the second already proved thirteen lines above this heading in the file's own isotypic table.*

> **THE RANGE IS UNSTATED AND THE FLOOR IS VACUOUS BELOW THE CAP**, being negative when $4d<n^2$, *so three of the four $S=0$ points cited as evidence sit where the floor says nothing.* **And $\alpha$ and "3-form mass" are defined nowhere on the record**, recoverable only from inside a review; the value is normalisation-locked, reading $8.4$ in the ordered convention and $1.4$ in the unordered one.

*Provenance: the heading comes from the bulk retrofit that also produced [L75](isotropy-cap.md), [L76](isotropy-cap.md) and [L77](isotropy-cap.md), **the fourth of that commit's headings to be found defective**, here costing the definition and the range rather than a hypothesis. The only place the proof exists is its source review, never cited. Nothing consumes L78, so every repair is free.*

#### A by-product that reinterprets this project's own evidence

The proof yields a residual floor $\alpha\ge(2d/n)(4d-n^2)$ for the 3-form mass at dimension $d$. At $n=5$, $d=7$ it gives **exactly $8.4$**, the value the earlier gradient search stalled at. That search was not stalling; it had found the true global minimum, so the negative evidence was stronger than it was recorded as being.

*Evidence.* Symmetric-pair subspaces realise $6,9,12,16$ at $n=5,6,7,8$, exactly $\lfloor n^2/4\rfloor$ each. Gradient search on the 3-form mass at one dimension higher fails with residual $8.4$ and $16.6$ (not marginal), **and the positive control passes**: the same optimiser from random starts finds an isotropic subspace at $\lfloor n^2/4\rfloor$ itself, residual $\sim10^{-11}$, so the negative is informative rather than a blind search. Every catalogued $S=0$ point respects it: $\dim\mathfrak m$ is $9,20,6,12$ at $S^3\times S^3$, the $C_5$ blow-up, $\mathbb{CP}^3$ and $\mathbb{CP}^4$ against caps $9,25,9,16$. *Located in the literature, late.* The field is **Turán problems for alternating multilinear maps**, [Qiao](https://arxiv.org/abs/2007.12820) and [Chen et al.](https://arxiv.org/abs/2603.00715), after Ol'šanskiĭ, Buhler–Gupta–Harris, Feldman–Propp and Tevelev, whose object is the *isotropy index* $\alpha_\Lambda(F,n,d,m)$, the **minimum** over all alternating $d$-forms of the largest totally-isotropic subspace. **Lemma L36 is the maximum for one distinguished form**, so their theorems bound it from below without giving its value; Chen's Theorem 1.2(b) settles $m=1$ at every order as $\max\{s:s(n-s)\ge\binom sd\}$ with exceptions at $(d,n)=(3,7)$ and $d=n-2$ even. **The earlier sweep missed this because it searched Lie-theoretic vocabulary rather than the vocabulary of the answer**, the cap came out as $\lfloor n^2/4\rfloor$ with the balanced complete-bipartite extremiser, which names extremal graph theory directly, and the coordinate case being Mantel was the signpost.

#### Rigidity at the cap, and it is genuine conjugacy

At $n=6$, dimension $9$: from $30$ random starts, $23$ converge to isotropic subspaces, **all** with the symmetric pair's $\mathfrak m$-Casimir spectrum $(-6)^{\times6},(-4)^{\times9}$ to $10^{-11}$, and matching an invariant is not equivalence, so this was pushed further. Fitting an explicit $g\in SO(6)$ gives $\|\Lambda^2(g)\,P\,\Lambda^2(g)^{\mathsf T}-P_{\rm sym}\|^2\le1.1\times10^{-10}$ on every case tried: **each isotropic subspace at the cap is $SO(6)$-conjugate to $\mathfrak m$ of $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$**, not merely spectrally indistinguishable from it. **At $n=8$ the same holds**: $10$ of $10$ isotropic subspaces found at cap dimension $16$ carry the reference spectrum $(-8)^{\times12},(-6)^{\times16}$, maximum deviation $1.7\times10^{-10}$, and $n=8$ is where triality has already broken one classification in this project, which is why it was run. *The explicit-conjugation check that upgraded $n=6$ beyond spectral matching is still running there.*

#### So item B splits into three, and the shape is two horns rather than a slope

*Corrected*: $\theta$ is **not** monotone in $\dim\mathfrak m$, measured, both ends are high and the low values sit in the middle.

| $\dim\mathfrak m$ | $\theta$ |
|---|---|
| $2$, padded $W_{\mathbb{CP}^2}$ | $\sqrt{3/2}=1.224745$ at **every** $n$ |
| $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$ | low: $0.671$ at the $C_5$ blow-up ($20$ of cap $25$), $1.0560$ and $1.1315$ from ascent at $n=6,8$ |
| $\lfloor n^2/4\rfloor$, balanced product | $\theta_0(n)$: $1.054,\,1.146,\,1.200,\,1.236$ at $n=6,8,10,12$ |

*At the cap* the rigidity forces $\mathfrak m$ onto the symmetric-pair subspace, hence $W$ onto the sphere product and $\theta$ onto $\theta_0(n)$, which **is** Conjecture A's claimed maximum, not a competitor. *At $\dim\mathfrak m\le2$* B0 closes it at $\sqrt{3/2}$. **The open half is the middle**, $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$, where every measured value is low and nothing is proved.

#### And that band does not reduce to the cap case: the Cartan 3-form's maximal isotropic subspaces do not share a dimension

At $n=6$, cap $9$, with the extender validated by construction on sub-subspaces of the symmetric pair (residuals $10^{-10}$ to $10^{-17}$):

#### Lemma L75, maximal isotropy, characterised three ways, the third needs isotropy as a hypothesis

*Gate 2, [r629](../reviews/REVIEW_r629.md) and [r630](../reviews/REVIEW_r630.md) on identical briefs, **both REFUTED as written, agreeing on the break and on the repair**. This audit was opened to settle a dispute between two earlier reviewers; **it resolves as both of them being right about different conditions**, which is why neither could convince the other.*

> **THE CHAIN IS NOT A CHAIN OF EQUIVALENCES, IT BREAKS AT THE SECOND LINK.** $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ **entails isotropy unaided**, since $\mathfrak m\subseteq[\mathfrak m,\mathfrak m]^\perp$ *is* isotropy restated; so the block's choice of the equality form over an inclusion is right, and unexplained. **But $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m$ says only $\dim[\mathfrak m,\mathfrak m]^\perp=\dim\mathfrak m$**, it fixes a dimension and leaves the subspace free. *The repair is asymmetric: only the rank form needs "for isotropic $\mathfrak m$".*

> **WITNESS, BY HAND, IN FOUR DIMENSIONS.** $\mathfrak{so}(3)\subset\mathfrak{so}(4)$: $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$, so $[\mathfrak m,\mathfrak m]=\mathfrak m$ and the rank count holds **exactly**, $3=6-3$, while $\langle[\varphi_{12},\varphi_{13}],\varphi_{23}\rangle=-1$, so $\mathfrak m$ is not isotropic. **The dimension-versus-subspace failure in its purest form.**

> **THE BLOCK'S PROSE CARRIES THE HYPOTHESIS ONE LINE ABOVE THE DISPLAY THAT DROPS IT**, and `git` shows the heading was a bulk retrofit, *the same commit that mislabelled [L76](isotropy-cap.md)*. **Three results in one file, one commit, one failure mode**: [L77](isotropy-cap.md) was repaired for this with the same $n=4$ witness, sixty-seven lines above this heading.

> **THE MISSING HYPOTHESIS IS WHAT THE BLOCK'S OWN RANK-$15$ ARGUMENT USES, FOUR LINES BELOW.** In one line: isotropy gives $r\le N-\dim\mathfrak m=9$, so rank $15$ forces $\mathfrak m=0$. *The detector is the very condition the third form omits.*

> **EVERY ROW OF THE TABLE IS NOW A COROLLARY.** $d=4$ is forced by $d\ge n-1$, **which is not merely implied by $\binom d2\ge N-d$ but equivalent to it**, that clears to $d(d+1)\ge n(n-1)$, holding exactly when $d\ge n-1$, with equality at $d=n-1$ since $(n-1)n=n(n-1)$ identically, so the bound is tight at the value it forces ([IsotropyCap.lean](../lean/HamiltonsCubic/Results/IsotropyCap.lean)); $d=5$ and $d=9$ reproduce under the $(1,5)$ and $(3,3)$ closed forms; and **the last measured row falls too**, $d=6$ at $n=6$ is the odd part of $\mathfrak{so}(6)/\mathfrak u(3)$, type DIII, isotropic by orthogonality of the Cartan decomposition and outside [L76](isotropy-cap.md)'s family since $pq=6$ has no solution with $p+q=6$. **The record already held it 22 lines above the table**, listing $\dim\mathfrak m=6$ at $\mathbb{CP}^3$ and $12$ at $\mathbb{CP}^4$.

> **A GENERAL STATEMENT SUBSUMES BOTH.** For any symmetric $\mathfrak{so}(n)=\mathfrak k\oplus\mathfrak p$ with $[\mathfrak p,\mathfrak p]=\mathfrak k$, the odd part $\mathfrak p$ is maximal isotropic, **subsuming [L76](isotropy-cap.md) and adding DIII**, and giving $\lfloor n/2\rfloor+1$ distinct dimensions at even $n=2m$ with $m$ not a square. *So the varying-dimension claim is a theorem and never needed four rows.* **The list $\{5,6,9\}$ is stale**: at $n=6$ it is $\{5,6,7,8,9\}$, the whole admissible interval $[n-1,\lfloor n^2/4\rfloor]$, with only $d=7$ still numerical.

> **A PUBLISHED NUMBER IS IN THE WRONG PAIRING.** *"Six values of exactly $\sqrt6$"* is $\sqrt3$ under [conventions.md](conventions.md)'s half-trace pairing, and L76's closed form $\sqrt{2p}$ is uniformly $\sqrt2$ high. **Rank is unaffected, so the criterion is immune**, but the figures are not. *And "clean gaps throughout" is overstated: at $d=4$ and $d=5$ the bracket matrix has full column rank, so there is no zero singular value to gap.*

*Provenance clean, and the block's own commit body says "adding $w$ to an **isotropic** $\mathfrak m$", so the hypothesis was lost in the display line and this repair restores it. The Witt comparison is decorative and uncited; the apt parallel is the Lagrangian condition, which is condition 2 itself.*

**and the criterion is exact linear algebra, not an optimiser.** Adding $w$ to an isotropic $\mathfrak m$ needs $\langle[u,v],w\rangle=0$ for all $u,v\in\mathfrak m$, i.e. $w\perp[\mathfrak m,\mathfrak m]$ (linear in $w$) so

$$\mathfrak m\ \text{is maximal}\iff[\mathfrak m,\mathfrak m]^\perp=\mathfrak m\iff\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-\dim\mathfrak m .$$

| $d$ | $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]$ | $N-d$ | free | verdict |
|---|---|---|---|---|
| $4$ | $6$ | $11$ | $5$ | extends |
| $5$ | $10$ | $10$ | $0$ | **maximal** |
| $6$ | $9$ | $9$ | $0$ | **maximal** |
| $9$ (cap) | $6$ | $6$ | $0$ | **maximal** |

with clean singular-value gaps throughout, at $d=6$ the tenth value is $3.5\times10^{-9}$ against a ninth of $0.436$, and at the cap six values of exactly $\sqrt6$ then nothing. *An unpolished run gave rank $15$ at $d=6$, which is impossible for a nonzero isotropic subspace and was the tell that the candidate was not yet isotropic to the tolerance being used; polishing removed it.*

So maximal isotropic subspaces occur at dimensions $5$, $6$ **and** $9$, unlike a quadratic form, where all maximal isotropics share the Witt index. The $d=4$ rows are consistent: they climb into the maximal-$5$ family rather than toward the cap. **Therefore the middle band is not "proper subspaces of a symmetric pair" and cannot inherit the cap rigidity; it needs an argument of its own.**

#### Lemma L76, the odd part $\mathbb R^p\otimes\mathbb R^q$ of every symmetric pair is a maximal isotropic subspace

*Gate 2, [r621](../reviews/REVIEW_r621.md) and [r622](../reviews/REVIEW_r622.md) on identical briefs, **both REFUTED as stated, agreeing exactly on the cause and both proving the intended statement**.*

> **THE HEADING NAMED THE WRONG HALF OF THE PAIR, AND THE OBJECT IT NAMED IS MAXIMAL ISOTROPIC AT NO $(p,q)$ AT ALL.** The refutation is total rather than range-limited. At $\max(p,q)\ge3$ the subalgebra **is not isotropic** (witness $(3,1)$ at $n=4$, where $\langle[\varphi_{12},\varphi_{23}],\varphi_{13}\rangle=1$), *since an isotropic subalgebra is abelian*. At $p,q\le2$ it is isotropic and **extends**, $(2,2)$ at $n=4$ growing by $\varphi_{13}$. **The block's own arithmetic gives it away**: the $(2,4)$ row records $\dim\mathfrak m=8=pq$, while $\binom22+\binom42=7$.

> **THE FILE ALREADY CARRIED THE CORRECTION, 169 LINES ABOVE, APPLIED THE SAME DAY.** [Lemma L36](isotropy-cap.md)'s block states *"an isotropic subalgebra is abelian"* with this exact witness, and **it was never propagated to this heading, its first sentence or its index row**, its closing pointer passes straight through. *The heading itself is a bulk retrofit ten days after the block, so it inherited the mislabel rather than creating it.*

> **THE INTENDED STATEMENT IS TRUE AND BOTH REVIEWERS PROVED IT, SYMBOLICALLY AND AT EVERY $n$.** For all $p,q\ge1$, $K_{p,q}$ is triangle-free so $\omega$ vanishes on $\mathfrak p=\mathbb R^p\otimes\mathbb R^q$; $[\mathfrak p,\mathfrak p]=\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ **exactly**; and that span is $\mathfrak p^\perp$. **The rank identity is then the symbolic $\binom{p+q}2=\binom p2+\binom q2+pq$**, so the recorded verification at $n=6,7,8$ was a spot check on a polynomial identity. *The range is owed: at $q=0$ the claim fails at every $n\ge2$.*

> **THE SINGULAR VALUES ARE A CLOSED FORM, NOT A MEASUREMENT**, $\sqrt{2p}$ with multiplicity $\binom q2$ and $\sqrt{2q}$ with multiplicity $\binom p2$. This reproduces the recorded *"six values of exactly $\sqrt6$"* at the cap and rank $7$ at $(2,4)$, and predicts $\{2^{\times6},2\sqrt2\}$ there. **It is also what identifies the numerics as computed on $\mathfrak p$ rather than on the subalgebra.**

> **THREE RESULTS THE RECORD LACKED, ALL FREE.** *Every maximal isotropic has $d\ge n-1$*, from $N-d\le\binom d2$, which turns [L75](isotropy-cap.md)'s $d=4$ *extends* row into a theorem and brackets the dimensions into $[n-1,\lfloor n^2/4\rfloor]$. *The varying-dimension claim is provable with zero numerics*, at least $\lfloor n/2\rfloor$ distinct dimensions at every $n\ge4$, so it never needed four rows. And **[L75](isotropy-cap.md)'s rank criterion needs isotropy as a hypothesis** ($\mathfrak{so}(3)\subset\mathfrak{so}(4)$ satisfies the rank count and is not isotropic), *the same omission [L77](isotropy-cap.md) was repaired for, forty lines below*; though its **equality** form $[\mathfrak m,\mathfrak m]^\perp=\mathfrak m$ entails isotropy on its own, which is why the block's choice of form is right and unexplained.

*Provenance clean, one of the audit's few. [r66](../reviews/REVIEW_r66.md) wrote "the off-diagonal block of $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$"; the record dropped those five words and the sentence inverted, and the same commit wrote the error into [plan.md](../plan.md).*

#### REFUTED: there is no gap at $8$, and every symmetric pair is maximal

An earlier census of $14$ polished random draws per dimension reported maximal isotropics at $d=5,6,7,9$ and none at $d=8$. That is wrong. By the exact rank criterion, **every** symmetric pair $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ is a maximal isotropic subspace, isotropy residual exactly $0$ and $\mathop{\mathrm{rank}}[\mathfrak m,\mathfrak m]=N-pq$ at every $(p,q)$ for $n=6,7,8$ (Reviewer 66, verified independently here). At $n=6$ the pair $(2,4)$ has $\dim\mathfrak m=8$ and $\mathop{\mathrm{rank}}=7=N-8$: a maximal isotropic of dimension $8$, exactly what the census reported absent.

*Why the census could not have found it.* It sampled **generic** isotropic subspaces, and symmetric-pair subspaces form a measure-zero family, so random search finds them with probability zero. The caveat was written into the record ("these rows describe the generic subspace at each dimension and are not a classification") and the result was nonetheless titled a dimension spectrum. **A caveat in the text does not weaken a claim in the heading.**

*What survives.* The rank criterion itself, and the observation that generic isotropic subspaces at $d=5,6,7$ are maximal, which shows maximal isotropics exist away from the symmetric pairs too, and therefore that the middle band still does not reduce to the cap case. Maximal dimensions now known at $n=6$ include $5$, $6$, $7$, $8$ and $9$.

*A cross-check that failed and is withdrawn.* Comparing the $\mathfrak m$-Casimir spectra of generic isotropic $4$-subspaces against a $400$-sample library of $4$-subspaces *inside* the symmetric pair gave distances $0.14$–$0.23$, read at first as "outside the family". Measuring the null (held-out members that genuinely are in the family), gives median $0.169$ and $90\%$ at or above $0.14$. The observation sits inside the null, so it measured the library's sparsity on a $20$-dimensional Grassmannian and nothing else. The extension evidence above is independent of it. And the two horns cross: $\theta_0(n)$ overtakes $\sqrt{3/2}$ between $n=10$ and $n=12$, at the recorded crossover $n=6+2\sqrt7$, which is why the conjecture holds only from $n=12$.

#### What it gives item B, and what it does not

It caps the number of negative eigenvalues on the whole $S=0$ locus, genuine structural information of a kind no marginal argument supplies. **But it cannot separate**: the balanced sphere product's $\mathfrak m$ *is* the symmetric-pair subspace of $\mathfrak{so}(n/2)\oplus\mathfrak{so}(n/2)$, of dimension exactly $(n/2)^2=\lfloor n^2/4\rfloor$, so the conjectured maximiser attains the cap. The cap therefore narrows the stratum without distinguishing its top point, and any bound built on it needs a second ingredient.

### B0: the rank-3 question is answered, and the statement it stood for is false

#### Bianchi and Ricci-flatness together are one positive-semidefinite identity

Pairing the $\Lambda^4$ condition $\sum_\alpha\lambda_\alpha(v_\alpha\wedge v_\alpha)=0$ against $u\otimes u$ for arbitrary skew $u$ gives $\sum_\alpha\lambda_\alpha[\langle v_\alpha,u\rangle^2-2\mathop{\mathrm{tr}}((v_\alpha u)^2)]=0$, and the term $\mathop{\mathrm{tr}}(u^2v_\alpha^2)$ inside it is annihilated by Ricci-flatness. What remains is an operator identity on $\mathfrak{so}(m)=\Lambda^2$:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W,\qquad\text{equivalently}\qquad \sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\quad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2 .$$

#### Lemma L79, the $\mathcal A$ eigenvalue theorem, $+2$, $-(m-4)$, $-2(m-2)$, $-4$ on $\mathrm{Weyl}_m$, $S^2_0$, $\mathbb R\cdot\mathrm{Id}$, $\Lambda^4$

**The map $\mathcal A(W)=\sum_{g,h}W_{gh}\,\mathrm{ad}(\varphi_g)\mathrm{ad}(\varphi_h)$ is linear and $O(m)$-equivariant *(reading it as $SO(m)$ licenses two scalars on $\Lambda^4$ at $m=8$ and two on $\mathrm{Weyl}$ at $m=4$; [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) says $O(n)$, [r411](../reviews/REVIEW_r411.md), [r412](../reviews/REVIEW_r412.md))*, so Schur makes it a scalar on each summand of $\mathrm{Sym}^2(\Lambda^2)$**, and the four constants are exact (Reviewers 60 and 61):

| summand | $\dim$ | $\mathcal A$ eigenvalue |
|---|---|---|
| $\mathrm{Weyl}_m$ | $m(m+1)(m+2)(m-3)/12$ | $+2$ |
| $S^2_0(\mathbb R^m)$, traceless Ricci | $m(m+1)/2-1$ | $-(m-4)$ |
| $\mathbb R\cdot\mathrm{Id}$ | $1$ | $-2(m-2)$ |
| $\Lambda^4\mathbb R^m$, the Bianchi defect | $\binom m4$ | $-4$ |

**The table holds at every $m\ge3$, and here is the proof the block owed.** $\mathcal A(R)=\sum_gA_gRA_g$, so $\mathcal A=\tfrac12\mathrm{Cas}-2(m-2)\mathrm{Id}$, and the standard Casimir values on the highest weights $0$, $[2]$, $[2,2]$, $[1^4]$ return $-2(m-2)$, $-(m-4)$, $+2$, $-4$ in four lines. *Equivalently $\mathcal A=-T$ for the operator this file already carries $138$ lines above, whose spectrum it lists as **measured**, a complete proof standing above the block that calls the constants \"exact (Reviewers 60 and 61)\", with neither block referencing the other.*

**Two checks the table passes and could not pass by accident.** The four dimensions sum to $\dim S^2(\Lambda^2\mathbb R^m)$ as a polynomial identity, both sides $\tfrac{m(m-1)(m^2-m+2)}8$, so no summand is missing; and $\mathop{\mathrm{tr}}\mathcal A=\sum_{g<h}\lVert[\varphi_g,\varphi_h]\rVert^2=\binom m2(m-2)$ from the Killing marginal matches $\sum\dim\times$eigenvalue identically in $m$. *Gate 2, [r577](../reviews/REVIEW_r577.md) and [r578](../reviews/REVIEW_r578.md).*

**The pairing is load-bearing and must be named.** Under the half-trace of [conventions.md](conventions.md) the constants are as tabled; **under plain Frobenius every one of them halves**, and that factor is exactly where [L131](#lemma-l131-mathcal-a-and-the-sharp-i-map-are-one-operator-mathcal-a-2cdoti)'s $2$ in $\mathcal A=-2(\cdot\#I)$ comes from. *[r471](../reviews/REVIEW_r471.md) recommended this repair and it was not applied.*

**Two eigenvalue collisions, and the block records neither.** At $m=8$, $-(m-4)=-4$ coincides with the $\Lambda^4$ row, so the $-4$ eigenspace is $35+70=105$-dimensional rather than $70$. At $m=4$, $-2(m-2)=-4$ coincides with it instead, and $-(m-4)=0$ gives $\mathcal A$ a $9$-dimensional kernel on $S^2_0$; **worse, $\mathbb R\cdot\mathrm{Id}$ and $\Lambda^4$ are isomorphic $SO(4)$-representations there, so $SO(4)$-Schur licenses *mixing* between them and not merely a second scalar.** *Every consumer uses the forward direction, summand to eigenvalue, so nothing downstream breaks on either.*

So **Bianchi does the structural work and Ricci-flatness only clears the two $\mathrm{Ric}$ terms**: Bianchi alone already gives the classical Weitzenböck form $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$, while **Ricci-flatness alone fails, because $\Lambda^4$ is itself Ricci-flat and carries $-4$** rather than $+2$.

#### The identity is classical and is cited, not claimed

It is the Weitzenböck curvature term on 2-forms, $q(R)\omega=\mathrm{Ric}\circ\omega+\omega\circ\mathrm{Ric}-2\mathring R\omega$, specialised to Ricci-flat $R$, **written here in Bourguignon–Karcher's $ikjl$ order, not Li's $iklj$**, which negates $\mathring R$ and so the sign of the last term; [stratum-two-negative.md](stratum-two-negative.md) runs in the same order and flags it, this passage did not, the specialisation using $\sum_{k,l}R_{ikjl}\omega^{kl}=\tfrac12\sum_{k,l}R_{ijkl}\omega^{kl}$ on skew $\omega$, which is the first Bianchi identity rearranged. **The evaluation belongs to Lichnerowicz and Besse**: $\Delta_Lh=\nabla^*\nabla h-2\mathring Rh+\mathrm{Ric}\circ h+h\circ\mathrm{Ric}$ ([Besse, *Einstein Manifolds*, §1.143](https://link.springer.com/book/10.1007/978-3-540-74311-8)), whose restriction to skew $h$ is the displayed formula. [Petersen–Wink Proposition 1.6](../references/petersen-wink-2019-bochner-technique/notes.md) supplies only the *eigenbasis* rewriting $g(\mathcal R(\hat T),\hat T)=\sum_\alpha\lambda_\alpha|\Xi_\alpha T|^2$ and **does not contain the evaluation $=2W$**, Reviewer 60 established this from the arXiv LaTeX source by counting the shared theorem counter. Cite Besse for the identity and Petersen–Wink for the eigenbasis form.

#### Lemma L80, $N_v\succeq0$, with $\ker N_v=v^\perp\cap\mathfrak z(v)$

> **AUDITED 2026-09-04, BOTH ASSERTIONS CONFIRMED WITH NO HYPOTHESIS AT ALL**, [r471](../reviews/REVIEW_r471.md) and [r472](../reviews/REVIEW_r472.md), independently, for every $v\in\mathfrak{so}(m)$ including $v=0$ and degenerate $v$, on ad-invariance of the pairing alone.

> **ONE STEP OF THE HARDER INCLUSION IS UNSTATED, AND IT IS LOAD-BEARING.** The block computes the **quadratic form**'s null set and writes $\ker N_v$. *Those are the same set only because $N_v$ is self-adjoint and positive semidefinite*, and separately because $\ker\mathrm{ad}(v)^2=\ker\mathrm{ad}(v)$. Both hold; neither is said. **[Lemma L33](stratum-two-negative.md) uses only the easy inclusion, plus the explicit quadratic form**, so the gap is not cosmetic.

> **$\ker N_v$ IS [LEMMA L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof)'S $\mathfrak c$, the same subspace under two names, forty lines apart in this file.** *From $N_vu=2\langle v,u\rangle v-[v,[v,u]]$ the kernel is $\{u:\langle v,u\rangle=0,\ [v,u]=0\}$, which is $v^\perp\cap\mathfrak z(v)$ by definition.* **So L32's repaired hypothesis $\mathfrak c\ne0$ says exactly that $N_v$ is singular.**

> **THE $\mathfrak c\ne0$ GAP IN [L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof) AND [L81](#lemma-l81-the-sharp-centraliser-criterion-requires-mne3) DOES NOT REACH THIS ONE.** *Those two assert a dimension is exactly one and are falsified from below; this asserts a subspace equality, which degenerates gracefully*: at $v=e_{12}\in\mathfrak{so}(3)$, $\mathfrak c=0$ and $N_v$ is positive **definite**, stronger, not broken.

> **THE RECORD UNDERSTATES ITS OWN IDENTITY.** $\sum_\alpha\lambda_\alpha N_{v_\alpha}=0$ splits into two positive semidefinite sums, so the side-intersections of centralisers over the positive and negative eigenvalues are **equal**, not merely one contained in the other, as this file and the [Petersen–Wink notes](../references/petersen-wink-2019-bochner-technique/notes.md) both say. *Nothing downstream is wrong: [Lemma L33](stratum-two-negative.md) uses the weak direction only.*

#### What is new is the splitting

$\mathrm{ad}(v)$ is skew-adjoint on $\mathfrak{so}(m)$ ($\langle u,N_vu\rangle=2\langle v,u\rangle^2+\|[v,u]\|^2$ in one line) so

$$N_v\succeq0,\qquad \ker N_v=v^\perp\cap\mathfrak z(v).$$

The identity is therefore a **balance of positive semidefinite operators between the two halves of the spectrum**, and kernel containment runs from the smaller side to the larger. Neither reviewer found this splitting in the literature.

**Lemma L32 (the centraliser collapse)**, *Superseded by the canonical Lemma L32 block in this file, which carries the full statement and argument.*

#### Lemma L81, the sharp centraliser criterion, REQUIRES $m\ne3$

> **THREE CORRECTIONS TO THE HEADING THAT STOOD HERE.** *Gate 2, [r579](../reviews/REVIEW_r579.md) and [r580](../reviews/REVIEW_r580.md) on identical briefs, each rebuilding the criterion from the definitions, one by isotypic decomposition of $\Lambda^2(V\oplus U)$ on the kernel side with roots only on the support side, the other by a commutant route.* **The criterion is true**: for every nonzero $x\in\mathfrak{so}(m)$, $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)>1$ **iff $x$ is a multiple of a rank-$4$ complex structure**, failing at $m=3$ and nowhere else, the value being always $1$ or $3$.
>
> **(a) The sharp hypothesis is $m\ne3$.** *Both reviewers independently place the only failure at $m=3$; the criterion holds at $m=2$ as well, so the $m\ge4$ form is conservative by that one case, and $m\ge4$ is what $\mathfrak c\ne0$ is equivalent to.* *\"$p\ge2$\" misquotes its own only source*: [r463](../reviews/REVIEW_r463.md) writes *\"$m\ge4$ (equivalently $\mathfrak c\ne0$, equivalently $p\ge2$ **or $\dim\ker x\ge2$**)\"*, and the heading kept the first disjunct and deleted the second, **which is exactly the rank-$2$ range at $m\ge4$ where the criterion holds**, covering $e_{12}\in\mathfrak{so}(6)$. *The hedge \"at $n\ge12$ the hypothesis is free\" is false under the support-rank reading, a simple bivector $e_{ab}\in\mathfrak{so}(12)$ having $p=1$, and empty under the other.* *And $p$ is undefined in this block, carrying two readings (the torus rank $\lfloor m/2\rfloor$ and the support rank $\tfrac12\mathop{\mathrm{rank}}x$) which are different hypotheses, $m\ge4$ against $\mathop{\mathrm{rank}}x\ge4$, with two sentences of the block forcing opposite readings.*
>
> **(b) \"Wider than [Lemma L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof)\" is REFUTED.** L32 states everything this states **and more** (the exact $\mathbb Rx$ and the exact $\mathfrak{su}(2)$) and its own scope paragraph already carries the root criterion and the degenerate case. *The real comparative is \"wider than nondegeneracy\".*
>
> **(c) The imported proof does not reach the conclusion at odd $m$.** Its root step is stated over $D_p$, but $\mathfrak{so}(2p+1)$ is $B_p$ with short roots $\pm e_i$: at $x=e_{12}\in\mathfrak{so}(5)$, $\mathfrak z(\mathfrak a)$ has dimension $4$ where the displayed formula gives $2$. **The degenerate clause names $\mathfrak{so}(\ker x)$ and never uses it, and that is what closes the case.**
>
> **Nothing consumes this lemma.** The apparent count was a raw-string artefact (line anchors of the form `#L81`) and the single use at [stratum-two-negative.md](stratum-two-negative.md) cites **L32**, discharging $\mathfrak c\ne0$ in the same sentence. *So these are repairs to a block a reader might cite, not to mathematics standing on it.*

> **THE SAME GAP AS [LEMMA L32](#lemma-l32-a-bivectors-centraliser-collapses-to-a-line-canonical-statement-and-proof).** *The proof splits on $p\ge3$ and $p=2$ and never treats $p=1$* ([r463](../reviews/REVIEW_r463.md)). At $x=e_{12}\in\mathfrak{so}(3)$ the centraliser $\mathfrak c$ is zero, so $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)=3>1$ **while $x$ is no rank-$4$ complex structure**, $\mathfrak{so}(3)$ has no $4$-plane. **The forward direction of the \"iff\" fails there**, and $p\ge2$ restores it. *At $n\ge12$ the hypothesis is free.*

#### The sharp mechanism, and it is wider than nondegeneracy

$\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)>1$ **iff the singular-value vector is proportional to a root of $D_p$, iff $x$ is a multiple of a rank-4 complex structure**, degenerate $x$ included. At $p=2$ that is compatible with nondegeneracy; at $p\ge3$ it forces a zero singular value. So nondegeneracy at $m\ge6$ is sufficient and not necessary, and a rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time, which is exactly where the semidefinite test below turns feasible. Confirmed at all 26 multiplicity partitions for $m=4,\dots,12$, under adversarial singular-value relations (sum relations, geometric ratios, $10^{12}$ spreads, $10^{-9}$ collisions), by both reviewers independently.

**Lemma L33 (the answer to B0's recorded question, in the sharp form Reviewer 60 supplies)**, *The canonical statement and argument are in [stratum-two-negative.md](stratum-two-negative.md); what stood here was the shorter account.*

#### Gate 2 passed, and by a method the proof does not use

Both reviewers certified Lemma L33 through *convex feasibility* instead of centralisers: with $\hat x$ fixed, existence is the exact program $\exists W\in\mathrm{Weyl}_m$ with $G=W+\hat x\hat x^{\mathsf T}\succeq0$ and $G\hat x=0$. Infeasible at every multiplicity pattern and every singular-value draw at $m=6,8,10,12$, margins $-0.013$ to $-0.14$, **with a feasible degenerate control** (a rank-4 $J$ padded up gives margin $+2\times10^{-11}$) so the test has teeth and nondegeneracy is exactly the hypothesis doing the work. The SDP is *stronger* than the lemma: it allows any number of eigenvalues of the other sign and any rank.

#### $m=4$ is the exception, it is realised, and it explains the failed searches

On $\mathbb R^4$ the self-dual forms are complex structures, and $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ lies in $\mathrm{Weyl}_4$ with signature $(2,1)$ and a full-rank minority eigenvector; its negative is the B0 base-case family at $\theta=+\sqrt{3/2}$, which is also the Weyl part of the Fubini–Study operator at $m=4$. **So the $520$ starts of Reviewers 58 and 59 were hunting an object that does not exist**, and the obstruction is that a singular-value vector can be proportional to a $D_p$ root only when $p\le2$.

#### REFUTED: the statement B0 was reduced to is not the rank-3 question, and it is false

[plan.md](../plan.md) recorded B0 as closing iff *no element of $\mathrm{Weyl}_m$ with $\dim\mathfrak m\le2$ has $\dim U=m$*, and recorded the rank-3 question as an equivalent form. The equivalence holds only at one positive eigenvalue: with several positives, Ricci-flatness reads $\sum_{\lambda>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$ and constrains no rank. Padding two copies of $W_4(q,r)$ onto 4-planes and adding gives a $\mathrm{Weyl}_m$ element with exactly two negative eigenvalues (one per summand) and support the union of the planes. Weyl membership needs no check beyond the arithmetic, both conditions being linear:

| $m$ | planes | spectrum | $\dim U$ | $\theta$ |
|---|---|---|---|---|
| $6$ | overlapping in a 2-plane | $(-3,-1,1,1,1,1)/\sqrt{14}$ | $6$ | $-1.030865$ |
| $8$ | orthogonal | $\{-0.57735^{\times2},\,0.288675^{\times4}\}$ | $8$ | $-0.866025$ |

Ricci-flatness, Bianchi and the identity at $10^{-16}$ ([b0_full_support_witness.py](../scripts/lib/b0_full_support_witness.py)); rebuilt from scratch and fully screened by both reviewers. **The recorded statement is false at $m=6$ and $m=8$.**

#### Corrected: these witnesses do not all have $\theta\le0$

$P$ is cubic, so it is additive over summands only when their supports are Frobenius-orthogonal. Orthogonal 4-planes give cross term exactly zero and $\theta_{\rm sum}=\theta_A/\sqrt2\le0$; **overlapping planes keep the cross term, and $\theta>0$ occurs**, three explicit $m=6$ witnesses with both summands negative and sums at $+0.1384$, $+0.1210$, $+0.0965$, each with exactly two negative eigenvalues and $\dim U=6$ (Reviewer 61), and **exact** witnesses at $\theta=+0.485408612$ ($m=6$) and $+0.115574271$ ($m=8$), both with two negative eigenvalues and $\dim U=m$, from 4-planes in **general position** (Reviewer 60); random general-position draws reach $+0.6259$ at $m=6$ and $+0.2650$ at $m=7$. **The clause is safe only for orthogonal planes**, where the two $\Lambda^2$ summands are orthogonal and $P$ is additive. *That is the shape of the $m=8$ witness alone*: the $m=6$ witness four lines above overlaps in a $2$-plane, with $\langle A,B\rangle=1$ and $P(A+B)=-54$ against $P(A)+P(B)=-36$, **so it is safe by a negative cross term rather than by orthogonality.**

#### So B0's conclusion is now unproved rather than differently proved

The descent through $\dim U<n$ *was* the proof of $\sup\theta\le\sqrt{3/2}$ on the stratum. Nothing found contradicts the conclusion, ascent inside the exact convex description tops out at $+1.187$ at $m=6$, and maximising over the padded-4-plane family returns exactly $\sqrt{3/2}$ by collapsing onto a *single* padded summand at $\dim U=4$, but the proof is gone.

#### What a search over the record does not reach

With the two negative eigenvectors fixed the question is a semidefinite feasibility problem, and random draws over every rank profile at $m=6$ give $0/36$ feasible, **including the rank $4+4$ profile where a witness exists**. Reviewer 60's penalised L-BFGS search reported full-support two-negative witnesses at $m=6,8,10$ with a *nondegenerate* most-negative eigenvector, which would have refuted the statement far more broadly; **they did not survive exact kernel-locking, the extra negatives are asymptotic, not exact**, and the reviewer withdrew them. Reviewer 61's independent penalty search failed to recover even the known $m=6$ witness and was reported as uncalibrated. The exact witnesses are the padded two-4-plane ones alone.

#### $m\ge10$ is open, and the evidence says the stratum is empty there

Two 4-planes span at most eight dimensions, so the construction is silent above $m=8$; and a structured SDP screen over rank and singular-value classes finds that at $m=6,8$ the only near-feasible class is $(4,4)$ with **equal** singular values (two rank-4 complex structures, images spanning $\le8$ dimensions), against margins one to three orders of magnitude worse for every other class, while at $m=10$ the screen is **exhaustive over all 19 admissible rank classes** in both singular-value variants and every one is infeasible, best $(4,6)$-equal at $-1.4\times10^{-3}$ against $-6.6\times10^{-2}$ once either rank leaves $4$; $m=12$ is 13 classes in, all infeasible. For scale, the classes that *are* feasible ($(4,4)$ equal at $m=6,8$), sit at $-4.6\times10^{-5}$ and $-6.7\times10^{-5}$, some $30\times$ closer to zero. *Rank classes are exhausted; relative positions inside each class are still sampled, so this is evidence and not a proof.* A one-parameter deformation makes the same point exactly: with $z$ deformed to singular values $(1,1,\varepsilon)$, $\varepsilon=0$ is feasible with $\dim U=8$ and every $\varepsilon>0$ has $\dim U=m$ and is strictly infeasible, the margin reaching zero only in the unattained limit. **That is Reviewer 59's $\delta^2$ floor with no separate branch, now with a convex certificate at each point and an explanation: the deficit vanishes precisely where the support degenerates.**

#### Lemma L82, the operator-norm lever $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2\ge1$ for at most two negative eigenvalues, REFUTED in its equality clause

*Gate 2, [r669](../reviews/REVIEW_r669.md) and [r670](../reviews/REVIEW_r670.md) on identical briefs, **both REFUTING the same clause**. Both displayed inequalities are theorems; the equality is attached to the wrong one.*

> **"WITH EQUALITY AT THE $m=6$ WITNESS" IS FALSE, AND THIS FILE REFUTES IT TWICE ON ITS OWN.** That witness has spectrum $(-3,-1,1,1,1,1)/\sqrt{14}$, printed twenty lines above the block, so the block's **own first inequality** already forces $\lVert\mathrm{ad}_{v_N}\rVert\ge\sqrt{3/2}=1.2247>1$, **no computation needed.** And eighteen lines below, the feasible class at $m=6,8$ is two rank-4 complex structures, giving $s_1+s_2=\sqrt2$, *the other end of the range.* **What is true: $m=6$ is tight in the contraction bound, $m=8$ in the two-negative step, and the composite is attained at neither. No equality case exists on the record.**

> **THE LEVER IS INFORMATION-FREE AT EVERY $m\le9$.** Every unit skew matrix satisfies $s_1+s_2\ge\min\{1,\,2/\sqrt{\lfloor m/2\rfloor}\}$, which is $1$ at every $m\le9$, **so $\ge1$ says nothing until $m=10$.** *The bare $2/\sqrt{\lfloor m/2\rfloor}$ is the all-equal value and is a minimum only from $\lfloor m/2\rfloor\ge4$: at $m=6,7$ it reads $1.1547$, and the rank-two $\varphi_{01}$ is a unit bivector under this record's own $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ pairing with pair spectrum $(1,0,0)$, so $s_1+s_2=1$ falsifies it.* **The conclusion is unchanged and is now tight rather than approximate**, $s_1+s_2\ge1$ holding at every $m\le9$, and the cut-off at $m=10$ stands. *Degrading through $T_+\le2\lvert\lambda_N\rvert$ discards exactly what would make the lever non-trivial, and the heading "the lever for closing it" oversells a bound that closes nothing.*

> **THE FIRST INEQUALITY IS FAR WIDER THAN STATED.** It holds at **every** negative eigenvector of **every** Ricci-flat Bianchi operator, scale-invariantly: **criticality, unit norm and "most negative" are all unused there**, the last being consumed only in $T_+\le2\lvert\lambda_N\rvert$, which silently uses trace-freeness. *And the quantifier should be **at most** two: the one-negative case is stronger, not degenerate.*

> **THE HEADLINE EQUALITY IS ASSERTED HERE AND PROVED ELSEWHERE.** $\lVert\mathrm{ad}_{v_N}\rVert_{\rm op}=s_1+s_2$ appears nowhere in this file; it is [L31](stratum-two-negative.md)'s root-system step in another file, **and this block cites nothing at all.**

> **A FREE RESULT THE BLOCK LEAVES UNCLAIMED.** At **one** negative eigenvalue the same contraction gives $\lVert\mathrm{ad}_{v_N}\rVert^2\ge2$, forcing equality against the universal $\le\sqrt2$, so $v_N$ is a rank-4 complex structure and $W$ is a padded $\mathrm{Weyl}_4$. **That is a two-line hand proof of [L33](stratum-two-negative.md) by a route L33 does not use**, and it pays a line [L35](stratum-two-negative.md)'s block records as owed.

*Provenance: the fifth heading from the bulk retrofit that produced [L75](isotropy-cap.md)–[L78](isotropy-cap.md), and here it lost neither hypothesis nor definition, **it created an empty numbered heading**, the content sitting under a sibling, the shape [L77](isotropy-cap.md) was repaired for. A **verbatim unnumbered twin** in [ATTEMPTS.md](../ATTEMPTS.md) carries the same false clause and **neither copy was corrected**; the source script's docstring is cleaner than both and makes no equality claim. The first item of "what B0 now owes" **is [L35](stratum-two-negative.md) verbatim and already discharged.** $v_N$, $\lambda_N$ and $T_+$ are defined nowhere on the record.*

#### The lever for closing it

Contracting the identity at the most negative eigenvector kills the negative terms and gives $\|\mathrm{ad}_{v_N}\|_{\rm op}^2\ge2|\lambda_N|/T_+$ with $T_+=\sum_{\lambda>0}\lambda$. With exactly two negative eigenvalues $T_+\le2|\lambda_N|$, so $\|\mathrm{ad}_{v_N}\|_{\rm op}=s_1+s_2\ge1$: **at least half the norm of the most negative eigenvector sits inside a single 4-plane**, with equality at the $m=6$ witness. Since $s_1+s_2\le\sqrt2$ with equality only at rank 4 with $s_1=s_2$, **sharpening $\ge1$ to $=\sqrt2$ would force both negative eigenvectors to be rank-4 complex structures and close $m\ge10$ outright** (Reviewer 61).

#### What B0 now owes

: $\sup\theta$ over $\dim\mathfrak m\le2$ with any number of positive eigenvalues (Lemma L29 covers rank 3 only) which closes B0 without any descent; and the sharpening $s_1+s_2=\sqrt2$, which closes $m\ge10$.

#### Lemma L131, $\mathcal A$ and the sharp-$I$ map are one operator: $\mathcal A=-2(\,\cdot\,\#\,I)$

*Both Gate 2 reviewers reached it independently while auditing a different claim ([r411](../reviews/REVIEW_r411.md), [r412](../reviews/REVIEW_r412.md)), each from Böhm–Wilking's invariant form rather than from the record. **Gate 2 passed on arrival.***

**Statement.** For every symmetric $R$ on $\Lambda^2\mathbb R^n$,
$$\mathcal A(R)=-2\,(R\,\#\,I),$$
$\mathcal A$ being this file's own operator and $\#$ Böhm–Wilking's sharp product. *Both are the quadratic form $h\mapsto-\mathop{\mathrm{tr}}(R\,\mathrm{ad}(h)^2)$: from the definition of $\#$, $\langle(R\#I)h,h\rangle=-\tfrac12\mathop{\mathrm{tr}}(R\mathcal A_h^2)$, while $\langle\mathcal A(R)h,h\rangle=-\mathop{\mathrm{tr}}(R\mathcal A_h^2)$ via $\mathcal A_kh=-\mathcal A_hf_k$.*

**Three consequences, all free.**

> **(i) [Lemma L79](#lemma-l79-the-mathcal-a-eigenvalue-theorem-2--m-4--2m-2--4-on-mathrmweyl_m-s2_0-mathbb-rcdotmathrmid-lambda4)'s table is proven at every $n$**, rather than measured at $n=4,\dots,7$. *$\#I$'s first three entries, $-1$, $\tfrac{m-4}2$ and $m-2$, are machine-checked on the coordinate-diagonal representatives of each summand in [L131Diag.lean](../lean/HamiltonsCubic/Results/L131Diag.lean) (`eig_weyl`, `eig_ricci`, `eig_scalar`), and the fourth, $2$ on $\Lambda^4$, on the four-set elements $a+b+c$ that span $\Lambda^4$ in [L131Four.lean](../lean/HamiltonsCubic/Results/L131Four.lean) (`sharpCross_four_id`), carried to combinations of four-set elements at distinct indices by the first-slot linearity of $\#$ in [L131Lin.lean](../lean/HamiltonsCubic/Results/L131Lin.lean) (`sharpCross_lam4_span`), and to every element of $\Lambda^4$ in [L131Lam4.lean](../lean/HamiltonsCubic/Results/L131Lam4.lean): `lam4_span` writes every linear $R$ preserving bivectors with totally antisymmetric coefficients as $\tfrac1{24}\sum C_{ijkl}\,\mathrm{lam4}_{ijkl}$, and `sharpCross_lam4_all` gives $R\#I=2R$ for all of them.* Its eigenvalues $(+2,-(m-4),-2(m-2),-4)$ are $-2$ times $\#I$'s $(-1,\tfrac{m-4}2,m-2,2)$, and those follow from [Böhm–Wilking's Lemma 2.1](../references/boehm-wilking-2008-space-forms/notes.md) on the Bianchi summands and from the Casimir on $\Lambda^4$.
>
> **(ii) "$\mathrm{Weyl}_n$ is $\mathcal A$'s $+2$ eigenspace" IS $W\#I=-W$**, *its inclusion half, $W\#I=-W$ for every Weyl operator, is machine-checked as `sharpCross_id` in [L131Sharp.lean](../lean/HamiltonsCubic/Results/L131Sharp.lean) in the layer's own $\#$*, *$\mathcal A=-2(\,\cdot\,\#I)$ turns $W\#I=-W$ into $\mathcal A(W)=+2W$, so $\mathrm{Weyl}_n$ is $\#I$'s $-1$ eigenspace and $\mathcal A$'s $+2$ one. [ATTEMPTS.md](../ATTEMPTS.md) states it correctly for $T$ and the substitution to $\mathcal A$ lost the sign; [r464](../reviews/REVIEW_r464.md) flagged it and it was not applied.*, this file's characterisation of the Weyl tensors and the published lemma are one statement, reached in two places that do not cite each other.
>
> **(iii) The isotropy cap moves inside the $\#$-calculus**: $\mu(\mathfrak m)=2\mathop{\mathrm{tr}}\big(\Pi_{\mathfrak m}^{\#}\big)$, so [Lemma L36](#)'s argument is a $\#$-trace rather than an $\mathcal A$-eigenvalue count.

**And it carries the correction to Lemma 2.1 off the Bianchi locus.** Splitting $R=R_B+\mathrm{Alt}(R)$ and using that $\mathrm{Ric}$ annihilates $\Lambda^4$,
$$\mathrm{Ric}(R)\wedge\mathrm{id}=R+R\#I-3\,\mathrm{Alt}(R)\qquad\text{for every symmetric }R,$$
the $3$ being $1+c_4$ with $c_4=2$ from (i). *This is [Observation L15](problem.md) polarised, and the same statement as this file's $\mathcal A(R)=2R-\mathrm{Ric}^*(\mathrm{Ric}\,R)-6\,\mathrm{Alt}(R)$, recorded here because the three files carrying it do not connect them.*

**Two conventions to carry.** $\mathrm{Ric}^*=2(\cdot\wedge\mathrm{id})$, so $H=\mathrm{Ric}^*(\mathrm{Ric}(|W|))=2\big(|W|+|W|\#I-3\,\mathrm{Alt}(|W|)\big)$ with the factor forced. And $\mathrm{Alt}(|W|)=2\,\mathrm{Alt}(W_-)$, so $\lVert\mathrm{Alt}(|W|)\rVert^2=4\delta^2$, *a constant stated at $|W|$ is not comparable with one stated at $W_-$.*
