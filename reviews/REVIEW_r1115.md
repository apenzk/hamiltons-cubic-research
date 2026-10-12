# Reviewer r1115: L238's Gaussian-free frame identity against its Lean statement

*Gate 2 review, one reviewer, of the paragraph "(ii) at $r=7$ needs no Gaussian" and the "Lean." paragraph of [L238](../findings/second-order.md) against section FrameIdentity of [FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean) and the L238 row of [lean/INDEX.md](../lean/INDEX.md), at commit 105888ea. Analysis first. Screens of seconds on constructed objects, reported as screens. Log: [r1115-frame-identity.log](../agent_logs/r1115-frame-identity.log). Scratch files in the session scratchpad, uncommitted.*

| # | Claim | Verdict |
|---|---|---|
| 1 | frameT is the ordered bracket total, frameM is the prose's $M_{ij}$ | CONFIRMED |
| 2 | frame_identity states the displayed identity, orthonormality unused | CONFIRMED, with one precision: the Lean carries $\operatorname{tr}M_{ij}^2$ where the prose writes $\lVert M_{ij}\rVert_F^2$, equal for skew $X_i$ |
| 3 | frame_bound is (ii) at $r=7$, and gives (iii) at $d\ge8$ | CONFIRMED. The step to $336/d$ is prose arithmetic, untyped. The prose's closing clause "(ii) for general $P$ is untyped" is now too broad and should read "(ii) at $r<7$" |
| 4 | Equality characterisation, both directions | CONFIRMED as prose. Untyped |
| 5 | Non-vacuity and axioms | CONFIRMED |
| 6 | lean/INDEX.md row against the file | PLAUSIBLE, corrected: `hT` is (i)'s Gaussian form, not part of the rank refinement, and the leaves-out list omits the equality case |

**The Lean matches the prose.** `frame_identity` is the displayed identity for every family of square matrices with $k\ge1$, and `frame_bound` is (ii) at $r=7$ for every skew family. Both compile clean from source and rest on the standard three axioms. The corrections are two wording points about what remains untyped.

## 1. frameT and frameM

