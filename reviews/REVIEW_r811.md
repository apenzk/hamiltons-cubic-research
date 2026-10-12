# r811: Gate 2 on the Lean batch: the star layer, the axiom gate, L191's typing, and the record repair

*Cold brief. I was given four commits and the pointers, and read [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean), [L190Statement.lean](../lean/HamiltonsCubic/Results/L190Statement.lean), [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean), [axiom_audit.py](../scripts/misc/axiom_audit.py), [lean/INDEX.md](../lean/INDEX.md), [findings/INDEX-results.md](../findings/INDEX-results.md) and [diagonal-half.md](../findings/diagonal-half.md) blocks L178 through L191 from scratch. **The programme is on an analysis-only footing and I opened no numerical line of work.** Three machine actions were screens: two runs of the repository's own [axiom_audit.py](../scripts/misc/axiom_audit.py) restricted to one file each, and a static re-implementation of that script's declaration extractor over the sources it reads. They are reported as screens and never as evidence for a positive claim. Log: [agent_logs/g2-leanbatch-r811.log](../agent_logs/g2-leanbatch-r811.log).*

| Target | Verdict |
|---|---|
| **A**, the star layer, `862e87c6` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** Both theorems are right, and `IsSkew` is the correct scope rather than a weakening. *$\dim\Lambda^2_+=3$ is typed nowhere*: spanning is typed, independence is not, $\Lambda^2_-$ is untouched, and trace-freeness is a different input entirely. The file's own header still says the opposite of what the commit proved |
| **B**, the axiom gate, `fb6c12cc` | **PLAUSIBLE.** The transitivity claim is right and it is what makes the module-grouping worry moot. *But the extractor silently drops 25 theorems and invents 2*, and the script never compares what it asked with what it parsed, so `4255 of 4398` is a count of what was parsed and not of what exists |
| **C**, L191's typing, `8af22b49` | **CONFIRMED AS TYPED, PROSE OVERCLAIMS.** `pair_coincidences_at_dim4` is true and is strictly weaker than the falsifier: *it has no orthogonality, no distinctness, and one component of $\Lambda^4$*. The falsifier's pieces are typed elsewhere in the layer and neither index credits them |
| **D**, the record repair, `12219558` | **SPLIT.** The footer arithmetic is **CONFIRMED** exactly. The L191 row is **CONFIRMED** on the mathematics and overcredits its Lean column. The L144 promotion is **REFUTED**: the block still carries the superseded reading in two places, [plan.md](../plan.md) contradicts the promotion in a line the same commit edited, and the numbered table still labels it `Observation`. The `Lean: blocked` reason is **REFUTED as the true blocker** |

**One line.** *No theorem in this batch is wrong, and every declaration I screened is kernel-clean. What fails is the accounting: three of the four commits credit a declaration or a label with more than it carries, the axiom gate cannot see a fifth of a percent of the layer and cannot report that it cannot, and L144 was promoted from `Observation` to `Lemma` while three surviving sentences in two files say the promotion is unearned.*

## 0. What I checked, and the standing rule

Every derivation below is by hand. The two screens were runs of an existing script in [scripts/](../scripts/) restricted by `--only` to a single file, which the brief names as permitted. The third was a pure-Python re-execution of [axiom_audit.py](../scripts/misc/axiom_audit.py)'s own `declarations()` and `sources()` over the tree, which reads files and builds no Lean. No sweep, census, optimisation or falsifier hunt was opened.

## 1. Target A, the star layer

### 1.1 Both theorems are right, and I checked the signs independently

`star4` is $(\star X)_{ab}=\tfrac12\sum_{cd}\varepsilon_{abcd}X_{cd}$, which is the record's Hodge star at the standard orientation with the standard normalisation. It is corroborated inside the layer twice over: `normSq star4 = 6` reproduces [conventions.md](../findings/conventions.md)'s $\lVert\star\rVert^2=6$, and `sdForm_selfDual` puts the three exhibited forms in the $+1$ eigenspace, which fixes the sign of $\tfrac12$ as well as its magnitude.

