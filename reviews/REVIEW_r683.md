# Review r683, Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ as gauge

**Reviewer A of an independent pair on identical briefs. Target: [findings/sym3-blocks.md](../findings/sym3-blocks.md), the block headed `#### Lemma L88, $\dim\mathrm{Sym}^2=65$, $\dim\Lambda^2=24$, and the $24$ are gauge`, together with the `## The unknown count is real symmetric, and a Hermitian ansatz over $\mathbb Q(i)$ inflates it` section beneath it.**

## Verdict: GAP

**All three numbers are right and all three are hand-derivable in about six lines, no Weyl integration is needed for any of them.** Given [L83](../findings/sym3-blocks.md)'s multiplicity column and the real type of every block, Schur's lemma gives $65$, $24$ and $89$ immediately; the block instead cites a run and never states the argument. **The brief's central question resolves in the affirmative: the certificate's $47$ Hermitian parameters are exactly consistent with this block's $65$**, being $\sum m'^2$ over the *restricted* multiplicities against $36=\sum m'(m'+1)/2$ over the same, the same $\sum m^2$ versus $\sum\binom{m+1}2$ mechanism L88 states on the full space. The gap on the restricted space is $11$, and the record already carries both halves (a "$34$-dimensional kernel" and a "$36-13=23$ dimensional" family, thirteen lines apart), without anywhere saying they are one object in two parametrisations.

**What is overstated is the load-bearing word.** "Gauge" is *derived*, in one line and correctly, for the Gram-to-sextic map. It is *false* for the SDP: translating a feasible Gram by an antisymmetric invariant leaves the PSD cone, with a two-by-two witness given in §4. What is true, and is the statement the block needs, is that the antisymmetric part is a redundant coordinate that may always be set to zero, a different claim with a different proof.

**And $65+24=89$ is not a check.** It is an identity in the multiplicities holding for *every* multiplicity list, so it cannot detect an error in the table. It is a restatement of $65-24=41$.

## Readings adopted, every one of them

| symbol | reading I use | why |
| --- | --- | --- |
| $\mathcal W_5$ | the real $O(5)$-irreducible $[2,2]$, $\dim=35$ | [conventions.md](../findings/conventions.md), $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ gives $5\cdot2\cdot6\cdot7/12=35$ |
| $(\lambda_1,\lambda_2)$ in [L83](../findings/sym3-blocks.md)'s table | **$e$-coordinates** | forced: $(2,2)$ must be $\mathcal W_5$ at $35$, and $4\omega_2=2e_1+2e_2$. The $\omega$-reading fails every row |
| $m_\lambda$ | multiplicity of $V_\lambda$ in $\mathrm{Sym}^3(\mathcal W_5)$, read off [L83](../findings/sym3-blocks.md)'s table | the block's own "measured multiplicities" |
| $m'_\lambda$ | multiplicity after the orbit constraint of [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md), $m_\lambda-1$ when $\lambda_2$ is even, $m_\lambda$ when odd | mine; the record has the *shape* but no symbol |
| "unknowns" | **ambiguous on the record and I distinguish**: $65$ is the count on the **full** $\mathrm{Sym}^3$; $36$ and $47$ are counts on the **restricted** space $K$ | L88 and L86 use the one word for the two objects, which is the whole of the $47$-versus-$36$-versus-$65$ confusion |
| an SOS Gram | a bilinear form on the space of *cubics*, $\mathrm{Sym}^3(\mathcal W_5^*)$ | the block writes $\mathrm{Sym}^3(\mathcal W_5)$; harmless at the level of dimensions because $O(5)$ preserves an inner product, but see §6 |
| block extent | a `####` block runs to the next `####`, absorbing the `##` in between | line 92's `##` sits below L88's `####` and above L89's; under the other reading L88 has no content at all |

