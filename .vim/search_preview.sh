# (IFS=:;set -- $1;head -$LINES $1)
# Split input search result by `:` i.e. input = "run_tests.py:12: search result line"
# Display 13 lines above the match and 10 lines below the match. Currently showing everything after the match
s_range=13  # number of lines above the result which should be shown
d_range=$((s_range*2))
# Here $1 and $2 are the `:` separater inputs i.e. filename and line number
(IFS=:;set -- $1;start_line=$(($2-$s_range));bat --style=numbers --color=always --highlight-line $2 --line-range $(($start_line>0? $start_line: 0)): $1)

