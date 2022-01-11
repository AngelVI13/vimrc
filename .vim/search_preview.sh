# (IFS=:;set -- $1;head -$LINES $1)
# Split input search result by `:` i.e. input = "run_tests.py:12: search result line"
# Display 10 lines above the match and 10 lines below the match
s_range=10
d_range=$((s_range*2))
(IFS=:;set -- $1;end_line=$(($s_range+$2));head -$end_line $1 | tail -$d_range)

