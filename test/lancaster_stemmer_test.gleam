import gleeunit
import lancaster_stemmer
import simplifile
import splitter

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  let line_split = splitter.new(["\n", "\r\n"])
  let row_split = splitter.new([" ", "\t"])
  let rules = lancaster_stemmer.default_rules()
  let assert Ok(tests) = simplifile.read("./test/wordlist.txt")
  run_test(tests, line_split, row_split, rules)
}

fn run_test(
  tests: String,
  line_split: splitter.Splitter,
  row_split: splitter.Splitter,
  rules: lancaster_stemmer.Rules,
) -> Nil {
  case splitter.split(line_split, tests) {
    #("", "", "") -> Nil
    #(line, _, rest) -> {
      case splitter.split(row_split, line) |> echo {
        #("", "", "") -> Nil
        #(word, _, stem) -> {
          assert lancaster_stemmer.stem(word, rules) == stem
        }
      }
      run_test(rest, line_split, row_split, rules)
    }
  }
}