For `selfDual_expand` I derived the coefficients rather than reading them. With $\varphi_{ij}$ satisfying $(\varphi_{ij})_{ab}=\delta_{ja}\delta_{ib}-\delta_{ia}\delta_{jb}$, so $(\varphi_{01})_{01}=-1$:

- entry $(0,1)$: only $\mathrm{sdForm}_0$ contributes, at $-1$, so the right side is $(-X_{01})(-1)=X_{01}$.
- entry $(2,3)$: only $\mathrm{sdForm}_0$ contributes, again at $-1$, so the right side is $X_{01}$. Self-duality supplies the matching left side, since $\varepsilon_{2301}=\mathrm{sgn}(2,3)\mathrm{sgn}(2,0)\mathrm{sgn}(2,1)\mathrm{sgn}(3,0)\mathrm{sgn}(3,1)\mathrm{sgn}(0,1)=+1$ gives $(\star X)_{23}=X_{01}$, hence $X_{23}=X_{01}$.

The two agree, and the same check at $(0,2)$ and $(0,3)$ closes on $\varepsilon_{1302}=-1$ and $\varepsilon_{1203}=+1$, which is the pattern $\mathrm{sdForm}_1=\varphi_{02}-\varphi_{13}$ carries its minus sign for.

### 1.2 `IsSkew` is the right scope, and "at every bivector" is accurate

`star4` annihilates the symmetric part of its argument, so $\star\star X$ recovers only the skew part: at $X=\mathrm{Id}_4$ it returns $0$. The hypothesis is therefore load-bearing rather than defensive, and since a bivector *is* a skew form, the index's *"$\star(\star X)=X$ at every bivector"* is exactly the theorem. **This attack finds nothing.**

The mirror-image redundancy is worth recording as a curiosity and not as a defect: `selfDual_expand`'s `hX : IsSkew X` is implied by `hd : IsSelfDual X`, because `star4_isSkew` makes every star image skew and `IsSelfDual X` is `star4 X = X`. The statement is not weakened by carrying it.

### 1.3 $\dim\Lambda^2_+=3$ is typed nowhere, and the index states it as though it were

This is the finding. [lean/INDEX.md](../lean/INDEX.md) reads *"so the three exhibited members SPAN and $\dim\Lambda^2_+=3$"*, joining a typed fact to an untyped one in one clause. Spanning is typed, in the strong form of an explicit expansion. The dimension is not, and three separate steps stand between them:

1. **Independence is not typed.** It would follow from `inner2_sdForm`'s Gram matrix $2I$ together with the positive-definiteness of `inner2` on skew forms. Neither the implication nor the definiteness is stated. Grepping the layer for `finrank`, `Basis` and `span` returns two prose hits and no declaration.
2. **$\Lambda^2_-$ is untouched.** `IsAntiSelfDual` is defined at [SelfDual.lean:422](../lean/HamiltonsCubic/Base/SelfDual.lean) and is the subject of no theorem anywhere in the layer, which one grep over `lean/` confirms. L178's step 1 needs *both* summands on three-dimensional spaces, and the index writes $W^\pm$, so it claims the minus side that the commit does not touch.
3. **Trace-freeness is a different input.** The index sentence is *"which is what L178's step 1 needs to call $W^\pm$ trace-free on a three-dimensional space"*. Read as a whole, that credits the commit with the trace-freeness too. L178's own step 4 is explicit that this comes from total trace-freeness and the first Bianchi identity together, and names the round where a reviewer wrongly reported Bianchi unused. Nothing typed here bears on it. What the commit supplies is the three words *"three-dimensional space"* and nothing else in that sentence.

**None of this makes the index false so much as unsplittable**: a later consumer reading the row cannot tell which half is in the kernel. That is the defect a row carries, since rows are what later work is built on.

### 1.4 The file now contradicts itself, in the header a consumer reads first

The commit updated [lean/INDEX.md](../lean/INDEX.md) and left [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean)'s own prose standing. Two spans are now false:

