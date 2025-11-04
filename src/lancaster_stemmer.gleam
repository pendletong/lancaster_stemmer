import gleam/bool
import gleam/dict
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/result
import gleam/string
import simplifile
import splitter

pub opaque type Rule {
  Rule(
    id: String,
    letter: String,
    suffix: String,
    intact: Bool,
    remove: Int,
    append: String,
    restem: Bool,
  )
}

pub type Rules =
  dict.Dict(String, List(Rule))

const default_rules_list = [
  #(
    "a",
    [
      Rule("(1:ai*2.)", "a", "ia", True, 2, "", False),
      Rule("(2:a*1.)", "a", "a", True, 1, "", False),
    ],
  ),
  #("b", [Rule("(3:bb1.)", "b", "bb", False, 1, "", False)]),
  #(
    "c",
    [
      Rule("(4:city3s.)", "c", "ytic", False, 3, "s", False),
      Rule("(5:ci2>)", "c", "ic", False, 2, "", True),
      Rule("(6:cn1t>)", "c", "nc", False, 1, "t", True),
    ],
  ),
  #(
    "d",
    [
      Rule("(7:dd1.)", "d", "dd", False, 1, "", False),
      Rule("(8:dei3y>)", "d", "ied", False, 3, "y", True),
      Rule("(9:deec2ss.)", "d", "ceed", False, 2, "ss", False),
      Rule("(10:dee1.)", "d", "eed", False, 1, "", False),
      Rule("(11:de2>)", "d", "ed", False, 2, "", True),
      Rule("(12:dooh4>)", "d", "hood", False, 4, "", True),
    ],
  ),
  #("e", [Rule("(13:e1>)", "e", "e", False, 1, "", True)]),
  #(
    "f",
    [
      Rule("(14:feil1v.)", "f", "lief", False, 1, "v", False),
      Rule("(15:fi2>)", "f", "if", False, 2, "", True),
    ],
  ),
  #(
    "g",
    [
      Rule("(16:gni3>)", "g", "ing", False, 3, "", True),
      Rule("(17:gai3y.)", "g", "iag", False, 3, "y", False),
      Rule("(18:ga2>)", "g", "ag", False, 2, "", True),
      Rule("(19:gg1.)", "g", "gg", False, 1, "", False),
    ],
  ),
  #(
    "h",
    [
      Rule("(20:ht*2.)", "h", "th", True, 2, "", False),
      Rule("(21:hsiug5ct.)", "h", "guish", False, 5, "ct", False),
      Rule("(22:hsi3>)", "h", "ish", False, 3, "", True),
    ],
  ),
  #(
    "i",
    [
      Rule("(23:i*1.)", "i", "i", True, 1, "", False),
      Rule("(24:i1y>)", "i", "i", False, 1, "y", True),
    ],
  ),
  #(
    "j",
    [
      Rule("(25:ji1d.)", "j", "ij", False, 1, "d", False),
      Rule("(26:juf1s.)", "j", "fuj", False, 1, "s", False),
      Rule("(27:ju1d.)", "j", "uj", False, 1, "d", False),
      Rule("(28:jo1d.)", "j", "oj", False, 1, "d", False),
      Rule("(29:jeh1r.)", "j", "hej", False, 1, "r", False),
      Rule("(30:jrev1t.)", "j", "verj", False, 1, "t", False),
      Rule("(31:jsim2t.)", "j", "misj", False, 2, "t", False),
      Rule("(32:jn1d.)", "j", "nj", False, 1, "d", False),
      Rule("(33:j1s.)", "j", "j", False, 1, "s", False),
    ],
  ),
  #(
    "l",
    [
      Rule("(34:lbaifi6.)", "l", "ifiabl", False, 6, "", False),
      Rule("(35:lbai4y.)", "l", "iabl", False, 4, "y", False),
      Rule("(36:lba3>)", "l", "abl", False, 3, "", True),
      Rule("(37:lbi3.)", "l", "ibl", False, 3, "", False),
      Rule("(38:lib2l>)", "l", "bil", False, 2, "l", True),
      Rule("(39:lc1.)", "l", "cl", False, 1, "", False),
      Rule("(40:lufi4y.)", "l", "iful", False, 4, "y", False),
      Rule("(41:luf3>)", "l", "ful", False, 3, "", True),
      Rule("(42:lu2.)", "l", "ul", False, 2, "", False),
      Rule("(43:lai3>)", "l", "ial", False, 3, "", True),
      Rule("(44:lau3>)", "l", "ual", False, 3, "", True),
      Rule("(45:la2>)", "l", "al", False, 2, "", True),
      Rule("(46:ll1.)", "l", "ll", False, 1, "", False),
    ],
  ),
  #(
    "m",
    [
      Rule("(47:mui3.)", "m", "ium", False, 3, "", False),
      Rule("(48:mu*2.)", "m", "um", True, 2, "", False),
      Rule("(49:msi3>)", "m", "ism", False, 3, "", True),
      Rule("(50:mm1.)", "m", "mm", False, 1, "", False),
    ],
  ),
  #(
    "n",
    [
      Rule("(51:nois4j>)", "n", "sion", False, 4, "j", True),
      Rule("(52:noix4ct.)", "n", "xion", False, 4, "ct", False),
      Rule("(53:noi3>)", "n", "ion", False, 3, "", True),
      Rule("(54:nai3>)", "n", "ian", False, 3, "", True),
      Rule("(55:na2>)", "n", "an", False, 2, "", True),
      Rule("(56:nee0.)", "n", "een", False, 0, "", False),
      Rule("(57:ne2>)", "n", "en", False, 2, "", True),
      Rule("(58:nn1.)", "n", "nn", False, 1, "", False),
    ],
  ),
  #(
    "p",
    [
      Rule("(59:pihs4>)", "p", "ship", False, 4, "", True),
      Rule("(60:pp1.)", "p", "pp", False, 1, "", False),
    ],
  ),
  #(
    "r",
    [
      Rule("(61:re2>)", "r", "er", False, 2, "", True),
      Rule("(62:rae0.)", "r", "ear", False, 0, "", False),
      Rule("(63:ra2.)", "r", "ar", False, 2, "", False),
      Rule("(64:ro2>)", "r", "or", False, 2, "", True),
      Rule("(65:ru2>)", "r", "ur", False, 2, "", True),
      Rule("(66:rr1.)", "r", "rr", False, 1, "", False),
      Rule("(67:rt1>)", "r", "tr", False, 1, "", True),
      Rule("(68:rei3y>)", "r", "ier", False, 3, "y", True),
    ],
  ),
  #(
    "s",
    [
      Rule("(69:sei3y>)", "s", "ies", False, 3, "y", True),
      Rule("(70:sis2.)", "s", "sis", False, 2, "", False),
      Rule("(71:si2>)", "s", "is", False, 2, "", True),
      Rule("(72:ssen4>)", "s", "ness", False, 4, "", True),
      Rule("(73:ss0.)", "s", "ss", False, 0, "", False),
      Rule("(74:suo3>)", "s", "ous", False, 3, "", True),
      Rule("(75:su*2.)", "s", "us", True, 2, "", False),
      Rule("(76:s*1>)", "s", "s", True, 1, "", True),
      Rule("(77:s0.)", "s", "s", False, 0, "", False),
    ],
  ),
  #(
    "t",
    [
      Rule("(78:tacilp4y.)", "t", "plicat", False, 4, "y", False),
      Rule("(79:ta2>)", "t", "at", False, 2, "", True),
      Rule("(80:tnem4>)", "t", "ment", False, 4, "", True),
      Rule("(81:tne3>)", "t", "ent", False, 3, "", True),
      Rule("(82:tna3>)", "t", "ant", False, 3, "", True),
      Rule("(83:tpir2b.)", "t", "ript", False, 2, "b", False),
      Rule("(84:tpro2b.)", "t", "orpt", False, 2, "b", False),
      Rule("(85:tcud1.)", "t", "duct", False, 1, "", False),
      Rule("(86:tpmus2.)", "t", "sumpt", False, 2, "", False),
      Rule("(87:tpec2iv.)", "t", "cept", False, 2, "iv", False),
      Rule("(88:tulo2v.)", "t", "olut", False, 2, "v", False),
      Rule("(89:tsis0.)", "t", "sist", False, 0, "", False),
      Rule("(90:tsi3>)", "t", "ist", False, 3, "", True),
      Rule("(91:tt1.)", "t", "tt", False, 1, "", False),
    ],
  ),
  #(
    "u",
    [
      Rule("(92:uqi3.)", "u", "iqu", False, 3, "", False),
      Rule("(93:ugo1.)", "u", "ogu", False, 1, "", False),
    ],
  ),
  #(
    "v",
    [
      Rule("(94:vis3j>)", "v", "siv", False, 3, "j", True),
      Rule("(95:vie0.)", "v", "eiv", False, 0, "", False),
      Rule("(96:vi2>)", "v", "iv", False, 2, "", True),
    ],
  ),
  #(
    "y",
    [
      Rule("(97:ylb1>)", "y", "bly", False, 1, "", True),
      Rule("(98:yli3y>)", "y", "ily", False, 3, "y", True),
      Rule("(99:ylp0.)", "y", "ply", False, 0, "", False),
      Rule("(100:yl2>)", "y", "ly", False, 2, "", True),
      Rule("(101:ygo1.)", "y", "ogy", False, 1, "", False),
      Rule("(102:yhp1.)", "y", "phy", False, 1, "", False),
      Rule("(103:ymo1.)", "y", "omy", False, 1, "", False),
      Rule("(104:ypo1.)", "y", "opy", False, 1, "", False),
      Rule("(105:yti3>)", "y", "ity", False, 3, "", True),
      Rule("(106:yte3>)", "y", "ety", False, 3, "", True),
      Rule("(107:ytl2.)", "y", "lty", False, 2, "", False),
      Rule("(108:yrtsi5.)", "y", "istry", False, 5, "", False),
      Rule("(109:yra3>)", "y", "ary", False, 3, "", True),
      Rule("(110:yro3>)", "y", "ory", False, 3, "", True),
      Rule("(111:yfi3.)", "y", "ify", False, 3, "", False),
      Rule("(112:ycn2t>)", "y", "ncy", False, 2, "t", True),
      Rule("(113:yca3>)", "y", "acy", False, 3, "", True),
    ],
  ),
  #(
    "z",
    [
      Rule("(114:zi2>)", "z", "iz", False, 2, "", True),
      Rule("(115:zy1s.)", "z", "yz", False, 1, "s", False),
    ],
  ),
]

