# Review r390, the four-set clause and the concentration route, Gate 2

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), "The eighteen identities were nine short" and "The four-set equality at padded CP-2", specifically the four-set reduction and the concentration/interpolation plan that closes the file. Analysis only, per [analysis-only.md](../.claude/rules/analysis-only.md). Every constant below is hand algebra from the definitions, derived cold before the record was opened; the four screens are named where they occur and none carries a positive claim.*

## Verdict table

| Claim | Verdict |
| --- | --- |
| **1** $\Sigma\le\tfrac32(A^2+B^2+C^2)$, and $\Sigma\le3\,m_4(S)$ with $m_4=\sum_{a<b\in S}M_{ab}^2$ | **CONFIRMED, and $3$ is sharp.** Both constants derived independently. **New:** the equality locus of the second is *exactly* the four-supported zero-row-sum slice, the bound is worst precisely where the route needs it best |
| **2** "in the band $\theta^2\ge\tfrac32$ makes $m_4(S)<\tfrac12$ sufficient" | **CONFIRMED as arithmetic**, and it is the right sufficient condition |
| **3** the $S^6\times S^6$ figure $0.0869$ "against a budget of $0.509$, a factor of six" | **CORRECTED.** $0.0869$ is the $(2,2)$-split, which is **not** the largest four-set there. The within-factor subset carries $0.10909$, a factor of $4.67$. The margin survives at $S^6\times S^6$; the habit of testing the $(2,2)$-split is what hides the refutation |
| **4** "a pure critical point in the band cannot concentrate its mass on a four-set" | **REFUTED, with witness.** $S^5\times S^{43}$ at $n=48$: in band at $\theta=1.263631$, with a four-subset carrying $m_4=0.501203$ |
| **5** the owed lemma, "$m_4(S)\ge\tfrac12$ at some four-subset forces $\theta$ below $\sqrt{3/2}$" | **REFUTED by the same witness. This lemma is false and no proof of it exists.** The sufficiency itself fails from $S^5\times S^{66}$ ($n=71$), where $3m_4>\theta^2$ |
| **6** $\Theta_4=\sqrt{12}/4=0.866$, the four-support endpoint | **CONFIRMED**, derived independently and attained at $S^2\times S^2$ |
| **7** "$\mathop{\mathrm{tr}}M^3=\tfrac89a^3=1.633$, so $\tfrac12\mathop{\mathrm{tr}}M^3=0.8165$" | **REFUTED twice over.** The spectrum is unreachable (zero row sums put $0$ in it); the true maximum is $2/\sqrt3=1.1547$. And $\theta\ne\tfrac12\mathop{\mathrm{tr}}M^3$, the entrywise cube term is missing. The two errors partly cancel |
| **8** "[Lemma L18](../findings/problem.md)(b) already computes the $\mathcal D_n$ projection in closed form" | **REFUTED as a citation**, there is no L18(b); the formula is Step 2(b) of the *candidate diagonal theorem*, a different result. The general formula is one line away but is not on the record |
| **9** the proposed fix, project $M_S$ back onto the zero-row-sum slice and price it | **REFUTED on its merits, by a dichotomy.** Either projection is available and vacuous, or useful and identically zero on the extremal concentrator |
| **10** the interpolation plan's well-posedness, is "$\theta(M_S)$" meaningful? | **CORRECTED, then REFUTED.** Malformed as written, repairable in one line exactly as the brief proposes, and the repaired plan dies on an **exact equality**: $\theta(M_S)=\sqrt{3/2}$ at the maximal concentrator |

**Headline for the parent.** [Lemma L128](../findings/second-order.md)(ii) itself is untouched, at every witness below $\Sigma$ is comfortably away from $\theta^2$, and at the refuting family it is exactly $0$. What falls is the whole route to it. The route's load-bearing sentence, "the band is exactly what forbids concentration", is false: $S^5\times S^{43}$ and beyond sit in the band with over half the Frobenius mass on four indices. And the route's proposed repair rests on a lemma that does not exist under the name cited, and would not work if it did. **The concentration line should be withdrawn, not repaired.**

---

## 0. The setting, rebuilt from the definitions