- the module header's *"What is NOT typed here"* list still opens with *"$\star\circ\star=\mathrm{id}$ on $\Lambda^2\mathbb R^4$. It is the $\varepsilon$-contraction identity, and without it neither the splitting nor $\dim\Lambda^2_+=3$ is available. Three explicit members are exhibited; that they span it is not proved"*, at lines 62 to 70 of the file whose last 45 lines prove both halves.
- `selfDualForms`' doc comment at lines 424 to 426 still reads *"That it is three-dimensional is NOT proved here; three explicit members with pairwise-zero pairing are exhibited below, and spanning is not."*

The second is the more damaging, because it sits on the definition rather than in a header, and hover documentation is where a Lean consumer looks. Note that the *first* of these is right for the wrong reason: $\dim\Lambda^2_+=3$ genuinely is still unavailable, per §1.3, but for the independence step rather than for the spanning step it names.

### 1.5 Screen

`python3 scripts/misc/axiom_audit.py --only SelfDual` returned `59/59 clean -- resting on the standard three alone`. So both new theorems are kernel-checked with no `sorry` and no `native_decide` beneath them. **This screen is also the concrete demonstration of Target B's defect**, for which see §2.2.

## 2. Target B, the axiom gate

### 2.1 The transitivity claim is right, and it disposes of the brief's own worry

`#print axioms` walks the whole dependency tree and reports the leaves carrying no proof. So the brief's question, whether a module the index marks `proved` could import one it marks `partial` in a way the module-level grouping hides, answers itself: such a theorem would itself report `sorryAx` and would be one of the 63, sitting in a `proved` module, and the claim *"all 63 sit in modules the index marks partial"* would have failed. The grouping cannot hide a transitive dependency because the audit is per-declaration and transitive. **CONFIRMED**, conditional on every theorem actually being asked, which is where it breaks.

### 2.2 The extractor drops 25 theorems and invents 2, and the script cannot notice

`DECL`'s name class is `[A-Za-z_][A-Za-z0-9_'!?₀-₉]*`, which excludes the dot. Every theorem whose name is dotted is therefore truncated to its prefix, and the generated call names a *definition or structure* rather than the theorem. `#print axioms` on that definition succeeds and reports clean, so the theorem is silently unaudited and something else is reported clean in its place. My static re-run of `declarations()` over the current tree finds **25 such truncations**, among them:

| declaration | file | truncated to |
|---|---|---|
| `IsComplexStructure.orthogonal` | [SelfDual.lean:641](../lean/HamiltonsCubic/Base/SelfDual.lean) | `IsComplexStructure` |
| `IsSphereProduct.isWeyl` | [Families.lean:399](../lean/HamiltonsCubic/Base/Families.lean) | `IsSphereProduct` |
| `RayleighGE.le_of_RayleighLE` | [FoxProduct.lean:383](../lean/HamiltonsCubic/Base/FoxProduct.lean) | `RayleighGE` |
| `IsCoordDiagonal.{zero,add,smul,affine}` | [L148Statement.lean:129](../lean/HamiltonsCubic/Results/L148Statement.lean) | `IsCoordDiagonal`, four times |
| `DiagFloorExact.{sInf_eq,strong_reading}` | [L98Statement.lean:298](../lean/HamiltonsCubic/Results/L98Statement.lean) | `DiagFloorExact`, twice |

Seven of the truncations collide into duplicate fully-qualified names, and `parse()` returns a dict, so those collapse to one entry each and the total is under-counted as well.

**The `--only SelfDual` screen exhibits this in the file under Target A.** It reported `59/59 clean` over 59 generated names. [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) has exactly 59 theorem lines, one of which is `IsComplexStructure.orthogonal`, so one of the 59 names asked was `HamiltonsCubic.SelfDualLayer.IsComplexStructure`, the definition. The file was reported completely clean while one of its theorems was never asked about.

Two false positives run the other way. `DECL` matches any line beginning with `theorem` or `lemma`, including a doc comment that happens to wrap onto one:

- [L128Statement.lean:173](../lean/HamiltonsCubic/Results/L128Statement.lean) is the line `theorem consumes. -/`, the tail of *"the invertibility the implicit function theorem consumes"*, which generates `#print axioms HamiltonsCubic.L128Statement.consumes`.
- [L73Statement.lean:25](../lean/HamiltonsCubic/Results/L73Statement.lean) is `lemma is a statement about a nonnegative pair-symmetric array…`, generating the name `is`, twice.

Both name unknown constants. `main` ignores the build's return code and parses whatever came back, so an errored command simply produces no entry.

### 2.3 The counts are of what was parsed, not of what exists

`main` prints `auditing {len(decls)} declarations` to stderr, then reports `{clean}/{total}` with `total = len(found)`, the size of the parse. **It never compares the two.** A declaration whose `#print axioms` errored, or whose name collided with another, vanishes from both numerator and denominator without a word. So `4255 of 4398` is not a statement about the layer, it is a statement about the subset that answered. The current tree generates 4458 names from 450 files, against the commit's 4398, and the difference is not accounted for anywhere.

### 2.4 Arguing the opposite: does the hole actually break the headline?

I tried to break *"no proved row rests on a sorry"* through the hole and could not. Every real `sorry` in the layer sits in a `Results/*Statement.lean` file, which one grep for `sorry` on its own line establishes. Of the 25 unaudited theorems, those in files that also carry a `sorry` are in [L96Statement.lean](../lean/HamiltonsCubic/Results/L96Statement.lean), [L98Statement.lean](../lean/HamiltonsCubic/Results/L98Statement.lean) and [L128Statement.lean](../lean/HamiltonsCubic/Results/L128Statement.lean), and the index marks all three `partial`. The rest sit in sorry-free files, [Base/](../lean/HamiltonsCubic/Base/) included, or in [L129Statement.lean](../lean/HamiltonsCubic/Results/L129Statement.lean), which is marked `proved` and carries no `sorry` at all. **So the headline survives, by where the sorries happen to live rather than by anything the audit measured.** That is why the verdict is `PLAUSIBLE` rather than `REFUTED`: the conclusion is probably true and the instrument does not establish it.

### 2.5 Two smaller items

- **The allow file does not exist.** [axiom_audit.py](../scripts/misc/axiom_audit.py)'s docstring documents `scripts/misc/axiom_audit_allow.txt` as where a deliberate `native_decide` is recorded. There is no such file, so `allowed()` returns empty and every one of the 80 compiler-dependent declarations fails the gate. The documented exception mechanism has no instance.
- **Bullet 4 is right by reading.** `COMPILER_SHAPE` matches `._native.native_decide.` by shape and `REPORT` carries `re.DOTALL`, so both halves of the wrapped-list diagnosis are implemented as described.

## 3. Target C, L191's typing

### 3.1 The theorems are true, and `selfDual_expand` is what licenses their reach

`wedgeSelf_sdCombo_apply` gives $2(x^2+y^2+z^2)$, which is `inner2_sdCombo` exactly, so it is the record's $\omega\wedge\omega=\lVert\omega\rVert^2f_{1234}$ in the layer's own normalisation. It agrees with `wedgeSelf_unitSD_apply = 1` under the quadratic rescaling by $(\sqrt2)^{-1}$. **And the docstring's *"every pair of $\Lambda^+\mathbb R^4$"* is licensed only by Target A's commit**: before `selfDual_expand`, `sdCombo` was a three-parameter family inside $\Lambda^+$ with nothing saying it exhausted it. The two commits interlock, and this one would have overclaimed the quantifier without the other.

### 3.2 `pair_coincidences_at_dim4` is strictly weaker than the falsifier

The falsifier [r808](REVIEW_r808.md) and [r809](REVIEW_r809.md) built is an **orthonormal pair** in $\Lambda^+\mathbb R^4$ giving an honest rank-two Weyl tensor. What is typed takes two coefficient triples of equal norm. Three gaps, in increasing order of seriousness:

