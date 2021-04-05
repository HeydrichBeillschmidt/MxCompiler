set ff=UNIX
set -e
cd "$(dirname "$0")"
mkdir -p bin
cp ./builtin/builtin.s .
find ./src -name *.java | javac -d bin -classpath "lib/antlr-4.9.1-complete.jar" @/dev/stdin