**The three conventions repaired in [conventions.md](../findings/conventions.md) on 2026-09-04 ($\theta_0(n)$, $\Theta_n$, $S_{XYZ}$), do not appear in L88 and do not bear on it.** Nor does any normalisation of the $\Lambda^2$ pairing: every claim here is a dimension.

## 1. The three numbers, derived by hand

Write $U=\mathrm{Sym}^3(\mathcal W_5)$ as a real $O(5)$-module, $U\cong\bigoplus_\lambda M_\lambda\otimes V_\lambda$ with $M_\lambda$ a trivial multiplicity space of dimension $m_\lambda$.

**Step 1, every $V_\lambda$ is of real type, and this is a hypothesis of the count rather than a footnote.** Every $\lambda$ occurring is integral for $B_2$, so the representation factors through $SO(5)$ rather than only through $Spin(5)\cong Sp(2)$; the quaternionic irreducibles of $\mathfrak{so}(5)\cong\mathfrak{sp}(4)$ are exactly the half-integral ones, of which the spin representation is the first, and none occur in a tensor construction of $\mathcal W_5$. Hence $\mathrm{End}_{O(5)}(V_\lambda)=\mathbb R$ and $V_\lambda$ carries an invariant **symmetric** form, unique up to scale, and no invariant antisymmetric one:

$$\dim(\mathrm{Sym}^2V_\lambda)^{O(5)}=1,\qquad \dim(\Lambda^2V_\lambda)^{O(5)}=0,\qquad (V_\lambda\otimes V_\mu)^{O(5)}=0\ \ (\lambda\neq\mu).$$

**Step 2, the plethysm of a tensor product.** For any two spaces, $\mathrm{Sym}^2(A\otimes B)=\mathrm{Sym}^2A\otimes\mathrm{Sym}^2B\ \oplus\ \Lambda^2A\otimes\Lambda^2B$ and $\Lambda^2(A\otimes B)=\Lambda^2A\otimes\mathrm{Sym}^2B\ \oplus\ \mathrm{Sym}^2A\otimes\Lambda^2B$. Put $A=M_\lambda$ (trivial action) and $B=V_\lambda$, take invariants, and use Step 1:

$$\mathrm{Sym}^2(U)^{O(5)}=\bigoplus_\lambda\mathrm{Sym}^2(M_\lambda),\qquad \Lambda^2(U)^{O(5)}=\bigoplus_\lambda\Lambda^2(M_\lambda).$$

**Step 3, read off the dimensions.**

$$\dim\mathrm{Sym}^2(U)^{O(5)}=\sum_\lambda\binom{m_\lambda+1}2,\qquad \dim\Lambda^2(U)^{O(5)}=\sum_\lambda\binom{m_\lambda}2,\qquad \text{sum}=\sum_\lambda m_\lambda^2=\dim_{\mathbb R}\mathrm{End}_{O(5)}(U).$$

**Step 4, substitute [L83](../findings/sym3-blocks.md)'s column**, twelve $m=1$, nine $m=2$, one $m=3$, two $m=4$:

| moment | value | arithmetic |
| --- | --- | --- |
| $\#\lambda$ | $24$ | $12+9+1+2$ |
| $\sum m$ | $41$ | $12+18+3+8$ |
| $\sum\binom{m+1}2$ | $\mathbf{65}$ | $12\cdot1+9\cdot3+1\cdot6+2\cdot10$ |
| $\sum\binom m2$ | $\mathbf{24}$ | $12\cdot0+9\cdot1+1\cdot3+2\cdot6$ |
| $\sum m^2$ | $\mathbf{89}$ | $12+36+9+32$ |

**Confirmed, all three, with no computation beyond this table.** The per-multiplicity split $65=12+27+6+20$ also reproduces [L83](../findings/sym3-blocks.md)'s own "unknowns" column $12/27/6/20$ row by row, which is a check the block never claims.

