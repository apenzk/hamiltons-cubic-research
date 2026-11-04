# Reviewer 358, Gate 2 on the Jacobi contraction and post F44

**Cold brief, independent build.** Every step below was derived from the definitions in [conventions.md](../findings/conventions.md) before the derivations in [bounds-relaxations.md](../findings/bounds-relaxations.md) and [second-order.md](../findings/second-order.md) were read as arguments. Analysis only: the four numerical runs reported are screens of claims derived first, seconds of compute on objects built here from $\mathfrak{so}(n)$ alone, and none is offered as evidence for a positive claim. Log: [agent_logs/reviewer358.log](../agent_logs/reviewer358.log).

| claim | verdict |
| --- | --- |
| **P1**, post F44, single-character Rayleigh quotients are blind to $R$ | **REFUTED AS STATED.** The quadratic-form fact is right and is stronger than the post says; the boxed conclusion "cannot detect the off-diagonal part $R$ at all" is false through two channels the post does not carry, and the post contradicts it one paragraph later |
| **P2**, the Killing collapse $\sum_{ab}c_{abg}A_aA_b=(n-2)A_g$ | **CONFIRMED.** All four steps independently derived, the constant $2(n-2)$ pinned from the definition of the Killing form, screened exactly at $n=5,6,7$, with the sign caveat of P5 attached |
| **P3**, the contraction against $c_{abg}$ is vacuous | **CONFIRMED**, and more strongly than the record claims: the pairing *is* the trace, so vacuity is an algebraic identity at every $W$ and owes nothing to the sphere products it was checked on. The brief's reading of the left-hand side is right |
| **P4**, any self-pairing contraction loses all of Jacobi's content | **REFUTED AS STATED.** Relations (A) and (C) are both contractions of exactly that shape and neither is contentless; the collapse is caused by the *unweighted trace*, not by the squaring. The operative conclusion survives as **PLAUSIBLE**, unproved, and the citation of [r331](REVIEW_r331.md) as agreement over-claims |
| **P5**, the convention trap | **CONFIRMED** on the mathematics, with two corrections: the pointer to [conventions.md](../findings/conventions.md) names a convention that file does not contain, and "which is consistent" is true only because $\#$ is quadratic in $\mathrm{ad}$ |

**The one-line summary.** P2, P3 and P5 stand as written. P1 and P4 are the same error committed twice, a true statement about an *unweighted* or *diagonal-block* contraction, written down with a universal quantifier that the record's own load-bearing relations violate; and in P4's case it is the third time, [post F18](../findings/bounds-relaxations.md) having been scoped at Gate 2 for precisely this distinction.

---

## 0. Setting, fixed before anything else

$\mathfrak{so}(n)$ with the orthonormal basis $v_a$ of coordinate bivectors, $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ so that $\mathop{\mathrm{tr}}(v_a^2)=-2$ and $\lVert v_a\rVert=1$; $c_{abg}=\langle[v_a,v_b],v_g\rangle$ totally antisymmetric, $T_{abg}=c_{abg}^2$, all as [conventions.md](../findings/conventions.md) fixes them. Sums are over ordered pairs. $D_a:=\mathrm{ad}(v_a)$ acting on $\Lambda^2$, whose matrix in the basis $\{v_m\}$ is $(D_a)_{gb}=c_{abg}$, the point of P5, and I keep $D$ for the homomorphism convention and $A$ for the record's implementation convention $(A_a)_{bg}=c_{abg}$ throughout, because the two are not the same operator.

---

## 1. P2, CONFIRMED, every step

**Step 1, the antisymmetrisation.** Relabelling $a\leftrightarrow b$ in $\sum_{ab}c_{abg}D_aD_b$ and using $c_{bag}=-c_{abg}$ gives $\sum_{ab}c_{abg}D_aD_b=-\sum_{ab}c_{abg}D_bD_a$, so the sum equals half the difference, $\tfrac12\sum_{ab}c_{abg}[D_a,D_b]$. This uses antisymmetry in the first two slots and nothing else.

