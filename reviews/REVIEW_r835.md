# Review r835: Gate 2 on L195 (the all-simple coincident stratum)

*Cold brief: I worked from [BRIEF](/tmp/brief_r835.md), reconstructing the block's four steps by hand before opening [findings/diagonal-half.md](../findings/diagonal-half.md) to confirm the quotation, and I read neither the sibling reviewer's log nor its report. **No screen and no computation of any kind was run.** Everything below is closed form: the one arithmetic check, the seven weights at $r=7$, is a sum of seven fortieths done by hand. Log: [agent_logs/g2-coincident-r835.log](../agent_logs/g2-coincident-r835.log).*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | $\omega_i\wedge\omega_i$ has $\Lambda^2E_j\otimes\Lambda^2E_k$ component $2\sigma_{ij}\sigma_{ik}c_jc_k$, and the $\Lambda^4E_j$ parts impose nothing extra | **BOTH CORRECT. THE $\varepsilon_j\wedge\varepsilon_j$ TERMS VANISH BECAUSE $\varepsilon_j$ IS DECOMPOSABLE, AND $\Lambda^4E_j=0$ OUTRIGHT AT $\dim E_j=2$** |
| 2 | $\langle\omega_i,\omega_{i'}\rangle=\sum_jt_j\sigma_{ij}\sigma_{i'j}$, $\sum_jt_j=1$ is $\mathop{\mathrm{tr}}A=2$, and $t_j=c_j^2m_j$ in general | **ALL CORRECT, AND THE IMPLICIT $\langle J_j,J_j\rangle=m_j$ IS RIGHT UNDER THE RECORD'S $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$** |
| 3 | The three displays force $T_{++}=T_{+-}=T_{-+}=T_{--}=\tfrac14$, so every class is nonempty | **CORRECT. THE SYSTEM IS THE $(\mathbb Z/2)^2$ CHARACTER TABLE, $HH^{\mathsf T}=4I$, SO THE SOLUTION IS UNIQUE** |
| 4 | "At most one singleton" excludes $r=3,4,5,6$ and admits $r=7$ | **THE ENUMERATION IS CORRECT AND THE CRITERION IS THE RIGHT ONE FOR WEIGHT-EXISTENCE. IT IS FAR WEAKER THAN THE HYPOTHESES ALLOW** |
| 5 | At $r=7$ weights exist with all seven $c_j^2$ distinct | **WEIGHTS EXIST, EXHIBITED IN CLOSED FORM. NO TRIPLE EXISTS, REFUTED IN CLOSED FORM** |
| 6 | The reduction to signs needs one simple eigenvalue, and the count then weakens because $c_j^2m_j=c_k^2m_k$ is achievable | **THE ARITHMETIC IS RIGHT AND EXHIBITED. BOTH CLAIMS ARE MOOT: NO SIMPLE EIGENVALUE IS NEEDED, AND THE COUNT IS NEVER THE OPERATIVE OBSTRUCTION** |
| 7 | What is left untouched is exactly: every eigenvalue of $A$ of multiplicity at least four | **REFUTED. WHAT IS LEFT IS EXACTLY $A$ SCALAR, AND AT $\dim V=8$ THAT IS ONE CONCRETE QUESTION WITH NO CHEAP ANSWER** |
| 8 | Scope: no Weyl input, $V$ the full support, orthonormality against equal norms | **NO WEYL INPUT ANYWHERE. EQUAL NORMS ARE NOT A HYPOTHESIS AT ALL, BEING FORCED BY THE COMMON SQUARE. ORTHOGONALITY IS LOAD-BEARING AND IS SPENT ONLY AT THE LAST LINE** |
| 9 | Falsifiers | **NAMED. NONE EXISTS AT ANY DIMENSION, WHICH IS THE FINDING BELOW** |
| **D1** | Header "empty up to $\dim V=12$, and first possible at $14$", and the Statement's "$r=7$ is the first value not excluded" | **REFUTED. THE BLOCK'S OWN CROSS-TERM LINE ALREADY EMPTIES EVERY $r$, INCLUDING $7$** |
| **D2** | The frontier box, "the cross-term step needs a two-dimensional eigenspace" | **REFUTED. RANK-ONE RIGIDITY IN $\Lambda^2E_j\otimes\Lambda^2E_k$ GIVES THE SIGN AT ANY MULTIPLICITIES** |
| **D3** | The sharpening box's own line yields a $k$-independent sign, so it already proves $\omega_i=\pm\omega_1$ | **REAL, AND IT IS THE BLOCK CONTRADICTING ITS OWN CONCLUSION IN A BOX BENEATH IT** |
| **D4** | The Statement enumerates $r\in\{3,4,5,6\}$ while the header says "up to $\dim V=12$" | **COMPLETENESS GAP ONLY, LOW SEVERITY: THE FOUR-CLASS COUNT COVERS $r=1,2$ TOO** |