$M$ hollow symmetric on $[n]$, $M\mathbf1=0$, $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ for $i\ne j$, $\theta>0$, $\mathop{\mathrm{tr}}M^2=2$. For a four-subset $S=\{i,j,k,l\}$ write the six entries as $x=M_{ij}$, $x'=M_{kl}$, $y=M_{ik}$, $y'=M_{jl}$, $z=M_{il}$, $z'=M_{jk}$, so $A=x+x'$, $B=y+y'$, $C=z+z'$ and $m_4(S)=x^2+x'^2+y^2+y'^2+z^2+z'^2$.

**$\theta$ as a cubic, derived and then checked against the record.** Multiplying criticality by $M_{ij}$ and summing over $i\ne j$, using $\sum_{i\ne j}(M^2)_{ij}M_{ij}=\mathop{\mathrm{tr}}M^3$ (the diagonal drops because $M$ is hollow):

$$\sum_{i\ne j}M_{ij}^3+\mathop{\mathrm{tr}}M^3=\theta\mathop{\mathrm{tr}}M^2=2\theta,\qquad\text{so}\qquad \theta=\tfrac12 P(M),\quad P(M):=\langle M,Q(M)\rangle .$$

This is [ad-form-attempt.md](../findings/ad-form-attempt.md)'s $\theta=\mathop{\mathrm{tr}}(M^3)+\langle M^\#,M\rangle$ in the present normalisation. **It is the identity §7 needs and does not use**, and the omission of the entrywise term is the error in claim 7.

**$S^p\times S^q$, derived rather than quoted.** With $a$ within the first block, $b$ within the second, $c$ across, hollowness and $M\mathbf1=0$ give $a=-qc/(p-1)$ and $b=-pc/(q-1)$, and criticality across the blocks collapses to $c(1-n)=\theta$. Setting $t=\theta/(n-1)$:

$$c=-t,\qquad a=\frac{qt}{p-1},\qquad b=\frac{pt}{q-1},\qquad t=K^{-1/2},\qquad K=\frac{pq}2\Big[\frac q{p-1}+\frac p{q-1}+2\Big],\qquad \theta=\frac{n-1}{\sqrt K}.$$

The within-block equations then hold identically, so this is a critical point for every $p,q\ge2$. It reproduces the record's catalogued values exactly, $\theta=1.236033$ at $S^6\times S^6$ and $\theta=1.228239$ at $S^5\times S^7$, both in [INDEX-values.md](../findings/INDEX-values.md), so the parametrisation below is the record's own.

---

## 1. The sharp constants, claim 1 CONFIRMED, with the equality locus identified

