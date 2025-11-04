import gleam/list
import glychee/benchmark
import glychee/configuration
import lancaster_stemmer
import porter_stemmer

@target(erlang)
pub fn main() {
  configuration.initialize()
  configuration.set_pair(configuration.Warmup, 2)
  configuration.set_pair(configuration.Parallel, 2)

  // pop_benchmark()
  benchmark()
  // reg_name_benchmark()
  // ip_benchmark()
}

@target(erlang)
fn benchmark() {
  let rules = lancaster_stemmer.default_rules()
  benchmark.run(
    [
      benchmark.Function("Lancaster", fn(data) {
        fn() { list.each(data, lancaster_stemmer.stem(_, rules)) }
      }),
      benchmark.Function("Porter", fn(data) {
        fn() { list.each(data, porter_stemmer.stem) }
      }),
    ],
    [
      benchmark.Data("10 words", [
        "abbreviate",
        "aberdeen",
        "abode",
        "abovementioned",
        "blemish",
        "christensen",
        "christendom",
        "flatiron",
        "mountainside",
        "zygote",
      ]),
    ],
  )
}
