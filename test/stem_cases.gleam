import gleeunit
import lancaster_stemmer

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn stem_abbas_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("abbas", rules) == "abba"
}

pub fn stem_abbas_case_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("AbBaS", rules) == "abba"
}

pub fn stem_accomplish_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("accomplish", rules) == "accompl"
}

pub fn stem_accomplish_upper_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("ACCOMPLISH", rules) == "accompl"
}

pub fn stem_accompaniment_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("accompaniment", rules) == "accompany"
}

pub fn stem_test_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("test", rules) == "test"
}

pub fn stem_tessellate_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("tessellate", rules) == "tessel"
}

pub fn stem_a_invalid_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("a", rules) == "a"
}

pub fn stem_i_invalid_test() {
  let rules = lancaster_stemmer.default_rules()
  assert lancaster_stemmer.stem("i", rules) == "i"
}
