# r805, Gate 2 on L188 (full rank at $\dim V=8$, the factoring of Bianchi, and the constant norm ratio)

*Cold brief: I was given the three claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) and [L188Statement.lean](../lean/HamiltonsCubic/Results/L188Statement.lean) from scratch. **No numerical work was done**; every value below is exact and every derivation is by hand. Three machine actions were screens, reported as screens and never as evidence for a positive claim: an exterior-algebra identity check on constructed forms (§1, §5.1), a symbolic solve of one linear system on constructed data (§5.5), and `lake build HamiltonsCubic.Results.L188Statement`, which completed over 8710 jobs with no `sorry` and one unused-variable lint. Log: [agent_logs/g2-l188-r805.log](../agent_logs/g2-l188-r805.log).*

| Claim | Verdict |
|---|---|
| **1**, both non-decomposable forms have full rank eight, by $\mathrm{Pf}(\omega_1)=c^2\mathrm{Pf}(\omega_2)$ | **CONFIRMED** |
| **1.1**, $\omega_1\wedge\omega_1=c\,(\omega_2\wedge\omega_2)$ gives $\omega_1^4=c^2\omega_2^4$, and $\omega^4=4!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$ on $\mathbb R^8$ carries the constant claimed | **CONFIRMED** |
| **2**, first Bianchi factors as $\alpha\wedge\beta=0$, with $\lVert\alpha\rVert^2=\lVert\beta\rVert^2=1+c$ and $\langle\alpha,\beta\rangle=1-c$ | **CONFIRMED**, and $c\in(0,1)$ under the lemma's own sign arrangement, so $\langle\alpha,\beta\rangle>0$ strictly |
| **3**, $\lambda_1A_1-\lvert\lambda_2\rvert A_2$ is PSD of rank exactly two, giving $\lambda_1\lVert\omega_1x\rVert^2=\lvert\lambda_2\rvert\lVert\omega_2x\rVert^2$ on the six-dimensional $P_3^\perp\cap V$ | **CONFIRMED** |
| **The [L180](../findings/diagonal-half.md)(3) import**, $V=\mathop{\mathrm{supp}}\omega_1$, $P_3\subseteq V$, $\omega_2\in\Lambda^2V$ | **CONFIRMED**, with one unstated relabelling (§2) |
| **Inhabitation of the configuration at $\dim V=8$** | **REFUTED, the branch is EMPTY**, by Bianchi and orthonormality alone on top of L180(3); §5 |
| **The lemma's forward framing** ("the shape the next attempt has to work with", "where the next attempt should start") | **REFUTED as a description of open ground**, the two constraints it names, used together, close the branch |

**One line.** *All three claims are correct as stated and the [L178](../findings/diagonal-half.md) import is clean, but the configuration they describe **does not exist**: splitting first Bianchi over $\mathbb R^8=P_3\oplus(P_3^\perp\cap V)$ gives four equations whose $\Lambda^4$ and $\Lambda^3$ parts force the common kernel of the two $\Lambda^2P_3^\perp$-blocks into the kernel of both forms, contradicting the full rank Claim 1 establishes, so this is the **fourth consecutive lemma of the line that is right about an empty class**, and the emptiness follows from exactly the two constraints the lemma says have not been used together.*

## 0. Conventions, fixed once

