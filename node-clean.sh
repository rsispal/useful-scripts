echo "DELETING NODE MODULES..."
find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +     
echo "DELETING PACKAGE LOCK FILES..."
find . -name 'package-lock.json' -type f -prune -exec rm -rf '{}' +
echo "DELETING YARN LOCK FILES..."
find . -name 'yarn.lock' -type f -prune -exec rm -rf '{}' +
echo "DELETING LOG FILES..."
find . -name 'yarn-*.log' -type f -prune -exec rm -rf '{}' +
echo "Complete!"