1. **No orthogonality.** The rank-two configuration needs $\langle\omega_1,\omega_2\rangle=0$ for the spectral form $W=\lambda(\omega_1\otimes\omega_1-\omega_2\otimes\omega_2)$ to be a spectral decomposition at all. The hypothesis is absent.
2. **No distinctness, so nothing is falsified.** L191's conclusion is $\omega_2=\pm\omega_1$. A statement that two forms have both coincidences refutes it only when the two forms are *not* $\pm$ each other, and taking $(u,v,w)=(x,y,z)$ satisfies the typed hypothesis with the conclusion holding. **The typed statement is consistent with L191 being true at $\dim V=4$**, so on its own it falsifies nothing. The needed inequality is typed nowhere in the file.
3. **One component of $\Lambda^4$.** Both self-wedges are compared at indices $(0,1,2,3)$ only. $\Lambda^4\mathbb R^4$ is one-dimensional and the alternating lemmas `wedgeSelf_swap01`, `wedgeSelf_swap12`, `wedgeSelf_swap23` and `wedgeSelf_diag01` do determine the rest, but that reduction is not typed, and [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean)'s own header lists it as owed in precisely these words: *"the step needing $\Lambda^4\mathbb R^4$'s one-dimensionality is left out"*. So the docstring's *"$\Phi$'s two components agree"* is one component and one entry of the other, and its claim that *"the images coincide" and "the squares and the self-wedges coincide" are the same statement* is the very identification the header says is missing.

### 3.3 The falsifier's pieces are in the layer, and neither index credits them

This is the constructive half. `unitSD_coincidences (i j : Fin 3)`, in the same file, gives both coincidences for the three standard unit forms, and [SelfDual.lean:558](../lean/HamiltonsCubic/Base/SelfDual.lean)'s `inner2_unitSD i j = if i = j then 1 else 0` types their orthonormality. Taking $i=0$, $j=1$ gives an orthonormal pair with both coincidences, which is r808's and r809's witness with only the step $\omega_2\ne\pm\omega_1$ left to make, and that step is one line from `inner2_unitSD` and bilinearity. **So more of the falsifier is typed than either index says, and the declaration both indexes name is the one that carries least of it.** [lean/INDEX.md](../lean/INDEX.md)'s L191 row and [findings/INDEX-results.md](../findings/INDEX-results.md)'s Lean column both credit `pair_coincidences_at_dim4` alone.

### 3.4 Nothing here types a Weyl tensor

No declaration in the file mentions Ricci-flatness, the first Bianchi identity, tracelessness or pair symmetry. The passage from *"equal squares and equal self-wedges"* to *"the rank-two Weyl configuration is inhabited"* runs through [L180](../findings/diagonal-half.md)(1) and [L179](../findings/diagonal-half.md)(b), and is carried in prose. The docstring's *"the rank-two Weyl configuration is inhabited at `dim V = 4`"* is therefore a claim about the record, made in a Lean file, resting on no declaration in it. The mathematics is right and both Gate 2 reviewers checked it. The typing does not reach it.

### 3.5 Screen

`python3 scripts/misc/axiom_audit.py --only L191` returned `3/3 clean -- resting on the standard three alone`.

## 4. Target D, the record repair

### 4.1 The footer arithmetic is exact

Derived from the rows rather than from the sentence, using the file's own recipe. `grep -o '^| \*\*[0-9]*\*\*' findings/INDEX-results.md` returns **191 rows, all distinct, running 0 through 191 with 60 the only gap**. Ids $0$ through $191$ number $192$, less the unassigned $60$, gives $191$ results, and the next free number is $192$. The footer says all three. **CONFIRMED**, and the pre-commit state was as the body describes.

### 4.2 The L191 row states the lemma, and its Lean column overcredits

*"It empties the RANK-TWO Weyl branch at $\dim V=6$"* is supported: it names the dimension, which is what [L180](../findings/diagonal-half.md)'s rank-two note insists on and what [r807](REVIEW_r807.md) found missing on the neighbouring row. The rigidity form, the orthogonality-spent-once clause and the $\dim V\ge8$ survivor all match the block. **CONFIRMED on the mathematics.** The Lean column repeats §3.2 and §3.3's error, crediting `pair_coincidences_at_dim4` as *"the $\dim V=4$ falsifier"* when that declaration falsifies nothing on its own and the layer holds better pieces.

