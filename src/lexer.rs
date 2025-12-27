use std::fmt;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct Span {
    pub line: usize,
    pub col: usize,
}

#[derive(Debug, Clone, PartialEq)]
pub enum TokenKind {
    Number(u16),
    Ident(String),
    StringLit(String),

    Dot,
    LParen,
    RParen,

    Eof,
}

#[derive(Debug, Clone, PartialEq)]
pub struct Token {
    pub kind: TokenKind,
    pub span: Span,
}

#[derive(Debug, Clone)]
pub struct LexError {
    pub message: String,
    pub span: Span,
}

impl fmt::Display for LexError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} at {}:{}", self.message, self.span.line, self.span.col)
    }
}

pub struct Lexer<'a> {
    src: &'a str,
    idx: usize,
    line: usize,
    col: usize,
    bytes: &'a [u8],
}

impl<'a> Lexer<'a> {
    pub fn new(src: &'a str) -> Self {
        Self {
            src,
            idx: 0,
            line: 1,
            col: 1,
            bytes: src.as_bytes(),
        }
    }

    fn span(&self) -> Span {
        Span { line: self.line, col: self.col }
    }

    fn peek(&self) -> Option<u8> {
        self.bytes.get(self.idx).copied()
    }

    fn bump(&mut self) -> Option<u8> {
        let b = self.bytes.get(self.idx).copied()?;
        self.idx += 1;

        if b == b'\n' {
            self.line += 1;
            self.col = 1;
        } else {
            self.col += 1;
        }
        Some(b)
    }

    fn skip_ws(&mut self) {
        loop {
            while let Some(b) = self.peek() {
                match b {
                    b' ' | b'\t' | b'\r' | b'\n' => {
                        self.bump();
                    }
                    _ => break,
                }
            }

            let saved_idx = self.idx;
            let saved_col = self.col;

            if self.col == 1 {
                if self.peek() == Some(b'*') {
                    self.skip_line();
                    continue;
                }
                if self.peek() == Some(b'/')
                    && self.bytes.get(self.idx + 1) == Some(&b'/')
                {
                    self.skip_line();
                    continue;
                }
                if self.peek() == Some(b'#') {
                    self.skip_line();
                    continue;
                }
            }

            if self.idx == saved_idx && self.col == saved_col {
                break;
            }
        }
    }

    fn skip_line(&mut self) {
        while let Some(b) = self.peek() {
            self.bump();
            if b == b'\n' {
                break;
            }
        }
    }

    fn is_ident_start(b: u8) -> bool {
        (b'a'..=b'z').contains(&b) || (b'A'..=b'Z').contains(&b) || b == b'_'
    }

    fn is_ident_cont(b: u8) -> bool {
        Self::is_ident_start(b) || (b'0'..=b'9').contains(&b) || b == b'-'
    }

    fn lex_number(&mut self) -> Result<Token, LexError> {
        let span = self.span();
        let start = self.idx;
        while let Some(b) = self.peek() {
            if (b'0'..=b'9').contains(&b) {
                self.bump();
            } else {
                break;
            }
        }
        let s = &self.src[start..self.idx];
        let n: u16 = s.parse().map_err(|_| LexError {
            message: format!("invalid number: {}", s),
            span,
        })?;
        Ok(Token { kind: TokenKind::Number(n), span })
    }

    fn lex_ident(&mut self) -> Token {
        let span = self.span();
        let start = self.idx;
        self.bump(); // first char
        while let Some(b) = self.peek() {
            if Self::is_ident_cont(b) {
                self.bump();
            } else {
                break;
            }
        }
        let s = self.src[start..self.idx].to_string();
        Token { kind: TokenKind::Ident(s), span }
    }

    fn lex_string(&mut self) -> Result<Token, LexError> {
        let span = self.span();
        // consume opening "
        self.bump();

        let mut out = String::new();
        while let Some(b) = self.peek() {
            match b {
                b'"' => {
                    self.bump(); // closing
                    return Ok(Token { kind: TokenKind::StringLit(out), span });
                }
                b'\\' => {
                    self.bump();
                    let esc = self.peek().ok_or_else(|| LexError {
                        message: "unterminated string escape".to_string(),
                        span: self.span(),
                    })?;
                    match esc {
                        b'"' => { self.bump(); out.push('"'); }
                        b'\\' => { self.bump(); out.push('\\'); }
                        b'n' => { self.bump(); out.push('\n'); }
                        b't' => { self.bump(); out.push('\t'); }
                        _ => {
                            return Err(LexError {
                                message: format!("unknown escape: \\{}", esc as char),
                                span: self.span(),
                            })
                        }
                    }
                }
                _ => {
                    self.bump();
                    out.push(b as char);
                }
            }
        }

        Err(LexError {
            message: "unterminated string".to_string(),
            span,
        })
    }

    pub fn lex_all(mut self) -> Result<Vec<Token>, LexError> {
        let mut tokens = Vec::new();

        loop {
            self.skip_ws();
            let span = self.span();

            let Some(b) = self.peek() else {
                tokens.push(Token { kind: TokenKind::Eof, span });
                return Ok(tokens);
            };

            let tok = match b {
                b'.' => { self.bump(); Token { kind: TokenKind::Dot, span } }
                b'(' => { self.bump(); Token { kind: TokenKind::LParen, span } }
                b')' => { self.bump(); Token { kind: TokenKind::RParen, span } }
                b'"' => self.lex_string()?,
                b'0'..=b'9' => self.lex_number()?,
                _ if Self::is_ident_start(b) => self.lex_ident(),
                _ => {
                    return Err(LexError {
                        message: format!("unexpected character: {:?}", b as char),
                        span,
                    });
                }
            };

            tokens.push(tok);
        }
    }
}
