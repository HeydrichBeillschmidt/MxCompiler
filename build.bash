set ff=UNIX
set -e
mkdir -p bin
find ./src -name *.java | javac -d bin -classpath "lib/antlr-4.9.1-complete.jar" @/dev/stdin