### 4.3 The `Lean: blocked` reason is not the true blocker

The trailer reads *"the three cases run on the six dimensional Hodge star identity for J wedge J"*. The block itself says otherwise, in the proof paragraph the same file carries: case 1 runs on $u_ju_k=1$ in the spectrum of $A=-\omega_1^2$ and touches no star, **case 2** runs on $\star_V(J\wedge J)=2\epsilon_JJ$, and **case 3** runs on the cross term in $\Lambda^2Q\otimes\Lambda^2P$. [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean)'s own docstring gets this right, saying *"cases 2 and 3"*, and even that overstates by one. [r808](REVIEW_r808.md) records case 1's argument as dimension-free. **So case 1 is typeable today with no unproved `Prop` in its path**, and the blocker as recorded is broader than the obstruction. [findings/INDEX-results.md](../findings/INDEX-results.md)'s new row repeats the trailer's version, *"the three cases run on"*, rather than the file's.

### 4.4 The L144 promotion is refuted by the block it was taken from

The record's convention, stated twice in [findings/INDEX-results.md](../findings/INDEX-results.md): *"Labels are literal. **Lemma** is proven, Gate 1 and Gate 2 passed. **Observation** is verified numerically at the dimensions stated."* The commit changed the heading at [diagonal-half.md:538](../findings/diagonal-half.md) from `Observation L144` to `Lemma L144` on the strength of the Gate 2 note at line 542, *"THE PRIMITIVE HALF IS NOW PROVED, SO THIS IS A LEMMA"*. Four things stand against it, three of them in files the commit had open:

1. **Line 562 of the same block still reads *"THE PRIMITIVE HALF, SCREENED AND NOT PROVED … screened to $n\le200$, maximum $0.4758$ … This is a census over a finite range, so it is evidence rather than a theorem, and a uniform bound over all primitive parameter sets is owed."*** The block asserts both readings at once.
2. **Line 564, the block's own conclusion, still reads *"Granting the screened half"* and *"The discharge inherits the status of its weakest input, which is the screen."*** That is the sentence a citing result reads.
3. **[plan.md](../plan.md) contradicts the promotion in the line the commit edited.** The same diff rewrites I18(a) from `Observation L144` to `Lemma L144` and leaves the very next clause standing: *"Its primitive half is a screen to $n\le200$, not a theorem, so the discharge inherits that status."*
4. **The numbered table still labels it `Observation`.** [findings/INDEX-results.md:163](../findings/INDEX-results.md) opens `| **144** | Observation |`, and its cell says *"so this becomes a `Lemma`"* in the future tense. The commit changed the heading in the prose file and not the label in the table that owns labels, so **the record now labels L144 two ways in two files**, which is a state neither the old nor the new reading produces.

On the substance the addendum asks about: the promotion was taken from a note inside the block rather than from the block's argument. **The primitive half's proof is [r676](REVIEW_r676.md)'s own derivation**, produced at Gate 2 and, by the convention that a reviewer's contribution is unaudited until a round covers it, never independently checked. The imprimitive half fares better but is not clean either: line 548 records that *"maximised uniquely at $g=n/2$"* needs **$n$ even** and holds only **up to complementation**, and the repair is a second argument, that every $g\le n/3$ gives $\theta^2<1$, plus *"the uniform bound one reviewer supplies"*. Both halves therefore rest on reviewer-supplied arguments that the block records and no round has re-derived. **A type change on a numbered result is a claim, and this one is a claim about two arguments neither of which has had a Gate 2 of its own.** REFUTED as made. The mathematics may well support the label. The block as it stands does not, and the repair should have been the block and the row together or neither.

## 5. What would falsify each target, and what I did to look