- $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$, the $\omega_i$ orthonormal in $\Lambda^2\mathbb R^n$, every $\lambda_i\ne0$, $W$ Ricci-flat and satisfying first Bianchi. $V$ is the span of the supports, and $W$ is supported on $\Lambda^2V$ by [L179](../findings/diagonal-half.md)(a).
- A $2$-form's **support** is the image of the skew map it names; $\mathop{\mathrm{rank}}\omega=\dim\mathop{\mathrm{supp}}\omega$. **Decomposable** $\iff\omega\wedge\omega=0\iff\mathop{\mathrm{rank}}\le2$. $\omega^j\ne0\iff j\le\tfrac12\mathop{\mathrm{rank}}\omega$.
- The branch: $\omega_1,\omega_2$ non-decomposable, $\omega_3$ decomposable with unit area form on the plane $P_3$, so $A_3=\omega_3\omega_3^{\mathsf T}=\Pi_3$; weights $\lambda_1>0>\lambda_2$ by [L186](../findings/diagonal-half.md)'s rank count, $\lambda_3<0$ under the lemma's arrangement, $\lambda_1=\lvert\lambda_2\rvert+\lvert\lambda_3\rvert$; $c=-\lambda_2/\lambda_1=\lvert\lambda_2\rvert/\lambda_1\in(0,1)$; $\dim V=8$.
- On an **oriented** $2m$-dimensional inner-product space, $\mathrm{Pf}(\omega)=s_1\cdots s_m$ in a positively-oriented adapted frame and $\omega^m=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$; $\det\omega=\mathrm{Pf}(\omega)^2$.
- On $\mathbb R^6$, $\sigma(\omega)=\star(\omega\wedge\omega)/2$, quadratic, with $\sigma(\sigma(\omega))=\mathrm{Pf}(\omega)\,\omega$, [L187](../findings/diagonal-half.md)'s identity, signs verified by [r802](REVIEW_r802.md) and [r803](REVIEW_r803.md) and re-screened here.
- Write $W_6:=P_3^\perp\cap V$, of dimension six by §4.

## 1. Hypothesis inventory

