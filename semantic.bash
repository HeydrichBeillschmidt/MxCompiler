set ff=UNIX
set -e
cd "$(dirname "$0")"
export CCHK="java -classpath ./lib/antlr-4.9.1-complete.jar:./bin Mx.Main"
cat > test.mx   # save everything in stdin to test.Mx
$CCHK
