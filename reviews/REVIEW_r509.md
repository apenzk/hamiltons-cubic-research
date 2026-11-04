# REVIEW r509, Lemma L122, "the pair block is a graph Laplacian of the sectional matrix"

**Target**: [Lemma L122](../findings/second-order.md), `findings/second-order.md` lines 629–645, heading to the next heading.

**Reviewer**: r509, independent adversarial audit, cold, the block matrix was re-derived from the structure constants before [DERIVE-df1.md](DERIVE-df1.md) was opened.

**Standing rule inherited**: analysis only. No sweep, search, census or falsifier hunt was run. Two screens were run, each seconds of compute on objects I constructed for the purpose, each confirming a claim I was about to record and none of them offered as evidence for a positive claim. They are labelled **SCREEN** below.

---

## VERDICT: CONFIRMED, with one printed clause REFUTED and two repairs owed

**The mathematics is right and I re-derived all of it.** The bracketed matrix is exact, sign for sign and half for half; the Laplacian rewriting is exact; the Ricci cut really is $\sum_ix_i=0$ with no weighting; and the consequence's constant is $\theta$, not $\theta/2$. The lemma is true under the hypothesis it states ("Let $M$ be a coordinate-diagonal **Weyl** operator").

**What is refuted is the scope clause "not Ricci-flatness"**, which claims the displayed equality chain holds on a wider class than the hypothesis. It does not, and I have an exact witness. That clause is already corrected 23 lines below in the same file, by [Lemma L123](../findings/second-order.md)'s scope paragraph, with no pointer back to L122, the same "refuted thirty lines below itself" shape a recent audit found.

**The verdict is CONFIRMED rather than REFUTED** because under L122's own hypothesis Ricci-flatness is automatic, every one of the 17 citations is applied at a Weyl operator, and no downstream number changes. The repair is to the printed scope, not to the result.

---

## Preamble, the normalisation, settled first

L122's displayed block is $L_M$, un-normalised. Its own two internal cross-checks confirm this: the orbit eigenvalue is printed as $\theta/2$, and the sibling [Lemma L121](../findings/second-order.md) reads $L_M$'s four-set block as $\tfrac12G$ with $\Sigma\le\theta^2$, which is $\tfrac12\sqrt\Sigma\le\theta/2$. So [Lemma L24](../findings/second-order.md) enters here as
$$\lambda_{\max}\big(L_M\vert_{W^\perp}\big)\le\theta/2,$$
since $L_e=L_M/\theta$ by bilinearity of $\circ$. **This is consistent throughout the block, with one exception recorded as finding 8.**

**And L120's repair costs L122 nothing**: $M$ sits on the $\mathrm{Sym}^2(\Lambda^2)$ diagonal while every $f_i$ is supported off it, so $\langle M,f_i\rangle=0$ and the whole pair block lies in $W^\perp$. No $\langle M\rangle$ cut is needed here. **L122 never says this**, and it is what licenses applying L24 to the block without a projection defect, worth one clause.

---

## Finding 1, the identity, re-derived from the structure constants: **CONFIRMED exactly**

Setup, fixed from [conventions.md](../findings/conventions.md): $v_{ab}=E_{ab}-E_{ba}$ is unit under $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$; $[v_{ab},v_{bc}]=v_{ac}$, so every triangle structure constant is $\pm1$ and all others vanish; $X\circ Y=\tfrac12\{X,Y\}+B(X,Y)$ with $B(X,Y)_{\alpha\beta}=\tfrac12c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}X_{\gamma\epsilon}Y_{\delta\zeta}$.