## One line someone can act on

**The lemma is true and radically understates itself, and the half of the header that says "first possible at $14$" is false**: the step the block derives and then discards, $\sigma_{ij}\sigma_{ik}$ independent of $i$ at every pair, forces $\omega_2=\pm\omega_1$ outright, so the all-simple coincident stratum is empty at **every** dimension, and with multiplicities restored the only stratum that survives anywhere is $A$ a multiple of the identity.

## Conventions, fixed before anything was derived

| object | reading used here | source |
|---|---|---|
| $\langle X,Y\rangle$ on $\Lambda^2$ | $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so a unit form has $\mathop{\mathrm{tr}}(\omega\omega^{\mathsf T})=2$ and $\mathop{\mathrm{tr}}(\omega^2)=-2$ | [conventions.md](../findings/conventions.md), and the brief's own givens |
| $(\omega\wedge\omega)_{ijkl}$ | $2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$ | [conventions.md](../findings/conventions.md), [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) |
| $\varepsilon_j$ | the area form of the oriented plane $E_j$, a unit element of $\Lambda^2$ under the rule above, with $\varepsilon_j^2=-\mathrm{Id}_{E_j}$ | brief's given, "a skew map on a plane is a multiple of its area form" |
| $\Lambda^4V$ under $V=\bigoplus_jE_j$ | the canonical splitting $\bigoplus_{\sum a_j=4}\bigotimes_j\Lambda^{a_j}E_j$, in which $\alpha\wedge\beta$ for $\alpha\in\Lambda^2E_j$, $\beta\in\Lambda^2E_k$ **is** $\alpha\otimes\beta$ | standard, and it is the whole of section 6 |
| $V$ | the common support, $A=-\omega_i^2$ positive definite on it | brief's given |

**The identification of the wedge with the tensor product is the one convention this review turns on.** *It is what upgrades the block's sign into a scalar $\lambda$ with $\lambda\cdot\lambda^{-1}=1$, and the norms then force $\lambda=\pm1$ without any appeal to a two-dimensional eigenspace.*

## Hypothesis inventory