**So: is Weyl integration a derivation a reader can follow, or a run?** It is a run. [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) extracts constant terms from a two-variable Laurent polynomial built from the degree-$3$ plethysm of a $35$-dimensional character; no reader checks that by hand. **The six lines above make the run unnecessary for the numbers**, which is the repair: the block should carry Steps 1–3 and cite the run as the independent confirmation it genuinely also is.

## 2. Are $65$, $24$ and $89$ three facts or one? One, and the displayed closure carries zero information

**Given the multiplicity column, any one of the three determines the other two.** $89=65+24$ and $41=65-24$, so the pair $(\sum m,\sum m^2)$ and the pair $(65,24)$ are the same data.

**The killer point: $\sum\binom{m+1}2+\sum\binom m2=\sum m^2$ is an identity, true of *every* multiset of multiplicities.** It is $\tfrac{m^2+m}2+\tfrac{m^2-m}2=m^2$ summed. So the displayed "$65+24=89$" is not a consistency check on anything, corrupt the table however you like and it still holds. The block sets it out as though it were a closure.

**What *is* a real check is the agreement between the run and the table.** The script computes $\dim\mathrm{Sym}^2$ and $\dim\Lambda^2$ from the character of $\mathcal W_5$ alone; the multiplicity list enters only as an `assert`. So $65$ and $24$ arriving twice **is** evidence, and it is evidence about the *multiset* $\{m_\lambda\}$, a corruption changing $\sum m^2$ or $\sum m$ would be caught.

**But it is blind in exactly the way [r663](REVIEW_r663.md)/[r664](REVIEW_r664.md) found L83 blind**: the check sees the multiplicities only through their moments, so it cannot see *which* $\lambda$ carries which multiplicity. Swapping the multiplicities of the two dimension-$35$ blocks $(2,2)$ and $(2,1)$ leaves $65$, $24$, $89$, $41$, $7770$ and L84's Casimir multiset all unchanged, and leaves [L87](../findings/sym3-blocks.md)'s $3570$ unchanged too, that being a sum of dimensions over the even blocks and independent of every multiplicity.

