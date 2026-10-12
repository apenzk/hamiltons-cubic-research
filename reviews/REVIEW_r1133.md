# Gate 2 review r1133: L245 and L243_min

Brief: [2026-09-25-L245-gate2-brief.md](2026-09-25-L245-gate2-brief.md). Log: [agent_logs/r1133.log](../agent_logs/r1133.log). Analysis by hand throughout; the computations below are seconds on objects constructed for the check (one $12\times12$ product curvature, one parse of an existing log).

| Item | Claim | Verdict |
|---|---|---|
| 1 | The identities | CONFIRMED |
| 2 | The star step and the ceiling | CONFIRMED, closed forms for $h_c$ supplied |
| 3 | The two exclusions | CONFIRMED |
| 4 | $S^5\times S^7$ | CONFIRMED, and the lemma is tight there in all three classes |
| 5 | Scope of the 175/190 screen | PLAUSIBLE: count reproduced, but 62 of the 175 are excluded by dimension alone and no script is committed |
| 6 | L243_min | CONFIRMED |

## 1. The identities: CONFIRMED

- Normalisation: $e_i\wedge e_j=e_ie_j^{\mathsf T}-e_je_i^{\mathsf T}$ has $-\tfrac12\operatorname{tr}(\cdot)^2=1$, so it is unit, and $(e_i\wedge e_j)(e_i\wedge e_j)^{\mathsf T}=e_ie_i^{\mathsf T}+e_je_j^{\mathsf T}$. Summed over $i<j$ each index occurs $n-1$ times: $\sum_cA_c=(n-1)I$. The sum $\sum_\alpha\psi_\alpha\psi_\alpha^{\mathsf T}$ is basis-independent on each eigenspace, so any orthonormal basis of $\Lambda^2$ adapted to the $E_c$ gives the same total.
- $\operatorname{Ric}$ is linear in the operator and sends $\psi\otimes\psi$ to $\psi\psi^{\mathsf T}$ in this normalisation (the identity case fixes the constant at $1$), so $\operatorname{Ric}(W)=\sum_c\lambda_cA_c$, which is $0$ at a Weyl $W$.
- $A_c=\sum\psi\psi^{\mathsf T}\succeq0$, so $a_c\ge0$; evaluating the two identities at unit $x$ gives the two linear equations. The solution set is a line in $\mathbb R^3$ met with the orthant, a segment, nonempty since the true $(a_c)$ lies on it.
- *Only $\operatorname{Ric}(W)=0$ is used.* Criticality ($W^2+W^\#=\theta W$) and unit norm play no role, so the lemma holds for every Weyl tensor with three eigenvalues. The statement could say so.

## 2. The star step and the ceiling: CONFIRMED

- $(e\wedge u)(e\wedge u)^{\mathsf T}=ee^{\mathsf T}+uu^{\mathsf T}$ for orthonormal $e,u$, so applied to $e$ it gives $e$. For an orthonormal basis $u_1,\dots,u_d$ of $U$ the $e\wedge u_i$ are orthonormal in the record norm, extend to an orthonormal basis of $E_c$, and each remaining term contributes $\lvert\psi e\rvert^2\ge0$. So $\langle A_ce,e\rangle\ge\dim U$, and with item 1, $\dim U\le h_c$.
- The segment's direction is $z=\mathbf1\times\lambda=(\lambda_2-\lambda_1,\ \lambda_0-\lambda_2,\ \lambda_1-\lambda_0)$, signs $(+,-,+)$, and $\lambda_0<0<\lambda_2$ (else $\sum\lambda_ca_c=0$ with $\sum a_c=n-1$ is impossible). So $a_0,a_2$ are maximal together at the endpoint $a_1=0$ and $a_1$ at the other endpoint. The closed forms, which the record could state:
  - $h_0=\dfrac{(n-1)\lambda_2}{\lambda_2-\lambda_0}$, $h_2=\dfrac{(n-1)\lvert\lambda_0\rvert}{\lambda_2-\lambda_0}$;
  - $h_1=\dfrac{(n-1)\lvert\lambda_0\rvert}{\lambda_1-\lambda_0}$ if $\lambda_1\ge0$, and $\dfrac{(n-1)\lambda_2}{\lambda_2-\lambda_1}$ if $\lambda_1\le0$ (both $n-1$ at $\lambda_1=0$).
- Symmetric spectrum $(-a,0,a)$: $h_0=h_2=\tfrac{n-1}2$ from the formulas, and $A_0=A_2$ directly from $a(A_2-A_0)=0$. Both correct.

## 3. The two exclusions: CONFIRMED

- The targets in [I73c_good_eigenspace.log](../agent_logs/I73c_good_eigenspace.log) are at `frac 0.5`, which for $m_0=m_2$ gives $t=0$, $s=1$: the symmetric spectrum, with class $0$ the negative eigenspace. So $h_0=\tfrac{11}2$.
- $(8,50,8)$: $E_0=e_1\wedge U$ with $\dim U=8$ gives $a_0(e_1)\ge8>5.5$. Excluded. (An eight-dimensional space of decomposable bivectors is necessarily a star, since a linear space of decomposables either shares a vector or lies in $\Lambda^2$ of a 3-space, so "all-decomposable" and "star" coincide here.)
- $(12,42,12)$: $E_0\supseteq e_1\wedge\mathbb R^{11}$ gives $a_0(e_1)\ge11>5.5$. Excluded, and in fact at every spectrum: $a_0(e_1)=n-1$ forces $a_1=a_2=0$ and then $\lambda_0(n-1)=0$, impossible.
- Scope note: the lemma excludes these subspaces as eigenspaces, not the spectra $(8,50,8)$ and $(12,42,12)$. The text says "excludes both" of the subspaces, which is accurate.

## 4. $S^5\times S^7$: CONFIRMED, and tight

Built from the definitions: $S^5(r_1)\times S^7(r_2)$ with Einstein radii $r_1^2=4$, $r_2^2=6$, curvature operator diagonal in the $e_i\wedge e_j$ basis ($1/r_1^2$ on $\Lambda^2\mathbb R^5$, $1/r_2^2$ on $\Lambda^2\mathbb R^7$, $0$ mixed), Weyl part $R-\tfrac{s}{n(n-1)}\mathrm{Id}$.

- Three eigenvalues with multiplicities $(35,21,10)$ (mixed, $\Lambda^2\mathbb R^7$, $\Lambda^2\mathbb R^5$), matching L244's record. $\operatorname{Ric}(W)=0$ to $4\cdot10^{-16}$, $\sum A_c=(n-1)I$ exactly, $\sum\lambda_cA_c=0$ to $4\cdot10^{-12}$.
- $h=(7,6,4)$ from item 2's formulas, and the largest eigenvalues of $A_0,A_1,A_2$ are exactly $7,6,4$. **Every direction satisfies $a_c\le h_c$ and the ceiling is attained in all three classes**, by the stars $e_1\wedge\mathbb R^7\subseteq E_0$ ($\dim7$), $e_6\wedge\mathbb R^6\subseteq E_1$ ($\dim 6$) and $e_1\wedge\mathbb R^4\subseteq E_2$ ($\dim 4$). *So the star bound is sharp on the record's own witness, a check worth recording.*

## 5. Scope of "175 of 190": PLAUSIBLE

- **The count reproduces.** From the 190 `FEASIBLE` lines of [I73c_offray_n12_theta0.log](../agent_logs/I73c_offray_n12_theta0.log), each with a single feasible direction, the script's direction $\varepsilon=(-1,t,s)$ and item 2's $h_c$ give $m_c>h_c$ for the smallest class at 175 (ties handled by requiring every smallest class). The 15 others are four triples $(5,m_1,m_2)$ at `frac 0.5` (smallest class $m_0=5\le h_0\approx5.2$ to $5.4$) and eleven at `frac 0.3` whose smallest class has $m_2\le3\le h_2\approx3.0$ to $3.3$.
- **It is labelled a screen**, correctly. **But no script is committed** for it, so "a screen of the exact $h_c$" cannot be rerun from the record.
- **62 of the 175 are trivial**: their smallest multiplicity is at least $12>n-1$, and a star $e\wedge U$ has dimension at most $n-1=11$ regardless of the lemma. The lemma's own contribution is **113** survivors. The sentence should say so.
- **"Cannot be a star" follows from $m_c>h_c$** (a star $E_c=e\wedge U$ has $m_c=\dim U\le h_c$), but it is the weakest reading: it excludes $E_c$ being exactly a star. The lemma gives more, that $E_c$ contains no star of dimension above $h_c$, and it excludes none of the 175 spectra. Suggested wording: "at 175 of the 190 (113 beyond the dimension count $m_c\le n-1$), the smallest eigenspace is not itself a star (a screen of the exact $h_c$)".

## 6. L243_min: CONFIRMED

- **Statement.** The left side is $\sum_{i\ne j}-\tfrac12\operatorname{tr}([X_i,X_j]^2)=\sum_{i\ne j}\lVert[X_i,X_j]\rVert^2=T$; `hnorm` ($\operatorname{tr}X_i^2=-2$) and `horth` are orthonormality in the record norm; $\sum X_i^{\mathsf T}X_i=\sum(-X_i^2)=P$; the right side is $(1-\tfrac1r)(4k^2+2\operatorname{tr}P^2)-4k(k-1)$ with $r=\min(k,n-1)$ taken in $\mathbb R$. This is L243's frame statement with $k\ge1$ (`hk`) and $n\ge2$.
- **`total_eq_frameT`**: $-\tfrac12\operatorname{tr}[A,B]^2=\operatorname{tr}A^2B^2-\operatorname{tr}ABAB$ by cyclicity, and the diagonal of `frameT` vanishes, so the identification is right and needs no skewness.
- **`frameP_eq`**: `frameQ` $=-X_i^2=X_i^{\mathsf T}X_i$ for skew $X_i$. Right.
- **The $r=k$ branch**: $(1-\tfrac1k)(4k^2+2t)-4k(k-1)=2(1-\tfrac1k)t$, which is `frame_bound`'s right side.
- **Build**: `lake build` of GaussianRankStep and L245SymmetricIsotropy succeeds; `#print axioms` on `L243_min`, `no_large_star` and `n12_star_le5` gives `propext`, `Classical.choice`, `Quot.sound`.

## Lean section, L245

- `isotropy_half`, `no_large_star` and `n12_star_le5` are correct and say what the Lean table claims: the symmetric scalar core, with $A_0=A_2$, the sum identity and $A_1\succeq0$ entering as hypotheses on three reals.
- **Defect (cosmetic)**: the file's docstring says it quotes the record, but the quoted text is an earlier symmetric-only wording, not the current L245 statement. It should either quote the current statement or say "the symmetric case of".
- The general $h_c$ is untyped, as the brief's table says.

## Corrections to fold

1. State that only $\operatorname{Ric}(W)=0$ is used, and give the closed forms of $h_0,h_1,h_2$ (item 2).
2. Record $S^5\times S^7$ as a check: $h=(7,6,4)$, attained by stars in all three classes (item 4).
3. Reword the 175 sentence to separate the 62 dimension-trivial cases and commit the screen (item 5).
4. Fix the Lean docstring's "quoted" statement.
