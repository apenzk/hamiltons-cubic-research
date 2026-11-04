# REVIEW r1132, Gate 2 on L245 and L243_min

Brief: [2026-09-25-L245-gate2-brief.md](2026-09-25-L245-gate2-brief.md). Log: [agent_logs/r1132.log](../agent_logs/r1132.log). Analysis only, with one seconds-long screen at $S^5\times S^7$ (item 4) and a build of the two Lean files.

| Item | Verdict |
|---|---|
| 1 identities | CONFIRMED |
| 2 star step and ceiling | CONFIRMED |
| 3 two exclusions | CONFIRMED |
| 4 $S^5\times S^7$ | CONFIRMED, tight in all three classes |
| 5 scope of 175/190 | PLAUSIBLE, repair below |
| 6 L243_min | CONFIRMED |

## 1. The identities: CONFIRMED

- With $\Psi$ the skew matrix of $\psi$ and $\lVert\psi\rVert^2=-\tfrac12\mathop{\mathrm{tr}}\Psi^2=\tfrac12\lVert\Psi\rVert_F^2$, the basis $e_i\wedge e_j\mapsto E_{ij}-E_{ji}$ is orthonormal and $(E_{ij}-E_{ji})(E_{ij}-E_{ji})^{\mathsf T}=E_{ii}+E_{jj}$. Summing over $i<j$ gives $(n-1)I$, and $A_c$ is independent of the orthonormal basis of $E_c$ (it is a contraction of the eigenprojection), so $\sum_cA_c=(n-1)I$.
- $\sum_\alpha\lambda_\alpha(\Psi_\alpha\Psi_\alpha^{\mathsf T})_{ik}=\sum_jW_{ijkj}$, the Ricci contraction of $W=\sum\lambda_\alpha\psi_\alpha\otimes\psi_\alpha$, which is zero for a Weyl tensor. Scaling $W$ versus $e=W/\theta$ does not matter since the right side is $0$.
- $a_c=\langle A_cx,x\rangle=\sum_{\alpha\in c}\lvert\Psi_\alpha x\rvert^2\ge0$. The segment is the intersection of the line $\{\sum a=n-1,\ \sum\lambda a=0\}$ with the nonnegative orthant, nonempty since the actual $a$ lies on it.
- Only the Weyl property is used; criticality and unit norm are not needed for this part.

## 2. The star step and the ceilings: CONFIRMED