**The number that *does* see the swap is $36$, and it is downstream of this block.** $(2,2)$ has $\lambda_2$ even and $(2,1)$ odd, so the swap sends the surviving pair $\{4-1,\,2\}=\{3,2\}$ to $\{2-1,\,4\}=\{1,4\}$: the same $25$ multiplicities, but $\sum\binom{m'+1}2$ moves $36\to38$ and $\sum m'^2$ moves $47\to51$. **So [L86](../findings/sym3-blocks.md)'s $36$ is the first number in the chain that distinguishes the two $35$s, and it distinguishes them only because the parity rule breaks the symmetry that every moment of $\{m_\lambda\}$ respects.** Worth recording, since it is the one place the label information is actually consumed.

**Contra the brief's premise:** a companion audit reported "$24$ the block count of that table". **In L88 the $24$ is $\sum\binom m2$, not the block count.** The two are numerically equal by accident, the coincidence is $\sum(m-2)(m+1)=0$, which here reads $2\cdot10+1\cdot4+9\cdot0+12\cdot(-2)=0$, with no structural reason. So they are *not* the same number arriving twice; they are two different numbers that collide, which is worse editorially. **The block then uses the collided value a third time**, in "every one of the $24$ weights is integral for $B_2$", where $24$ is again the block count. Three occurrences of "$24$" in one block, two meanings, no distinguishing word.

## 3. Why the unknowns are $\mathrm{Sym}^2$ and what the $\Lambda^2$ part is

Let $q_1,\dots,q_N$ be a basis of the cubics and $v(W)=(q_1(W),\dots,q_N(W))$. An SOS representation is $F(W)=v(W)^{\mathsf T}Gv(W)$ with $G\succeq0$. Since $v^{\mathsf T}Gv=\langle G,\,vv^{\mathsf T}\rangle$ and $vv^{\mathsf T}$ is symmetric for every $W$, only the symmetric part of $G$ is seen:

$$v^{\mathsf T}Gv=v^{\mathsf T}G^{\mathrm{sym}}v\quad\text{for all }W,\qquad G^{\mathrm{sym}}=\tfrac12(G+G^{\mathsf T}).$$

**So the Gram-to-sextic map $\mu$ kills the antisymmetric part identically, and the $\Lambda^2$ invariants are precisely $\ker\mu$ inside the full $89$-dimensional space of invariant bilinear forms.** The transformation the $24$ generate is the **additive translation group** $G\mapsto G+A$, $A\in\Lambda^2(U)^{O(5)}\cong\mathbb R^{24}$, and it acts trivially on $\mu$ because $\mu$ factors through $G\mapsto G^{\mathrm{sym}}$. **That much the block asserts in a clause and it is correct, and it is a derivation rather than an assertion**, one line, but a real one.

## 4. Where "gauge" fails, with the witness

**Gauge means the transformation changes nothing. It changes feasibility.** Translation by $A$ preserves $\mu(G)$ and does *not* preserve $G\succeq0$.

Take a multiplicity-$2$ block, $S=I_2$, and the Hermitian ansatz $H=S+iA$ with $A=\begin{psmallmatrix}0&2\\-2&0\end{psmallmatrix}$:

$$H=\begin{pmatrix}1&2i\\-2i&1\end{pmatrix},\qquad \mathop{\mathrm{spec}}(H)=\{-1,\,3\}.$$

**$S\succ0$ and $S+iA$ is indefinite**, so the translation carries a feasible certificate out of the cone while leaving the sextic fixed. The $24$ therefore act freely on the *affine solution set of the linear equations* and not on the *SDP feasible set*. Calling them "gauge" without qualification claims the second.

**The statement the block actually needs, and its proof, in two lines.** For real $v$ and real antisymmetric $A$, $v^{\mathsf T}Av=0$, so $v^*Hv=v^{\mathsf T}Sv$; hence $H\succeq0\Rightarrow S\succeq0$, and conversely $S\succeq0$ gives the Hermitian psd point $H=S$ by taking $A=0$. **So the projection $H\mapsto S$ maps the invariant Hermitian psd cone *onto* the invariant real-symmetric psd cone.** Nothing is lost by setting $A=0$: the Hermitian ansatz is a redundant over-parametrisation, not a relaxation. **That is what makes the reduction $89\to65$ legitimate**, and it is the half of the argument the block omits, the half on which a certificate route could actually have died.

**One caution attaches, and it is [r204](REVIEW_r204.md)'s.** "Set $A=0$" is well posed only once "real" is meant with respect to the real structure of $U$, and the $\mathbb Q(i)$ highest-weight basis is not real for it. In that basis, deleting the coordinate-wise imaginary part need produce neither an invariant nor a psd form. **The block records the refutation and I confirm its logic independently**: a Hermitian $h$ with nonzero imaginary off-diagonals is consistent with real type, since it only says the basis is not a real one; and rephasing one copy of a multiplicity-$2$ block by $i$ moves the split while leaving $h$ Hermitian and nonsingular, so the split is not basis-invariant. **The count survives, the coordinates do not, and the block says so.**

## 5. The real-versus-Hermitian axis: $47$, $36$ and $65$ reconcile exactly

This is the brief's central question and it settles cleanly.

**The three numbers are counts of three different things, and each is right about its own.**

| number | space | field / symmetry | formula | check |
| --- | --- | --- | --- | --- |
| $65$ | **full** $\mathrm{Sym}^3\mathcal W_5$ | real symmetric | $\sum_\lambda\binom{m_\lambda+1}2$ | $12+27+6+20$ |
| $89$ | **full** | invariant Hermitian over $\mathbb C$ / all invariant bilinear over $\mathbb R$ | $\sum_\lambda m_\lambda^2$ | $12+36+9+32$ |
| $36$ | **restricted** to $K$ | real symmetric | $\sum_\lambda\binom{m'_\lambda+1}2$ | $9\cdot1+5\cdot3+2\cdot6$ |
| $\mathbf{47}$ | **restricted** to $K$ | invariant Hermitian over $\mathbb Q(i)$ | $\sum_\lambda m'^2_\lambda$ | $9\cdot1+5\cdot4+2\cdot9$ |

**Derivation of $m'$.** [L86](../findings/sym3-blocks.md)'s parity rule kills one multiplicity from each block with $\lambda_2$ even and none from a block with $\lambda_2$ odd; [L87](../findings/sym3-blocks.md) promotes the rank-one bound to an identity. Applying that to L83's table by hand: the two $m=4$ blocks $(4,2)$ and $(2,2)$ are both even and drop to $3$; $(3,2)$ is even and drops to $2$; of the nine $m=2$ blocks, the four with odd $\lambda_2$ ($(4,3)$, $(4,1)$, $(3,1)$, $(2,1)$), stay at $2$ and the five even ones drop to $1$; of the twelve $m=1$ blocks, the four odd ones ($(6,3)$, $(5,3)$, $(5,1)$, $(3,3)$), stay and the eight even ones die. **That is $\{3,3\}\cup\{2^5\}\cup\{1^9\}$: two $3\times3$, five $2\times2$, nine scalars, sixteen surviving blocks, $25$ surviving multiplicities**, reproducing L86's shape exactly, and the eight named dying blocks exactly. **Sixteen even blocks, dimensions summing to $3570$, also reproduces**, which is L87's cap.

Then

$$\sum\binom{m'+1}2=2\cdot6+5\cdot3+9\cdot1=\mathbf{36},\qquad \sum m'^2=2\cdot9+5\cdot4+9\cdot1=\mathbf{47},\qquad \sum\binom{m'}2=2\cdot3+5\cdot1=\mathbf{11}.$$

### The answer the record most needs

> **The certificate's $47$ Hermitian parameters are consistent with this block's $65$.** They are not competing counts of one object. $47$ is the Hermitian count on the orbit-restricted space, $36$ its real-symmetric shadow, and $47=36+11$ is *the same theorem L88 states on the full space*, $89=65+24$, transported through [L86](../findings/sym3-blocks.md)/[L87](../findings/sym3-blocks.md). **The right count for an SOS certificate over $\mathbb R$ is $36$** (real symmetric on the restricted space) and the certificate's extra $11$ coordinates are its gauge, in the same qualified sense as §4.

**The record already contains the corroboration and does not notice it.** [findings/sym3-blocks.md](../findings/sym3-blocks.md) line 137 records "an exact $34$-dimensional kernel" for the certificate family; line 151 records "the affine family is $36-13=23$ dimensional". With the restricted rank $13$ of [L62](../findings/sym3-blocks.md), $47-13=34$ and $36-13=23$, and $34-23=11$. **Two parametrisations of one affine family, fourteen lines apart, differing by exactly the restricted gauge dimension, with nothing on the record saying so.** I regard that as the strongest single confirmation of the reconciliation: three independent recorded numbers ($47$, $34$, $23$), all land where $\sum m'^2$ and $\sum\binom{m'+1}2$ put them.

**Consequently [L61](../findings/sym3-blocks.md)'s audit finding is downgraded but not dismissed.** "$47$ Hermitian parameters against the file's stated $36$ real-symmetric unknowns" is *legitimate and now explained*; what remains true is that it is **unstated**, and that converting the recorded $47$-parameter certificate to a $36$-parameter real one is not the trivial "drop the imaginary part", because of [r204](REVIEW_r204.md)'s real-structure obstruction. **That conversion is the open item this block leaves.** It is an analytic task, compute the real structure $\sigma$ on each $M_\lambda$ from the Hermitian and symmetric invariant forms, and I do not open it here.

## 6. $O(5)$ against $SO(5)$

**The step is valid at $n=5$ and the block does not state it.**

$\det(-I)=(-1)^5=-1$, so $-I\notin SO(5)$ and $O(5)=SO(5)\times\{\pm I\}$. The action of $-I$ on $\Lambda^2\mathbb R^5$ is $(-1)^2=+1$, hence trivial on $\mathcal W_5$ and on every $\mathrm{Sym}^k\mathcal W_5$. **So $O(5)$-invariants and $SO(5)$-invariants coincide, and $B_2$ highest weights may be used as $O(5)$ block labels.** At even $n$ this fails: $-I\in SO(n)$, the non-identity component is generated by a reflection acting nontrivially, and the two invariant rings differ.

**L88 never mentions $SO(5)$, writes $O(5)$ throughout, and silently consumes $B_2$ data.** The justification is in the file twice, in [L83](../findings/sym3-blocks.md)'s closing italic ("legitimate only because $\det(-I)=-1$ at odd $n$, and the same step fails at even $n$") and, in the form actually needed, inside [L86](../findings/sym3-blocks.md) ("every constituent of $\mathrm{Sym}^3(\mathcal W_5)$ has $-\mathrm{Id}$ acting trivially"). **So the block's own file already settles it, above, and L88 cites neither.** This is the seventeenth-odd instance of the pattern the brief names.

A second, smaller version of the same slip: the block writes the unknowns as $\mathrm{Sym}^2(\mathrm{Sym}^3\mathcal W_5)^{O(5)}$ when a Gram is a form on the *cubics*, $\mathrm{Sym}^3(\mathcal W_5^*)$. **The dimension is unaffected**, because $O(5)$ preserves an inner product and $\mathcal W_5\cong\mathcal W_5^*$ equivariantly, but this is the same unnamed-pairing defect [r651](REVIEW_r651.md)/[r652](REVIEW_r652.md) recorded against [L59](../findings/sym3-blocks.md), recurring here.

## 7. Hedging clauses, one at a time

| clause | verdict |
| --- | --- |
| "Weyl integration **settles it**" | **True but misdirected.** The run is sound and independent; the settling argument is six lines of Schur and is absent. A reader is told to trust a script for something checkable by hand. |
| "a **dimension** rather than a basis convention" | **True and the block's best sentence.** $\mathrm{Sym}^2(U)^{O(5)}$ is basis-free; the $\mathbb Q(i)$ ansatz's $89$ is a coordinate count. |
| "a Hermitian ansatz over $\mathbb Q(i)$ **inflates** it" | **True, and quantified correctly**: $+24$ on the full space, $+11$ on the restricted one. |
| "and they are **gauge**" | **Half-derived.** Correct for $\mu$, one line, and the block gives that line. False for the PSD cone, witness in §4. The claim it needs is that the Hermitian psd cone surjects onto the real one, which is true and unstated. |
| "**genuine** $O(5)$-invariants, of $\Lambda^2$" | **True.** $\Lambda^2(U)^{O(5)}=\bigoplus\Lambda^2M_\lambda$ is a genuine invariant space of dimension $24$. |
| "**every one of the $24$ weights** is integral for $B_2$, hence of real type" | **True, and load-bearing in a place the block does not mark.** Real type is what makes $65$ the symmetric count and $24$ the antisymmetric one; were any block quaternionic the two would swap. The block deploys the fact only to explain the $\mathbb Q(i)$ basis. |
| "touching **none of the certificate machinery**: no adapted basis, no cache, no prime, no highest-weight vectors" | **True of the script.** [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py) imports only the character machinery of [run_n5_constraint_count.py](../scripts/runs/run_n5_constraint_count.py) and uses the multiplicity list solely inside an `assert`. |
| "the $24$ of the $89$ are gauge is **a theorem**" (r204's sentence, quoted in the block) | **True as stated**, with §4's qualification. |

## 8. Provenance, and pointers

**Provenance clean.** `git log -S` puts the whole paragraph at one commit, `5af38a68` *"docs(findings): the unknowns are real symmetric, and rank 14 is a theorem"*, whose body states the mathematics exactly as the block now reads it, including "the $24$ are invariants of $\Lambda^2$ and are gauge, since an antisymmetric form contributes nothing to a sextic" and "every weight here is integral for $B_2$, hence of real type". The heading arrived later at `8d869d2c` *"place headings for Lemmas 83-92"* and touched no prose in this block. **No rewording-into-falsehood here, unlike [L83](../findings/sym3-blocks.md) and [L61](../findings/sym3-blocks.md).**

**The block's prose is a near-verbatim transcription of the docstring of [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py).** Worth recording because the docstring is where the argument's absence originates: it too asserts the identities and computes rather than derives.

**Pointers.** The block carries exactly one link, to [run_n5_unknown_count.py](../scripts/runs/run_n5_unknown_count.py); **it resolves**, and the script does what the sentence says. **Four reviewers are named in bare numerals (204, 192, 201, 202), with no links**, though [REVIEW_r204.md](REVIEW_r204.md), [REVIEW_r192.md](REVIEW_r192.md), [REVIEW_r201.md](REVIEW_r201.md) and [REVIEW_r202.md](REVIEW_r202.md) all exist. **[L83](../findings/sym3-blocks.md), [L86](../findings/sym3-blocks.md) and [L87](../findings/sym3-blocks.md) are consumed and none is cited**, the multiplicity column is L83's, and the parity rule and rank-one step are the only route from $65$ to the certificate's $47$.

**Index state.** [findings/INDEX-results.md](../findings/INDEX-results.md) line 103 records L88 as "Gate 2: no verdict on the record", which this pair supplies.

## 9. What is owed, none of it changing a number

1. **Add Steps 1–3 of §1** (six lines) so the numbers are hand-checkable and the run is corroboration rather than authority.
2. **Say that real type is a hypothesis of the count**, not only an explanation of the $\mathbb Q(i)$ basis.
3. **Replace the bare "gauge"** with the two-line statement of §4: $\mu$ kills the antisymmetric part, and the Hermitian psd cone surjects onto the real one, so $A=0$ is always available. Note that translation by $A$ does not preserve feasibility.
4. **State the reconciliation of §5** ($47=36+11$ on the restricted space, mirroring $89=65+24$) and reconcile the "$34$-dimensional kernel" of line 137 with the "$36-13=23$" of line 151. **This is the repair the record most needs**; it closes an open audit finding on [L61](../findings/sym3-blocks.md).
5. **Distinguish the two $24$s** and say the collision is an accident.
6. **Say that $65+24=89$ is an identity in the $m$'s** and therefore not a closure.
7. **State the $\det(-I)=-1$ step or cite [L86](../findings/sym3-blocks.md)**, and say the word "unknowns" differently on the full and restricted spaces.

## 10. Computation not run, and what it would decide

**Standing rule observed: analysis only.** The arithmetic in §1 and §5 is a screen of sums I derived by hand first, on multiplicity lists I wrote out for the purpose; it is reported as a screen and every number in it is also given as an explicit hand sum in the tables.

**One item is genuinely blocked.** Identifying *which* $11$ directions are the restricted gauge, and converting the recorded $47$-parameter certificate to a $36$-parameter real-symmetric one, needs the real structure $\sigma$ computed on each surviving $M_\lambda$, [r204](REVIEW_r204.md)'s point, and the reason "drop the imaginary part" is not available. **What the run would decide**: whether the recorded certificate has a real-symmetric representative that a reader can check without $\mathbb Q(i)$. **If yes**, the certificate's verifiability improves and $47$ leaves the record. **If no** (which would mean the psd surjection of §4 fails in practice for a *rational* representative), the obstruction is arithmetic rather than representation-theoretic and would need naming. **I do not open it.**