| hypothesis | where the block uses it | where it is actually needed |
|---|---|---|
| $\omega_i^2$ common, $=-A$ | to make $A$ well defined and to get $\omega_i|_{E_j}=c_j\sigma_{ij}\varepsilon_j$ | the same, and it silently supplies equal norms |
| $A$ positive definite on $V$ | $c_jc_k>0$ in the cross-term division | genuinely needed, a kernel would kill the pair $(j,k)$ it meets |
| $\omega_i\wedge\omega_i$ common | the cross-term step | the whole lemma, and it is stronger than the block spends |
| all eigenvalues of multiplicity exactly two | to convert each $\omega_i|_{E_j}$ into a sign rather than a complex structure | not needed at all, see section 6 |
| $t_j$ pairwise distinct | to rule out two singleton classes | only for the count, which is not the operative obstruction |
| $\langle\omega_i,\omega_{i'}\rangle=0$ | the three displays | the last line, once, in the corrected proof |
| $\langle\omega_i,\omega_i\rangle=1$ | $\sum_jt_j=1$ | a normalisation, the corrected proof needs only $\sum_jt_j>0$ |
| Ricci-flatness, first Bianchi, $W\in\mathcal W_n$ | nowhere | nowhere |

## 1. The cross-term step, derived rather than checked

Write $V=\bigoplus_{j=1}^rE_j$ for the eigenspaces of $A$, mutually orthogonal because $A$ is symmetric, each of dimension two by hypothesis, with $A|_{E_j}=c_j^2\,\mathrm{Id}$ and $c_j>0$. Each $\omega_i$ commutes with $\omega_i^2=-A$, so it preserves every $E_j$, and its restriction is a skew map on a plane, hence $a_{ij}\varepsilon_j$ for the area form $\varepsilon_j$ of a fixed orientation of $E_j$. Then $\omega_i^2|_{E_j}=-a_{ij}^2\,\mathrm{Id}$ and $\omega_i^2=-A$ give $a_{ij}^2=c_j^2$, so $a_{ij}=\sigma_{ij}c_j$ with $\sigma_{ij}=\pm1$. This is the block's line and it is correct.

**The choice of orientation of each $E_j$ is free and the conclusion does not see it.** *Reversing the orientation of $E_j$ flips $\sigma_{ij}$ for all three $i$ at once, which leaves every product $\sigma_{ij}\sigma_{i'j}$ and every $\sigma_{ij}\sigma_{ik}\sigma_{i'j}\sigma_{i'k}$ unchanged.*

For the wedge, take an oriented orthonormal frame with $E_j=\mathrm{span}(e_{2j-1},e_{2j})$ and $\varepsilon_j=e_{2j-1}\wedge e_{2j}$, so $\omega_i=\sum_j\sigma_{ij}c_j\,\varepsilon_j$ as an element of $\Lambda^2V$. Then
$$\omega_i\wedge\omega_i=\sum_{j,k}\sigma_{ij}\sigma_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k=2\sum_{j<k}\sigma_{ij}\sigma_{ik}c_jc_k\,\varepsilon_j\wedge\varepsilon_k,$$
using that $2$-forms commute under $\wedge$ and that the diagonal terms vanish.

**The $\varepsilon_j\wedge\varepsilon_j$ terms vanish for a reason available at any dimension**: $\varepsilon_j=e_{2j-1}\wedge e_{2j}$ is decomposable, and a decomposable $2$-form wedged with itself repeats a factor, so $\varepsilon_j\wedge\varepsilon_j=0$. *At $\dim E_j=2$ there is also nowhere for such a term to live, $\Lambda^4E_j$ being the zero space, so in the all-simple stratum the question is empty twice over.* That answers the brief's item 1 in the affirmative, and it also flags that "the $\Lambda^4E_j$ parts impose nothing extra once the signs are pinned" is vacuously true here rather than a step. **It is not vacuous at higher multiplicity**, where section 6 has to dispose of it, and at $r=1$ it is the entire content of the wedge hypothesis.

The component claim is exactly right, in the record's index convention as well as in the multi-index one. With $E_j=\mathrm{span}(e_1,e_2)$ and $E_k=\mathrm{span}(e_3,e_4)$ and $\omega=\sigma_jc_j\varepsilon_j+\sigma_kc_k\varepsilon_k$, the only nonzero matrix entries above the diagonal are $\omega_{12}=\sigma_jc_j$ and $\omega_{34}=\sigma_kc_k$, so
$$(\omega\wedge\omega)_{1234}=2(\omega_{12}\omega_{34}-\omega_{13}\omega_{24}+\omega_{14}\omega_{23})=2\sigma_j\sigma_kc_jc_k,$$
which is the block's $2\sigma_{ij}\sigma_{ik}c_jc_k$. The exterior-algebra reading gives the same number, the coefficient of $e_1\wedge e_2\wedge e_3\wedge e_4$ in $(a\varepsilon_j+b\varepsilon_k)^{\wedge2}$ being $2ab$.

The forms $\{\varepsilon_j\wedge\varepsilon_k\}_{j<k}$ are distinct basis $4$-vectors, hence independent, so equality of the three wedges is equivalent to
$$\sigma_{1j}\sigma_{1k}=\sigma_{2j}\sigma_{2k}=\sigma_{3j}\sigma_{3k}\qquad\text{at every }j<k. \tag{$\ast$}$$

## 2. The weights, and the factor the block leaves implicit

Distinct blocks are orthogonal, $\langle\varepsilon_j,\varepsilon_k\rangle=\tfrac12\mathop{\mathrm{tr}}(\varepsilon_j^{\mathsf T}\varepsilon_k)=0$ for $j\ne k$, and $\langle\varepsilon_j,\varepsilon_j\rangle=\tfrac12\mathop{\mathrm{tr}}(\mathrm{Id}_{E_j})=1$. So
$$\langle\omega_i,\omega_{i'}\rangle=\sum_{j,k}\sigma_{ij}c_j\sigma_{i'k}c_k\langle\varepsilon_j,\varepsilon_k\rangle=\sum_j t_j\,\sigma_{ij}\sigma_{i'j},\qquad t_j=c_j^2,$$
which is the block's display. Taking $i=i'$ gives $\langle\omega_i,\omega_i\rangle=\sum_jt_j$, and separately $\mathop{\mathrm{tr}}A=\sum_j2c_j^2=2\sum_jt_j$, so $\sum_jt_j=1$ and $\mathop{\mathrm{tr}}A=2$ and $\lVert\omega_i\rVert=1$ are one statement. **Confirmed, and it carries a hypothesis the block does not charge for**: since $A$ is common, $\lVert\omega_i\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(\omega_i^2)=\tfrac12\mathop{\mathrm{tr}}A$ is the same number for all three $i$, so *equal norms are a consequence of the common square rather than an assumption*, and only the value $1$ is a normalisation.

At general multiplicity, $\dim E_j=2m_j$, the restriction $\omega_i|_{E_j}$ is skew with square $-c_j^2\,\mathrm{Id}$, so $\omega_i|_{E_j}=c_jJ_{ij}$ with $J_{ij}$ skew and $J_{ij}^2=-\mathrm{Id}$, that is an orthogonal complex structure on $E_j$. Then
$$\langle J_{ij},J_{ij}\rangle=\tfrac12\mathop{\mathrm{tr}}(J_{ij}^{\mathsf T}J_{ij})=\tfrac12\mathop{\mathrm{tr}}(\mathrm{Id}_{E_j})=m_j,$$
so the block's implicit $\langle J_j,J_j\rangle=m_j$ is **correct** under the record's inner product, and $\langle\omega_i,\omega_{i'}\rangle=\sum_jc_j^2m_j\sigma_{ij}\sigma_{i'j}$ once the $J_{ij}$ are pinned to $\pm J_{1j}$. The trace check matches: $\mathop{\mathrm{tr}}A=\sum_j2m_jc_j^2=2\sum_jt_j$ with $t_j=c_j^2m_j$. **Item 2 is confirmed in both forms.**

## 3. The four classes

With $u=\sigma_1\sigma_2$ and $v=\sigma_1\sigma_3$ componentwise, and using $\sigma_{ij}^2=1$,
$$\langle\omega_1,\omega_2\rangle=\sum_jt_ju_j,\qquad\langle\omega_1,\omega_3\rangle=\sum_jt_jv_j,\qquad\langle\omega_2,\omega_3\rangle=\sum_jt_j\sigma_{2j}\sigma_{3j}=\sum_jt_ju_jv_j,$$
the last because $\sigma_{2j}\sigma_{3j}=(\sigma_{1j}u_j)(\sigma_{1j}v_j)=u_jv_j$. So the three displays are right.

Grouping the coordinates by $(u_j,v_j)$ and writing $T_{\pm\pm}$ for the class sums, the four conditions including the normalisation are $HT^{\mathsf T}=(0,0,0,1)^{\mathsf T}$ with
$$H=\begin{pmatrix}1&1&-1&-1\\1&-1&1&-1\\1&-1&-1&1\\1&1&1&1\end{pmatrix},$$
whose rows are the four characters of $(\mathbb Z/2)^2$. Hence $HH^{\mathsf T}=4I$, $H$ is invertible, and the solution is unique. It is $T=(\tfrac14,\tfrac14,\tfrac14,\tfrac14)$, as substitution confirms. Each $T$ is a sum of strictly positive $t_j$ over its class, so an empty class has weight $0\ne\tfrac14$ and **every class is nonempty**. *Item 3 is confirmed, uniqueness included.*

## 4. The partition count

A singleton class $\{j\}$ has $t_j=\tfrac14$. Two singletons give $t_j=t_k=\tfrac14$ with $j\ne k$, against distinctness of the $c_j^2$. So **at most one singleton** is a necessary condition, and it is also sufficient for weights to exist, since a class of size $s\ge2$ can always be filled with $s$ distinct positive reals summing to $\tfrac14$ and the classes can be kept mutually distinct. The criterion is therefore exactly the weight-existence criterion, neither weaker nor stronger, which is what the brief asks.

The enumeration of partitions of $r$ into four nonempty parts:

| $r$ | partitions into four nonempty parts | fewest singletons |
|---|---|---|
| $3$ | none | no partition |
| $4$ | $1{+}1{+}1{+}1$ | $4$ |
| $5$ | $2{+}1{+}1{+}1$ | $3$ |
| $6$ | $3{+}1{+}1{+}1$, $2{+}2{+}1{+}1$ | $2$ |
| $7$ | $4{+}1{+}1{+}1$, $3{+}2{+}1{+}1$, $2{+}2{+}2{+}1$ | $1$ |

**Every entry is correct.** *The general statement is cleaner than the case list: at most one singleton means three parts of size at least two, so $r\ge2+2+2+1=7$, with equality only at $2{+}2{+}2{+}1$.* So $r=7$ is the least $r$ the count admits, and the block's four exclusions are right as far as they go. **Section 6 shows they do not go as far as the hypotheses do.**

## 5. $r=7$: the weights exist and the triple does not

**The weights exist, in closed form.** Take denominators of $40$ and set
$$(t_1,\dots,t_7)=\left(\tfrac{4}{40},\tfrac{6}{40},\ \tfrac{3}{40},\tfrac{7}{40},\ \tfrac{2}{40},\tfrac{8}{40},\ \tfrac{10}{40}\right)=\left(\tfrac1{10},\tfrac3{20},\ \tfrac3{40},\tfrac7{40},\ \tfrac1{20},\tfrac15,\ \tfrac14\right),$$
with classes $\{t_1,t_2\}$, $\{t_3,t_4\}$, $\{t_5,t_6\}$, $\{t_7\}$. Each class sums to $\tfrac{10}{40}=\tfrac14$, the seven numerators $4,6,3,7,2,8,10$ are distinct and positive, and they total $40$, so $\sum_jt_j=1$. **So the block's existence claim is confirmed**, and $c_j=\sqrt{t_j}$ gives the spectrum of $A$ on $V=\mathbb R^{14}$.

**No triple exists at $r=7$ all the same, and the refutation is two lines.** By $(\ast)$, $\sigma_{2j}\sigma_{2k}=\sigma_{1j}\sigma_{1k}$ at every pair, so
$$u_ju_k=(\sigma_{1j}\sigma_{2j})(\sigma_{1k}\sigma_{2k})=(\sigma_{1j}\sigma_{1k})(\sigma_{2j}\sigma_{2k})=(\sigma_{1j}\sigma_{1k})^2=1 .$$
Hence $u_j=u_k$ at every pair, so $u$ is constant, $u\equiv\eta\in\{\pm1\}$. Then two of the four classes are empty: if $\eta=+1$ then $T_{-+}=T_{--}=0$, if $\eta=-1$ then $T_{++}=T_{+-}=0$. Either way a class weight is $0$ rather than $\tfrac14$, against section 3. Equivalently and more directly, $u\equiv\eta$ says $\sigma_2=\eta\sigma_1$, so $\omega_2=\eta\,\omega_1$ and $\langle\omega_1,\omega_2\rangle=\eta\ne0$.

**So what $r=7$ needs beyond weights is exactly a sign assignment**, and the sign assignment is the thing $(\ast)$ forbids. *Nothing else is needed and nothing else is free: the eigenplanes may be any orthogonal splitting of $\mathbb R^{14}$ into seven planes, and their orientations are a gauge choice that cancels.*

## 6. The sharpening, and why it needs no simple eigenvalue

**The block's box is true and is not minimal.** With $\dim E_j=2m_j$ and $\omega_i=\sum_jc_jJ_{ij}$ as in section 2, the wedge splits as
$$\omega_i\wedge\omega_i=\sum_jc_j^2\,J_{ij}\wedge J_{ij}\ +\ 2\sum_{j<k}c_jc_k\,J_{ij}\wedge J_{ik},$$
the first sum in $\bigoplus_j\Lambda^4E_j$ and the second in $\bigoplus_{j<k}\Lambda^2E_j\otimes\Lambda^2E_k$, distinct summands of the canonical splitting of $\Lambda^4V$. Equality across $i$ is therefore equality summand by summand, and at each pair $j<k$, dividing by $c_jc_k>0$,
$$J_{ij}\otimes J_{ik}=J_{1j}\otimes J_{1k}\quad\text{in }\Lambda^2E_j\otimes\Lambda^2E_k .$$
**A nonzero rank-one tensor determines its factors up to reciprocal scalars**, so $J_{ij}=\lambda J_{1j}$ and $J_{ik}=\lambda^{-1}J_{1k}$ for some $\lambda\ne0$. Both $J_{ij}$ and $J_{1j}$ are orthogonal complex structures on $E_j$, hence both of squared norm $m_j$ by section 2, so $\lambda^2=1$ and $\lambda=\pm1$. **No two-dimensional eigenspace is used anywhere in that paragraph.**

Writing $J_{ij}=\eta_{ij}J_{1j}$, well defined as soon as $r\ge2$, the pair relation reads $\eta_{ij}\eta_{ik}=1$ at every $j\ne k$, so all $\eta_{ij}$ agree for fixed $i$, say $\eta_{ij}=\eta_i$. Then $\omega_i=\eta_i\omega_1$ and $\langle\omega_1,\omega_i\rangle=\eta_i\lVert\omega_1\rVert^2\ne0$. The $\Lambda^4E_j$ components are then automatic, $J_{ij}\wedge J_{ij}=\eta_i^2J_{1j}\wedge J_{1j}=J_{1j}\wedge J_{1j}$, so they impose nothing extra, which is the block's claim in item 1 and is true here for a reason rather than by dimension. **The conclusion is a pair statement, needing only two of the three forms.**

**The block's own box already proves this and stops short of saying so.** Its line reads: the cross term $s_{i1}\,\varepsilon_1\wedge J_{ik}$ independent of $i$ gives $J_{ik}=\pm J_{1k}$ at every $k$. Spelled out, $s_{i1}J_{ik}=s_{11}J_{1k}$ gives $J_{ik}=s_{i1}s_{11}J_{1k}$, and *the sign $s_{i1}s_{11}$ does not depend on $k$*. So the box's own equation delivers one sign for all $k$ at once, which is $\omega_i=\pm\omega_1$, and not the free per-index signs $\sigma_{ij}$ its next clause writes down.

**The arithmetic of the weakening claim is right and the claim is moot.** Distinct $c_j^2$ with equal $t_j$: take $c_j^2=\tfrac18$ with $m_j=2$ and $c_k^2=\tfrac14$ with $m_k=1$, so $t_j=t_k=\tfrac14$ with $c_j^2\ne c_k^2$, on eigenspaces of dimensions four and two. **So two singleton classes are indeed consistent with the weights.** *It changes nothing, because the count is never what closes the case: the sign rigidity closes every stratum with $r\ge2$ before the classes are consulted.*

## 7. The frontier, corrected

**"Every eigenvalue of $A$ of multiplicity at least four" is not what is left untouched.** Section 6 empties every stratum with $r\ge2$, at all multiplicities, so a stratum such as $\dim V=8$ with $A$ of spectrum $\{a,a,a,a,b,b,b,b\}$, $a\ne b$, which has both multiplicities four and is untouched on the block's account, is in fact closed. **What survives is exactly $r=1$**, that is $A=\tfrac1m\mathrm{Id}_{2m}$ on $V=\mathbb R^{2m}$, the value being forced by $\mathop{\mathrm{tr}}A=2$.

There the question is concrete and Weyl-free:

> **Do there exist three orthogonal complex structures $J_1,J_2,J_3$ on $\mathbb R^{2m}$, pairwise trace-orthogonal, with $J_1\wedge J_1=J_2\wedge J_2=J_3\wedge J_3$?** The triple is then $\omega_i=m^{-1/2}J_i$.

| $m$ | $\dim V$ | status |
|---|---|---|
| $1$ | $2$ | empty, $\omega_i=\pm\varepsilon_1$ and orthogonality fails |
| $2$ | $4$ | **inhabited**, any orthonormal basis of $\Lambda^+\mathbb R^4$, which is the padded $W_{\mathbb{CP}^2}$ witness |
| $3$ | $6$ | empty, by [L184](../findings/diagonal-half.md) case 2 via $\star_V(J\wedge J)=2\epsilon_JJ$ |
| $\ge4$ | $\ge8$ | **open**, and this is the whole of the remaining coincident question |

**Nothing cheap closes $\dim V=8$, and the obvious candidate fails.** *The diagonal quaternionic triple on $\mathbb R^8=\mathbb H^2$, with $I,J,K$ acting on both factors, is pairwise trace-orthogonal and each is a complex structure, but $I\wedge I$ and $J\wedge J$ differ*: within each $\mathbb H$ factor the self-wedges agree, both being twice the volume form, while the cross term of $I\wedge I$ is $2\,\omega_I^{(1)}\otimes\omega_I^{(2)}$ against $2\,\omega_J^{(1)}\otimes\omega_J^{(2)}$, and two rank-one tensors with non-proportional first factors are unequal. The same rank-one obstruction kills every $J_i=\alpha_i\oplus\beta_i$ built on one fixed $4{+}4$ splitting. **Nothing cheap inhabits it either**, and the honest statement is that $\dim V\ge8$ with $A$ scalar is open.

*A handle worth recording: polarising the wedge condition, $J_1\wedge J_1=J_2\wedge J_2$ is $(J_1-J_2)\wedge(J_1+J_2)=0$, and the two factors are automatically orthogonal because $J_1$ and $J_2$ have equal norms. At $\dim V=4$ that is solved by any two orthogonal self-dual forms, which is exactly why the witness lives there.*

## 8. Scope and hypotheses

**No step anywhere uses Ricci-flatness, first Bianchi, or membership in $\mathcal W_n$.** The block is a statement about three $2$-forms and nothing else, and the same is true of the corrected argument in section 6. That matches [L184](../findings/diagonal-half.md), whose own box records that its route uses no Weyl hypothesis at all.

**$V$ is the full common support and that is load-bearing where the block says.** Positive definiteness of $A$ is what makes $c_jc_k>0$, and the division by it is the cross-term step. *If $\omega_i$ had a kernel, $A$ would carry the eigenvalue $0$, no $\varepsilon$ would be defined on that block, and every pair meeting it would impose nothing.* Since the squares are common, the supports are common and restricting to the support is free, so this is a normalisation rather than a restriction. The parametrisation $\dim V=2r$ is then forced, not assumed.

**Orthonormality is used more than it needs to be, in two separate ways.** Equal norms are not a hypothesis at all, being forced by the common square as shown in section 2. The unit value is a scale, and the four-class conclusion is scale-free, the system $HT^{\mathsf T}=(0,0,0,s)^{\mathsf T}$ giving $T=(\tfrac s4,\tfrac s4,\tfrac s4,\tfrac s4)$ at any $s>0$. **What is genuinely needed is one orthogonality**, $\langle\omega_1,\omega_2\rangle=0$, spent at the last line of section 6 against $\omega_2=\pm\omega_1$. The block spends all three, because its route through the classes requires all three displays.

## 9. Falsifiers, and what I did

**The lemma falls if a coincident triple exists at $\dim V\in\{8,10,12\}$ in the all-simple stratum.** No such triple exists, and section 5's two-line argument shows why none can, at any $r$, so this half of the lemma is safe in the strongest possible sense.

**The header falls if the all-simple stratum is empty at $r=7$**, and section 5 exhibits that emptiness in closed form. **My own strengthening falls if some $\omega_2$ has $\omega_2^2=\omega_1^2$, $\omega_2\wedge\omega_2=\omega_1\wedge\omega_1$, $A$ with at least two distinct eigenvalues, and $\omega_2\ne\pm\omega_1$.** Section 6 rules that out by rank-one rigidity, so the only place to look for one is a failure of the canonical splitting of $\Lambda^4V$ or of the rank-one uniqueness, and both are standard.

**What I did to look**: I re-derived the splitting of $\Lambda^4(\bigoplus E_j)$ from scratch, checked the component formula against both the record's index convention and the exterior-algebra one at a concrete $4{+}4$ example in section 1, and tested the surviving $r=1$ stratum at $\dim V=8$ against the quaternionic triple in section 7, which fails the wedge condition rather than satisfying it. **No search, sweep, census, optimisation, screen or computation of any kind was run**, in keeping with the analysis-only footing the brief carries.

## Discrepancies, under the protocol

### D1. The header's second half is false, by the block's own discarded line

**Located.** The header, "the all-simple coincident stratum is empty up to $\dim V=12$, **and first possible at $14$**", and the Statement's bolded "$r=7$ is the first value not excluded", and the proof's last sentence, "At $r=7$ the partition $2+2+2+1$ has exactly one, and weights exist".

**The failure, in closed form.** The proof derives $(\ast)$, "$\sigma_{ij}\sigma_{ik}$ independent of $i$, at every pair $j<k$", and then uses only that the three sign vectors are $t$-orthogonal. But $(\ast)$ gives $u_ju_k=(\sigma_{1j}\sigma_{1k})^2=1$ at every pair, so $u$ is constant, so $\omega_2=\pm\omega_1$ and $\langle\omega_1,\omega_2\rangle=\pm1$. At the block's own $r=7$ weights this reads: two of the four classes are empty, against $T=\tfrac14$ each. **The stratum is empty at every $r\ge1$**, so $\dim V=14$ is not possible and neither is any other dimension.

**The opposite, argued.** The most charitable reading of the Statement's sentence is "$r=7$ is the first value not excluded *by this count*", which is literally true, the count being the four-class argument alone. Under that reading the Statement is a true remark about a method. **The header is not readable that way**: "first possible at $14$" is a claim about the stratum, as is the title's implicit contrast between "empty up to $12$" and what happens above it, and the closing box's "the count that closes it is the same one that runs out at twelve" turns the method's limit into the object's limit. *The charitable reading rescues one sentence and leaves the header, the title and two boxes asserting something false.*

### D2. The stated frontier is wrong, and the true one is smaller

**Located.** The box "WHAT IT DOES NOT REACH, AND THE WITNESS SHOWS WHY", at "the cross-term step needs a two-dimensional eigenspace to convert a complex structure into a sign", and the box "WHAT IS LEFT UNTOUCHED IS EXACTLY: EVERY EIGENVALUE OF $A$ OF MULTIPLICITY AT LEAST FOUR".

**The failure, in closed form.** Section 6. The cross-term equation at any multiplicities is $J_{ij}\otimes J_{ik}=J_{1j}\otimes J_{1k}$ in $\Lambda^2E_j\otimes\Lambda^2E_k$, a rank-one tensor identity, which gives $J_{ij}=\lambda J_{1j}$ with $\lambda=\pm1$ by equality of norms. A concrete stratum the box declares untouched and the argument closes: $\dim V=8$ with $A$ of spectrum $\{a,a,a,a,b,b,b,b\}$ and $a\ne b$, where both multiplicities are four.

**The opposite, argued.** Read as a statement about the reduction *as the block writes it*, in signs $\sigma_{ij}$ obtained from a plane, the box is true: that particular conversion does need a plane. **But the box says "untouched" and "the frontier this lemma stops at", which are claims about the question**, and the question is closed there by the same cross term one line up. *The witness is still correctly placed: padded $W_{\mathbb{CP}^2}$ has $r=1$, and $r=1$ is genuinely the surviving stratum.*

### D3. The sharpening box contradicts its own next clause

**Located.** "THE REDUCTION TO SIGNS NEEDS ONE SIMPLE EIGENVALUE": the equation "$s_{i1}\,\varepsilon_1\wedge J_{ik}$ being independent of $i$" and the clause "So $\omega_i=\sum_jc_j\sigma_{ij}J_j$ for one family $J_j$".

**The failure, in closed form.** The equation is $s_{i1}J_{ik}=s_{11}J_{1k}$, so $J_{ik}=(s_{i1}s_{11})J_{1k}$ with a sign that is the same for every $k$, and on $E_1$ itself $\omega_i|_{E_1}=c_1s_{i1}\varepsilon_1=(s_{i1}s_{11})\,\omega_1|_{E_1}$. So $\omega_i=(s_{i1}s_{11})\,\omega_1$ exactly, and $\langle\omega_1,\omega_i\rangle=\pm1$. **The free per-$j$ signs $\sigma_{ij}$ of the next clause do not exist**, and with them goes the weighted orthogonality the box hands to the following box.

**The opposite, argued.** One could read $\sigma_{ij}$ as merely *permitted* to vary rather than asserted to, the clause being a parametrisation of a superset. That reading is available, and the box then says something true and weak. **It is not the reading the next box takes**, which builds a count on those signs varying and concludes that two singleton classes are consistent.

### D4. The Statement's enumeration and the header's range disagree at the bottom

**Located.** Header "empty up to $\dim V=12$" against Statement "no such triple exists at $r\in\{3,4,5,6\}$", which is $\dim V\in\{6,8,10,12\}$ and omits $\dim V\in\{2,4\}$.

**The failure.** Low severity and self-repairing: $r=1$ and $r=2$ cannot fill four nonempty classes either, so the block's own count covers them and the header's range is true. *At $r=2$ the same $u_ju_k=1$ closes it in one line, and at $r=1$ orthogonality alone does, $\langle\omega_1,\omega_2\rangle=\pm t_1=\pm1$.*

**The opposite, argued.** The enumeration may be deliberate, $r\ge3$ being where the record's interest starts, since $\dim V=4$ is the inhabited case in the *other* stratum. **Recorded as a wording note rather than a defect.**

## What the lemma should say

The corrected statement is a pair statement, it carries no dimension, and it subsumes both L195 and [L184](../findings/diagonal-half.md)'s cases 1 and 3:

> **Let $\omega_1,\omega_2$ be $2$-forms on $V$ with $\omega_1^2=\omega_2^2=-A$, $A$ positive definite, and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. If $A$ has at least two distinct eigenvalues then $\omega_2=\pm\omega_1$.** *Hence an orthogonal pair with both coincidences forces $A$ to be a multiple of the identity, and the coincident case at every dimension reduces to three pairwise trace-orthogonal orthogonal complex structures with a common self-wedge.*

**The proof is section 6 and it is five lines**, the only ingredients being the canonical splitting of $\Lambda^4V$, uniqueness of the factors of a rank-one tensor, and $\langle J,J\rangle=m$. *It is the mechanism [L184](../findings/diagonal-half.md) case 3 already used at $\dim V=6$, which is the reason to expect it to have been available all along.*

## Verdict

**CONFIRMED IN ITS EMPTINESS, REFUTED IN ITS BOUNDARY.** *Every step of the proof as written is valid, every arithmetic claim in it checks out, and the $r=7$ weights exist as claimed.* **What is wrong is the conclusion drawn around them**: the block derives the sign condition $(\ast)$, uses a strict consequence of it, and then reports the limit of that consequence as the limit of the object, so "first possible at $14$" is false, the stated frontier at multiplicity four is false, and the sharpening box refutes its own next clause. **The lemma is true, and true far beyond what it claims**: the all-simple coincident stratum is empty at every dimension, the whole coincident case with $A$ non-scalar is empty at every dimension and every multiplicity, and what remains of the rank-three question is one concrete problem at $\dim V\ge8$ with $A$ a multiple of the identity.