/// Constructs the default ruleset
pub fn default_rules() -> Rules {
  dict.from_list(default_rules_list)
}

/// Lancaster (Paice-Husk) stemming algorithm
///
/// ## Example
///
/// ```gleam
/// lancaster_stemmer.stem("Gleam", lancaster_stemmer.stem.default_rules())
/// // -> gleam
/// ```
///
/// ```gleam
/// lancaster_stemmer.stem("fancy", lancaster_stemmer.stem.default_rules())
/// // -> fant
/// ```
pub fn stem(word: String, rules: Rules) -> String {
  let word = string.lowercase(word)
  case is_valid(word) {
    True -> {
      do_stem(word, rules, True)
    }
    False -> word
  }
}

fn do_stem(word: String, rules: Rules, intact: Bool) -> String {
  case string.reverse(word) {
    "a" as letter <> _
    | "b" as letter <> _
    | "c" as letter <> _
    | "d" as letter <> _
    | "e" as letter <> _
    | "f" as letter <> _
    | "g" as letter <> _
    | "h" as letter <> _
    | "i" as letter <> _
    | "j" as letter <> _
    | "k" as letter <> _
    | "l" as letter <> _
    | "m" as letter <> _
    | "n" as letter <> _
    | "o" as letter <> _
    | "p" as letter <> _
    | "q" as letter <> _
    | "r" as letter <> _
    | "s" as letter <> _
    | "t" as letter <> _
    | "u" as letter <> _
    | "v" as letter <> _
    | "w" as letter <> _
    | "x" as letter <> _
    | "y" as letter <> _
    | "z" as letter <> _ -> {
      case stem_letter(rules, letter, word, intact) {
        #(stem, True, intact) -> do_stem(stem, rules, intact)
        #(stem, _, _) -> stem
      }
    }

    _ -> word
  }
}

