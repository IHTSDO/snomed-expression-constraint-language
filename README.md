# SNOMED CT Expression Constraint Language

This repository contains the formal syntax and valid examples for each version of the SNOMED CT Expression Constraint Language, commonly known as ECL. 

The Expression Constraint Language is used to represent SNOMED CT expression constraints and simple queries, it is a computable language that is part of the 
SNOMED CT Family of Languages.

The folders are organized as follows:
* _**syntax**_
  * `ECL.g4` the ANTLR grammar file (**recommended**)
  * `abnf-brief.txt` the normative ABNF grammar file
  * `abnf-long.txt` the long ABNF grammar file
* _**examples**_
  * Contains an extensive set of files with valid ECL examples.

Please note that the ABNF has some ambiguity because the `memberFieldFilter` uses a wildcard field name that can overlap with other filters when there is no order of preference.
The ANTLR grammar is a better alternative and is recommended.

## Other Useful Resources

### ECL Specification and Guide
The Specification and Guide is available at [snomed.org/ecl](http://snomed.org/ecl).

### ECL Parsers
- JavaScript (ECMAScript):
  - Parsers can be generated using the [APG JS project](https://github.com/ldthomas/apg-js), enables validating the syntax of ECL in a web page.
- Java parsers:
  - [IHTSDO / snomed-ecl-parser](https://github.com/IHTSDO/snomed-ecl-parser) - ANTLR and plain java abstract ECL implementation, base layer of a full implementation.
  - [b2ihealthcare / snomed-ecl](https://github.com/b2ihealthcare/snomed-ecl) - Eclipse Xtext based abstract ECL implementation, base layer of a full implementation. Enables an Eclipse based UI an Eclipse LSP4J language server.
