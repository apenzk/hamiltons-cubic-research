"""r211, claim 2: does the column order of the dumped rows match the block list?

run_n5_assemble.py's herm_row walks the blocks in the order
    sorted(ADAPTED, key=lambda l: (-len(ADAPTED[l]), l))
while the dump records
    blocks/shape = [... for l in sorted(TR) if TR[l]]
which is plain lexicographic.  run_n5_lift.py partitions the 47 columns using the
dumped SHAPE.  If the two orders differ the PSD constraint is imposed on a
different block decomposition than the one the columns carry.
"""
import importlib.util, sys, os, json
RD = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs"))
sp = importlib.util.spec_from_file_location("ad", os.path.join(RD, "run_n5_adapted.py"))
ad = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(ad); sys.stdout = _o
ADAPTED = ad.ADAPTED
mult = {l: len(ADAPTED[l]) for l in ADAPTED}
print(f"{len(ADAPTED)} blocks, multiplicities:")
for l in sorted(ADAPTED): print(f"   {l}: m = {mult[l]}")

dj = json.load(open(os.path.join(RD, "n5_rows_1099511627873.json")))
blocks_dump = [tuple(b) for b in dj["blocks"]]
shape_dump = dj["shape"]
size = dict(zip(blocks_dump, shape_dump))

order_row = [l for l in sorted(ADAPTED, key=lambda l: (-mult[l], l)) if l in size]
order_dump = blocks_dump

print("\nherm_row column order:", order_row)
print("shape in that order   :", [size[l] for l in order_row])
print("\ndump block order      :", order_dump)
print("dump shape            :", shape_dump)
print("\nORDERS AGREE:", order_row == list(order_dump))
print("SHAPES AGREE:", [size[l] for l in order_row] == list(shape_dump))
