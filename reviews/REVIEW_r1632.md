# REVIEW r1632: L131Four.lean, the fourth entry of L131's sharp-I table, against the record

**Verdict: CONFIRMED WITH GAPS.** `sharpCross_four_id` proves $v\#I=2v$ on bivectors for the element $v=a+b+c$ of each four-set block, and that element is the four-form $e_i\wedge e_j\wedge e_k\wedge e_l$ read as an operator on $\Lambda^2$. The gaps concern the owed list: $\Lambda^4$ is spanned by these representatives directly, so it needs no frame images, and the linearity of $X\mapsto X\#I$ is owed for every summand but appears nowhere in the list.

Log: agent_logs/review-l131four.log

Footing: analysis only. The only run was `python3 scripts/misc/axiom_audit.py --only L131Four`, which builds a generated module of `#print axioms` calls. A second lake process was live when it started (pgrep found pid 79657), so it did not wait on an empty pgrep, and it completed normally. The hand screen in section 5 is a screen and carries no weight as evidence.

**Provenance.** [L131Four.lean](../lean/HamiltonsCubic/Results/L131Four.lean), the [L131Diag.lean](../lean/HamiltonsCubic/Results/L131Diag.lean) header edit and the L131 row of [lean/INDEX.md](../lean/INDEX.md#L492) all arrived in commit 25ecafdd. That commit's message covers I117 work only (L269, L271 (4)), because a concurrent session's commit swept these files in. So the git log carries no message for this result, and this review is the first record of it.

## Claim table

| # | Claim | Where | Verdict |
|---|---|---|---|
| 1 | $v=a+b+c$ is the totally antisymmetric element of the four-set block, orthogonal to the Bianchi cut $x+y+z=0$ | [lam4](../lean/HamiltonsCubic/Results/L131Four.lean#L29), header [:12-14](../lean/HamiltonsCubic/Results/L131Four.lean#L12) | CONFIRMED (by hand, untyped) |
| 2 | $v\#I=2v$ on every bivector, in the record's $\#$ | [sharpCross_four_id](../lean/HamiltonsCubic/Results/L131Four.lean#L49) | CONFIRMED |
| 3 | The fourth entry of L131 (i), "$\#I=2$ on $\Lambda^4$", together with the INDEX owed list | [lean/INDEX.md:492](../lean/INDEX.md#L492), [L131Diag.lean:22-25](../lean/HamiltonsCubic/Results/L131Diag.lean#L22) | CONFIRMED WITH GAPS |
| 4 | Axioms | lam4, lam4_lin, rk2_skew', lam4_skew, sharpCross_four_id | standard three: 4/4 audited declarations are clean |

## 1. lam4 is the four-form

- **The sign check.** A four-form $\omega$ becomes the symmetric operator on $\Lambda^2$ with $\langle\omega(e_{pq}),e_{rs}\rangle=\omega(p,q,r,s)$. On the pair orderings of lam4 this gives $\omega(i,j,k,l)=1$. Next, $\omega(k,i,j,l)=+1$ because $(k,i,j)$ is a cyclic, and so even, permutation of $(i,j,k)$. Finally $\omega(i,l,j,k)=+1$ because moving $l$ from slot 4 to slot 2 is a 3-cycle. All three coefficients are therefore $+1$ in the orderings $(ij,kl)$, $(ki,jl)$, $(il,jk)$ that lam4 uses.
- **The phi convention does not change the sign.** phi ([WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean#L45)) is $E_{ji}-E_{ij}$, and each of $a,b,c$ is bilinear in two phis, so the sign enters squared.
- **The claim agrees with fourSet_bianchi_iff** ([L121Bianchi.lean:78](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L78)), which cuts out the Bianchi part of the block as $x+y+z=0$. The supports of $a,b,c$ are disjoint pair sets and their norms are equal, so the three are pairwise orthogonal of equal norm. The orthogonal complement of $x+y+z=0$ in the block is then the line through $(1,1,1)$, which is lam4.
- **A consistency check through the same machinery.** Take $w=$ jw in fourSet_span. The coefficient of $a$ in $I\circ(xa+yb+zc)$ is $\tfrac12\cdot2(x+y+z)$, and likewise for $b$ and $c$. On the Bianchi cut this is $0$, so $v\#I=0-v=-v$, which is the Weyl eigenvalue. At $(1,1,1)$ it is $3v$, which gives $2$. Had a pair ordering been flipped, $(1,1,1)$ would mix the two eigenvalues and neither value would come out.
- **Gap 1a.** The header's parenthesis at [L131Four.lean:13-14](../lean/HamiltonsCubic/Results/L131Four.lean#L13), "the orthogonal complement of the Bianchi cut", is a docstring assertion with no Lean statement behind it. It is true, as shown above. Neither orthogonality nor total antisymmetry of lam4 is typed.

## 2. sharpCross_four_id

- **The # is the record's.** sharpCross ([FoxProduct.lean:264](../lean/HamiltonsCubic/Base/FoxProduct.lean#L264)) is $\tfrac12(\mathrm{sharpOp}(X+Y)-\mathrm{sharpOp}\,X-\mathrm{sharpOp}\,Y)$, the polarisation of the quadratic map $R\mapsto R\#R$. That is Böhm–Wilking's bilinear $R\#S$. L131Diag's sharpCross_diag_id and L131Sharp's sharpCross_id use the same operator, with $I$ written as `fun X => X`, so all four entries of the table are stated in one convention. The $-1$ on Weyl in L131Sharp is the calibration that fixes the constant.
- **The arithmetic, redone by hand.** fourSet_span with $w=$ jw sets every off-diagonal weight to $1$, so each bracket $w_{pq}+w_{rs}$ equals $2$. The coefficient of each of $a,b,c$ is then $\tfrac12(2+2+2)=3$, which gives $I\circ v=3v$ ([hfox, :73](../lean/HamiltonsCubic/Results/L131Four.lean#L73)). The Jordan half is $\tfrac12(v(IZ)+I(vZ))=\tfrac12(vZ+vZ)=vZ$ for skew $Z$, because $vZ$ is skew by lam4_skew ([hjord, :83](../lean/HamiltonsCubic/Results/L131Four.lean#L83)). foxProd_split then leaves $v\#I=3v-v=2v$.
- **Replacing $I$ by diagOp jw is legitimate.** sharpOp_congr_on_skew needs its two operators to agree on skew inputs and $R+I$ to preserve skewness. The proof supplies both through lam4_skew and diagOp_jw_skew.
- **The statement's scope is right.** It holds for every skew $Z$ and every choice of distinct $i,j,k,l$ in any finite type, which is the claim at every $n\ge4$.
- **A minor point.** rk2_skew' ([:37](../lean/HamiltonsCubic/Results/L131Four.lean#L37)) generalises L126Bridge's rk2_skew from Fin n to arbitrary ι, so it is not a pure duplicate. The two could be merged.

## 3. Is "on the four-set representatives" enough, and is the owed list right?

- **For Λ⁴ the representatives already span.** The lam4 values over $i<j<k<l$ are the images of the standard basis $e_i\wedge e_j\wedge e_k\wedge e_l$ of $\Lambda^4\mathbb R^n$, so $\Lambda^4$ is their linear span. No frame images and no appeal to sharpBil_act are needed. The case differs from Weyl and $S^2_0$, whose coordinate-diagonal representatives span only after frame rotation.
- **What the full $\Lambda^4$ claim still owes is linearity.** Extending $v\#I=2v$ from the basis to all of $\Lambda^4$ needs $X\mapsto\mathrm{sharpCross}\,X\,I$ to be additive and homogeneous on linear $X$. I searched the layer for sharpCross_add, sharpCross_smul and sharpCross_lin and found none. The frame-image route for the other summands needs the same linearity, since equivariance gives the eigenvalue only on each image, and summing images needs linearity.
- **Gap 3a.** The INDEX row ([lean/INDEX.md:492](../lean/INDEX.md#L492)) lists as owed "that each summand is spanned by frame images of these representatives". For $\Lambda^4$ that overstates what is owed. The row also omits the linearity of sharpCross in its first slot, which every summand owes. A precise wording would be: "linearity of $\cdot\#I$ (sharpCross in its first argument), owed for all four summands; for Weyl and $S^2_0$, spanning by frame images of the diagonal representatives; $\Lambda^4$ and $\mathbb R\cdot\mathrm{Id}$ are spanned by their representatives directly".
- **Gap 3b.** L131Diag's header ([L131Diag.lean:23-25](../lean/HamiltonsCubic/Results/L131Diag.lean#L23)) still says "the three summands are spanned by their images under the frame group". That is consistent, because it excludes $\Lambda^4$. It has the same linearity omission.
- **Gap 3c (record side).** [findings/isotropy-cap.md:433](../findings/isotropy-cap.md#L433) still says that only $\#I$'s first three entries are machine-checked, citing L131Diag, and that the fourth follows "from the Casimir on $\Lambda^4$". It does not cite L131Four.lean or sharpCross_four_id.
- **No Λ⁴ predicate exists in the layer.** I searched for `IsAlt`, `Alt` and `Lambda4`. The full claim therefore cannot yet be stated in Lean, and the row's "statement: not typed" is accurate for that reason.

## 4. Axioms

- `python3 scripts/misc/axiom_audit.py --only L131Four` printed "auditing 4 declarations across 1 files" and "4/4 clean -- resting on the standard three alone". The file contains no `native_decide` and no `sorry`.

## 5. What would break each claim, and what I did to look for it

| Claim | Breaking object | Search |
|---|---|---|
| 1 | A pair ordering in lam4 with the wrong parity, for example $\varphi_{ik}\odot\varphi_{jl}$ in place of $\varphi_{ki}\odot\varphi_{jl}$, which would make $(1,1,1)$ a mix of $\Lambda^4$ and Weyl | Checked the permutation parity of all three orderings by hand. Cross-checked through fourSet_span: the cut $x+y+z=0$ gives $-1$ and $(1,1,1)$ gives $2$, a clean split |
| 2 | A sharpCross that is a multiple of the record's #, for example with the $\tfrac12$ missing | The same sharpCross gives $-1$ on Weyl (L131Sharp) and $-1$, $(n-4)/2$, $n-2$ on the diagonal (L131Diag), matching the record. Screen: $\sum\dim\times$ eigenvalue equals $-m(m-1)(m-2)/4$ at $m=4$ ($-10+0+2+2=-6$) and at $m=5$ ($-35+7+3+10=-15$) |
| 3 | An element of $\Lambda^4$ outside the span of the lam4 values, or a failure of additivity of $\cdot\#I$ | The first is impossible, because the lam4 values form the standard basis. The second is owed: no lemma found |
| 4 | sorryAx or ofReduceBool beneath a declaration | Axiom audit, 4/4 clean |

## Gaps, precise

- [L131Four.lean:13-14](../lean/HamiltonsCubic/Results/L131Four.lean#L13): the orthogonal-complement and total-antisymmetry claim is untyped. It is true.
- [lean/INDEX.md:492](../lean/INDEX.md#L492): the owed list misplaces $\Lambda^4$ under "spanned by frame images" and omits the linearity of sharpCross in its first argument.
- [L131Diag.lean:23-25](../lean/HamiltonsCubic/Results/L131Diag.lean#L23): the same linearity omission.
- [findings/isotropy-cap.md:433](../findings/isotropy-cap.md#L433): the record does not cite L131Four for the fourth entry.
- Provenance: the git log has no message describing L131Four. This review stands in for it.