fn stem_letter(
  rules: dict.Dict(String, List(Rule)),
  letter: String,
  word: String,
  intact: Bool,
) -> #(String, Bool, Bool) {
  case dict.get(rules, letter) {
    Ok(specific_rules) -> {
      // let #(stem, restem, intact) =
      list.fold_until(specific_rules, #(word, False, intact), fn(state, rule) {
        case rule_matches(rule, word, intact) {
          True -> {
            let result = apply_rule(rule, word)
            case is_valid(result) {
              False -> list.Continue(state)
              True -> {
                list.Stop(#(result, rule.restem, False))
              }
            }
          }
          False -> list.Continue(state)
        }
      })
    }
    Error(_) -> #(word, False, False)
  }
}

fn rule_matches(rule: Rule, word: String, stem_intact: Bool) -> Bool {
  case stem_intact || !rule.intact {
    True -> string.ends_with(word, rule.suffix)
    False -> False
  }
}

fn apply_rule(rule: Rule, word: String) -> String {
  string.drop_end(word, rule.remove) <> rule.append
}

fn is_valid(word: String) -> Bool {
  case word {
    "" -> False
    "a" <> rest | "e" <> rest | "i" <> rest | "o" <> rest | "u" <> rest -> {
      rest != ""
    }
    _ -> {
      is_valid_internal(word, 0)
    }
  }
}

