# SNOMED CT Expression Constraint Language

This repository contains the formal syntax and valid examples for each version of the SNOMED CT Expression Constraint Language, commonly known as ECL. 

The Expression Constraint Language is used to represent SNOMED CT expression constraints and simple queries, it is a computable language that is part of the 
SNOMED CT Family of Languages.

The folders are organized as follows:
* _**syntax**_
  * Contains the brief (normative) and long (informative) ABNF syntaxes. Also the brief ANTLR v4 syntax.
* _**examples**_
  * Contains an extensive set of files with valid ECL examples.

## Other Useful Resources

### ECL Specification and Guide
The Specification and Guide is available at [snomed.org/ecl](http://snomed.org/ecl).

### ECL Parsers
- JavaScript (ECMAScript):
  - Parsers can be generated using the [APG JS project](https://github.com/ldthomas/apg-js), enables validating the syntax of ECL in a web page.
- Java parsers:
  - [IHTSDO / snomed-ecl-parser](https://github.com/IHTSDO/snomed-ecl-parser) - ANTLR and plain java abstract ECL implementation, base layer of a full implementation.
  - [b2ihealthcare / snomed-ecl](https://github.com/b2ihealthcare/snomed-ecl) - Eclipse xtext based abstract ECL implementation, base layer of a full implementation. Enables an 
    Eclipse based UI.