- **frameT.** `frameT X` sums $\operatorname{tr}(X_i^2X_j^2)-\operatorname{tr}(X_iX_jX_iX_j)$ over all ordered $(i,j)$. At $i=j$ both traces are $\operatorname{tr}X_i^4$, so the diagonal term is $0$ identically (the proof uses `sub_self`).
- Off the diagonal, $[X,Y]^2=XYXY-XY^2X-YX^2Y+YXYX$, so by cyclicity $\operatorname{tr}[X,Y]^2=2\operatorname{tr}(XYXY)-2\operatorname{tr}(X^2Y^2)$ and $\lVert[X,Y]\rVert^2=-\tfrac12\operatorname{tr}[X,Y]^2=\operatorname{tr}(X^2Y^2)-\operatorname{tr}(XYXY)$. For skew $X,Y$ the bracket is skew and this is the record norm. So `frameT` is $T=\sum_{i\ne j}\lVert[X_i,X_j]\rVert^2$.
- **frameM.** For skew $X_i$, $X_i^{\mathsf T}X_j=-X_iX_j$ and its transpose is $-X_jX_i$, so $\operatorname{sym}(X_i^{\mathsf T}X_j)=-\tfrac12(X_iX_j+X_jX_i)$, which is the Lean's off-diagonal entry. On the diagonal $\operatorname{sym}(X_i^{\mathsf T}X_i)=-X_i^2=Q_i$, and the Lean's $M_{ii}=Q_i-\tfrac1kP$ is the prose's $Q_i-P/k$.
- For a family that is not skew the two definitions part (the Lean's is not $\operatorname{sym}(X_i^{\mathsf T}X_j)$ in general). The prose restricts to skew families, so the match is exact where the prose speaks.

## 2. frame_identity

- **Hand derivation.** Off the diagonal, `bracket_quad` gives $\operatorname{tr}(X_i^2X_j^2)-\operatorname{tr}(X_iX_jX_iX_j)=2\operatorname{tr}(Q_iQ_j)-\tfrac12\operatorname{tr}S_{ij}^2$ with $Q_iQ_j=X_i^2X_j^2$, and $M_{ij}=-\tfrac12S_{ij}$ gives $\tfrac12\operatorname{tr}S_{ij}^2=2\operatorname{tr}M_{ij}^2$. On the diagonal the term is $0=2\operatorname{tr}Q_i^2-2\operatorname{tr}Q_i^2$.
- Summing, $T=2\sum_{i,j}\operatorname{tr}Q_iQ_j-2\sum_{i\ne j}\operatorname{tr}M_{ij}^2-2\sum_i\operatorname{tr}Q_i^2$. With $\sum_{i,j}\operatorname{tr}Q_iQ_j=\operatorname{tr}P^2$ and $\sum_i\operatorname{tr}M_{ii}^2=\sum_i\operatorname{tr}Q_i^2-\tfrac2k\operatorname{tr}P^2+\tfrac1k\operatorname{tr}P^2$ (the lemma `frame_diag`), this is $2(1-\tfrac1k)\operatorname{tr}P^2-2\sum_{i,j}\operatorname{tr}M_{ij}^2$. The factor and the full $(i,j)$ range match the display.
- **Precision.** The Lean's right side has $\operatorname{tr}(M_{ij}M_{ij})$. The prose has $\lVert M_{ij}\rVert_F^2=\operatorname{tr}M_{ij}^{\mathsf T}M_{ij}$. They agree when $M_{ij}$ is symmetric, which `frameM_symm` proves for skew $X_i$, and `trace_sq_nonneg_of_symm` proves the entrywise form $\operatorname{tr}M^2=\sum_{a,b}M_{ab}^2$ internally. No lemma states the Frobenius form, which is harmless because it is a one-line consequence.
- **Orthonormality unused: true, and more.** `frame_identity`'s only hypothesis is $0<k$. It uses neither orthonormality nor skewness.
- **"The Gaussian identity with $\mathbb E\lVert G-\tfrac{\operatorname{tr}G}7I\rVert_F^2$ evaluated."** $(\operatorname{tr}G)^2-\lVert G\rVert_F^2=\tfrac67(\operatorname{tr}G)^2-\lVert G_0\rVert_F^2$ with $G_0=G-\tfrac{\operatorname{tr}G}7I$, whose entries are $v^{\mathsf T}M_{ij}v$. Isserlis gives $\mathbb E\lVert G_0\rVert_F^2=\sum_{i,j}(\operatorname{tr}M_{ij})^2+2\sum_{i,j}\lVert M_{ij}\rVert_F^2$, and orthonormality kills every trace ($\operatorname{tr}M_{ij}=2\langle X_i,X_j\rangle=0$ for $i\ne j$, $\operatorname{tr}M_{ii}=2-2=0$). So the reading holds for orthonormal seven-frames, which is where the Gaussian identity lives. It is the one place in the paragraph that uses orthonormality.
- Screen: the identity with Frobenius norms to $10^{-12}$ on random skew families at $(n,k)=(5,3),(9,7)$.

## 3. frame_bound as (ii) at $r=7$, and (iii) at $d\ge8$

- `frame_bound`: for skew $X_i$ and $k\ge1$, `frameT X` is at most $2(1-\tfrac1k)\operatorname{tr}P^2$. At $k=7$ this is $\tfrac{12}7\operatorname{tr}P^2$.
- The prose (ii) at $r=7$ is $\tfrac67(196+2\operatorname{tr}P^2)-168=168+\tfrac{12}7\operatorname{tr}P^2-168=\tfrac{12}7\operatorname{tr}P^2$. The two agree exactly, using $(\operatorname{tr}P)^2=196$ on the prose side. `frame_bound` holds for every skew family, so it is the $r=7$ instance for orthonormal seven-frames and a general statement beyond them.
- The $r=7$ instance is valid at every $d$. At $d\le7$ the prose's $r=d-1$ is smaller and the bound stronger, which is the part the Gaussian still carries.
- **(iii) at $d\ge8$.** $\operatorname{tr}P=\sum_i\operatorname{tr}Q_i=\sum_i2\lVert X_i\rVert^2=14$. Isotropic $P=cI$ on a $d$-dimensional range gives $c=14/d$ and $\operatorname{tr}P^2=196/d$, so $T\le\tfrac{12}7\cdot\tfrac{196}d=\tfrac{336}d\le42$ for $d\ge8$. At $d=7$ the same bound gives $48$, so the prose is right that $d\le7$ needs the rank refinement.
- **This step is untyped.** The file has no theorem from `frame_bound` to $336/d$, and the $336/d$ appears only in `frame_bound`'s docstring. The index row lists it as left out, correctly.
- **Correction to the "Lean." paragraph.** Its last clause, "so (ii) for general $P$ is untyped", now contradicts its first sentence, since `frame_bound` is (ii) at $r=7$ for general $P$. It should read: "so (ii) at $r=d-1<7$ for general $P$ is untyped".

## 4. The equality case

- **Equality forces the conditions.** Equality in `frame_bound` means $\sum_{i,j}\operatorname{tr}M_{ij}^2=0$. Each term is $\lVert M_{ij}\rVert_F^2\ge0$ for skew $X_i$, so every $M_{ij}=0$. Off the diagonal that is $X_iX_j+X_jX_i=0$. On the diagonal it is $Q_i=P/k$.
- **The conditions force equality.** Pairwise anticommutation and $Q_i=P/k$ make every $M_{ij}$ zero, so the subtracted sum vanishes.
- Both directions hold. The characterisation is prose only: the file states no equality theorem, and neither the prose's Lean paragraph nor the index row claims one.
- Screen: the octonion frame $L_{e_i}/2$ on $\mathbb R^8$ (Cayley–Dickson) is skew and orthonormal, with $\operatorname{tr}P=14$, $\operatorname{tr}P^2=24.5=196/8$, $\sum\lVert M_{ij}\rVert_F^2=0$ and $T=42$, equal to the bound. The $\mathfrak g_2$-complement frame at $d=7$ has $T=42$ below `frame_bound`'s $48$, consistent with the characterisation: there $P=2I_7$ makes $Q_i=P/7$ scalar, and seven anticommuting skew $7\times7$ matrices with scalar squares cannot exist (a $\mathrm{Cl}_7$ module has dimension divisible by $8$).

## 5. Non-vacuity and axioms

- **Hypotheses.** `frame_bound` takes $0<k$ and $X_i^{\mathsf T}=-X_i$. A scratch file imports the module and discharges both for `Jfam`, the family $k=2$, $n=2$ with $X_0=X_1=\begin{pmatrix}0&1\\-1&0\end{pmatrix}$, as `frame_bound Jfam (by norm_num) Jfam_skew`. It compiles. The octonion frame of section 4 is a non-trivial family meeting the same hypotheses, with the bound attained.
- **Source.** `lake env lean` on [FrameGaussianBound.lean](../lean/HamiltonsCubic/Results/FrameGaussianBound.lean) exits $0$ with no output, so no `sorry` and no warnings.
- **Axioms.** `#print axioms` gives `[propext, Classical.choice, Quot.sound]` for `frame_identity` and for `frame_bound`.

## 6. The lean/INDEX.md row

- **Accurate.** The status **partial** fits, since (i)'s second equality and (ii) at $r<7$ are untyped. `frame_identity` is described for any family of square matrices, which matches its lone hypothesis $0<k$, and its display matches the theorem term for term, including $\operatorname{tr}M_{ij}^2$. `frame_bound` is described with its two supporting lemmas. `bracket_quad`, `sigma2_le`, `isotropic_frame_bound`, `isotropic_frame_d7` and `isotropic_frame_d8` are all in the file under those names.
- **Correction, the hypotheses.** The row says the rank refinement "enters `isotropic_frame_bound` as `hT`, `hM`". Only `hM` carries the rank refinement (the averaged pointwise step with $r\le\min(7,d-1)$). `hT` is (i)'s Gaussian form $T=\mathbb E[\cdot]-168$, Isserlis applied to the per-pair identity, and it is needed at every $d$. Suggested text: "the Gaussian form of (i), which enters `isotropic_frame_bound` as `hT`, and the rank refinement $r=d-1<7$ at $d\le7$, which enters as `hM`".
- **Omissions from the leaves-out list.** The equality characterisation of section 4 is prose only. The frames' own $T=42$ at $d=7,8$ is untyped (r1114 L6), and `isotropic_frame_d7`, `isotropic_frame_d8` are the arithmetic of the bound's value. Both belong in "What the file leaves out".
- The row's Gate 2 cell names r1113 and r1114 "before `frame_identity` was added". This review is the Gate 2 for the added section.
