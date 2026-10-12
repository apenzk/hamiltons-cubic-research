"""Reviewer 199: build sabotaged variants of run_n5_assemble.py by TEXTUAL patch.

Nothing under review is edited: base_assemble.py in sandbox/ is a byte copy of
scripts/runs/run_n5_assemble.py and every variant is written beside it.
Each mode names the assert it attacks and the defect it plants.
"""
import sys, os, subprocess
d = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sandbox")
SRC = open(os.path.join(d, "base_assemble.py")).read()

# --- speed: the QWIDTH blocks feed stage 4 only, never the cross sweep ---
FAST = ("        blocks[w] = [[ip3(c0[a], c0[b]) for b in ts] for a in ts]",
        "        blocks[w] = None   # r199 fast: feeds QWIDTH only, not the sweep")
# --- stop after the cross assert, for the cross experiments ---
STOP_CROSS = ('assert cross == 0, "Q is not block-diagonal by weight"',
              'assert cross == 0, "Q is not block-diagonal by weight"\n'
              'print("R199 CROSS ASSERT PASSED"); sys.exit(0)')
# --- skip the cross sweep, for the h / homogeneity experiments ---
SKIP_CROSS = ("    if cross: break", "    break   # r199: sweep skipped")

PLANT = '''
# ---- r199 plant: force ONE cross-weight Q entry nonzero, by identity ----
import os as _os199
_LAM199 = eval(_os199.environ["R199_LAM"]); _A199 = int(_os199.environ["R199_A"])
_B199 = int(_os199.environ["R199_B"])
_c0199 = ADAPTED[_LAM199][0]
_u199, _v199 = _c0199[_A199], _c0199[_B199]
_ip3_true = ip3
def ip3(u, v):
    if (u is _u199 and v is _v199) or (u is _v199 and v is _u199):
        return 1              # a genuine block-diagonality violation
    return _ip3_true(u, v)
print(f"R199 planted a cross-weight nonzero at lambda={_LAM199} ({_A199},{_B199})",
      flush=True)
'''

MODES = {
  # cross assert, single planted entry -- location supplied by the environment
  "cross_plant": [FAST, STOP_CROSS,
                  ("# ---- the cross-weight falsifier, which the Q loop lacked ----",
                   PLANT + "# ---- the cross-weight falsifier ----")],
  # cross assert, realistic data corruption: one vector gains a foreign weight
  "cross_data": [FAST, STOP_CROSS,
      ("# ---- the cross-weight falsifier, which the Q loop lacked ----", '''
# ---- r199: one adapted vector in copy 0 gains a monomial of another weight ----
import os as _os199
_LAM199 = eval(_os199.environ["R199_LAM"]); _T199 = int(_os199.environ["R199_T"])
_c0199 = ADAPTED[_LAM199][0]
_w199 = mwt(max(_c0199[_T199]))
_pool = {kk for vv in _c0199 if vv for kk in vv}
_alien = next(k for k in sorted(_pool) if mwt(k) != _w199 and k < max(_c0199[_T199]))
_c0199[_T199][_alien] = G(F(1), F(0))
print(f"R199 corrupted lambda={_LAM199} position {_T199}: added monomial "
      f"{_alien} of weight {mwt(_alien)} to a vector of weight {_w199}", flush=True)
# ---- the cross-weight falsifier ----''')],
  # h multi-probe assert: swap two same-weight vectors inside ONE copy
  "h_swap": [FAST, SKIP_CROSS,
      ("# ---- h from several probes, since (0,0) cannot see the word list ----", '''
# ---- r199: transpose two same-weight positions inside copy 1 of one block ----
import os as _os199
_LAM199 = eval(_os199.environ["R199_LAM"])
_cs199 = ADAPTED[_LAM199]
_seen = {}
_pair = None
for _t, _v in enumerate(_cs199[1]):
    if not _v: continue
    _w = mwt(max(_v))
    if _w in _seen: _pair = (_seen[_w], _t); break
    _seen[_w] = _t
_i, _j = _pair
_cs199[1][_i], _cs199[1][_j] = _cs199[1][_j], _cs199[1][_i]
print(f"R199 transposed same-weight positions {_i},{_j} in copy 1 of {_LAM199}",
      flush=True)
# ---- h from several probes ----''')],
  # homogeneity assert
  "inhom": [FAST, SKIP_CROSS,
      ("# ---- homogeneity, tested nowhere in the pipeline ----", '''
# ---- r199: one vector carries two weights ----
import os as _os199
_LAM199 = eval(_os199.environ["R199_LAM"]); _T199 = int(_os199.environ["R199_T"])
_v199 = ADAPTED[_LAM199][0][_T199]
_w199 = mwt(max(_v199))
_alien = next(k for k in range(len(MONO)) if mwt(k) != _w199)
_v199[_alien] = G(F(1), F(0))
print(f"R199 made lambda={_LAM199} position {_T199} inhomogeneous", flush=True)
# ---- homogeneity ----''')],
  # the "every weight block is square" check -- drop one adapted vector
  "square": [FAST,
      ("COLS = {}", '''
# ---- r199: delete one adapted vector from a weight class ----
_wdel = max(BYW, key=lambda w: len(BYW[w]))
_lam, _i, _t, _v = BYW[_wdel][0]
BYW[_wdel] = BYW[_wdel][1:]
print(f"R199 removed one adapted vector of weight {_wdel}: the class now has "
      f"{len(BYW[_wdel])} vectors against {len([1 for k in range(len(MONO)) if mwt(k)==_wdel])} monomials",
      flush=True)
COLS = {}'''),
      ('print(f"  every weight block is square: {square}   <- it must be, the adapted")',
       'print(f"  every weight block is square: {square}   <- it must be, the adapted")\n'
       'print("R199 REACHED THE LINE AFTER THE SQUARE CHECK", flush=True); sys.exit(0)')],
}

mode = sys.argv[1]
txt = SRC
for old, new in MODES[mode]:
    assert txt.count(old) == 1, f"anchor not unique in {mode}: {old!r}"
    txt = txt.replace(old, new)
p = os.path.join(d, f"var_{mode}.py")
open(p, "w").write(txt)
print(f"wrote {p}")
