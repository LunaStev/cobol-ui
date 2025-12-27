mod ast;
mod html;
mod lexer;
mod parser;

use std::{env, fs};

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("usage: cobol-ui <input.cbl> [output.html]");
        std::process::exit(1);
    }

    let input_path = &args[1];
    let output_path = args.get(2);

    let src = match fs::read_to_string(input_path) {
        Ok(s) => s,
        Err(e) => {
            eprintln!("read error: {e}");
            std::process::exit(1);
        }
    };

    let tokens = match lexer::Lexer::new(&src).lex_all() {
        Ok(t) => t,
        Err(e) => {
            eprintln!("lex error: {e}");
            std::process::exit(1);
        }
    };

    let mut p = parser::Parser::new(&tokens);
    let mut doc = match p.parse_document() {
        Ok(d) => d,
        Err(e) => {
            eprintln!("parse error: {e}");
            std::process::exit(1);
        }
    };

    html::enrich(&mut doc);

    let html = html::render(&doc);

    if let Some(out_path) = output_path {
        if let Err(e) = fs::write(out_path, html) {
            eprintln!("write error: {e}");
            std::process::exit(1);
        }
    } else {
        print!("{html}");
    }
}
