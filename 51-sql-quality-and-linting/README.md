# 51 — SQL Quality, Linting and Style

## Quality gates
- SQL formatting
- naming conventions
- reserved-word checks
- explicit column lists
- parameterized application SQL
- migration safety review
- transaction boundary review
- index review
- EXPLAIN review for critical queries
- NULL/three-valued-logic review
- timezone review
- security/privilege review

## Optional tooling
- SQLFluff
- pgFormatter
- migration tools such as Flyway, Liquibase, Sqitch or dbmate

Tooling is supplementary: the curriculum must remain understandable without requiring a particular formatter or migration product.