$Q(A,B,C)=A^2+B^2+C^2-AB-BC-CA$ has matrix $\tfrac32\mathrm{Id}-\tfrac12J$, spectrum $\{0,\tfrac32,\tfrac32\}$ with the kernel on $(1,1,1)$. So $\Sigma\le\tfrac32(A^2+B^2+C^2)$, **sharp, with equality exactly on $A+B+C=0$**. Then $A^2\le2(x^2+x'^2)$ with equality exactly at $x=x'$, and likewise for $B,C$, giving

$$\Sigma\;\le\;3\,m_4(S),$$

**sharp**: $(x,x',y,y',z,z')=(1,1,-1,-1,0,0)$ gives $\Sigma=12$ and $m_4=4$. **The author's constant $3$ is correct**, and it is correct because $m_4$ is defined as the sum over the six unordered pairs. *Under the Frobenius convention $\lVert M_S\rVert_F^2=2m_4$ the sharp constant would be $\tfrac32$; the section's definition is the one that makes $3$ right, and it is stated.*

**What the section does not record, and it is the whole story.** The two inequalities are simultaneously tight exactly when $x=x'$, $y=y'$, $z=z'$ and $x+y+z=0$. That set has a name:

> **Lemma (four-support structure).** A hollow symmetric matrix supported on exactly four indices with all row sums zero satisfies $M_{ij}=M_{kl}$, $M_{ik}=M_{jl}$, $M_{il}=M_{jk}$, and the three common values sum to zero. Conversely every such matrix is zero-row-sum. *Proof.* The four row-sum equations are $x+y+z=0$, $x+y'+z'=0$, $y+x'+z'=0$, $z+x'+y'=0$. Differencing the first two and the last two gives $y-y'=z'-z$ and $y-y'=z-z'$, so $z=z'$ and $y=y'$; the first and third then give $x=x'$. The map has rank $4$ on the six entries, so the solution space is two-dimensional. $\square$ *(Screen: the rank and null basis check numerically, and the basis vectors have exactly this twin form.)*

**So the equality locus of $\Sigma\le3m_4$ is precisely the four-supported zero-row-sum slice**, the fully concentrated configurations the route is trying to exclude. On that slice, with $\mathop{\mathrm{tr}}M^2=2$, one gets $m_4=1$ and $\Sigma=3$ identically. The reduction is at its lossiest exactly at the object it is aimed at, which is a warning the section does not carry.

---

## 2. Claim 3, the $S^6\times S^6$ margin is real, the four-subset chosen is not the right one

At $S^p\times S^q$ the four-subsets fall into five types by how many indices lie in the first block, and $\Sigma$ is not the interesting coordinate:

| type | $A,B,C$ | $\Sigma$ | $m_4$ |
| --- | --- | --- | --- |
| $(4,0)$ | $2a,2a,2a$ | $0$ | $6a^2$ |
| $(3,1)$ | $a+c,a+c,a+c$ | $0$ | $3a^2+3c^2$ |
| $(2,2)$ | $a+b,\,2c,\,2c$ | $(a+b-2c)^2=4K/(p^2q^2)$ | $a^2+b^2+4c^2$ |
| $(1,3)$, $(0,4)$ |, | $0$ | $3b^2+3c^2$, $6b^2$ |

**Only the $(2,2)$-split carries any $\Sigma$ at all.** That is why the section tests it, and it is exactly why testing it is the wrong screen for a *mass* bound, which must be run over every type.

At $S^6\times S^6$: the $(2,2)$-split has $m_4=0.086869$, matching the section's $0.0869$; but the within-factor $(4,0)$ subset has $m_4=6a^2=0.109091$. The budget $\theta^2/3=0.509$ still clears it by $4.67$, so **the conclusion at $S^6\times S^6$ stands** and nothing downstream of that one point changes. What changes is the generalisation: the $(2,2)$ mass stays small forever, while the within-factor mass does not.

*Cross-check that the derivation is the record's own:* from the table, $\Sigma/\theta^2=4K^2/\big(p^2q^2(n-1)^2\big)$, and this is algebraically identical to $(n-2)^2/\big((p-1)^2(q-1)^2\big)$, which is [Lemma L127](../findings/second-order.md)'s $\mu_{p,q}^2$ with $\mu_{p,q}=(n-2)/(2(p-1)(q-1))$. Independent agreement to the last digit at $S^6\times S^6$ ($0.16$) and $S^5\times S^7$ ($0.173611$).

**And [Lemma L126](../findings/second-order.md) is reproduced cold.** Solving $\Sigma=\theta^2$ in the family gives $q/(p-1)+p/(q-1)=p+q-3$; with $u=p-1$, $v=q-1$, $s=u+v$, $m=uv$ this factors as $(s+1)(s-m)=0$, i.e. $u+v=uv$, i.e. $\tfrac1{p-1}+\tfrac1{q-1}=1$, L126 exactly, with $S^3\times S^3$ the only integer solution, at $\theta=1.054093$, below the band. **L126 CONFIRMED by an independent route.**

---

## 3. Claims 4 and 5, REFUTED, with an exact witness family

Write the within-factor $(4,0)$ mass as a function of the family. As $q\to\infty$ at fixed $p$:

$$m_4^{(4,0)}\;\longrightarrow\;\frac{12}{p(p-1)},\qquad \theta^2\;\longrightarrow\;\frac{2(p-1)}{p},\qquad \frac{3m_4}{\theta^2}\;\longrightarrow\;\frac{18}{(p-1)^2}.$$

| $p$ | $m_4\to$ | $\theta^2\to$ | $3m_4/\theta^2\to$ | in band? |
| --- | --- | --- | --- | --- |
| $4$ | $1.000$ | $1.500$ | $2.000$ | **no**, see below |
| $5$ | $0.600$ | $1.600$ | $\mathbf{1.125}$ | **yes** |
| $6$ | $0.400$ | $1.667$ | $0.720$ | yes |
| $7$ | $0.286$ | $1.714$ | $0.500$ | yes |

**$p=4$ is out of band at every $q$, and this is a proof rather than a check.** Clearing denominators, $\theta^2\ge\tfrac32$ at $S^4\times S^q$ reduces to $18q-54\ge36q$, i.e. $-54\ge18q$, false for every $q>0$. So $\theta^2\to\tfrac32$ strictly from below along the whole $p=4$ line, which is [r376](REVIEW_r376.md)'s statement, here with the inequality. *This is what makes the band look like it forbids concentration: the $m_4\to1$ line is the one it just barely excludes.*

**$p=5$ is in band and it breaks the route.** Exact rational arithmetic in $(p,q)$:

| $q$ | $n$ | $\theta$ | in band | $m_4$ | $m_4\ge\tfrac12$ | $3m_4\ge\theta^2$ |
| --- | --- | --- | --- | --- | --- | --- |
| $42$ | $47$ | $1.263572$ | yes | $0.499130$ | no | no |
| **$43$** | **$48$** | **$1.263631$** | **yes** | **$0.501203$** | **yes** | no |
| $65$ | $70$ | $1.264339$ | yes | $0.531969$ | yes | no |
| **$66$** | **$71$** | **$1.264355$** | **yes** | **$0.532919$** | **yes** | **yes** |
| $1000$ | $1005$ | $1.264909$ | yes | $0.595226$ | yes | yes |

> **CLAIM 5 IS FALSE.** The owed lemma reads "$m_4(S)\ge\tfrac12$ at some four-subset forces $\theta$ below $\sqrt{3/2}$". At $S^5\times S^{43}$, $n=48$, the four-subset inside the five-block has $m_4=0.501203\ge\tfrac12$ **and** $\theta=1.263631>\sqrt{3/2}=1.224745$. The lemma the section asks for cannot be proved because it is not true.

> **CLAIM 4 IS FALSE.** "A pure critical point in the band cannot concentrate its mass on a four-set" fails on the same witness, and the concentration grows: at $S^5\times S^{1000}$ a single four-subset carries $59.5\%$ of the Frobenius mass while $\theta=1.264909$ sits comfortably inside the band.

> **THE SUFFICIENT CONDITION ITSELF FAILS IN BAND.** From $S^5\times S^{66}$ onward, $3m_4>\theta^2$, so the reduction $\Sigma\le3m_4<\theta^2$ has no content at genuine in-band pure critical points. The supremum of the loss is $9/8$.

**$p=5$ is the only place this happens, and that is not a coincidence.** The band's own floor is $\min(p,q)\ge5$ ([Corollary L128.1](../findings/second-order.md), citing [r376](REVIEW_r376.md)); the reduction needs $18/(p-1)^2<1$, i.e. $p\ge6$; and $m_4\ge\tfrac12$ needs $p(p-1)\le24$, i.e. $p\le5$. **The two conditions meet in exactly one value of $p$, and the band sits on it.** The route fails in a single one-parameter family, at the band's own boundary, which is why six months of testing balanced products never saw it.

*What survives: [Lemma L128](../findings/second-order.md)(ii) is untouched at every witness.* On these four-subsets all six entries equal $a$, so $A=B=C=2a$ and $\Sigma=0$ exactly, far from $\theta^2$. The clause holds; only its proposed proof falls.

---

## 4. Claim 7, two independent errors in one sentence, and one was visible without arithmetic

The section writes: "$\mathop{\mathrm{tr}}M=0$, $\mathop{\mathrm{tr}}M^2=2$ maximise $\mathop{\mathrm{tr}}M^3$ at one large eigenvalue against three equal negatives: $a=\sqrt{3/2}$, $\mathop{\mathrm{tr}}M^3=\tfrac89a^3=1.633$, so $\tfrac12\mathop{\mathrm{tr}}M^3=0.8165$."

**Error (a), the spectrum is unreachable.** $M\mathbf1=0$ puts $0$ in the spectrum with eigenvector $\mathbf1_4$, so the four eigenvalues cannot be $(a,-a/3,-a/3,-a/3)$; at most three are nonzero and they sum to zero. On the actual slice (the two-dimensional family of §1), Newton's identities with $e_1=0$, $e_2=-\tfrac14$ give $\mathop{\mathrm{tr}}M^3=24xyz$ and $\lvert xyz\rvert\le1/(12\sqrt3)$ from the discriminant, so

$$\max\mathop{\mathrm{tr}}M^3=\frac2{\sqrt3}=1.154701,$$

attained at $(x,y,z)=\big(1/\sqrt3,-1/(2\sqrt3),-1/(2\sqrt3)\big)$, which **is** a critical point, and **is** $S^2\times S^2$ at $n=4$. The figure $1.633$ overstates it by $41\%$.

**Error (b), the functional is wrong.** By §0, $\theta=\tfrac12\big(\sum_{i\ne j}M_{ij}^3+\mathop{\mathrm{tr}}M^3\big)$; the entrywise term is dropped. At the same extremiser $\sum_{i\ne j}M_{ij}^3=1/\sqrt3$, so $\theta=\tfrac12(1.154701+0.577350)=0.866025=\Theta_4$ **exactly**.

**The two errors partly cancel, which is why $0.8165$ looked plausible.** But the sentence is self-refuting on its own page: it prints $0.8165$ as a maximisation, then prints the exact value $0.866$ two lines later. A quantity derived as a maximum cannot be below the value it is being compared with. **No computation was needed to catch this, the section contains its own falsifier.**

**Claim 6 is nonetheless CONFIRMED.** $\Theta_4=\sqrt{12}/4=\sqrt3/2=0.866025$ is exactly what the corrected derivation gives, and it is attained. The endpoint the route wants is real; the reasoning offered for it is not.

---

## 5. Claim 8, the projection lemma cited does not exist under that name

The section's closing sentence cites "[Lemma L18](../findings/problem.md)(b)" for "the $\mathcal D_n$ projection in closed form, with residual $a_i+a_j+c$ orthogonal to every hollow zero-row-sum matrix".

**That is Step 2(b) of the *candidate diagonal theorem*** in [problem.md](../findings/problem.md), under the heading "Step 2 is now PROVED here, both halves", the section that ends immediately before the "Lemma L18" heading. **Lemma L18 is a different result entirely**: the lifting of the diagonal proof's middle chapters, with the Bianchi defect priced, about the tube around the $\mathbb{CP}^2$ orbit. There is no part (b) of it. The citation took the next heading down the file.

**Is the formula general, or specific to a $Z(v)$ built from a vector?** The brief's suspicion is half right, and the half that is wrong matters:

- **What is proved is specific.** $Z(v)_{ij}=v_iv_j+\tfrac{v_i^2+v_j^2}{n-2}-\tfrac1{(n-1)(n-2)}$ is shown to be the orthogonal projection of the *rank-one Gram matrix* $(v_iv_j)$, for a unit $v\perp\mathbf1$. Nothing in the statement covers a general hollow symmetric input.
- **The mechanism is general.** The orthogonality proof uses nothing about $v$: for any $a\in\mathbb R^n$ and any $c$, $\sum_{i<j}(a_i+a_j+c)T_{ij}=0$ for every $T\in\mathcal D_n$, by the row sums alone.
- **One line upgrades it.** $\dim\mathcal D_n=\binom n2-n$ (the $n$ row-sum functionals are independent on hollow symmetric matrices for $n\ge3$), and $\{a_i+a_j+c\}$ has dimension $n$ once the gauge $(a,c)\mapsto(a+s,c-2s)$ is quotiented. **So $\{a_i+a_j+c\}=\mathcal D_n^\perp$ exactly**, and the projection of any hollow symmetric $N$ is $N$ minus the unique such residual killing its row sums.

**Verdict: the citation is wrong and the general statement is absent from the record, but the machinery does exist and is one line from being general.** *If the concentration route were otherwise alive, this would be a bookkeeping repair. It is not otherwise alive.*

---

## 6. Claim 9, the fix fails on its merits, by a dichotomy

Take $M_S$ the restriction to pairs inside $S$, and ask what the projection buys. **There are two target spaces and they fail in opposite ways.**

**(A) Project onto $\mathcal D_n$, cheap, and vacuous.** For the extremal case $M_S=a\cdot A(K_4)$ on $S$, solving the row-sum conditions with the gauge $a_i=0$ outside $S$ gives $\alpha=3a/(n-2)$ on $S$ and $c=-12a/\big((n-2)(n-1)\big)$. The residual norm is $O(a^2/n)$, so **the projection cost vanishes as $n$ grows**, that much of the plan is right. But the residual is nonzero on *every outside pair*, since $c\ne0$. **The projected matrix is supported on all of $[n]$.** [Lemma L57](../findings/problem.md) then bounds it by $\Theta_n$, which for the witness family is about $1.41$, the bound one already had for $M$ itself. The projection is affordable and buys nothing.

**(B) Project onto $\mathcal D_n\cap\{\text{supported on }S\}$, useful, and identically zero.** This is the target that keeps $\Theta_4=0.866$. By §1 that space is the two-dimensional plane $\{x=x',\,y=y',\,z=z',\,x+y+z=0\}$. In the six coordinates, the maximal concentrator $M_S=a\cdot A(K_4)$ is $a(1,1,1,1,1,1)$: it already has the twin form, and its three common values are $(a,a,a)$, whose sum is $3a\ne0$. **Its orthogonal projection onto the plane is exactly $0$.** The projection destroys the entire block; the cost is $100\%$.

> **The fix does not exist as a working step, independently of the mis-citation.** Any projection that keeps the four-support annihilates the extremal concentrator; any projection that keeps the norm loses the four-support and with it the only small constant in the argument. **This is the real obstacle, and it is structural rather than a missing estimate.**

---

## 7. Claim 10, is $\theta$ the right functional? The plan is malformed, repairable, and then dead

**The brief is right that this is the deepest problem, and right about the diagnosis.** $\theta$ enters the setting as an *eigenvalue*: it is defined by $Q(M)=\theta M$ off the diagonal. $M_S$ satisfies no such equation, so "$\theta(M_S)$" has no referent, and the section's "$\theta$ is a cubic form, so $\lvert\theta(M)-\theta(M_S)\rvert$ is controlled by $\lVert E\rVert$" conflates the eigenvalue with the cubic that determines it at critical points. **As written the continuity plan quantifies over an undefined object.**

**But it is repairable in one line, and the record already contains the repair.** Define

$$\theta(M)\;:=\;\frac{\sqrt2\,P(M)}{\lVert M\rVert_F^3},\qquad P(M)=\langle M,Q(M)\rangle=\sum_{i\ne j}M_{ij}^3+\mathop{\mathrm{tr}}M^3 .$$

This is homogeneous of degree $0$, defined at every nonzero hollow symmetric matrix, real-analytic, and by §0 it agrees with the eigenvalue at every critical point with $\mathop{\mathrm{tr}}M^2=2$. **And it is already the functional [Lemma L57](../findings/problem.md) bounds**, L57 is stated as $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ on the *whole* diagonal locus, with no criticality hypothesis. So the well-posed object the brief asks for is on the record; only [ATTEMPTS.md](../ATTEMPTS.md)'s wording is loose. **The plan should be restated in $P$ on the unit sphere, as the brief proposes.**

**Restating it kills it, by an exact equality.** Evaluate the repaired functional at the maximal concentrator, the constant block, all six entries $a>0$. Then $\lVert M_S\rVert_F^2=12a^2$, $\sum_{i\ne j}M_{ij}^3=12a^3$, $\mathop{\mathrm{tr}}M^3=24a^3$, so $P=36a^3$ and

$$\theta(M_S)=\frac{\sqrt2\cdot36a^3}{(12a^2)^{3/2}}=\frac32\sqrt{\frac23}=\sqrt{\frac32}=1.224744871\ldots$$

**Exactly the band constant.** *(Verified to $10^{-12}$; the algebra above is exact.)* And this block is itself a critical point of $P$ on the hollow symmetric sphere once the row-sum constraint is dropped: $a^2+2a^2=\theta a$ gives $\theta=3a$, and $12a^2=2$ gives $\theta=3/\sqrt6=\sqrt{3/2}$.

> **THE INTERPOLATION HAS ZERO HEADROOM AND THERE IS NO EPSILON TO SPEND.** The plan needs $\theta(M_S)$ bounded *strictly below* $\sqrt{3/2}$ as $m_4\to1$, so that continuity can push $\theta(M)$ below the band. At the concentrator it is *exactly at* $\sqrt{3/2}$. The $0.866$ the plan reaches for is the maximum over four-supported matrices **that are zero-row-sum**, and zero-row-sum is precisely the hypothesis $M_S$ loses. **Dropping that hypothesis raises the four-support supremum from $0.866$ to at least $\sqrt{3/2}$, a jump of exactly the band constant.** *A $200{,}000$-point random screen over four-supported hollow symmetric matrices found nothing above $1.2103$, consistent with the constant block being the maximiser; the screen is reported as a screen, and the existence claim above needs none of it.*

**So the verdict on point 4 is not "malformed and unfixable" but something sharper.** The plan is well posed after a one-line repair, and then it fails by an exact equality rather than by a missing estimate. That is a stronger closure than a well-posedness objection would have been: no sharpening of the continuity constant can recover a strict inequality that is an equality.

---

## 8. Hypotheses used silently

1. **That the largest four-subset of a sphere product is a $(2,2)$-split.** It is not: for $p\ge4$ the within-factor subset carries more. The section tests only $(2,2)$ because that is where $\Sigma$ lives, and imports the habit into a statement about *mass*, where it is wrong. **The refutation of claims 4 and 5 lives entirely in the subsets the screen never looked at.**
2. **That $\theta$ extends to non-critical matrices.** Unstated throughout §7 of the section; repairable, and repaired in §7 above.
3. **That $\Theta_4$ controls a four-set block.** $\Theta_4=0.866$ is a maximum over four-supported *zero-row-sum* matrices. Without that constraint the supremum is at least $\sqrt{3/2}$. The section's own next sentence identifies zero-row-sum as the missing hypothesis, then continues to use the $0.866$ as though the projection would restore it.
4. **That criticality of $M$ transfers to $M_S$.** It does not, and it is used implicitly whenever $\theta$ is written of the restriction.
5. **That "if $M$ were supported on four indices" is the limiting case of "$m_4$ large".** The $m_4=1$ endpoint is genuinely excluded by the band. Every intermediate value is not, and the family that shows this is $S^5\times S^q$, already flagged on the record as a stress point for a different reduction.

---

## 9. What should be recorded

- **Withdraw claims 4 and 5** and the sentence "the band is exactly what forbids concentration", with the witness $S^5\times S^{43}$ ($n=48$, $\theta=1.263631$, $m_4=0.501203$) and the sufficiency failure from $S^5\times S^{66}$.
- **Keep** $\Sigma\le3m_4$ as a correct sharp bound with its equality locus now identified as the four-supported zero-row-sum slice, and keep $\Theta_4=0.866$.
- **Correct** claim 7's two errors and the $S^6\times S^6$ four-subset choice.
- **Repair** the citation: the projection is Step 2(b) of the candidate diagonal theorem, and the general form needs the one-line dimension count.
- **Record the dichotomy of §6 as a fence post.** Any route that restricts to a four-set and projects back faces it: four-support and zero-row-sum cannot both be kept, and the extremal concentrator is orthogonal to their intersection.
- **Record $\theta(\text{constant }K_4)=\sqrt{3/2}$** as a catalogued value. It is the reason the band constant is the natural barrier for four-set concentration arguments, and it says any successor route must find its margin somewhere other than the four-set restriction.

*The one thing the section got right and should keep: the four-set clause is a statement about mass rather than about $\widetilde N$ or an eigenvector, and it is untouched by [posts F47](../findings/INDEX-traps.md)–F49. That reframing survives. What does not survive is the belief that the band supplies the mass bound.*
