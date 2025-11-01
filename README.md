# lancaster_stemmer

Gleam implementation of the Lancaster (Paice/Husk) Stemmer

[![Package Version](https://img.shields.io/hexpm/v/lancaster_stemmer)](https://hex.pm/packages/lancaster_stemmer)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lancaster_stemmer/)

```sh
gleam add lancaster_stemmer@1
```
```gleam
import lancaster_stemmer

pub fn main() -> Nil {
  lancaster_stemmer.stem("breathe", lancaster_stemmer.default_rules())
}
```

Further documentation can be found at <https://hexdocs.pm/lancaster_stemmer>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