**The setup was validated against the record's own anchors before it was used.** It reproduces $Q_{ab}=M_{ab}^2+(M^2)_{ab}$ on the diagonal locus, gives $\mathop{\mathrm{tr}}W^{\#}=-1$ at a unit critical point exactly as [conventions.md](../findings/conventions.md) requires, and recovers $\theta_0(6)=\sqrt{10}/3$ at $S^3\times S^3$. It also agrees with [DERIVE-df1.md](DERIVE-df1.md)'s implementation convention $(W^{\#})_{ab}=-\tfrac12\mathop{\mathrm{tr}}(A_aWA_bW)$: transposing one index pair turns my $B$ into exactly that, so the two definitions coincide rather than merely resemble each other.

**The two halves.**

- Symmetrised half: $M$ is diagonal in the pair basis, so $\tfrac12(Mf_i+f_iM)=\tfrac12(M_{ji}+M_{ki})f_i$.
- $\#$ half: writing $p=v_{ji}$, $q=v_{ki}$, a term survives only when $c_{\alpha\gamma p}\ne0$ **and** $c_{\beta\gamma q}\ne0$. Enumerating the four ways $\gamma$ can sit in both triangles, **exactly two survive**: $\gamma=\{i,m\}$ with $m\notin\{i,j,k\}$, forcing $(\alpha,\beta)=(v_{jm},v_{km})$ and contributing $+\tfrac12M_{im}f_m$; and $\gamma=\{j,k\}$, forcing $(\alpha,\beta)=(q,p)$ and contributing $-\tfrac12M_{jk}f_i$. The other two die, one on $c_{\beta qq}=0$, one on the requirement $m\ne i$.

$$\boxed{\;L_Mf_i=\tfrac12\big(M_{ji}+M_{ki}-M_{jk}\big)f_i+\tfrac12\!\!\sum_{m\notin\{i,j,k\}}\!\!M_{im}f_m\;}$$

which is the printed $\tfrac12[\mathop{\mathrm{diag}}(M_{ji}+M_{ki})-M_{jk}\mathrm{Id}+M^{(jk)}]$, **every sign and every $\tfrac12$ confirmed**. Block-invariance is proved en route rather than assumed: the image lands in the span of the $f_m$.

> **SCREEN.** Built $\circ$ from the structure constants at $n=6$ and compared the true block against this formula at $S^3\times S^3$, at a within-factor pair $\{0,1\}$ and a cross-factor pair $\{0,3\}$: `max|circ - formula| = 0.0` at both, exactly. Criticality residual $2.8\times10^{-17}$, $\mathop{\mathrm{tr}}W^2=1$, $\mathop{\mathrm{tr}}W^{\#}=-1$.

**Row sums are constant.** $\tfrac12(M_{ji}+M_{ki})-\tfrac12M_{jk}+\tfrac12\sum_{m}M_{im}=-\tfrac12M_{jk}$ using $M\mathbf1=0$, so $\mathbf1$ is an eigenvector of the uncut $(n-2)$ block and the Ricci cut is preserved, which is the test the withdrawn halved form fails. **The withdrawal note is coherent**: halving only the $\#$ part leaves row sums $\tfrac14(M_{ji}+M_{ki}-M_{jk})$, varying with $i$, exactly as the note says.

---

## Finding 2, the two expressions really are equal, and the missing $M_{ij},M_{ik}$ are where the brief expected: **CONFIRMED, and it is where Ricci-flatness enters**

A graph Laplacian is $\Delta=\mathop{\mathrm{diag}}(\text{row sums})-A$. With $A=M^{(jk)}$, **the row sums of $\Delta^{(jk)}$ are**
$$\sum_{m\notin\{j,k\}}M_{im}=(M\mathbf1)_i-M_{ij}-M_{ik}\;\overset{M\mathbf1=0}{=}\;-\big(M_{ij}+M_{ik}\big),$$
which is exactly $-\mathop{\mathrm{diag}}(M_{ji}+M_{ki})$, i.e. the diagonal the identity needs. **So the deleted rows' entries $M_{ij},M_{ik}$ did not disappear, they returned as the row sums, and only Ricci-flatness puts them back.** The sign on $M^{(jk)}$ is right: $-\tfrac12\Delta^{(jk)}=-\tfrac12\mathop{\mathrm{diag}}(\text{row sums})+\tfrac12M^{(jk)}$, matching the $+M^{(jk)}$ inside the bracket.

**One wording risk, and it is live.** "the weighted graph Laplacian of $M$ with rows and columns $j,k$ deleted" admits a second reading, Laplacian of the *full* $M$, then delete. That object is $\mathop{\mathrm{diag}}((M\mathbf1)_i)-M^{(jk)}=-M^{(jk)}$ under Ricci-flatness, and it **does not** satisfy the identity: it is short by $\tfrac12\mathop{\mathrm{diag}}(M_{ji}+M_{ki})$. The intended reading is "Laplacian of [$M$ with rows and columns deleted]" and should be written unambiguously, e.g. "$\Delta^{(jk)}=\mathop{\mathrm{diag}}(M^{(jk)}\mathbf1)-M^{(jk)}$".

**A free check the record does not carry**: $\mathop{\mathrm{tr}}\Delta^{(jk)}=2M_{jk}$, since $\sum_{i\notin\{j,k\}}(M_{ij}+M_{ik})=-2M_{jk}$ under $M\mathbf1=0$. Confirmed by screen to $10^{-16}$ at both pairs. It is a one-line transcription test for any future restatement.

---

## Finding 3, "The Ricci cut on this block is exactly $\sum_ix_i=0$": **CONFIRMED exactly, unweighted**

$f_i=\varphi\odot\psi$ with $\varphi=v_{ji},\psi=v_{ki}$ has $\mathrm{Ric}(f_i)_{bd}=\sum_a(f_i)_{abad}=-(\varphi\psi+\psi\varphi)_{bd}$. Computing, $\varphi\psi=-E_{jk}$ and $\psi\varphi=-E_{kj}$, so
$$\mathrm{Ric}(f_i)=E_{jk}+E_{kj}\qquad\text{for every }i.$$
**Independent of $i$.** Hence $\mathrm{Ric}\big(\sum_ix_if_i\big)=(\sum_ix_i)(E_{jk}+E_{kj})$, the cut is $\sum_ix_i=0$ with **no weighting**, and it is a single relation, matching [Lemma L120](../findings/second-order.md)'s "one Ricci relation cuts each pair block from $n-2$ to $n-3$". Since $\Delta^{(jk)}$ is symmetric with $\Delta^{(jk)}\mathbf1=0$ (a graph Laplacian always kills $\mathbf1$; here the row sums are $-(M_{ij}+M_{ik})$ and $\mathop{\mathrm{diag}}$ of them cancels $M^{(jk)}\mathbf1$), $\mathbf1^\perp$ is invariant and the restricted block is $-\tfrac12\Delta^{(jk)}\vert_{\mathbf1^\perp}-\tfrac12M_{jk}\mathrm{Id}$. **The spectral consequence is exactly as advertised.**

**One refinement to the record's own correction.** [Lemma L123](../findings/second-order.md)'s scope paragraph says "the identification of the Ricci cut with $\mathbf1^\perp$ ... require[s] Ricci-flatness". Strictly, $\sum_ix_i=0$ is unconditional, it is a property of the Weyl subspace and no condition on $M$ enters the computation above. What needs Ricci-flatness is calling that hyperplane **"the Laplacian's own $\mathbf1^\perp$"**, since without $M\mathbf1=0$ there is no such Laplacian. The correction is right in effect and slightly over-broad as phrased.

---

## Finding 4, "Diagonality alone is needed, not criticality, not $\theta>0$, not Ricci-flatness": **the third negative is REFUTED, with a witness**

**Two of the three hold.** Criticality and $\theta>0$ appear nowhere in the derivation of Finding 1, no row sum, no vertex equation, no sign of $\theta$. Confirmed.

**"Not Ricci-flatness" is false for the second expression.** Setting $r_i$ for the row sums of $M^{(jk)}$,
$$-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}\;=\;\tfrac12\big[\mathop{\mathrm{diag}}(M_{ji}+M_{ki})-M_{jk}\mathrm{Id}+M^{(jk)}\big]\iff -r_i=M_{ij}+M_{ik}\iff (M\mathbf1)_i=0 .$$
So the equality chain holds **iff** $M$ is Ricci-flat, index by index.

> **WITNESS.** $n=6$, $M$ hollow and symmetric with $M_{02}=M_{20}=1$ and every other entry zero. Then $(M\mathbf1)_0=(M\mathbf1)_2=1\ne0$. At the pair $\{0,1\}$ the bracketed form is exact; the Laplacian form has diagonal $0$ against a true diagonal $(\tfrac12,0,0,0)$, **off by $\tfrac12$**.
> **SCREEN** against $\circ$ built from the structure constants: bracketed form `max err = 0.0`, Laplacian form `max err = 0.5`. A $4\times4$ hand version of the same witness works identically.

**The tension the brief asks about is real, and it resolves like this.** The Ricci *cut* (Finding 3) is a condition on the direction $X$; Ricci-*flatness* is a condition on $M$. They are different conditions, so the two sentences are not literally contradictory, but the Laplacian rewriting genuinely needs the second, so the negative is still false.

**Where the defect came from.** [DERIVE-df1.md](DERIVE-df1.md) is correct: it attaches "It needs diagonality only, not criticality, not $\theta>0$, not Ricci-flatness" to the **bracketed form only**, inside its own box, and puts the Laplacian rewriting in a *separate later section*. **L122 merged the two into one paragraph and left the scope sentence after the whole equality chain.** That is a transcription defect, not an error of derivation.

**It is not harmless.** The withdrawn halved form survived a $222$-block screen precisely because that screen used random diagonal matrices rather than Weyl tensors, the same class of object on which the Laplacian half is false. The scope sentence invites exactly the check that already failed once here.

---

## Finding 5, the consequence: **constant CONFIRMED as $\theta$; hypotheses differ from the identity's and the block runs them together**

From $\lambda_{\max}(L_M\vert_{W^\perp})\le\theta/2$ and the block being $-\tfrac12\Delta^{(jk)}\vert_{\mathbf1^\perp}-\tfrac12M_{jk}\mathrm{Id}$:
$$-\tfrac12\lambda_{\min}\big(\Delta^{(jk)}\vert_{\mathbf1^\perp}\big)-\tfrac12M_{jk}\le\tfrac\theta2\;\Longrightarrow\;\lambda_{\min}\big(\Delta^{(jk)}\vert_{\mathbf1^\perp}\big)\ge-(\theta+M_{jk}).$$
**$\theta$, not $\theta/2$.** The factor is confirmed independently three ways.

- **By hand, against criticality.** $x_i=M_{ki}-M_{ji}$ satisfies $(Ax)_m=\tfrac\theta2x_m$ exactly: the $M_{km}^2-M_{mk}^2$, $M_{mj}^2-M_{jm}^2$ and $M_{jk}M_{jm}-M_{jm}M_{jk}$ terms all cancel identically after substituting $(M^2)_{ab}=\theta M_{ab}-M_{ab}^2$. **All $M$-dependence cancels**, exactly as the block claims. Also $\sum_mx_m=0$, so it lands in the Ricci cut as it must.
- **Consistency with [Lemma L123](../findings/second-order.md)'s tail**: eigenvalue $\theta/2$ on the block forces $\lambda_\Delta=-(\theta+M_{jk})$, which is what that paragraph prints.
- **Consistency with [post F47](../findings/second-order.md) and [post F51](../findings/second-order.md)**: $-\Delta^{(jk)}=M^{(jk)}+\mathop{\mathrm{diag}}(p)$ with $p_a=M_{aj}+M_{ak}$ is exactly their $\widetilde N=M\vert_I+\mathop{\mathrm{diag}}(p)$, and $T=\theta+M_{jk}$ matches. **No restatement anywhere in `findings/` carries a different constant.**

**The hypotheses, stated plainly, because the block does not.**

| claim | needs |
| --- | --- |
| bracketed form $\tfrac12[\mathop{\mathrm{diag}}(M_{ji}+M_{ki})-M_{jk}\mathrm{Id}+M^{(jk)}]$ | $M$ coordinate-diagonal. Nothing else. |
| Ricci cut $=\sum_ix_i=0$ | nothing on $M$ at all |
| rewriting as $-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\mathrm{Id}$ | additionally $M\mathbf1=0$ |
| $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})\ge-(\theta+M_{jk})$ | additionally $W$ a **unit-norm maximiser** with $\theta>0$ |