**Step 2, Jacobi.** $[\mathrm{ad}\,x,\mathrm{ad}\,y]=\mathrm{ad}[x,y]$ is Jacobi, and $[v_a,v_b]=\sum_dc_{abd}v_d$ needs the $v_d$ to be **orthonormal**, which the record's normalisation supplies ($\lVert v_a\rVert=1$). So $[D_a,D_b]=\sum_dc_{abd}D_d$. Note what this step consumes: Jacobi *and* orthonormality of the frame. A non-normalised frame breaks the expansion, not the homomorphism.

**Step 3, the constant.** $\mathop{\mathrm{tr}}(D_gD_d)=\sum_{a,b}(D_g)_{ab}(D_d)_{ba}=\sum_{ab}c_{gba}c_{dab}=-\sum_{ab}c_{abg}c_{abd}$, so $\sum_{ab}c_{abg}c_{abd}=-B(v_g,v_d)$ for $B$ the Killing form. [conventions.md](../findings/conventions.md) fixes $B(X,Y)=(n-2)\mathop{\mathrm{tr}}(XY)$ and $\mathop{\mathrm{tr}}(v^2)=-2$, giving $B(v_g,v_d)=-2(n-2)\delta_{gd}$ and hence $\sum_{ab}c_{abg}c_{abd}=2(n-2)\delta_{gd}$. This is the same statement as the standing fact $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ already in [conventions.md](../findings/conventions.md), read one index at a time, and it is consistent with $\kappa=2(n-2)$ there. Sanity at $n=3$, where $c=\varepsilon$: $\sum_{ab}\varepsilon_{abg}\varepsilon_{abd}=2\delta_{gd}=2(n-2)\delta_{gd}$.

**Step 4.** $\tfrac12\sum_{ab}c_{abg}\sum_dc_{abd}D_d=\tfrac12\sum_d2(n-2)\delta_{gd}D_d=(n-2)D_g$. $\square$

*Screen.* Built $c$ at $n=5,6,7$ from the matrix commutators of $E_{ij}-E_{ji}$ with $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$: total antisymmetry exact, $\sum_{ab}c_{abg}c_{abd}-2(n-2)\delta_{gd}$ exactly zero, and $\sum_{ab}c_{abg}D_aD_b-(n-2)D_g$ exactly zero at all three $n$.

**One thing the record does not say and should.** Step 3 is not a consequence of Jacobi. It is the statement that $\mathfrak{so}(n)$'s Killing form is proportional to the chosen $\mathrm{ad}$-invariant metric, which is simplicity (and at $n=4$ the symmetry between the two ideals), plus orthonormality of the frame. That matters for P4, whose whole diagnosis attributes the collapse to Jacobi.

---

## 2. P3, CONFIRMED, and the vacuity is universal rather than checked

**The record never writes down the identity it contracts, so I reconstructed it.** In the eigenframe of $W$, with eigenvalues $\lambda_a$,

