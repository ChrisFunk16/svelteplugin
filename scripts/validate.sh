#!/bin/bash
# Validate UDL XML files using Python (works everywhere Python3 exists)
set -e

cd "$(dirname "$0")/.."

echo "🔍 Validating UDL XML files..."
echo ""

python3 - <<'PY'
import xml.etree.ElementTree as ET
import sys, glob

errors = 0
for f in sorted(glob.glob('udl/*.xml') + glob.glob('autocomplete/*.xml')):
    try:
        ET.parse(f)
        print(f'✅ {f}')
    except Exception as e:
        print(f'❌ {f}: {e}')
        errors += 1

print()
if errors == 0:
    print('🎉 All XML files valid!')
else:
    print(f'💥 {errors} file(s) have errors')
sys.exit(errors)
PY