fn is_valid_internal(word: String, length: Int) -> Bool {
  case word {
    "" -> False
    "a" <> rest
    | "e" <> rest
    | "i" <> rest
    | "o" <> rest
    | "u" <> rest
    | "y" <> rest -> {
      { length + 1 + string.byte_size(rest) } >= 3
    }
    _ -> {
      is_valid_internal(string.drop_start(word, 1), length + 1)
    }
  }
}

/// Constructs a ruleset from the specified file
///
/// Format of the file is as follows:
/// Each line contains a specific rule (order matters)
/// The rule consists of a string made up of the following parts
/// | Rule part | Description |
/// | ------ | ------ |
/// |suffix|the reverse of the required suffix, e.g. the suffix for winning, ing would be specified gni|
/// |* (optional)|if the rule is only to be used if a previous rule has not been applied then add an asterisk. For example ht*2. only applies if th is the final suffix, so the stem of breath would be brea but the stem of breathe would be breath because the suffix e has already been removed|
/// |number of chars to remove|this is the number of characters to remove after the suffix has been matched. For example psychoanalytic has the suffix ytic of which 3 characters should be removed to retain psychoanaly, this would be 'city3'. This can be 0|
/// |append string (optional)|this is the characters that are appended after the match and removal of characters|
/// |> or .|If > then you can continue stemming process after this one, if . then stemming stops|
///
/// So for example with the `psychoanalytic` stem of `psychoanalys` the rule would be `ytic3s.`
///
pub fn load_rules(filename: String) -> Result(Rules, Nil) {
  case simplifile.read(filename) {
    Error(_) -> Error(Nil)
    Ok(rules) -> {
      let split = splitter.new(["\n", "\r\n"])
      use rules <- result.try(process_rules(rules, split, [], 1))
      list.fold(rules, dict.new(), fn(acc, rule) {
        dict.upsert(acc, rule.letter, fn(rules) {
          case rules {
            Some(rules) -> {
              [rule, ..rules]
            }
            None -> [rule]
          }
        })
      })
      |> Ok
    }
  }
}

