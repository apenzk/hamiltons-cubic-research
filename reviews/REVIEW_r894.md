# REVIEW r894 on the repaired commit gate: the 196 were correct as a class, the count and the breakdown are both wrong, and three of the four guards over-reach

**This round compared a hook against the behaviour asserted of it.** There is no argument here, only a claim about what code does, and it is settled by running it. I read [mechanical_check.py](../.claude/hooks/mechanical_check.py) whole, wrote my own transcription of the pre-`6aacee94` rule rather than reuse the parent's script, reconstructed the exact added-line set the gate saw from `git diff 6aacee94^ 6aacee94 -U0`, and fed 33 crafted rows to the real [check_named_decls](../.claude/hooks/mechanical_check.py#L158) and 9 crafted files to the real [check_anchors](../.claude/hooks/mechanical_check.py#L61). **No file in the repository was modified**: both functions take their inputs as arguments, so crafted rows were passed in directly and [lean/INDEX.md](../lean/INDEX.md) was never touched. Every run was seconds of arithmetic on objects in hand, and **no numerical line of work was opened**. Log: [agent_logs/review-r894-gate.log](../agent_logs/review-r894-gate.log).

## Claim table

| # | Claim as recorded | Verdict |
|---|---|---|
| 1 | "It fired on 196 rows of lean/INDEX.md", the breakdown being "193 say `Kernel-checked, no native_decide`, two name another file's anchor, one says a gap was recorded rather than left as a `sorry`" | **WRONG ON BOTH NUMBERS.** My pass gives **199 findings over 190 distinct rows**, and the split is **147 negation-clause, 45 non-name English tokens, 4 cross-file, 2 layer-only, 1 missing file**. 196 is exactly what the shape, negation and cross-file guards remove ($147+45+4$), so the parent reported the silenced subtotal as the total and left its own fourth guard's 2 out of the account |
| 2 | "every one of them was right" | **UPHELD, and by an exhaustive check rather than a sample.** All 147 negation findings are the literal adjacent string "no `native_decide`" with zero intervening text, all 39 `sorry` findings sit behind a negation, and I grepped **all 186** target files: not one carries the token it is said to lack. The 15-row spread sample and all 6 non-negation findings check out individually. **No suppressed real finding exists** |
| 3 | The repaired gate catches "a name that no longer exists" | **CATCHES A DELETION, MISSES A RENAME.** A name absent from the layer fires when it sits clear of the guards. A rename by added prefix or suffix passes silently, because the layer test is a substring test: `index_at_theta` passes on `no_index_at_theta`, `le_theta_record` on `pair_le_theta_record` |
| 4 | Four guards, each removing one class | **THREE OVER-REACH.** The **`.lean` guard is the worst**: it blinds an average of **48.5 characters of every row's prose**, because the row's own second-column link sits inside the 70-character window. The **shape guard** drops 189 of 528 tokens and ignores real declarations such as [levi6](../lean/HamiltonsCubic/Base/SelfDual.lean#L602). The **negation guard** disowns a token up to 70 characters after an unrelated "no", "not" or "zero". The **possessive guard** alone was not shown to over-reach, every test of it being decided by the `.lean` guard first |
| 5 | "a name present anywhere in lean/HamiltonsCubic/ has not been deleted or renamed" | **FALSE AS STATED.** The test is `name in _layer_text`, a bare substring test. `_record` passes on `pair_le_theta_record`, and `eq_re` on [harmMean_eq_recip](../lean/HamiltonsCubic/Base/SelfDual.lean). **Both of the 2 layer-only findings passed by accident**: no declaration is named `_record`. The other, `areaForm_mul_apply`, is a genuine pass |
| 6 | "mechanical_check.py now honours an explicit `<a id="...">` as a link target" | **CONFIRMED, AND TOO PERMISSIVE, THOUGH HARMLESS TODAY.** An id inside a fenced block, an HTML comment or an inline code span also counts, since the id harvest reads the raw file while only the link scan is code-stripped. The record carries 3 explicit anchors in 3 files, none quoted, so nothing is affected now |
| 7 | The deleted L20 row duplicated two rows whose files exist, and git never tracked `Results/L20.lean` | **BOTH HALVES CONFIRMED, ONE SURVIVOR MISNAMED, ONE FACT LOST.** Git has never tracked the path. The odd-witness half is carried verbatim and expanded by [OddWitness](../lean/HamiltonsCubic/Results/OddWitness.lean)'s row. The radius half is carried by **[TubeRadius](../lean/HamiltonsCubic/Results/TubeRadius.lean)'s row**, not by the L20Statement row the commit names. **Lost**: the remark that the route-a block prints $0.5748$ and never states the equation it solves |

**One-line summary.** The repair's substance stands, since no correct finding was suppressed and the current index has zero tokens that any guard hides from a real check, but the commit's own arithmetic is wrong (199 findings over 190 rows, not 196 rows) and the `.lean` guard should be narrowed to skip the row's own second-column link rather than any `.lean` within 70 characters, because as written it makes the check blind to roughly the first 48 characters of every row's prose.

## 1. The count, reproduced independently

I transcribed the old rule from `6aacee94^` into a script of my own and ran it over the exact added-line set of the commit, taken from `git diff 6aacee94^ 6aacee94 -U0 -- lean/INDEX.md`: 449 deduplicated added lines. The gate ran before the L20 row was deleted, so the state it read is that set plus the L20 row, which the final diff shows as a pure deletion. That is 450 rows.

| Measure | Parent's commit | My pass |
|---|---|---|
| Findings | 196 | **199** |
| Distinct rows flagged | "196 rows" | **190** |
| Negation-clause findings | 193 | **147** |
| Non-name English tokens (`sorry`, `iff`, `rfl`, `proved`, `det`, `out`, `levi6`) | not accounted for | **45** |
| Cross-file attributions | 2 | **4** |
| `rather than` findings | 1 | 1, but it is removed by the shape guard, not by the `rather than` clause |
| Layer-only passes | not accounted for | **2** |
| Missing-file findings | 1 | 1 |

**Where they differ, and why.** $147+45+2+2=196$ exactly. So the parent's 196 is the number of findings its first three guards silence, reported as the number the old rule produced. The two findings its own fourth guard silences are absent from the prose, and the one real finding brings the true total to 199. The "193 negations" figure is off by 46 because the 45 English tokens and the 4 cross-file cases were folded into it.

**Names flagged**: `native_decide` 149, `sorry` 39, then one each of `_record`, `srgWeight`, `srg_theta_closed_form`, `iff`, `areaForm_mul_apply`, `levi6`, `rfl`, `proved`, `det`, `out`, plus the missing file. The "193 say `Kernel-checked, no native_decide`" claim cannot be right when only 149 findings name that token at all.

## 2. Were all 196 really correct? Yes, and the argument is exhaustive rather than sampled

**The negation class is correct by construction, and I verified it anyway.** The old rule fires exactly when the token is absent from the row's own file. The clause asserts absence. So agreement is forced. The failure mode that would break the argument is a negation attached to a different noun, so I printed the negation word, the intervening text and the token for all 147:

```
  147  neg='no'  between=''  token=native_decide
```

**One pattern, zero intervening characters, every time.** Not one of the 147 is a loose negation.

I then grepped all 147 target files for `native_decide` and all 39 `sorry` files for `\bsorry\b`: **rows whose negative assertion is FALSE: 0**.

**The 15-row spread sample**, taken at even intervals through the document rather than consecutively, at [lean/INDEX.md](../lean/INDEX.md) lines 71, 182, 235, 253, 272, 292, 313, 331, 350, 369, 384, 405, 424, 438 and 452. Every one: token absent from the file as a word, `native_decide` count 0, `sorry` count 0. Each row is right and the old rule was wrong on each.

**The three the commit singles out as not-negations, read individually.**

- **[L116Statement](../lean/HamiltonsCubic/Results/L116Statement.lean)'s row**, "the sign and factor are NOT checked against [Sharp.lean](../lean/HamiltonsCubic/Base/Sharp.lean)'s `native_decide` anchor". The anchor is Sharp.lean's. **Correct row.**
- **[L15Statement](../lean/HamiltonsCubic/Results/L15Statement.lean)'s row**, "agrees with the $\mathbb Q$ layer's `native_decide` anchors at $n=4,5,6$". Another layer's anchors. **Correct row.**
- **The `rather than` row**, "Recorded rather than left as a `sorry` under a load-bearing name". **Correct row**, and worth noting that it is the shape guard that removes it, since `sorry` has no underscore and no internal capital. The `rather than`, `instead of` and `in place of` alternatives in the negation regex do no work on this data at all.

**Two more cross-file cases the commit's breakdown omits**, both on [L144Statement](../lean/HamiltonsCubic/Results/L144Statement.lean)'s row: `srg_theta_closed_form` and `srgWeight`, each explicitly attributed to L74. Both correct rows, so the class is 4 and not 2.

**The two layer-only findings.** `areaForm_mul_apply` on [L181Statement](../lean/HamiltonsCubic/Results/L181Statement.lean)'s row is a real theorem at [SelfDual.lean:275](../lean/HamiltonsCubic/Base/SelfDual.lean#L275), and L181Statement uses its consequences `areaForm_mul_transpose_of_orthonormal` and `areaForm_mul_eq_zero`, so the row is right. `_record` on [L130Statement](../lean/HamiltonsCubic/Results/L130Statement.lean)'s row names a **suffix** and says so in words, so that row is right too, but see section 5 for how it passes.

**Verdict on the central question: no row among them genuinely names a deleted declaration.** The headline that the findings were false positives holds. What fails is the count and the classification, not the correctness call.

## 3. Does the new rule still catch what it exists to catch?

**A name absent from the layer fires, provided it is clear of the guards.** The row

```
| Ltest | [HamiltonsCubic/Results/L90.lean](HamiltonsCubic/Results/L90.lean) | **proved** | the argument proceeds through the stated reduction and the bookkeeping step that follows it, and then reaches the point where the row asserts that `zzz_qqq_absent` closes it |
```

gives

```
lean/INDEX.md: row names `zzz_qqq_absent`, which HamiltonsCubic/Results/L90.lean does not carry
```

**The same row with the token near the front is silent**, which is section 4's finding, not this one's.

**A rename is caught only when the new name shares no substring with the old.** `srg_theta_gone_form` fires. But the realistic rename, where a qualifier is added to an existing name, passes:

| Crafted row's token | Layer carries | Gate |
|---|---|---|
| `zzz_qqq_absent` | nothing | **FIRES** |
| `srg_theta_gone_form` | `srg_theta_closed_form` | **FIRES** |
| `index_at_theta` | `no_index_at_theta` at [L130Statement.lean:542](../lean/HamiltonsCubic/Results/L130Statement.lean#L542) | **SILENT** |
| `le_theta_record` | `pair_le_theta_record` at [L130Statement.lean:512](../lean/HamiltonsCubic/Results/L130Statement.lean#L512) | **SILENT** |
| `harm_mean` | `harmMean_eq_recip` only, no underscore form | **FIRES** |

**What the gate now misses, plainly.** A declaration renamed by adding a prefix or a suffix, since the old name survives as a substring of the new one. A declaration renamed to anything, if the row's mention sits within 70 characters of any `.lean` string. A declaration whose name has no underscore and no internal capital, deleted or not. A name that happens to be a substring of any identifier, comment or docstring anywhere in the layer.

## 4. The four guards, one at a time

Each crafted row was fed to the real function, and the deciding guard was read off by replaying the same branches in order.

### 4.1 The negation guard: it looks back 70 characters and does not check what is negated

`before = line[max(0, m2.start() - 70):m2.start()].lower()`, and the regex is `\b(no|not|…)\b[^.]*$`. So **any** listed word inside that window, with no full stop between it and the token, disowns the token.

| Crafted row's prose | Gate | Should be |
|---|---|---|
| "Kernel-checked, no `zzz_qqq_absent`" | SILENT | silent, the intended case |
| "there is no rounding anywhere in the computed table, and the key step is `zzz_qqq_absent`" | **SILENT** | should fire, the negation is about rounding |
| "no closed form is asserted, and it rests on `zzz_qqq_absent`" | **SILENT** | should fire |
| "the defect is zero at every index, by `zzz_qqq_absent`" | **SILENT** | should fire, "zero" is a value here |
| "the bound is not sharp, and is proved by `zzz_qqq_absent`" | **SILENT** | should fire |
| the same, padded past 70 characters | FIRES | correct, the window bounds the damage |

**Answers to the brief's two questions.** It looks back exactly 70 characters, and **yes, a negation early in a long row disowns a token much later in it**, up to that bound and only while no full stop intervenes. The bound is what keeps this from gutting whole rows, and no current row exploits it: all 147 are adjacent.

### 4.2 The possessive guard: not shown to over-reach

`(?:'s|s')\s*$` requires the possessive to sit immediately before the token, so it cannot reach across prose. Both crafted over-reach rows, "the lemma's `zzz_qqq_absent`" and "the reviewers' `zzz_qqq_absent`", are silent, but **both are decided by the `.lean` guard first**, which runs ahead of the possessive test and matched the row's own link. So the possessive guard is **not exonerated, it is untested by these inputs**, and on the real file it accounts for 7 of 528 tokens. It does read `'s` after a plain English noun as a cross-file attribution, which is wrong in principle: "the lemma's `foo_bar`" attributes nothing elsewhere.

### 4.3 The `.lean` guard: the guard that is far too wide

**Tested hardest, as the brief instructs, and it is the finding of this round.** The test is `if ".lean" in before`, over the same 70-character window. An index row's shape is

```
| id | [X.lean](HamiltonsCubic/…/X.lean) | **status** | prose …
```

so the closing `.lean)` of the row's own second-column link sits roughly 20 characters before the prose begins. **The row's own target therefore disowns the opening of its own prose.**

| Crafted row's prose | Gate | Window the guard read |
|---|---|---|
| "the file proves `zzz_qqq_absent` and nothing else" | **SILENT** | `lean](hamiltonscubic/results/l90.lean) \| **proved** \| the file proves ` |
| "by `zzz_qqq_absent`" | **SILENT** | the row's own link |
| "see Sharp.lean and then `zzz_qqq_absent`" | **SILENT** | the row's own link, and a bare `.lean` with no link suffices |
| "the step imported from [Sharp.lean](…) is then `zzz_qqq_absent`" | **SILENT** | the mid-row link |
| the same, padded past 70 characters | FIRES | the window bounds it |

**Measured on the real file.** Over all 432 rows of [lean/INDEX.md](../lean/INDEX.md) matching the row regex, the mean number of prose characters falling inside the leading link's window is **48.5**. So the check is structurally blind to roughly **the first 48 characters of every row's prose cell**, and to 70 characters after every mid-row `.lean` link.

**Does the first link gut the check for the whole row?** No, and only because the window is 70 characters. It guts the first clause of every row, which is where an index row states what the file proves. That is the very clause the check exists to police.

**The repair.** Compare against the row's own captured target rather than the literal string `.lean`: strip the second column before computing `before`, and require the `.lean` to belong to a link whose path differs from `m.group(1)`.

### 4.4 The name-shape guard: it ignores real declarations

`if "_" not in name and name == name.lower(): continue`.

| Crafted row's token | Exists? | Gate |
|---|---|---|
| `levi6` | **yes**, `def levi6` at [SelfDual.lean:602](../lean/HamiltonsCubic/Base/SelfDual.lean#L602) | **SILENT** |
| `levi7` | no | **SILENT** |
| `qqqzzz` | no | **SILENT** |

**Answer to the brief: yes, a real Lean declaration of that shape is now ignored entirely.** [levi6](../lean/HamiltonsCubic/Base/SelfDual.lean#L602) is a live definition, [L192Statement](../lean/HamiltonsCubic/Results/L192Statement.lean)'s row names it, and the gate classifies it as English. Were it deleted, no row naming it would be flagged. On the real file the guard drops **189 of 528 tokens**, 36 per cent, more than any other guard.

### 4.5 What actually survives to be checked

| Disposition of the 528 lowercase backticked tokens in the 432 rows | Count |
|---|---|
| Swallowed by the name-shape guard | 189 |
| Swallowed by the negation guard | 170 |
| Swallowed by the `.lean` guard | 8 |
| Swallowed by the possessive guard | 7 |
| **Actually compared against the row's own file, and found** | **152** |
| Found only as a layer substring | 2 |

**Fewer than three tokens in ten reach the check the function is named for.**

## 5. The layer-wide fallback is a substring test

`if name in _layer_text(cwd)` has no word boundary, so any identifier, comment or docstring containing the name as a substring vouches for it.

**Concrete examples, all verified against the layer.**

| Token | Matched inside | Is it a declaration? |
|---|---|---|
| `_record` | `pair_le_theta_record`, `theta_sub_pair_record`, `in_recorded_range` | **no** |
| `eq_re` | `harmMean_eq_recip`, `gapN_eq_record_form` | **no** |
| `index_at_theta` | `no_index_at_theta` | **no** |
| `le_theta_record` | `pair_le_theta_record` | **no** |

**Did any of the 196 pass for that reason?** The layer guard silences exactly 2 findings, and **one of the two passed by accident**: `_record` on [L130Statement](../lean/HamiltonsCubic/Results/L130Statement.lean)'s row. I grepped the layer for every `_record`-containing identifier and no declaration bears that name. The row is nevertheless correct, since it says "the record's reading carries the `_record` suffix" and is describing a suffix, so the outcome is right and the reason is wrong. `areaForm_mul_apply` passes legitimately, as section 2 records.

**The narrowing.** Require a word boundary, `re.search(r"\b" + re.escape(name) + r"\b", _layer_text(cwd))`. That keeps `areaForm_mul_apply` passing and stops `_record`, `eq_re`, `index_at_theta` and `le_theta_record`.

## 6. check_anchors and the explicit-anchor change

**The change does what the commit says.** `heads |= set(re.findall(r'<a\s+id="([^"]+)"', text))`.

| Crafted file | Link | Gate |
|---|---|---|
| heading only | to its slug | SILENT, correct |
| heading only | to an unknown id | **FIRES**, correct |
| `## L74 <a id="l74"></a>` | `](#l74)` | SILENT, the new behaviour confirmed |
| `<a id="deep-target">` mid-prose, no heading near it | `](#deep-target)` | SILENT |
| id inside a **fenced code block** | `](#only-in-a-fence)` | **SILENT** |
| id inside an **HTML comment** | `](#only-in-a-comment)` | **SILENT** |
| id inside an **inline code span** | `](#only-inline)` | **SILENT** |

**It is too permissive, and the cause is an asymmetry.** [_strip_code](../.claude/hooks/mechanical_check.py#L55) is applied to the added lines being scanned for links, and not to the `text` the ids are harvested from. So a quoted id is a target while a quoted link is not.

**Does it matter here?** Not today. The record carries 3 explicit anchors across 3 files, [REVIEW_r426.md](REVIEW_r426.md), [REVIEW_r704.md](REVIEW_r704.md) and [REVIEW_r620.md](REVIEW_r620.md), all in live prose and none quoted. The one-line fix is to harvest ids from `_strip_code(text)`.

**Two further observations from the same tests.**

- **A case asymmetry.** Ids are harvested verbatim while the link regex is `\]\(#([a-z0-9\-]+)\)`. An id carrying a capital or an underscore can never be matched as a link at all, and a lowercase link to a MixedCase id is reported dangling. All 3 anchors in the record are lowercase-hyphen, so this is latent.
- **Set deduplication can break a code fence.** `added` is a set, so when a fence's opening and closing ```` ``` ```` lines are identical only one survives, `_strip_code` finds no pair, and a link quoted inside a fence in the added lines is reported. My test case 6i fires for exactly this reason. Minor, and it errs towards reporting rather than hiding.

## 7. The L20 row deletion

**Half one: git has never tracked the path.** `git log --all --follow -- lean/HamiltonsCubic/Results/L20.lean` is empty, and `git log --all --diff-filter=A` over every L20-prefixed Lean path yields `L20Statement.lean`, `L201Statement.lean` through `L207SphereExcess.lean`, and no `L20.lean`. **Confirmed.**

**Half two: the survivors carry it, but one is misnamed.** The commit names "the L20Statement and OddWitness rows". The radius half is in fact carried by the **[TubeRadius](../lean/HamiltonsCubic/Results/TubeRadius.lean) row**, which states more than the deleted row did.

| The deleted row asserted | Carried now by |
|---|---|
| the chain closes at $\cos\varphi+\sin^3\varphi=1$ | TubeRadius row, verbatim as $\psi(\varphi)=1$ |
| $s^2(s^4-2s+1)=0$, with $s^4-2s+1=(s-1)(s^3+s^2+s-1)$ | TubeRadius row, plus the identification of $s=1$ as the spurious root squaring introduced |
| the radius is $\arcsin$ of the real root of $s^3+s^2+s=1$ | TubeRadius row, as $\arcsin s^*$ |
| bracketed by $0.5436$ and $0.5437$ | TubeRadius row, tighter at $(0.5436890, 0.5436891)$, and the L20Statement row gives $(0.54368, 0.54369)$ |
| unique there, the cubic strictly increasing | TubeRadius row, and it adds irrationality by the rational root theorem |
| the odd-$n$ witness exists under $\Theta_n$, $\Theta_n^2>3/2 \Leftrightarrow n^2-13n+18>0$, negative at 11, positive at 12 | OddWitness row, verbatim and extended to both parities |
| a different polynomial from $n^2-12n+8$, discriminants $97$ against $112$ | OddWitness row, verbatim, plus the two roots |
| Owed: the cubic expansion and $\alpha\le1/3$, which is L21 | OddWitness row, verbatim, and the TubeRadius row for the expansion |
| **"The block prints the number and never states the equation."** | **nothing.** Absent from [lean/INDEX.md](../lean/INDEX.md), from [findings/](../findings/) and from [results.md](../results.md) |

**The one fact lost.** The deleted row recorded a gap in the **record**: findings/route-a.md prints $0.5748$ without ever stating the equation that determines it. TubeRadius's row makes a neighbouring but different statement, that the number is "quoted fifteen times" and is "not a chosen constant". Neither asserts that the record never states the defining equation. That is a one-clause restoration, and the TubeRadius row is where it belongs.

**One incidental defect, pre-existing.** The TubeRadius row's Owed clause ends "both trigonometry and both the record's **statement: not typed**", a sentence broken off mid-phrase. I checked `6aacee94^`: it read the same apart from the em dash, so the sweep did not cause it. Someone should finish the sentence.

**One convention defect for the parent.** [REVIEW_r704.md](REVIEW_r704.md) line 20 still carries an em dash in a heading. Commit `1d5db5f1` left anchor-bearing headings alone to preserve their slugs, but **this heading has an explicit `<a id="finding-1">`**, so its slug is not load-bearing and the mark can go. I left it, the brief forbidding me any file but this report.

## 8. What would break the repair, and how I looked for it

**The input that would show the repair wrong** is a row of [lean/INDEX.md](../lean/INDEX.md) that positively names a declaration absent from the whole layer and that some guard now swallows. Two shapes are most likely: a name inside the 48-character blind zone at the head of a row's prose, and a name of the form `foo` that the shape guard reads as English.

**How I looked.** I enumerated **all 528** lowercase backticked name-shaped tokens across all 432 rows, took each one's name, and asked whether it is absent both from the row's own file and from the whole of [lean/HamiltonsCubic/](../lean/HamiltonsCubic/), recording which guard would swallow it.

```
tokens absent from the row file AND absent from the whole layer: 0
```

**None. The repair suppresses nothing real in the index as it stands today.** The three over-reaches of section 4 and the substring weakness of section 5 are therefore latent rather than live, and the cost of leaving them is a defect admitted later rather than one admitted now.

**What I could not test.** Whether the gate prompts or blocks in practice, since a reviewer sees only tool results and never the committer's screen. Everything above is the behaviour of [check_named_decls](../.claude/hooks/mechanical_check.py#L158) and [check_anchors](../.claude/hooks/mechanical_check.py#L61) called directly, which is the same code `main` calls.

## Verdict

**The repair's correctness call is upheld and its arithmetic is refuted.** No row among those the old rule flagged genuinely named a deleted declaration, and I established that exhaustively rather than by sample, so the commit's headline stands. The commit's own numbers do not: the old rule produced **199 findings over 190 rows**, and 196 is the subtotal its first three guards remove.

**Three repairs, in the order they matter.**

1. **Narrow the `.lean` guard** to the row's own captured target instead of the literal string, since as written it blinds the check to the first 48 characters of every row's prose, the clause that says what the file proves.
2. **Give the layer test a word boundary**, which stops `_record`, `eq_re` and every prefix or suffix rename while keeping `areaForm_mul_apply`.
3. **Replace the shape guard with a stop-list** of the English and status words it was written for, since as a rule about name shape it ignores [levi6](../lean/HamiltonsCubic/Base/SelfDual.lean#L602) and every declaration like it, 36 per cent of all tokens.

**And two one-line record repairs**: restore the deleted row's remark that the route-a block prints $0.5748$ without stating the equation, into the TubeRadius row, and harvest anchor ids from `_strip_code(text)` so a quoted id stops counting as a link target.