| Hypothesis | Used where | Status |
|---|---|---|
| Orthonormality of the triple | Claim 2's norms; §5.2 and §5.3's contradictions; §5.4's independence | used, and load-bearing in §5 |
| $\lambda_i\ne0$, $\sum\lambda_i=0$ | the sign split, $c>0$, $c<1$ | used |
| Opposite signs on $\lambda_1,\lambda_2$ | $c>0$, hence $\sqrt c$ exists | used, and it is a **theorem** ([L186](../findings/diagonal-half.md)'s rank count) rather than an assumption |
| Ricci-flatness | only through [L180](../findings/diagonal-half.md)(3) and Claim 3's identity | used |
| First Bianchi | $\omega_1\wedge\omega_1=c\,(\omega_2\wedge\omega_2)$; §5's four equations | used |
| $\omega_3$ decomposable | dropping its Bianchi term; $A_3=\Pi_3$; the $\Lambda^2P_3$ component of $\omega_1,\omega_2$ vanishing | used |
| $\dim V=8$ | $\mathrm{Pf}$ on $\mathbb R^8$; $\dim W_6=6$, which is what makes $\sigma$ exist in §5.2–§5.3 | used, and §5 is a statement about this dimension alone |
| $\dim V\le6$ | nowhere | **the L187 defect is absent here**, §6 |

**The screen behind §1's wedge facts.** On constructed skew matrices: $\omega^4$'s $e_{12345678}$ coefficient matched $24\,\mathrm{Pf}(\omega)$ to $3\times10^{-13}$; $\sigma(\sigma(C))$ matched $+\mathrm{Pf}(C)\,C$ to $3\times10^{-15}$ on $\mathbb R^6$; $\sigma$ of a rank-four $C=e_{01}+2e_{23}$ returned $2\,e_{45}$, the area form of $\ker C$ scaled by the sub-Pfaffian. Screens, not evidence.

## 2. The [L180](../findings/diagonal-half.md)(3) import. CONFIRMED, with one unstated relabelling

L180(3) says the support $V$ is the support of the **minority-sign** form, under Ricci-flatness and rank three alone, and that the other two supports sum to it. Here $\lambda_1>0>\lambda_2$, so the minority is whichever of $\omega_1,\omega_2$ disagrees in sign with $\lambda_3$. The lemma writes $\lambda_1A_1=\lvert\lambda_2\rvert A_2+\lvert\lambda_3\rvert\Pi_3$, which **fixes $\lambda_3<0$ and $\omega_1$ as the minority**; that is a relabelling of the two non-decomposable forms, legitimate because the branch is symmetric under swapping them ($c\mapsto1/c$), and **it is not stated**. With it:

$$\mathop{\mathrm{supp}}\omega_2+\mathop{\mathrm{supp}}\omega_3=\mathop{\mathrm{supp}}\omega_1=V,\qquad \dim V=8 .$$

So $\mathop{\mathrm{rank}}\omega_1=8$, $P_3\subseteq V$ and $\omega_2\in\Lambda^2V$, the three things Claims 1 and 3 draw on, all present. *The other labelling gives $c>1$ and the same conclusions with the indices swapped, so nothing in §5 depends on the choice.*

## 3. Claim 1. CONFIRMED

**The wedge step.** $\eta_1:=\omega_1\wedge\omega_1$ and $\eta_2:=\omega_2\wedge\omega_2$ satisfy $\eta_1=c\,\eta_2$ in $\Lambda^4V$, so $\eta_1\wedge\eta_1=c^2\,\eta_2\wedge\eta_2$ by bilinearity of the wedge, that is $\omega_1^4=c^2\,\omega_2^4$. Nothing beyond bilinearity is used, and no commutation is needed at this step.

**The constant.** On the oriented eight-dimensional $V$, $\omega^4=4!\,\mathrm{Pf}(\omega)\,\mathrm{vol}=24\,\mathrm{Pf}(\omega)\,\mathrm{vol}$. The $24$ appears on both sides and cancels, leaving $\mathrm{Pf}(\omega_1)=c^2\,\mathrm{Pf}(\omega_2)$ exactly as written. **Both forms lie in $\Lambda^2V$** (§2), so a single $\mathrm{Pf}$, relative to $V$'s volume, serves both, the step that would fail if $\omega_2$ left $V$.

**The conclusion.** $\mathop{\mathrm{rank}}\omega_2<8$ gives $\omega_2^4=0$, hence $\mathrm{Pf}(\omega_2)=0$, hence $\mathrm{Pf}(\omega_1)=0$, hence $\det\omega_1=0$ and $\mathop{\mathrm{rank}}\omega_1<8$, against $\mathop{\mathrm{rank}}\omega_1=\dim V=8$. So $\mathop{\mathrm{rank}}\omega_2=8$. **The content of Claim 1 is entirely about $\omega_2$**: $\omega_1$'s full rank is §2's import and holds before any Pfaffian is taken. *The claim's own wording ("both … have full rank eight"), reads as if the argument delivered both, and it delivers one.*

## 4. Claims 2 and 3. CONFIRMED

**Claim 2.** For $2$-forms $\omega_1\wedge\omega_2=\omega_2\wedge\omega_1$, the degree product being even, so with $\alpha=\omega_1-\sqrt c\,\omega_2$ and $\beta=\omega_1+\sqrt c\,\omega_2$ the cross terms cancel and $\alpha\wedge\beta=\omega_1\wedge\omega_1-c\,(\omega_2\wedge\omega_2)=0$. The degree argument is right. $\sqrt c$ exists because $c=\lvert\lambda_2\rvert/\lambda_1>0$, which [L186](../findings/diagonal-half.md)'s rank count **proves** rather than assumes. Orthonormality gives $\lVert\alpha\rVert^2=\lVert\beta\rVert^2=1+c$ and $\langle\alpha,\beta\rangle=1-c$, and $\lVert\alpha\rVert^2=1+c>0$ is a shorter route to "both nonzero" than the dependence argument recorded. **One thing sharpens.** Under §2's arrangement $\lambda_1=\lvert\lambda_2\rvert+\lvert\lambda_3\rvert$, so $c\in(0,1)$ strictly and $\langle\alpha,\beta\rangle=1-c>0$: the two factors are never orthogonal, and $\lVert\alpha\rVert\lVert\beta\rVert=1+c>1-c$ keeps them independent. *The reformulation is exactly equivalent to Bianchi, adding no information, which is what the lemma says it is.*

**Claim 3.** $\lambda_1A_1-\lvert\lambda_2\rvert A_2=\lvert\lambda_3\rvert\Pi_3$ is the Ricci identity rearranged, and $\Pi_3$ is an orthogonal projection onto a plane with $\lvert\lambda_3\rvert>0$, so PSD of rank exactly two, immediately. Reading it at $x\in P_3^\perp\cap V$ kills $\Pi_3x$, and $\langle A_ix,x\rangle=\lVert\omega_i^{\mathsf T}x\rVert^2=\lVert\omega_ix\rVert^2$, giving $\lambda_1\lVert\omega_1x\rVert^2=\lvert\lambda_2\rvert\lVert\omega_2x\rVert^2$. $P_3\subseteq V$ by §2, so $\dim(P_3^\perp\cap V)=8-2=6$. The ratio is $\sqrt{\lvert\lambda_2\rvert/\lambda_1}=\sqrt c$, well defined because $\omega_2$ is full rank on $V$ by Claim 1. **All four sub-assertions hold.** *"Two positive definite matrices" is right on $V$ and false on $\mathbb R^n$, where both $A_i$ have kernel $V^\perp$; the lemma's "with both forms full rank" carries this, just.*

## 5. Inhabitation. The branch at $\dim V=8$ is EMPTY

*This is the attack item that decided [L185](../findings/diagonal-half.md), [L186](../findings/diagonal-half.md) and [L187](../findings/diagonal-half.md), and it decides this one. The derivation below uses first Bianchi, orthonormality, and §2's imports, Ricci-flatness enters nowhere else.*

### 5.1 The splitting

Work inside $V\cong\mathbb R^8=P_3\oplus W_6$ with $P_3=\langle e_1,e_2\rangle$. Since $\omega_3$ is the unit area form of $P_3$, it spans $\Lambda^2P_3$, and $\langle\omega_i,\omega_3\rangle=0$ **kills the $\Lambda^2P_3$ component of $\omega_1$ and of $\omega_2$**. So

$$\omega_i=e_1\wedge u^1_i+e_2\wedge u^2_i+C_i,\qquad u^j_i\in W_6^*,\ C_i\in\Lambda^2W_6 .$$

Then, using $e_1\wedge u\wedge e_2\wedge v=-e_1\wedge e_2\wedge u\wedge v$,

$$\omega_i\wedge\omega_i=-2\,e_1\wedge e_2\wedge(u^1_i\wedge u^2_i)+2\,e_1\wedge(u^1_i\wedge C_i)+2\,e_2\wedge(u^2_i\wedge C_i)+C_i\wedge C_i,$$

whose four summands lie in the independent pieces $e_{12}\wedge\Lambda^2W_6$, $e_1\wedge\Lambda^3W_6$, $e_2\wedge\Lambda^3W_6$, $\Lambda^4W_6$ of $\Lambda^4V$. *Screened against a constructed random block form: maximum coefficient discrepancy $9\times10^{-16}$.* First Bianchi $\omega_1\wedge\omega_1=c\,(\omega_2\wedge\omega_2)$ therefore splits into

$$\text{(i) } u^1_1\wedge u^2_1=c\,u^1_2\wedge u^2_2,\quad \text{(ii) } u^1_1\wedge C_1=c\,u^1_2\wedge C_2,\quad \text{(iii) } u^2_1\wedge C_1=c\,u^2_2\wedge C_2,\quad \text{(iv) } C_1\wedge C_1=c\,C_2\wedge C_2 .$$

### 5.2 Both $C_i$ have rank at least four

In the block form $\omega_i=\begin{pmatrix}0&B_i\\-B_i^{\mathsf T}&C_i\end{pmatrix}$ with $B_i$ of size $2\times6$ carrying the rows $u^1_i,u^2_i$, the column ranks give $\mathop{\mathrm{rank}}\omega_i\le2+\mathop{\mathrm{rank}}B_i+\mathop{\mathrm{rank}}C_i\le4+\mathop{\mathrm{rank}}C_i$. Both forms are full rank eight (§2 and Claim 1), so $\mathop{\mathrm{rank}}C_i\ge4$ for $i=1,2$. **In particular $C_i\wedge C_i\ne0$ and $C_i$ is not of the form $a\wedge v$**, so by exactness of $\Lambda^\bullet W_6\xrightarrow{a\wedge}\Lambda^{\bullet+1}W_6$,

$$a\wedge C_i=0\ \Longrightarrow\ a=0\qquad\text{for }a\in W_6^* . \tag{$\ast$}$$

### 5.3 Rank six is impossible, and so is $C_1\parallel C_2$

Suppose $\mathop{\mathrm{rank}}C_1=6$. Applying $\star$ to (iv), $\sigma(C_1)=c\,\sigma(C_2)$; applying the quadratic $\sigma$ again, $\mathrm{Pf}(C_1)\,C_1=c^2\,\mathrm{Pf}(C_2)\,C_2$, so $C_2=k\,C_1$ with $k\ne0$. Then (iv) reads $C_1\wedge C_1=ck^2\,C_1\wedge C_1$ with $C_1\wedge C_1\ne0$, forcing $ck^2=1$, i.e. $1/k=ck$. Now (ii) becomes $(u^1_1-ck\,u^1_2)\wedge C_1=0$, so $u^1_1=ck\,u^1_2$ by $(\ast)$, and likewise $u^2_1=ck\,u^2_2$; and $C_1=k^{-1}C_2=ck\,C_2$. Hence $\omega_1=ck\,\omega_2$ and $\langle\omega_1,\omega_2\rangle=ck\ne0$, **against orthonormality**. The same run with the roles of the indices exchanged excludes $\mathop{\mathrm{rank}}C_2=6$, and the run needs only $\mathop{\mathrm{rank}}C_1\ge4$ for $(\ast)$, so it **also excludes $C_2=k\,C_1$ at rank four**. Therefore

$$\mathop{\mathrm{rank}}C_1=\mathop{\mathrm{rank}}C_2=4,\qquad C_1,C_2\ \text{linearly independent}.$$

### 5.4 The two blocks share a kernel

For a rank-four $C\in\Lambda^2W_6$ with support $S_C$ and kernel $K_C$, $C\wedge C=2\,\mathrm{Pf}_{S_C}(C)\,\mathrm{vol}_{S_C}\ne0$, so $\sigma(C)=\mathrm{Pf}_{S_C}(C)\,\mathrm{vol}_{K_C}$ up to sign, **a nonzero decomposable $2$-form supported on the kernel**. From $\sigma(C_1)=c\,\sigma(C_2)$ with $c\ne0$ and both sides nonzero, the two decomposable forms are proportional, hence

$$K:=\ker C_1=\ker C_2,\qquad \dim K=2,\qquad C_1,C_2\in\Lambda^2S,\ \ S:=K^\perp\cap W_6,\ \dim S=4 .$$

### 5.5 And then $K$ lies in the kernel of both forms

Split $u=u_K+u_S$ along $W_6=K\oplus S$. For $C\in\Lambda^2S$ the two pieces $u_K\wedge C\in K^*\wedge\Lambda^2S$ and $u_S\wedge C\in\Lambda^3S$ lie in different summands of $\Lambda^3W_6$, so (ii) splits, and its $K$-part in a basis $f^1,f^2$ of $K^*$ reads componentwise

$$p_1\,C_1=c\,p_2\,C_2,\qquad q_1\,C_1=c\,q_2\,C_2,\qquad u^1_{i,K}=p_i f^1+q_i f^2 .$$

$C_1$ and $C_2$ are linearly independent by §5.3, so $p_1=p_2=q_1=q_2=0$: **$u^1_{1,K}=u^1_{2,K}=0$**, and (iii) gives $u^2_{1,K}=u^2_{2,K}=0$ the same way. So $B_i$ annihilates $K$, and $C_i$ annihilates $K$ by construction, whence $K\subseteq\ker\omega_i$ and $\mathop{\mathrm{rank}}\omega_i\le6$ for both $i$.

**That contradicts $\mathop{\mathrm{rank}}\omega_1=\dim V=8$.** The configuration does not exist. $\square$

*Screen of the load-bearing step, on constructed data: $S=\langle f_0,\dots,f_3\rangle$, $K=\langle f_4,f_5\rangle$, $C_1=f_{01}+2f_{23}$, $C_2=f_{01}+8f_{23}$, $c=1/4$, which satisfies (iv) exactly, both sides $4f_{0123}$. Solving (ii) symbolically over the twelve unknowns returned the single family $p_0=q_0$, $p_1=q_1$, $p_2=q_2/4$, $p_3=q_3/4$, $p_4=p_5=q_4=q_5=0$: the $K$-components are forced to zero, as derived. A screen, not the argument.*

### 5.6 What this costs the lemma, and what it does not

- **Every claim of L188 stays true.** They are true of an empty class, so the lemma is **correct and vacuous**, the same shape as [L185](../findings/diagonal-half.md) (empty by Ricci alone) and [L186](../findings/diagonal-half.md) (empty by Bianchi alone). Here it is Bianchi and orthonormality, on top of L180(3).
- **The lemma's closing instruction is answered rather than open.** It says the two constraints "have not been used together, and that is where the next attempt should start". §5 is that attempt: $\alpha\wedge\beta=0$ is (i)–(iv), and Claim 1's full rank is what (ii)–(iv) contradict. *Claim 3's constant norm ratio is not needed.*
- **The census moves.** Two non-decomposable forms are now empty at $\dim V\in\{4,6\}$ ([L187](../findings/diagonal-half.md)'s $\sigma$ route), at $\{10,14,\dots\}$ ([r802](REVIEW_r802.md)'s $\tau$ route) and at $8$ (§5), leaving **$\dim V\in\{12,16,20,\dots\}$**; three non-decomposable remains open and untouched.
- **The argument is specific to eight.** It runs on $\dim W_6=6$, where $\star$ sends $\Lambda^4$ to $\Lambda^2$ and $\sigma$ exists. At $\dim V=12$ the complement is ten-dimensional and §5.3–§5.4 have no analogue, so **nothing here reaches $\{12,16,\dots\}$**.

## 6. The remaining attack items

- **Anything carried from a neighbouring configuration**, the failure mode of [L187](../findings/diagonal-half.md). **Nothing found.** Every hypothesis L188 uses is discharged inside its own branch: $c>0$ from [L186](../findings/diagonal-half.md)'s rank count, $V=\mathop{\mathrm{supp}}\omega_1$ and $P_3\subseteq V$ from [L180](../findings/diagonal-half.md)(3) at rank three, $\mathop{\mathrm{rank}}\omega_1=8$ from $\dim V=8$. **In particular $\dim V\le6$ (L187's circular premise), appears nowhere**, and Claim 1 is the correct replacement for it: it derives a rank rather than assuming one.
- **The [L178](../findings/diagonal-half.md) import flagged by the lemma's own note.** Not circular, and I reach the same reading as the two reviewers cited: L178's step 1 is applied under the hypothesis $\dim V=4$ to contradict "exactly two non-decomposable", which is a conditional.
- **The Lean statement.** It builds. Two remarks on scope rather than correctness. `factor_norms` is docstringed as "the norms of the two factors" but states $(1+c)-(1-c)=2c$, an arithmetic identity that mentions no form and no norm, **the norms of Claim 2 are not typed**; and its `hc : 0 < c` is unused, as is `full_rank_of_pf`'s `hc : c ≠ 0` (the build's one lint). `factor_of_comm` and `bianchi_factors` over a `CommRing` do capture the whole of Claim 2's algebra, as the file says. **The file's own "What is NOT typed here" is accurate**, save that it should add the norms to the list.
- **Nothing was found against Claims 1, 2 or 3 themselves.** The two wordings worth tightening are §3's "both … have full rank" (the argument delivers $\omega_2$; $\omega_1$ is imported) and §2's unstated relabelling.