$$(W^\#)_{gd}=\tfrac12\sum_{a,b}\lambda_a\lambda_b\,c_{gab}c_{dab},$$

which is the definition $(W^\#)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$ written out; its diagonal is $\tfrac12m_{11}(g)$, and criticality's diagonal makes it $\lambda_g(\theta-\lambda_g)$, matching relation (C) as [r331](REVIEW_r331.md) states it. *Screened at $n=6$ on a random diagonal $W$: agreement $1.8\times10^{-15}$ at scale $12.2$.* This is the only reading under which the record's sentence can be true, and it is true under it.

**The contraction, and what it actually is.** Contracting *any* $(g,d)$-indexed identity against $\sum_{ab}c_{abg}c_{abd}$ multiplies it by $2(n-2)\delta_{gd}$, that is, it **takes the trace and scales by $2(n-2)$**. So both sides of the criticality identity for $W^\#$ collapse to $2(n-2)\mathop{\mathrm{tr}}(W^\#)$, which by the trace of criticality is $-2(n-2)\lVert W\rVert^2$. *Screened at $n=6$: the contraction and $2(n-2)\mathop{\mathrm{tr}}(W^\#)$ agree to the last digit, both $-158.038152$.*

**The brief's reading of the left-hand side is right.** $\sum_g\big(\sum_{ab}T_{abg}\big)(W^\#)_{gg}$ evaluates to the same $-158.038152$, because $\sum_{ab}T_{abg}=2(n-2)$ for every $g$, the row marginal (A). So the left side is exactly the brief's expression.

**And it is not an artefact of the sphere products.** The collapse is an algebraic identity in $c$ alone; no property of $W$ enters beyond having a $(g,d)$-indexed identity to contract. So the record's "checked at four sphere products, agreeing to machine zero" is a check of something that cannot fail anywhere, and the "verified exactly at $n=6,7,8$" attached to the Killing collapse is likewise a check of a two-line proof. Neither is wrong; both understate what is proved. **What the contraction returns is the trace of criticality, $\mathop{\mathrm{tr}}(W^2)+\mathop{\mathrm{tr}}(W^\#)=0$, which the record already holds**, [Lemma L116](../findings/bounds-relaxations.md) is the same fact one level finer, on the Bianchi component.

---

## 3. P4, REFUTED AS STATED, and the real mechanism is the trace

The claim under attack: *any* contraction pairing each $c$ with itself over both bracket slots loses **all** of Jacobi's content, because squaring forces the Killing form, which is a multiple of the identity.

### 3.1 The quantifier is false, and the record's own relations are the counterexamples

**Because $c$ is totally antisymmetric there are no distinguished bracket slots.** $c_{abg}=c_{gab}$, so "pairing each $c$ with itself over both bracket slots" names exactly one operation up to relabelling: contract two copies of $c$ over two shared slots, leaving one slot on each free. Every such contraction is $F_{gd}=\sum_{ab}w_{ab}\,c_{abg}c_{abd}$ for some weight, and its $T$-expressible shadow is the diagonal $F_{gg}=\sum_{ab}w_{ab}T_{abg}$.

**At $w\equiv1$ this contraction is relation (A).** $F_{gg}=\sum_{ab}T_{abg}=2(n-2)$, the row marginal. That is not "all of Jacobi's content lost". It is the single most-used $T$-relation on the record: the transportation marginal of the bracket relaxation, the row constraint of the LP at $n=12$, the subject of [post F18](../findings/bounds-relaxations.md), and the (A) of [r331](REVIEW_r331.md)'s census. **The collapse produces content; it happens to produce content the record already had.**

**At $w_{ab}=\lambda_a\lambda_b$ this contraction is relation (C).** $F_{gg}=\sum_{ab}\lambda_a\lambda_bT_{abg}=m_{11}(g)=2(W^\#)_{gg}$, which at a critical point is $2\lambda_g(\theta-\lambda_g)$, the only channel through which criticality's cubic information reaches the per-index calculus at all. *Screened at $n=6$: the identity $\sum_{ab}\lambda_a\lambda_bT_{abg}=2(W^\#)_{gg}$ holds to $3.6\times10^{-15}$, and the left side ranges over $[-24.31,\,3.37]$ across $g$, manifestly not a multiple of the identity.* So the stated mechanism, "squaring forces the Killing form, which is a multiple of the identity", holds **only for the unweighted contraction** and fails at the very next weight.

**The correct diagnosis of the record's own run.** What killed it is not that the $c$'s were squared. It is that $\sum_{ab}c_{abg}c_{abd}=2(n-2)\delta_{gd}$ acts as $2(n-2)\times$ the **trace**, so the contraction can only ever return the trace of the identity it is applied to, and the trace of criticality was already on record. State it that way and the successor question writes itself: contract against a *weighted* pairing $\sum_{ab}w_{ab}c_{abg}c_{abd}$, which is not the trace.

**This is the third occurrence of one slip.** [Post F18](../findings/bounds-relaxations.md) was scoped at Gate 2 with exactly this correction, "only the *unweighted* generator sum of Prop 1.7 is inert ... the very next weight returns $\theta$ itself", and the record's own summary of it reads "any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma L30/31". P4 restates the unscoped form of that sentence in a new place, without the qualifier that Gate 2 forced the first time.

### 3.2 What survives, after I attacked the escape as well

I pushed the weighted route to see whether it delivers a $T$-only consequence of Jacobi, and it does not, for a reason worth recording. Weighting P2 gives $\sum_{ab}w_aw_b\,c_{abg}[D_a,D_b]=\sum_dK^w_{gd}D_d$ with $K^w_{gd}=\sum_{ab}w_aw_bc_{abg}c_{abd}$; pairing against $D_g$ under $\mathop{\mathrm{tr}}(D_dD_e^{\mathsf T})=2(n-2)\delta_{de}$ turns the right side into $2(n-2)\sum_{ab}w_aw_bT_{abg}$, which is the wanted non-constant $T$-quantity. But the left side is $2\sum_{ab}w_aw_bc_{abg}\mathop{\mathrm{tr}}(D_aD_bD_g^{\mathsf T})$, and since $w_aw_bc_{abg}$ is antisymmetric in $(a,b)$ it reads only the antisymmetric part of $\mathop{\mathrm{tr}}(D_aD_bD_g^{\mathsf T})$, which is $\tfrac12\mathop{\mathrm{tr}}([D_a,D_b]D_g^{\mathsf T})=(n-2)c_{abg}$, the same $T$-quantity back. **So the weighted contraction of P2 is an identity for every weight**, and the escape that refutes the mechanism does not by itself produce a constraint.

**Hence the operative conclusion is PLAUSIBLE and unproved**, and two things attached to it need correcting:

- **The citation of [r331](REVIEW_r331.md) as agreement over-claims.** r331 proves "Jacobi, empty at **linear order in $T$**", with per-index polynomial $\lambda$-weights, and says so explicitly: "The operator form $\mathrm{ad}([x,y])=[\mathrm{ad}\,x,\mathrm{ad}\,y]$ traced against polynomials in $W$ yields relations among *cubic* $c$-contractions, never linear in $T$." P4 asserts the far stronger statement that **no polynomial in $T$** carries a Jacobi consequence. That is not r331's theorem seen from another side; it is a strictly larger claim resting on one worked example.
- **"Those terms no polynomial in $T$ carries" is asserted, not proved.** The obstruction is correctly located, Jacobi's terms $c_{abd}c_{dce}$ share exactly one index, so squaring them leaves cross terms $d\ne d'$, and the $d=d'$ part *is* $T$-expressible ($\sum_d m^w(d)^2$ under a weight), so what Jacobi delivers is a $T$-quantity equated to a non-$T$ remainder. That the remainder is not $T$-expressible is the sign-realizability question of [DERIVE-t7](DERIVE-t7.md), which proves it for inequalities from the off-diagonal block, not for arbitrary polynomials. The natural proof (flip the sign of $c$ on one unordered triple, which preserves total antisymmetry and $T$), **fails**, because the flipped array need not satisfy Jacobi, and no witness pair of Jacobi-satisfying $c$ with equal $T$ and different cross terms is on the record.

### 3.3 What I would put in its place

> A contraction of Jacobi against an **unweighted** pairing $\sum_{ab}c_{abg}c_{abd}$ acts as $2(n-2)$ times the trace and therefore returns only the trace of the identity contracted; at $w\equiv1$ that trace is relation (A). *What a successor must clear*: the weighted pairing $\sum_{ab}w_{ab}c_{abg}c_{abd}$ escapes the collapse (relations (B) and (C) are instances) so the live obstruction is not the squaring but the cross terms $d\ne d'$, and closing I15 needs either a proof that no polynomial in $T$ separates two Jacobi-satisfying arrays with the same $T$, or a witness pair showing one does.

---

## 4. P1, REFUTED AS STATED, with a stronger replacement

### 4.1 The quadratic-form fact is right, and is stronger than the post states

[Lemma L123](../findings/second-order.md) gives $\langle X,R\circ X\rangle=0$ for $X$ in a single character space. Polarising inside that space, $X+Y$ lies in it too, and $\langle\cdot,\cdot\circ\cdot\rangle$ is fully symmetric so $L_R$ is self-adjoint, gives $\langle Y,L_RX\rangle=0$ for **all** $X,Y$ in the same character space. So the whole compression of $L_R$ to a character space vanishes, not merely its diagonal. Combined with [Lemma L120](../findings/second-order.md)'s mechanism, $\mathop{\mathrm{diag}}(M)$ carries the trivial character, $\circ$ is $\Gamma$-equivariant, so $L_{\mathop{\mathrm{diag}}(M)}$ preserves every character space, this is an exact split:

> **In the $\Gamma$-character decomposition of $\mathrm{Sym}^2(\Lambda^2)$, $L_{\mathop{\mathrm{diag}}(M)}$ is exactly the block-diagonal part of $L_W$ and $L_R$ is exactly the off-block part.**

*Screened at $n=6$ on a random symmetric $W$ split as $\mathop{\mathrm{diag}}(M)+R$, over all $120$ character-labelled basis elements: $\max|\langle Y,L_RX\rangle|$ within a character $4.4\times10^{-16}$, $\max|\langle Y,L_{\mathop{\mathrm{diag}}M}X\rangle|$ across characters $2.8\times10^{-16}$, and $\max|\langle Y,L_RX\rangle|$ across characters $2.14$, so $R$ is not hidden, it is off-block.*

That statement is more useful than the post's, because it says where $R$ *is* rather than where it is not, and it makes the successor requirement concrete: a two-character test direction $X+Y$ picks up the cross term $2\langle Y,L_RX\rangle$, which is pure $R$.

### 4.2 The boxed conclusion is false through two channels

**Channel one, $\theta$.** [Lemma L24](../findings/second-order.md)'s criterion is $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ with $e=W/\theta$, so on a unit $X$ it reads $\langle X,L_WX\rangle\le\theta/2$. The left side is a function of $\mathop{\mathrm{diag}}(M)$; the constant on the right is $\theta=P(W)$, a function of all of $W$. Two Weyl tensors with the same $\mathop{\mathrm{diag}}(M)$ in a frame and different $R$ have different $\theta$ and are therefore tested against different thresholds, one possibly passing and one failing. So the criterion **discriminates between off-diagonal parts**, and "cannot detect the off-diagonal part $R$ at all" is false. The record's own [Lemma L121](../findings/second-order.md) shows it in print: $A^2+B^2+C^2-AB-BC-CA\le\theta^2$ has $A,B,C$ from $\mathop{\mathrm{diag}}(M)$ and $\theta$ from everything.

**Channel two, admissibility.** L24 requires $X\perp W$. For $X$ in a **non-trivial** character space, $\langle X,\mathop{\mathrm{diag}}(M)\rangle=0$ automatically, so $\langle X,W\rangle=\langle X,R\rangle$: the admissible directions inside that character space are exactly $R^\perp$, a hyperplane whose position is determined by $R$. In a two-dimensional $4$-set block that cuts the test from a plane to a line, and *which* line is $R$'s doing. So even the set of directions the criterion is evaluated on depends on $R$.

**The post contradicts its own box.** Two paragraphs below the box: "the certificate's only $R$-dependence enters through the *projection* defect $\langle X,W\rangle$ rather than through $L_R$." That sentence concedes channel two, and it cannot stand beside "cannot detect $R$ at all". [Lemma L123](../findings/second-order.md)'s own scope paragraph says the same thing correctly, "[Lemma L24](../findings/second-order.md) also requires $X\perp W$, which fails there, and the resulting projection defect is a separate correction", so the record holds both the right statement and the wrong one, in adjacent sections, and the wrong one is the boxed headline.

### 4.3 The scope paragraph is under-drawn, in two further places

The post's "what is not closed" names mixed-character directions, third-order fusion, and the Laplacian read across pairs. It misses: (i) any criterion using the **vector** $L_WX$ rather than the number $\langle X,L_WX\rangle$, an operator-norm bound, or the requirement that the full Hessian be negative semidefinite on $W^\perp$, which sees $R$ through the off-blocks §4.1 exhibits, and this is not the same escape as "a direction with components in two characters"; and (ii) the two channels of §4.2, which are not about the test directions at all.

### 4.4 It does read L121 and L122 as weaker than they are

"The closed forms of L121 and L122 hold under diagonality alone, which is the same fact again: they never see $R$ because they cannot." **At a coordinate-diagonal critical point there is no $R$ to see**, $W=\mathop{\mathrm{diag}}(M)$ in that frame, and L121 and L122 give the *complete* block of $L_W$ there, spectrum and all. The record's diagonal theorem lives entirely in that setting, so nothing in it is weakened. The blindness bites in exactly one place: transporting the lemmas to a frame where $W$ is not diagonal, which is [DERIVE-mx1](DERIVE-mx1.md)'s refuted I12 and is already recorded as such. The sentence should say that the lemmas are exact where they are stated and blind only where they are transported.

### 4.5 One downstream propagation, in the plan

[plan.md](../plan.md)'s I15 item reads "by [post F44](../findings/INDEX-traps.md) the second-order criterion on single-character directions cannot see the sign-carrying part at all". F44's $R$ is the off-diagonal part of $W$ in a **coordinate frame of $\mathbb R^n$**, decomposed under that frame's sign group; I15's "sign-carrying part" is the signs of $c_{abc}$ in $W$'s **spectral eigenframe on $\Lambda^2$**, which is generically not a coordinate-bivector frame at all, the distinction [conventions.md](../findings/conventions.md) raises under "Diagonal means diagonal in coordinate $2$-planes". F44 says nothing about the census's sign question, and the plan item should not cite it there.

---

## 5. P5, CONFIRMED, with two corrections to the note

**The homomorphism direction is right.** $\mathrm{ad}(v_a)v_m=[v_a,v_m]=\sum_nc_{amn}v_n$, so the matrix of $\mathrm{ad}(v_a)$ has $(D_a)_{nm}=c_{amn}$, i.e. $(D_a)_{mn}=c_{anm}$, the record's stated convention. The other choice $(A_a)_{mn}=c_{amn}$ is $D_a^{\mathsf T}=-D_a$, since $c$ is antisymmetric in the last two slots, so $[A_a,A_b]=[D_a,D_b]=\sum_dc_{abd}D_d=-\sum_dc_{abd}A_d$: the homomorphism fails by a sign, exactly as claimed. *Screened at $n=5,6,7$: $\max|[D_a,D_b]-\sum_dc_{abd}D_d|=0$ over all pairs, and the same expression for $A$ is off by $2.0$; the collapse $\sum_{ab}c_{abg}A_aA_b+(n-2)A_g=0$ holds exactly, with the sign reversed.*

**Correction one, the citation is to a file that does not carry the convention.** The note says "[conventions.md](../findings/conventions.md)'s $Q$ implementation uses $(A_a)_{bg}=c_{abg}$". [conventions.md](../findings/conventions.md) contains no such line; the convention lives in the implementation of $Q$ in [adversarial_check1.py](../scripts/lib/adversarial_check1.py), which is where I read it. The record's own rule in that file is that conventions are quoted from it and never restated elsewhere, so either the line belongs in [conventions.md](../findings/conventions.md) or the pointer should name the script.

**Correction two, "which is consistent" needs its reason, and the reason bounds it.** $(W^\#)_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$ is **quadratic** in $A$, so it is invariant under $A\mapsto-A$ and $Q$ is unaffected by the choice. That is why the implementation is safe. But in that same convention P2's identity reads $\sum_{ab}c_{abg}A_aA_b=-(n-2)A_g$, so "consistent" must not be read as "the identity above holds in it".

**Does any recorded result depend on the wrong one? No, and the reason is structural.** Every use of $\mathrm{ad}$ on the record is quadratic in it and therefore sign-blind: $W^\#$ and $Q$; [r331](REVIEW_r331.md)'s moments $m_{pq}(k)=-\mathop{\mathrm{tr}}(\mathrm{ad}_kW^q\mathrm{ad}_kW^p)$, hence relations (A), (B) and (C); [Lemma L122](../findings/second-order.md)'s pair block, built from $\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)$; and [post F18](../findings/bounds-relaxations.md)'s $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$. r331's master identity $(\star)$ is written for the derivation $D_A$ defined intrinsically, which fixes the sign by construction. **Jacobi is the only place on the record where $\mathrm{ad}$ enters linearly**, which is exactly why the trap surfaced there and nowhere else, worth saying in the note, because it tells a successor when to check.

---

## 6. What I did not do

I did not attempt a computational search for a witness pair of Jacobi-satisfying arrays with equal $T$ and different cross terms, which is what would settle §3.2's second bullet. **What the run would decide:** whether $\sum_{d\ne d'}c_{abd}c_{dce}c_{abd'}c_{d'ce}$ is a function of $T$ on the Jacobi locus. **What each outcome would mean:** a witness pair refutes P4's clause (iv) outright and reopens I15 as a live search; failure to find one over a structured family is evidence for the clause and no more, since the locus is not enumerable. It is blocked under the programme's analysis-only rule and stays blocked.