- $e\wedge u\mapsto eu^{\mathsf T}-ue^{\mathsf T}$ has Frobenius norm squared $2$, so record norm $1$, and $(eu^{\mathsf T}-ue^{\mathsf T})(ue^{\mathsf T}-eu^{\mathsf T})=ee^{\mathsf T}+uu^{\mathsf T}$ for orthonormal $e,u$, which maps $e$ to $e$. The $e\wedge u_i$ over an orthonormal basis of $U$ are orthonormal, extend them to a basis of $E_c$, and the remaining terms are PSD: $\langle A_ce,e\rangle\ge\dim U$.
- Closed forms of $h_c$ (the segment's endpoints lie where one coordinate vanishes, and $t\mapsto t/(t-\lambda_0)$ is increasing): $h_0=(n-1)\frac{\lambda_2}{\lambda_2-\lambda_0}$, $h_2=(n-1)\frac{-\lambda_0}{\lambda_2-\lambda_0}$, both attained at the endpoint $a_1=0$; $h_1=(n-1)\frac{-\lambda_0}{\lambda_1-\lambda_0}$ if $\lambda_1>0$, $(n-1)\frac{\lambda_2}{\lambda_2-\lambda_1}$ if $\lambda_1<0$, $n-1$ if $\lambda_1=0$. **Suggest adding these to the statement**, which currently defines $h_c$ only implicitly.
- At $(-a,0,a)$: $-aA_0+aA_2=0$ gives $A_0=A_2$, and $h_0=h_2=\tfrac{n-1}2$, $h_1=n-1$. Correct.
- A remark the record may want: $h_0+h_2=n-1$ at every three-value spectrum, so one of the two outer eigenspaces always has ceiling at most $\tfrac{n-1}2$.

## 3. The two exclusions: CONFIRMED

- [screen_I73c_good_eigenspace.py](../scripts/misc/screen_I73c_good_eigenspace.py) builds both targets with `frac=0.5`, which its `spectrum()` turns into $(-1,0,1)$ up to scale (at $(8,50,8)$: $a=33$, $b=-33$, $s=1$, $t=0$; same at $(12,42,12)$), and class $c=0$, the negative eigenspace. So $h_0=\tfrac{11}2$.
- $(8,50,8)$: $E_0=e_1\wedge U$, $\dim U=8>5.5$. Excluded.
- $(12,42,12)$: $E_0\supseteq e_1\wedge\mathbb R^{11}$, $\dim U=11>5.5$. Excluded by the containment form of the lemma (the extra twelfth direction is irrelevant). Had either lived in $E_1$ the lemma would say nothing ($h_1=11$), and neither does.

## 4. $S^5\times S^7$: CONFIRMED, and the ceiling is attained in every class

- By hand: $A_{\Lambda^2\mathbb R^5}=4P_5$, $A_{\Lambda^2\mathbb R^7}=6P_7$, $A_{\mathrm{mix}}=7P_5+5P_7$, summing to $11I$. $\mathop{\mathrm{Ric}}(W)=0$ forces $\lambda_{\Lambda^2\mathbb R^5}=-\tfrac74\lambda_{\mathrm{mix}}$, $\lambda_{\Lambda^2\mathbb R^7}=-\tfrac56\lambda_{\mathrm{mix}}$, traceless as required. The ceilings are $h=(7,6,4)$ for (mix, $\Lambda^2\mathbb R^7$, $\Lambda^2\mathbb R^5$), equal to the top eigenvalues of the $A_c$.
- Screen (seconds, constructed object): Weyl part of the product curvature at $n=12$, unit; spectrum $(-0.1117,0.0930,0.1954)$ with multiplicities $(35,21,10)$; $\lVert\sum A_c-11I\rVert=0$, $\lVert\sum\lambda_cA_c\rVert=4\cdot10^{-10}$ (eigenvalue rounding); $\mathop{\mathrm{tr}}A_c=2m_c$; exact $h_c=(7,6,4)$ equal to $\lambda_{\max}(A_c)$; 2000 random unit $x$ stay below.
- The stars it carries, $e\wedge\mathbb R^7$ in the mixed space, $e\wedge\mathbb R^6$ in $\Lambda^2\mathbb R^7$, $e\wedge\mathbb R^4$ in $\Lambda^2\mathbb R^5$, meet $\dim U=h_c$ with equality. So the lemma is sharp on the catalogued point at $\theta=1.228239<\theta_0(12)$.

## 5. Scope of "175 of 190": PLAUSIBLE, repair

- It is labelled a screen in [second-order.md](../findings/second-order.md), in the index row and in the commit. Good.
- The logic holds: $\dim(e\wedge U)=\dim U$, so $E_c=e\wedge U$ forces $m_c\le h_c$, and $m_c>h_c$ rules out $E_c$ being a star.
- **Defect 1, provenance.** No script or saved survivor list is named for the count, so it cannot be reproduced from the record (not rerun here: the survivor screen is outside the brief's allowance). Name the script and arguments.
- **Defect 2, the count mixes in cases the lemma is not needed for.** A star has $\dim U\le n-1=11$, so any $m_c\ge12$ is not a star by dimension alone (the symmetric survivors $(12,42,12)$ through $(16,34,16)$ are such). The lemma's own contribution is the survivors with $h_c<m_c\le11$. Report that split, or phrase it as "at 175 the smallest eigenspace cannot be a star, at N of them by L245 and the rest by dimension".
- **Defect 3, reading.** "Cannot be a star" is weaker than the lemma: it rules out $E_c=e\wedge U$, and survivors counted in the 175 can still carry a star of dimension up to $h_c$ inside $E_c$, as $(12,42,12)$'s candidate shows is the relevant shape. The sentence should not be read as an exclusion count; it currently is not claimed as one, which is correct.

## 6. L243_min: CONFIRMED

- Statement: for skew $X_i$ with $\mathop{\mathrm{tr}}X_i^2=-2$ and $\mathop{\mathrm{tr}}X_iX_j=0$, the ordered sum over $i\ne j$ of $-\tfrac12\mathop{\mathrm{tr}}[X_i,X_j]^2$ is at most $(1-\tfrac1{\min(k,n-1)})(4k^2+2\mathop{\mathrm{tr}}P^2)-4k(k-1)$ with $P=\sum X_i^{\mathsf T}X_i=\sum(-X_i^2)$. This is L243 verbatim, with $n\ge2$, $k\ge1$.
- `total_eq_frameT`: expanding $-\tfrac12\mathop{\mathrm{tr}}(X_iX_j-X_jX_i)^2=\mathop{\mathrm{tr}}(X_i^2X_j^2)-\mathop{\mathrm{tr}}(X_iX_jX_iX_j)$ by cyclicity, which is `frameT`'s summand; `frameT`'s diagonal terms vanish, matching the `if i = j then 0`. Right identification.
- `frameP_eq`: `frameQ X i = -(X i * X i)`, and $X_i^{\mathsf T}X_i=(-X_i)X_i$ for skew $X_i$. Right.
- The $r=k$ branch: $(1-\tfrac1k)(4k^2+2\mathop{\mathrm{tr}}P^2)-4k(k-1)=2(1-\tfrac1k)\mathop{\mathrm{tr}}P^2$, the step `e`, so `frame_bound` (which needs only skewness) gives it; the $r=n-1$ branch is `L243_frame`.
- `lake build` of GaussianRankStep and L245SymmetricIsotropy succeeds; `#print axioms` on `L243_min`, `no_large_star`, `n12_star_le5` gives only `propext`, `Classical.choice`, `Quot.sound`.

## Lean note on L245

- [L245SymmetricIsotropy.lean](../lean/HamiltonsCubic/Results/L245SymmetricIsotropy.lean) types only the symmetric case ($a_0=a_2$ as hypothesis), which the brief's Lean table states. Its three theorems are correct and match that case.
- **Text defect**: its docstring header says "The record's statement, quoted from second-order.md", but the quoted text ("the negative eigenspace contains no $e_1\wedge U$ with $\dim U>\tfrac{n-1}2$") is not the current L245 statement, which is general in $c$ and in the spectrum. Either quote the current statement or relabel the block as a paraphrase of the symmetric case.