## Verdict

**PROVEN, and vacuous.** All three claims are correct, the imports are sound, and no step is circular; but the configuration is **empty at $\dim V=8$**, so L188 states three true facts about nothing. The record should carry §5 as the emptiness proof, move the census to $\dim V\in\{12,16,\dots\}$ for the two-non-decomposable case, and retire the closing paragraph that points the next attempt at ground now closed.

## 7. Added after the derivation above was complete: [r804](REVIEW_r804.md)'s route, checked, and one correction to §5.6

*The sibling Gate 2 review committed while §§0–6 were being written. I read it only after my own derivation was fixed in text, and I record it here rather than folding it in, so the independence of §5 stays visible.* **It reaches the same emptiness by a shorter argument, and that argument is correct and strictly stronger than mine.**

Put $N=\sqrt{\lambda_1}\,\omega_1$ and $M=\sqrt{\lvert\lambda_2\rvert}\,\omega_2$. Ricci is $NN^{\mathsf T}=MM^{\mathsf T}+\lvert\lambda_3\rvert\Pi_3$ and Bianchi is $N\wedge N=M\wedge M$. At $\dim V=2m$ with $m$ **even**, $N^{\wedge m}=(N\wedge N)^{\wedge m/2}=(M\wedge M)^{\wedge m/2}=M^{\wedge m}$, so $\mathrm{Pf}(N)=\mathrm{Pf}(M)$ and $\det(NN^{\mathsf T})=\mathrm{Pf}(N)^4=\mathrm{Pf}(M)^4=\det(MM^{\mathsf T})$. But $MM^{\mathsf T}$ is positive definite on $V$ (Claim 1 in the form $\mathrm{Pf}(M)\ne0$) and $\lvert\lambda_3\rvert\Pi_3$ is nonzero PSD, so $\det(NN^{\mathsf T})=\det(MM^{\mathsf T})\det(I+(MM^{\mathsf T})^{-1/2}\lvert\lambda_3\rvert\Pi_3(MM^{\mathsf T})^{-1/2})>\det(MM^{\mathsf T})$. **Every step checks.** *Screen of the determinant inequality on a constructed positive definite $P$ and rank-two $Q$: $\det(P+Q)-\det(P)=+7922.9$.*

- **Both Ricci and Bianchi are used**, where §5 uses Ricci only through [L180](../findings/diagonal-half.md)(3), so the two derivations are genuinely different and neither is a rediscovery of the other.
- **The only use of $\dim V=8$ is that $m$ is even**, so it empties $\dim V\equiv0\pmod4$ entirely. **§5.6's census bullet is therefore too weak and is corrected here**: with [r802](REVIEW_r802.md)'s $\tau$ route at odd $m$, the two-non-decomposable case is empty at **every** dimension, and three non-decomposable image forms is the only surviving case of [I38](../plan.md)'s census.
- **§5 keeps a use**, as an independent second proof at $\dim V=8$ that needs no determinant comparison and no positivity, and as a structure result: at $\dim V=8$ first Bianchi alone forces the two $\Lambda^2(P_3^\perp\cap V)$-blocks to be rank-four with a common kernel, or the pair to be dependent.
- **The verdict is unchanged**: all three claims CONFIRMED, the configuration empty, the lemma correct and vacuous.