fn process_rules(
  rules: String,
  split: splitter.Splitter,
  acc: List(Rule),
  id: Int,
) -> Result(List(Rule), Nil) {
  case splitter.split(split, rules) {
    #("end0." <> _, _, _) -> Ok(acc)
    #(rule, _, rest) -> {
      use rule <- result.try(process_rule(rule, id))
      process_rules(rest, split, [rule, ..acc], id + 1)
    }
  }
}

fn process_rule(rule: String, id: Int) -> Result(Rule, Nil) {
  let rule = string.trim(rule)

  use #(suffix, rule) <- result.try(parse_rule_text(rule, ""))

  use <- bool.guard(when: suffix == "", return: Error(Nil))
  let #(intact, rule) = case rule {
    "*" <> rule -> #(True, rule)
    _ -> #(False, rule)
  }
  use #(remove, rule) <- result.try(parse_rule_remove(rule, ""))
  use #(append, rule) <- result.try(parse_rule_text(rule, ""))
  use restem <- result.try(case rule {
    ">" <> _ -> Ok(True)
    "." <> _ -> Ok(False)
    _ -> Error(Nil)
  })

  let id =
    "("
    <> int.to_string(id)
    <> ":"
    <> suffix
    <> {
      case intact {
        True -> "*"
        False -> ""
      }
    }
    <> int.to_string(remove)
    <> append
    <> {
      case restem {
        True -> ">"
        False -> "."
      }
    }
    <> ")"
  use letter <- result.try(string.first(suffix))
  let suffix = string.reverse(suffix)
  Ok(Rule(id, letter, suffix, intact, remove, append, restem))
}

fn parse_rule_remove(rule: String, acc: String) -> Result(#(Int, String), Nil) {
  case rule {
    "0" as number <> rest
    | "1" as number <> rest
    | "2" as number <> rest
    | "3" as number <> rest
    | "4" as number <> rest
    | "5" as number <> rest
    | "6" as number <> rest
    | "7" as number <> rest
    | "8" as number <> rest
    | "9" as number <> rest -> parse_rule_remove(rest, acc <> number)
    _ if acc == "" -> Error(Nil)
    _ -> {
      use i <- result.try(int.parse(acc))
      Ok(#(i, rule))
    }
  }
}

fn parse_rule_text(rule: String, acc: String) -> Result(#(String, String), Nil) {
  case rule {
    "a" as letter <> rest
    | "b" as letter <> rest
    | "c" as letter <> rest
    | "d" as letter <> rest
    | "e" as letter <> rest
    | "f" as letter <> rest
    | "g" as letter <> rest
    | "h" as letter <> rest
    | "i" as letter <> rest
    | "j" as letter <> rest
    | "k" as letter <> rest
    | "l" as letter <> rest
    | "m" as letter <> rest
    | "n" as letter <> rest
    | "o" as letter <> rest
    | "p" as letter <> rest
    | "q" as letter <> rest
    | "r" as letter <> rest
    | "s" as letter <> rest
    | "t" as letter <> rest
    | "u" as letter <> rest
    | "v" as letter <> rest
    | "w" as letter <> rest
    | "x" as letter <> rest
    | "y" as letter <> rest
    | "z" as letter <> rest
    | "A" as letter <> rest
    | "B" as letter <> rest
    | "C" as letter <> rest
    | "D" as letter <> rest
    | "E" as letter <> rest
    | "F" as letter <> rest
    | "G" as letter <> rest
    | "H" as letter <> rest
    | "I" as letter <> rest
    | "J" as letter <> rest
    | "K" as letter <> rest
    | "L" as letter <> rest
    | "M" as letter <> rest
    | "N" as letter <> rest
    | "O" as letter <> rest
    | "P" as letter <> rest
    | "Q" as letter <> rest
    | "R" as letter <> rest
    | "S" as letter <> rest
    | "T" as letter <> rest
    | "U" as letter <> rest
    | "V" as letter <> rest
    | "W" as letter <> rest
    | "X" as letter <> rest
    | "Y" as letter <> rest
    | "Z" as letter <> rest -> parse_rule_text(rest, acc <> letter)
    _ -> Ok(#(acc, rule))
  }
}
