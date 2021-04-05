#!python3

import os


test_cases_dir = '../testcases/codegen'
compile_cmd = "bash ../build.bash"
execute_cmd = "bash ../codegen.bash"
excluded_test_cases = []


color_red = "\033[0;31m"
color_green = "\033[0;32m"
color_none = "\033[0m"


def collect_test_cases():
    test_cases = []
    for f in os.listdir(test_cases_dir):
        if os.path.splitext(f)[1] == '.mx':
            test_cases.append(f)
    for s in excluded_test_cases:
        if s in test_cases: test_cases.remove(s)
    test_cases.sort()
    return test_cases


def parse_test_case(test_case_path):
    with open(test_case_path, 'r') as f:
        lines = f.read().split('\n')
    src_start_idx = lines.index('*/', lines.index('/*')) + 1
    src_text = '\n'.join(lines[src_start_idx:])

    input_start_idx = lines.index('=== input ===') + 1
    input_end_idx = lines.index('=== end ===', input_start_idx)
    input_text = '\n'.join(lines[input_start_idx:input_end_idx])

    output_start_idx = lines.index('=== output ===') + 1
    output_end_idx = lines.index('=== end ===', output_start_idx)
    output_text = '\n'.join(lines[output_start_idx:output_end_idx])

    for i, line in enumerate(lines):
        if line[0:10] == "ExitCode: ":
            exit_code = int(line[10:])
            break

    return src_text, input_text, output_text, exit_code


def main():
    if os.system(compile_cmd):
        print(color_red + "Fail when building your compiler...")
        return
    test_cases = collect_test_cases()
    n_accept = 0
    for t in test_cases:
        src_text, input_text, output_text, exit_code = \
            parse_test_case(os.path.join(test_cases_dir, t))
        with open('test.mx', 'w') as f:
            f.write(src_text)
        with open('test.in', 'w') as f:
            f.write(input_text)
        with open('test.ans', 'w') as f:
            f.write(output_text)

        print(t + ':', end=' ')
        if os.system('%s < ./test.mx > test.ll' % execute_cmd):
            print(color_red + "Compilation failed" + color_none)
            continue

        if os.system('clang test.ll ../lib/builtin_function.ll -o test'):
            print(color_red + "Clang compilation failed" + color_none)
            continue

        if (os.system('./test < test.in > test.out') >> 8) != exit_code:
            print(color_red + "Wrong exit code" + color_none)
            continue

        if os.system('diff -B -b test.out test.ans > diff.out'):
            print(color_red + "Wrong answer" + color_none)
            continue

        print(color_green + "Accepted" + color_none)
        n_accept += 1

    print("total passed: {}/{}".format(n_accept, len(test_cases)))


if __name__ == '__main__':
    main()