> **AND THE RECORD ALREADY HOLDS A COUNTEREXAMPLE TO THE INEQUALITY AT A NON-MAXIMAL CRITICAL POINT.** [Post F48](../findings/second-order.md)'s padded $S^6\times S^6$ at $n=14$: at the padded pair $p\equiv0$, so $\widetilde N=M'$, $T=\theta$, and $M'\mathbf1=0$ puts $\mathbf1$ in $\ker M'$, so $\lambda_{\max}(\widetilde N\vert_{\mathbf1^\perp})=\lambda_1(M')>\theta=T$, i.e. $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})<-(\theta+M_{jk})$. **The restriction to $\mathbf1^\perp$ does not rescue it; only maximality does.** The point is diagonal, critical, Ricci-flat, unit-norm and has $\theta>0$.
>
> So the sentence "Diagonality alone is needed, not criticality, not $\theta>0$" sits **two lines above** a displayed inequality that is false at a critical point on the record. The lead-in "Consequently [Lemma L24](../findings/second-order.md) ... gives" carries the hypothesis, but only for a reader who traces it. **This is the most consequential defect for the 17 citations**, because it is the half they use.

---

## Finding 6, the basis is orthogonal with equal norms, **not orthonormal**: no factor owed, but say so

Under [conventions.md](../findings/conventions.md)'s plain Frobenius pairing on the pair matrix, $f_i=E_{pq}+E_{qp}$ has $\lVert f_i\rVert^2=2$: **the $f_i$ are not unit vectors.** They are pairwise orthogonal ($\{j,i\}=\{j,m\}$ forces $i=m$, and $\{j,i\}=\{k,m\}$ needs $j=k$ or $i=k$, both excluded) and all of the same norm $\sqrt2$.

**A uniform rescaling of an orthogonal basis leaves the matrix of an operator unchanged**, so no normalisation factor is owed and the symmetric-looking expression is the genuine matrix of the operator, not a congruence of it. But the safety rests on *uniformity*, which the lemma never states. **One clause: "the $f_i$ are pairwise orthogonal of common norm $\sqrt2$, so the matrix below is the operator's."** Without it a reader has to redo the check to know a diagonal congruence is not hiding in the display.

---

## Finding 7, "graph Laplacian" in the heading is doing more work than it can: **REPAIR, not an error**

$M\mathbf1=0$ with $M$ hollow forces both signs in $M$ unless $M=0$, so the weights of $\Delta^{(jk)}$ take both signs. It is the **Kirchhoff matrix of a signed-weight graph**, $\mathop{\mathrm{diag}}(\sum_mw_{im})-W$, not the $\mathop{\mathrm{diag}}(\sum\lvert w\rvert)-W$ that the signed-graph literature calls a Laplacian and that is PSD. **This one is indefinite**, and must be: $\mathop{\mathrm{tr}}\Delta^{(jk)}=2M_{jk}$ over $n-3$ dimensions of $\mathbf1^\perp$, so $M_{jk}<0$ forces a negative eigenvalue.

**And the whole content of the lemma depends on that.** If $\Delta^{(jk)}$ were PSD then $\lambda_{\min}\ge0>-(\theta+M_{jk})$ and the consequence would be vacuous. **What actually transfers from "graph Laplacian" is symmetry and $\mathbf1\in\ker$, nothing else**, and both are used. [diagonal-half.md](../findings/diagonal-half.md) is careful about exactly this distinction for $K$ itself ("$K$ is a signed-graph Laplacian, with weights $-K_{ab}$"); L122's heading is not. **Repair: say "signed-weight graph Laplacian", and add the one clause that it is indefinite, which is why the bound has content.**

> **SCREEN.** At $S^3\times S^3$, $\mathop{\mathrm{spec}}(\Delta^{(jk)}\vert_{\mathbf1^\perp})=\{-0.8433,0.7379,0.7379\}$ within-factor and $\{-0.8433,0.2108,0.2108\}$ cross-factor. Negative eigenvalues present at both.

---

## Finding 8, an unflagged normalisation switch inside the block

The sentence **"The within-factor top eigenvalue is $(p-2)/(2(p-1))$, now proved"** is in $L_e$ units, while everything else in L122 (the displayed matrix, the $\theta/2$ orbit eigenvalue, the $\lambda_{\min}$ consequence), is in $L_M$ units. The block never says so.

> **SCREEN**, at $S^3\times S^3$, within-factor pair $\{0,1\}$: $\mathop{\mathrm{spec}}(L_M\vert_{\mathbf1^\perp})=\{-\theta/2,-\theta/2,\theta/4\}$, so $\mathop{\mathrm{spec}}(L_e\vert_{\mathbf1^\perp})=\{-\tfrac12,-\tfrac12,\tfrac14\}$ and the top is $\tfrac14=(p-2)/(2(p-1))$ at $p=3$, **in $L_e$**. In $L_M$ the top is $\theta/4=0.2635$. At $p=3$ the two numbers are $0.25$ and $0.2635$: close enough to be mistaken for a rounding difference.

Line 871 of the same file prints the sibling cross-factor spectrum as $\{\tfrac12,0^{n-4}\}$ (also $L_e$) so the file is consistent with itself elsewhere and only L122's own display mixes the two. **Repair: write "$(p-2)/(2(p-1))$ for $L_e$, i.e. $\theta(p-2)/(2(p-1))$ for the block above".**

> **SCREEN**, cross-factor pair $\{0,3\}$: $\mathop{\mathrm{spec}}(L_e\vert_{\mathbf1^\perp})=\{\tfrac12,0,0\}$ with the $\tfrac12$ on the orbit direction $x\propto(-1,-1,1,1)$, and $\lambda_{\min}(\Delta\vert_{\mathbf1^\perp})=-0.84327=-(\theta+M_{jk})$ **attained exactly**; within-factor it is $-0.84327>-1.37032$, **strict**. Both match [Lemma L123](../findings/second-order.md)'s "attained on the orbit, strict only in the orbit-free blocks", and both match the block's own claim that within-factor pairs at $S^p\times S^q$ carry no orbit direction ($M_{ji}=M_{ki}$ there).

---

## Cross-file check, no contradiction found

Grepped `findings/` and `results.md` for every restatement of the identity and its consequence.

| location | reads | verdict |
| --- | --- | --- |
| [INDEX-results.md](../findings/INDEX-results.md) row 122 | $\lambda_{\min}(\Delta^{(jk)}\vert_{\mathbf1^\perp})\ge-(\theta+M_{jk})$ | consistent |
| [post F47](../findings/second-order.md) | $\widetilde N=-\Delta^{(jk)}$, $T=\theta+M_{jk}$, $\widetilde No=To$ | consistent, it is my Finding 5 restated |
| [post F51](../findings/second-order.md) | $\widetilde N=M\vert_I+\mathop{\mathrm{diag}}(p)$, $p_a=M_{aj}+M_{ak}$ | consistent, equals $-\Delta^{(jk)}$ identically |
| [post F48](../findings/second-order.md) | $\lambda_{\max}(\widetilde N)\le T$ FALSE at padded pairs | **no contradiction**, because it is unrestricted and non-maximal; but see Finding 5's box, it also refutes the $\mathbf1^\perp$ form at a critical point, which the record does not say |
| [Lemma L127](../findings/second-order.md), line 871 | cross-factor $\{\tfrac12,0^{n-4}\}$, within-factor $\tfrac{m-2}{2(m-1)}$ | consistent in $L_e$; see Finding 8 |
| [Lemma L123](../findings/second-order.md) scope paragraph | corrects L122's "not Ricci-flatness" | **agrees with my Finding 4**, and is the only place the correction appears |
| [DERIVE-df1.md](DERIVE-df1.md) | both forms, correctly separated | the source is right; L122's transcription is what merged them |

**No restatement anywhere carries a different constant.**

---

## Repairs owed, in priority order

1. **Delete "not Ricci-flatness" from the scope sentence**, or split the sentence the way [DERIVE-df1.md](DERIVE-df1.md) does: diagonality alone for the bracketed form, plus $M\mathbf1=0$ for the Laplacian rewriting. Add the pointer to [Lemma L123](../findings/second-order.md)'s correction so the two are not 23 lines apart and silent about each other.
2. **State the consequence's hypotheses on the consequence.** "At a unit-norm **maximiser** with $\theta>0$" on the displayed inequality itself, with the note that [post F48](../findings/second-order.md)'s padded point is a critical point where it fails. This is what the 17 citations consume.
3. **Say "signed-weight graph Laplacian", and that it is indefinite**, otherwise the heading imports a PSD-ness that would make the bound vacuous.
4. **Add one clause on the basis**: pairwise orthogonal of common norm $\sqrt2$, so the display is the operator's matrix.
5. **Disambiguate $\Delta^{(jk)}$** as $\mathop{\mathrm{diag}}(M^{(jk)}\mathbf1)-M^{(jk)}$; the current phrasing admits a reading that is short by $\tfrac12\mathop{\mathrm{diag}}(M_{ji}+M_{ki})$.
6. **Mark $(p-2)/(2(p-1))$ as an $L_e$ value**, the only $L_e$ number in an $L_M$ block.
7. *Optional, free*: record $\mathop{\mathrm{tr}}\Delta^{(jk)}=2M_{jk}$ as a one-line transcription test, and note that the pair block lies wholly in $W^\perp$ so L120's $\langle M\rangle$ cut never touches it.

## VERDICT: CONFIRMED