| Target | The falsifier I looked for | What I did |
|---|---|---|
| **A** | A `finrank`, `Basis` or `span` declaration making $\dim\Lambda^2_+=3$ a typed statement, which would defeat §1.3 | Grepped the whole layer for all three. Two prose hits, no declaration. Also grepped `lean/` for `IsAntiSelfDual`: one hit, the definition |
| **A** | `IsSkew` being an unnecessary hypothesis, which would make the prose right and the theorem over-hypothesised | Evaluated $\star\star$ at $X=\mathrm{Id}_4$: it returns $0$, so the hypothesis is load-bearing. The attack fails and the prose is accurate |
| **A** | The star being mis-normalised, which `star4_star4` would then be proving of the wrong operator | Recomputed $\varepsilon_{2301}=+1$ by the file's own `sgnR` product and checked $(\star X)_{23}=X_{01}$ against `sdForm_selfDual`. Consistent, and `normSq star4 = 6` pins the constant independently |
| **B** | A theorem in a module the index marks `proved` that rests on a `sorry` in a `partial` one | Established this cannot hide behind the grouping, since the audit is transitive. Then attacked through the coverage hole instead: located every real `sorry` in the layer, cross-referenced the 25 unaudited theorems against those files, and found the headline survives. Reported as `PLAUSIBLE` on that basis |
| **B** | The extractor being sound after all, which would make §2.2 wrong | Re-ran `declarations()` and `sources()` statically over the tree, counted truncations and collisions, and read the two doc-comment false positives in situ at [L128Statement.lean:173](../lean/HamiltonsCubic/Results/L128Statement.lean) and [L73Statement.lean:25](../lean/HamiltonsCubic/Results/L73Statement.lean). Screened `--only SelfDual` and matched its 59 against the file's 59 theorem lines to exhibit the substitution |
| **C** | A typed statement in the layer that does establish the inhabitation, which would make the docstring right | Found `unitSD_coincidences` and `inner2_unitSD`, which together carry the orthonormal pair. They are not the declaration either index credits, and neither supplies $\omega_2\ne\pm\omega_1$. So the docstring is closer to true than its cited declaration, and still not typed |
| **C** | A Ricci or Bianchi declaration anywhere in [L191Statement.lean](../lean/HamiltonsCubic/Results/L191Statement.lean) or its imports that would make *"Weyl configuration"* typed | Read the file whole and grepped its import chain's headline names. Nothing types Weyl-ness of the pair |
| **D** | An id collision or an off-by-one in the footer | Derived the id set from the rows with the file's own recipe. 191 rows, 0 through 191, gap at 60 only, no duplicates. Exact |
| **D** | The L144 block supporting `Lemma` at both halves after all | Read the block whole rather than the note. Found the superseded reading surviving at lines 562 and 564, the table label at line 163 unchanged, and [plan.md](../plan.md) contradicting the promotion in a line the same commit edited |
| **D** | The star identity genuinely blocking all three cases, which would make the trailer right | Read the block's proof paragraph: case 1 uses $u_ju_k=1$ and case 3 the cross term. Only case 2 uses the identity, and the Lean file's own docstring already says two rather than three |

## 6. What I would change

Not a request for a run, and not for me to make: this is a review.

1. **Split the $\dim\Lambda^2_+=3$ claim in [lean/INDEX.md](../lean/INDEX.md)** into the typed half, spanning, and the untyped remainder, independence and the $\Lambda^2_-$ side. Update the two stale spans in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) at lines 62 to 70 and 424 to 426 in the same edit.
2. **Widen `DECL`'s name class to admit the dot** and make `main` refuse to report when `len(found) < len(decls)`, naming the difference. Until it does, no count it prints is a count of the layer.
3. **Credit `unitSD_coincidences` and `inner2_unitSD` in both L191 rows**, and say plainly that $\omega_2\ne\pm\omega_1$ is untyped, so the falsifier is assembled by hand from typed parts.
4. **Take L144 back to `Observation`, or finish the promotion**: the block's lines 562 and 564, the table label at line 163 and [plan.md](../plan.md)'s I18(a) clause must all say one thing.
